function [ xBreastPlacement, yBreastPlacement, zBreastPlacement ] = breastPlacement( breastPhantom, position, xVoxelL, xVoxelR, yVoxel, zVoxel )
%BREASTPLACEMENT Returns dimensions to place "breastPhantom" on whole-body voxel model
%
%	Copyright 2015 Joseph V Rispoli
%		2015/04/14
%
%	Input variables
%   	breastPhantom:	three-dimensional (x/y/z) array
%   	position:		'l' or 'r' indicating left/right breast
%		xVoxelL:		x voxel where left breast phantom base to be centered
%		xVoxelR:		x voxel where right breast phantom base to be centered
%		yVoxel:			y voxel where breast phantom base to be centered
%		zVoxel:			z voxel where breast phantom base to be centered
%
%	Output variables
%		xBreastPlacement:	x pixel offset to place breastPhantom on whole-body voxel model
%		yBreastPlacement:	y pixel offset to place breastPhantom on whole-body voxel model
%		zBreastPlacement:	z pixel offset to place breastPhantom on whole-body voxel model
%
%	Example values for 0.5-mm Ella whole-body model:
%		xVoxelL = 690
%		xVoxelR = 366
%		yVoxel = 396
%		zVoxel = 905

% determine center of phantom on base xz plane
xBreastCenter = floor((find(squeeze(sum(squeeze(any(breastPhantom(:,1,:),3)),2)),1,'last')-find(squeeze(sum(squeeze(any(breastPhantom(:,1,:),3)),2)),1,'first'))/2);
zBreastCenter = floor((find(squeeze(sum(squeeze(any(breastPhantom(:,1,:),1)),2)),1,'last')-find(squeeze(sum(squeeze(any(breastPhantom(:,1,:),1)),2)),1,'first'))/2);

% alternatively, use center of entire phantom on xz plane
% xBreastCenter = floor(size(breastPhantom,3)/2);
% zBreastCenter = floor(size(breastPhantom,1)/2);

if position == 'r'
    xVoxel = xVoxelR;
else % if position == 'l'
    xVoxel = xVoxelL;
end

xBreastPlacement = xVoxel - xBreastCenter;
yBreastPlacement = yVoxel;
zBreastPlacement = zVoxel - zBreastCenter;

end
