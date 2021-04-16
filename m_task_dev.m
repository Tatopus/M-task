%2021/1/31 by Minyi Chen. aferse885201@gmail.com
%behavior condition=> 11 : negative word and key pressed.
%                     10 : negative word and no key pressed
%                     21 : neutral word and key pressed.
%                     20 : neutral word and no key pressed
%fwrite送trigger
clear; clc; 
[negative_words, neutral_words] = get_words();
negative_words = string(negative_words);
neutral_words = string(neutral_words);
time_rec=[];

neg_words_num = 35% # of negative word to be selected
neu_words_num = 15; % # of neutral words to be selected
word_onesection = neg_words_num + neu_words_num; %2021/04/16新增
weak_index = randperm(word_onesection); %2021/04/16修改
strong_index = randperm(word_onesection);%2021/04/16修改
p_negative = randperm(size(negative_words,1) - neg_words_num);%隨機生成 105個2021/04/16新增
p_negative = p_negative(1:neg_words_num);%2021/04/16新增
p_neutral = randperm( size(neutral_words,1) - neu_words_num);%隨機生成45個 2021/04/16新增
p_neutral = p_neutral(1:neu_words_num);%2021/04/16新增


count_neg = 0;
count_neu = 0;
neg_sel(1:size(negative_words,1)) = 0;
neu_sel(1:size(neutral_words,1)) = 0; 
beh_1 = []; %First task(weak stimul.) subject's behavior
beh_2 =[];  %Second task(strong stimul.) subject's behavior
trigger = []; %trigger sended=>  4: negative_weak; 5: negative_strong; 6:neutral_weak; 7: neutral_strong; 8: key press
correct_press = 0;
%%
% clear device
% 
% device_found = 0;
% ports = serialportlist("available");
% 
% for p = 1:length(ports)
%     device = serialport(ports(p),115200,"Timeout",1);
%     %In order to identify an XID device, you need to send it "_c1", to
%     %which it will respond with "_xid" followed by a protocol value. 0 is
%     %"XID", and we will not be covering other protocols.
%     device.flush()
%     write(device,"_c1","char")
%     query_return = read(device,5,"char");
%     if length(query_return) > 0 && query_return == "_xid0"
%         device_found = 1;
%         break
%     end
% end
% 
% if device_found == 0
%     disp("No XID device found. Exiting.")
%     return
% end
% disp("Raising all output lines for 1 second.")
% 
% setPulseDuration(device, 5)%ms
% 
% 
%%

config_display(0,5);%FULLSCREEN: 1 WINDOW_MODE: 0. config_display(1,5): full screen, res = 1280*1024;
config_keyboard; 
s_t=500   %stimuls time = 4000ms

start_cogent;
keymap = getkeymap;
settextstyle('新細明體', 60);
loadpict('grey.jpg',3);
drawpict(3);
preparestring('您好，閱讀完畢後按空白鍵繼續閱讀',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);

loadpict('grey.jpg',3);
drawpict(3);
preparestring('請選出35個和自己相關的負面詞',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);

loadpict('grey.jpg',3);
drawpict(3);
preparestring('選字請按 V; 不選請按 X',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);

loadpict('grey.jpg',3);
drawpict(3);
preparestring('準備好後請按空白鍵開始選詞(V：選 ; X：不選)',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);

% %選字，負面字(選的話按Ｖ，不選按X
i=0;
while count_neg < neg_words_num
    if i >= size(neg_sel,2)
        i = 1;
    else
        i=i+1;
    end
    correct_press = 0;
    clearpict(1);
    while correct_press ~= 1
      if neg_sel(i) ~= 1
            word = negative_words(i);
            word = convertStringsToChars(word);
            loadpict('grey.jpg',1);
            drawpict(1);
            preparestring(word,1);
            drawpict(1);
            [key,time,n]=waitkeydown(inf);

            if key == 24
                neg_sel(i) = 0;
                correct_press =1;
            elseif key == 22
                neg_sel(i) = 1;
                count_neg =count_neg + 1
                correct_press =1;
            else
                correct_press = 0;
                neg_sel(i) = 0;
            end
      else
          correct_press = 1;
       end
    end
end
negative_strong = negative_words(neg_sel == 1);
negative_weak_temp = negative_words(neg_sel == 0);%2021/04/16新增
negative_weak = negative_weak_temp(p_negative);%2021/04/16新增

loadpict('grey.jpg',3);
drawpict(3);
preparestring('請選出15個和自己相關的中性詞',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);

loadpict('grey.jpg',3);
drawpict(3);
preparestring('選字請按 V; 不選請按 X',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);

loadpict('grey.jpg',3);
drawpict(3);
preparestring('準備好後請按鍵空白鍵開始(V：選 ; X：不選)',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);
%選字，中性字(選的話按V，不選按X)
i=0;
while count_neu < neu_words_num
    if i >= size(neu_sel,2)
        i = 1;
    else
        i=i+1;
    end
    correct_press = 0;
    clearpict(1);
    while correct_press ~=1
        if neu_sel(i) ~= 1
            
            word = neutral_words(i);
            word = convertStringsToChars(word);
            loadpict('grey.jpg',1);
            drawpict(1);
            preparestring(word,1);
            drawpict(1);
            [key,t,n]=waitkeydown(inf);

            if key == 24
                neu_sel(i) = 0;
                correct_press = 1;
            elseif key == 22
                neu_sel(i) = 1;
                count_neu = count_neu + 1
                correct_press = 1;
            else
                neu_sel(i) = 0;
                correct_press = 0;
            end
        else 
            correct_press = 1;
        end
    end
end
neutral_sel = neutral_words(neu_sel == 1);
neutral_weak_temp = neutral_words(neu_sel == 0);%2021/04/16新增
neutral_weak = neutral_weak_temp(p_neutral); %2021/04/16新增

words_strong = [negative_strong;neutral_sel];
words_weak = [negative_weak; neutral_weak];
clearpict(4)

%選字結束開始實驗

preparestring('選詞結束，請按空白鍵繼續',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);
preparestring('準備開始實驗，看到負面字詞請按空白鍵',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);
preparestring('準備好後請按空白鍵開始實驗',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);



%prepare weak trigger
trigger_weak(weak_index < neg_words_num+1) = 4; %negative_weak;
trigger_weak(weak_index >= neg_words_num+1) = 6; %neutral
%prepare strong trigger
trigger_strong(strong_index < neg_words_num+1) = 5; %negative_strong;
trigger_strong(strong_index >= neg_words_num+1) = 7 ; %neutral;


%%
%實驗開始

for i = 1:word_onesection %2021/04/16修改
    clearpict(1);
    clearpict(2);
    
    word = words_weak(weak_index(i));
    word = convertStringsToChars(word);
    preparestring(word,1);
%     write(device,sprintf("mh%c%c", trigger_weak(i), 0), "char")
    trigger_weak(i)
    
    t1 = drawpict(1);
    waitkeydown(s_t - 200,71);
    [key,t,n] = getkeydown;
    if n >= 1
%         write(device,sprintf("mh%c%c", 8, 0), "char")
        a = 8
        temp = append(word,' V')
        preparestring(temp,2)
        clearpict(1)
        drawpict(2);
    end
    waituntil(t1 + s_t);

    

    if weak_index(i) < 36 %if it was a negative word
        if n >= 1 %if any key was pressed
            beh_1(i) = 11;
            
        else%
            beh_1(i) = 10;
        end
    else %if the word was a neutral word.
        if n >= 1 %if any key was pressed
            beh_1(i) = 21;
            
        else 
            beh_1(i) = 20;
        end
    end
    
end

%strong stimu.

for i = 1:word_onesection %2021/04/16修改
    clearpict(1);
    clearpict(2);
    word = words_strong(strong_index(i));
    word = convertStringsToChars(word);
    preparestring(word,1);

%     write(device,sprintf("mh%c%c", trigger_weak(i), 0), "char")
    trigger_weak(i)
    
    t1 = drawpict(1);
    waitkeydown(s_t - 200,71);
    [key,t,n] = getkeydown;
    if n >= 1
%         write(device,sprintf("mh%c%c", 8, 0), "char")
        temp = append(word,' V')
        preparestring(temp,2)
        clearpict(1)
        drawpict(2);
    end
    waituntil(t1 + s_t);
    

    if strong_index(i) < 36 %if the word was a negative word.
        if n >= 1 %if any key were pressed
            beh_2(i) = 11;
            
        else
            beh_2(i) = 10;
        end
    else %the word was a neutral word
        if n >= 1 %any key was pressed
            beh_2(i) = 21;
            
        else %沒按鍵
            beh_2(i) = 20;
        end
    end
end
preparestring('實驗結束，請按空白鍵退出',3);
drawpict(3);
waitkeydown(inf,71);
clearpict(3);
stop_cogent
%%
% save('C:\Users\VGH\Desktop\behavior_Data\behavior_weak.mat','beh_1')
% save('C:\Users\VGH\Desktop\behavior_Data\behavior_strong.mat','beh_2')
% save('C:\Users\VGH\Desktop\behavior_Data\negative_strong.mat','negative_strong')
% save('C:\Users\VGH\Desktop\behavior_Data\negative_weak.mat','negative_weak')
% save('C:\Users\VGH\Desktop\behavior_Data\neutral_strong.mat','neutral_sel')
% save('C:\Users\VGH\Desktop\behavior_Data\neutral_weak.mat','neutral_weak')
% save('C:\Users\VGH\Desktop\behavior_Data\words_strong.mat','words_strong')
% save('C:\Users\VGH\Desktop\behavior_Data\words_weak.mat','words_weak')
% save('C:\Users\VGH\Desktop\behavior_Data\strong_inex.mat','strong_index')
% save('C:\Users\VGH\Desktop\behavior_Data\weak_index.mat','weak_index')
% save('C:\Users\VGH\Desktop\behavior_Data\strong_trigger.mat','trigger_strong')
% save('C:\Users\VGH\Desktop\behavior_Data\weak_trigger.mat','trigger_weak')

%%
% clear device
% 
% function byte = getByte(val, index)
%     byte = bitand(bitshift(val,-8*(index-1)), 255); %indian encode(
% end
% 
% function setPulseDuration(device, duration)
% %mp sets the pulse duration on the XID device. The duration is a four byte
% %little-endian integer.(某種編碼)
%     write(device, sprintf("mp%c%c%c%c", getByte(duration,1),...
%         getByte(duration,2), getByte(duration,3),...
%         getByte(duration,4)), "char")
% end