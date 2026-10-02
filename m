Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49E428841
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970648; cv=none; b=qIDeLGDighHkEIrtde3Sv/3h3Rk21vIoJAGyhcp4acR2yJ4D5e/+xGq/Q1jqmgNb3r+lM9V6d3B+CJAgksin0ZCL8WzKKsURbR3dmZxQs6CRgpeCuNSvHc+ZbaA/+e2QMvY9NcasTm7xrVwsXEe0/dyuMWgEydUUdKZv/aX2qeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970648; c=relaxed/simple;
	bh=Nq7Fx9cW/yMMojiMbMsDPveLjNjnf6n6z2l3LEZbbFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHPKMe4m0J8dE76CSk7MK1A36DLBAWYYtiYxuFdN4g9P+/R158Cw1cMxk0VgciQWY9Rh0LmDejg6ktCHrN7/V8uLPnJJYSEmLTsipTUoMD+ftBUpMynGx05hPT7ILVuo/GPxEij57f0MeqcQ0JD7lsBbcHhQ/IdB5PItaGwPsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIkb22I2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NawNL/0R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIkb22I2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NawNL/0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790970641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F25QBZ61ZmBrTf7fU7xFNKMRCKDf4lsr8/BxhtCtQxg=;
	b=PIkb22I25sUt3cZTuk+tza4DdoZW+L9/tJXy4QQompVPd9lX5+7nD7hvOeQadZ0HXc0pFJ
	En/wq7yH6Bl7VtGrl1IyARcADo0zLRGuhv8gfFcq+wBaXiLTft1hJzz0aRXR0INf18qtkF
	STG9T6Qjtzv0bMLrQ1Ftu3zRWFqKZoQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-frQXp871N-a4WhmdiDq_0Q-1; Fri, 02 Oct 2026 15:50:40 -0400
X-MC-Unique: frQXp871N-a4WhmdiDq_0Q-1
X-Mimecast-MFC-AGG-ID: frQXp871N-a4WhmdiDq_0Q_1790970640
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-895241d7405so125906337b3.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790970640; x=1791575440; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F25QBZ61ZmBrTf7fU7xFNKMRCKDf4lsr8/BxhtCtQxg=;
        b=NawNL/0RtDRb6R02vo9so4pmLT1u7I4tX9TCa5R8B66YZ4lA9X9OVBBcU6fzqS0dmq
         An1b6UWwRXVCO0N4n1kfySq3sb5rEbLKpSIAL/tPRrB4LSmmsvdrm+W3IWb9ekFyUVQY
         vMSRa3vs9yr2XB6zs4T6PDAQ0JIgpED0xAQ9IhBl74e9DTrOjnsvIVnlxysYLS2U9mA0
         OuwHIL4NepaCmDjC7jpIy/1PyV+RL2aO4GhIJysrjEGr9OVyqQpaaAq8wi6ESs+VB71h
         xeUV7GiolbSGAhnJjFCIFRP4L4xms/V1rS+3X4iy+WCaiYEbXr9Fwg1dlKNNUFdzdjQ+
         kgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970640; x=1791575440;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F25QBZ61ZmBrTf7fU7xFNKMRCKDf4lsr8/BxhtCtQxg=;
        b=wTbHi3PQMdj6yaqGcEYC5NaNqLirlEzDlmagZ13Yw4pszd1cOUgM0qrwKnVbhklgc+
         hWkGk1tvlg+G/xqgvbzOcU0VSqEX8inZd4ppoXE+NFcKRkFRAr2ubvLreDVqXvKFXj9C
         jjLDNjhZbCq2JRTOPeByyus/ICzlQDSxHmFnV0XVzm26MEE8l8w4y0ayNDb1S2oSLCX1
         TTP1HMVHrgc13lxGFFbIEc6P8gTCb3chtVQIM3yrQjlTfT6eSYS2AdxH3GahinzFMHL+
         +tUC9JE96tTWFOG9emiIDo2Vlgt4zEFBYTvhVH/z3zb7MVzlZ/ScZE7Gf7qRjcd0vo58
         GFKg==
X-Forwarded-Encrypted: i=1; AKwUvBw6P3PeTntCsw7obsswgcCOJlYElJsR4haAF+H1mQGrFEOfpouAFPT9eyPcws1rVzMXl5IdnOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhVIhVT9mGyxMWAhw82pt6JKOJj2x4bvssOHgblOR1bzz6wuLo
	JrMlaOKvUwgVaPh1UGh1jLsYuiB0QD8XwLg2D/Us74hduA8raLHgUZLoA6Xp4udz3OB2Li8dXA6
	NlHFrRTVehjwFGSTNMKWRTA+XfQj5L3MFflwUxRLWtiF4MxEQyfZjP7b/oQ==
X-Gm-Gg: AYBFou1tBALrYrx3wc1UO2qf0PSwa3hbDaNHqTkJfItLC6FjckMS3v55ct5zxaI0BjL
	iZIhAZd+DNNJWCxS93EcZ4BwXSIsPhqkiHiuIzdm8eMhWbeSHO8GgIkHQmListXMGJ0vQnGlk19
	usNPN1iJ3zb7wyrT0cgrXyd6nsULunHg6L+c3NO63ms7fhF5ie4O4zuaCL3rJkh0rSwgb9EPCnq
	2JxO0P4Z1KSCe6TOz4ZqJAK5tqGNjKN8GgEY6fUEmSK/oq2MMFkyVJXwmGsN5wY97Fef0iSVWvY
	QthLB4BORMtN/LOAlDy0oYCLc75LaX/UB5kgowXS4cLf/4AI7EHHABTHpbI7eTTAMScaTaRZig=
	=
X-Received: by 2002:a05:690c:808:b0:894:4ded:2746 with SMTP id 00721157ae682-8ae39bc3a5emr15283707b3.36.1790970639955;
        Fri, 02 Oct 2026 12:50:39 -0700 (PDT)
X-Received: by 2002:a05:690c:808:b0:894:4ded:2746 with SMTP id 00721157ae682-8ae39bc3a5emr15283607b3.36.1790970639475;
        Fri, 02 Oct 2026 12:50:39 -0700 (PDT)
Received: from redhat.com ([2600:382:850b:d4de:3546:fbce:3693:8762])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae32cf2f27sm13728657b3.26.2026.10.02.12.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:50:38 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:50:34 -0400
From: Brian Masney <bmasney@redhat.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 10/23] clk: starfive: Add JHB100 System-2 clock
 generator driver
Message-ID: <asALCsosWkutrwUK@redhat.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-11-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930124317.5648-11-changhuang.liang@starfivetech.com>
User-Agent: Mutt/2.4.2 (2026-08-30)

Hi Changhuang,

On Wed, Sep 30, 2026 at 05:43:04AM -0700, Changhuang Liang wrote:
> Add support for JHB100 System-2 clock generator (SYS2CRG).
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/clk/starfive/Kconfig                  |  10 ++
>  drivers/clk/starfive/Makefile                 |   1 +
>  .../clk/starfive/clk-starfive-jhb100-sys2.c   | 129 ++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c
> 
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 11da8bcc4046..cfaac934a8e0 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -92,3 +92,13 @@ config CLK_STARFIVE_JHB100_SYS1
>  	help
>  	  Say yes here to support the system-1 clock controller on the
>  	  StarFive JHB100 SoC.
> +
> +config CLK_STARFIVE_JHB100_SYS2
> +	bool "StarFive JHB100 system-2 clock support"
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	select CLK_STARFIVE_JH71X0
> +	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
> +	default ARCH_STARFIVE
> +	help
> +	  Say yes here to support the system-2 clock controller on the
> +	  StarFive JHB100 SoC.
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index 0061550e0f7e..29cdef20575e 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
>  
>  obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
>  obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
> +obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
> diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys2.c b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
> new file mode 100644
> index 000000000000..a2c7e8eba9b6
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JHB100 System-2 Clock Driver
> + *
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + *
> + * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
> + *
> + */
> +
> +#include <dt-bindings/clock/starfive,jhb100-crg.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-starfive-jh71x0.h"
> +
> +#define JHB100_SYS2CLK_NUM_CLKS			(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1 + 1)
> +
> +/* external clocks */
> +#define JHB100_SYS2CLK_OSC			(JHB100_SYS2CLK_NUM_CLKS + 0)
> +#define JHB100_SYS2CLK_PLL1			(JHB100_SYS2CLK_NUM_CLKS + 1)
> +#define JHB100_SYS2CLK_GPU0_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 2)
> +#define JHB100_SYS2CLK_GPU1_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 3)
> +
> +static const char * const jhb100_sys2_ext_clk[] = {
> +	"osc",
> +	"pll1",
> +	"gpu0_ncnoc_init",
> +	"gpu1_ncnoc_init",
> +};
> +
> +static const struct jh71x0_clk_data jhb100_sys2crg_clk_data[] = {
> +	/* jtag mst*/
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_HCLK, "jtagm0_hclk", 6,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_HCLK, "jtagm1_hclk", 6,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_ATPG, "jtagm0_ATPG", 12,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_ATPG, "jtagm1_ATPG", 12,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_ATPG_TCLOCK, "jtagm0_atpg_tclock", 2,
> +		    JHB100_SYS2CLK_JTAGM0_ATPG),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_ATPG_TCLOCK, "jtagm1_atpg_tclock", 2,
> +		    JHB100_SYS2CLK_JTAGM1_ATPG),
> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_HCLK, "jtag0_mst_wrap_hclk",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),

Can you leave a comment somewhere about why CLK_IGNORE_UNUSED is on some
of these clocks? We may be able to deprecate this flag once some
variation of the clk sync_state support lands:

https://lore.kernel.org/linux-clk/20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com/


> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_CLK_JTAG, "jtag0_mst_wrap_clk_jtag",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),
> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_APB_PCLK, "jtag0_mst_wrap_apb_pclk",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_ATPG_TCLOCK, "jtag0_mst_wrap_atpg_tclock",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_HCLK, "jtag1_mst_wrap_hclk",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_CLK_JTAG, "jtag1_mst_wrap_clk_jtag",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_APB_PCLK, "jtag1_mst_wrap_apb_pclk",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
> +	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_ATPG_TCLOCK, "jtag1_mst_wrap_atpg_tclock",
> +		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
> +	/* hostusbcmn */
> +	JH71X0__DIV(JHB100_SYS2CLK_HOSTUSB_NCNOC_TARG, "hostusb_ncnoc_targ", 12,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_HOSTUSBCMN_CFG_500, "hostusbcmn_cfg_500", 4,
> +		    JHB100_SYS2CLK_PLL1),
> +	/* bmcperiph1 */
> +	JH71X0__DIV(JHB100_SYS2CLK_BMCPER1_NCNOC_TARG, "bmcper1_ncnoc_targ", 6,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_BMCPER1_CFG_250, "bmcper1_cfg_250", 5,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_BMCPER1_CFG_143_DFT, "bmcper1_cfg_143_dft", 8,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0_GATE(JHB100_SYS2CLK_BMCPER1_CFG_143, "bmcper1_cfg_143", CLK_IS_CRITICAL,

Also please leave a comment why CLK_IS_CRITICAL is needed as well for
these particular clocks.

Brian

