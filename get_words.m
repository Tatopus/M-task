function [nagative, neutral] = get_words ()
    nagative = importdata("負面字詞.txt")
    neutral = importdata("中性字詞.txt")
end