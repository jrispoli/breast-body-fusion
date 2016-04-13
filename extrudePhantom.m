function [ extrudedPhantom ] = extrudePhantom( bodyModel, inputPhantom, xOffset, yOffset, zOffset )
%EXTRUDEPHANTOM Extends base xz plane of "inputPhantom" into "bodyModel" until encoutering one of the specified tissue types
%
%	Copyright 2016 Joseph V Rispoli
%		2016/04/13
%
%	Input variables
%		bodyModel:	three-dimensional (x/y/z) int8 array of whole-body voxel model
%		inputPhantom:	three-dimensional (x/y/z) int8 array of phantom
%		xOffset:		x pixel offset to place inputPhantom on bodyModel
%		yOffset:		y pixel offset to place inputPhantom on bodyModel
%		zOffset:		z pixel offset to place inputPhantom on bodyModel
%
%	Output variables
%		extrudedPhantom:	three-dimensional (x/y/z) int8 array of extruded phantom
%
%	Informational: IT'IS Foundation Virtual Population tissue numbering
%		skin = 27
%		SAT = 30
%		breast = 43
%		muscle = 22
%		fat = 14
%		
%	Informational: Wisconsin breast phantom tissue numbering
%		skin = -2
%		fibroconnective = 1
%		transitional = 2
%		fatty = 3

for ii = 1:size(inputPhantom,1)
    for kk = 1:size(inputPhantom,3)

        % check tissue for each voxel on base xz plane
        % if skin tissue, extrude into body phantom until encounter (e.g.) fat, breast, muscle or skin
        if inputPhantom(ii,1,kk) == -2 % UW skin = -2
            jj = 1;
            while all(bodyModel(xOffset+ii,yOffset-jj,zOffset+kk) ~= [30 43 22 14 27]) % IT'IS tissue types in header
                phantomExtrusionReversed(ii,jj,kk) = inputPhantom(ii,1,kk);
                jj = jj+1;
            end
            
        % if non-skin tissue, extrude into body phantom until encounter (e.g.) fat, breast, or muscle           
        elseif inputPhantom(ii,1,kk) ~= 0
            jj = 1;
            while all(bodyModel(xOffset+ii,yOffset-jj,zOffset+kk) ~= [30 43 22 14]) % IT'IS tissue types in header
                phantomExtrusionReversed(ii,jj,kk) = inputPhantom(ii,1,kk);
                jj = jj+1;
            end
            
        % if free space, no extrusion
        else
            phantomExtrusionReversed(ii,1,kk) = 0;
        end
        
        % remove inputPhantom skin located inside bodyModel
        jj = 1;      
        while all(bodyModel(xOffset+ii,yOffset+jj-1,zOffset+kk) ~= [0 27]) % IT'IS skin = 27
            if inputPhantom(ii,jj,kk) == -2 % UW skin = -2
                inputPhantom(ii,jj,kk) = 0;
            end
            jj = jj+1;    
        end
        
    end
end
phantomExtrusion = int8(fliplr(phantomExtrusionReversed));
extrudedPhantom = zeros(size(inputPhantom,1),size(inputPhantom,2)+size(phantomExtrusion,2),size(inputPhantom,3),'int8');
extrudedPhantom(:,1:size(phantomExtrusion,2),:) = phantomExtrusion;
extrudedPhantom(:,size(phantomExtrusion,2)+1:size(extrudedPhantom,2),:) = inputPhantom;

end

