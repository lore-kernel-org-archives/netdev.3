Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633541;
	b=b9VyS3Fg5aD3DolJcJx2sChZu/HPce2U2gMQG4a1UpJvWZ3NO8MdLAUhfr830H4vmLy3
	 8WUDeRpGbb6vrpl6R/1t1OK74Vqk6HlvbP/boXChore89nZ2gd7Ym6IVb3Jaw+RRZ+g2Y
	 eLY/nuDVg/kvs06KAkIu2Uit9/gd56TZK0Eq/+EAej5aJoLJIUl7fzADjg/+fG550UuSn
	 1Ztk2kIKU4VThj0XvfyOyECJFAgOvTj/QQJKje/D1Uumig5tKlDnfVyU/WfjfbNVHPrt+
	 eoDStoDHP1J2B/BmAq4Fek0Nv+eW8ZNmFCEcnvxpAFxdxnPZf8nS4EMDsxBpKE3Hx8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633541;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6T5rb2LxFyPxvnPh+kKiCO5M57lVXbWd+BmSHjtX1s8=;
	b=Ygv3L01x7c7FtnAIe7I+Jcqlb5PsRKlibR+7xl7ENV+mmhjfiSmgf7IKYD6wJ0X7IltQ
	 Bn/+lmPQMt7dcKdEOtWN63E/AteC606OA0x5HvO9fcUIEX/h6TlVdRYa02SB988Yg6IF3
	 239uY0LtjxNTDpEN9y7e5WK9ICsSAtroFE+peiX6FiEg9xguuoS6Ekfg00srb3nY+3lXs
	 HljtTj6iDwIbDyaxCb+PBMVHfv/l0cP07mwvBjIp9BxvneCmzxv7rSv7nvglTEbPjsSa+
	 E2WA9qgR5sO6rlP3MT5rAvH6sg1NhysitT1EUWs+FzCQW3SYzE7A0y4TIb4zGrBmLHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ikaeaFGK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3686072280;
	Mon,  2 Nov 2026 15:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E3686072280
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ikaeaFGK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB781691;
	Mon,  2 Nov 2026 07:32:15 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67D33F673;
	Mon,  2 Nov 2026 07:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793633538; bh=rqqSdujFsWaTpfObZP49AiLOxTNz3wt1vLLYuVMAw6A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ikaeaFGKRwBLu+BLDNAFrEZn904hESZQQ9OUmAMDFjV9cz/6rzV+aKBdA7OrHM8BR
	 k9E981FAspOFA46HHKec4Sr8ApCtmHXIaThZpXehfr2lFvwC91nzl4i46bTthrfe2W
	 rkz/V5NEDtXbrcPLGpVEYJ2K85gHiznEY7o4h698=
Message-ID: <30e43e84-e6e8-4024-b415-dedf67070c4f@arm.com>
Date: Mon, 2 Nov 2026 16:32:12 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v6 6/8] clk: sunxi-ng: a733: Add mod clocks support
To: Junhui Liu <junhui.liu@pigmoral.tech>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
 Enzo Adriano <enzo.adriano.code@gmail.com>, Norman Herms
 <dockseed@proton.me>, Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech>
 <20261009-a733-clk-v6-6-ae8178fce7e8@pigmoral.tech>
Content-Language: en-GB
In-Reply-To: <20261009-a733-clk-v6-6-ae8178fce7e8@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

judging from the "fun" this is to review, I very much appreciate your 
efforts in putting this together ;-)

On 10/9/26 17:52, Junhui Liu wrote:
> Add the module clocks found in the Allwinner A733 SoC, including video,
> storage, interfaces and others. While most of these clocks are similar
> to those in the A523 SoC, this implementation accounts for changes in
> register offsets and introduces support for new modules.
> 
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>   drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 1103 ++++++++++++++++++++++++++++++++
>   1 file changed, 1103 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> index 371c4297c3ab..7847eec84313 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> @@ -27,6 +27,7 @@
>   #include "ccu_gate.h"
>   #include "ccu_mp.h"
>   #include "ccu_mult.h"
> +#include "ccu_mux.h"
>   #include "ccu_nkmp.h"
>   #include "ccu_nm.h"
>   
> @@ -85,6 +86,9 @@ static const struct clk_hw *pll_ref_hws[] = {
>    * - sys-24M serves as reference clock for downstream functional modules
>    */
>   static CLK_FIXED_FACTOR_HWS(sys_24M_clk, "sys-24M", pll_ref_hws, 1, 1, 0);
> +static const struct clk_hw *sys_24M_hws[] = {
> +	&sys_24M_clk.hw
> +};
>   
>   #define SUN60I_A733_PLL_DDR_REG		0x020
>   static struct ccu_nkmp pll_ddr_clk = {
> @@ -161,6 +165,9 @@ static CLK_FIXED_FACTOR_HWS(pll_periph0_200M_clk, "pll-periph0-200M",
>   			    pll_periph0_400M_hws, 2, 1, 0);
>   static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pll-periph0-150M",
>   			    pll_periph0_300M_hws, 2, 1, 0);
> +static const struct clk_hw *pll_periph0_150M_hws[] = {
> +	&pll_periph0_150M_clk.hw
> +};
>   static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
>   			    pll_periph0_480M_hws, 3, 1, 0);
>   
> @@ -511,6 +518,912 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x588
>   					   CLK_IS_CRITICAL,
>   					   CCU_FEATURE_UPDATE_BIT);
>   
> +/**************************************************************************
> + *                          mod clocks                                    *
> + **************************************************************************/
> +
> +static const struct clk_parent_data timer_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "iosc" },
> +	{ .fw_name = "losc" },
> +	{ .hw = &pll_periph0_200M_clk.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer0_clk, "timer0", timer_parents, 0x800,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer1_clk, "timer1", timer_parents, 0x804,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer2_clk, "timer2", timer_parents, 0x808,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer3_clk, "timer3", timer_parents, 0x80c,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer4_clk, "timer4", timer_parents, 0x810,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer5_clk, "timer5", timer_parents, 0x814,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer6_clk, "timer6", timer_parents, 0x818,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer7_clk, "timer7", timer_parents, 0x81c,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer8_clk, "timer8", timer_parents, 0x820,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer9_clk, "timer9", timer_parents, 0x824,
> +				      0, 3,		/* P */
> +				      24, 3,		/* mux */
> +				      BIT(31),		/* gate */
> +				      0);
> +
> +/* Undocumented, taken from the vendor kernel. */
> +static const struct clk_parent_data avs_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "hosc" },
> +};

Those two parents appear two more times below (usb01_ref_parents and 
hdmi_sfr_parents). Please rename this array to something more generic 
and reuse it below.

> +static SUNXI_CCU_MUX_DATA_WITH_GATE(avs_clk, "avs-clk", avs_parents, 0x880,
> +				    24, 3,		/* mux */
> +				    BIT(31),		/* gate */
> +				    0);
> +
> +static const struct clk_hw *de_parents[] = {
> +	&pll_de_3x_clk.common.hw,
> +	&pll_de_4x_clk.common.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_300M_clk.hw,
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(de0_clk, "de0", de_parents, 0xa00,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *di_parents[] = {
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0xa20,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *g2d_parents[] = {
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_300M_clk.hw,

My copy of the manual puts the 300MHz clock first, then the 400 MHz one. 
Can you please check this?

> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0xa40,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *eink_parents[] = {
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(eink_clk, "eink", eink_parents, 0xa60,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *eink_panel_parents[] = {
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video0_3x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +	&pll_video1_3x_clk.common.hw,
> +	&pll_periph0_300M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(eink_panel_clk, "eink-panel", eink_panel_parents, 0xa64,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *ve_enc_parents[] = {
> +	&pll_ve0_clk.common.hw,
> +	&pll_ve1_clk.common.hw,
> +	&pll_periph0_800M_clk.common.hw,
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_de_3x_clk.common.hw,
> +	&pll_npu_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_enc0_clk, "ve-enc0", ve_enc_parents, 0xa80,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *ve_dec_parents[] = {
> +	&pll_ve1_clk.common.hw,
> +	&pll_ve0_clk.common.hw,

Did AW really swap just the first two clocks between the encoder and the 
decoder parents? Those hardware guys ...

> +	&pll_periph0_800M_clk.common.hw,
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_de_3x_clk.common.hw,
> +	&pll_npu_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_dec0_clk, "ve-dec0", ve_dec_parents, 0xa88,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *ce_parents[] = {
> +	&sys_24M_clk.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_600M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0xac0,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *npu_parents[] = {
> +	&pll_npu_clk.common.hw,
> +	&pll_periph0_800M_clk.common.hw,
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_ve0_clk.common.hw,
> +	&pll_ve1_clk.common.hw,
> +	&pll_de_3x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0xb00,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +/*
> + * GPU_CLK = ClockSource * ((16 - M) / 16)
> + * Here we use a div_table to select M values that result in integer divisors.
> + */
> +static struct clk_div_table gpu_div_table[] = {
> +	{ .val = 0, .div = 1 },
> +	{ .val = 8, .div = 2 },
> +	{ .val = 12, .div = 4 },
> +	{ .val = 14, .div = 8 },
> +	{ .val = 15, .div = 16 },
> +	{ /* sentinel */ },
> +};
> +static const struct clk_parent_data gpu_parents[] = {
> +	{ .hw = &pll_gpu0_clk.common.hw, },
> +	{ .hw = &pll_periph0_800M_clk.common.hw, },
> +	{ .hw = &pll_periph0_600M_clk.hw, },
> +	{ .hw = &pll_periph0_400M_clk.hw, },
> +	{ .hw = &pll_periph0_300M_clk.hw, },
> +	{ .hw = &pll_periph0_200M_clk.hw, },
> +};
> +static struct ccu_div gpu0_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_TABLE(0, 4, gpu_div_table),
> +	.mux		= _SUNXI_CCU_MUX(24, 3),
> +	.common		= {
> +		.reg		= 0xb20,
> +		.features	= CCU_FEATURE_UPDATE_BIT,

Just a heads up: in my A523 CPU clocks series, I reworked the update bit 
handling, so depending on the order of merging this might need some rework.

> +		.hw.init	= CLK_HW_INIT_PARENTS_DATA("gpu0", gpu_parents,
> +							   &ccu_div_ops, 0),
> +	}
> +};
> +
> +static const struct clk_parent_data dram_parents[] = {
> +	{ .hw = &pll_ddr_clk.common.hw, },
> +	{ .hw = &pll_periph0_800M_clk.common.hw, },
> +	{ .hw = &pll_periph0_600M_clk.hw, },
> +	{ .hw = &pll_de_clk.common.hw, },

Should this be pll_de_3x instead?

> +	{ .hw = &pll_npu_clk.common.hw, },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(dram0_clk, "dram0", dram_parents, 0xc00,
> +					   0, 4,	/* M */
> +					   24, 3,	/* mux */
> +					   BIT(31),	/* gate */
> +					   CLK_IS_CRITICAL,
> +					   CCU_FEATURE_UPDATE_BIT);
> +
> +static const struct clk_parent_data nand_mmc_parents[] = {
> +	{ .hw = &sys_24M_clk.hw, },
> +	{ .hw = &pll_periph0_400M_clk.hw, },
> +	{ .hw = &pll_periph0_300M_clk.hw, },
> +	{ .hw = &pll_periph1_400M_clk.hw, },
> +	{ .hw = &pll_periph1_300M_clk.hw, },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk0_clk, "nand0-clk0", nand_mmc_parents, 0xc80,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk1_clk, "nand0-clk1", nand_mmc_parents, 0xc84,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc0_clk, "mmc0", nand_mmc_parents, 0xd00,
> +					     0, 5,	/* M */
> +					     8, 5,	/* P */
> +					     24, 3,	/* mux */
> +					     BIT(31),	/* gate */
> +					     2,		/* post div */
> +					     0);
> +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc1_clk, "mmc1", nand_mmc_parents, 0xd10,
> +					     0, 5,	/* M */
> +					     8, 5,	/* P */
> +					     24, 3,	/* mux */
> +					     BIT(31),	/* gate */
> +					     2,		/* post div */
> +					     0);
> +
> +static const struct clk_parent_data mmc2_mmc3_parents[] = {
> +	{ .hw = &sys_24M_clk.hw, },
> +	{ .hw = &pll_periph0_800M_clk.common.hw },
> +	{ .hw = &pll_periph0_600M_clk.hw },
> +	{ .hw = &pll_periph1_800M_clk.common.hw },
> +	{ .hw = &pll_periph1_600M_clk.hw },
> +};
> +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc2_clk, "mmc2", mmc2_mmc3_parents, 0xd20,
> +					     0, 5,	/* M */
> +					     8, 5,	/* P */
> +					     24, 3,	/* mux */
> +					     BIT(31),	/* gate */
> +					     2,		/* post div */
> +					     0);
> +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc3_clk, "mmc3", mmc2_mmc3_parents, 0xd30,
> +					     0, 5,	/* M */
> +					     8, 5,	/* P */
> +					     24, 3,	/* mux */
> +					     BIT(31),	/* gate */
> +					     2,		/* post div */
> +					     0);
> +
> +static const struct clk_hw *ufs_axi_parents[] = {
> +	&pll_periph0_300M_clk.hw,
> +	&pll_periph0_200M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(ufs_axi_clk, "ufs-axi", ufs_axi_parents, 0xd80,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_parent_data ufs_cfg_parents[] = {
> +	{ .hw = &pll_periph0_480M_clk.common.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ufs_cfg_clk, "ufs-cfg", ufs_cfg_parents, 0xd84,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data spi_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph0_300M_clk.hw },
> +	{ .hw = &pll_periph0_200M_clk.hw },
> +	{ .hw = &pll_periph1_300M_clk.hw },
> +	{ .hw = &pll_periph1_200M_clk.hw },
> +	{ .hw = &pll_periph0_480M_clk.common.hw },
> +	{ .hw = &pll_periph1_480M_clk.common.hw },
> +	{ .fw_name = "hosc"},
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spi0_clk, "spi0", spi_parents, 0xf00,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spi1_clk, "spi1", spi_parents, 0xf08,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spi2_clk, "spi2", spi_parents, 0xf10,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +
> +static const struct clk_parent_data spif_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph0_400M_clk.hw },
> +	{ .hw = &pll_periph0_300M_clk.hw },
> +	{ .hw = &pll_periph1_400M_clk.hw },
> +	{ .hw = &pll_periph1_300M_clk.hw },
> +	{ .hw = &pll_periph0_160M_clk.hw },
> +	{ .hw = &pll_periph1_160M_clk.hw },
> +	{ .fw_name = "hosc"},
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spif_clk, "spif", spif_parents, 0xf18,
> +				  0, 5,		/* M */
> +				  8, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spi3_clk, "spi3", spi_parents, 0xf20,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +/* Undocumented, taken from the vendor kernel. */
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spi4_clk, "spi4", spi_parents, 0xf28,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +
> +static const struct clk_parent_data gpadc0_24m_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "hosc"},
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gpadc0_24m_clk, "gpadc0-24m", gpadc0_24m_parents, 0xfc0,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data irrx_parents[] = {
> +	{ .fw_name = "losc"},
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "hosc"},
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irrx_clk, "irrx", irrx_parents, 0x1000,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data irtx_parents[] = {
> +	{ .fw_name = "losc"},

I think this clock should be sys_24M_clk.

> +	{ .hw = &pll_periph1_600M_clk.hw },
> +	{ .fw_name = "hosc"},
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irtx_clk, "irtx", irtx_parents, 0x1008,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +/* Undocumented, taken from the vendor kernel. */
> +static const struct clk_parent_data sgpio_parents[] = {
> +	{ .fw_name = "losc"},
> +	{ .hw = &sys_24M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(sgpio_clk, "sgpio", sgpio_parents, 0x1060,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +/* Undocumented, taken from the vendor kernel. */
> +static const struct clk_hw *lpc_parents[] = {
> +	&pll_video0_3x_clk.common.hw,
> +	&pll_video1_3x_clk.common.hw,
> +	&pll_video2_3x_clk.common.hw,
> +	&pll_periph0_300M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(lpc_clk, "lpc", lpc_parents, 0x1080,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *i2spcm_parents[] = {
> +	&pll_audio0_4x_clk.common.hw,
> +	&pll_audio1_div2_clk.hw,
> +	&pll_audio1_div5_clk.hw,
> +	&pll_periph0_200M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm0_clk, "i2spcm0", i2spcm_parents, 0x1200,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm1_clk, "i2spcm1", i2spcm_parents, 0x1210,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_clk, "i2spcm2", i2spcm_parents, 0x1220,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *i2spcm2_asrc_parents[] = {
> +	&pll_audio0_4x_clk.common.hw,
> +	&pll_audio1_div2_clk.hw,
> +	&pll_audio1_div5_clk.hw,
> +	&pll_periph0_300M_clk.hw,
> +	&pll_periph1_300M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_asrc_clk, "i2spcm2_asrc", i2spcm2_asrc_parents, 0x1224,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm3_clk, "i2spcm3", i2spcm_parents, 0x1230,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm4_clk, "i2spcm4", i2spcm_parents, 0x1240,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *spdif_tx_parents[] = {
> +	&pll_audio0_4x_clk.common.hw,
> +	&pll_audio1_div2_clk.hw,
> +	&pll_audio1_div5_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(spdif_tx_clk, "spdif-tx", spdif_tx_parents, 0x1280,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *spdif_rx_parents[] = {
> +	&pll_periph0_200M_clk.hw,
> +	&pll_periph0_300M_clk.hw,

The manual I am looking at says those two muxes are "Reserved". So are 
those parents from the BSP? Can you please add a comment about it then?

> +	&pll_periph0_400M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(spdif_rx_clk, "spdif-rx", spdif_rx_parents, 0x1284,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *dmic_parents[] = {
> +	&pll_audio0_4x_clk.common.hw,
> +	&pll_audio1_div2_clk.hw,
> +	&pll_audio1_div5_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(dmic_clk, "dmic", dmic_parents, 0x12c0,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +/*
> + * The first parent is a 48 MHz input clock divided by 4. That 48 MHz clock is
> + * a 2x multiplier from pll-ref synchronized by pll-periph0, and is also used by
> + * the OHCI module.
> + */
> +static const struct clk_parent_data usb_ohci_parents[] = {
> +	{ .hw = &pll_periph0_4x_clk.common.hw },
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +};
> +static const struct ccu_mux_fixed_prediv usb_ohci_predivs[] = {
> +	{ .index = 0, .div = 200 },
> +	{ .index = 1, .div = 2 },
> +};
> +
> +static struct ccu_mux usb_ohci0_clk = {
> +	.enable		= BIT(31),
> +	.mux		= {
> +		.shift		= 24,
> +		.width		= 2,
> +		.fixed_predivs	= usb_ohci_predivs,
> +		.n_predivs	= ARRAY_SIZE(usb_ohci_predivs),
> +	},
> +	.common		= {
> +		.reg		= 0x1300,
> +		.features	= CCU_FEATURE_FIXED_PREDIV,
> +		.hw.init	= CLK_HW_INIT_PARENTS_DATA("usb-ohci0", usb_ohci_parents,
> +							   &ccu_mux_ops, 0),
> +	},
> +};
> +
> +static struct ccu_mux usb_ohci1_clk = {
> +	.enable		= BIT(31),
> +	.mux		= {
> +		.shift		= 24,
> +		.width		= 2,
> +		.fixed_predivs	= usb_ohci_predivs,
> +		.n_predivs	= ARRAY_SIZE(usb_ohci_predivs),
> +	},
> +	.common		= {
> +		.reg		= 0x1308,
> +		.features	= CCU_FEATURE_FIXED_PREDIV,
> +		.hw.init	= CLK_HW_INIT_PARENTS_DATA("usb-ohci1", usb_ohci_parents,
> +							   &ccu_mux_ops, 0),
> +	},
> +};
> +
> +static const struct clk_parent_data usb01_ref_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_MUX_DATA(usb01_ref_clk, "usb01-ref", usb01_ref_parents, 0x1340, 24, 3, 0);
> +
> +static SUNXI_CCU_MUX_DATA(usb2_u2_ref_clk, "usb2-u2-ref", usb01_ref_parents, 0x1348, 24, 3, 0);

Don't these two clocks miss the gate at bit 31? So it should be 
SUNXI_CCU_MUX_DATA_WITH_GATE instead?

 > +
> +static const struct clk_parent_data usb2_suspend_parents[] = {
> +	{ .fw_name = "losc" },
> +	{ .hw = &sys_24M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_suspend_clk, "usb2-suspend", usb2_suspend_parents,
> +				      0x1350,
> +				      0, 5,	/* M */
> +				      24, 1,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data usb2_mf_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph0_300M_clk.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_mf_clk, "usb2-mf", usb2_mf_parents,
> +				      0x1354,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data usb2_u3_utmi_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph0_300M_clk.hw },
> +	{ .fw_name = "hosc" },

Aren't those parents exactly the same as the usb2_mf_parents[] above?
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_u3_utmi_clk, "usb2-u3-utmi", usb2_u3_utmi_parents,
> +				      0x1360,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data usb2_u2_pipe_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph0_480M_clk.common.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_u2_pipe_clk, "usb2-u2-pipe", usb2_u2_pipe_parents,
> +				      0x1364,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data pcie_aux_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "losc" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(pcie_aux_clk, "pcie-aux", pcie_aux_parents, 0x1380,
> +				      0, 5,	/* M */
> +				      24, 1,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_hw *pcie_axi_slv_parents[] = {
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(pcie_axi_slv_clk, "pcie-axi-slv", pcie_axi_slv_parents, 0x1384,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *serdes_phy_parents[] = {
> +	&sys_24M_clk.hw,
> +	&pll_periph0_600M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(serdes_phy_clk, "serdes-phy", serdes_phy_parents, 0x13c0,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_parent_data gmac_ptp_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph0_200M_clk.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gmac_ptp_clk, "gmac-ptp", gmac_ptp_parents, 0x1400,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_M_HWS_WITH_GATE(gmac0_phy_clk, "gmac0-phy", pll_periph0_150M_hws, 0x1410,
> +				 0, 5,		/* M */
> +				 BIT(31),	/* gate */
> +				 0);
> +/* Undocumented, taken from the vendor kernel. */
> +static SUNXI_CCU_M_HWS_WITH_GATE(gmac1_phy_clk, "gmac1-phy", pll_periph0_150M_hws, 0x1420,
> +				 0, 5,		/* M */
> +				 BIT(31),	/* gate */
> +				 0);
> +
> +static const struct clk_hw *tcon_lcd_parents[] = {
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_periph0_2x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd0_clk, "tcon-lcd0", tcon_lcd_parents, 0x1500,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd1_clk, "tcon-lcd1", tcon_lcd_parents, 0x1508,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +/* Undocumented, taken from the vendor kernel. */
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd2_clk, "tcon-lcd2", tcon_lcd_parents, 0x1510,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *dsi_parents[] = {
> +	&sys_24M_clk.hw,
> +	&pll_periph0_200M_clk.hw,
> +	&pll_periph0_150M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(dsi0_clk, "dsi0", dsi_parents, 0x1580,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(dsi1_clk, "dsi1", dsi_parents, 0x1588,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *combphy_parents[] = {
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_periph0_2x_clk.common.hw,
> +	&pll_video0_3x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(combphy0_clk, "combphy0", combphy_parents, 0x15c0,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(combphy1_clk, "combphy1", combphy_parents, 0x15c4,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *edp_tv_parents[] = {
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_periph0_2x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_tv_clk, "edp-tv", edp_tv_parents, 0x1640,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);

There is a second divider range from bits [12:8].

> +
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k", pll_periph0_2x_hws, 0x1680,
> +				      BIT(30),	/* gate */
> +				      36621,	/* pre div */
> +				      0);
> +
> +static const struct clk_parent_data hdmi_cec_parents[] = {
> +	{ .fw_name = "losc" },
> +	{ .hw = &hdmi_cec_32k_clk.common.hw },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk, "hdmi-cec", hdmi_cec_parents, 0x1680,
> +				    24, 1,	/* mux */

Even though there are indeed only two choices, the manual still 
specifies the mux bits as ranging from [26:24] (as for many other clocks).

> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_parent_data hdmi_tv_parents[] = {
> +	{ .hw = &pll_video0_4x_clk.common.hw },
> +	{ .hw = &pll_video1_4x_clk.common.hw },
> +	{ .hw = &pll_video2_4x_clk.common.hw },
> +	{ .hw = &pll_periph0_2x_clk.common.hw },
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(hdmi_tv_clk, "hdmi-tv", hdmi_tv_parents, 0x1684,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +
> +static const struct clk_parent_data hdmi_sfr_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_sfr_clk, "hdmi-sfr", hdmi_sfr_parents, 0x1690,
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static SUNXI_CCU_GATE_HWS(hdcp_esm_clk, "hdcp-esm", pll_periph0_300M_hws, 0x1694, BIT(31), 0);
> +
> +static const struct clk_parent_data ledc_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph0_600M_clk.hw },
> +	{ .fw_name = "hosc" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ledc_parents, 0x1700,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data csi_master_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_video0_4x_clk.common.hw },
> +	{ .hw = &pll_video0_3x_clk.common.hw },
> +	{ .hw = &pll_video1_4x_clk.common.hw },
> +	{ .hw = &pll_video1_3x_clk.common.hw },
> +	{ .hw = &pll_video2_4x_clk.common.hw },
> +	{ .hw = &pll_video2_3x_clk.common.hw },
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master0_clk, "csi_master0", csi_master_parents, 0x1800,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master1_clk, "csi_master1", csi_master_parents, 0x1804,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master2_clk, "csi_master2", csi_master_parents, 0x1808,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +
> +static const struct clk_hw *csi_parents[] = {
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_de_4x_clk.common.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_600M_clk.hw,

My manual lists two more parents: video0_4x and video1_4x.

> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_clk, "csi", csi_parents, 0x1840,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *isp_parents[] = {
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_600M_clk.hw,
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(isp_clk, "isp", isp_parents, 0x1860,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static SUNXI_CCU_GATE_DATA(res_dcap_24m_clk, "res-dcap-24m", hosc, 0x1a00, BIT(3), 0);
> +
> +static const struct clk_parent_data apb2jtag_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +	{ .hw = &pll_periph0_480M_clk.common.hw },
> +	{ .hw = &pll_periph1_480M_clk.common.hw },
> +	{ .hw = &pll_periph0_200M_clk.hw },
> +	{ .hw = &pll_periph1_200M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(apb2jtag_clk, "apb2jtag", apb2jtag_parents, 0x1c00,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_GATE_HWS(fanout_24M_clk, "fanout-24M", sys_24M_hws, 0x1f30, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_12M_clk, "fanout-12M", sys_24M_hws, 0x1f30,
> +				      BIT(1), 2, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_16M_clk, "fanout-16M", pll_periph0_480M_hws, 0x1f30,
> +				      BIT(2), 30, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_25M_clk, "fanout-25M", pll_periph0_2x_hws, 0x1f30,
> +				      BIT(3), 48, 0);

Where do those parents come from? My manual just lists the frequencies.
Is that matching the 0x1f3c register sources?

The rest seems to be correct, as far as my mostly manual comparison goes.

Cheers,
Andre

> +
> +static const struct clk_parent_data fanout_27M_parents[] = {
> +	{ .hw = &pll_video0_4x_clk.common.hw },
> +	{ .hw = &pll_video1_4x_clk.common.hw },
> +	{ .hw = &pll_video2_4x_clk.common.hw },
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(fanout_27M_clk, "fanout-27M", fanout_27M_parents, 0x1f34,
> +				  0, 5,		/* M */
> +				  8, 5,		/* N */
> +				  24, 2,	/* mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +
> +static const struct clk_parent_data fanout_pclk_parents[] = {
> +	{ .hw = &apb0_clk.common.hw }
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(fanout_pclk_clk, "fanout-pclk", fanout_pclk_parents, 0x1f38,
> +				  0, 5,		/* M */
> +				  5, 5,		/* N */
> +				  0, 0,		/* no mux */
> +				  BIT(31),	/* gate */
> +				  0);
> +
> +static const struct clk_parent_data fanout_parents[] = {
> +	{ .fw_name = "losc-fanout" },
> +	{ .hw = &fanout_12M_clk.common.hw, },
> +	{ .hw = &fanout_16M_clk.common.hw, },
> +	{ .hw = &fanout_24M_clk.common.hw, },
> +	{ .hw = &fanout_25M_clk.common.hw, },
> +	{ .hw = &fanout_27M_clk.common.hw, },
> +	{ .hw = &fanout_pclk_clk.common.hw, },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout0_clk, "fanout0", fanout_parents, 0x1f3c,
> +				    0, 3,	/* mux */
> +				    BIT(21),	/* gate */
> +				    0);
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout1_clk, "fanout1", fanout_parents, 0x1f3c,
> +				    3, 3,	/* mux */
> +				    BIT(22),	/* gate */
> +				    0);
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout2_clk, "fanout2", fanout_parents, 0x1f3c,
> +				    6, 3,	/* mux */
> +				    BIT(23),	/* gate */
> +				    0);
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout3_clk, "fanout3", fanout_parents, 0x1f3c,
> +				    9, 3,	/* mux */
> +				    BIT(24),	/* gate */
> +				    0);
> +
>   /*
>    * Contains all clocks that are controlled by a hardware register. They
>    * have a (sunxi) .common member, which needs to be initialised by the common
> @@ -552,6 +1465,101 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
>   	&trace_clk.common,
>   	&gic_clk.common,
>   	&mbus_clk.common,
> +	&timer0_clk.common,
> +	&timer1_clk.common,
> +	&timer2_clk.common,
> +	&timer3_clk.common,
> +	&timer4_clk.common,
> +	&timer5_clk.common,
> +	&timer6_clk.common,
> +	&timer7_clk.common,
> +	&timer8_clk.common,
> +	&timer9_clk.common,
> +	&avs_clk.common,
> +	&de0_clk.common,
> +	&di_clk.common,
> +	&g2d_clk.common,
> +	&eink_clk.common,
> +	&eink_panel_clk.common,
> +	&ve_enc0_clk.common,
> +	&ve_dec0_clk.common,
> +	&ce_clk.common,
> +	&npu_clk.common,
> +	&gpu0_clk.common,
> +	&dram0_clk.common,
> +	&nand0_clk0_clk.common,
> +	&nand0_clk1_clk.common,
> +	&mmc0_clk.common,
> +	&mmc1_clk.common,
> +	&mmc2_clk.common,
> +	&mmc3_clk.common,
> +	&ufs_axi_clk.common,
> +	&ufs_cfg_clk.common,
> +	&spi0_clk.common,
> +	&spi1_clk.common,
> +	&spi2_clk.common,
> +	&spif_clk.common,
> +	&spi3_clk.common,
> +	&spi4_clk.common,
> +	&gpadc0_24m_clk.common,
> +	&irrx_clk.common,
> +	&irtx_clk.common,
> +	&sgpio_clk.common,
> +	&lpc_clk.common,
> +	&i2spcm0_clk.common,
> +	&i2spcm1_clk.common,
> +	&i2spcm2_clk.common,
> +	&i2spcm2_asrc_clk.common,
> +	&i2spcm3_clk.common,
> +	&i2spcm4_clk.common,
> +	&spdif_tx_clk.common,
> +	&spdif_rx_clk.common,
> +	&dmic_clk.common,
> +	&usb_ohci0_clk.common,
> +	&usb_ohci1_clk.common,
> +	&usb01_ref_clk.common,
> +	&usb2_u2_ref_clk.common,
> +	&usb2_suspend_clk.common,
> +	&usb2_mf_clk.common,
> +	&usb2_u3_utmi_clk.common,
> +	&usb2_u2_pipe_clk.common,
> +	&pcie_aux_clk.common,
> +	&pcie_axi_slv_clk.common,
> +	&serdes_phy_clk.common,
> +	&gmac_ptp_clk.common,
> +	&gmac0_phy_clk.common,
> +	&gmac1_phy_clk.common,
> +	&tcon_lcd0_clk.common,
> +	&tcon_lcd1_clk.common,
> +	&tcon_lcd2_clk.common,
> +	&dsi0_clk.common,
> +	&dsi1_clk.common,
> +	&combphy0_clk.common,
> +	&combphy1_clk.common,
> +	&edp_tv_clk.common,
> +	&hdmi_cec_32k_clk.common,
> +	&hdmi_cec_clk.common,
> +	&hdmi_tv_clk.common,
> +	&hdmi_sfr_clk.common,
> +	&hdcp_esm_clk.common,
> +	&ledc_clk.common,
> +	&csi_master0_clk.common,
> +	&csi_master1_clk.common,
> +	&csi_master2_clk.common,
> +	&csi_clk.common,
> +	&isp_clk.common,
> +	&res_dcap_24m_clk.common,
> +	&apb2jtag_clk.common,
> +	&fanout_24M_clk.common,
> +	&fanout_12M_clk.common,
> +	&fanout_16M_clk.common,
> +	&fanout_25M_clk.common,
> +	&fanout_27M_clk.common,
> +	&fanout_pclk_clk.common,
> +	&fanout0_clk.common,
> +	&fanout1_clk.common,
> +	&fanout2_clk.common,
> +	&fanout3_clk.common,
>   };
>   
>   static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
> @@ -606,6 +1614,101 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
>   		[CLK_TRACE]		= &trace_clk.common.hw,
>   		[CLK_GIC]		= &gic_clk.common.hw,
>   		[CLK_MBUS]		= &mbus_clk.common.hw,
> +		[CLK_TIMER0]		= &timer0_clk.common.hw,
> +		[CLK_TIMER1]		= &timer1_clk.common.hw,
> +		[CLK_TIMER2]		= &timer2_clk.common.hw,
> +		[CLK_TIMER3]		= &timer3_clk.common.hw,
> +		[CLK_TIMER4]		= &timer4_clk.common.hw,
> +		[CLK_TIMER5]		= &timer5_clk.common.hw,
> +		[CLK_TIMER6]		= &timer6_clk.common.hw,
> +		[CLK_TIMER7]		= &timer7_clk.common.hw,
> +		[CLK_TIMER8]		= &timer8_clk.common.hw,
> +		[CLK_TIMER9]		= &timer9_clk.common.hw,
> +		[CLK_AVS]		= &avs_clk.common.hw,
> +		[CLK_DE0]		= &de0_clk.common.hw,
> +		[CLK_DI]		= &di_clk.common.hw,
> +		[CLK_G2D]		= &g2d_clk.common.hw,
> +		[CLK_EINK]		= &eink_clk.common.hw,
> +		[CLK_EINK_PANEL]	= &eink_panel_clk.common.hw,
> +		[CLK_VE_ENC0]		= &ve_enc0_clk.common.hw,
> +		[CLK_VE_DEC0]		= &ve_dec0_clk.common.hw,
> +		[CLK_CE]		= &ce_clk.common.hw,
> +		[CLK_NPU]		= &npu_clk.common.hw,
> +		[CLK_GPU0]		= &gpu0_clk.common.hw,
> +		[CLK_DRAM0]		= &dram0_clk.common.hw,
> +		[CLK_NAND0_CLK0]	= &nand0_clk0_clk.common.hw,
> +		[CLK_NAND0_CLK1]	= &nand0_clk1_clk.common.hw,
> +		[CLK_MMC0]		= &mmc0_clk.common.hw,
> +		[CLK_MMC1]		= &mmc1_clk.common.hw,
> +		[CLK_MMC2]		= &mmc2_clk.common.hw,
> +		[CLK_MMC3]		= &mmc3_clk.common.hw,
> +		[CLK_UFS_AXI]		= &ufs_axi_clk.common.hw,
> +		[CLK_UFS_CFG]		= &ufs_cfg_clk.common.hw,
> +		[CLK_SPI0]		= &spi0_clk.common.hw,
> +		[CLK_SPI1]		= &spi1_clk.common.hw,
> +		[CLK_SPI2]		= &spi2_clk.common.hw,
> +		[CLK_SPIF]		= &spif_clk.common.hw,
> +		[CLK_SPI3]		= &spi3_clk.common.hw,
> +		[CLK_SPI4]		= &spi4_clk.common.hw,
> +		[CLK_GPADC0_24M]	= &gpadc0_24m_clk.common.hw,
> +		[CLK_IRRX]		= &irrx_clk.common.hw,
> +		[CLK_IRTX]		= &irtx_clk.common.hw,
> +		[CLK_SGPIO]		= &sgpio_clk.common.hw,
> +		[CLK_LPC]		= &lpc_clk.common.hw,
> +		[CLK_I2SPCM0]		= &i2spcm0_clk.common.hw,
> +		[CLK_I2SPCM1]		= &i2spcm1_clk.common.hw,
> +		[CLK_I2SPCM2]		= &i2spcm2_clk.common.hw,
> +		[CLK_I2SPCM2_ASRC]	= &i2spcm2_asrc_clk.common.hw,
> +		[CLK_I2SPCM3]		= &i2spcm3_clk.common.hw,
> +		[CLK_I2SPCM4]		= &i2spcm4_clk.common.hw,
> +		[CLK_SPDIF_TX]		= &spdif_tx_clk.common.hw,
> +		[CLK_SPDIF_RX]		= &spdif_rx_clk.common.hw,
> +		[CLK_DMIC]		= &dmic_clk.common.hw,
> +		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
> +		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
> +		[CLK_USB01_REF]		= &usb01_ref_clk.common.hw,
> +		[CLK_USB2_U2_REF]	= &usb2_u2_ref_clk.common.hw,
> +		[CLK_USB2_SUSPEND]	= &usb2_suspend_clk.common.hw,
> +		[CLK_USB2_MF]		= &usb2_mf_clk.common.hw,
> +		[CLK_USB2_U3_UTMI]	= &usb2_u3_utmi_clk.common.hw,
> +		[CLK_USB2_U2_PIPE]	= &usb2_u2_pipe_clk.common.hw,
> +		[CLK_PCIE_AUX]		= &pcie_aux_clk.common.hw,
> +		[CLK_PCIE_AXI_SLV]	= &pcie_axi_slv_clk.common.hw,
> +		[CLK_SERDES_PHY]	= &serdes_phy_clk.common.hw,
> +		[CLK_GMAC_PTP]		= &gmac_ptp_clk.common.hw,
> +		[CLK_GMAC0_PHY]		= &gmac0_phy_clk.common.hw,
> +		[CLK_GMAC1_PHY]		= &gmac1_phy_clk.common.hw,
> +		[CLK_TCON_LCD0]		= &tcon_lcd0_clk.common.hw,
> +		[CLK_TCON_LCD1]		= &tcon_lcd1_clk.common.hw,
> +		[CLK_TCON_LCD2]		= &tcon_lcd2_clk.common.hw,
> +		[CLK_DSI0]		= &dsi0_clk.common.hw,
> +		[CLK_DSI1]		= &dsi1_clk.common.hw,
> +		[CLK_COMBPHY0]		= &combphy0_clk.common.hw,
> +		[CLK_COMBPHY1]		= &combphy1_clk.common.hw,
> +		[CLK_EDP_TV]		= &edp_tv_clk.common.hw,
> +		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
> +		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
> +		[CLK_HDMI_TV]		= &hdmi_tv_clk.common.hw,
> +		[CLK_HDMI_SFR]		= &hdmi_sfr_clk.common.hw,
> +		[CLK_HDCP_ESM]		= &hdcp_esm_clk.common.hw,
> +		[CLK_LEDC]		= &ledc_clk.common.hw,
> +		[CLK_CSI_MASTER0]	= &csi_master0_clk.common.hw,
> +		[CLK_CSI_MASTER1]	= &csi_master1_clk.common.hw,
> +		[CLK_CSI_MASTER2]	= &csi_master2_clk.common.hw,
> +		[CLK_CSI]		= &csi_clk.common.hw,
> +		[CLK_ISP]		= &isp_clk.common.hw,
> +		[CLK_RES_DCAP_24M]	= &res_dcap_24m_clk.common.hw,
> +		[CLK_APB2JTAG]		= &apb2jtag_clk.common.hw,
> +		[CLK_FANOUT_24M]	= &fanout_24M_clk.common.hw,
> +		[CLK_FANOUT_12M]	= &fanout_12M_clk.common.hw,
> +		[CLK_FANOUT_16M]	= &fanout_16M_clk.common.hw,
> +		[CLK_FANOUT_25M]	= &fanout_25M_clk.common.hw,
> +		[CLK_FANOUT_27M]	= &fanout_27M_clk.common.hw,
> +		[CLK_FANOUT_PCLK]	= &fanout_pclk_clk.common.hw,
> +		[CLK_FANOUT0]		= &fanout0_clk.common.hw,
> +		[CLK_FANOUT1]		= &fanout1_clk.common.hw,
> +		[CLK_FANOUT2]		= &fanout2_clk.common.hw,
> +		[CLK_FANOUT3]		= &fanout3_clk.common.hw,
>   	},
>   	.num	= CLK_FANOUT3 + 1,
>   };
> 

