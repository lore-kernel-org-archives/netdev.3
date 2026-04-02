Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253138C2C7;
	Thu,  2 Apr 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124364; cv=none; b=ai0pgXujaqd39CZLzEVdJzXL+DvjGHwuA6iNCxsWbDQCJG9+9q7lLUUALd+qH51lAqYJnU8rGiPSz0vDyvDakTW2427OPDH/Uw6bignNHTXx7wkSAfkWkIZrZ/DPyUEVc/vK3WQQL9SteV4Lb2zzcl6AIfttu3DFsrIbHicyTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124364; c=relaxed/simple;
	bh=D4kfl7vQPG5i2TDOvaJ3hANWJtrLLrfKi0I6ESNoUBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOIsHoOcR2rue9YOMlbL/Lz1UxAOUOGqH5rdzfUiu3r2jvTFPcA/Qs3VoxoGQc+rzOtpWNwVzT/onPO1Ya5P9sGdoO4L2lhM9OQgbwteLFR2uUK1RWqNvFWuFa6XqhEWxNDOzcwA/idP45j1RV81D7w5yeRoicEMdKOZxafVxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nRHJM3au; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nRHJM3au"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1775124355;
	bh=D4kfl7vQPG5i2TDOvaJ3hANWJtrLLrfKi0I6ESNoUBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRHJM3auCioWf+U0lXNf1DZ9gI4HLqoLnXqJQpjK6TuZsG9eGFNv66ISHZTp2Fsf9
	 4+KQuuqnFfDlcwxSRhSX9dCkDB05hBwx3nPMGi7F0x1EFo1spXfrGcB/J5NQCl/nh3
	 ag9YWUXhz1aubhJ/gq27GHnYIVutjnU6rioAydOUSPF8+8HLcbzc+n9G7OB/a34IHm
	 sWAE+DffuBhhDmc7g1NV38A/CoWRxmoWbg7sdMGLOiGQjDjcmE4sLuevU4vfqgTCNU
	 F8wZT8Mct0gVg9s3Uy8Forr2bfWqRAziqSbeVIDa6a8SdQTVY7t28t7DtfnbqBQ0LN
	 qUi7hMlU4TDhg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:54e2:77ca:8340:99bd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 19DCC17E76A5;
	Thu,  2 Apr 2026 12:05:54 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: jason-jh.lin@mediatek.com
Cc: Guangjie.Song@mediatek.com,
	Nancy.Lin@mediatek.com,
	Paul-pl.Chen@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Singo.Chang@mediatek.com,
	Sirius.Wang@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	nfraprado@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org,
	wenst@chromium.org
Subject: Re: [PATCH v5 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Date: Thu,  2 Apr 2026 12:05:38 +0200
Message-Id: <20260402100538.27291-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2d418383ff2d6ff40ffb3b4f8e2b0c0e665c3b58.camel@mediatek.com>
References: <2d418383ff2d6ff40ffb3b4f8e2b0c0e665c3b58.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason-JH,

On 4/2/26 08:30, Jason-JH Lin (林睿祥) wrote:
> On Fri, 2025-08-29 at 11:19 +0200, Laura Nao wrote:
>> Add support for the MT8196 disp-ao clock controller, which provides
>> clock gate control for the display system. It is integrated with the
>> mtk-mmsys driver, which registers the disp-ao clock driver via
>> platform_device_register_data().
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Reviewed-by: AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>  drivers/clk/mediatek/Makefile              |  2 +-
>>  drivers/clk/mediatek/clk-mt8196-vdisp_ao.c | 80
>> ++++++++++++++++++++++
>>  2 files changed, 81 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
>>
>> diff --git a/drivers/clk/mediatek/Makefile
>> b/drivers/clk/mediatek/Makefile
>> index fe5699411d8b..5b8969ff1985 100644
>> --- a/drivers/clk/mediatek/Makefile
>> +++ b/drivers/clk/mediatek/Makefile
>> @@ -157,7 +157,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) +=
>> clk-mt8196-imp_iic_wrap.o
>>  obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
>>  obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
>>  obj-$(CONFIG_COMMON_CLK_MT8196_MFGCFG) += clk-mt8196-mfg.o
>> -obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-
>> mt8196-disp1.o
>> +obj-$(CONFIG_COMMON_CLK_MT8196_MMSYS) += clk-mt8196-disp0.o clk-
>> mt8196-disp1.o clk-mt8196-vdisp_ao.o
>>  obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
>>  obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
>>  obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-
>> mt8365.o
>> diff --git a/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
>> b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
>> new file mode 100644
>> index 000000000000..fddb69d1c3eb
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
>> @@ -0,0 +1,80 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2025 MediaTek Inc.
>> + *                    Guangjie Song <guangjie.song@mediatek.com>
>> + * Copyright (c) 2025 Collabora Ltd.
>> + *                    Laura Nao <laura.nao@collabora.com>
>> + */
>> +#include <dt-bindings/clock/mediatek,mt8196-clock.h>
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-gate.h"
>> +#include "clk-mtk.h"
>> +
>> +static const struct mtk_gate_regs mm_v_cg_regs = {
>> +	.set_ofs = 0x104,
>> +	.clr_ofs = 0x108,
>> +	.sta_ofs = 0x100,
>> +};
>> +
>> +static const struct mtk_gate_regs mm_v_hwv_regs = {
>> +	.set_ofs = 0x0030,
>> +	.clr_ofs = 0x0034,
>> +	.sta_ofs = 0x2c18,
>> +};
>> +
>> +#define GATE_MM_AO_V(_id, _name, _parent, _shift) {	\
>> +		.id = _id,				\
>> +		.name = _name,				\
>> +		.parent_name = _parent,			\
>> +		.regs = &mm_v_cg_regs,			\
>> +		.shift = _shift,			\
>> +		.ops = &mtk_clk_gate_ops_setclr,	\
>> +		.flags = CLK_OPS_PARENT_ENABLE |	\
>> +			 CLK_IS_CRITICAL,		\
>> +	}
>> +
>> +#define GATE_HWV_MM_V(_id, _name, _parent, _shift) {	\
>> +		.id = _id,				\
>> +		.name = _name,				\
>> +		.parent_name = _parent,			\
>> +		.regs = &mm_v_cg_regs,			\
>> +		.hwv_regs = &mm_v_hwv_regs,		\
>> +		.shift = _shift,			\
>> +		.ops = &mtk_clk_gate_hwv_ops_setclr,	\
>> +		.flags = CLK_OPS_PARENT_ENABLE,		\
>> +	}
>> +
>> +static const struct mtk_gate mm_v_clks[] = {
>> +	GATE_HWV_MM_V(CLK_MM_V_DISP_VDISP_AO_CONFIG,
>> "mm_v_disp_vdisp_ao_config", "disp", 0),
>> +	GATE_HWV_MM_V(CLK_MM_V_DISP_DPC, "mm_v_disp_dpc", "disp",
>> 16),
>> +	GATE_MM_AO_V(CLK_MM_V_SMI_SUB_SOMM0, "mm_v_smi_sub_somm0",
>> "disp", 2),
>> +};
>> +
>> +static const struct mtk_clk_desc mm_v_mcd = {
>> +	.clks = mm_v_clks,
>> +	.num_clks = ARRAY_SIZE(mm_v_clks),
>> +};
>> +
>> +static const struct of_device_id of_match_clk_mt8196_vdisp_ao[] = {
>> +	{ .compatible = "mediatek,mt8196-vdisp-ao", .data =
>> &mm_v_mcd },
>
> Hi Laura,
>
> We are going to send mtk-mmsys driver for MT8196 recently, but we found
> the compatible name is used here.
>
> As your commit message, vdisp-ao is integrated with the mtk-mmsys
> driver, which registers the vdisp-ao clock driver via 
> platform_device_register_data().
>
> Shouldn't this compatible name belong to mmsys driver for MT8196?
>

That's right, my fault for missing that! Thanks for the heads up.

I'm aware Angelo is currently restructuring mediatek-drm (including 
mmsys and mutex), and that might affect the way vdisp-ao is loaded too. 
So I'm not sure whether it makes sense to send a patch to fix this 
right away.

Best,

Laura

