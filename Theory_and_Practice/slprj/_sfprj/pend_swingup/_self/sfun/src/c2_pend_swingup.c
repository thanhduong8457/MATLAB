/* Include files */

#include "blascompat32.h"
#include "pend_swingup_sfun.h"
#include "c2_pend_swingup.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance.chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance.instanceNumber)
#include "pend_swingup_sfun_debug_macros.h"

/* Type Definitions */

/* Named Constants */
#define c2_IN_NO_ACTIVE_CHILD          (0)

/* Variable Declarations */

/* Variable Definitions */
static SFc2_pend_swingupInstanceStruct chartInstance;

/* Function Declarations */
static void initialize_c2_pend_swingup(void);
static void initialize_params_c2_pend_swingup(void);
static void enable_c2_pend_swingup(void);
static void disable_c2_pend_swingup(void);
static void c2_update_debugger_state_c2_pend_swingup(void);
static const mxArray *get_sim_state_c2_pend_swingup(void);
static void set_sim_state_c2_pend_swingup(const mxArray *c2_st);
static void finalize_c2_pend_swingup(void);
static void sf_c2_pend_swingup(void);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber);
static void c2_eml_scalar_eg(void);
static const mxArray *c2_sf_marshall(void *c2_chartInstance, void *c2_u);
static void c2_info_helper(c2_ResolvedFunctionInfo c2_info[42]);
static const mxArray *c2_b_sf_marshall(void *c2_chartInstance, void *c2_u);
static void init_dsm_address_info(void);

/* Function Definitions */
static void initialize_c2_pend_swingup(void)
{
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
  chartInstance.c2_is_active_c2_pend_swingup = 0U;
}

static void initialize_params_c2_pend_swingup(void)
{
}

static void enable_c2_pend_swingup(void)
{
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
}

static void disable_c2_pend_swingup(void)
{
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
}

static void c2_update_debugger_state_c2_pend_swingup(void)
{
}

static const mxArray *get_sim_state_c2_pend_swingup(void)
{
  const mxArray *c2_st = NULL;
  const mxArray *c2_y = NULL;
  real_T c2_u;
  const mxArray *c2_b_y = NULL;
  uint8_T c2_b_u;
  const mxArray *c2_c_y = NULL;
  real_T *c2_d_y;
  c2_d_y = (real_T *)ssGetOutputPortSignal(chartInstance.S, 1);
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellarray(2));
  c2_u = *c2_d_y;
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0));
  sf_mex_setcell(c2_y, 0, c2_b_y);
  c2_b_u = chartInstance.c2_is_active_c2_pend_swingup;
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_b_u, 3, 0U, 0U, 0U, 0));
  sf_mex_setcell(c2_y, 1, c2_c_y);
  sf_mex_assign(&c2_st, c2_y);
  return c2_st;
}

static void set_sim_state_c2_pend_swingup(const mxArray *c2_st)
{
  const mxArray *c2_u;
  const mxArray *c2_y;
  real_T c2_d0;
  real_T c2_b_y;
  const mxArray *c2_b_is_active_c2_pend_swingup;
  uint8_T c2_u0;
  uint8_T c2_c_y;
  real_T *c2_d_y;
  c2_d_y = (real_T *)ssGetOutputPortSignal(chartInstance.S, 1);
  chartInstance.c2_doneDoubleBufferReInit = true;
  c2_u = sf_mex_dup(c2_st);
  c2_y = sf_mex_dup(sf_mex_getcell(c2_u, 0));
  sf_mex_import("y", sf_mex_dup(c2_y), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_b_y = c2_d0;
  sf_mex_destroy(&c2_y);
  *c2_d_y = c2_b_y;
  c2_b_is_active_c2_pend_swingup = sf_mex_dup(sf_mex_getcell(c2_u, 1));
  sf_mex_import("is_active_c2_pend_swingup", sf_mex_dup
                (c2_b_is_active_c2_pend_swingup), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_c_y = c2_u0;
  sf_mex_destroy(&c2_b_is_active_c2_pend_swingup);
  chartInstance.c2_is_active_c2_pend_swingup = c2_c_y;
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_pend_swingup();
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_pend_swingup(void)
{
}

static void sf_c2_pend_swingup(void)
{
  int32_T c2_previousEvent;
  real_T c2_ang;
  real_T c2_vel;
  real_T c2_nargout = 1.0;
  real_T c2_nargin = 2.0;
  real_T c2_temp;
  real_T c2_y;
  real_T c2_x;
  real_T c2_xk;
  real_T c2_b_x;
  real_T c2_c_x;
  real_T c2_b;
  real_T c2_b_y;
  real_T c2_d_x;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_g_x;
  real_T c2_c_y;
  real_T c2_h_x;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_k_x;
  real_T c2_d_y;
  real_T c2_l_x;
  real_T c2_m_x;
  real_T c2_e_y;
  real_T *c2_f_y;
  real_T *c2_b_vel;
  real_T *c2_b_ang;
  c2_b_vel = (real_T *)ssGetInputPortSignal(chartInstance.S, 1);
  c2_f_y = (real_T *)ssGetOutputPortSignal(chartInstance.S, 1);
  c2_b_ang = (real_T *)ssGetInputPortSignal(chartInstance.S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG,0);
  _SFD_DATA_RANGE_CHECK(*c2_b_ang, 0U);
  _SFD_DATA_RANGE_CHECK(*c2_f_y, 1U);
  _SFD_DATA_RANGE_CHECK(*c2_b_vel, 2U);
  c2_previousEvent = _sfEvent_;
  _sfEvent_ = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG,0);
  c2_ang = *c2_b_ang;
  c2_vel = *c2_b_vel;
  sf_debug_symbol_scope_push(6U, 0U);
  sf_debug_symbol_scope_add("nargout", &c2_nargout, c2_sf_marshall);
  sf_debug_symbol_scope_add("nargin", &c2_nargin, c2_sf_marshall);
  sf_debug_symbol_scope_add("temp", &c2_temp, c2_sf_marshall);
  sf_debug_symbol_scope_add("y", &c2_y, c2_sf_marshall);
  sf_debug_symbol_scope_add("vel", &c2_vel, c2_sf_marshall);
  sf_debug_symbol_scope_add("ang", &c2_ang, c2_sf_marshall);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0,3);
  c2_x = c2_ang;
  c2_eml_scalar_eg();
  c2_xk = c2_x;
  c2_b_x = c2_xk;
  c2_eml_scalar_eg();
  c2_temp = c2_b_x / 6.2831853071795862E+000;
  c2_c_x = c2_temp;
  c2_b = muDoubleScalarAbs(c2_c_x);
  c2_b_y = 2.2204460492503131E-016 * c2_b;
  c2_d_x = c2_temp;
  c2_e_x = c2_d_x;
  c2_f_x = c2_e_x;
  if (c2_f_x < 0.0) {
    c2_e_x = muDoubleScalarCeil(c2_f_x - 0.5);
  } else {
    c2_e_x = muDoubleScalarFloor(c2_f_x + 0.5);
  }

  c2_g_x = c2_temp - c2_e_x;
  c2_c_y = muDoubleScalarAbs(c2_g_x);
  if (c2_c_y <= c2_b_y) {
    c2_temp = 0.0;
  } else {
    c2_h_x = c2_temp;
    c2_i_x = c2_h_x;
    c2_i_x = muDoubleScalarFloor(c2_i_x);
    c2_temp = (c2_temp - c2_i_x) * 6.2831853071795862E+000;
  }

  _SFD_EML_CALL(0,4);
  if (CV_EML_IF(0, 0, c2_temp > 3.1415926535897931E+000)) {
    _SFD_EML_CALL(0,5);
    c2_temp = c2_temp - 6.2831853071795862E+000;
  }

  _SFD_EML_CALL(0,8);
  c2_j_x = c2_temp;
  c2_k_x = c2_j_x;
  c2_d_y = muDoubleScalarAbs(c2_k_x);
  if (CV_EML_COND(0, 0, c2_d_y < 3.4906585039886590E-001)) {
    c2_l_x = c2_vel;
    c2_m_x = c2_l_x;
    c2_e_y = muDoubleScalarAbs(c2_m_x);
    if (CV_EML_COND(0, 1, c2_e_y < 6.2831853071795862E+000)) {
      CV_EML_MCDC(0, 0, true);
      CV_EML_IF(0, 1, true);
      _SFD_EML_CALL(0,9);
      c2_y = -1.0;
      goto label_1;
    }
  }

  CV_EML_MCDC(0, 0, false);
  CV_EML_IF(0, 1, false);
  _SFD_EML_CALL(0,11);
  c2_y = 1.0;
 label_1:
  ;
  _SFD_EML_CALL(0,-11);
  sf_debug_symbol_scope_pop();
  *c2_f_y = c2_y;
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG,0);
  _sfEvent_ = c2_previousEvent;
  sf_debug_check_for_state_inconsistency(_pend_swingupMachineNumber_,
    chartInstance.chartNumber, chartInstance.instanceNumber);
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber)
{
}

static void c2_eml_scalar_eg(void)
{
}

static const mxArray *c2_sf_marshall(void *c2_chartInstance, void *c2_u)
{
  const mxArray *c2_y = NULL;
  real_T c2_b_u;
  const mxArray *c2_b_y = NULL;
  c2_y = NULL;
  c2_b_u = *((real_T *)c2_u);
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_b_u, 0, 0U, 0U, 0U, 0));
  sf_mex_assign(&c2_y, c2_b_y);
  return c2_y;
}

const mxArray *sf_c2_pend_swingup_get_eml_resolved_functions_info(void)
{
  const mxArray *c2_nameCaptureInfo = NULL;
  c2_ResolvedFunctionInfo c2_info[42];
  const mxArray *c2_m0 = NULL;
  int32_T c2_i0;
  c2_ResolvedFunctionInfo *c2_r0;
  c2_nameCaptureInfo = NULL;
  c2_info_helper(c2_info);
  sf_mex_assign(&c2_m0, sf_mex_createstruct("nameCaptureInfo", 1, 42));
  for (c2_i0 = 0; c2_i0 < 42; c2_i0 = c2_i0 + 1) {
    c2_r0 = &c2_info[c2_i0];
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->context)), "context",
                    "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c2_r0->name)), "name",
                    "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c2_r0->dominantType)),
                    "dominantType", "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->resolved)), "resolved"
                    , "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileLength,
      7, 0U, 0U, 0U, 0), "fileLength", "nameCaptureInfo",
                    c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTime1, 7,
      0U, 0U, 0U, 0), "fileTime1", "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTime2, 7,
      0U, 0U, 0U, 0), "fileTime2", "nameCaptureInfo", c2_i0);
  }

  sf_mex_assign(&c2_nameCaptureInfo, c2_m0);
  return c2_nameCaptureInfo;
}

static void c2_info_helper(c2_ResolvedFunctionInfo c2_info[42])
{
  c2_info[0].context = "";
  c2_info[0].name = "pi";
  c2_info[0].dominantType = "";
  c2_info[0].resolved = "[B]pi";
  c2_info[0].fileLength = 0U;
  c2_info[0].fileTime1 = 0U;
  c2_info[0].fileTime2 = 0U;
  c2_info[1].context = "";
  c2_info[1].name = "mtimes";
  c2_info[1].dominantType = "double";
  c2_info[1].resolved = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[1].fileLength = 3302U;
  c2_info[1].fileTime1 = 1242732894U;
  c2_info[1].fileTime2 = 0U;
  c2_info[2].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[2].name = "nargin";
  c2_info[2].dominantType = "";
  c2_info[2].resolved = "[B]nargin";
  c2_info[2].fileLength = 0U;
  c2_info[2].fileTime1 = 0U;
  c2_info[2].fileTime2 = 0U;
  c2_info[3].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[3].name = "gt";
  c2_info[3].dominantType = "double";
  c2_info[3].resolved = "[B]gt";
  c2_info[3].fileLength = 0U;
  c2_info[3].fileTime1 = 0U;
  c2_info[3].fileTime2 = 0U;
  c2_info[4].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[4].name = "isa";
  c2_info[4].dominantType = "double";
  c2_info[4].resolved = "[B]isa";
  c2_info[4].fileLength = 0U;
  c2_info[4].fileTime1 = 0U;
  c2_info[4].fileTime2 = 0U;
  c2_info[5].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[5].name = "isinteger";
  c2_info[5].dominantType = "double";
  c2_info[5].resolved = "[B]isinteger";
  c2_info[5].fileLength = 0U;
  c2_info[5].fileTime1 = 0U;
  c2_info[5].fileTime2 = 0U;
  c2_info[6].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[6].name = "isscalar";
  c2_info[6].dominantType = "double";
  c2_info[6].resolved = "[B]isscalar";
  c2_info[6].fileLength = 0U;
  c2_info[6].fileTime1 = 0U;
  c2_info[6].fileTime2 = 0U;
  c2_info[7].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[7].name = "strcmp";
  c2_info[7].dominantType = "char";
  c2_info[7].resolved = "[B]strcmp";
  c2_info[7].fileLength = 0U;
  c2_info[7].fileTime1 = 0U;
  c2_info[7].fileTime2 = 0U;
  c2_info[8].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[8].name = "size";
  c2_info[8].dominantType = "double";
  c2_info[8].resolved = "[B]size";
  c2_info[8].fileLength = 0U;
  c2_info[8].fileTime1 = 0U;
  c2_info[8].fileTime2 = 0U;
  c2_info[9].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[9].name = "eq";
  c2_info[9].dominantType = "double";
  c2_info[9].resolved = "[B]eq";
  c2_info[9].fileLength = 0U;
  c2_info[9].fileTime1 = 0U;
  c2_info[9].fileTime2 = 0U;
  c2_info[10].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[10].name = "class";
  c2_info[10].dominantType = "double";
  c2_info[10].resolved = "[B]class";
  c2_info[10].fileLength = 0U;
  c2_info[10].fileTime1 = 0U;
  c2_info[10].fileTime2 = 0U;
  c2_info[11].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[11].name = "not";
  c2_info[11].dominantType = "logical";
  c2_info[11].resolved = "[B]not";
  c2_info[11].fileLength = 0U;
  c2_info[11].fileTime1 = 0U;
  c2_info[11].fileTime2 = 0U;
  c2_info[12].context = "";
  c2_info[12].name = "mod";
  c2_info[12].dominantType = "double";
  c2_info[12].resolved = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/mod.m";
  c2_info[12].fileLength = 960U;
  c2_info[12].fileTime1 = 1228072190U;
  c2_info[12].fileTime2 = 0U;
  c2_info[13].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/mod.m";
  c2_info[13].name = "isreal";
  c2_info[13].dominantType = "double";
  c2_info[13].resolved = "[B]isreal";
  c2_info[13].fileLength = 0U;
  c2_info[13].fileTime1 = 0U;
  c2_info[13].fileTime2 = 0U;
  c2_info[14].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/mod.m";
  c2_info[14].name = "eml_scalar_eg";
  c2_info[14].dominantType = "double";
  c2_info[14].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c2_info[14].fileLength = 3068U;
  c2_info[14].fileTime1 = 1240244010U;
  c2_info[14].fileTime2 = 0U;
  c2_info[15].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m/any_enums";
  c2_info[15].name = "false";
  c2_info[15].dominantType = "";
  c2_info[15].resolved = "[B]false";
  c2_info[15].fileLength = 0U;
  c2_info[15].fileTime1 = 0U;
  c2_info[15].fileTime2 = 0U;
  c2_info[16].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c2_info[16].name = "isstruct";
  c2_info[16].dominantType = "double";
  c2_info[16].resolved = "[B]isstruct";
  c2_info[16].fileLength = 0U;
  c2_info[16].fileTime1 = 0U;
  c2_info[16].fileTime2 = 0U;
  c2_info[17].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m/zerosum";
  c2_info[17].name = "cast";
  c2_info[17].dominantType = "double";
  c2_info[17].resolved = "[B]cast";
  c2_info[17].fileLength = 0U;
  c2_info[17].fileTime1 = 0U;
  c2_info[17].fileTime2 = 0U;
  c2_info[18].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m/zerosum";
  c2_info[18].name = "plus";
  c2_info[18].dominantType = "double";
  c2_info[18].resolved = "[B]plus";
  c2_info[18].fileLength = 0U;
  c2_info[18].fileTime1 = 0U;
  c2_info[18].fileTime2 = 0U;
  c2_info[19].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/mod.m";
  c2_info[19].name = "eml_scalexp_alloc";
  c2_info[19].dominantType = "double";
  c2_info[19].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m";
  c2_info[19].fileLength = 808U;
  c2_info[19].fileTime1 = 1230473100U;
  c2_info[19].fileTime2 = 0U;
  c2_info[20].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m";
  c2_info[20].name = "minus";
  c2_info[20].dominantType = "double";
  c2_info[20].resolved = "[B]minus";
  c2_info[20].fileLength = 0U;
  c2_info[20].fileTime1 = 0U;
  c2_info[20].fileTime2 = 0U;
  c2_info[21].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/mod.m";
  c2_info[21].name = "eml_scalar_mod";
  c2_info[21].dominantType = "double";
  c2_info[21].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[21].fileLength = 1103U;
  c2_info[21].fileTime1 = 1228072186U;
  c2_info[21].fileTime2 = 0U;
  c2_info[22].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[22].name = "eml_scalar_floor";
  c2_info[22].dominantType = "double";
  c2_info[22].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_floor.m";
  c2_info[22].fileLength = 260U;
  c2_info[22].fileTime1 = 1209312790U;
  c2_info[22].fileTime2 = 0U;
  c2_info[23].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[23].name = "times";
  c2_info[23].dominantType = "double";
  c2_info[23].resolved = "[B]times";
  c2_info[23].fileLength = 0U;
  c2_info[23].fileTime1 = 0U;
  c2_info[23].fileTime2 = 0U;
  c2_info[24].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[24].name = "eml_scalar_round";
  c2_info[24].dominantType = "double";
  c2_info[24].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_round.m";
  c2_info[24].fileLength = 523U;
  c2_info[24].fileTime1 = 1203426408U;
  c2_info[24].fileTime2 = 0U;
  c2_info[25].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_round.m";
  c2_info[25].name = "isfloat";
  c2_info[25].dominantType = "double";
  c2_info[25].resolved = "[B]isfloat";
  c2_info[25].fileLength = 0U;
  c2_info[25].fileTime1 = 0U;
  c2_info[25].fileTime2 = 0U;
  c2_info[26].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_round.m/scalar_round";
  c2_info[26].name = "lt";
  c2_info[26].dominantType = "double";
  c2_info[26].resolved = "[B]lt";
  c2_info[26].fileLength = 0U;
  c2_info[26].fileTime1 = 0U;
  c2_info[26].fileTime2 = 0U;
  c2_info[27].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[27].name = "eml_scalar_abs";
  c2_info[27].dominantType = "double";
  c2_info[27].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_abs.m";
  c2_info[27].fileLength = 461U;
  c2_info[27].fileTime1 = 1203426360U;
  c2_info[27].fileTime2 = 0U;
  c2_info[28].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_abs.m";
  c2_info[28].name = "ischar";
  c2_info[28].dominantType = "double";
  c2_info[28].resolved = "[B]ischar";
  c2_info[28].fileLength = 0U;
  c2_info[28].fileTime1 = 0U;
  c2_info[28].fileTime2 = 0U;
  c2_info[29].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_abs.m";
  c2_info[29].name = "islogical";
  c2_info[29].dominantType = "double";
  c2_info[29].resolved = "[B]islogical";
  c2_info[29].fileLength = 0U;
  c2_info[29].fileTime1 = 0U;
  c2_info[29].fileTime2 = 0U;
  c2_info[30].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[30].name = "eps";
  c2_info[30].dominantType = "char";
  c2_info[30].resolved = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elmat/eps.m";
  c2_info[30].fileLength = 1337U;
  c2_info[30].fileTime1 = 1228072200U;
  c2_info[30].fileTime2 = 0U;
  c2_info[31].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elmat/eps.m";
  c2_info[31].name = "eml_is_float_class";
  c2_info[31].dominantType = "char";
  c2_info[31].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_is_float_class.m";
  c2_info[31].fileLength = 226U;
  c2_info[31].fileTime1 = 1197828842U;
  c2_info[31].fileTime2 = 0U;
  c2_info[32].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elmat/eps.m";
  c2_info[32].name = "uminus";
  c2_info[32].dominantType = "double";
  c2_info[32].resolved = "[B]uminus";
  c2_info[32].fileLength = 0U;
  c2_info[32].fileTime1 = 0U;
  c2_info[32].fileTime2 = 0U;
  c2_info[33].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[33].name = "le";
  c2_info[33].dominantType = "double";
  c2_info[33].resolved = "[B]le";
  c2_info[33].fileLength = 0U;
  c2_info[33].fileTime1 = 0U;
  c2_info[33].fileTime2 = 0U;
  c2_info[34].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_mod.m";
  c2_info[34].name = "zeros";
  c2_info[34].dominantType = "char";
  c2_info[34].resolved = "[B]zeros";
  c2_info[34].fileLength = 0U;
  c2_info[34].fileTime1 = 0U;
  c2_info[34].fileTime2 = 0U;
  c2_info[35].context = "";
  c2_info[35].name = "abs";
  c2_info[35].dominantType = "double";
  c2_info[35].resolved = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m";
  c2_info[35].fileLength = 566U;
  c2_info[35].fileTime1 = 1221249134U;
  c2_info[35].fileTime2 = 0U;
  c2_info[36].context = "";
  c2_info[36].name = "mrdivide";
  c2_info[36].dominantType = "double";
  c2_info[36].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.m";
  c2_info[36].fileLength = 800U;
  c2_info[36].fileTime1 = 1238416292U;
  c2_info[36].fileTime2 = 0U;
  c2_info[37].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.m";
  c2_info[37].name = "ge";
  c2_info[37].dominantType = "double";
  c2_info[37].resolved = "[B]ge";
  c2_info[37].fileLength = 0U;
  c2_info[37].fileTime1 = 0U;
  c2_info[37].fileTime2 = 0U;
  c2_info[38].context =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.m";
  c2_info[38].name = "rdivide";
  c2_info[38].dominantType = "double";
  c2_info[38].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[38].fileLength = 620U;
  c2_info[38].fileTime1 = 1213908766U;
  c2_info[38].fileTime2 = 0U;
  c2_info[39].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[39].name = "isempty";
  c2_info[39].dominantType = "double";
  c2_info[39].resolved = "[B]isempty";
  c2_info[39].fileLength = 0U;
  c2_info[39].fileTime1 = 0U;
  c2_info[39].fileTime2 = 0U;
  c2_info[40].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[40].name = "eml_warning";
  c2_info[40].dominantType = "char";
  c2_info[40].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_warning.m";
  c2_info[40].fileLength = 262U;
  c2_info[40].fileTime1 = 1236235678U;
  c2_info[40].fileTime2 = 0U;
  c2_info[41].context = "[ILX]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[41].name = "eml_div";
  c2_info[41].dominantType = "double";
  c2_info[41].resolved =
    "[ILX]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_div.m";
  c2_info[41].fileLength = 4269U;
  c2_info[41].fileTime1 = 1228072226U;
  c2_info[41].fileTime2 = 0U;
}

static const mxArray *c2_b_sf_marshall(void *c2_chartInstance, void *c2_u)
{
  const mxArray *c2_y = NULL;
  boolean_T c2_b_u;
  const mxArray *c2_b_y = NULL;
  c2_y = NULL;
  c2_b_u = *((boolean_T *)c2_u);
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_b_u, 11, 0U, 0U, 0U, 0));
  sf_mex_assign(&c2_y, c2_b_y);
  return c2_y;
}

static void init_dsm_address_info(void)
{
}

/* SFunction Glue Code */
void sf_c2_pend_swingup_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1457747354U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3068511254U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(4245756989U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2810841332U);
}

mxArray *sf_c2_pend_swingup_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,4,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateDoubleMatrix(4,1,mxREAL);
    double *pr = mxGetPr(mxChecksum);
    pr[0] = (double)(2039464665U);
    pr[1] = (double)(2792954011U);
    pr[2] = (double)(1724654434U);
    pr[3] = (double)(3728839307U);
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  return(mxAutoinheritanceInfo);
}

static mxArray *sf_get_sim_state_info_c2_pend_swingup(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"y\",},{M[8],M[0],T\"is_active_c2_pend_swingup\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_pend_swingup_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (_pend_swingupMachineNumber_,
           2,
           1,
           1,
           3,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance.chartNumber),
           &(chartInstance.instanceNumber),
           ssGetPath(S),
           (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation(_pend_swingupMachineNumber_,
            chartInstance.chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (_pend_swingupMachineNumber_,chartInstance.chartNumber,1);
          sf_debug_set_chart_event_thresholds(_pend_swingupMachineNumber_,
            chartInstance.chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,"ang",0,
                              (MexFcnForType)c2_sf_marshall);
          _SFD_SET_DATA_PROPS(1,2,0,1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,"y",0,
                              (MexFcnForType)c2_sf_marshall);
          _SFD_SET_DATA_PROPS(2,1,1,0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,"vel",0,
                              (MexFcnForType)c2_sf_marshall);
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of EML Model Coverage */
        _SFD_CV_INIT_EML(0,1,2,0,0,0,2,1);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,152);
        _SFD_CV_INIT_EML_IF(0,0,55,66,-1,86);
        _SFD_CV_INIT_EML_IF(0,1,88,130,137,152);

        {
          static int condStart[] = { 92, 115 };

          static int condEnd[] = { 111, 128 };

          static int pfixExpr[] = { 0, 1, -3 };

          _SFD_CV_INIT_EML_MCDC(0,0,91,129,2,0,&(condStart[0]),&(condEnd[0]),3,
                                &(pfixExpr[0]));
        }

        _SFD_TRANS_COV_WTS(0,0,0,1,0);
        if (chartAlreadyPresent==0) {
          _SFD_TRANS_COV_MAPS(0,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              1,NULL,NULL,
                              0,NULL,NULL);
        }

        {
          real_T *c2_ang;
          real_T *c2_y;
          real_T *c2_vel;
          c2_vel = (real_T *)ssGetInputPortSignal(chartInstance.S, 1);
          c2_y = (real_T *)ssGetOutputPortSignal(chartInstance.S, 1);
          c2_ang = (real_T *)ssGetInputPortSignal(chartInstance.S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, c2_ang);
          _SFD_SET_DATA_VALUE_PTR(1U, c2_y);
          _SFD_SET_DATA_VALUE_PTR(2U, c2_vel);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(_pend_swingupMachineNumber_,
        chartInstance.chartNumber,chartInstance.instanceNumber);
    }
  }
}

static void sf_opaque_initialize_c2_pend_swingup(void *chartInstanceVar)
{
  chart_debug_initialization(chartInstance.S,0);
  initialize_params_c2_pend_swingup();
  initialize_c2_pend_swingup();
}

static void sf_opaque_enable_c2_pend_swingup(void *chartInstanceVar)
{
  enable_c2_pend_swingup();
}

static void sf_opaque_disable_c2_pend_swingup(void *chartInstanceVar)
{
  disable_c2_pend_swingup();
}

static void sf_opaque_gateway_c2_pend_swingup(void *chartInstanceVar)
{
  sf_c2_pend_swingup();
}

static mxArray* sf_opaque_get_sim_state_c2_pend_swingup(void *chartInstanceVar)
{
  mxArray *st = (mxArray *) get_sim_state_c2_pend_swingup();
  return st;
}

static void sf_opaque_set_sim_state_c2_pend_swingup(void *chartInstanceVar,
  const mxArray *st)
{
  set_sim_state_c2_pend_swingup(sf_mex_dup(st));
}

static void sf_opaque_terminate_c2_pend_swingup(void *chartInstanceVar)
{
  if (sim_mode_is_rtw_gen(chartInstance.S) || sim_mode_is_external
      (chartInstance.S)) {
    sf_clear_rtw_identifier(chartInstance.S);
  }

  finalize_c2_pend_swingup();
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_pend_swingup(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_pend_swingup();
  }
}

static void mdlSetWorkWidths_c2_pend_swingup(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable("pend_swingup","pend_swingup",2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop("pend_swingup","pend_swingup",2,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop("pend_swingup",
      "pend_swingup",2,"gatewayCannotBeInlinedMultipleTimes"));
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,"pend_swingup","pend_swingup",2,2);
      sf_mark_chart_reusable_outputs(S,"pend_swingup","pend_swingup",2,1);
    }

    sf_set_rtw_dwork_info(S,"pend_swingup","pend_swingup",2);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
    ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  }

  ssSetChecksum0(S,(3064424033U));
  ssSetChecksum1(S,(1277462059U));
  ssSetChecksum2(S,(988321250U));
  ssSetChecksum3(S,(1414312878U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
}

static void mdlRTW_c2_pend_swingup(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    sf_write_symbol_mapping(S, "pend_swingup", "pend_swingup",2);
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_pend_swingup(SimStruct *S)
{
  chartInstance.chartInfo.chartInstance = NULL;
  chartInstance.chartInfo.isEMLChart = 1;
  chartInstance.chartInfo.chartInitialized = 0;
  chartInstance.chartInfo.sFunctionGateway = sf_opaque_gateway_c2_pend_swingup;
  chartInstance.chartInfo.initializeChart = sf_opaque_initialize_c2_pend_swingup;
  chartInstance.chartInfo.terminateChart = sf_opaque_terminate_c2_pend_swingup;
  chartInstance.chartInfo.enableChart = sf_opaque_enable_c2_pend_swingup;
  chartInstance.chartInfo.disableChart = sf_opaque_disable_c2_pend_swingup;
  chartInstance.chartInfo.getSimState = sf_opaque_get_sim_state_c2_pend_swingup;
  chartInstance.chartInfo.setSimState = sf_opaque_set_sim_state_c2_pend_swingup;
  chartInstance.chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_pend_swingup;
  chartInstance.chartInfo.zeroCrossings = NULL;
  chartInstance.chartInfo.outputs = NULL;
  chartInstance.chartInfo.derivatives = NULL;
  chartInstance.chartInfo.mdlRTW = mdlRTW_c2_pend_swingup;
  chartInstance.chartInfo.mdlStart = mdlStart_c2_pend_swingup;
  chartInstance.chartInfo.mdlSetWorkWidths = mdlSetWorkWidths_c2_pend_swingup;
  chartInstance.chartInfo.extModeExec = NULL;
  chartInstance.chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance.chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance.chartInfo.storeCurrentConfiguration = NULL;
  chartInstance.S = S;
  ssSetUserData(S,(void *)(&(chartInstance.chartInfo)));/* register the chart instance with simstruct */
  if (!sim_mode_is_rtw_gen(S)) {
    init_dsm_address_info();
  }

  chart_debug_initialization(S,1);
}

void c2_pend_swingup_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_pend_swingup(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_pend_swingup(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_pend_swingup(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_pend_swingup_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
