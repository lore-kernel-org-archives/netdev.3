Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41543B4A2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060370; cv=none; b=gwEgVH4hWPoIgXoPPAFbRGXwB7BM0JZAd5W8wxkx5zCbE+k+XBPiUTODCJWZXMuj13NDFom8ltj6nMgiLA76EyEJmTIGVuElgLOCMSxBeupqLhaftVmyrJkkNoIL7oh5tphttIa4nuURadK4PN0SCOINxndAGwCfbgJ3nXpxkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060370; c=relaxed/simple;
	bh=1TiV2Ip4e4Vs333/dEmHkKjYSPHQHH9TAPa+dveTvNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKiznIG3ZWGDgdUOi2FW2JGNIkVHcJIJA9fvzmUjmkNBGj6rsWyqfW+NXOS8s3oyHcagP9usFzWoCZr1cgcYE+w5WTqKZNXvR2au6j1OR5UpPl9gfxm0LDoEKMeMsosuT6Yra6JNFfU5Es07OdWzFgwCNpTwUtV0/w5jFscG5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=04z+sDMf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="04z+sDMf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E123C4E40EC4;
	Tue, 22 Sep 2026 06:59:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9947560580;
	Tue, 22 Sep 2026 06:59:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AD541032920C;
	Tue, 22 Sep 2026 08:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790060361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CYJeYVq+zoPSXgvrTiKhlttbrwfDZWH+MXsuurAOmL4=;
	b=04z+sDMfWGyJYBXSgQNXBy3AkYLFY8XpueASItQKWpzYTtG8+ABBFthFjuGX7LlEsXTh5T
	2TQ/8CPiNBsIHa5Wxg3NMxlaB/ekvbjTBgF/LPvPYvJjPEd9ZiDyHmMURMMwMt7RSSo09m
	PRdjI3GEuMVpgPBiFEc45AXbxcuhVOm3pOb3eNgj1Y+hPTojTMjAtUgsZql5UnqYLxEzaf
	JLQqOFIOz8QGxZOGo/0lln2uuvMiodSirzz3w1ZXmE6Jp/BJP1BoosQEmyTSEaJWT0K/SY
	MKLBHtp3HUpFOMk+MPyJN35Gd2n1rfSIwY70mcoBkcc0nPUTrmM9FintCMWsJg==
Message-ID: <839fd50c-f74a-4189-86f4-1d5173050fca@bootlin.com>
Date: Tue, 22 Sep 2026 08:59:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/4] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
To: muhammad.nazim.amirul.nazle.asmade@altera.com, dinguyen@kernel.org
Cc: rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260908070557.3585-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260908070557.3585-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/8/26 09:05, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
> implemented as FPGA soft IP between gmac1 and its PHY. This converter
> provides the RGMII TX/RX clock delays, so the MAC interface selector
> must be configured for GMII while the PHY is configured without delays.
> 
> Add the "altr,socfpga-stmmac-agilex5-tsn" compatible with dedicated
> match .data ops that extend the standard Agilex5 setup: force GMII for
> the MAC interface selector and strip delay bits from phy_interface so
> the PHY is not configured to add delays already provided by the FPGA
> converter.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> v6: No changes from v5.
> v5: Replace of_device_is_compatible() probe check with dedicated
>     socfpga_agilex5_tsn_gmac_ops via match .data, per Krzysztof
>     Kozlowski and Dinh Nguyen.
> v4: Add Reviewed-by from Andrew Lunn.
> 
>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d288..0632105b420f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -69,12 +69,13 @@ struct socfpga_dwmac {
>  	void __iomem *tse_pcs_base;
>  	void __iomem *sgmii_adapter_base;
>  	bool f2h_ptp_ref_clk;
> +	phy_interface_t mac_interface;
>  	const struct socfpga_dwmac_ops *ops;
>  };
>  
>  static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
>  {
> -	return dwmac->plat_dat->phy_interface;
> +	return dwmac->mac_interface;
>  }
>  
>  static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
> @@ -650,6 +651,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
>  	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>  	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
>  
> +	dwmac->mac_interface = plat_dat->phy_interface;
> +
>  	ops->setup_plat_dat(dwmac);
>  
>  	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> @@ -670,10 +673,28 @@ static const struct socfpga_dwmac_ops socfpga_agilex5_ops = {
>  	.setup_plat_dat = socfpga_agilex5_setup_plat_dat,
>  };
>  
> +static void socfpga_agilex5_tsn_gmac_setup_plat_dat(struct socfpga_dwmac *dwmac)
> +{
> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
> +
> +	socfpga_agilex5_setup_plat_dat(dwmac);
> +
> +	/* FPGA converter supplies RGMII delays; MAC uses GMII, PHY gets plain RGMII */
> +	dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
> +	if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
> +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
> +}
> +
> +static const struct socfpga_dwmac_ops socfpga_agilex5_tsn_gmac_ops = {
> +	.set_phy_mode = socfpga_gen10_set_phy_mode,
> +	.setup_plat_dat = socfpga_agilex5_tsn_gmac_setup_plat_dat,
> +};
> +
>  static const struct of_device_id socfpga_dwmac_match[] = {
>  	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
>  	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
>  	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
> +	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_tsn_gmac_ops },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);

