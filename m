Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECC409283
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769947; cv=none; b=BWo5mlWHVfPNIid91iy2WWRXm9wTucHUpasLoB9MGK77oxdisyCgUMgZXj/svKtLabu/lvUk7ShdUvTm+hONM+n+XiMsn6Be8xe5jF4u6lzpXMnl0N8gZCgVRqTKp529/iaTdvXkL5BYDy2LJQcVB6kXjMXpSaN7yJg6AqWmGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769947; c=relaxed/simple;
	bh=iexzmFB8KQHgucwZjKyJV/HshQ3jw4C884ppX1S0bMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCo2hoY/rYiazgxRnFebYgwOBW67F1rULj09llq6ie+a7ZeDexR8dsEDoh4WNDrvtKdLCqUA6DT6H0+XWy7ELP9OqdKDIBWE7jmEP9GqnzF9PwKsid8PZIIemlt3f/dpF1cs/Ac0i16XyVi0f20TDpwtmDpQri2Qh0CloIXGWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/r/QcP7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XshItDJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/r/QcP7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XshItDJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785769944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jF3MmI86y2BChVqhm8vdVAw/xAkrV44X6MqoOsmdA58=;
	b=F/r/QcP7TS7g8mkZrqfcy+CDL4BOHJeqBD2L0j6qIHc8N3Nlm6fv3VKZ+dvTmDn+9y4z6h
	br2kt2NEJ11RxoZk/x8EBDmFOm11pe040cr9gp9EbLrDbsVyWeA6klUBEhTWoUjdv4C61F
	C8DbOYPh9jGRNR/5XSlPzJgMKXPtluw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-hGguzlgZNBGWmMkDw9M1RQ-1; Mon, 03 Aug 2026 11:12:23 -0400
X-MC-Unique: hGguzlgZNBGWmMkDw9M1RQ-1
X-Mimecast-MFC-AGG-ID: hGguzlgZNBGWmMkDw9M1RQ_1785769942
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-668095be86aso5289088d50.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785769942; x=1786374742; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jF3MmI86y2BChVqhm8vdVAw/xAkrV44X6MqoOsmdA58=;
        b=XshItDJcrw4c+tZSk/O6v22qTJF6qczk3jmhYQy1ypfRNdVflu1t+uypnN+zoCKdZ3
         lRhxqxIjzwTRrCHE81Flfy2Pw1EfvcG+pKjggtS3WIckFtANVsKq87rdpq4LttPOcnE9
         6zkqEveYQDBdm+8CsZ5ZXU+HbJWr9RSKtis+bgiv0ITM21UcQqLV70qXVbC6TDCIpwXZ
         kJ7cSbEj76uUS8RHB10mIhmQocwfxb8RTTwJH5vePYzr35qwkEGx4Hspt45P0storPPe
         jA6iDdQGbHN/Tf2HI2DbYJqBGn3YqIH2SQ7+wGFWcfnHK4RGGcxJNu/qtg65losUMM5D
         ZZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769942; x=1786374742;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jF3MmI86y2BChVqhm8vdVAw/xAkrV44X6MqoOsmdA58=;
        b=hTgMYV+FlWVhA0xeqB3mHpqc7HYgZsjiCEpP3b6F/d4rJSXCvCJtucM6UYJPEO2nXx
         gS2RmJUXd6hNK5G47EYrAmXuifZUeLXfskYFP1fl6GZGtyfm50higx6iR7xiVzvR/7Fc
         u1D69SHRy2XBakxhu/ZV0gGCZO55XJ7JJS2+60/m/r2dxTiMqoy2hEoyQ9uBGLLRthsE
         iYtTU0bfWZP3GbPZgBhLw2Md9CNsbkWjwnXdXlZYx+1nn9ZppJh+RYg0RPJ/Hx/kTwSn
         a1vwNgkDViLIJUU48pxka9SYEcl4MbpmdMfxI8+GsWpJE+rVvEetfODG+TYGlqcLx+0l
         vZWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAQLFvvs7uXRMy4Le3nmgEmDDha9oUB3QdAVcFHMOtHxwv9HvN5rTzxFKmqnJKtoJCI6epvEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3u57ih16yHXNGzKVsCKtln7foA0y1ITN6n46QXgOEylrReTo
	3xEZhcGoPgBpvd6cPL9ObsAYNXocRFxZChog+E2z2EMSLZIDZU2K9DFWmKMGtZNerZgT3jWkacS
	SpPL0QaXpbX+9B5ofqp3TRnhEt+ctyL8ZQSs55RUPzF5Xp3ijHxqmmDB5LQ==
X-Gm-Gg: AR+sD13In706GCmPETX24g0e16xaL6LGTmZbmyVnFwn1sHhce+1njprnw2NK+apOtXp
	hk4z/4CwVhjkRNnfvX6h6xNL+FRFA55qyz8mFbSRNQTfaLfWPUeIkUnJl6pyrnXRXEkxHnCQXL5
	NFYBr85LUXGeB9BXbd4D/cEP1UO0OvRiZ9ph/XbtcJ0ruVf3+MvG+22Wqpra+xNoNeTpuhyY2p3
	njP1Nhn6krtIEwhSd9su/L9+6aHbhbmXo70/l5DZUehzOp6iOkNzbGwIUpHK8Zs0xFCgApaOaLv
	4W0rblEMPOnOmT1TvdvxxQmjZV5HGM5aUNJ+yDutsEnWlVw09efy7/mhZ40bAjOM98kXlYXCmuM
	ka9T1panj5aiGMRBfDHntXPBtGhdtWqRz0/0=
X-Received: by 2002:a05:690e:2244:b0:663:9a0a:7b80 with SMTP id 956f58d0204a3-6694f08c75fmr9214962d50.19.1785769942513;
        Mon, 03 Aug 2026 08:12:22 -0700 (PDT)
X-Received: by 2002:a05:690e:2244:b0:663:9a0a:7b80 with SMTP id 956f58d0204a3-6694f08c75fmr9214934d50.19.1785769942042;
        Mon, 03 Aug 2026 08:12:22 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948fc7ef2sm5945641d50.13.2026.08.03.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:12:21 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:12:18 -0400
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
Subject: Re: [PATCH v5 16/25] clk: mediatek: Add MT8189 apmixedsys clock
 support
Message-ID: <anCv0ga226obZg2g@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-16-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-16-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:21:02PM +0200, Louis-Alexis Eyraud wrote:
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
>  drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 203 +++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
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
> index 000000000000..a50a8979b849
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
> @@ -0,0 +1,203 @@
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
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
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
> +#define MT8189_PLLEN_SET_OFS	0x74
> +#define MT8189_PLLEN_CLR_OFS	0x78
> +#define MT8189_RSTBAR_OFS	0x80
> +#define MT8189_RSTBAR_SET_OFS	0x84
> +#define MT8189_RSTBAR_CLR_OFS	0x88
> +#define MT8189_INTEGER_BITS	8
> +
> +#define PLL_SETCLR(_id, _name, _reg, _pwr_reg, _en_setclr_bit,		\
> +			_rstb_setclr_bit, _flags, _pd_reg,	\
> +			_pd_shift, _tuner_reg, _tuner_en_reg,	\
> +			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
> +			_pcwbits) {				\
> +		.id = _id,					\
> +		.name = _name,					\
> +		.en_reg = MT8189_PLLEN_OFS,			\
> +		.en_set_reg = MT8189_PLLEN_SET_OFS,		\
> +		.en_clr_reg = MT8189_PLLEN_CLR_OFS,		\
> +		.reg = _reg,					\
> +		.pwr_reg = _pwr_reg,				\
> +		.pll_en_bit = _en_setclr_bit,			\
> +		.rst_bar_reg = MT8189_RSTBAR_OFS,		\
> +		.rst_bar_set_reg = MT8189_RSTBAR_SET_OFS,	\
> +		.rst_bar_clr_reg = MT8189_RSTBAR_CLR_OFS,	\
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
> +		.ops = &mtk_pll_setclr_ops,			\
> +	}
> +
> +static const struct mtk_pll_data apmixed_plls[] = {
> +	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 0x210, 18,
> +		   0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 0x220, 17,
> +		   0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 0x230, 16,
> +		   0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 0x310, 15,
> +		   2, HAVE_RST_BAR | PLL_AO,
> +		   0x308, 24, 0, 0, 0, 0x308, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 0x320, 14,
> +		   1, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 0x330, 13,
> +		   0, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 0x510, 7,
> +		   0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 0x414, 11,
> +		   0, 0, 0x408, 24, 0x040, 0x00c, 0, 0x40c, 0, 32),
> +	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 0x428, 10,
> +		   0, 0, 0x41c, 24, 0x044, 0x00c, 1, 0x420, 0, 32),
> +	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 0x340, 12,
> +		   0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 0x620, 2,
> +		   0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 0x610, 3,
> +		   0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42c, 0x438, 9,
> +		   0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43c,  0x448, 8,
> +		   0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 0x520, 6,
> +		   0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 0x530, 5,
> +		   0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
> +	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 0x540, 4,
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
> +			.ops = &mtk_pllfh_setclr_ops,		\
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
> +	const u8 *fhctl_node = "mediatek,mt8189-fhctl";
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));

So I know this is how the existing drivers are written. This calls
of_iomap(), and the iounmap is called by mtk_clk_unregister_pllfhs().
I usually like to see things in pairs to make it easier to review
where there's some register, and an unregister with the same name.

Could the fhctl_parse_dt() call be moved into
mtk_clk_register_pllfhs() ?

Additionally fhctl_parse_dt() sets some state variables that are never
cleared in the unregister:

                pllfh->state.fh_enable = 1;
                pllfh->state.ssc_rate = ssc_rate;
                pllfh->state.base = base;

Just a quick glance though I think this is fine.

Brian

