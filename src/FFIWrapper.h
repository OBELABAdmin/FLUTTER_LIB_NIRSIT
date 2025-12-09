#ifndef __FFIWrapper__
#define __FFIWrapper__

#include <vector>

// C++ 코드 내에서 C 스타일의 함수 링크를 보장하기 위한 extern "C" 블록
#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief getGainSNR의 반환값을 담는 구조체 (int 배열 2개)
 */
struct GainSNRResult {
    int* data_780;
    int  length_780;
    int* data_850;
    int  length_850;
};

/**
 * @brief double 배열 1개를 반환하기 위한 구조체
 */
struct DoubleArrayResult {
    double* data;
    int     length;
};

/**
 * @brief int 배열 1개를 반환하기 위한 구조체
 */
struct IntArrayResult {
    int* data;
    int  length;
};


// --- 2. Export 함수 선언 ---

// 테스트 함수
double testDouble();

// 초기화 및 설정 함수
void initialized(int protocolType);
void clear();
void clearRecentData();
void initChannelRejectFlag();
void setDSPOption(unsigned char option); // jchar가 아닌 unsigned char
void setPDGainIndex(char* idxdata);     // jcharArray가 아닌 char*
void setSnrLimit(int snrLimit);

// 데이터 처리 함수 (입력)
void measureRawData(double* rawdata);
void measure(double* rawdata_780, double* rawdata_850);
void calibrationRawData(double* rawdata);
void calibration(double* rawdata_780, double* rawdata_850);
void addSNRRecentData();
void snrCalculation(int snrLimit);

// 데이터 반환 함수 (Struct 반환)
GainSNRResult     getGainSNR();
DoubleArrayResult getHbO2();
DoubleArrayResult getHbR();
IntArrayResult    getRSO2();

// 메모리 해제 함수 (필수)
void freeGainSNRData(GainSNRResult result);
void freeDoubleArrayResult(DoubleArrayResult result);
void freeIntArrayResult(IntArrayResult result);


#ifdef __cplusplus
}
#endif

#endif //__FFIWrapper__