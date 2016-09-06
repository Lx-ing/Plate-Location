function [x,y,width,height,flag] = posCalculation(varargin)
%�������ܣ������Ƿ��г�������
%�����������ֵ�߼�ͼ��ͼ���е���ɫ��Ե��
%���ز�����flag-�Ƿ���ͼ�������У���(x,y,width,height)Ϊͼ���Ӧ�ľ�������
    %����ͶӰֵ
    lineW = sum(varargin{1},1);
    lineW = imfilter(lineW,ones(1,3)/3,'replicate');
    lineH = sum(varargin{1},2);
    lineH = imfilter(lineH,ones(3,1)/3,'replicate');
    %Ĭ��ֵ
    flag = 0;
    x = 0;
    y = 0;
    width = length(lineW);
    height = length(lineH);
    
    %�����������
    %����ನ�������Ƿ���������
    [X1,IND] = findpeaks(lineW,'minpeakdistance',ceil(length(lineW) / 20));
    X2 = sort(X1);
    if length(X2) < 5 return;end
    TH = X2(end - 2) * 0.2;
    X2 = find(X1 > TH); %X1(X2(i))��IND(X2(i))�����Ӧ��ֵ�Ĵ�С��λ��
    if length(X2) < 5 return;end
    %��ȡ��������
    X2 = IND(X2);
    
	%���ݲ���λ�ã������������������
    begin = 1;
    finish = 2;
    step_last = X2(2) - X2(1);
    L = zeros(length(X2),3);
    L(1,1) = 1;
    m = 1;
    for i=3:1:length(X2)
        if i - 1 == L(m,1) 
            continue;
        end
        avr = (X2(i-1) - X2(L(m,1))) / (i - 1 - L(m,1));
        step_last = X2(i-1) - X2(i-2);
        step = X2(i) - X2(i-1);
        if step / step_last > 0.5 & step / step_last < 2 & step / avr < 2
            finish = i;
            if finish == length(X2) & begin < finish
                L(m,2) = finish;
                L(m,3) = finish - begin + 1;
            end
        else
            L(m,2) = finish;
            L(m,3) = finish - begin + 1;
            m = m + 1;
            L(m,1) = i;
            begin = i;
            finish = i;
        end
    end
    K = sortrows(L,-3);
    if ~(K(1,3) > 5 | (K(1,3)+K(2,3) > 5 & ((K(1,1)-K(2,2) == 1) | (K(2,1) - K(1,2) == 1)))) %�����ж�������˴�����ȡ�������������
        return;
    end
    
	%�������������������
    begin = X2(K(1,1)); %��ȡ�����Ŀ�ʼ������λ��
    finish = X2(K(1,2));
    X3 = find(lineW > TH);
    x = 1;
    for i=begin:-1:1
        if lineW(i) < TH * 0.1 & i < X3(3)
            x = i;
            break;
        end
    end
    width = length(lineW) - x;
    for i=finish:1:length(lineW)
        if lineW(i) < TH * 0.1 & i > X3(end)
            width = i - x;
            break;
        end
    end
    if width < 0.25 * length(lineW) return;end
    
    %������������
    TH = max(lineH) * 0.01;
    [MAX,index] = max(lineH);
    X1 = find(lineH > max(lineH) * 0.1);
    y = 1;
    for i=index:-1:1
        if  lineH(i) < TH & i < X1(1)
            y = i;
            break;
        end
    end
    height = length(lineH) - y;
    for i=index:1:length(lineH)
        if  lineH(i) < TH & i > X1(end)
            height = i - y;
            break;
        end
    end
    if height < 0.25 * length(lineH) return;end
    
    %�ʵ��ſ�Χ��ȷ����������©
    if x > 0 & y > 0 & width >= 40 & height >= 20 & 0.6 < width / height & width / height < 6
        flag = 1;
	end
    
end

