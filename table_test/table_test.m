function varargout = table_test(varargin)
% TABLE_TEST MATLAB code for table_test.fig
%      TABLE_TEST, by itself, creates a new TABLE_TEST or raises the existing
%      singleton*.
%
%      H = TABLE_TEST returns the handle to a new TABLE_TEST or the handle to
%      the existing singleton*.
%
%      TABLE_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABLE_TEST.M with the given input arguments.
%
%      TABLE_TEST('Property','Value',...) creates a new TABLE_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before table_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to table_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help table_test

% Last Modified by GUIDE v2.5 08-Apr-2015 18:53:33

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @table_test_OpeningFcn, ...
                   'gui_OutputFcn',  @table_test_OutputFcn, ...
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


% --- Executes just before table_test is made visible.
function table_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to table_test (see VARARGIN)

% Choose default command line output for table_test
handles.output = hObject;

% Update handles structure
jEditor = javax.swing.JTextField('click me');
handles.jEditor=jEditor;
javacomponent(jEditor, [50,50,80,20], handles.figure1);
guidata(hObject, handles);
% UIWAIT makes table_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = table_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
handles.uitable1.Data=rand(33,2);
handles.uitable1.ColumnName='';
handles.uitable1.RowName='';
handles.uitable1.Position(3)=handles.uitable1.Extent(3);


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
%disp(eventdata);
hObject.Units='pixels';
handles.edit1.Units='pixels';
dp_position=hObject.Extent(4)/size(handles.uitable1.Data,1)-0.15;
if(eventdata.Indices(2)==2)
%     handles.edit1.Position(1)=hObject.position(1)+hObject.ColumnWidth{1};
%     handles.edit1.Position(2)=hObject.position(2)+hObject.position(4)-eventdata.Indices(1)*dp_position;
%     handles.edit1.Position(3)=hObject.position(3)-hObject.ColumnWidth{1};
%     handles.edit1.Position(4)=dp_position;
%     uicontrol(handles.edit1);

    position(1)=hObject.Position(1)+hObject.ColumnWidth{1};
    position(2)=hObject.Position(2)+hObject.Position(4)-eventdata.Indices(1)*dp_position;
    position(3)=hObject.Position(3)-hObject.ColumnWidth{1};
    position(4)=dp_position;    
    
    javacomponent(handles.jEditor, position, handles.figure1);
end




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
disp('edit1_Callback');


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function callback_fcn(hSource, eventData)
    
disp('callback_fcn');