Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A941685A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768264; cv=none; b=rqWM2b2HiCs9pmda4Cm1D7Eba+29SAQkzYviIOEFv1CoIzc+jGL0WMxyJZ0t20Jv8d13oNNCGUnYOdTxDYcLkX9R11f3sOXNmZ1DN2VR/i8Z5a4taBrKJQJTP7G4QB3KrXBPlG/nI0+zZHrFGT9uT/lTIkfDmvGDeUp1ZUHpxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768264; c=relaxed/simple;
	bh=TPNhfpCjJ7K9BIQKoO6eafvRbdeq9bSuqGX5iRJjLwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR73IxT1cEU6iLQ7CVI/f1w7yxxt36KB129zfO5geiC12zuPSnrvS44yb0R0iWOLry0AK1faHlFP1LOOV01neRyK9uYpyrSkdPm8ShnJeJyB/GxsqtOGwtGH6wONgFN/Tp634TUJEiCkvVx51mbVxftvP38tIsPeIbH3EzkjqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ9fFgow; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZD7Fz5QT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ9fFgow";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZD7Fz5QT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785768262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ptAA2UgbXk0GHtmmP9E3bbEDZbmeRKtWgtxlW5QXXyQ=;
	b=IZ9fFgowMkwLA7gw+woVtpJGQOKKVkNcefgWRCtW8eeJWX+HEGdAhwqMUU7SdzFG2BLDPW
	EhYgpAMBAdsmyic2TGcJnXyBAXI17PtOadjlhK/j9TNBI8cAX1AROY9R9/IG7E0w4SVllj
	OfuGsNkSNn4ZPcCH8c0dlrv0zxbV1Bg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-LiyEzZ_oO8Ch4xfySmcP-w-1; Mon, 03 Aug 2026 10:44:19 -0400
X-MC-Unique: LiyEzZ_oO8Ch4xfySmcP-w-1
X-Mimecast-MFC-AGG-ID: LiyEzZ_oO8Ch4xfySmcP-w_1785768259
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66937c2e6d7so11863333d50.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785768258; x=1786373058; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ptAA2UgbXk0GHtmmP9E3bbEDZbmeRKtWgtxlW5QXXyQ=;
        b=ZD7Fz5QTdQVGhfCMbV6dkAe48Hn5mGvoL0AyHdL7FagowLq7diGhixzIhUmJ+RUQWa
         EgwNDBHeJ0ztZW2W09tH8ZSGDnanvtKMYIdL2ZV8zt2ZBYzDTBMKLyko6ubVYN0NF1Bg
         S7JUfdNBsP/xq/RfJmU6xAIf8rfl/Tv4cXwyHLX+n8NVfrWgksh5mm4hOX3sRtDk+4jZ
         f8bFkfazt7PfLBiwIc6CyydgJQ/r+GKM1JFA/dQAvSB85bEp7GpiQLfhQW1QOQFH66IS
         Qg5erM8VlhW6t0d7xe2FsZSWRe5v9YiqQ9odsNErvDfR1xmAezsYk2WnZjpJ4Ffswaxs
         kn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768258; x=1786373058;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptAA2UgbXk0GHtmmP9E3bbEDZbmeRKtWgtxlW5QXXyQ=;
        b=P2HCTmxYOReVDRyxr9YYMZREyk76kIXOO0pdIKujHuE6SCtWMg18wtliO1tDSt0eu3
         ese8sAYJigRQCdGpm9yvg7OTWcURLwwyALIkpl4cNLH+GDomMWttqTtsP+z3qHbA5mk/
         tzRna5zKAvqiWsIcomaR5vCgxfkKzmKuR+oWV/d5SjkiKidS3wu13mmrR5farqRVDJnF
         peyK0XgCmH+ZoA5ogX2xhJKIUvVQNE9lpILR5xOKu/8GLLuNN2FQQxq0a8//QQDk3X2l
         IeJZQCVUnFg3+2OKSd89xKum0ugqu8MBQOuh8XaR3TPbcUyc6CoePc1V+atddu48hai9
         VjBw==
X-Forwarded-Encrypted: i=1; AHgh+RrEAWih9nEmCk3TisIZsoUgVlnUQVGsLflGTOT39XvIgdajNy1u91rCN2NJewatNZpBzkAfQtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYoKS+Lu/YhY6ets3GAmfee9i7oFw4I7NSZmcBNyro1tBSoUGj
	yce+HI9ngVBo1yLT/A6ZRmRu8/BUKoJ/kts+Xf1LacEHSB4PCSnzISr3VU9I5DKehzLqv6JRjMi
	yndHdtxPY097XkjEckO6qLJcS3NjUqE+PU4jdVlH/6p1sK2pVR6hMPZt4BA==
X-Gm-Gg: AR+sD11QbCFj9xgf4zpJHQI/1nflXCNhMoh3On6srmT6KozZJpzrezkDootnwp9xzGt
	YeCjD2MurFBxIFROdKNfNZjuDU0hUk/EoA+cT5H2HRNg1hlaPZyGUzDjErSnDKR9jN16XXNNhSQ
	XygmakCehjea0cDAHq6dE/4DKziNI07J817BfVGbh0iAeHe03nprZZd9NN0Dak4tnl8hYHtxvjx
	P+l8+weuzyEqDgLIN8YM1U5Whs4Cv7Vkml0HprHnhXsMibLSJd+PP+2R4yndk4GpBWY0osWfs9y
	0cl3L5+NosFrE18RZQngt73QQq7CBlf3fD4aJuLcsf2amUjQbsQuJngNMnCAjIWrAnjmp0YIcJ8
	pb8tBQ59/segzoM/QbnxiG6eK9upVsdeJDjQ=
X-Received: by 2002:a53:ef09:0:b0:664:e66e:f955 with SMTP id 956f58d0204a3-6694efcd46cmr9652586d50.4.1785768258650;
        Mon, 03 Aug 2026 07:44:18 -0700 (PDT)
X-Received: by 2002:a53:ef09:0:b0:664:e66e:f955 with SMTP id 956f58d0204a3-6694efcd46cmr9652545d50.4.1785768258248;
        Mon, 03 Aug 2026 07:44:18 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948fcb3acsm5643561d50.10.2026.08.03.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:44:17 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:44:15 -0400
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
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 13/25] clk: mediatek: pll: Add ops for PLLs using
 set/clr regs
Message-ID: <anCpP0FlwHdomb_e@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-13-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-13-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Louis-Alexis,

On Sat, Aug 01, 2026 at 01:20:59PM +0200, Louis-Alexis Eyraud wrote:
> MT8189 SoC uses a new combination of status and set/clr registers to
> control its PLL enable state and perform BAR reset, that are different
> than the current default clock prepare/unprepare operations are using.
> 
> Add new set of PLL clock operations to support this logic that relies
> on the following registers for prepare/unprepare operations:
>   - en/en_set/en_clr, rather than en register, for PLL enable
>     control
>   - rst_bar/rst_bar_set/rst_bar_clr, rather than default rst_bar
>     register for BAR reset control
> 
> Also, handle rst_bar register setting/clearing with a timeout, to
> verify the operation was correctly performed.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/clk/mediatek/clk-pll.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-pll.h |  5 ++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 9a197a657dce..3118f68aa9ac 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> @@ -32,6 +33,7 @@
>  #define INTEGER_BITS		7
>  
>  #define PLL_STABILIZATION_DELAY	20 /* in us */
> +#define RST_BAR_TIMEOUT		20 /* in us */
>  
>  int mtk_pll_is_prepared(struct clk_hw *hw)
>  {
> @@ -301,6 +303,60 @@ void mtk_pll_unprepare(struct clk_hw *hw)
>  	mtk_pll_power_off(pll);
>  }
>  
> +int mtk_pll_prepare_setclr(struct clk_hw *hw)
> +{
> +	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> +	u32 val = 0;
> +	int ret;
> +
> +	mtk_pll_power_on(pll);
> +
> +	writel(BIT(pll->data->pll_en_bit), pll->en_set_addr);
> +
> +	__mtk_pll_tuner_enable(pll);
> +
> +	udelay(PLL_STABILIZATION_DELAY);
> +
> +	if (pll->data->flags & HAVE_RST_BAR) {
> +		writel(pll->data->rst_bar_mask, pll->rst_bar_set_addr);
> +
> +		ret = readl_poll_timeout(pll->rst_bar_addr, val,
> +					(val & pll->data->rst_bar_mask), 1,
> +					RST_BAR_TIMEOUT);
> +		if (ret) {
> +			mtk_pll_unprepare_setclr(hw);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_pll_prepare_setclr);
> +
> +void mtk_pll_unprepare_setclr(struct clk_hw *hw)
> +{
> +	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> +	u32 val = 0;
> +
> +	if (pll->data->flags & HAVE_RST_BAR) {
> +		writel(pll->data->rst_bar_mask, pll->rst_bar_clr_addr);
> +
> +		/* ignore return code to continue unpreparing the PLL if
> +		 * a error occurs on register read poll.

Use proper kernel comment:

  /*
   * Ignore return code...
   */

Also s/a error/an error/

With that fixed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

