function varargout = Xml_analyzer_V5(varargin)
% XML_ANALYZER_V5 MATLAB code for Xml_analyzer_V5.fig
%      XML_ANALYZER_V5, by itself, creates a new XML_ANALYZER_V5 or raises the existing
%      singleton*.
%
%      H = XML_ANALYZER_V5 returns the handle to a new XML_ANALYZER_V5 or the handle to
%      the existing singleton*.
%
%      XML_ANALYZER_V5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XML_ANALYZER_V5.M with the given input arguments.
%
%      XML_ANALYZER_V5('Property','Value',...) creates a new XML_ANALYZER_V5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xml_analyzer_V5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xml_analyzer_V5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xml_analyzer_V5

% Last Modified by GUIDE v2.5 10-Apr-2016 09:54:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Xml_analyzer_V5_OpeningFcn, ...
                   'gui_OutputFcn',  @Xml_analyzer_V5_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Xml_analyzer_V5 is made visible.
function Xml_analyzer_V5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xml_analyzer_V5 (see VARARGIN)

% Choose default command line output for Xml_analyzer_V5
handles.output = hObject;
if exist('working_dir.mat')==2
    load working_dir
    set(handles.eb_working_dir,'String',working_dir)
else
set(handles.eb_working_dir,'String',pwd)
end
handles.working_dir=get(handles.eb_working_dir,'String')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Xml_analyzer_V5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Xml_analyzer_V5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_load_files_web.
function pb_load_files_web_Callback(hObject, eventdata, handles)
% hObject    handle to pb_load_files_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.lb_files_web,'value', 1); 
set(handles.lb_files_web,'String',[]); %clearing list
set(handles.txt_total_file_downloaded,'string','Total files downloaded: ');
set(handles.eb_files_saved_in,'string','')
set(handles.txt_status,'BackgroundColor','red');set(handles.txt_status,'String','Downloading')
pause(1)% to change background color of downloading


    handles.working_dir=get(handles.eb_working_dir,'String');
    allstate=get(handles.pop_states,'String');
    state_index=get(handles.pop_states,'Value');
    state=allstate{state_index};
    handles.foldername=state;
    guidata(hObject, handles);
    weblink=['http://w1.weather.gov/xml/current_obs/seek.php?state=',state,'&Find=Find'];
    station_id=Xml_data_online_import(weblink,handles.working_dir,handles.foldername);
    set(handles.lb_files_web,'String',station_id)
    handles.file_paths=station_id; guidata(hObject, handles);
    saved_folder_path=[handles.working_dir,'\',handles.foldername];
    save saved_folder_path saved_folder_path

if get(handles.rb_computer,'value')==0
set(handles.txt_status,'BackgroundColor','green');set(handles.txt_status,'String','Download completed')
end
set(handles.txt_total_file_downloaded,'string',['Total files downloaded: ', num2str(length(station_id))]);
set(handles.eb_files_saved_in,'string',saved_folder_path)

% --- Executes on selection change in lb_files_web.
function lb_files_web_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function lb_files_web_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_files_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eb_text_Callback(hObject, eventdata, handles)
% hObject    handle to eb_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eb_text as text
%        str2double(get(hObject,'String')) returns contents of eb_text as a double


% --- Executes during object creation, after setting all properties.
function eb_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eb_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_extract.
function pb_extract_Callback(hObject, eventdata, handles)
search_ini=get(handles.eb_search_ini,'String');search_fin=get(handles.eb_search_fin,'String');
xml_extraction(handles.SelectedName,search_ini,search_fin)
data1 = importdata('write1.txt','');
set(handles.eb_text,'String',data1)
set(handles.txt_merged_file,'string','');


% --- Executes on button press in pb_merge.
function pb_merge_Callback(hObject, eventdata, handles)

search_ini=get(handles.eb_search_ini,'String');search_fin=get(handles.eb_search_fin,'String');
Record_no=0;
set(handles.lb_files_computer,'value', 1); 
handles.File_index=1;

set(handles.txt_merged_file,'string','');
for i=1:length(handles.file_paths)
        set(handles.lb_files_computer,'value', i);
        guidata(hObject, handles);pause(.2);
handles.SelectedName=handles.file_paths{i};
     xml_extraction(handles.SelectedName, search_ini,search_fin); %it will create write1.txt file
        fid_rd=fopen('write1.txt','r');
    
    
    if Record_no==0 %for the first time
        Record_no=Record_no+1;
        %fid_wt=fopen([handles.folder_path,'\',handles.foldername,'\','mergedfile_',handles.foldername,'.xml'],'wt');
        fid_wt=fopen([handles.folder_path,'\','mergedfile.xml'],'wt');
        t1= '<?xml version="1.0" encoding="ISO-8859-1"?>';
        t2='<?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>';
        t3='<current_observation version="1.0"';
        t4='xmlns:xsd="http://www.w3.org/2001/XMLSchema"';
        t5='xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
  
        fprintf (fid_wt,t1); fprintf (fid_wt,'\n');
        fprintf (fid_wt,t2); fprintf (fid_wt,'\n');
        fprintf (fid_wt,t3); fprintf (fid_wt,'\n');
        fprintf (fid_wt,t4); fprintf (fid_wt,'\n');
        fprintf (fid_wt,t5); fprintf (fid_wt,'\n');
        fprintf (fid_wt,'\n');
        fprintf (fid_wt,'<records>\n'); fprintf (fid_wt,'\n');
        fprintf (fid_wt,'<record id="%1.0f">\n',i);
        fprintf (fid_wt,'\n');
            while ~feof(fid_rd)
                 curr = fgets(fid_rd);
                 fprintf(fid_wt,'%s',curr);
            end
        fprintf (fid_wt,'</record>\n');
        fclose(fid_rd);
        fclose(fid_wt);
    else % appending

      %  fid_wt=fopen([handles.folder_path,'\',handles.foldername,'\','mergedfile_',handles.foldername,'.xml'],'a');     
       
fid_wt=fopen([handles.folder_path,'\','mergedfile.xml'],'a');     
        fprintf (fid_wt,'<record id="%1.0f">\n',i);
        %fprintf (fid_wt,'\n');
            while ~feof(fid_rd)
                 curr = fgets(fid_rd);
                 fprintf(fid_wt,'%s',curr);
            end
        fprintf (fid_wt,'</record>\n');
        if i==length(handles.file_paths);
            fprintf (fid_wt,'</records>\n'); fprintf (fid_wt,'\n');
                t1='<disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>';
                t2='<copyright_url>http://weather.gov/disclaimer.html</copyright_url>';
                t3='<privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>';
                 t4='</current_observation>';
                fprintf (fid_wt,t1); fprintf (fid_wt,'\n');
                fprintf (fid_wt,t2); fprintf (fid_wt,'\n');
                fprintf (fid_wt,t3); fprintf (fid_wt,'\n');
                fprintf (fid_wt,t4); fprintf (fid_wt,'\n');
        end
        
        fclose(fid_rd);
        fclose(fid_wt);  
    end      
    
end
set(handles.txt_merged_file,'string',[handles.folder_path,'mergedfile.xml is created']);
% data1 = importdata([handles.folder_path,'\',handles.foldername,'\','mergedfile.xml']);
% set(handles.eb_text,'String',data1)



function eb_search_ini_Callback(hObject, eventdata, handles)
% hObject    handle to eb_search_ini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eb_search_ini as text
%        str2double(get(hObject,'String')) returns contents of eb_search_ini as a double


% --- Executes during object creation, after setting all properties.
function eb_search_ini_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eb_search_ini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eb_search_fin_Callback(hObject, eventdata, handles)
% hObject    handle to eb_search_fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eb_search_fin as text
%        str2double(get(hObject,'String')) returns contents of eb_search_fin as a double


% --- Executes during object creation, after setting all properties.
function eb_search_fin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eb_search_fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rb_computer.
function rb_computer_Callback(hObject, eventdata, handles)
% hObject    handle to rb_computer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_computer


% --- Executes on button press in rb_web.
function rb_web_Callback(hObject, eventdata, handles)
% hObject    handle to rb_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_web



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_states.
function pop_states_Callback(hObject, eventdata, handles)
% hObject    handle to pop_states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_states contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_states


% --- Executes during object creation, after setting all properties.
function pop_states_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pb_extract_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pb_extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function eb_working_dir_Callback(hObject, eventdata, handles)
% hObject    handle to eb_working_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eb_working_dir as text
%        str2double(get(hObject,'String')) returns contents of eb_working_dir as a double


% --- Executes during object creation, after setting all properties.
function eb_working_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eb_working_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_change_working_dir.
function pb_change_working_dir_Callback(hObject, eventdata, handles)
% hObject    handle to pb_change_working_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('working_dir.mat')==2
    load working_dir
    starting_path=working_dir;
else
    starting_path=pwd;
end

working_dir=uigetdir(starting_path);
if length(working_dir)>2;save working_dir working_dir;end
set(handles.eb_working_dir,'String',working_dir)
handles.working_dir=working_dir;
 guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in pb_change_visibility_of_tabs.
function pb_change_visibility_of_tabs_Callback(hObject, eventdata, handles)
% hObject    handle to pb_change_visibility_of_tabs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.rb_web,'value')==1
    set(handles.uip_web,'Visible','on')
    set(handles.uip_computer,'Visible','off')
    set(handles.uip_web_all,'Visible','off')
elseif get(handles.rb_computer,'value')==1
     set(handles.uip_computer,'Visible','on')
     set(handles.uip_web,'Visible','off')
     set(handles.uip_web_all,'Visible','off')
else
    set(handles.uip_web_all,'Visible','on')
    set(handles.uip_computer,'Visible','off')
    set(handles.uip_web,'Visible','off')
     
end


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
pb_change_visibility_of_tabs_Callback(hObject, eventdata, handles)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb_files_computer.
function lb_files_computer_Callback(hObject, eventdata, handles)
File_index=get(hObject, 'Value');
handles.File_index=File_index;
handles.SelectedName=handles.file_paths{handles.File_index};
guidata(hObject, handles);
copyfile(handles.SelectedName,[pwd,'\','tempfile.txt']);
data1 = importdata('tempfile.txt','');
set(handles.eb_text,'String',data1)
[ s] = xml2struct( handles.SelectedName );
available_fields=fieldnames(s.current_observation)
set(handles.lb_attributes,'string',available_fields)

% --- Executes during object creation, after setting all properties.
function lb_files_computer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_files_computer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_load_files_computer.
function pb_load_files_computer_Callback(hObject, eventdata, handles)
    [Folder_path,file_paths] = Select_Files();
    set(handles.lb_files_computer,'String',file_paths)
    handles.file_paths=file_paths;
    handles.folder_path=Folder_path;
    set(handles.txt_merged_file,'string','');
    guidata(hObject, handles);



function eb_files_saved_in_Callback(hObject, eventdata, handles)
% hObject    handle to eb_files_saved_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eb_files_saved_in as text
%        str2double(get(hObject,'String')) returns contents of eb_files_saved_in as a double


% --- Executes during object creation, after setting all properties.
function eb_files_saved_in_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb_attributes.
function lb_attributes_Callback(hObject, eventdata, handles)
% hObject    handle to lb_attributes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_attributes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_attributes


% --- Executes during object creation, after setting all properties.
function lb_attributes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_attributes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_download_all_files.
function pb_download_all_files_Callback(hObject, eventdata, handles)
if strcmp(get(handles.eb_web_all_working_dir,'String'),'Saving Path')==1
    msgbox 'First select the saving path'
else
choice = questdlg('Would you like to download files for all State? It may take few minutes', ...
	'Options', ...
	'Yes','No','Cancel','No');
switch choice
    case 'Yes'
    tic;
    handles.working_dir=get(handles.eb_web_all_working_dir,'string');
    allstate=get(handles.lb_folders_web_all,'String');
    set(handles.txt_web_all_status,'BackgroundColor','red');pause(0.2)
    for state_index=1:length(allstate)
    
    set(handles.lb_folders_web_all,'value',state_index);
    state=allstate{state_index};
    set(handles.txt_web_all_status,'string',['Download in progress for the state -',state]);pause(0.2)
    handles.foldername=state;
    %guidata(hObject, handles);
    weblink=['http://w1.weather.gov/xml/current_obs/seek.php?state=',state,'&Find=Find'];
    station_id=Xml_data_online_import(weblink,handles.working_dir,handles.foldername);
    end
    totaltime=toc;
    set(handles.txt_web_all_status,'string',['Download Complete and total elapsed time is ',num2str(round(totaltime)),' secs.']);
    set(handles.txt_web_all_status,'BackgroundColor','green');
end  
end
% --- Executes on selection change in lb_folders_web_all.
function lb_folders_web_all_Callback(hObject, eventdata, handles)
% hObject    handle to lb_folders_web_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_folders_web_all contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_folders_web_all


% --- Executes during object creation, after setting all properties.
function lb_folders_web_all_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_folders_web_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eb_web_all_working_dir_Callback(hObject, eventdata, handles)
% hObject    handle to eb_web_all_working_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eb_web_all_working_dir as text
%        str2double(get(hObject,'String')) returns contents of eb_web_all_working_dir as a double


% --- Executes during object creation, after setting all properties.
function eb_web_all_working_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eb_web_all_working_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_change_path_web_all.
function pb_change_path_web_all_Callback(hObject, eventdata, handles)
path2save=uigetdir(pwd,'select folder to save files');
set(handles.eb_web_all_working_dir,'string',path2save)
set(handles.pb_add_datentime,'Enable','on')
% --- Executes on button press in rb_web_all.
function rb_web_all_Callback(hObject, eventdata, handles)
pb_change_visibility_of_tabs_Callback(hObject, eventdata, handles)
set(handles.lb_folders_web_all,'string',get(handles.pop_states,'string'))


% --- Executes on button press in pb_add_datentime.
function pb_add_datentime_Callback(hObject, eventdata, handles)
datetime=clock;
foldername=[num2str(datetime(1)),'-',num2str(datetime(2)),'-',num2str(datetime(3)),...
    '-',num2str(datetime(4)),'-',num2str(datetime(5)),'-',num2str(round(datetime(6)))];
original_folder_name=get(handles.eb_web_all_working_dir,'string');
date_time_added_folder=[original_folder_name,'\',foldername];
mkdir(date_time_added_folder);
set(handles.eb_web_all_working_dir,'string',date_time_added_folder)
