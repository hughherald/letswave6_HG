function GLW_test
clc;
f=0.1;
t=linspace(0,1,1000);
y=sin(2*pi*f*t);
last_axis=[0,1,0,1];
handles = createGUI;

    function handles = createGUI
        handles.fig1 =figure('CloseRequestFcn',@fig1_CloseReq_Callback,'WindowButtonMotionFcn',@fig1_BtnMotion);
        set(handles.fig1,'Resize','off');
        set(handles.fig1,'position',[100,200,300,480]);
        set(handles.fig1,'MenuBar','none');
        
        uicontrol(handles.fig1,'style','text','Units','pixels','Position',[10,450,20, 20],'String', 'x:');
        handles.x1=uicontrol(handles.fig1,'style','edit','Callback',@fig1_axis_changed_Callback,'Units','pixels','Position',[40,450,50, 20],'String', num2str(last_axis(1)));
        handles.x2=uicontrol(handles.fig1,'style','edit','Callback',@fig1_axis_changed_Callback,'Units','pixels','Position',[100,450,50, 20],'String', num2str(last_axis(2)));
        
        uicontrol(handles.fig1,'style','text','Units','pixels','Position',[10,420,20, 20],'String', 'y:');
        handles.y1=uicontrol(handles.fig1,'style','edit','Callback',@fig1_axis_changed_Callback,'Units','pixels','Position',[40,420,50, 20],'String', num2str(last_axis(3)));
        handles.y2=uicontrol(handles.fig1,'style','edit','Callback',@fig1_axis_changed_Callback,'Units','pixels','Position',[100,420,50, 20],'String', num2str(last_axis(4)));
        
        
        handles.fig2 =figure('CloseRequestFcn',@fig2_CloseReq_Callback,'WindowButtonDownFcn',@fig2_BtnDown,'WindowButtonMotionFcn',@fig2_BtnMotion,'WindowButtonUpFcn',@fig2_BtnUp);
        set(handles.fig2,'DockControls','off');
        htoolbar = uitoolbar(handles.fig2);
        set(findall(handles.fig2,'ToolTipString','Save Figure'),'Parent',htoolbar);
        set(findall(handles.fig2,'ToolTipString','Zoom In'),'Parent',htoolbar);
        set(findall(handles.fig2,'ToolTipString','Zoom Out'),'Parent',htoolbar);
        set(findall(handles.fig2,'ToolTipString','Pan'),'Parent',htoolbar);
        set(handles.fig2,'MenuBar','none');
        
        set(handles.fig2,'position',[410,205,600,442]);
        handles.r(1)=subplot(1,2,1);
        hold on; grid on;box on;
        handles.plot_h(1)=plot(handles.r(1),t,y);
        handles.shade(1)=fill([0,10,10,0],[-1,-1,1,1],[0.8,0.8,0.8],'EdgeColor','None','FaceAlpha',0.3);
        handles.line_x(1)=plot([10,10],[-1,1],'k');
        axis([0,1,-1,1]);
        handles.text_x(1) = uicontrol('Style','text','String','1','FontSize',10,'ForegroundColor',[1,1,1],'BackgroundColor',[0,0,0]);
        handles.text_y(1) = uicontrol('Style','text','String','1','FontSize',10,'ForegroundColor',[0,0,0],'BackgroundColor',[0,0,0]);
        
        
        handles.r(2)=subplot(1,2,2);
        hold on; grid on;box on;
        handles.plot_h(2)=plot(handles.r(2),t,y);
        handles.shade(2)=fill([0,10,10,0],[-1,-1,1,1],[0.8,0.8,0.8],'EdgeColor','None','FaceAlpha',0.3);
        handles.line_x(2)=plot([10,10],[-1,1],'k');
        axis([0,1,-1,1]);
        handles.text_x(2) = uicontrol('Style','text','String','1','FontSize',10,'ForegroundColor',[1,1,1],'BackgroundColor',[0,0,0]);
        handles.text_y(2) = uicontrol('Style','text','String','1','FontSize',10,'ForegroundColor',[0,0,0],'BackgroundColor',[0,0,0]);
        
        set(handles.line_x,'Visible','off');
        
        handles.mouse_state=0;
        handles.shade_x1=10;
        handles.shade_x2=12;
        h = zoom;h.ActionPostCallback = @fig2_axis_changed_callback;
        h = pan; h.ActionPostCallback = @fig2_axis_changed_callback;
        
        last_axis(1:2)=get(handles.r(1),'XLim');
        last_axis(3:4)=get(handles.r(1),'YLim');
        set(handles.x1, 'String', num2str(last_axis(1)));
        set(handles.x2, 'String', num2str(last_axis(2)));
        set(handles.y1, 'String', num2str(last_axis(3)));
        set(handles.y2, 'String', num2str(last_axis(4)));
        set(handles.r,'XLim',last_axis(1:2));
        set(handles.r,'YLim',last_axis(3:4));
    end

    function fig2_axis_changed_callback(obj, event)
        last_axis(1:2) = get(event.Axes,'XLim');
        last_axis(3:4) = get(event.Axes,'YLim');
        set(handles.x1, 'String', num2str(last_axis(1)));
        set(handles.x2, 'String', num2str(last_axis(2)));
        set(handles.y1, 'String', num2str(last_axis(3)));
        set(handles.y2, 'String', num2str(last_axis(4)));
        set(handles.r,'XLim',last_axis(1:2));
        set(handles.r,'YLim',last_axis(3:4));
    end

    function fig1_axis_changed_Callback(obj, event)
        last_axis(1)=str2double(get(handles.x1, 'String'));
        last_axis(2)=str2double(get(handles.x2, 'String'));
        last_axis(3)=str2double(get(handles.y1, 'String'));
        last_axis(4)=str2double(get(handles.y2, 'String'));
        set(handles.r,'XLim',last_axis(1:2));
        set(handles.r,'YLim',last_axis(3:4));
    end

    function fig2_BtnDown(obj, event)
        temp = get(gca,'CurrentPoint');
        point1=temp(1,[1,2]);
        handles.shade_x1=point1(1);
        temp = get(gca,'XLim');
        if (handles.shade_x1>temp(1) && handles.shade_x1<temp(2))
            handles.mouse_state=1;
            set(handles.shade,'Visible','off');
        end
    end

    function fig2_BtnUp(obj, event)
        if(handles.mouse_state==1)
            temp = get(gca,'CurrentPoint');
            point1=temp(1,[1,2]);
            handles.shade_x2=point1(1);
            temp = get(gca,'XLim');
            if handles.shade_x2<temp(1)
                handles.shade_x2=temp(1);
            end
            if handles.shade_x2>temp(2)
                handles.shade_x2=temp(2);
            end
        end
        handles.mouse_state=0;
        set(handles.shade,'Visible','on');
    end

    function fig1_BtnMotion(obj, event)
        figure(handles.fig1);
    end

    function fig2_BtnMotion(obj, event)
        figure(handles.fig2);
        temp = get(gca,'CurrentPoint');
        point1=temp(1,[1,2]);
        if(handles.mouse_state==1)
            handles.shade_x2=point1(1);
            temp = get(gca,'XLim');
            if handles.shade_x2<temp(1)
                handles.shade_x2=temp(1);
            end
            if handles.shade_x2>temp(2)
                handles.shade_x2=temp(2);
            end
            fig2_DrawShade();
            set(handles.shade,'Visible','on');
            %set(handles.line_x,'Visible','off');
        end
        is_inaxis=0;
        for plot_num=1:2
            temp=get(handles.r(plot_num),'CurrentPoint');
            temp=temp(1,[1,2]);
            temp_xlim=get(handles.r(plot_num),'XLim');
            if(temp(1)-temp_xlim(1))*(temp(1)-temp_xlim(2))<0
                is_inaxis=1;
                break;
            end
        end
        if(is_inaxis==0)
            return;
        end
        set(handles.line_x,'XData',[temp(1),temp(1)]);
        set(handles.line_x,'Visible','on');
        for plot_num=1:2
            plot_x=get(handles.plot_h(plot_num),'XData');
            plot_y=get(handles.plot_h(plot_num),'YData');
            a=find(plot_x<temp(1),1,'last');
            b=find(plot_x>temp(1),1,'first');
            if isempty(a)||isempty(b)
            else
                plot_x=plot_x([a,b]);
                plot_y=plot_y([a,b]);
                temp(2)=plot_y(2)-(plot_y(2)-plot_y(1))/(plot_x(2)-plot_x(1))*(plot_x(2)-temp(1));
            end
            set(handles.r(plot_num),'Units','pixels');
            fig_pos=get(handles.r(plot_num),'Position');
            fig_xlim=get(handles.r(plot_num),'XLim');
            fig_ylim=get(handles.r(plot_num),'YLim');
            point_pos(1)=fig_pos(3)+fig_pos(1)-(fig_pos(3)+fig_pos(1)-fig_pos(1))/(fig_xlim(2)-fig_xlim(1))*(fig_xlim(2)-temp(1));
            point_pos(2)=fig_pos(4)+fig_pos(2)-(fig_pos(4)+fig_pos(2)-fig_pos(2))/(fig_ylim(2)-fig_ylim(1))*(fig_ylim(2)-temp(2));
            set(handles.r(plot_num),'Units','normalized');
            set(handles.text_x(plot_num),'String',num2str(temp(1,1)));
            set(handles.text_y(plot_num),'String',num2str(temp(1,2)));
            c1=get(handles.text_x(plot_num),'extent');
            c2=get(handles.text_y(plot_num),'extent');
            set(handles.text_y(plot_num),'BackgroundColor',get(handles.plot_h(plot_num),'Color'));
            
            c3=[point_pos(1)-c1(3)/2,fig_pos(2)-c1(4),c1(3),c1(4)-5];
            set(handles.text_x(plot_num),'Position',c3);
            c3=[fig_pos(1)-c1(3)-5,point_pos(2)-c1(4)/2,c1(3),c1(4)-5];
            set(handles.text_y(plot_num),'Position',c3);
            
            if isempty(a)||isempty(b)
                set(handles.text_y(plot_num),'Visible','off');
            else
                set(handles.text_y(plot_num),'Visible','on');
            end
        end
    end

    function fig2_DrawShade()
        temp = get(gca,'YLim');
        set(handles.shade,'XData',[handles.shade_x1,handles.shade_x2,handles.shade_x2,handles.shade_x1])
        set(handles.shade,'YData',[temp(1),temp(1),temp(2),temp(2)]);
    end

    function fig1_CloseReq_Callback(obj, event)
        closereq;
        if ishandle(handles.fig2)
            close(handles.fig2);
        end
    end

    function fig2_CloseReq_Callback(obj, event)
        closereq;
        if ishandle(handles.fig1)
            close(handles.fig1);
        end
    end
end
