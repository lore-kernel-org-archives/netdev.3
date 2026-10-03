Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465D32B104;
	Sat,  3 Oct 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039475; cv=pass; b=A1p3dY+jXUcDhdN1cHGNoszkyFz7soIRggGpWviT1uyWXd3zlk5OpqL+d9Q08KHIKnbR2QLw55YjP9KzwMkjtSNrjVnIm1f/f6f4xugJfBmXUkbsHwT61Mq0Sd76KY4SEmFibNULd+0oO2satBg5LOdWsFhJm3/IiufgXWJaLBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039475; c=relaxed/simple;
	bh=94s8DAePrZQltiZEATVnfh2QmCIKcDgq2NH1OOJdEDc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RnFQvbbP0s70910EIDQyhBOQ0sTs+GBVQ6JulPWzHX2/ViyonndarwjJxMzXbjDOkjVAGIrWjgvWP31j3j0+i61q+/fm1d0D6G1uuHV47wFkMTwW8sObg46puAEFCnodN4QSPVKylvlRIaVqghUVI7OEzhYmc3j+JnQ5Ago/Ejo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=M/ruwXtv; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="M/ruwXtv"
ARC-Seal: i=1; a=rsa-sha256; t=1791039435; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B2dsupjAD/xEnuZcDbRd+J/uMOSoydtGZfPxlM6yasMU2a9zDYAftDmaOCX+L7U+4iaYhmDlVzNjg3JRd/WBJ1cAmZyeGjI7/t/x82BD9hNjlXAXJhLju5z2al5Unnqwn8rojxOPw5e0YPmnnJg3dAPJiYFHzDnIziGwwT5H5Hc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791039435; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NSwFcA47hIfQsmJOM2nJiaMy7kPbDB0MRzTINBK5Ig0=; 
	b=Y9yCCFJ8pntBF4VjVtbbbw2Cx8GVyNFdVh7VPjPCkISjbg5kMiR/trhW+LmV/bRb0SkcWPdS6kHCE1dbHTDIDdh6uEWoJylqS/hMjE0uVDfvzUxpxghiLPXzqpC0RVHsIQmEDuEetdkWua+ptZq+RVVOb333Q1BEqCmTkU5DbBM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791039435;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
	bh=NSwFcA47hIfQsmJOM2nJiaMy7kPbDB0MRzTINBK5Ig0=;
	b=M/ruwXtveB/UX2Trc/MfPckGq4+fgMTSw48qxjxnjA5TG4mz298fBPbMjh9B3hJD
	PHFWRNiOM+3WPAJ0Dyo4Cf7sI/Hh9XzT19J3+0aySez7FhUKEyk8UkHfIcymXIfGBcu
	s1lXQp1majEII+vk8kywd+o2Ekg4qUxloJUkJcwY=
Received: by smtp.zohomail.com with SMTPS id 1791039435077605.2511497773884;
	Sat, 3 Oct 2026 07:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 22:57:05 +0800
Message-Id: <DLVAHLGLB6W5.1X87X6JJ6MY5H@pigmoral.tech>
Cc: "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>, "Jerome
 Brunet" <jbrunet@baylibre.com>, "Enzo Adriano"
 <enzo.adriano.code@gmail.com>, "Andre Przywara" <andre.przywara@arm.com>
Subject: Re: [PATCH v5 3/8] clk: sunxi-ng: a733: Add PRCM CCU
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: <wens@kernel.org>, "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
 <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech>
 <CAGb2v65q8w6NLzTtuMX3HZR98nAvR=Z4ODUCFZb5j3TgkDu_3Q@mail.gmail.com>
In-Reply-To: <CAGb2v65q8w6NLzTtuMX3HZR98nAvR=Z4ODUCFZb5j3TgkDu_3Q@mail.gmail.com>
X-ZohoMailClient: External

Hi Chen-Yu,
Thanks for the review.

On Sat Oct 3, 2026 at 10:00 PM CST, Chen-Yu Tsai wrote:
> On Wed, Sep 30, 2026 at 1:27=E2=80=AFAM Junhui Liu <junhui.liu@pigmoral.t=
ech> wrote:
>>
>> Add support for the Power Reset Clock Management (PRCM) module found in
>> the Allwinner A733 SoC. This clock controller manages the clock control
>> and reset functions for device modules within the CPUS domain.
>>
>> The PRCM module includes the management of three primary buses: r-ahb,
>> r-apb0, and r-apb1. It also provides clocking for several key
>> peripherals, such as R-UART, R-I2C, R-SPI, and the R-RISCV subsystem.
>> Additionally, the reset lines for these modules are integrated.
>>
>> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>> Reviewed-by: Enzo Adriano <enzo.adriano.code@gmail.com>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  drivers/clk/sunxi-ng/Kconfig             |   5 +
>>  drivers/clk/sunxi-ng/Makefile            |   2 +
>>  drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c | 273 ++++++++++++++++++++++++=
+++++++
>>  3 files changed, 280 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
>> index 6af2d020e03e..202e793dc754 100644
>> --- a/drivers/clk/sunxi-ng/Kconfig
>> +++ b/drivers/clk/sunxi-ng/Kconfig
>> @@ -67,6 +67,11 @@ config SUN55I_A523_R_CCU
>>         default ARCH_SUNXI
>>         depends on ARM64 || COMPILE_TEST
>>
>> +config SUN60I_A733_R_CCU
>> +       tristate "Support for the Allwinner A733 PRCM CCU"
>> +       default ARCH_SUNXI
>> +       depends on ARM64 || COMPILE_TEST
>> +
>>  config SUN4I_A10_CCU
>>         tristate "Support for the Allwinner A10/A20 CCU"
>>         default ARCH_SUNXI
>> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefi=
le
>> index a1c4087d7241..d3702bdb7a23 100644
>> --- a/drivers/clk/sunxi-ng/Makefile
>> +++ b/drivers/clk/sunxi-ng/Makefile
>> @@ -36,6 +36,7 @@ obj-$(CONFIG_SUN50I_H616_CCU) +=3D sun50i-h616-ccu.o
>>  obj-$(CONFIG_SUN55I_A523_CCU)  +=3D sun55i-a523-ccu.o
>>  obj-$(CONFIG_SUN55I_A523_MCU_CCU)      +=3D sun55i-a523-mcu-ccu.o
>>  obj-$(CONFIG_SUN55I_A523_R_CCU)        +=3D sun55i-a523-r-ccu.o
>> +obj-$(CONFIG_SUN60I_A733_R_CCU)        +=3D sun60i-a733-r-ccu.o
>>  obj-$(CONFIG_SUN4I_A10_CCU)    +=3D sun4i-a10-ccu.o
>>  obj-$(CONFIG_SUN5I_CCU)                +=3D sun5i-ccu.o
>>  obj-$(CONFIG_SUN6I_A31_CCU)    +=3D sun6i-a31-ccu.o
>> @@ -64,6 +65,7 @@ sun50i-h616-ccu-y             +=3D ccu-sun50i-h616.o
>>  sun55i-a523-ccu-y              +=3D ccu-sun55i-a523.o
>>  sun55i-a523-mcu-ccu-y          +=3D ccu-sun55i-a523-mcu.o
>>  sun55i-a523-r-ccu-y            +=3D ccu-sun55i-a523-r.o
>> +sun60i-a733-r-ccu-y            +=3D ccu-sun60i-a733-r.o
>>  sun4i-a10-ccu-y                        +=3D ccu-sun4i-a10.o
>>  sun5i-ccu-y                    +=3D ccu-sun5i.o
>>  sun6i-a31-ccu-y                        +=3D ccu-sun6i-a31.o
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c b/drivers/clk/sunx=
i-ng/ccu-sun60i-a733-r.c
>> new file mode 100644
>> index 000000000000..f320b52526ea
>> --- /dev/null
>> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c
>> @@ -0,0 +1,273 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 rengaomin@allwinnertech.com
>> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>> + * Based on the A523 CCU driver:
>> + *   Copyright (C) 2024 Arm Ltd.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h>
>> +#include <dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h>
>> +
>> +#include "ccu_common.h"
>> +#include "ccu_reset.h"
>> +
>> +#include "ccu_div.h"
>> +#include "ccu_gate.h"
>> +#include "ccu_mp.h"
>> +
>> +static const struct clk_parent_data r_ahb_parents[] =3D {
>> +       { .fw_name =3D "hosc" },
>> +       { .fw_name =3D "losc" },
>> +       { .fw_name =3D "iosc" },
>> +       { .fw_name =3D "pll-periph0-200m" },
>> +       { .fw_name =3D "pll-periph0-300m" },
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX(r_ahb_clk, "r-ahb", r_ahb_parents, 0x0=
00,
>> +                                0, 5,  /* M */
>> +                                24, 3, /* mux */
>> +                                0);
>> +
>> +static const struct clk_parent_data r_apb_parents[] =3D {
>> +       { .fw_name =3D "hosc" },
>> +       { .fw_name =3D "losc" },
>> +       { .fw_name =3D "iosc" },
>> +       { .fw_name =3D "pll-periph0-200m" },
>> +       { .fw_name =3D "sys-24m" },
>> +};
>> +
>> +static SUNXI_CCU_M_DATA_WITH_MUX(r_apb0_clk, "r-apb0", r_apb_parents, 0=
x00c,
>> +                                0, 5,  /* M */
>> +                                24, 3, /* mux */
>> +                                0);
>> +
>> +static SUNXI_CCU_M_DATA_WITH_MUX(r_apb1_clk, "r-apb1", r_apb_parents, 0=
x010,
>> +                                0, 5,  /* M */
>> +                                24, 3, /* mux */
>> +                                0);
>
> The three bus dividers are secure by default, and either need to be toggl=
ed
> to non-secure by the bootloader, or (I'm guessing) the system is running
> without secure boot and the secure access bit isn't in effect.
>
> Please add a comment about this.

Okay, I will add a comment explaining this.

>
>> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer0, "r-timer0", r_apb_p=
arents, 0x100,
>> +                                     1, 3,     /* P */
>> +                                     4, 3,     /* mux */
>> +                                     BIT(0),   /* gate */
>> +                                     0);
>> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer1, "r-timer1", r_apb_p=
arents, 0x104,
>> +                                     1, 3,     /* P */
>> +                                     4, 3,     /* mux */
>> +                                     BIT(0),   /* gate */
>> +                                     0);
>> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer2, "r-timer2", r_apb_p=
arents, 0x108,
>> +                                     1, 3,     /* P */
>> +                                     4, 3,     /* mux */
>> +                                     BIT(0),   /* gate */
>> +                                     0);
>> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer3, "r-timer3", r_apb_p=
arents, 0x10c,
>> +                                     1, 3,     /* P */
>> +                                     4, 3,     /* mux */
>> +                                     BIT(0),   /* gate */
>> +                                     0);
>> +
>> +static SUNXI_CCU_GATE_HW(bus_r_timer_clk, "bus-r-timer", &r_ahb_clk.com=
mon.hw, 0x11c, BIT(0), 0);
>
>> +static SUNXI_CCU_GATE_HW(bus_r_twd_clk, "bus-r-twd", &r_apb0_clk.common=
.hw, 0x12c, BIT(0), 0);
>
> User manual says this is secure only. I suggest at least adding a comment
> if not removing it altogether. Or perhaps someone could clarify with
> Allwinner what this does.

I will try to test this on a board with secure boot enabled. If the
register is indeed inaccessible from the non-secure world, I will remove
this clock.

>
>> +static const struct clk_parent_data r_pwm_parents[] =3D {
>> +       { .fw_name =3D "hosc" },
>> +       { .fw_name =3D "losc" },
>> +       { .fw_name =3D "iosc" },
>> +       { .fw_name =3D "sys-24m" },
>> +};
>> +static SUNXI_CCU_MUX_DATA_WITH_GATE(r_pwm_clk, "r-pwm", r_pwm_parents, =
0x130,
>> +                                   24, 2,      /* mux */
>> +                                   BIT(31),    /* gate */
>> +                                   0);
>> +static SUNXI_CCU_GATE_HW(bus_r_pwm_clk, "bus-r-pwm",
>> +                        &r_apb0_clk.common.hw, 0x13c, BIT(0), 0);
>> +
>> +static const struct clk_parent_data r_spi_parents[] =3D {
>> +       { .fw_name =3D "hosc" },
>> +       { .fw_name =3D "pll-periph0-200m" },
>> +       { .fw_name =3D "pll-periph0-300m" },
>> +       { .fw_name =3D "pll-periph1-300m" },
>> +       { .fw_name =3D "sys-24m" },
>> +};
>> +static SUNXI_CCU_DUALDIV_MUX_GATE(r_spi_clk, "r-spi", r_spi_parents, 0x=
150,
>> +                                 0, 5,         /* M */
>> +                                 8, 5,         /* N */
>> +                                 24, 3,        /* mux */
>> +                                 BIT(31),      /* gate */
>> +                                 0);
>> +static SUNXI_CCU_GATE_HW(bus_r_spi_clk, "bus-r-spi", &r_ahb_clk.common.=
hw, 0x15c, BIT(0), 0);
>> +
>> +static SUNXI_CCU_GATE_HW(bus_r_msgbox_clk, "bus-r-msgbox", &r_ahb_clk.c=
ommon.hw, 0x17c, BIT(0), 0);
>> +
>> +static SUNXI_CCU_GATE_HW(bus_r_uart0_clk, "bus-r-uart0", &r_apb1_clk.co=
mmon.hw, 0x18c, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HW(bus_r_uart1_clk, "bus-r-uart1", &r_apb1_clk.co=
mmon.hw, 0x18c, BIT(1), 0);
>> +
>> +static SUNXI_CCU_GATE_HW(bus_r_i2c0_clk, "bus-r-i2c0", &r_apb1_clk.comm=
on.hw, 0x19c, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HW(bus_r_i2c1_clk, "bus-r-i2c1", &r_apb1_clk.comm=
on.hw, 0x19c, BIT(1), 0);
>> +static SUNXI_CCU_GATE_HW(bus_r_i2c2_clk, "bus-r-i2c2", &r_apb1_clk.comm=
on.hw, 0x19c, BIT(2), 0);
>> +
>> +static SUNXI_CCU_GATE_HW(bus_r_ppu_clk, "bus-r-ppu", &r_apb0_clk.common=
.hw, 0x1ac, BIT(0), 0);
>> +
>> +static SUNXI_CCU_GATE_HW(bus_r_tzma_clk, "bus-r-tzma", &r_apb0_clk.comm=
on.hw, 0x1b0, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HW(bus_r_cpu_bist_clk, "bus-r-cpu-bist", &r_apb0_=
clk.common.hw,
>> +                        0x1bc, BIT(0), 0);
>> +
>> +static const struct clk_parent_data r_ir_rx_parents[] =3D {
>> +       { .fw_name =3D "losc" },
>> +       { .fw_name =3D "hosc" },
>> +       { .fw_name =3D "sys-24m" },
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(r_ir_rx_clk, "r-ir-rx", r_ir_rx_p=
arents, 0x1c0,
>> +                                     0, 5,     /* M */
>> +                                     24, 2,    /* mux */
>> +                                     BIT(31),  /* gate */
>> +                                     0);
>> +static SUNXI_CCU_GATE_HW(bus_r_ir_rx_clk, "bus-r-ir-rx", &r_apb0_clk.co=
mmon.hw, 0x1cc, BIT(0), 0);
>
> BSP sources say there is a "dma-clken-sw" gate at 0x1dc bit 0. Same on th=
e
> A523, though it's unclear what it does or controls.

I checked the vendor BSP available to me and found that dma-clken-sw is
present in the sun60iw1 R-CCU driver, but not in the sun60iw2 R-CCU
driver.

The A733 corresponds to sun60iw2. Since this clock is neither documented
in the A733 user manual nor present in the vendor A733 (sun60iw2) clock
driver, I don't plan to expose it in the A733 driver.

>
>> +static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc", &r_ahb_clk.common.=
hw, 0x20c, BIT(0), 0);
>> +
>> +static const struct clk_parent_data r_riscv_parents[] =3D {
>> +       { .fw_name =3D "hosc" },
>> +       { .fw_name =3D "losc" },
>> +       { .fw_name =3D "iosc" },
>> +};
>> +static SUNXI_CCU_MUX_DATA_WITH_GATE(r_riscv_clk, "r-riscv", r_riscv_par=
ents, 0x210,
>> +                                 24, 2,        /* mux */
>> +                                 BIT(31),      /* gate */
>> +                                 0);
>> +static SUNXI_CCU_GATE_HW(bus_r_riscv_clk, "bus-r-riscv", &r_apb0_clk.co=
mmon.hw,
>> +                        0x21c, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HW(bus_r_riscv_cfg_clk, "bus-r-riscv-cfg", &r_apb=
0_clk.common.hw,
>> +                        0x21c, BIT(1), 0);
>> +
>> +static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg", &r_apb0_clk.=
common.hw,
>> +                        0x22c, BIT(0), CLK_IS_CRITICAL);
>> +
>> +static struct ccu_common *sun60i_a733_r_ccu_clks[] =3D {
>> +       &r_ahb_clk.common,
>> +       &r_apb0_clk.common,
>> +       &r_apb1_clk.common,
>> +       &r_cpu_timer0.common,
>> +       &r_cpu_timer1.common,
>> +       &r_cpu_timer2.common,
>> +       &r_cpu_timer3.common,
>> +       &bus_r_timer_clk.common,
>> +       &bus_r_twd_clk.common,
>> +       &r_pwm_clk.common,
>> +       &bus_r_pwm_clk.common,
>> +       &r_spi_clk.common,
>> +       &bus_r_spi_clk.common,
>> +       &bus_r_msgbox_clk.common,
>> +       &bus_r_uart0_clk.common,
>> +       &bus_r_uart1_clk.common,
>> +       &bus_r_i2c0_clk.common,
>> +       &bus_r_i2c1_clk.common,
>> +       &bus_r_i2c2_clk.common,
>> +       &bus_r_ppu_clk.common,
>> +       &bus_r_tzma_clk.common,
>> +       &bus_r_cpu_bist_clk.common,
>> +       &r_ir_rx_clk.common,
>> +       &bus_r_ir_rx_clk.common,
>> +       &bus_r_rtc_clk.common,
>> +       &r_riscv_clk.common,
>> +       &bus_r_riscv_clk.common,
>> +       &bus_r_riscv_cfg_clk.common,
>> +       &bus_r_cpucfg_clk.common,
>> +};
>> +
>> +static struct clk_hw_onecell_data sun60i_a733_r_hw_clks =3D {
>> +       .hws =3D {
>> +               [CLK_R_AHB]             =3D &r_ahb_clk.common.hw,
>> +               [CLK_R_APB0]            =3D &r_apb0_clk.common.hw,
>> +               [CLK_R_APB1]            =3D &r_apb1_clk.common.hw,
>> +               [CLK_R_TIMER0]          =3D &r_cpu_timer0.common.hw,
>> +               [CLK_R_TIMER1]          =3D &r_cpu_timer1.common.hw,
>> +               [CLK_R_TIMER2]          =3D &r_cpu_timer2.common.hw,
>> +               [CLK_R_TIMER3]          =3D &r_cpu_timer3.common.hw,
>> +               [CLK_BUS_R_TIMER]       =3D &bus_r_timer_clk.common.hw,
>> +               [CLK_BUS_R_TWD]         =3D &bus_r_twd_clk.common.hw,
>> +               [CLK_R_PWM]             =3D &r_pwm_clk.common.hw,
>> +               [CLK_BUS_R_PWM]         =3D &bus_r_pwm_clk.common.hw,
>> +               [CLK_R_SPI]             =3D &r_spi_clk.common.hw,
>> +               [CLK_BUS_R_SPI]         =3D &bus_r_spi_clk.common.hw,
>> +               [CLK_BUS_R_MSGBOX]      =3D &bus_r_msgbox_clk.common.hw,
>> +               [CLK_BUS_R_UART0]       =3D &bus_r_uart0_clk.common.hw,
>> +               [CLK_BUS_R_UART1]       =3D &bus_r_uart1_clk.common.hw,
>> +               [CLK_BUS_R_I2C0]        =3D &bus_r_i2c0_clk.common.hw,
>> +               [CLK_BUS_R_I2C1]        =3D &bus_r_i2c1_clk.common.hw,
>> +               [CLK_BUS_R_I2C2]        =3D &bus_r_i2c2_clk.common.hw,
>> +               [CLK_BUS_R_PPU]         =3D &bus_r_ppu_clk.common.hw,
>> +               [CLK_BUS_R_TZMA]        =3D &bus_r_tzma_clk.common.hw,
>> +               [CLK_BUS_R_CPU_BIST]    =3D &bus_r_cpu_bist_clk.common.h=
w,
>> +               [CLK_R_IR_RX]           =3D &r_ir_rx_clk.common.hw,
>> +               [CLK_BUS_R_IR_RX]       =3D &bus_r_ir_rx_clk.common.hw,
>> +               [CLK_BUS_R_RTC]         =3D &bus_r_rtc_clk.common.hw,
>> +               [CLK_R_RISCV]           =3D &r_riscv_clk.common.hw,
>> +               [CLK_BUS_R_RISCV]       =3D &bus_r_riscv_clk.common.hw,
>> +               [CLK_BUS_R_RISCV_CFG]   =3D &bus_r_riscv_cfg_clk.common.=
hw,
>> +               [CLK_BUS_R_CPUCFG]      =3D &bus_r_cpucfg_clk.common.hw,
>> +       },
>> +       .num =3D CLK_BUS_R_CPUCFG + 1,
>> +};
>> +
>> +static const struct ccu_reset_map sun60i_a733_r_ccu_resets[] =3D {
>> +       [RST_BUS_R_TIMER]       =3D { 0x11c, BIT(16) },
>> +       [RST_BUS_R_PWM]         =3D { 0x13c, BIT(16) },
>> +       [RST_BUS_R_SPI]         =3D { 0x15c, BIT(16) },
>> +       [RST_BUS_R_MSGBOX]      =3D { 0x17c, BIT(16) },
>> +       [RST_BUS_R_UART0]       =3D { 0x18c, BIT(16) },
>> +       [RST_BUS_R_UART1]       =3D { 0x18c, BIT(17) },
>> +       [RST_BUS_R_I2C0]        =3D { 0x19c, BIT(16) },
>> +       [RST_BUS_R_I2C1]        =3D { 0x19c, BIT(17) },
>> +       [RST_BUS_R_I2C2]        =3D { 0x19c, BIT(18) },
>> +       [RST_BUS_R_IR_RX]       =3D { 0x1cc, BIT(16) },
>> +       [RST_BUS_R_RTC]         =3D { 0x20c, BIT(16) },
>> +       [RST_BUS_R_RISCV_CFG]   =3D { 0x21c, BIT(16) },
>> +       [RST_BUS_R_CPUCFG]      =3D { 0x22c, BIT(16) },
>> +};
>> +
>> +static const struct sunxi_ccu_desc sun60i_a733_r_ccu_desc =3D {
>> +       .ccu_clks       =3D sun60i_a733_r_ccu_clks,
>> +       .num_ccu_clks   =3D ARRAY_SIZE(sun60i_a733_r_ccu_clks),
>> +
>> +       .hw_clks        =3D &sun60i_a733_r_hw_clks,
>> +
>> +       .resets         =3D sun60i_a733_r_ccu_resets,
>> +       .num_resets     =3D ARRAY_SIZE(sun60i_a733_r_ccu_resets),
>> +};
>> +
>> +static int sun60i_a733_r_ccu_probe(struct platform_device *pdev)
>> +{
>> +       void __iomem *reg;
>> +
>> +       reg =3D devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(reg))
>> +               return PTR_ERR(reg);
>> +
>> +       return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun60i_a733_r_ccu_=
desc);
>> +}
>> +
>> +static const struct of_device_id sun60i_a733_r_ccu_ids[] =3D {
>> +       { .compatible =3D "allwinner,sun60i-a733-r-ccu" },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, sun60i_a733_r_ccu_ids);
>> +
>> +static struct platform_driver sun60i_a733_r_ccu_driver =3D {
>> +       .probe  =3D sun60i_a733_r_ccu_probe,
>> +       .driver =3D {
>> +               .name                   =3D "sun60i-a733-r-ccu",
>> +               .suppress_bind_attrs    =3D true,
>> +               .of_match_table         =3D sun60i_a733_r_ccu_ids,
>> +       },
>> +};
>> +module_platform_driver(sun60i_a733_r_ccu_driver);
>> +
>> +MODULE_IMPORT_NS("SUNXI_CCU");
>> +MODULE_DESCRIPTION("Support for the Allwinner A733 PRCM CCU");
>> +MODULE_LICENSE("GPL");
>
> The rest looks OK.

Thanks!

>
>
> Thanks
> ChenYu

--=20
Best regards,
Junhui Liu
