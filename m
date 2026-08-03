Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EAF415F09
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770382; cv=none; b=oLO7Vm5issX8MKit0jeP7kRgaZOSwF75RtL3rj3jWOnaZlFRJ+tTw252zaITl4svthmyH5ufsMgjSuGtBsPB8AqERHiIrsIEgBUWBHiDerl41Ru5YvkPjOFdFr2PDOVJOCP96pxw+RGrdalW9SxlamtdqNqnHFq2189ZnmAmZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770382; c=relaxed/simple;
	bh=S4/lIw01byCzq07ylvrJS1kUmYO4YWq751Wf1CZYFTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbjFFFMDD7LrczXpzwaJ8Yq03gb8EgvS7DDnFkbej2K6B3sx2NmLzda6+ESWk9TzkeDOaiClyTEVK0MWK1vV6Rl4WPneVXNk9pqcTIayHjvR1gY6uOFg4gVa19jH+EXxMbn3bzHIRdi4DOsCTlIXleX9Z0fnUQsG28CbGTTn32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMFAO/PY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oiak5fLV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMFAO/PY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oiak5fLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785770380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfrwFppqeJr324Y3CbSyZQEjIv8H0QwZoY4+hT00zdY=;
	b=fMFAO/PYIW/swxyRcgOG0C+xHsMfTg3okH+RIsqGMOaZUBtpNKsjzOdiubI701SjB+9V/S
	neGg+p7JdPXY1lPxCj5fAFitkzzdZ8g0HzjJBPqG2ucpRZExq0eFLWq7j+QAD8O+5W5Knx
	tqt+LDFHafN1DLWIolzum4qcMAmCU/s=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-V4MHhrkkPPG-0-kF9hv_wg-1; Mon, 03 Aug 2026 11:19:37 -0400
X-MC-Unique: V4MHhrkkPPG-0-kF9hv_wg-1
X-Mimecast-MFC-AGG-ID: V4MHhrkkPPG-0-kF9hv_wg_1785770377
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e8f17ada0so83715457b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785770377; x=1786375177; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mfrwFppqeJr324Y3CbSyZQEjIv8H0QwZoY4+hT00zdY=;
        b=Oiak5fLVc313fQ5LNFy2U1rCtyLgANOjyCRvUrFrHThP1YwAcbOwlGqklTndo1inhH
         bg6OF/GWEI5WlM7OL44WSta8kyePrjIX477KC1aTK8lHZI7zf54SCxw7H4EcdtL3TOOg
         ekHhp4tQ3RQdutdk3nIbmixn8Wn3ITRfn2tkF8g+jnatweC9mFS5lXiKKyLesZYz2GeO
         Al5/Fw1lG56+b/aUOPrqK6SqNdvKxhqo1GOVST0++C7QlkjxZOH1vTLY5VWfgHDQzfYD
         h8SHyD4MpRgfHTb+wx6g852bCpn4+wHmOYkT/7O88ZyTZNMtk2AptodWhwVlHtQYRjuL
         VRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770377; x=1786375177;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfrwFppqeJr324Y3CbSyZQEjIv8H0QwZoY4+hT00zdY=;
        b=ivYuPq6tZfhTqTobIYF/pgPxp3urduxsJiSSkE+OD8Mhu0YDOAQ96JyN4kuzSOnwUr
         27h54Sg7zwHcHdANUzazqyUremN0znLi+0jg8J+KEANJSnL6NTN32PixR+kThf41VBrc
         0QL+kscABb2Jgz4c58UBREnHxRhcMGRJKnM7Ffee699dULlOeitB4XW3No/jOKrsBJgF
         +HWLjmi0LockMxnivfXOTfqgkuyxSgCvBaYz0DXsO654jB6RHBnSWoiKevYw+3xEH+mc
         dNNKqRfFpSMHU92iMmYGpzwQ2C+wG4RxdlnXE3pTKpcsTU1R22dHAKvdPL9LFF2E0VLM
         hv4g==
X-Forwarded-Encrypted: i=1; AHgh+Rr+zrCpnMSa+KrWKdxNFFtQLO+R+qNb/WeyUQbXogq6yE1wrQp51zSjALffZ02pBDJqk77b6OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAChEi7nojNyJOd1FPpeLeCPgQfJvdzvLQ2/5OrfDP5UHm9+c
	WyNwqQfilqKyVKd5nw0SOvpaRzK0i5waDUBE0PhL11uoYIEZhNF0NJ7pAGkNXaaTRGk/iPgbOsg
	/s8aDXhVThPQjwQOpkXeJYiNqMBu6i0dA+BXoiTOsW7QKqz1y7TTJhfDZwg==
X-Gm-Gg: AR+sD12/dRR+/+/4Q1UbACP5ZlcSTWMQx+/2gW7sJUoACBC6zwK2wEY6MDSoN5eZdWG
	09OIKx6fL7t6UjVgGvU5Typ1g3udkogjva2PaAV8G/c4vfoyxOGcAuxCtYiPGIw986z5K56vayO
	QRCqkPyufevUu3acmcvkcaq4yGgWA85KlSwuuWnz8abY07kTnc6JpytYzMuaUaYB+2lHheoQRQT
	BeWE5dgXSOwB1eYvfWg1XWfLgX3+rmev2SAIa+t8RD/vILuyjkvcpJc2QiCwmGdDWLMQIxjCc9G
	fLwmI0XzGLl17XcjuSzXKOWoMmbfXD0tvQnK7w3DA1BhpAuiUnDGq0JkanybmJeDGoJSdcbuvZW
	PK8ewTRKZZhh4qA4skfxQi5D4UDBcoibf7Yc=
X-Received: by 2002:a05:690c:278a:b0:81c:a61e:6309 with SMTP id 00721157ae682-81fd4bee7cfmr133567017b3.32.1785770376567;
        Mon, 03 Aug 2026 08:19:36 -0700 (PDT)
X-Received: by 2002:a05:690c:278a:b0:81c:a61e:6309 with SMTP id 00721157ae682-81fd4bee7cfmr133566557b3.32.1785770376131;
        Mon, 03 Aug 2026 08:19:36 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2e2b0sm55932967b3.8.2026.08.03.08.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:19:35 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:19:33 -0400
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
Subject: Re: [PATCH v5 19/25] clk: mediatek: Add MT8189 vlpcfg clock support
Message-ID: <anCxhZEK9Rh1H4U9@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-19-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-19-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:21:05PM +0200, Louis-Alexis Eyraud wrote:
> Add support for the MT8189 vlpcfg clock controller,
> which provides clock gate control for vlp domain IPs.
> 
> Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile            |   2 +-
>  drivers/clk/mediatek/clk-mt8189-vlpcfg.c | 116 +++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 3b25df9e7b50..d9279b237b7b 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -124,7 +124,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
> -				   clk-mt8189-vlpckgen.o
> +				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
>  obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-vlpcfg.c b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> new file mode 100644
> index 000000000000..cc4ebfd46a6f
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> @@ -0,0 +1,116 @@
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
> +#include <linux/of_device.h>

of_device.h is deprecated. You can drop this one since what you need
will be provided by platform_device.h.

With that fixed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

