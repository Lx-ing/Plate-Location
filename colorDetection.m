function Block = colorDetection(varargin)
%�������ܣ����ͼ�����ض���ɫ������
%���������
%��һ������-������RGBͼ��
%�ڶ�������-�������ɫ��1Ϊ��ɫ��2Ϊ��ɫ
%����������-�������(area)���Ƿ�����(edge)
%���ĸ�����-���ʱ���ǰ���(day)����ҹ��(nig)
%���������Block-��ֵͼ��ͼ����ֵΪ1�ĵ��Ӧ��Ӧɫ��
	
    %��ʽת��
    f = im2double(varargin{1}); 
    f = rgb2hsv(f);
    
    %ת��ΪHSV�ռ�
    H = f(:,:,1) * 360;
    S = f(:,:,2);
    V = f(:,:,3);
    [M,N]=size(H);

    %��ɫɸѡ
    colour = varargin{2};
    choice = varargin{3};
    time = varargin{4};
    if time == 'day' %�������
        if choice == 'area' %�������
            switch colour
                case 1
                    H1 = ones(M,N) * 240;
                    S1 = ones(M,N);
                    V1 = ones(M,N);
                    D = (S.*cos(H*pi/180) - S1.*cos(H1*pi/180)).^2 + (S.*(sin(H*pi/180)) - S1.*sin(H1*pi/180)).^2 + (V - V1).^2;
                    Block = (1 - sqrt(D) / sqrt(5)) > 0.6 & S > 0.2 & V > 0.3;
            end
        else	%���������
            switch colour	
                case 1
                    H1 = ones(M,N) * 240;
                    S1 = ones(M,N);
                    V1 = ones(M,N);
                    D = (S.*cos(H*pi/180) - S1.*cos(H1*pi/180)).^2 + (S.*(sin(H*pi/180)) - S1.*sin(H1*pi/180)).^2 + (V - V1).^2;
                    Block = (1 - sqrt(D) / sqrt(5)) > 0.65 & S > 0.25 & V > 0.35;
                case 2
                    Block = S < 0.3 & V > 0.7;
            end
        end
    else            %ҹ�����
        if choice == 'area' %�������
            switch colour
                case 1
                    H1 = ones(M,N) * 240;
                    S1 = ones(M,N);
                    V1 = ones(M,N);
                    D = (S.*cos(H*pi/180) - S1.*cos(H1*pi/180)).^2 + (S.*(sin(H*pi/180)) - S1.*sin(H1*pi/180)).^2 + (V - V1).^2;
                    Block = (1 - sqrt(D) / sqrt(5)) > 0.55 & S > 0.2;
            end
        else	%���������
            switch colour
                case 1
                    H1 = ones(M,N) * 240;
                    S1 = ones(M,N);
                    V1 = ones(M,N);
                    D = (S.*cos(H*pi/180) - S1.*cos(H1*pi/180)).^2 + (S.*(sin(H*pi/180)) - S1.*sin(H1*pi/180)).^2 + (V - V1).^2;
                    Block = (1 - sqrt(D) / sqrt(5)) > 0.55 & S > 0.2;
                case 2
                    Block = S < 0.3 & V > 0.7;
            end
        end
    end
    
    %�Ƿ���Ҫ�������
    if choice == 'area'
		%��̬ѧ������ɾ��С���򣬽������ͣ���ɾ��һ�β����������
        Block = bwareaopen(Block,50);
        
        a = ceil(N / 50);
        p = ones(1,a);
        Block = imdilate(Block,p);
        
        Block = bwareaopen(Block,ceil(M*N / 2500));
    end
end

