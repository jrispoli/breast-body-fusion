# breast-body-fusion
MATLAB functions to resize, place, and fuse breast phantoms to a whole-body voxel model

Supporting Information

Function Name: resizePhantom
Description: Resizes a phantom to desired dimensions using a nearest-neighbor interpolation
Input variables:
•	inputPhantom: a three-dimensional (x,y,z) int8 array (e.g., a breast phantom)
•	dimensions: a three-element (x,y,z) vector indicating desired number of points
Output variable:
•	scaledPhantom: a three-dimensional (x,y,z) int8 array (e.g., a scaled breast phantom)

Function Name: phantomPlacement
Description: Returns the dimensions situate the phantom on a whole-body voxel model
Input variables:
•	inputPhantom: a three-dimensional (x,y,z) int8 array (e.g., a breast phantom)
•	position: single character 'l' or 'r' indicating left or right side of body
•	dimensions: a three-element (x,y,z) vector indicating desired number of points
•	xVoxelL, xVoxelR, yVoxel, zVoxel: voxel numbers where phantom is to be centered
Output variable:
•	placementOffset: a three-element (x,y,z) vector indicating the pixel offset to place the phantom with respect to the whole-body voxel model

Function Name: extrudePhantom
Description: Extends the base xz plane of the phantom into the whole-body voxel model until encountering one of the specified tissue types
Input variables:
•	inputPhantom: a three-dimensional (x,y,z) int8 array (e.g., a breast phantom)
•	bodyModel: a three-dimensional (x,y,z) int8 array (e.g., a whole-body voxel model)
•	placementOffset: a three-element (x,y,z) int vector indicating the pixel offset to place the phantom with respect to the whole-body voxel model
Output variable:
•	extrudedPhantom: a three-dimensional (x,y,z) int8 array (e.g., a fused breast phantom)

Software Execution

It is recommended that the software functions are executed in the following sequence: 
1)	resizePhantom
2)	phantomPlacement
3)	extrudePhantom

