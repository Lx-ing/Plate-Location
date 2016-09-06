function j = bbww( varargin )
%�������ܣ�blue-background-white-writings������ͼ�������װ��ֵĳ��Ƶ����������������������
%�����������һ������ΪͼƬ���ƣ��ڶ�������Ϊ��ʼ�ĳ�������
%���������j�������װ��ֵĳ�������
    %��ȡͼ��
    f = imread(varargin{1});
    
    %��ȡ��ɫ����
    [Blue,temp] = colorDetection(f,1,'area','day');
    [L,num] = bwlabel(Blue,8);
    S = regionprops(L,'basic');
    [S,num] = areaJudge(S,num);

    j = 0; %j = varargin{2}
    for i=1:num
        rec = S(i,:);
        temp = imcrop(f,rec);
        [conveximage,flag] = isPlate(temp,'day'); %��һ���жϳ����Ƿ��г���
        if flag == 0 continue;end
       
        
        %�����ɫ����Ե�㡢ȡ��ɫ��Ե��
        Blue = colorDetection(temp,1,'edge','day');
        edge = colorLP(temp);
        junction = Blue & edge & conveximage;
		%���㳵������
        [x,y,width,height,flag] = posCalculation(junction);


        %�����ƴ��ڣ����ʵ��ſ���ֵ�����ͼ��
        if  flag == 1
            if width < 500 || height < 250
                x = x - width * 0.2;
                width = width * 1.4;
                y = y - height * 0.1;
                height = height * 1.2;
            else
                x = x - width * 0.1;
                width = width * 1.2;
                y = y - height * 0.1;
                height = height * 1.2;
            end
            j = j + 1;
            rec(1) = rec(1) + x;
            rec(2) = rec(2) + y;
            rec(3) = width;
            rec(4) = height;
            temp = imcrop(f,rec);
            name = [varargin{1}(1:4),'_0',num2str(j),'.jpg'];
            imwrite(temp,name,'jpg');
        end
    end
    
    %��δ��⵽���ƣ��������ɫ������ҹ����
    if j == 0
		%ʹ��retinex�㷨����������ͬ����
        f = retinex(f);
        
        %��ȡ��ɫ����
        [Blue,temp] = colorDetection(f,1,'area','nig');
        [L,num] = bwlabel(Blue,8);
        S = regionprops(L,'basic');
        [S,num] = areaJudge(S,num);
        for i=1:num
            rec = S(i,:);
            temp = imcrop(f,rec);
            [conveximage,flag] = isPlate(temp,'nig');
            if flag == 0 continue;end

            %�����ɫ����ɫ����Ե��
            Blue = colorDetection(temp,1,'edge','nig');
            edge = colorLP(temp);

            junction = Blue & edge & conveximage;
            [x,y,width,height,flag] = posCalculation(junction);
            temp = imcrop(f,[x y width height]);


            %�����ƴ��ڣ����ʵ��ſ���ֵ�����ͼ��
            if  flag == 1
                if width < 500 || height < 250
                    x = x - width * 0.2;
                    width = width * 1.4;
                    y = y - height * 0.1;
                    height = height * 1.2;
                else
                    x = x - width * 0.1;
                    width = width * 1.2;
                    y = y - height * 0.1;
                    height = height * 1.2;
                end
                j = j + 1;
                rec(1) = rec(1) + x;
                rec(2) = rec(2) + y;
                rec(3) = width;
                rec(4) = height;
                temp = imcrop(f,rec);
                name = [varargin{1}(1:4),'_0',num2str(j),'.jpg'];
                imwrite(temp,name,'jpg');
            end
        end
    end
end

