clc;clear;close all
data=urlread('http://w1.weather.gov/xml/current_obs/seek.php?state=ut&Find=Find')
dlmwrite('test.txt',data,'delimiter','')


fid = fopen('test.txt');

k = 0;j=0;
while ~feof(fid)
    curr = fgets(fid)
     k = k+1; %total lines 
   xml_location_check= findstr(curr,'.xml')
    if xml_location_check>=4; 
        j=j+1;
       location(1,j)=xml_location_check;
       location(2,j)=k;
       station_id{j}=curr(xml_location_check-4:xml_location_check+3);
       station_web_link{j}=['http://w1.weather.gov/xml/current_obs/' station_id{j}]
    end
end
  for i=1:length(station_web_link)
data=urlread(station_web_link{i});
dlmwrite([station_id{i},'.txt'],data,'delimiter','')
  end
%xml_extraction_n_make_write1_txt_file('test.txt')