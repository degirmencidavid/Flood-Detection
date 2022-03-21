%script to take all tifs from /preprocess, converts all nans to zeros,
%then puts them in /processed
clc
clear

%path is ../nantifs
files = dir(fullfile("nantifs/preprocess",'*.tif'));
for i = 1:length(files)
    %get filename
    filename = files(i).name;
    f_filename = fullfile("nantifs/preprocess", filename);
    fprintf(1, "Now reading: %s\n", f_filename);
    
    %get current file, convert nans to 0
    current_file = imread(f_filename);
    current_file(isnan(current_file))=0;
    
    %%minmax check to see if it's reasonable to cast to half (16 bit float)
    %max(current_file, [], 'all')
    %min(current_file, [], 'all')
    
    %cast to 16 bit integer, to keep some precision, multiply by 100
    % to get the first 2 decimal places
    %incase you don't want halfs
    %castedfile = cast(round(current_file*100),"int16");
    castedfile = current_file;
    
    %plot them to check
    plotthem = 0;
    x=-25;
    if (plotthem == 1)
        figure(i)
        imshow(current_file./x)
    end
    
    %file extension name
    ext = ".tif";
    ext = ".txt";
    
    %save tif in /processed folder
    dirplusname = "./nantifs/processed/" + strip(filename, "right", ".") + ext;
    %imwrite(castedfile, dirplusname);
    writematrix(castedfile, dirplusname);
    
    %confirmation
    fprintf(1, "Write completed: %s\n", dirplusname);
    
end

disp("completed");
