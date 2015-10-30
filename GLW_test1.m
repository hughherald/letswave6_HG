function GLW_test1
clc;
f=0.1;
t=linspace(0,1,1000);
y=sin(2*pi*f*t);

handles=[];
userdata=[];
initGUI;

    function initGUI
        userdata.is_split=0;
        createGUI;
    end

    function createGUI
        handles=[];
        icon=load('icon.mat');
        handles.fig1=figure('SizeChangedFcn',@Fig1_SizeChanged,'Visible','off');
        set(handles.fig1,'Visible','on');
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
        
        if userdata.is_split==1
            handles.fig2=figure('SizeChangedFcn',@Fig2_SizeChanged,'Visible','off');
            set(handles.fig2,'Visible','on');
            set(handles.fig2,'MenuBar','none');
            set(handles.fig2,'DockControls','off');
            handles.toolbar2 = uitoolbar(handles.fig2);
            handles.toolbar2_split = uitoggletool(handles.toolbar2);
            set(handles.toolbar2_split,'TooltipString','Split');
            set(handles.toolbar2_split,'CData',icon.icon_split);
            set(handles.toolbar2_split,'OnCallback',{@fig_split,1});
            set(handles.toolbar2_split,'OffCallback',{@fig_split,0});
            set(handles.toolbar2_split,'State','on');
            
            figure(handles.fig1)
            handles.ax(1)=subplot(1,1,1);
            plot(t,y);
            figure(handles.fig2)
            handles.ax(2)=subplot(1,1,1);
            plot(t,-y);
        else
            figure(handles.fig1)
            handles.ax(1)=subplot(1,2,1);
            plot(t,y);
            handles.ax(2)=subplot(1,2,2);
            plot(t,-y);
        end
    end
    function Fig1_SizeChanged(varargin)
        handles;
    end
    function fig_split(obj,events,is_split)
        userdata.is_split=is_split;
        if is_split==1
            if ishandle(handles.fig1)
                close(handles.fig1);
            end
        else
            if ishandle(handles.fig1)
                close(handles.fig1);
            end
            if ishandle(handles.fig2)
                close(handles.fig2);
            end
        end
        createGUI;
    end
end