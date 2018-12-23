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
static const char *ng0 = "D:/Autosave Carino/Documents/XILINX/Dino-Run-master/Dino/seg_disp.v";
static unsigned int ng1[] = {1U, 0U};
static unsigned int ng2[] = {15U, 0U};
static int ng3[] = {1, 0};
static int ng4[] = {0, 0};
static unsigned int ng5[] = {0U, 0U};
static unsigned int ng6[] = {2U, 0U};
static unsigned int ng7[] = {3U, 0U};
static unsigned int ng8[] = {79U, 0U};
static unsigned int ng9[] = {18U, 0U};
static unsigned int ng10[] = {6U, 0U};
static unsigned int ng11[] = {4U, 0U};
static unsigned int ng12[] = {76U, 0U};
static unsigned int ng13[] = {5U, 0U};
static unsigned int ng14[] = {36U, 0U};
static unsigned int ng15[] = {32U, 0U};
static unsigned int ng16[] = {7U, 0U};
static unsigned int ng17[] = {8U, 0U};
static unsigned int ng18[] = {9U, 0U};
static unsigned int ng19[] = {10U, 0U};
static unsigned int ng20[] = {11U, 0U};
static unsigned int ng21[] = {96U, 0U};
static unsigned int ng22[] = {12U, 0U};
static unsigned int ng23[] = {49U, 0U};
static unsigned int ng24[] = {13U, 0U};
static unsigned int ng25[] = {66U, 0U};
static unsigned int ng26[] = {14U, 0U};
static unsigned int ng27[] = {48U, 0U};
static unsigned int ng28[] = {56U, 0U};



static void Initial_39_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(39, ng0);

LAB2:    xsi_set_current_line(40, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2408);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Always_43_1(char *t0)
{
    char t6[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;

LAB0:    t1 = (t0 + 3896U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(43, ng0);
    t2 = (t0 + 4216);
    *((int *)t2) = 1;
    t3 = (t0 + 3928);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(43, ng0);

LAB5:    xsi_set_current_line(44, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t0 + 2248);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(45, ng0);
    t2 = (t0 + 2568);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t4, 2, t5, 32);
    t7 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t7, t6, 0, 0, 2, 0LL);
    xsi_set_current_line(46, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t7 = *((char **)t5);
    t8 = (t0 + 2568);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    xsi_vlog_generic_convert_bit_index(t6, t7, 2, t10, 2, 2);
    t11 = (t6 + 4);
    t12 = *((unsigned int *)t11);
    t13 = (!(t12));
    if (t13 == 1)
        goto LAB6;

LAB7:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2568);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB8:    t5 = ((char*)((ng5)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 2, t5, 2);
    if (t13 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 2);
    if (t13 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng6)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 2);
    if (t13 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng7)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 2);
    if (t13 == 1)
        goto LAB15;

LAB16:
LAB18:
LAB17:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t6 + 4);
    t5 = (t3 + 4);
    t12 = *((unsigned int *)t3);
    t14 = (t12 >> 0);
    *((unsigned int *)t6) = t14;
    t15 = *((unsigned int *)t5);
    t16 = (t15 >> 0);
    *((unsigned int *)t2) = t16;
    t17 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t17 & 15U);
    t18 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t18 & 15U);
    t7 = (t0 + 2728);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 4);

LAB19:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 2728);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);

LAB20:    t7 = ((char*)((ng5)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t7, 32);
    if (t13 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng6)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng7)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB27;

LAB28:    t2 = ((char*)((ng11)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB29;

LAB30:    t2 = ((char*)((ng13)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB31;

LAB32:    t2 = ((char*)((ng10)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB33;

LAB34:    t2 = ((char*)((ng16)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB35;

LAB36:    t2 = ((char*)((ng17)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB37;

LAB38:    t2 = ((char*)((ng18)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB39;

LAB40:    t2 = ((char*)((ng19)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB41;

LAB42:    t2 = ((char*)((ng20)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB43;

LAB44:    t2 = ((char*)((ng22)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB45;

LAB46:    t2 = ((char*)((ng24)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB47;

LAB48:    t2 = ((char*)((ng26)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB49;

LAB50:    t2 = ((char*)((ng2)));
    t13 = xsi_vlog_unsigned_case_compare(t5, 4, t2, 32);
    if (t13 == 1)
        goto LAB51;

LAB52:
LAB54:
LAB53:    xsi_set_current_line(71, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2088);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);

LAB55:    goto LAB2;

LAB6:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t6), 1);
    goto LAB7;

LAB9:    xsi_set_current_line(48, ng0);
    t7 = (t0 + 1688U);
    t8 = *((char **)t7);
    memset(t6, 0, 8);
    t7 = (t6 + 4);
    t9 = (t8 + 4);
    t12 = *((unsigned int *)t8);
    t14 = (t12 >> 0);
    *((unsigned int *)t6) = t14;
    t15 = *((unsigned int *)t9);
    t16 = (t15 >> 0);
    *((unsigned int *)t7) = t16;
    t17 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t17 & 15U);
    t18 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t18 & 15U);
    t10 = (t0 + 2728);
    xsi_vlogvar_assign_value(t10, t6, 0, 0, 4);
    goto LAB19;

LAB11:    xsi_set_current_line(49, ng0);
    t3 = (t0 + 1528U);
    t5 = *((char **)t3);
    memset(t6, 0, 8);
    t3 = (t6 + 4);
    t7 = (t5 + 4);
    t12 = *((unsigned int *)t5);
    t14 = (t12 >> 0);
    *((unsigned int *)t6) = t14;
    t15 = *((unsigned int *)t7);
    t16 = (t15 >> 0);
    *((unsigned int *)t3) = t16;
    t17 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t17 & 15U);
    t18 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t18 & 15U);
    t8 = (t0 + 2728);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 4);
    goto LAB19;

LAB13:    xsi_set_current_line(50, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    memset(t6, 0, 8);
    t3 = (t6 + 4);
    t7 = (t5 + 4);
    t12 = *((unsigned int *)t5);
    t14 = (t12 >> 0);
    *((unsigned int *)t6) = t14;
    t15 = *((unsigned int *)t7);
    t16 = (t15 >> 0);
    *((unsigned int *)t3) = t16;
    t17 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t17 & 15U);
    t18 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t18 & 15U);
    t8 = (t0 + 2728);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 4);
    goto LAB19;

LAB15:    xsi_set_current_line(51, ng0);
    t3 = (t0 + 1208U);
    t5 = *((char **)t3);
    memset(t6, 0, 8);
    t3 = (t6 + 4);
    t7 = (t5 + 4);
    t12 = *((unsigned int *)t5);
    t14 = (t12 >> 0);
    *((unsigned int *)t6) = t14;
    t15 = *((unsigned int *)t7);
    t16 = (t15 >> 0);
    *((unsigned int *)t3) = t16;
    t17 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t17 & 15U);
    t18 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t18 & 15U);
    t8 = (t0 + 2728);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 4);
    goto LAB19;

LAB21:    xsi_set_current_line(55, ng0);
    t8 = ((char*)((ng1)));
    t9 = (t0 + 2088);
    xsi_vlogvar_assign_value(t9, t8, 0, 0, 8);
    goto LAB55;

LAB23:    xsi_set_current_line(56, ng0);
    t3 = ((char*)((ng8)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB25:    xsi_set_current_line(57, ng0);
    t3 = ((char*)((ng9)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB27:    xsi_set_current_line(58, ng0);
    t3 = ((char*)((ng10)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB29:    xsi_set_current_line(59, ng0);
    t3 = ((char*)((ng12)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB31:    xsi_set_current_line(60, ng0);
    t3 = ((char*)((ng14)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB33:    xsi_set_current_line(61, ng0);
    t3 = ((char*)((ng15)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB35:    xsi_set_current_line(62, ng0);
    t3 = ((char*)((ng2)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB37:    xsi_set_current_line(63, ng0);
    t3 = ((char*)((ng5)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB39:    xsi_set_current_line(64, ng0);
    t3 = ((char*)((ng11)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB41:    xsi_set_current_line(65, ng0);
    t3 = ((char*)((ng17)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB43:    xsi_set_current_line(66, ng0);
    t3 = ((char*)((ng21)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB45:    xsi_set_current_line(67, ng0);
    t3 = ((char*)((ng23)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB47:    xsi_set_current_line(68, ng0);
    t3 = ((char*)((ng25)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB49:    xsi_set_current_line(69, ng0);
    t3 = ((char*)((ng27)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

LAB51:    xsi_set_current_line(70, ng0);
    t3 = ((char*)((ng28)));
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 8);
    goto LAB55;

}


extern void work_m_00000000000789079070_0542327438_init()
{
	static char *pe[] = {(void *)Initial_39_0,(void *)Always_43_1};
	xsi_register_didat("work_m_00000000000789079070_0542327438", "isim/test_main_isim_beh.exe.sim/work/m_00000000000789079070_0542327438.didat");
	xsi_register_executes(pe);
}
