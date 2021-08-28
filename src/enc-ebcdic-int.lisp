(in-package #:babel-encodings)

(define-character-encoding :ebcdic-international
    "An 8-bit, fixed-width character encoding from IBM.")

(define-constant +ebcdic-int-to-unicode+
  #(   0    1    2    3  156    9  134  127  151  141  142   11   12   13   14   15
      16   17   18   19  157  133    8  135   24   25  146  143   28   29   30   31
     128  129  130  nil  132   10   23   27  nil  nil  138  139  nil    5    6    7
     nil  nil   22  nil  148  149  150    4  nil  nil  nil  155   20   21  nil   26
      32  nil  nil  nil  nil  nil  nil  nil  nil  nil   91   46   60   40   43   33
      38  nil  nil  nil  nil  nil  nil  nil  nil  nil   93  164   42   41   59  172
      45   47  nil  nil  nil  nil  nil  nil  nil  nil  124   44   37   95   62   63
     nil  nil  nil  nil  nil  nil 1102 1072 1073   96   58   35   64   39   61   34
    1094   97   98   99  100  101  102  103  104  105 1076 1077 1092 1075 1093 1080
    1081  106  107  108  109  110  111  112  113  114 1082 1083 1084 1085 1086 1087
    1103  126  115  116  117  118  119  120  121  122 1088 1089 1090 1091 1078 1074
    1100 1099 1079 1096 1101 1097 1095 1098 1070 1040 1041 1062 1044 1045 1060 1043
     123   65   66   67   68   69   70   71   72   73 1061 1048 1049 1050 1051 1052
     125   74   75   76   77   78   79   80   81   82 1053 1054 1055 1071 1056 1057
      92  nil   83   84   85   86   87   88   89   90 1058 1059 1046 1042 1068 1067
      48   49   50   51   52   53   54   55   56   57 1047 1064 1069 1065 1063 159)
  :test #'equalp)

(define-constant +unicode-upto-ac-ebcdic-int+
  #(  0   1   2   3  55  45  46  47  22   5  37  11  12  13  14  15
     16  17  18  19  60  61  50  38  24  25  63  39  28  29  30  31
     64  79 127 123 nil 108  80 125  77  93  92  78 107  96  75  97
    240 241 242 243 244 245 246 247 248 249 122  94  76 126 110 111
    124 193 194 195 196 197 198 199 200 201 209 210 211 212 213 214
    215 216 217 226 227 228 229 230 231 232 233  74 224  90 nil 109
    121 129 130 131 132 133 134 135 136 137 145 146 147 148 149 150
    151 152 153 162 163 164 165 166 167 168 169 192 106 208 161   7
     32  33  34 nil  36  21   6  23 nil nil  42  43 nil   9  10  27
    nil nil  26 nil  52  53  54   8 nil nil nil  59   4  20 nil 255
    nil nil nil nil  91 nil nil nil nil nil nil nil  95)
  :test #'equalp)

(define-constant +unicode-0410-0450-ebcdic-int+
  #(185 186 237 191 188 189 236 250 203 204 205 206 207 218 219 220 222 223 234
    235 190 202 187 254 251 253 nil 239 238 252 184 221 119 120 175 141 138 139
    174 178 143 144 154 155 156 157 158 159 170 171 172 173 140 142 128 182 179
    181 183 177 176 180 118 160)
  :test #'equalp)

(define-unibyte-decoder :ebcdic-international (octet)
  (or (svref +ebcdic-int-to-unicode+ (the ub8 octet))
      (handle-error)))

(define-unibyte-encoder :ebcdic-international (code)
  (or (cond
        ((<= code #xAC)
         (svref +unicode-upto-ac-ebcdic-int+ code))
        ((<= #x0410 code #x0450)
         (svref +unicode-0410-0450-ebcdic-int+ (- code #x0410))))
      (handle-error)))
