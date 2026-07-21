Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C636B048
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675067; cv=none; b=DtzCZgt45suYNXvvldaCzBp+nsYTjp60i4FAjWsg2Da97rw8JysIET1YLMp8g5UuEHEihmJ6eL3CAer/MFUIVHxVGH8gdpFObkBJ3qvT8dFY+6y1P/xhMntI+C9A7pQ1CMK7gSqt1EC/dX6rqIXAU9XIAyDA6uTtDXFNX+hRHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675067; c=relaxed/simple;
	bh=xgOxOMovpA25BbgSbz35rwS0VQ0yjeoylBXXLZfEkck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBnY7m6LEItpjsVnEJYCRouWg2SXEP7kumiBAiOVMGjmgWi94MPYu8mkLjoyTkbsuKCoQTujpG/emkpf5Pb2dIvE1vnAcJUkcuiYBS0nXrHpIq3kqU85FZyCD88l2q5o1zs3RDIst3oP7TFvgFAyj1tZXQPrO8q92K71fIc0wC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGexj/wp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6IvSn/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGexj/wp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6IvSn/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784675061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9jxxoNk0Zci913QIrLSshdt2n65M0x+d9IlMGmwHh4=;
	b=EGexj/wpbzem8GSRnIILKx3VU9LaKh7QcOPFMgWyfbZPKHOlyJJi1ANfLQR1blR+dWtjJC
	sC9LqM3/P133JwMMepKC6Kp6jM7uRi8cd+m3OCk6l6+jIAyKGOycPoM47HMPFd4kGEIlff
	hkrDWpR9ELi9uGF+feLdqv1p7kibZLM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-l9GqIldfNNel5bu5MEpCug-1; Tue, 21 Jul 2026 19:04:20 -0400
X-MC-Unique: l9GqIldfNNel5bu5MEpCug-1
X-Mimecast-MFC-AGG-ID: l9GqIldfNNel5bu5MEpCug_1784675060
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f113592bf3so185745626d6.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784675060; x=1785279860; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z9jxxoNk0Zci913QIrLSshdt2n65M0x+d9IlMGmwHh4=;
        b=f6IvSn/D+R+eg/nK/xBdXFNTy52hDpsHHUCWr7Ueq5xmBR0PGn0dyykgtaGMEEl207
         VSyd/e2BpQoXHShxhGdy7kWdxyBXZJa8OlNrln0pN6E2dKJz+JnItmfNi440NeBPeron
         eRx5TYxrYVyb8oV18rSsLVImP0q49Oj1zItZ6vZKYhA2YnFtjRGV8Uw+iRNO2z0LSANg
         9eh+uhGAbNO32zThJUyeoygSA+Nr95NFcdaxVREDqWQO0HMRMejP61co+aoXjdnp6CGe
         g0yl0ZfXBEkUrCkJHzFOF7Wfcd/fSJ0cZCCtHia+GybhnFbxhzYLsNL+x8Khp2ybuiIW
         UViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675060; x=1785279860;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9jxxoNk0Zci913QIrLSshdt2n65M0x+d9IlMGmwHh4=;
        b=nkpb4NU05KELdY/ttF0ZuhwnnMDhU5UgyTuCFyTwhvp/cz6XGm7hvIsd6oE+0FMVal
         UWQa63mLBTpn5DyN89nm94i2O7iwVZmcDWuELCopALTdkZiBdz62beXKIqnOMO5g4rgM
         OEwGRRq5fU6vDIe9d39SVdmDsn6w70zDgICgQ58/cWJeD2OizbCZJn8yccTCVDxs0dRI
         ubNaq8qf6R9Foq+T0kjuMmQctEL8ZL4zhlFRWUWOLa/BmsBJxh8O7qD9nuF2G/Qhnio+
         59AANVuckQ2+29ulpl7cmO/dE1ROT5FAWra90SggcBRmyGYwvGUJs+T4rf1WAKWo1kyu
         fafA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5Pl1l6RYIXmDjE3BapAGcr27DtErgB3J8ysdHex9oUiGLKUAGc1smkBBS8zEypLbITMtaFqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxdbGFuJjA5tJPRGChT+1kmf2tMPK73Py488Ll3deBXC8Snfc
	UaDdF5Cmh1xJEE9M1r9vsRc+fARGVHym8EWV52xjhwhkqEzDW8Fw9UAZeMYGT8g8H0EirYJ2rIU
	bOTVcEI1Iw+9+VKC8HOp0SZz3Kesq2Un2WhzDnRfHK9KLj2S4wMnbWtFMUA==
X-Gm-Gg: AR+sD124k73HfJ0KUGIQJo24x2A7hhvaYT/WpY6Wl5Lpum/ufn17QivAJrHghWg74Bz
	JYhwUyqBkX+YIjLDL5m618yL3toQ1XlLmKOiN4LKuq+x+/SZl1sy0ugtzd01PNMjLlpc/m9j4o4
	jWouOjvIhNR+0tNVxN6O+oC0yAahvkRr58XTDbJIvprLkz3FTKboaTYqt1zAZbl3vbo2oeuQjKH
	0DNJsqz+bMzpcFxhy5uIe6ne3UfVl+ZjNvF2TXw0cy++17s/eyNkWjFLcBAYbGQ9LLJRcMsCJ9O
	QtaPq1K4VX1abvvdI0L5EsAQDaZP1HLpmQkpYGNtLbFvTxO/iMsu/Pgfa+sl4rBZQD88CDjPf33
	GdvKyUqzvtJh6wgI5xQGqjvQHVTzKdbNXlAc=
X-Received: by 2002:a05:6214:2301:b0:8ce:ca7d:b099 with SMTP id 6a1803df08f44-9077832dd19mr216149156d6.18.1784675059738;
        Tue, 21 Jul 2026 16:04:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2301:b0:8ce:ca7d:b099 with SMTP id 6a1803df08f44-9077832dd19mr216148766d6.18.1784675059293;
        Tue, 21 Jul 2026 16:04:19 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba9e13d1sm7062316d6.28.2026.07.21.16.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:04:18 -0700 (PDT)
Date: Tue, 21 Jul 2026 19:04:16 -0400
From: Brian Masney <bmasney@redhat.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Irving-CH Lin <irving-ch.lin@mediatek.com>
Subject: Re: [PATCH v3 09/18] clk: mediatek: Add MT8189 apmixedsys clock
 support
Message-ID: <al_68GlP01W0US0x@redhat.com>
References: <20260720-mt8189-clocks-system-base-v3-0-8e6d99ab3ad2@collabora.com>
 <20260720-mt8189-clocks-system-base-v3-9-8e6d99ab3ad2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-mt8189-clocks-system-base-v3-9-8e6d99ab3ad2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Louis-Alexis,

On Mon, Jul 20, 2026 at 12:04:19PM +0200, Louis-Alexis Eyraud wrote:
> Add support for the MT8189 apmixedsys clock controller, which provides
> PLLs generated from SoC 26m.
> 
> Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig                 |  13 ++
>  drivers/clk/mediatek/Makefile                |   1 +
>  drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 196 +++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 2c09fd729bab..f67dfb6cd019 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -815,6 +815,19 @@ config COMMON_CLK_MT8188_WPESYS
>  	help
>  	  This driver supports MediaTek MT8188 Warp Engine clocks.
>  
> +config COMMON_CLK_MT8189
> +	tristate "Clock driver for MediaTek MT8189"
> +	depends on ARM64 || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	select COMMON_CLK_MEDIATEK_FHCTL
> +	default ARCH_MEDIATEK
> +	help
> +	  Enable this option to support the clock management for MediaTek MT8189 SoC. This
> +	  includes handling of all primary clock functions and features specific to the MT8189
> +	  platform. Enabling this driver ensures that the system's clock functionality aligns
> +	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
> +	  clock speeds and power consumption.
> +
>  config COMMON_CLK_MT8192
>  	tristate "Clock driver for MediaTek MT8192"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index d8736a060dbd..66577ccb9b93 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
> +obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o
>  obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> new file mode 100644
> index 000000000000..0657a50c30d9
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025-2026 MediaTek Inc.
> + *                    Qiqi Wang <qiqi.wang@mediatek.com>
> + *                    Irving-CH Lin <irving-ch.lin@mediatek.com>
> + * Copyright (C) 2026 Collabora Ltd.
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

The list of includes here seems excessive, especially compared to the
later files in this series.

> +
> +#include "clk-fhctl.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
> +
> +#include <dt-bindings/clock/mediatek,mt8189-clk.h>
> +
> +#define MT8189_PLL_FMAX		(3800UL * MHZ)
> +#define MT8189_PLL_FMIN		(1500UL * MHZ)
> +#define MT8189_PLLEN_OFS	0x70
> +#define MT8189_INTEGER_BITS	8
> +
> +#define PLL_SETCLR(_id, _name, _reg, _en_setclr_bit,		\
> +			_rstb_setclr_bit, _flags, _pd_reg,	\
> +			_pd_shift, _tuner_reg, _tuner_en_reg,	\
> +			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
> +			_pcwbits) {				\
> +		.id = _id,					\
> +		.name = _name,					\
> +		.en_reg = MT8189_PLLEN_OFS,			\
> +		.reg = _reg,					\
> +		.pll_en_bit = _en_setclr_bit,			\
> +		.rst_bar_mask = BIT(_rstb_setclr_bit),		\
> +		.flags = _flags,				\
> +		.fmax = MT8189_PLL_FMAX,			\
> +		.fmin = MT8189_PLL_FMIN,			\
> +		.pd_reg = _pd_reg,				\
> +		.pd_shift = _pd_shift,				\
> +		.tuner_reg = _tuner_reg,			\
> +		.tuner_en_reg = _tuner_en_reg,			\
> +		.tuner_en_bit = _tuner_en_bit,			\
> +		.pcw_reg = _pcw_reg,				\
> +		.pcw_shift = _pcw_shift,			\
> +		.pcwbits = _pcwbits,				\
> +		.pcwibits = MT8189_INTEGER_BITS,		\
> +	}

There is no .ops set. mtk_clk_register_pll() in drivers/clk/mediatek/clk-pll.c
will use mtk_pll_ops when no ops is set. mtk_pll_prepare() reads/writes
pll->pwr_addr.

> +
> +static const struct mtk_pll_data apmixed_plls[] = {
> +	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 18,
> +		   0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 17,
> +		   0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 16,
> +		   0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 15,
> +		   23, HAVE_RST_BAR | PLL_AO,
> +		   0x308, 24, 0, 0, 0, 0x308, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 14,
> +		   23, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 13,
> +		   23, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 7,
> +		   0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 11,
> +		   0, 0, 0x408, 24, 0x040, 0x00c, 0, 0x40c, 0, 32),
> +	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 10,
> +		   0, 0, 0x41c, 24, 0x044, 0x00c, 1, 0x420, 0, 32),
> +	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 12,
> +		   0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 2,
> +		   0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 3,
> +		   0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42c, 9,
> +		   0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43c, 8,
> +		   0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 6,
> +		   0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 5,
> +		   0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 4,
> +		   0, 0, 0x538, 24, 0, 0, 0, 0x538, 0, 22),
> +};
> +
> +#define FH(_pllid, _fhid, _offset) {				\
> +		.data = {					\
> +			.pll_id = _pllid,			\
> +			.fh_id = _fhid,				\
> +			.fh_ver = FHCTL_PLLFH_V2,		\
> +			.fhx_offset = _offset,			\
> +			.dds_mask = GENMASK(21, 0),		\
> +			.slope0_value = 0x6003c97,		\
> +			.slope1_value = 0x6003c97,		\
> +			.sfstrx_en = BIT(2),			\
> +			.frddsx_en = BIT(1),			\
> +			.fhctlx_en = BIT(0),			\
> +			.tgl_org = BIT(31),			\
> +			.dvfs_tri = BIT(31),			\
> +			.pcwchg = BIT(31),			\
> +			.dt_val = 0x0,				\
> +			.df_val = 0x9,				\
> +			.updnlmt_shft = 16,			\
> +			.msk_frddsx_dys = GENMASK(23, 20),	\
> +			.msk_frddsx_dts = GENMASK(19, 16),	\
> +		},						\
> +	}
> +
> +static struct mtk_pllfh_data pllfhs[] = {
> +	FH(CLK_APMIXED_ARMPLL_LL, 0, 0x003C),
> +	FH(CLK_APMIXED_ARMPLL_BL, 1, 0x0050),
> +	FH(CLK_APMIXED_CCIPLL, 2, 0x0064),
> +	FH(CLK_APMIXED_MAINPLL, 3, 0x0078),
> +	FH(CLK_APMIXED_MMPLL, 4, 0x008C),
> +	FH(CLK_APMIXED_MFGPLL, 5, 0x00A0),
> +	FH(CLK_APMIXED_EMIPLL, 6, 0x00B4),
> +	FH(CLK_APMIXED_TVDPLL1, 7, 0x00C8),
> +	FH(CLK_APMIXED_TVDPLL2, 8, 0x00DC),
> +	FH(CLK_APMIXED_MSDCPLL, 9, 0x00F0),
> +	FH(CLK_APMIXED_UFSPLL, 10, 0x0104),
> +	FH(CLK_APMIXED_APUPLL, 11, 0x0118),
> +	FH(CLK_APMIXED_APUPLL2, 12, 0x012c),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_apmixed[] = {
> +	{ .compatible = "mediatek,mt8189-apmixedsys" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_apmixed);
> +
> +static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
> +{
> +	int r;
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	const u8 *fhctl_node = "mediatek,mt8189-fhctl";

Reverse Christmas tree.

Brian

