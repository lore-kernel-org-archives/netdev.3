Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6C3955CF
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770185; cv=none; b=Y2GFhQJkkq81XTxY9iI9TDrXWnukPZE5mR9hoI5lAlKmErRsOLmM+Q++MpjGJkgf/LrEFl73pdInBm3t64RacTMWHwR2wcVc+3GL4Mloh4ObhC5Ivt4694J5IIB+Z7Tljm23IbNsqRf3XEdG31CNsVjq2ZcDeyAxx50Cf3Y3VMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770185; c=relaxed/simple;
	bh=ryf0iFj9gPEiTE5nfUzCyEHn3MXXGaHhAdPI4KW+ekw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWx42x8syZTS8CsCDRqvm96YoRcHYJeQhWQfHZNF7YlypypSqt569gLFRjiSZN0G/3rk9GivtOBXexm8FyEy8GayzCUkJ4IgrDYBEkgZ9q3FmojTuTQWNgUM86KpsmESJcMBv5wS5BYYDhsO2gHAJq3X7Yhq19GL6+UvnUGOuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWfwE+kn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kV9nyRCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWfwE+kn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kV9nyRCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785770182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTxJzMwyKJ+KE+3ACQJ1eEMl59YLw7vdII78uf288/s=;
	b=DWfwE+kndzygYyA42BdyjPLX1uUUR6se9yUq6LC98xJatthYSCCVzsb5ZmiAAM3vtcVb9B
	YradT4tOEp0nim3J5y4kWBX0nupboWsbkan1s8fmf/6mW9G77qm5X6J3NenwsKyEpeKgXe
	xpqQNo2EJWScdrlVp1jOIE7VsW4G6DQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-QozY1SJyP2Cv24COG971Gg-1; Mon, 03 Aug 2026 11:16:21 -0400
X-MC-Unique: QozY1SJyP2Cv24COG971Gg-1
X-Mimecast-MFC-AGG-ID: QozY1SJyP2Cv24COG971Gg_1785770181
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81f0b6bb02dso123144687b3.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785770180; x=1786374980; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LTxJzMwyKJ+KE+3ACQJ1eEMl59YLw7vdII78uf288/s=;
        b=kV9nyRCmGkoA69YKZtEUDS1Yip+CTuczlyJDIFdyZVSa9HyI7gbuHQB7sFTqKIjzf4
         jwI4sPZ6Tn3iJJLhGjgS/Kwz61p10bpuyMjOP45Qh3ESHvQhhpiIrd2R/20DjAu9/lbb
         KwCvI5Gk5tzEkPYP1t1nK2Z2UGDNJrz8QjXWG30Q2gZZU4PpHqVqjKPrNaDof8w0ENlJ
         wZZNNrTGrVOp+o3csirR9bdewoXD1CkHbcwA5/dpFSgOVOOhCOj913HRAu5ez7iZXs9K
         oIZeJ3b2qLqtr6bpMEbCWNLE9v8zaSiITeoAc1ak5xgLsG7q0n1s9oz3nIH7o5FHVWgA
         i10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770180; x=1786374980;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTxJzMwyKJ+KE+3ACQJ1eEMl59YLw7vdII78uf288/s=;
        b=eR1/YiXEuH1BCwUecR2uroU96NmZNp5O4vSSKNsir2i0kT4taoOqtN1r4aqa/mjbb6
         5XE/xwDmMab5IxOJjzvcRyZM8cSbMDgF9CM7i7wCr6aIfSxVajIL50SyoK2hRiZpmBVb
         BqodOd1+8ta2A0pQHRFEp9OOuQEbs6gGzE7wLo9sxLsITqjA2E5UwnaIosEPweQH0yJI
         EP4d0hoyu5MZwGMpoWML91nf3HKF+6ZnxPNuKHfZvOt4SZv1WAyYS8kieHzq/u8Urp0l
         Bdj38ND2FKcolnKZjgFhFJ1g9yavZfD9ZIUJEFz31m5jQtx/JY/5cHvS9A4f3jjsyz/5
         yI8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqG4+kX4XbP1P+W/1Qd5PX20CMCVEtgHuxNXEjyI94bsO26SxX9l6jj+A6szxlF0mVR1OxosSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAC00ZblqrbZVtOUKMjXarjC9Cog3mCNtYq/vFB52qmAahPFj
	AUK5zRli/6ojO+I7EKJVwj/kFHPbO39Y9OLf5rMozDtA6FCRrizLyHSHDOfulbiDCpJz6iRpAUP
	3kd7RTHSLKHUC5Ud55DxOBbP/SVi5/EhomjZnhb5svkvnoBhf99z9T4KVwQ==
X-Gm-Gg: AR+sD11JNydydJdiFlY2ze4+yQWMGZLJ+3b9GH79TOqEbJ7AmJdnC5RBZEtqRK5czWr
	BFTj5fRufqksYs+DD14uaNloX3Tws9v52EOP315Q6wiVnH5qlmURuhy1Fooil7i7Rpef0gDiHPD
	bt7tMJnCQWZy+RqTU2JGk6fDEnLkLkiKH3y2/5S/QAe5TixX9aCaW0mr3KfVXwsJbd7ASLM3hy4
	eivpkSizWUruHvJBGvCD9mXGZRxYk+zsd/Fibc2DkBkghizljXP3c3BIVO25OOJFaf8byJg0OYJ
	Q2BGQ01kFt79nFaG/5xFz5cHN/jYGY6yeXSzfpHta9NZ09QdflZ0zBeQ86DskdVGtCBvZokrJFc
	ahwg/i3wHjpGRFw3EngoucIWHYxQLomGN53Q=
X-Received: by 2002:a05:690c:6e0d:b0:7dc:aa85:5c67 with SMTP id 00721157ae682-81fd4ad3603mr135327067b3.11.1785770180553;
        Mon, 03 Aug 2026 08:16:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6e0d:b0:7dc:aa85:5c67 with SMTP id 00721157ae682-81fd4ad3603mr135326267b3.11.1785770179868;
        Mon, 03 Aug 2026 08:16:19 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd123dacsm56520997b3.39.2026.08.03.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:16:19 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:16:16 -0400
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
Subject: Re: [PATCH v5 17/25] clk: mediatek: Add MT8189 topckgen clock support
Message-ID: <anCwwMRMYex2_eSN@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-17-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-17-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Louis-Alexis,

On Sat, Aug 01, 2026 at 01:21:03PM +0200, Louis-Alexis Eyraud wrote:
> Add support for the MT8189 topckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
> 
> Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile              |    2 +-
>  drivers/clk/mediatek/clk-mt8189-topckgen.c | 1025 ++++++++++++++++++++++++++++
>  2 files changed, 1026 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 66577ccb9b93..9d3d2983bfb2 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -123,7 +123,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
> -obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o
> +obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o
>  obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-topckgen.c b/drivers/clk/mediatek/clk-mt8189-topckgen.c
> new file mode 100644
> index 000000000000..f25c0711512c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-topckgen.c
> @@ -0,0 +1,1025 @@
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

Are these two headers needed?

> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

And this one?

Brian

