function [ extrudedBreast ] = extrudeBreast( bodyPhantom, breastPhantom, xOffset, yOffset, zOffset )
%EXTRUDEBREAST Extends base xz plane of "breastPhantom" into "bodyPhantom" until encoutering specified tissue type
%
%	Copyright 2015 Joseph V Rispoli
%		2015/04/14
%
%	Input variables
%		bodyPhantom:	three-dimensional (x/y/z) int8 array of whole-body voxel model
%		breastPhantom:	three-dimensional (x/y/z) int8 array of breast phantom
%		xOffset:		x pixel offset to place breastPhantom on bodyPhantom
%		yOffset:		y pixel offset to place breastPhantom on bodyPhantom
%		zOffset:		z pixel offset to place breastPhantom on bodyPhantom
%
%	Output variables
%		extrudedBreast:	three-dimensional (x/y/z) int8 array of extruded breast phantom
%
%	IT'IS Foundation Virtual Population tissue numbering
%		skin = 27
%		SAT = 30
%		breast = 43
%		muscle = 22
%		fat = 14
%		
%	Wisconsin breast phantom tissue numbering
%		skin = -2
%		fibroconnective = 1
%		transitional = 2
%		fatty = 3

for ii = 1:size(breastPhantom,1)
    for kk = 1:size(breastPhantom,3)

        % check tissue for each voxel on base xz plane
        % if skin tissue, extrude into body phantom until encounter fat, breast, muscle or skin
        if breastPhantom(ii,1,kk) == -2 % UW skin = -2
            jj = 1;
            while all(bodyPhantom(xOffset+ii,yOffset-jj,zOffset+kk) ~= [30 43 22 14 27]) % IT'IS tissue types in header
                breastExtrusionReversed(ii,jj,kk) = breastPhantom(ii,1,kk);
                jj = jj+1;
            end
            
        % if non-skin tissue, extrude into body phantom until encounter fat, breast, or muscle           
        elseif breastPhantom(ii,1,kk) ~= 0
            jj = 1;
            while all(bodyPhantom(xOffset+ii,yOffset-jj,zOffset+kk) ~= [30 43 22 14]) % IT'IS tissue types in header
                breastExtrusionReversed(ii,jj,kk) = breastPhantom(ii,1,kk);
                jj = jj+1;
            end
            
        % if free space, no extrusion
        else
            breastExtrusionReversed(ii,1,kk) = 0;
        end
        
        % remove breast phantom skin inside body phantom
        jj = 1;      
        while all(bodyPhantom(xOffset+ii,yOffset+jj-1,zOffset+kk) ~= [0 27]) % IT'IS skin = 27
            if breastPhantom(ii,jj,kk) == -2 % UW skin = -2
                breastPhantom(ii,jj,kk) = 0;
            end
            jj = jj+1;    
        end
        
    end
end
breastExtrusion = int8(fliplr(breastExtrusionReversed));
extrudedBreast = zeros(size(breastPhantom,1),size(breastPhantom,2)+size(breastExtrusion,2),size(breastPhantom,3),'int8');
extrudedBreast(:,1:size(breastExtrusion,2),:) = breastExtrusion;
extrudedBreast(:,size(breastExtrusion,2)+1:size(extrudedBreast,2),:) = breastPhantom;

end

