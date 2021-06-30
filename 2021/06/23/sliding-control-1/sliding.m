a = 1; % 输出跟踪sin(at)
x1_0 = 3;
x2_0 = 0;

lambda = 1; % 滑模面斜率
eta = 2; % 收敛到滑模面的速度

sim('sliding_control')

writerObj=VideoWriter('Phase_trajectory_of_sliding_control.avi');  %// 定义一个视频文件用来存动画 % , 'Archival'
open(writerObj);                    %// 打开该视频文件
h = figure(1);
set(h, 'position',[100 100 500 500]);

for t = 1 : 5 : length(xd)
    % 滑模面
    xx = -5:5;
    plot(xx, -lambda*xx+(lambda*xd(t,1)+xd(t,2)) , '--', 'Color', [.5 .5 .5], 'Linewidth', 0.1)
    hold on
    % 跟踪目标轨迹
    plot(xd(  1     :t,1), xd(   1     :t,2) , '.-', 'Color', [1, 0.8, 0.8], 'Linewidth', 5)
    scatter( xd(t,1), xd(t,2) ,50 ,[1,0.5,0.5], 'o')
    
    % 实际状态轨迹
    plot(x(max(1,t-80):t,1), x(max(1,t-80):t,2) , 'black')
    % 状态
    scatter( x(t,1), x(t,2) , 100 , '.b')
    hold off
    
    grid on
    axis( 4*[-1, 1, -1, 1] )
    axis square
    set(gca, 'XTick', -4: 2 :4);
    set(gca, 'YTick', -4: 2 :4);
    xlabel('$$x_1$$','Interpreter','latex', 'fontsize', 16);
    ylabel('$$x_2$$','Interpreter','latex', 'fontsize', 16);
    
    pause(.01)

%% 把图像存入视频文件中
%     frame = print('-RGBImage');%     frame = getframe % 不够清晰
%     writeVideo(writerObj,frame); %// 将帧写入视频
    
end

close(writerObj); %// 关闭视频文件句柄

