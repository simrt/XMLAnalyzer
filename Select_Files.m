function [Folder_path, pathname] = Select_Files(start_path, dialog_title)
% Pick multiple directories and/or files

import javax.swing.JFileChooser;

if nargin == 0 || start_path == '' || start_path == 0 % Allow a null argument.
   
if exist('saved_folder_path.mat')==2
    load saved_folder_path;
    start_path=saved_folder_path;
else
    start_path=pwd;
end

   
end

jchooser = javaObjectEDT('javax.swing.JFileChooser', start_path);

jchooser.setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);
if nargin > 1
    jchooser.setDialogTitle(dialog_title);
    
end

jchooser.setMultiSelectionEnabled(true);

status = jchooser.showOpenDialog([]);

if status == JFileChooser.APPROVE_OPTION
    jFile = jchooser.getSelectedFiles();
	pathname{size(jFile, 1)}=[];
    for i=1:size(jFile, 1)
		pathname{i} = char(jFile(i).getAbsolutePath);
	end
	
elseif status == JFileChooser.CANCEL_OPTION
    pathname = [];
else
    error('Error occured while picking file.');
end

    TotalPath_file1=pathname{1};
   slash_locs= findstr(TotalPath_file1,'\');
   Folder_path=TotalPath_file1(1:slash_locs(end));