Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029541378E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770247; cv=none; b=hFgXPEXUKHquks/JdzhKp0fTMIuXBrj5l8dCBUxz81kmxREmb6yXGb/NO+yvdFedwAviPiCTP/VjKdw/pxU0KHA1VXm29iaULer+vja8PlaMiTxABI0XjgLbNu+7jGCwohkcy6M8X/ZDaO2PEwHfO/OdJyBie3yiAWo8LmVifXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770247; c=relaxed/simple;
	bh=Tg2c5hSCmf4R8GHhniWyNjrjuYL6rS8mvKvO0Rjnhuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq+4SG+A/xoqYNoTYkPiRpLsJF5h/ZKF8fjPHdG2uY/zjnK51U7gHDojsulliRXNvK4U8CEnCh6im8McyE8INj+EdwcgJ138GeleTBYvQ1CysBPJmUFys0aTyGejOlSI8ANkUa5jiH8XyrhLnwfnzIcS0oS37QpkT4MPA01HNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zz4SWlT/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQh5iDqF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz4SWlT/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQh5iDqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785770245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CISqUyNrQHnuig4NG6zWObmoUM7qsn/M6rO8iF8GMa0=;
	b=Zz4SWlT/Ho4Ro80EfMM4dWEGc0lLq3zukxv/YKRmvp+3sAoZ4LE/Nyb3zEd29BJnLZz5Bz
	vlh9+PXYkzFQQzmHQf/nAZpH0iH/GiLhdTCDvuep6uHJgPB9MqIZGlZRybSxW2bODA19RY
	+vnftvrkM5QMdSa+xkEr82IT/CMs/GM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-tyLjO3MbOF2T-5KsEkK43w-1; Mon, 03 Aug 2026 11:17:19 -0400
X-MC-Unique: tyLjO3MbOF2T-5KsEkK43w-1
X-Mimecast-MFC-AGG-ID: tyLjO3MbOF2T-5KsEkK43w_1785770239
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81ec0eb032aso115994117b3.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785770239; x=1786375039; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CISqUyNrQHnuig4NG6zWObmoUM7qsn/M6rO8iF8GMa0=;
        b=eQh5iDqFiJh8Zep4vZvjC8HGIzyBpAUPOZ6PUtfq9zJFoCEMd26mK4pQPOJdmMd8HJ
         k5AExO2SPlbHxluekpkzW6T1mTeOItZ3J3qlLG4WJHVmI76rpPb8TtqEQXURH+K9BGjF
         ExJYFV/4DMgScBq/je2JxvnVj1TviZJzTb025r7Gg4M0w77grpCAIpNSWTsdmhnvkqQq
         RH7RjuWrSHmsErm9Epr8A/OO+d2ZnqBTc40QbYruncuzwMxXJWwxBpSBp3WvXpwMwP7m
         SJXHJRpUqBMwtmK8Qkho2k3wCiusZlKXBXnznVWZQSpRBXVFgbcl/FYsVOCXhMW2figD
         Kg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770239; x=1786375039;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CISqUyNrQHnuig4NG6zWObmoUM7qsn/M6rO8iF8GMa0=;
        b=WN0dEsIJwEDWinska4k3VEkrVpX00jyHpSwdxyBBWRXB9Tetk7Q+JbNHzE/tGtZG/0
         0haA5l7hBq8FyfRIYQOamb9a0RzbeCgP29wU6B5r00OKN7iDIYuudLAFbVF/5eBR3h8i
         t/qgsHbnBF5/jK9+ZVw8jBg6Si+i4FlsZFNkIZcBsRKoGSMQ7rX6J3oLFunwSP4mfKN7
         2Kx2cu8xf+3Mfws5Sm68edMh47ECfmW9wqRAOIjiTgfH9TxFBymby+1uYKtMg/84mujS
         l+U4bGjgETD5cuviy2hxPqKWW+g+8jB0ZG2BMNMnolvqt4a6T315BWtiHW42dry8iOqD
         LPXg==
X-Forwarded-Encrypted: i=1; AHgh+Rrn33RR9LxrFCiljUFGCQ505UV1VXcX19SYsZyabJFDVPtdcYGYXnhQR2pBLaJO2xp5SbeUwl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjnAc3TYJ5JAvHtMv/d81yswoy2OjBPgSVWSD3tJ/NYIcM0JE
	8lGJfuq8jS0q8WUe0WTSEoo2rU+YWli7Jclhsgys14kCfpQAtl8f8DcjcgrxJk5EcA2NXmTD+Lt
	rn4XEtcMI50dVpRko9Ph5MIpNks7UKhW0nnMe/3qw4zaH5xwKe982JrTjWw==
X-Gm-Gg: AR+sD10ugD0hzr6AwP+DRHFfs6efgqSshNeLcqV6gfFPFo8TGbqUbnA3Ck0BFYraXmu
	IUw82aElgVE9X9b2fMCZ3Xk7qOeeoTwKzjxrWeY0PP06aBMf+hoatwFinb4WyUd6TjQQpDr3Ae1
	iO65qkIBdFCfHgDyntCdGF5xKkYiZ+XCpyq9/tX+PYiL6mOfqooC/oleJMrDWG+RosqCIle1EOc
	LUpnJiN98Z08wH2LbZ32Ez2pXHM/wo5RX6P+gyGha0KZk0SNz/2Hoij+Nx3CMpiV2+5POP8bLn0
	6S9+APJX/CHCEesag22Ss9cB4xLFevtchPQWzMtYWCQc8oKK2FPcsWPWZASkELp9tOzGOr2amIJ
	A+t5yuwJC9PlsTy0TwdqvRKToF8S/DIngExk=
X-Received: by 2002:a05:690c:450d:b0:7d1:dd7b:b734 with SMTP id 00721157ae682-81fd4b5a2c8mr136703397b3.23.1785770238453;
        Mon, 03 Aug 2026 08:17:18 -0700 (PDT)
X-Received: by 2002:a05:690c:450d:b0:7d1:dd7b:b734 with SMTP id 00721157ae682-81fd4b5a2c8mr136702797b3.23.1785770237899;
        Mon, 03 Aug 2026 08:17:17 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2e239sm57358447b3.5.2026.08.03.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:17:17 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:17:14 -0400
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
Subject: Re: [PATCH v5 18/25] clk: mediatek: Add MT8189 vlpckgen clock support
Message-ID: <anCw-ozpIjYfan5O@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-18-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-18-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Louis-Alexis,

On Sat, Aug 01, 2026 at 01:21:04PM +0200, Louis-Alexis Eyraud wrote:
> Add support for the MT8189 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in vlp domain for other IP blocks.
> 
> Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile              |   3 +-
>  drivers/clk/mediatek/clk-mt8189-vlpckgen.c | 285 +++++++++++++++++++++++++++++
>  2 files changed, 287 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 9d3d2983bfb2..3b25df9e7b50 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -123,7 +123,8 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
> -obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o
> +obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
> +				   clk-mt8189-vlpckgen.o
>  obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-vlpckgen.c b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
> new file mode 100644
> index 000000000000..8eda5331972e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
> @@ -0,0 +1,285 @@
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

There are also some headers that can likely be dropped here as well. I'm
not going to comment on this on any other patches. I'll just list any
new issues I see.

Brian

