file_path =  'G:\\code\\matlab\\recogniziton\\Blue\\';% ͼ���ļ���·��
img_path_list = dir(strcat(file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������
fid = fopen('plate.txt','a+');
a = 0;
if img_num > 0 %������������ͼ��
          for j = 1:img_num
              image_name = img_path_list(j).name;% ͼ����
              if length(image_name) > 8 continue;end
                    time = isDay(image_name);
                    if time == 0
                        a = a + 1;
                    end
               
%               fprintf(fid,'%06.4f',M);
%               fprintf(fid,'\r\n');
          end
end
fclose(fid);
clear file_path img_path_list img_num image_name Blue j%�������