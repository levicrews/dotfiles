* Warm Cream color system. Matches ffloyd_colors.tex and the approved swatches.
* Categorical: swatch order. Sequential: low to high. Diverging: negative to zero to positive.
* Load with: do ffloyd_palette.do
* Native RGB strings work directly with graph color options.
* RGB syntax: https://www.stata.com/manuals/g-4colorstyle.pdf
* Example: scatter y x, mcolor("$ff_green") ///
*     graphregion(color("$ff_background")) ///
*     plotregion(color("$ff_background")) ///
*     xlabel(, labcolor("$ff_text")) ylabel(, labcolor("$ff_text"))
* For colorstyle lists: mcolor($ff_categorical)
* This file defines globals only; it does not change data or the graph scheme.

global ff_background "237 232 217" // #EDE8D9
global ff_text "37 96 111" // #25606F
global ff_heading "22 76 103" // #164C67
global ff_link "22 76 103" // #164C67
global ff_ink "20 44 85" // #142C55
global ff_border "158 178 155" // #9EB29B
global ff_separator "115 152 136" // #739888
global ff_bullet "86 134 126" // #56867E
global ff_yellow "203 138 40" // #CB8A28
global ff_green "0 132 100" // #008464
global ff_blue "66 126 175" // #427EAF
global ff_terracotta "192 91 67" // #C05B43
global ff_violet "120 100 160" // #7864A0
global ff_rose "180 86 124" // #B4567C
global ff_olive "120 130 56" // #788238
global ff_deep_blue "22 76 103" // #164C67
global ff_cat_1 "203 138 40" // #CB8A28
global ff_cat_2 "0 132 100" // #008464
global ff_cat_3 "66 126 175" // #427EAF
global ff_cat_4 "192 91 67" // #C05B43
global ff_cat_5 "120 100 160" // #7864A0
global ff_cat_6 "180 86 124" // #B4567C
global ff_cat_7 "120 130 56" // #788238
global ff_cat_8 "22 76 103" // #164C67
global ff_seq_1 "235 212 149" // #EBD495
global ff_seq_2 "194 193 111" // #C2C16F
global ff_seq_3 "134 178 110" // #86B26E
global ff_seq_4 "62 159 119" // #3E9F77
global ff_seq_5 "28 132 124" // #1C847C
global ff_seq_6 "15 103 121" // #0F6779
global ff_seq_7 "22 76 103" // #164C67
global ff_div_neg_4 "110 50 35" // #6E3223
global ff_div_neg_3 "169 76 46" // #A94C2E
global ff_div_neg_2 "205 127 81" // #CD7F51
global ff_div_neg_1 "221 188 149" // #DDBC95
global ff_div_zero "244 240 228" // #F4F0E4
global ff_div_pos_1 "166 203 199" // #A6CBC7
global ff_div_pos_2 "94 162 168" // #5EA2A8
global ff_div_pos_3 "33 119 141" // #21778D
global ff_div_pos_4 "22 76 103" // #164C67

* Quoted RGB colorstyle lists, in the same order as the other exports.
global ff_categorical `""$ff_cat_1" "$ff_cat_2" "$ff_cat_3" "$ff_cat_4" "$ff_cat_5" "$ff_cat_6" "$ff_cat_7" "$ff_cat_8""'
global ff_sequential `""$ff_seq_1" "$ff_seq_2" "$ff_seq_3" "$ff_seq_4" "$ff_seq_5" "$ff_seq_6" "$ff_seq_7""'
global ff_diverging `""$ff_div_neg_4" "$ff_div_neg_3" "$ff_div_neg_2" "$ff_div_neg_1" "$ff_div_zero" "$ff_div_pos_1" "$ff_div_pos_2" "$ff_div_pos_3" "$ff_div_pos_4""'
