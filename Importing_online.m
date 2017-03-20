clc;clear;close all
data=urlread('http://w1.weather.gov/xml/current_obs/PAWS.xml');
dlmwrite('test.txt',data,'delimiter','')

xml_extraction_n_make_write1_txt_file('test.txt')