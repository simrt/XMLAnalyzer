function varargout = Xml_analyzer_V4(varargin)
% XML_ANALYZER_V4 MATLAB code for Xml_analyzer_V4.fig
%      XML_ANALYZER_V4, by itself, creates a new XML_ANALYZER_V4 or raises the existing
%      singleton*.
%
%      H = XML_ANALYZER_V4 returns the handle to a new XML_ANALYZER_V4 or the handle to
%      the existing singleton*.
%
%      XML_ANALYZER_V4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XML_ANALYZER_V4.M with the given input arguments.
%
%      XML_ANALYZER_V4('Property','Value',...) creates a new XML_ANALYZER_V4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xml_analyzer_V4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xml_analyzer_V4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xml_analyzer_V4

% Last Modified by GUIDE v2.5 08-Apr-2016 16:40:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Xml_analyzer_V4_OpeningFcn, ...
                   'gui_OutputFcn',  @Xml_analyzer_V4_OutputFcn, ...
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


% --- Executes just before Xml_analyzer_V4 is made visible.
function Xml_analyzer_V4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xml_analyzer_V4 (see VARARGIN)

% Choose default command line output for Xml_analyzer_V4
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

% UIWAIT makes Xml_analyzer_V4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Xml_analyzer_V4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_load_files.
function pb_load_files_Callback(hObject, eventdata, handles)
% hObject    handle to pb_load_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.lb_files,'value', 1); 
set(handles.lb_files,'String',[]); %clearing list
if get(handles.rb_computer,'value')==0
    set(handles.txt_status,'BackgroundColor','red');set(handles.txt_status,'String','Downloading')
end
pause(1)
if get(handles.rb_computer,'value')==1
    [Folder_path,file_paths] = Select_Files()
    set(handles.lb_files,'String',file_paths)
    handles.file_paths=file_paths;
    handles.folder_path=Folder_path;
    handles.working_dir=Folder_path;
    set(handles.eb_working_dir,'String',Folder_path)
    guidata(hObject, handles);
else
    %handles.folder_path=pwd;
    handles.folder_path=handles.working_dir;
    allstate=get(handles.pop_states,'String');
    state_index=get(handles.pop_states,'Value');
    state=allstate{state_index};handles.foldername=state;
    guidata(hObject, handles);
    weblink=['http://w1.weather.gov/xml/current_obs/seek.php?state=',state,'&Find=Find'];
    station_id=Xml_data_online_import(weblink,handles.folder_path,handles.foldername);
    set(handles.lb_files,'String',station_id)
    handles.file_paths=station_id; guidata(hObject, handles);
end
if get(handles.rb_computer,'value')==0
set(handles.txt_status,'BackgroundColor','green');set(handles.txt_status,'String','Download completed')
end
% --- Executes on selection change in lb_files.
function lb_files_Callback(hObject, eventdata, handles)
if get(handles.rb_computer,'value')==1;
File_index=get(hObject, 'Value');
handles.File_index=File_index;
handles.SelectedName=handles.file_paths{handles.File_index};
guidata(hObject, handles);
else
    File_index=get(hObject, 'Value');handles.File_index=File_index;
    handles.SelectedName_only=handles.file_paths{handles.File_index};
    handles.SelectedName=[handles.folder_path,'\',handles.foldername,'\',handles.SelectedName_only];
    guidata(hObject, handles);
end
% --- Executes during object creation, after setting all properties.
function lb_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_files (see GCBO)
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
search_ini=get(handles.eb_search_ini,'String');search_fin=get(handles.eb_search_fin,'String')
xml_extraction(handles.SelectedName,handles.folder_path,handles.foldername, search_ini,search_fin)
data1 = importdata('write1.txt','');
set(handles.eb_text,'String',data1)


% --- Executes on button press in pb_merge.
function pb_merge_Callback(hObject, eventdata, handles)
% hObject    handle to pb_merge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
search_ini=get(handles.eb_search_ini,'String');search_fin=get(handles.eb_search_fin,'String');
Record_no=0;
set(handles.lb_files,'value', 1); %lb_files_Callback;
% handles.search_ini=get(handles.eb_search_ini,'string');
% handles.search_ini=get(handles.eb_search_fin,'string');
guidata(hObject, handles);
for i=1:length(handles.file_paths)
        set(handles.lb_files,'value', i);
        guidata(hObject, handles);pause(.02);
 if       get(handles.rb_computer,'value')==1
        handles.SelectedName=handles.file_paths{i}
        else
            %handles.SelectedName=[handles.folder_path,'\',handles.foldername,'\',handles.SelectedName_only];
            handles.SelectedName=[handles.working_dir,'\',handles.foldername,'\',handles.SelectedName_only];
end
       xml_extraction(handles.SelectedName, search_ini,search_fin);
        fid_rd=fopen('write1.txt','r');
    
    
    if Record_no==0 %for the first time
        Record_no=Record_no+1;
        %fid_wt=fopen([handles.folder_path,'\',handles.foldername,'\','mergedfile_',handles.foldername,'.xml'],'wt');
        fid_wt=fopen([handles.working_dir,'\',handles.foldername,'\','mergedfile_',handles.foldername,'.xml'],'wt');
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
        fprintf (fid_wt,'<record id="%2.0f">\n',i);
        fprintf (fid_wt,'\n');
            while ~feof(fid_rd)
                 curr = fgets(fid_rd);
                 fprintf(fid_wt,'%s\n',curr);
            end
        fprintf (fid_wt,'</record>\n');
        fclose(fid_rd);
        fclose(fid_wt);
    else % appending

      %  fid_wt=fopen([handles.folder_path,'\',handles.foldername,'\','mergedfile_',handles.foldername,'.xml'],'a');     
       
       fid_wt=fopen([handles.working_dir,'\',handles.foldername,'\','mergedfile_',handles.foldername,'.xml'],'a');     
        fprintf (fid_wt,'<record id="%2.0f ">\n',i);
        fprintf (fid_wt,'\n');
            while ~feof(fid_rd)
                 curr = fgets(fid_rd);
                 fprintf(fid_wt,'%s \n',curr);
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
        fclose(fid_wt)   ;  
    end      
    
end
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

working_dir=uigetdir;
save working_dir working_dir
set(handles.eb_working_dir,'String',working_dir)
handles.working_dir=working_dir;
 guidata(hObject, handles)
