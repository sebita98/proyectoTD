/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/proyectoTD/lcdOWN/timer.vhd";
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_2110339434_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_1242562249_sub_2110375371_1035706684(char *, char *, char *, char *, char *);


static void work_a_0141943142_2737160039_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;

LAB0:    xsi_set_current_line(47, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1152U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 4376);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(48, ng0);
    t1 = xsi_get_transient_memory(20U);
    memset(t1, 0, 20U);
    t5 = t1;
    memset(t5, (unsigned char)2, 20U);
    t6 = (t0 + 4504);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 20U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 1992U);
    t6 = *((char **)t2);
    t2 = (t0 + 4504);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t6, 20U);
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

LAB7:    t2 = (t0 + 1192U);
    t5 = *((char **)t2);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB9;

}

static void work_a_0141943142_2737160039_p_1(char *t0)
{
    char t16[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned char t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;

LAB0:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t11 = (t0 + 1832U);
    t12 = *((char **)t11);
    t11 = (t0 + 6504U);
    t13 = (t0 + 2152U);
    t14 = *((char **)t13);
    t13 = (t0 + 6520U);
    t15 = ieee_p_1242562249_sub_2110339434_1035706684(IEEE_P_1242562249, t12, t11, t14, t13);
    if (t15 != 0)
        goto LAB5;

LAB6:
LAB9:    t29 = xsi_get_transient_memory(20U);
    memset(t29, 0, 20U);
    t30 = t29;
    memset(t30, (unsigned char)2, 20U);
    t31 = (t0 + 4568);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    memcpy(t35, t29, 20U);
    xsi_driver_first_trans_fast(t31);

LAB2:    t36 = (t0 + 4392);
    *((int *)t36) = 1;

LAB1:    return;
LAB3:    t1 = xsi_get_transient_memory(20U);
    memset(t1, 0, 20U);
    t5 = t1;
    memset(t5, (unsigned char)2, 20U);
    t6 = (t0 + 4568);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 20U);
    xsi_driver_first_trans_fast(t6);
    goto LAB2;

LAB5:    t17 = (t0 + 1832U);
    t18 = *((char **)t17);
    t17 = (t0 + 6504U);
    t19 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t16, t18, t17, 1);
    t20 = (t16 + 12U);
    t21 = *((unsigned int *)t20);
    t22 = (1U * t21);
    t23 = (20U != t22);
    if (t23 == 1)
        goto LAB7;

LAB8:    t24 = (t0 + 4568);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t19, 20U);
    xsi_driver_first_trans_fast(t24);
    goto LAB2;

LAB7:    xsi_size_not_matching(20U, t22, 0);
    goto LAB8;

LAB10:    goto LAB2;

}

static void work_a_0141943142_2737160039_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 6504U);
    t3 = (t0 + 2152U);
    t4 = *((char **)t3);
    t3 = (t0 + 6520U);
    t5 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t2, t1, t4, t3);
    if (t5 != 0)
        goto LAB3;

LAB4:
LAB5:    t11 = (t0 + 4632);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t16 = (t0 + 4408);
    *((int *)t16) = 1;

LAB1:    return;
LAB3:    t6 = (t0 + 4632);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t6);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0141943142_2737160039_p_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(61, ng0);

LAB3:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = (t0 + 4696);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 20U);
    xsi_driver_first_trans_fast(t1);

LAB2:    t7 = (t0 + 4424);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0141943142_2737160039_init()
{
	static char *pe[] = {(void *)work_a_0141943142_2737160039_p_0,(void *)work_a_0141943142_2737160039_p_1,(void *)work_a_0141943142_2737160039_p_2,(void *)work_a_0141943142_2737160039_p_3};
	xsi_register_didat("work_a_0141943142_2737160039", "isim/tb_lcd_top_isim_beh.exe.sim/work/a_0141943142_2737160039.didat");
	xsi_register_executes(pe);
}
