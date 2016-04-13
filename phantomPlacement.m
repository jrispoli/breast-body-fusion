function [ xPhantomOffset, yPhantomOffset, zPhantomOffset ] = phantomPlacement( inputPhantom, position, xVoxelL, xVoxelR, yVoxel, zVoxel )
%PHANTOMPLACEMENT Returns dimensions to place "inputPhantom" on whole-body voxel model
%
%	Copyright 2016 Joseph V Rispoli
%		2016/04/13
%
%	Input variables
%   	inputPhantom:	three-dimensional (x/y/z) array
%   	position:		'l' or 'r' indicating left/right side of body
%		xVoxelL:		x voxel where left phantom to be centered
%		xVoxelR:		x voxel where right phantom to be centered
%		yVoxel:			y voxel where phantom to be centered
%		zVoxel:			z voxel where phantom to be centered
%
%	Output variables
%		xPhantomOffset:	x pixel offset to place inputPhantom on whole-body voxel model
%		yPhantomOffset:	y pixel offset to place inputPhantom on whole-body voxel model
%		zPhantomOffset:	z pixel offset to place inputPhantom on whole-body voxel model
%
%	Example values for 0.5-mm Ella whole-body model:
%		xVoxelL = 690
%		xVoxelR = 366
%		yVoxel = 396
%		zVoxel = 905

% determine center of phantom on base xz plane
xBreastCenter = floor((find(squeeze(sum(squeeze(any(inputPhantom(:,1,:),3)),2)),1,'last')-find(squeeze(sum(squeeze(any(inputPhantom(:,1,:),3)),2)),1,'first'))/2);
zBreastCenter = floor((find(squeeze(sum(squeeze(any(inputPhantom(:,1,:),1)),2)),1,'last')-find(squeeze(sum(squeeze(any(inputPhantom(:,1,:),1)),2)),1,'first'))/2);

% alternatively, use center of entire phantom on xz plane and uncomment following two lines
% xBreastCenter = floor(size(inputPhantom,3)/2);
% zBreastCenter = floor(size(inputPhantom,1)/2);

if position == 'r'
    xVoxel = xVoxelR;
else % if position == 'l'
    xVoxel = xVoxelL;
end

xPhantomOffset = xVoxel - xBreastCenter;
yPhantomOffset = yVoxel;
zPhantomOffset = zVoxel - zBreastCenter;

end
