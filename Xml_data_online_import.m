function station_id=Xml_data_online_import(weblink,working_dir,foldername)
%weblink='http://w1.weather.gov/xml/current_obs/seek.php?state=ut&Find=Find'
%with different state abbrebrations

data=urlread(weblink); %Getting link

dlmwrite('test.txt',data,'delimiter',''); %writing in a file temporarily

fid = fopen('test.txt');
k = 0;j=0;
while ~feof(fid)
    curr = fgets(fid);
     k = k+1; %total lines 
   xml_location_check= findstr(curr,'.xml');
    if xml_location_check>=4; 
        j=j+1;
       location(1,j)=xml_location_check;
       location(2,j)=k;
       station_id{j}=curr(xml_location_check-4:xml_location_check+3); %Geting Station IDs
       station_web_link{j}=['http://w1.weather.gov/xml/current_obs/' station_id{j}]; %if we have more weblinks, it has to be changed
    end
end
mkdir([working_dir,'\',foldername]); %foldername is state abbribiation to be made
  for i=1:length(station_web_link)
    data=urlread(station_web_link{i});
    dlmwrite([working_dir,'\',foldername,'\',station_id{i}],data,'delimiter','');
    %saving xml files
  end
