file_path =  'G:\\code\\matlab\\recogniziton\\Blue\\';% ͼ���ļ���·��
img_path_list = dir(strcat(file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������
if img_num > 0 %������������ͼ��
        for j = 1:img_num %��һ��ȡͼ��
            %ʶ��ͼ��
            image_name = img_path_list(j).name;% ͼ����
            if length(image_name) >= 10
                delete(image_name);
            end
        end
end