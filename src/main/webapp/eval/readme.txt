AutoEval�������ͬѧ��д�����ܣ�

����������ָ�꣺
BLEU5-SBP	BLEU5	BLEU6	NIST6	NIST7	GTM	mWER	mPER	ICT	METEOR	TER
���⺺��

ע�⣺
1. TERָ�꣺��Ϊ��������Ե�ʣ�������Linux�²��ԣ���׼ȷ��
2. Meteorָ�꣺����ܵ���������Դ����ͬ��ʵȣ���Ч������ã�Ŀǰ��Ӣ�Ŀ��Ե���������Դ���⵽����û����Դ�ɵ��ã�
3. ����TER��METEOR��صĳ�����Windows��Linux��ͨ�ã���autoeval.py������Windows��Linux��������
4. 2013���޸��˲��Գ�������һ���ǣ������Զ����⺺�Ĳο����Ľ�����A2Bת������������ĵ�ת��һ���ˣ���

ʹ��˵��:
InputData����Ҫ�ļ���
    --->InputData
         |-->*ref*.xml    (�ο���)
         |-->*src*.xml    (real src)
         |-->*primary*.xml (��ϵͳ�ύ�����
         |-->*contrast*.xml        (�Ա�ϵͳ�ύ���)
         |-->realSegID.txt
(�ο��𰸡����Լ�DOC��ǩ�±���������sysid)

������windows�����£���ҪԤ�Ȱ�װperl,python
�뱣��ԭ��Ŀ¼�ṹ
���python AutoEval.py ���뷽�� InputData\
���з��뷽�����Ϊ��
    1. zh-en-news 
    2. en-zh-news
    3. en-zh-scie
    4. jp-zh-news
    5. mn-zh-dail
    6. ti-zh-gove
    7. uy-zh-news
    8. ka-zh-news
    9. ki-zh-news
������������OutputData***�ļ����С������������й��̵��м��ļ��Լ������������ļ���

ע�⣺�ļ����ڵ�·�����κ��ļ�/Ŀ¼���в����пո�����ģ�