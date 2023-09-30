using Godot;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Transforms.Text;
using NumSharp;
using System;
using System.Collections;
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
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("Hello!");
		var modelPath = ProjectSettings.GlobalizePath("res://handwritten_letters.onnx");
		var outputColumnNames = new[] { "dense_3" };
		var inputColumnNames = new[] { "conv2d_1_input" };
		var mlContext = new MLContext();
		var pipeline = mlContext.Transforms.ApplyOnnxModel(outputColumnNames, inputColumnNames, modelPath);

		var test_image = new float[28*28];
		for (var i = 0; i < 28*28; i++) {
			test_image[i] = 128f;
		}

		var data = np.array(test_image)
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
		// Add ASCII for capital A
		GD.Print((char) (index + 65));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
