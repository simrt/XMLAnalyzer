function varargout = Xml_analyzer_V1(varargin)
% XML_ANALYZER_V1 MATLAB code for Xml_analyzer_V1.fig
%      XML_ANALYZER_V1, by itself, creates a new XML_ANALYZER_V1 or raises the existing
%      singleton*.
%
%      H = XML_ANALYZER_V1 returns the handle to a new XML_ANALYZER_V1 or the handle to
%      the existing singleton*.
%
%      XML_ANALYZER_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XML_ANALYZER_V1.M with the given input arguments.
%
%      XML_ANALYZER_V1('Property','Value',...) creates a new XML_ANALYZER_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xml_analyzer_V1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xml_analyzer_V1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xml_analyzer_V1

% Last Modified by GUIDE v2.5 05-Apr-2016 19:47:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Xml_analyzer_V1_OpeningFcn, ...
                   'gui_OutputFcn',  @Xml_analyzer_V1_OutputFcn, ...
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


% --- Executes just before Xml_analyzer_V1 is made visible.
function Xml_analyzer_V1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xml_analyzer_V1 (see VARARGIN)

% Choose default command line output for Xml_analyzer_V1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Xml_analyzer_V1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Xml_analyzer_V1_OutputFcn(hObject, eventdata, handles) 
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

for i=1:15
    handles.SelectedName=handles.file_paths{i};
    xml_extraction_n_make_write1_txt_file(handles.SelectedName);
     fid_rd=fopen('write1.txt','r')
    
    file_exist_check = exist('mergedfile.txt');
    if file_exist_check==0 %file does not exist, then make it
    fid_wt=fopen('mergedfile.txt','wt');
   
    fprintf (fid_wt,'<record id="%2.0f ">\n',i)
    while ~feof(fid_rd)
         curr = fgets(fid_rd)
         fprintf(fid_wt,'%s \n',curr);
    end
    fprintf (fid_wt,'</record>\n')
    fclose(fid_rd)
    fclose(fid_wt)
    else % appending

    fid_wt=fopen('mergedfile.txt','a');     
    fprintf (fid_wt,'<record id="%2.0f ">\n',i)
    while ~feof(fid_rd)
         curr = fgets(fid_rd)
         fprintf(fid_wt,'%s \n',curr);
    end
    fprintf (fid_wt,'</record>\n')
    
    fclose(fid_rd)
    fclose(fid_wt)     
         
    end
end
