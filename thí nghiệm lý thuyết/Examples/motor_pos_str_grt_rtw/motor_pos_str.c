/*
 * motor_pos_str.c
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

#include "motor_pos_str.h"
#include "motor_pos_str_private.h"

/* Block signals (default storage) */
B_motor_pos_str_T motor_pos_str_B;

/* Continuous states */
X_motor_pos_str_T motor_pos_str_X;

/* Block states (default storage) */
DW_motor_pos_str_T motor_pos_str_DW;

/* Real-time model */
RT_MODEL_motor_pos_str_T motor_pos_str_M_;
RT_MODEL_motor_pos_str_T *const motor_pos_str_M = &motor_pos_str_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 1;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  motor_pos_str_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  motor_pos_str_step();
  motor_pos_str_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  motor_pos_str_step();
  motor_pos_str_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model step function */
void motor_pos_str_step(void)
{
  if (rtmIsMajorTimeStep(motor_pos_str_M)) {
    /* set solver stop time */
    if (!(motor_pos_str_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&motor_pos_str_M->solverInfo,
                            ((motor_pos_str_M->Timing.clockTickH0 + 1) *
        motor_pos_str_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&motor_pos_str_M->solverInfo,
                            ((motor_pos_str_M->Timing.clockTick0 + 1) *
        motor_pos_str_M->Timing.stepSize0 + motor_pos_str_M->Timing.clockTickH0 *
        motor_pos_str_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(motor_pos_str_M)) {
    motor_pos_str_M->Timing.t[0] = rtsiGetT(&motor_pos_str_M->solverInfo);
  }

  {
    real_T PHI[4];
    int32_T i;
    real_T y;
    real_T b_y;
    real_T tmp[16];
    real_T tmp_0[16];
    int32_T i_0;
    real_T rtb_TmpSignalConversionAtSFun_0[4];
    real_T PHI_0;

    /* TransferFcn: '<Root>/Transfer Fcn' */
    motor_pos_str_B.TransferFcn = 0.0;
    motor_pos_str_B.TransferFcn += motor_pos_str_P.TransferFcn_C *
      motor_pos_str_X.TransferFcn_CSTATE;
    if (rtmIsMajorTimeStep(motor_pos_str_M)) {
      /* DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
      motor_pos_str_B.DiscreteTransferFcn =
        motor_pos_str_P.DiscreteTransferFcn_NumCoef[0] *
        motor_pos_str_DW.DiscreteTransferFcn_states[0] +
        motor_pos_str_P.DiscreteTransferFcn_NumCoef[1] *
        motor_pos_str_DW.DiscreteTransferFcn_states[1];

      /* UnitDelay: '<S2>/Unit Delay' */
      motor_pos_str_B.UnitDelay = motor_pos_str_DW.UnitDelay_DSTATE;

      /* UnitDelay: '<S2>/Unit Delay1' */
      motor_pos_str_B.UnitDelay1 = motor_pos_str_DW.UnitDelay1_DSTATE;

      /* UnitDelay: '<S2>/Unit Delay2' */
      motor_pos_str_B.UnitDelay2 = motor_pos_str_DW.UnitDelay2_DSTATE;

      /* UnitDelay: '<S2>/Unit Delay3' */
      motor_pos_str_B.UnitDelay3 = motor_pos_str_DW.UnitDelay3_DSTATE;

      /* UnitDelay: '<S2>/Unit Delay5' */
      memcpy(&motor_pos_str_B.UnitDelay5[0],
             &motor_pos_str_DW.UnitDelay5_DSTATE[0], sizeof(real_T) << 4U);

      /* UnitDelay: '<S2>/Unit Delay4' */
      memcpy(&motor_pos_str_B.UnitDelay4[0],
             &motor_pos_str_DW.UnitDelay4_DSTATE[0], sizeof(real_T) << 4U);
    }

    /* MATLAB Function: '<S2>/MATLAB Function' incorporates:
     *  SignalConversion: '<S4>/TmpSignal ConversionAt SFunction Inport2'
     */
    PHI[0] = -motor_pos_str_B.UnitDelay2;
    PHI[1] = -motor_pos_str_B.UnitDelay3;
    PHI[2] = motor_pos_str_B.UnitDelay;
    PHI[3] = motor_pos_str_B.UnitDelay1;
    y = 0.0;
    b_y = 0.0;
    for (i = 0; i < 4; i++) {
      PHI_0 = motor_pos_str_B.UnitDelay5[(i << 2) + 3] *
        motor_pos_str_B.UnitDelay1 + (motor_pos_str_B.UnitDelay5[(i << 2) + 2] *
        motor_pos_str_B.UnitDelay + (motor_pos_str_B.UnitDelay5[(i << 2) + 1] *
        -motor_pos_str_B.UnitDelay3 + motor_pos_str_B.UnitDelay5[i << 2] *
        -motor_pos_str_B.UnitDelay2));
      y += PHI_0 * PHI[i];
      PHI_0 = motor_pos_str_B.UnitDelay5[(i << 2) + 3] *
        motor_pos_str_B.UnitDelay1 + (motor_pos_str_B.UnitDelay5[(i << 2) + 2] *
        motor_pos_str_B.UnitDelay + (motor_pos_str_B.UnitDelay5[(i << 2) + 1] *
        -motor_pos_str_B.UnitDelay3 + motor_pos_str_B.UnitDelay5[i << 2] *
        -motor_pos_str_B.UnitDelay2));
      b_y += PHI_0 * PHI[i];
    }

    for (i = 0; i < 4; i++) {
      PHI_0 = motor_pos_str_B.UnitDelay5[i + 12] * motor_pos_str_B.UnitDelay1 +
        (motor_pos_str_B.UnitDelay5[i + 8] * motor_pos_str_B.UnitDelay +
         (motor_pos_str_B.UnitDelay5[i + 4] * -motor_pos_str_B.UnitDelay3 +
          motor_pos_str_B.UnitDelay5[i] * -motor_pos_str_B.UnitDelay2));
      tmp[i] = PHI_0 * -motor_pos_str_B.UnitDelay2;
      tmp[i + 4] = PHI_0 * -motor_pos_str_B.UnitDelay3;
      tmp[i + 8] = PHI_0 * motor_pos_str_B.UnitDelay;
      tmp[i + 12] = PHI_0 * motor_pos_str_B.UnitDelay1;
      for (i_0 = 0; i_0 < 4; i_0++) {
        tmp_0[i + (i_0 << 2)] = motor_pos_str_B.UnitDelay5[(i_0 << 2) + i] -
          (((motor_pos_str_B.UnitDelay5[(i_0 << 2) + 1] * tmp[i + 4] +
             motor_pos_str_B.UnitDelay5[i_0 << 2] * tmp[i]) +
            motor_pos_str_B.UnitDelay5[(i_0 << 2) + 2] * tmp[i + 8]) +
           motor_pos_str_B.UnitDelay5[(i_0 << 2) + 3] * tmp[i + 12]) / (0.96 +
          b_y);
      }
    }

    for (i = 0; i < 4; i++) {
      motor_pos_str_B.P[i << 2] = tmp_0[i << 2] * 1.0416666666666667;
      motor_pos_str_B.P[1 + (i << 2)] = tmp_0[(i << 2) + 1] * 1.0416666666666667;
      motor_pos_str_B.P[2 + (i << 2)] = tmp_0[(i << 2) + 2] * 1.0416666666666667;
      motor_pos_str_B.P[3 + (i << 2)] = tmp_0[(i << 2) + 3] * 1.0416666666666667;
      PHI[i] = (((motor_pos_str_B.UnitDelay5[i + 4] *
                  -motor_pos_str_B.UnitDelay3 + motor_pos_str_B.UnitDelay5[i] *
                  -motor_pos_str_B.UnitDelay2) + motor_pos_str_B.UnitDelay5[i +
                 8] * motor_pos_str_B.UnitDelay) + motor_pos_str_B.UnitDelay5[i
                + 12] * motor_pos_str_B.UnitDelay1) / (0.96 + y);
      rtb_TmpSignalConversionAtSFun_0[i] = motor_pos_str_B.DiscreteTransferFcn -
        (((motor_pos_str_B.UnitDelay4[(i << 2) + 1] *
           -motor_pos_str_B.UnitDelay3 + motor_pos_str_B.UnitDelay4[i << 2] *
           -motor_pos_str_B.UnitDelay2) + motor_pos_str_B.UnitDelay4[(i << 2) +
          2] * motor_pos_str_B.UnitDelay) + motor_pos_str_B.UnitDelay4[(i << 2)
         + 3] * motor_pos_str_B.UnitDelay1);
    }

    for (i = 0; i < 4; i++) {
      motor_pos_str_B.Theta[i] = PHI[i] * rtb_TmpSignalConversionAtSFun_0[0] +
        motor_pos_str_B.UnitDelay4[i];
      motor_pos_str_B.Theta[i + 4] = motor_pos_str_B.UnitDelay4[i + 4] + PHI[i] *
        rtb_TmpSignalConversionAtSFun_0[1];
      motor_pos_str_B.Theta[i + 8] = motor_pos_str_B.UnitDelay4[i + 8] + PHI[i] *
        rtb_TmpSignalConversionAtSFun_0[2];
      motor_pos_str_B.Theta[i + 12] = motor_pos_str_B.UnitDelay4[i + 12] + PHI[i]
        * rtb_TmpSignalConversionAtSFun_0[3];
    }

    /* End of MATLAB Function: '<S2>/MATLAB Function' */
    if (rtmIsMajorTimeStep(motor_pos_str_M)) {
      /* DiscretePulseGenerator: '<Root>/Pulse Generator' */
      motor_pos_str_B.PulseGenerator = (motor_pos_str_DW.clockTickCounter <
        motor_pos_str_P.PulseGenerator_Duty) &&
        (motor_pos_str_DW.clockTickCounter >= 0) ?
        motor_pos_str_P.PulseGenerator_Amp : 0.0;
      if (motor_pos_str_DW.clockTickCounter >=
          motor_pos_str_P.PulseGenerator_Period - 1.0) {
        motor_pos_str_DW.clockTickCounter = 0;
      } else {
        motor_pos_str_DW.clockTickCounter++;
      }

      /* End of DiscretePulseGenerator: '<Root>/Pulse Generator' */

      /* UnitDelay: '<S1>/Unit Delay' */
      motor_pos_str_B.UnitDelay_d = motor_pos_str_DW.UnitDelay_DSTATE_h;

      /* UnitDelay: '<S1>/Unit Delay1' */
      motor_pos_str_B.UnitDelay1_n = motor_pos_str_DW.UnitDelay1_DSTATE_o;

      /* UnitDelay: '<S1>/Unit Delay2' */
      motor_pos_str_B.UnitDelay2_o = motor_pos_str_DW.UnitDelay2_DSTATE_d;

      /* UnitDelay: '<S1>/Unit Delay3' */
      motor_pos_str_B.UnitDelay3_e = motor_pos_str_DW.UnitDelay3_DSTATE_a;
    }

    /* Sum: '<S1>/Sum' */
    motor_pos_str_B.Sum = motor_pos_str_B.TransferFcn -
      motor_pos_str_B.DiscreteTransferFcn;
  }

  if (rtmIsMajorTimeStep(motor_pos_str_M)) {
    /* Matfile logging */
    rt_UpdateTXYLogVars(motor_pos_str_M->rtwLogInfo, (motor_pos_str_M->Timing.t));
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(motor_pos_str_M)) {
    real_T denAccum;
    if (rtmIsMajorTimeStep(motor_pos_str_M)) {
      /* Update for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
      denAccum = ((0.0 - motor_pos_str_P.DiscreteTransferFcn_DenCoef[1] *
                   motor_pos_str_DW.DiscreteTransferFcn_states[0]) -
                  motor_pos_str_P.DiscreteTransferFcn_DenCoef[2] *
                  motor_pos_str_DW.DiscreteTransferFcn_states[1]) /
        motor_pos_str_P.DiscreteTransferFcn_DenCoef[0];
      motor_pos_str_DW.DiscreteTransferFcn_states[1] =
        motor_pos_str_DW.DiscreteTransferFcn_states[0];
      motor_pos_str_DW.DiscreteTransferFcn_states[0] = denAccum;

      /* Update for UnitDelay: '<S2>/Unit Delay' */
      motor_pos_str_DW.UnitDelay_DSTATE = 0.0;

      /* Update for UnitDelay: '<S2>/Unit Delay1' */
      motor_pos_str_DW.UnitDelay1_DSTATE = motor_pos_str_B.UnitDelay;

      /* Update for UnitDelay: '<S2>/Unit Delay2' */
      motor_pos_str_DW.UnitDelay2_DSTATE = motor_pos_str_B.DiscreteTransferFcn;

      /* Update for UnitDelay: '<S2>/Unit Delay3' */
      motor_pos_str_DW.UnitDelay3_DSTATE = motor_pos_str_B.UnitDelay2;

      /* Update for UnitDelay: '<S2>/Unit Delay5' */
      memcpy(&motor_pos_str_DW.UnitDelay5_DSTATE[0], &motor_pos_str_B.P[0],
             sizeof(real_T) << 4U);

      /* Update for UnitDelay: '<S2>/Unit Delay4' */
      memcpy(&motor_pos_str_DW.UnitDelay4_DSTATE[0], &motor_pos_str_B.Theta[0],
             sizeof(real_T) << 4U);

      /* Update for UnitDelay: '<S1>/Unit Delay' */
      motor_pos_str_DW.UnitDelay_DSTATE_h = motor_pos_str_B.Sum;

      /* Update for UnitDelay: '<S1>/Unit Delay1' */
      motor_pos_str_DW.UnitDelay1_DSTATE_o = motor_pos_str_B.UnitDelay_d;

      /* Update for UnitDelay: '<S1>/Unit Delay2' */
      motor_pos_str_DW.UnitDelay2_DSTATE_d = 0.0;

      /* Update for UnitDelay: '<S1>/Unit Delay3' */
      motor_pos_str_DW.UnitDelay3_DSTATE_a = motor_pos_str_B.UnitDelay2_o;
    }
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(motor_pos_str_M)) {
    /* signal main to stop simulation */
    {                                  /* Sample time: [0.0s, 0.0s] */
      if ((rtmGetTFinal(motor_pos_str_M)!=-1) &&
          !((rtmGetTFinal(motor_pos_str_M)-(((motor_pos_str_M->Timing.clockTick1
               +motor_pos_str_M->Timing.clockTickH1* 4294967296.0)) * 0.005)) >
            (((motor_pos_str_M->Timing.clockTick1+
               motor_pos_str_M->Timing.clockTickH1* 4294967296.0)) * 0.005) *
            (DBL_EPSILON))) {
        rtmSetErrorStatus(motor_pos_str_M, "Simulation finished");
      }
    }

    rt_ertODEUpdateContinuousStates(&motor_pos_str_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick0 and the high bits
     * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++motor_pos_str_M->Timing.clockTick0)) {
      ++motor_pos_str_M->Timing.clockTickH0;
    }

    motor_pos_str_M->Timing.t[0] = rtsiGetSolverStopTime
      (&motor_pos_str_M->solverInfo);

    {
      /* Update absolute timer for sample time: [0.005s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 0.005, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       * Timer of this task consists of two 32 bit unsigned integers.
       * The two integers represent the low bits Timing.clockTick1 and the high bits
       * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
       */
      motor_pos_str_M->Timing.clockTick1++;
      if (!motor_pos_str_M->Timing.clockTick1) {
        motor_pos_str_M->Timing.clockTickH1++;
      }
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void motor_pos_str_derivatives(void)
{
  XDot_motor_pos_str_T *_rtXdot;
  _rtXdot = ((XDot_motor_pos_str_T *) motor_pos_str_M->derivs);

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE = 0.0;
  _rtXdot->TransferFcn_CSTATE += motor_pos_str_P.TransferFcn_A *
    motor_pos_str_X.TransferFcn_CSTATE;
  _rtXdot->TransferFcn_CSTATE += motor_pos_str_B.PulseGenerator;
}

/* Model initialize function */
void motor_pos_str_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)motor_pos_str_M, 0,
                sizeof(RT_MODEL_motor_pos_str_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&motor_pos_str_M->solverInfo,
                          &motor_pos_str_M->Timing.simTimeStep);
    rtsiSetTPtr(&motor_pos_str_M->solverInfo, &rtmGetTPtr(motor_pos_str_M));
    rtsiSetStepSizePtr(&motor_pos_str_M->solverInfo,
                       &motor_pos_str_M->Timing.stepSize0);
    rtsiSetdXPtr(&motor_pos_str_M->solverInfo, &motor_pos_str_M->derivs);
    rtsiSetContStatesPtr(&motor_pos_str_M->solverInfo, (real_T **)
                         &motor_pos_str_M->contStates);
    rtsiSetNumContStatesPtr(&motor_pos_str_M->solverInfo,
      &motor_pos_str_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&motor_pos_str_M->solverInfo,
      &motor_pos_str_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&motor_pos_str_M->solverInfo,
      &motor_pos_str_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&motor_pos_str_M->solverInfo,
      &motor_pos_str_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&motor_pos_str_M->solverInfo, (&rtmGetErrorStatus
      (motor_pos_str_M)));
    rtsiSetRTModelPtr(&motor_pos_str_M->solverInfo, motor_pos_str_M);
  }

  rtsiSetSimTimeStep(&motor_pos_str_M->solverInfo, MAJOR_TIME_STEP);
  motor_pos_str_M->intgData.y = motor_pos_str_M->odeY;
  motor_pos_str_M->intgData.f[0] = motor_pos_str_M->odeF[0];
  motor_pos_str_M->intgData.f[1] = motor_pos_str_M->odeF[1];
  motor_pos_str_M->intgData.f[2] = motor_pos_str_M->odeF[2];
  motor_pos_str_M->contStates = ((X_motor_pos_str_T *) &motor_pos_str_X);
  rtsiSetSolverData(&motor_pos_str_M->solverInfo, (void *)
                    &motor_pos_str_M->intgData);
  rtsiSetSolverName(&motor_pos_str_M->solverInfo,"ode3");
  rtmSetTPtr(motor_pos_str_M, &motor_pos_str_M->Timing.tArray[0]);
  rtmSetTFinal(motor_pos_str_M, 20.0);
  motor_pos_str_M->Timing.stepSize0 = 0.005;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    motor_pos_str_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(motor_pos_str_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(motor_pos_str_M->rtwLogInfo, (NULL));
    rtliSetLogT(motor_pos_str_M->rtwLogInfo, "tout");
    rtliSetLogX(motor_pos_str_M->rtwLogInfo, "");
    rtliSetLogXFinal(motor_pos_str_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(motor_pos_str_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(motor_pos_str_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(motor_pos_str_M->rtwLogInfo, 0);
    rtliSetLogDecimation(motor_pos_str_M->rtwLogInfo, 1);
    rtliSetLogY(motor_pos_str_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(motor_pos_str_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(motor_pos_str_M->rtwLogInfo, (NULL));
  }

  /* block I/O */
  (void) memset(((void *) &motor_pos_str_B), 0,
                sizeof(B_motor_pos_str_T));

  /* states (continuous) */
  {
    (void) memset((void *)&motor_pos_str_X, 0,
                  sizeof(X_motor_pos_str_T));
  }

  /* states (dwork) */
  (void) memset((void *)&motor_pos_str_DW, 0,
                sizeof(DW_motor_pos_str_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(motor_pos_str_M->rtwLogInfo, 0.0,
    rtmGetTFinal(motor_pos_str_M), motor_pos_str_M->Timing.stepSize0,
    (&rtmGetErrorStatus(motor_pos_str_M)));

  /* Start for DiscretePulseGenerator: '<Root>/Pulse Generator' */
  motor_pos_str_DW.clockTickCounter = 0;

  {
    int32_T i;

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
    motor_pos_str_X.TransferFcn_CSTATE = 0.0;

    /* InitializeConditions for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
    motor_pos_str_DW.DiscreteTransferFcn_states[0] =
      motor_pos_str_P.DiscreteTransferFcn_InitialStat;
    motor_pos_str_DW.DiscreteTransferFcn_states[1] =
      motor_pos_str_P.DiscreteTransferFcn_InitialStat;

    /* InitializeConditions for UnitDelay: '<S2>/Unit Delay' */
    motor_pos_str_DW.UnitDelay_DSTATE =
      motor_pos_str_P.UnitDelay_InitialCondition;

    /* InitializeConditions for UnitDelay: '<S2>/Unit Delay1' */
    motor_pos_str_DW.UnitDelay1_DSTATE =
      motor_pos_str_P.UnitDelay1_InitialCondition;

    /* InitializeConditions for UnitDelay: '<S2>/Unit Delay2' */
    motor_pos_str_DW.UnitDelay2_DSTATE =
      motor_pos_str_P.UnitDelay2_InitialCondition;

    /* InitializeConditions for UnitDelay: '<S2>/Unit Delay3' */
    motor_pos_str_DW.UnitDelay3_DSTATE =
      motor_pos_str_P.UnitDelay3_InitialCondition;
    for (i = 0; i < 16; i++) {
      /* InitializeConditions for UnitDelay: '<S2>/Unit Delay5' */
      motor_pos_str_DW.UnitDelay5_DSTATE[i] =
        motor_pos_str_P.UnitDelay5_InitialCondition;

      /* InitializeConditions for UnitDelay: '<S2>/Unit Delay4' */
      motor_pos_str_DW.UnitDelay4_DSTATE[i] =
        motor_pos_str_P.UnitDelay4_InitialCondition;
    }

    /* InitializeConditions for UnitDelay: '<S1>/Unit Delay' */
    motor_pos_str_DW.UnitDelay_DSTATE_h =
      motor_pos_str_P.UnitDelay_InitialCondition_b;

    /* InitializeConditions for UnitDelay: '<S1>/Unit Delay1' */
    motor_pos_str_DW.UnitDelay1_DSTATE_o =
      motor_pos_str_P.UnitDelay1_InitialCondition_c;

    /* InitializeConditions for UnitDelay: '<S1>/Unit Delay2' */
    motor_pos_str_DW.UnitDelay2_DSTATE_d =
      motor_pos_str_P.UnitDelay2_InitialCondition_c;

    /* InitializeConditions for UnitDelay: '<S1>/Unit Delay3' */
    motor_pos_str_DW.UnitDelay3_DSTATE_a =
      motor_pos_str_P.UnitDelay3_InitialCondition_m;
  }
}

/* Model terminate function */
void motor_pos_str_terminate(void)
{
  /* (no terminate code required) */
}
