function xml_extraction(filename, search_ini,search_fin)

% get(handles.eb_search_ini,'string')
total_file_path=filename;
fid = fopen(total_file_path);

k = 0;
while ~feof(fid)
    curr = fgets(fid);
     k = k+1; %total lines 
   %location1= findstr(curr,'<suggested_pickup>')
   location1= findstr(curr,search_ini);
    if location1>=1; initial=k;end
   % location2= findstr(curr,'<visibility_mi>')
     location2= findstr(curr,search_fin);
   if location2>=1; final=k;end
end
    
    fclose(fid);
    
    fid = fopen(total_file_path);
    fid_wt=fopen('write1.txt','wt');
    k=0;
 for i=1:initial-1
     junk = fgets(fid);
 end
 for i=initial:final
            curr = fgets(fid);
        fprintf(fid_wt,'%s',curr);
 end

    fclose(fid_wt);
fclose(fid);


