using Godot;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Transforms.Onnx;
using NumSharp;
using System;
using System.Collections.Generic;
using System.Linq;

public class Input
{
	[VectorType(28*28*1)] // Our model takes a three-dimensional tensor as input but ML.NET takes a flatten vector as input
	[ColumnName("conv2d_1_input")] // This name must match the input node's name
	public float[] Data { get; set; }
}

public class Output
{
    [VectorType(26)] // Because output node has (10) shape
    [ColumnName("dense_3")] // This name must match the output node's name
    public float[] Data { get; set; }
}

public partial class ObjectDetector : Node
{

	[Signal]
	public delegate void ObjectDetectedEventHandler(char detectedValue);
	
	[Export]
	public double drawingWidth = 1.5;

	private MLContext mlContext;
	private OnnxScoringEstimator pipeline;

	private double pointDist(double x1, double y1, double x2, double y2) {
		return Math.Sqrt(Math.Pow(x2 - x1, 2) + Math.Pow(y2 - y1, 2));
	}
	private byte[] generateByteArrayFromLine(Vector2[] line) {
		// set min to 0
		double minX = line.MinBy(point => point.X).X;
		double minY = line.MinBy(point => point.Y).Y;
		for (var i = 0; i < line.Length; i++) {
			line[i].X -= (float) minX;
			line[i].Y -= (float) minY;
		}

		// Divide to fit 28*28, keeping aspect ratio
		var max = Math.Max(line.MaxBy(point => point.X).X, line.MaxBy(point => point.Y).Y);
		for (var i = 0; i < line.Length; i++) {
			line[i] = (line[i] * 24 / max) + new Vector2(2, 2);
		}

		// Create 28 * 28 canvas
		var canvas = new byte[28,28];

		// For each pair of points, fill in every pixel that is passed through
		// This could be done more efficiently, see Bresenham's line algorithm
		for (var i = 0; i < line.Length - 1; i++) {
			double x1 = line[i].X;
			double y1 = line[i].Y;
			double x2 = line[i+1].X;
			double y2 = line[i+1].Y;

			minX = Math.Min(x1, x2);
			minY = Math.Min(y1, y2);

			for (var y = 0; y < 28; y++) {
				for (var x = 0; x < 28; x++) {
					var x0 = x + 0.5;
					var y0 = y + 0.5;
					// https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line#Line_defined_by_two_points
					var x1Tox2 = pointDist(x1, y1, x2, y2);
					var x0Tox1 = pointDist(x0, y0, x1, y1);
					var x0Tox2 = pointDist(x0, y0, x2, y2);
					var dist = Math.Abs((x2 - x1) * (y1 - y0) - (x1 - x0) * (y2 - y1)) / Math.Sqrt(Math.Pow(x2 - x1, 2) + Math.Pow(y2 - y1, 2));
					if (dist <= drawingWidth && x0Tox1 <= x1Tox2 + drawingWidth && x0Tox2 <= x1Tox2 + drawingWidth) {
						try {
							canvas[(int)Math.Floor(y0), (int)Math.Floor(x0)] = 255;
						}
						catch {}
					}
				}
			}
		}

    var byteArray = new byte[28 * 28];
		for (var y = 0; y < 28; y++) {
			for (var x = 0; x < 28; x++) {
				byteArray[28 * y + x]= canvas[y, x];
			}
		}

		return byteArray;
	}

	private int predictCharacter(byte[] byteArray) {
		var data = np.array(byteArray)
			.astype(NPTypeCode.Single)
			.flatten()
			.ToArray<float>();
		var input = new Input { Data = data };
		IEnumerable<Input> enumerable = new Input[]{
			input
		};
		var dataView = mlContext.Data.LoadFromEnumerable(enumerable);
		var transformedValues = pipeline.Fit(dataView).Transform(dataView);
		var output = mlContext.Data.CreateEnumerable<Output>(transformedValues, reuseRowObject: false);
		var testOutput = output.First();
		var max = testOutput.Data.Max();
		var index = Array.IndexOf(testOutput.Data, max);

		return index;
	}

	public void _on_trail_control_left_line_drawn (Vector2[] line) {

		var byteArray = generateByteArrayFromLine(line);
		var image = Image.CreateFromData(28, 28, false, Image.Format.R8, byteArray);
		ImageTexture.CreateFromImage(image);

		var node = GetNode<Node2D>("DebugDisplay");
		var newSprite = new Sprite2D();
		node.AddChild(newSprite);
		newSprite.Texture = ImageTexture.CreateFromImage(image);

		int prediction = predictCharacter(byteArray);

		var text = GetNode<RichTextLabel>("DebugText");
		text.Text = "Detected Letter: " + ((char) (65 + prediction));
		EmitSignal("ObjectDetected", prediction);
	}

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		var modelPath = ProjectSettings.GlobalizePath("res://handwritten_letters.onnx");
		var outputColumnNames = new[] { "dense_3" };
		var inputColumnNames = new[] { "conv2d_1_input" };
		mlContext = new MLContext();
		pipeline = mlContext.Transforms.ApplyOnnxModel(outputColumnNames, inputColumnNames, modelPath);
	}
}
