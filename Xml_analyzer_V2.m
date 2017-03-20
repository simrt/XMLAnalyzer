function varargout = Xml_analyzer_V2(varargin)
% XML_ANALYZER_V2 MATLAB code for Xml_analyzer_V2.fig
%      XML_ANALYZER_V2, by itself, creates a new XML_ANALYZER_V2 or raises the existing
%      singleton*.
%
%      H = XML_ANALYZER_V2 returns the handle to a new XML_ANALYZER_V2 or the handle to
%      the existing singleton*.
%
%      XML_ANALYZER_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XML_ANALYZER_V2.M with the given input arguments.
%
%      XML_ANALYZER_V2('Property','Value',...) creates a new XML_ANALYZER_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xml_analyzer_V2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xml_analyzer_V2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xml_analyzer_V2

% Last Modified by GUIDE v2.5 05-Apr-2016 23:02:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Xml_analyzer_V2_OpeningFcn, ...
                   'gui_OutputFcn',  @Xml_analyzer_V2_OutputFcn, ...
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


% --- Executes just before Xml_analyzer_V2 is made visible.
function Xml_analyzer_V2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xml_analyzer_V2 (see VARARGIN)

% Choose default command line output for Xml_analyzer_V2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Xml_analyzer_V2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Xml_analyzer_V2_OutputFcn(hObject, eventdata, handles) 
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
[file_paths] = Select_Files();
set(handles.lb_files,'String',file_paths)
handles.file_paths=file_paths;

guidata(hObject, handles);

% --- Executes on selection change in lb_files.
function lb_files_Callback(hObject, eventdata, handles)
File_index=get(hObject, 'Value');
handles.File_index=File_index;
handles.SelectedName=handles.file_paths{handles.File_index};
guidata(hObject, handles);

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
xml_extraction_n_make_write1_txt_file(handles.SelectedName)
data1 = importdata('write1.txt','');
set(handles.eb_text,'String',data1)


% --- Executes on button press in pb_merge.
function pb_merge_Callback(hObject, eventdata, handles)
% hObject    handle to pb_merge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Record_no=0;
set(handles.lb_files,'value', 1); guidata(hObject, handles);
for i=1:length(handles.file_paths)
        set(handles.lb_files,'value', i)
        guidata(hObject, handles);pause(.02)
        handles.SelectedName=handles.file_paths{i};
        xml_extraction_n_make_write1_txt_file(handles.SelectedName);
        fid_rd=fopen('write1.txt','r')
    
    
    if Record_no==0 %for the first time
        Record_no=Record_no+1;
        fid_wt=fopen('mergedfile.txt','wt');
       t1= '<?xml version="1.0" encoding="ISO-8859-1"?>';
t2='<?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>';
t3='<current_observation version="1.0"';
	 t4='xmlns:xsd="http://www.w3.org/2001/XMLSchema"'
	 t5='xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"'
        fprintf (fid_wt,t1); fprintf (fid_wt,'\n')
        fprintf (fid_wt,t2); fprintf (fid_wt,'\n')
        fprintf (fid_wt,t3); fprintf (fid_wt,'\n')
        fprintf (fid_wt,t4); fprintf (fid_wt,'\n')
        fprintf (fid_wt,t5); fprintf (fid_wt,'\n')
        fprintf (fid_wt,'\n')
        fprintf (fid_wt,'<records>\n'); fprintf (fid_wt,'\n')
        fprintf (fid_wt,'<record id="%2.0f">\n',i)
        fprintf (fid_wt,'\n')
            while ~feof(fid_rd)
                 curr = fgets(fid_rd)
                 fprintf(fid_wt,'%s\n',curr);
            end
        fprintf (fid_wt,'</record>\n')
        fclose(fid_rd)
        fclose(fid_wt)
    else % appending

        fid_wt=fopen('mergedfile.txt','a');     
        fprintf (fid_wt,'<record id="%2.0f ">\n',i)
        fprintf (fid_wt,'\n')
            while ~feof(fid_rd)
                 curr = fgets(fid_rd)
                 fprintf(fid_wt,'%s \n',curr);
            end
        fprintf (fid_wt,'</record>\n')
        if i==length(handles.file_paths)
            fprintf (fid_wt,'</records>\n'); fprintf (fid_wt,'\n')
                t1='<disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>';
                t2='<copyright_url>http://weather.gov/disclaimer.html</copyright_url>';
                t3='<privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>';
                fprintf (fid_wt,t1); fprintf (fid_wt,'\n')
                fprintf (fid_wt,t2); fprintf (fid_wt,'\n')
                fprintf (fid_wt,t3); fprintf (fid_wt,'\n')
                
        end
        
        fclose(fid_rd)
        fclose(fid_wt)     
    end      
    
end
data1 = importdata('mergedfile.txt');
set(handles.eb_text,'String',data1)
