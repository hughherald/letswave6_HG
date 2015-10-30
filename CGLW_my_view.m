function CGLW_my_view()
clc;
file_path=which('CGLW_my_view');
[p, n, e]=fileparts(file_path);
varargin{2}={[p,'\chan-select ep dataset1.lw6'],[p,'\ep dataset2.lw6']};
handles=[];
userdata=[];
datasets_header={};
datasets_data={};
initGUI;

    function initGUI
        inputfiles=varargin{2};
        for k=1:length(inputfiles);
            [p, n, e]=fileparts(inputfiles{k});
            userdata.datasets_filename{k}=n;
            [datasets_header(k).header, datasets_data(k).data]=CLW_load(inputfiles{k});
        end
        userdata.is_split=0;
        userdata.datasets_index=[1,2];
        userdata.epochs_index=1;
        userdata.channels_index=1;
        userdata.fig_pos=[100,100,360,610];
        createGUI;
        updateGUI;
        
    end

    function createGUI
        handles=[];
        icon=load('icon.mat');
        handles.fig1=figure('SizeChangedFcn',@fig1_SizeChangedFcn,'Visible','off');
        set(handles.fig1,'position',userdata.fig_pos);
        set(handles.fig1,'MenuBar','none');
        set(handles.fig1,'DockControls','off');
        handles.toolbar1 = uitoolbar(handles.fig1);
        handles.toolbar1_split = uitoggletool(handles.toolbar1);
        set(handles.toolbar1_split,'TooltipString','Split');
        set(handles.toolbar1_split,'CData',icon.icon_split);
        set(handles.toolbar1_split,'OnCallback',{@fig_split,1});
        set(handles.toolbar1_split,'OffCallback',{@fig_split,0});
        if userdata.is_split==1
            set(handles.toolbar1_split,'State','on');
        else
            set(handles.toolbar1_split,'State','off');
        end
        handles.panel=uipanel(handles.fig1);
        set(handles.panel,'Title','Datasets');
        set(handles.panel,'Units','pixels');
        if userdata.is_split==1
            set(handles.panel,'Position',[5,5,userdata.fig_pos(3)-10,userdata.fig_pos(4)-10]);
        else
            set(handles.panel,'Position',[5,5,350,userdata.fig_pos(4)-10]);
        end
        %set(handles.panel,'Units','normalized');
        handles.dataset_listbox=uicontrol(handles.panel,'style','listbox');
        set(handles.dataset_listbox,'Min',0);
        set(handles.dataset_listbox,'Max',2);
        set(handles.dataset_listbox,'Units','pixels');
        set(handles.dataset_listbox,'Position',[5,userdata.fig_pos(4)-125,userdata.fig_pos(3)-20,100]);
        set(handles.dataset_listbox,'Units','normalized');
        
        handles.epoch_text=uicontrol(handles.panel,'style','text','String','Epochs:');
        set(handles.epoch_text,'Units','pixels');
        set(handles.epoch_text,'HorizontalAlignment','left');
        set(handles.epoch_text,'Position',[5,userdata.fig_pos(4)-155,50,20]);
        set(handles.epoch_text,'Units','normalized');
        handles.epoch_listbox=uicontrol(handles.panel,'style','listbox');
        set(handles.epoch_listbox,'Min',0);
        set(handles.epoch_listbox,'Max',2);
        set(handles.epoch_listbox,'Units','pixels');
        set(handles.epoch_listbox,'Position',[5,userdata.fig_pos(4)-450,70,300]);
        set(handles.epoch_listbox,'Units','normalized');
        
        handles.channel_text=uicontrol(handles.panel,'style','text','String','Channels:');
        set(handles.channel_text,'Units','pixels');
        set(handles.channel_text,'HorizontalAlignment','left');
        set(handles.channel_text,'Position',[80,userdata.fig_pos(4)-155,50,20]);
        set(handles.channel_text,'Units','normalized');
        handles.channel_listbox=uicontrol(handles.panel,'style','listbox');
        set(handles.channel_listbox,'Min',0);
        set(handles.channel_listbox,'Max',2);
        set(handles.channel_listbox,'Units','pixels');
        set(handles.channel_listbox,'Position',[80,userdata.fig_pos(4)-450,100,300]);
        set(handles.channel_listbox,'Units','normalized');
        
        handles.graph_row_text=uicontrol(handles.panel,'style','text','String','Separate graphs (rows) :');
        set(handles.graph_row_text,'Units','pixels');
        set(handles.graph_row_text,'HorizontalAlignment','left');
        set(handles.graph_row_text,'Position',[10,userdata.fig_pos(4)-483,150,20]);
        set(handles.graph_row_text,'Units','normalized');
        handles.graph_row_popup=uicontrol(handles.panel,'style','popup','String',{'datasets','epochs','channels'});
        set(handles.graph_row_popup,'Units','pixels');
        set(handles.graph_row_popup,'Position',[5,userdata.fig_pos(4)-500,175,20]);
        set(handles.graph_row_popup,'Units','normalized');
        
        handles.graph_col_text=uicontrol(handles.panel,'style','text','String','Separate graphs (columns) :');
        set(handles.graph_col_text,'Units','pixels');
        set(handles.graph_col_text,'HorizontalAlignment','left');
        set(handles.graph_col_text,'Position',[10,userdata.fig_pos(4)-533,150,20]);
        set(handles.graph_col_text,'Units','normalized');
        handles.graph_col_popup=uicontrol(handles.panel,'style','popup','String',{'datasets','epochs','channels'});
        set(handles.graph_col_popup,'Units','pixels');
        set(handles.graph_col_popup,'Position',[5,userdata.fig_pos(4)-550,175,20]);
        set(handles.graph_col_popup,'Units','normalized');
        
        handles.graph_wave_text=uicontrol(handles.panel,'style','text','String','Superimposed waves :');
        set(handles.graph_wave_text,'Units','pixels');
        set(handles.graph_wave_text,'HorizontalAlignment','left');
        set(handles.graph_wave_text,'Position',[10,userdata.fig_pos(4)-583,150,20]);
        set(handles.graph_wave_text,'Units','normalized');
        handles.graph_wave_popup=uicontrol(handles.panel,'style','popup','String',{'datasets','epochs','channels'});
        set(handles.graph_wave_popup,'Units','pixels');
        set(handles.graph_wave_popup,'Position',[5,userdata.fig_pos(4)-600,175,20]);
        set(handles.graph_wave_popup,'Units','normalized');
        
        handles.index_text=uicontrol(handles.panel,'style','text','String','Index:');
        set(handles.index_text,'Units','pixels');
        set(handles.index_text,'HorizontalAlignment','left');
        set(handles.index_text,'Position',[190,userdata.fig_pos(4)-155,50,20]);
        set(handles.index_text,'Units','normalized');
        set(handles.index_text,'Visible','off');
        handles.index_popup=uicontrol(handles.panel,'style','popup');
        set(handles.index_popup,'String',{'pixels','pixels','pixels','pixels','pixels','pixels','pixels'});
        set(handles.index_popup,'Units','pixels');
        set(handles.index_popup,'Position',[185,userdata.fig_pos(4)-170,150,20]);
        set(handles.index_popup,'Units','normalized');
        set(handles.index_popup,'Visible','off');
        
        handles.y_text=uicontrol(handles.panel,'style','text','String','Y:');
        set(handles.y_text,'Units','pixels');
        set(handles.y_text,'HorizontalAlignment','left');
        set(handles.y_text,'Position',[185,userdata.fig_pos(4)-210,50,20]);
        set(handles.y_text,'Units','normalized');
        set(handles.y_text,'Visible','off');
        handles.y_edit=uicontrol(handles.panel,'style','edit');
        set(handles.y_edit,'Units','pixels');
        set(handles.y_edit,'Position',[200,userdata.fig_pos(4)-208,50,20]);
        set(handles.y_edit,'Units','normalized');
        set(handles.y_edit,'Visible','off');
        
        handles.z_text=uicontrol(handles.panel,'style','text','String','Z:');
        set(handles.z_text,'Units','pixels');
        set(handles.z_text,'HorizontalAlignment','left');
        set(handles.z_text,'Position',[265,userdata.fig_pos(4)-210,50,20]);
        set(handles.z_text,'Units','normalized');
        set(handles.z_text,'Visible','off');
        handles.z_edit=uicontrol(handles.panel,'style','edit');
        set(handles.z_edit,'Units','pixels');
        set(handles.z_edit,'Position',[280,userdata.fig_pos(4)-208,50,20]);
        set(handles.z_edit,'Units','normalized');
        set(handles.z_edit,'Visible','off');
        
        handles.xaxis_panel=uipanel(handles.panel);
        set(handles.xaxis_panel,'Title','X-axis:');
        set(handles.xaxis_panel,'Units','pixels');
        set(handles.xaxis_panel,'Position',[190,userdata.fig_pos(4)-290,userdata.fig_pos(3)-210,70]);
        set(handles.xaxis_panel,'Units','normalized');
        handles.xaxis1_edit=uicontrol(handles.xaxis_panel,'style','edit');
        set(handles.xaxis1_edit,'Units','pixels');
        set(handles.xaxis1_edit,'Position',[5,35,60,20]);
        set(handles.xaxis1_edit,'Units','normalized');
        handles.xaxis2_edit=uicontrol(handles.xaxis_panel,'style','edit');
        set(handles.xaxis2_edit,'Units','pixels');
        set(handles.xaxis2_edit,'Position',[80,35,60,20]);
        set(handles.xaxis2_edit,'Units','normalized');
        handles.xaxis_auto_edit=uicontrol(handles.xaxis_panel,'style','checkbox');
        set(handles.xaxis_auto_edit,'String','auto');
        set(handles.xaxis_auto_edit,'Units','pixels');
        set(handles.xaxis_auto_edit,'Position',[15,5,60,20]);
        set(handles.xaxis_auto_edit,'Units','normalized');
        
        handles.yaxis_panel=uipanel(handles.panel);
        set(handles.yaxis_panel,'Title','Y-axis:');
        set(handles.yaxis_panel,'Units','pixels');
        set(handles.yaxis_panel,'Position',[190,userdata.fig_pos(4)-370,userdata.fig_pos(3)-210,70]);
        set(handles.yaxis_panel,'Units','normalized');
        handles.yaxis1_edit=uicontrol(handles.yaxis_panel,'style','edit');
        set(handles.yaxis1_edit,'Units','pixels');
        set(handles.yaxis1_edit,'Position',[5,35,60,20]);
        set(handles.yaxis1_edit,'Units','normalized');
        handles.yaxis2_edit=uicontrol(handles.yaxis_panel,'style','edit');
        set(handles.yaxis2_edit,'Units','pixels');
        set(handles.yaxis2_edit,'Position',[80,35,60,20]);
        set(handles.yaxis2_edit,'Units','normalized');
        handles.yaxis_auto_edit=uicontrol(handles.yaxis_panel,'style','checkbox');
        set(handles.yaxis_auto_edit,'String','auto');
        set(handles.yaxis_auto_edit,'Units','pixels');
        set(handles.yaxis_auto_edit,'Position',[15,5,60,20]);
        set(handles.yaxis_auto_edit,'Units','normalized');
        
        handles.interval_panel=uipanel(handles.panel);
        set(handles.interval_panel,'Title','Explore interval');
        set(handles.interval_panel,'Units','pixels');
        set(handles.interval_panel,'Position',[190,10,userdata.fig_pos(3)-210,200]);
        set(handles.interval_panel,'Units','normalized');
        handles.interval1_edit=uicontrol(handles.interval_panel,'style','edit');
        set(handles.interval1_edit,'Units','pixels');
        set(handles.interval1_edit,'Position',[5,160,60,20]);
        set(handles.interval1_edit,'Units','normalized');
        handles.interval2_edit=uicontrol(handles.interval_panel,'style','edit');
        set(handles.interval2_edit,'Units','pixels');
        set(handles.interval2_edit,'Position',[80,160,60,20]);
        set(handles.interval2_edit,'Units','normalized');
        handles.interval_popup1=uicontrol(handles.interval_panel,'style','popup');
        set(handles.interval_popup1,'String',{'max within interval','min within interval','latency'});
        set(handles.interval_popup1,'Units','pixels');
        set(handles.interval_popup1,'Position',[5,130,135,20]);
        set(handles.interval_popup1,'Units','normalized');
        handles.interval_button1=uicontrol(handles.interval_panel,'style','pushbutton');
        set(handles.interval_button1,'String','Table');
        set(handles.interval_button1,'Units','pixels');
        set(handles.interval_button1,'Position',[5,95,135,30]);
        set(handles.interval_button1,'Units','normalized');
        handles.interval_button2=uicontrol(handles.interval_panel,'style','pushbutton');
        set(handles.interval_button2,'String','Scalp maps');
        set(handles.interval_button2,'Units','pixels');
        set(handles.interval_button2,'Position',[5,62,135,30]);
        set(handles.interval_button2,'Units','normalized');
        handles.interval_button3=uicontrol(handles.interval_panel,'style','pushbutton');
        set(handles.interval_button3,'String','Head plots');
        set(handles.interval_button3,'Units','pixels');
        set(handles.interval_button3,'Position',[5,29,135,30]);
        set(handles.interval_button3,'Units','normalized');
        handles.interval_popup2=uicontrol(handles.interval_panel,'style','popup');
        set(handles.interval_popup2,'String',{'top','back','left','right','front'});
        set(handles.interval_popup2,'Units','pixels');
        set(handles.interval_popup2,'Position',[5,5,135,20]);
        set(handles.interval_popup2,'Units','normalized');
        
        set(handles.fig1,'SizeChangedFcn',@fig1_SizeChangedFcn);
        set(handles.fig1,'Visible','on');
        
        set(handles.dataset_listbox,'String',userdata.datasets_filename);
        set(handles.dataset_listbox,'Value',userdata.datasets_index);
    end

    function updateGUI
        selected_datasets=get(handles.dataset_listbox,'Value');
        selected_epochs=get(handles.epoch_listbox,'Value');
        selected_channels=get(handles.channel_listbox,'Value');
        indexpos=get(handles.index_popup,'Value');
        graph_row_idx=get(handles.graph_row_popup,'Value');
        graph_col_idx=get(handles.graph_col_popup,'Value');
        graph_wave_idx=get(handles.graph_wave_popup,'Value');
        
        %if ~isequal(userdata.datasets_index,selected_datasets)
            header=datasets_header(userdata.datasets_index(1)).header;
            channel_label= {header.chanlocs.labels};
            for k=userdata.datasets_index(2:end)
                header.datasize=min(header.datasize,datasets_header(k).header.datasize);
                channel_label=intersect(channel_label,{datasets_header(k).header.chanlocs.labels});
                if isempty(channel_label)
                    CreateStruct.Interpreter = 'none';
                    CreateStruct.WindowStyle = 'modal';
                    h=msgbox('no common channels!','Error','error',CreateStruct);
                    return;
                end
            end
            
            st={};
            for k=1:header.datasize(1)
                st{k}=num2str(k);
            end;
            set(handles.epoch_listbox,'String',st);
            header.datasize(2)=length(channel_label);
            [~,ia] = intersect(channel_label,{header.chanlocs.labels});
            header.chanlocs=header.chanlocs(ia);
            for k=userdata.datasets_index
                [~,userdata.channel_index{k}]=intersect({datasets_header(k).header.chanlocs.labels},channel_label);
            end
            set(handles.channel_listbox,'String',channel_label);
            disp(header.datasize);
            if header.datasize(3)>1;
                set(handles.index_text,'Visible','on');
                set(handles.index_popup,'Visible','on');
                if isfield(header,'index_labels');
                    set(handles.index_popup,'String',header.index_labels);
                    set(handles.index_popup,'Value',1);
                else
                    st={};
                    for i=1:header.datasize(3);
                        st{i}=num2str(i);
                    end
                    set(handles.index_popup,'String',st);
                    set(handles.index_popup,'Value',1);
                end
            end
            %y
            if header.datasize(5)>1;
                set(handles.y_text,'Visible','on');
                set(handles.y_edit,'Visible','on');
                set(handles.y_edit,'String',num2str(header.ystart));
            end
            %z
            if header.datasize(4)>1;
                set(handles.z_text,'Visible','on');
                set(handles.z_edit,'Visible','on');
                set(handles.z_edit,'String',num2str(header.zstart));
            end
        %end
    end

    function fig1_SizeChangedFcn(obj,events)
        userdata.fig_pos=get(handles.fig1,'Position');
        p=get(handles.panel,'Position');
        if userdata.is_split==1
            p(3)=360;
        else
            p(3)=userdata.fig_pos(3)-10;%fix(0.9722*(userdata.fig_pos(3)));
        end
        p(4)=userdata.fig_pos(4)-10;%fix(0.9836*(userdata.fig_pos(4)));
        set(handles.panel,'Position',p);
    end

    function fig_split(obj,events,is_split)
        userdata.is_split=is_split;
        %         if is_split==1
        %             if ishandle(handles.fig1)
        %                 close(handles.fig1);
        %             end
        %         else
        %             if ishandle(handles.fig1)
        %                 close(handles.fig1);
        %             end
        %             if ishandle(handles.fig2)
        %                 close(handles.fig2);
        %             end
        %         end
        %         createGUI;
    end
end