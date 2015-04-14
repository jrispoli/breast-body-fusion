function [ scaledPhantom ] = resizePhantom( inputPhantom, dimensions )
%RESIZEPHANTOM Resize "inputPhantom" to "dimensions" using nearest-neighbor interpolation
%
%	Copyright 2015 Joseph V Rispoli
%		2015/04/14
%
%	Input variables
%   	inputPhantom:	three-dimensional (x/y/z) int8 array of phantom
%		dimensions:		three-element (x/y/z) vector indicating desired number of points
%
%	Output variables
%		scaledPhantom:	three-dimensional (x/y/z) int8 array of scaled phantom

% first, resize in xz
xzScaledPhantom = zeros(dimensions(1),size(inputPhantom,2),dimensions(3),'int8');
for jj = 1:size(inputPhantom,2)
	xzScaledPhantom(:,jj,:) = imresize(squeeze(inputPhantom(:,jj,:)),[dimensions(1) dimensions(3)],'nearest');
end

% second, resize in yz
scaledPhantom = zeros(dimensions,'int8');
for ii = 1:dimensions(1)
	scaledPhantom(ii,:,:) = imresize(squeeze(xzScaledPhantom(ii,:,:)),dimensions(2:3),'nearest');
end
