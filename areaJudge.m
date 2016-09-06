function [Area,m] = areaJudge(S,num) 
%�������ܣ��������Ƿ���ܴ��ڳ��ƽ����жϣ������Ƶ������������鲢
%���������num-��������S-ʹ��regionprops��õ��������ݽṹ��
%���ز�����m-��������Area-����ľ������ݶ�ά���飬ÿά���ĸ����ݴ���һ�����ݣ�x,y,width,height��

	%����������С�����
    if num < 1 
        m = 0;
        Area = [0 0 0 0];
        return;
    end
    Area = zeros(num,4);
    if num == 1
        m = 1;
        Area(1,:) = S(1,1).BoundingBox;
        return;
    end
    
	%���������϶࣬�ȴ����һ�����Ӻ�����ʼ����
    m = 1;
    Area(1,1) = S(1,1).BoundingBox(1);
    Area(1,2) = S(1,1).BoundingBox(2);
    Area(1,3) = S(1,1).BoundingBox(3) + S(1,1).BoundingBox(1);
    Area(1,4) = S(1,1).BoundingBox(4) + S(1,1).BoundingBox(2);
    for i=2:num
        rec = S(i,1).BoundingBox;
        rec(3) = rec(1) + rec(3);
        rec(4) = rec(2) + rec(4);
        flag = 0;	%������¼�����Ƿ񱻴���
        %����鲢
        for j=1:m
%           �����������ϵ���򲻿��ǹ��������
%             if rec(1) > Area(j,1) & rec(2) > Area(j,2) & rec(3) < Area(j,3) & rec(4) < Area(j,4) 
%                if rec(3)-rec(1) > 100 & rec(4)-rec(2) > 50 & (rec(3)-rec(1)) / (rec(4)-rec(2)) > 1.2 & (rec(3)-rec(1)) / (rec(4)-rec(2)) < 6
%                    flag = 1;
%                    Area(j,:) = rec;
%                end
%             elseif rec(1) < Area(j,1) & rec(2) < Area(j,2) & rec(3) < Area(j,3) & rec(4) < Area(j,4)
%                if Area(j,3)-Area(j,1) > 100 & Area(j,4)-Area(j,2) > 50 & (Area(j,3)-Area(j,1)) / (Area(j,4)-Area(j,2)) > 1.2 &  (Area(j,3)-Area(j,1)) / (Area(j,4)-Area(j,2)) < 6
%                    flag = 1;
%                end
               
               
            %���������ƶȸߣ�����й鲢
            if ~(rec(4)<Area(j,2) | rec(2)>Area(j,4)) 
                if rec(2) > Area(j,2) & rec(4) < Area(j,4) 	%���㴹ֱ������غϿ��
                    overlay = rec(4) - rec(2);
                elseif rec(2) < Area(j,2) & rec(4) > Area(j,4)
                    overlay = Area(j,4) - Area(j,2);
                else
                    overlay = min(abs(Area(j,4)-rec(2)),abs(Area(j,2)-rec(4)));
                end
                
                distance = max(Area(j,1)-rec(3),rec(1)-Area(j,3));	%ˮƽ����
                k1 = (rec(3)-rec(1)) / (rec(4)-rec(2));
                k2 = (Area(j,3)-Area(j,1)) / (Area(j,4)-Area(j,2));
				%�鲢�����������ºϲ�Ϊһ������
                if overlay/(rec(4)-rec(2)) > 0.8 & overlay/(Area(j,4)-Area(j,2)) > 0.8 & distance < min(min((rec(3)-rec(1)),(Area(j,3)-Area(j,1))),30) * 1.5 & (k1 < 1.5 | k2 < 1.5)
                    flag = 1;
                    Area(j,1) = min(Area(j,1),rec(1));
                    Area(j,2) = min(Area(j,2),rec(2));
                    Area(j,3) = max(Area(j,3),rec(3));
                    Area(j,4) = max(Area(j,4),rec(4));
                end
           end
        end
        
		%������鲢�����ҳ���Ⱥ������������
        if flag == 0 & rec(3)-rec(1) > 40 & rec(4)-rec(2) > 12
            m = m+1;
            Area(m,:) = rec;
        end
    end
	
	%����ת����(x,y,width,height)�ĸ�ʽ
    Area(:,3) = Area(:,3) - Area(:,1);
    Area(:,4) = Area(:,4) - Area(:,2);
end