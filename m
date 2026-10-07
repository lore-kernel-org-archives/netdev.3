Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AB3911A9
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365813; cv=none; b=Z1AkR384S/eKhCvrd2lcsn1vwwehYV9nNwns2kL0rnTBPshevv42mZdGcHyyUintfFAjUyRkdUKaiugg5vHAUrYLnQghIgX7XZH+gggaBttdQqF9TI/plmUut12Tg9OAY13pFixgkqC2lJ/rJZ6AutDda4AWrFvidhqb2Wzjw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365813; c=relaxed/simple;
	bh=6wlmBMug/czsODO6BZoaF+On6U3jjQlKqBL1Nax9BwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyhAxiKXMS1IiXj1XE+m15A9A08ZWh33OQOFiwiq3dhx4aVFd00lKd2x8B+SsG6DtpEaruwcTqRR7F6bZwMv8llC8ST/v+MFsEhdmTRJcDsWV8qYT6Xgr9lpeR4Qylf3wgPnX5Ht+Y0xhrl6blnquyLzxs9h+qelH9P+flUIOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nmCoNw19; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nmCoNw19"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0042D4E410C6;
	Wed,  7 Oct 2026 09:36:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C77856074B;
	Wed,  7 Oct 2026 09:36:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0F8B11D500A5;
	Wed,  7 Oct 2026 11:36:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791365798; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=z20W5mUIAexQAlTa3dlGNHHX48Yvv7PgJnJT1HAMI0Q=;
	b=nmCoNw19zCWapbVTqYNds9xg5iZW0txeUyi5eiclFAlFGe9N5b4Tp0nLOm2JZDfObXI7fL
	cimytk5ukcnLEGqUTOVRang3096yrnQDeuwLER4drGFJlNhpFZXnbK0bsb8uinteL2ULal
	1mGRVJsOGE0SbYWh/NbKAjebJlH9jFANexFuP1lAKPVYDDWdNsGXw86Tumf66UakPUsJbz
	89bP900/JNv4FcIfqzRfATbNmoz9+c1Elip9aOXoIKUM770Az6L2YGKg9hHubsM46Kca1b
	q/HAd48+3OZkLvkEIIqg5E+XFYQS5pDDX15GI/o1O8pCayMLceTwNWXDziL+Tg==
Message-ID: <ea812192-184b-4726-9ff4-abeca3a3b498@bootlin.com>
Date: Wed, 7 Oct 2026 11:36:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] net: stmmac: dwmac-meson8b: add support for
 the Amlogic T7
To: Lucas Tanure <tanure@linux.com>, xianwei.zhao@amlogic.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-5-tanure@linux.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261007082627.63807-5-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/7/26 10:26, Lucas Tanure wrote:
> The glue registers on the T7 are laid out exactly as the G12A ones, RX
> delay field included, so the T7 can reuse the G12A settings.
> 
> What it does not share is how the controller reaches memory. That path
> runs through a pipeline stage with a gate of its own, and no other
> device has any use for that gate. Nothing claims it, so it is switched
> off as unused and a transfer that has started can never finish.
> 
> Without that gate the controller cannot do DMA at all, so it is
> required rather than optional: a clear probe failure beats an
> undiagnosable hang later.
> 
> Assisted-by: LLM
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> index d73dfd0ac167..dd10d719ab84 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> @@ -81,6 +81,7 @@ struct meson8b_dwmac;
>  struct meson8b_dwmac_data {
>  	int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
>  	bool has_prg_eth1_rgmii_rx_delay;
> +	bool has_pipeline_clk;
>  };
>  
>  struct meson8b_dwmac {
> @@ -402,6 +403,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>  	struct plat_stmmacenet_data *plat_dat;
>  	struct stmmac_resources stmmac_res;
>  	struct meson8b_dwmac *dwmac;
> +	struct clk *pipeline_clk;
>  	u32 tx_delay_ps;
>  	int ret;
>  
> @@ -485,6 +487,13 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(dwmac->timing_adj_clk))
>  		return PTR_ERR(dwmac->timing_adj_clk);
>  
> +	if (dwmac->data->has_pipeline_clk) {
> +		pipeline_clk = devm_clk_get_enabled(dwmac->dev, "pipeline");
> +		if (IS_ERR(pipeline_clk))
> +			return dev_err_probe(dwmac->dev, PTR_ERR(pipeline_clk),
> +					     "missing pipeline clock\n");
> +	}
> +
>  	ret = meson8b_init_rgmii_delays(dwmac);
>  	if (ret)
>  		return ret;
> @@ -521,6 +530,12 @@ static const struct meson8b_dwmac_data meson_g12a_dwmac_data = {
>  	.has_prg_eth1_rgmii_rx_delay = true,
>  };
>  
> +static const struct meson8b_dwmac_data meson_t7_dwmac_data = {
> +	.set_phy_mode = meson_axg_set_phy_mode,
> +	.has_prg_eth1_rgmii_rx_delay = true,
> +	.has_pipeline_clk = true,
> +};
> +
>  static const struct of_device_id meson8b_dwmac_match[] = {
>  	{
>  		.compatible = "amlogic,meson8b-dwmac",
> @@ -542,6 +557,10 @@ static const struct of_device_id meson8b_dwmac_match[] = {
>  		.compatible = "amlogic,meson-g12a-dwmac",
>  		.data = &meson_g12a_dwmac_data,
>  	},
> +	{
> +		.compatible = "amlogic,t7-dwmac",
> +		.data = &meson_t7_dwmac_data,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);

