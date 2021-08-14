/*
 * motor_pos_str_data.c
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

/* Block parameters (default storage) */
P_motor_pos_str_T motor_pos_str_P = {
  /* Computed Parameter: TransferFcn_A
   * Referenced by: '<Root>/Transfer Fcn'
   */
  -10.0,

  /* Computed Parameter: TransferFcn_C
   * Referenced by: '<Root>/Transfer Fcn'
   */
  10.0,

  /* Expression: [0.01 0.004]
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  { 0.01, 0.004 },

  /* Expression: [1 -1.605 0.605]
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  { 1.0, -1.605, 0.605 },

  /* Expression: 0
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S2>/Unit Delay'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S2>/Unit Delay1'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S2>/Unit Delay2'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S2>/Unit Delay3'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S2>/Unit Delay5'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S2>/Unit Delay4'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<Root>/Pulse Generator'
   */
  1.0,

  /* Computed Parameter: PulseGenerator_Period
   * Referenced by: '<Root>/Pulse Generator'
   */
  800.0,

  /* Computed Parameter: PulseGenerator_Duty
   * Referenced by: '<Root>/Pulse Generator'
   */
  400.0,

  /* Expression: 0
   * Referenced by: '<Root>/Pulse Generator'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay1'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay2'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay3'
   */
  0.0
};
