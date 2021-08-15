/*
 * motor_pos_str.h
 *
 * Code generation for model "motor_pos_str".
 *
 * Model version              : 1.1
 * Simulink Coder version : 8.14 (R2018a) 06-Feb-2018
 * C source code generated on : Thu Dec 31 10:35:15 2020
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_motor_pos_str_h_
#define RTW_HEADER_motor_pos_str_h_
#include <string.h>
#include <float.h>
#include <stddef.h>
#ifndef motor_pos_str_COMMON_INCLUDES_
# define motor_pos_str_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#endif                                 /* motor_pos_str_COMMON_INCLUDES_ */

#include "motor_pos_str_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetContStateDisabled
# define rtmGetContStateDisabled(rtm)  ((rtm)->contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
# define rtmSetContStateDisabled(rtm, val) ((rtm)->contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
# define rtmGetContStates(rtm)         ((rtm)->contStates)
#endif

#ifndef rtmSetContStates
# define rtmSetContStates(rtm, val)    ((rtm)->contStates = (val))
#endif

#ifndef rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag
# define rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm) ((rtm)->CTOutputIncnstWithState)
#endif

#ifndef rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag
# define rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm, val) ((rtm)->CTOutputIncnstWithState = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
# define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
# define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetIntgData
# define rtmGetIntgData(rtm)           ((rtm)->intgData)
#endif

#ifndef rtmSetIntgData
# define rtmSetIntgData(rtm, val)      ((rtm)->intgData = (val))
#endif

#ifndef rtmGetOdeF
# define rtmGetOdeF(rtm)               ((rtm)->odeF)
#endif

#ifndef rtmSetOdeF
# define rtmSetOdeF(rtm, val)          ((rtm)->odeF = (val))
#endif

#ifndef rtmGetOdeY
# define rtmGetOdeY(rtm)               ((rtm)->odeY)
#endif

#ifndef rtmSetOdeY
# define rtmSetOdeY(rtm, val)          ((rtm)->odeY = (val))
#endif

#ifndef rtmGetPeriodicContStateIndices
# define rtmGetPeriodicContStateIndices(rtm) ((rtm)->periodicContStateIndices)
#endif

#ifndef rtmSetPeriodicContStateIndices
# define rtmSetPeriodicContStateIndices(rtm, val) ((rtm)->periodicContStateIndices = (val))
#endif

#ifndef rtmGetPeriodicContStateRanges
# define rtmGetPeriodicContStateRanges(rtm) ((rtm)->periodicContStateRanges)
#endif

#ifndef rtmSetPeriodicContStateRanges
# define rtmSetPeriodicContStateRanges(rtm, val) ((rtm)->periodicContStateRanges = (val))
#endif

#ifndef rtmGetRTWLogInfo
# define rtmGetRTWLogInfo(rtm)         ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetZCCacheNeedsReset
# define rtmGetZCCacheNeedsReset(rtm)  ((rtm)->zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
# define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetdX
# define rtmGetdX(rtm)                 ((rtm)->derivs)
#endif

#ifndef rtmSetdX
# define rtmSetdX(rtm, val)            ((rtm)->derivs = (val))
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               ((rtm)->Timing.t)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T TransferFcn;                  /* '<Root>/Transfer Fcn' */
  real_T DiscreteTransferFcn;          /* '<Root>/Discrete Transfer Fcn' */
  real_T UnitDelay;                    /* '<S2>/Unit Delay' */
  real_T UnitDelay1;                   /* '<S2>/Unit Delay1' */
  real_T UnitDelay2;                   /* '<S2>/Unit Delay2' */
  real_T UnitDelay3;                   /* '<S2>/Unit Delay3' */
  real_T UnitDelay5[16];               /* '<S2>/Unit Delay5' */
  real_T UnitDelay4[16];               /* '<S2>/Unit Delay4' */
  real_T PulseGenerator;               /* '<Root>/Pulse Generator' */
  real_T Sum;                          /* '<S1>/Sum' */
  real_T UnitDelay_d;                  /* '<S1>/Unit Delay' */
  real_T UnitDelay1_n;                 /* '<S1>/Unit Delay1' */
  real_T UnitDelay2_o;                 /* '<S1>/Unit Delay2' */
  real_T UnitDelay3_e;                 /* '<S1>/Unit Delay3' */
  real_T P[16];                        /* '<S2>/MATLAB Function' */
  real_T Theta[16];                    /* '<S2>/MATLAB Function' */
} B_motor_pos_str_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T DiscreteTransferFcn_states[2];/* '<Root>/Discrete Transfer Fcn' */
  real_T UnitDelay_DSTATE;             /* '<S2>/Unit Delay' */
  real_T UnitDelay1_DSTATE;            /* '<S2>/Unit Delay1' */
  real_T UnitDelay2_DSTATE;            /* '<S2>/Unit Delay2' */
  real_T UnitDelay3_DSTATE;            /* '<S2>/Unit Delay3' */
  real_T UnitDelay5_DSTATE[16];        /* '<S2>/Unit Delay5' */
  real_T UnitDelay4_DSTATE[16];        /* '<S2>/Unit Delay4' */
  real_T UnitDelay_DSTATE_h;           /* '<S1>/Unit Delay' */
  real_T UnitDelay1_DSTATE_o;          /* '<S1>/Unit Delay1' */
  real_T UnitDelay2_DSTATE_d;          /* '<S1>/Unit Delay2' */
  real_T UnitDelay3_DSTATE_a;          /* '<S1>/Unit Delay3' */
  struct {
    void *LoggedData;
  } Scope_PWORK;                       /* '<Root>/Scope' */

  struct {
    void *LoggedData;
  } Theta_PWORK;                       /* '<Root>/Theta' */

  struct {
    void *LoggedData;
  } u_PWORK;                           /* '<Root>/u' */

  int32_T clockTickCounter;            /* '<Root>/Pulse Generator' */
} DW_motor_pos_str_T;

/* Continuous states (default storage) */
typedef struct {
  real_T TransferFcn_CSTATE;           /* '<Root>/Transfer Fcn' */
} X_motor_pos_str_T;

/* State derivatives (default storage) */
typedef struct {
  real_T TransferFcn_CSTATE;           /* '<Root>/Transfer Fcn' */
} XDot_motor_pos_str_T;

/* State disabled  */
typedef struct {
  boolean_T TransferFcn_CSTATE;        /* '<Root>/Transfer Fcn' */
} XDis_motor_pos_str_T;

#ifndef ODE3_INTG
#define ODE3_INTG

/* ODE3 Integration Data */
typedef struct {
  real_T *y;                           /* output */
  real_T *f[3];                        /* derivatives */
} ODE3_IntgData;

#endif

/* Parameters (default storage) */
struct P_motor_pos_str_T_ {
  real_T TransferFcn_A;                /* Computed Parameter: TransferFcn_A
                                        * Referenced by: '<Root>/Transfer Fcn'
                                        */
  real_T TransferFcn_C;                /* Computed Parameter: TransferFcn_C
                                        * Referenced by: '<Root>/Transfer Fcn'
                                        */
  real_T DiscreteTransferFcn_NumCoef[2];/* Expression: [0.01 0.004]
                                         * Referenced by: '<Root>/Discrete Transfer Fcn'
                                         */
  real_T DiscreteTransferFcn_DenCoef[3];/* Expression: [1 -1.605 0.605]
                                         * Referenced by: '<Root>/Discrete Transfer Fcn'
                                         */
  real_T DiscreteTransferFcn_InitialStat;/* Expression: 0
                                          * Referenced by: '<Root>/Discrete Transfer Fcn'
                                          */
  real_T UnitDelay_InitialCondition;   /* Expression: 0
                                        * Referenced by: '<S2>/Unit Delay'
                                        */
  real_T UnitDelay1_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S2>/Unit Delay1'
                                        */
  real_T UnitDelay2_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S2>/Unit Delay2'
                                        */
  real_T UnitDelay3_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S2>/Unit Delay3'
                                        */
  real_T UnitDelay5_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S2>/Unit Delay5'
                                        */
  real_T UnitDelay4_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S2>/Unit Delay4'
                                        */
  real_T PulseGenerator_Amp;           /* Expression: 1
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T PulseGenerator_Period;        /* Computed Parameter: PulseGenerator_Period
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T PulseGenerator_Duty;          /* Computed Parameter: PulseGenerator_Duty
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T PulseGenerator_PhaseDelay;    /* Expression: 0
                                        * Referenced by: '<Root>/Pulse Generator'
                                        */
  real_T UnitDelay_InitialCondition_b; /* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay'
                                        */
  real_T UnitDelay1_InitialCondition_c;/* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay1'
                                        */
  real_T UnitDelay2_InitialCondition_c;/* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay2'
                                        */
  real_T UnitDelay3_InitialCondition_m;/* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay3'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_motor_pos_str_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;
  RTWSolverInfo solverInfo;
  X_motor_pos_str_T *contStates;
  int_T *periodicContStateIndices;
  real_T *periodicContStateRanges;
  real_T *derivs;
  boolean_T *contStateDisabled;
  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;
  real_T odeY[1];
  real_T odeF[3][1];
  ODE3_IntgData intgData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numSampTimes;
  } Sizes;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T tFinal;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *t;
    time_T tArray[2];
  } Timing;
};

/* Block parameters (default storage) */
extern P_motor_pos_str_T motor_pos_str_P;

/* Block signals (default storage) */
extern B_motor_pos_str_T motor_pos_str_B;

/* Continuous states (default storage) */
extern X_motor_pos_str_T motor_pos_str_X;

/* Block states (default storage) */
extern DW_motor_pos_str_T motor_pos_str_DW;

/* Model entry point functions */
extern void motor_pos_str_initialize(void);
extern void motor_pos_str_step(void);
extern void motor_pos_str_terminate(void);

/* Real-time Model object */
extern RT_MODEL_motor_pos_str_T *const motor_pos_str_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'motor_pos_str'
 * '<S1>'   : 'motor_pos_str/Self-Tuning Regulator'
 * '<S2>'   : 'motor_pos_str/identification'
 * '<S3>'   : 'motor_pos_str/Self-Tuning Regulator/MATLAB Function'
 * '<S4>'   : 'motor_pos_str/identification/MATLAB Function'
 */
#endif                                 /* RTW_HEADER_motor_pos_str_h_ */
