Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47A32ABCA;
	Thu, 16 Jul 2026 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188575; cv=none; b=i8/q7QX/SVhsfFLP0MTdyggCUWSVf9AQB89tWO+Im1CvfgiY8hSKL6MRZTToNolWFbI7taH7D/1+p1tT74PNEOjWCpq+Xp6j/lwfCySJNzEX7VgsvhaRBdEVQGJjn/v8nlSfLOUt6kiNA/+vQCKQj7BSXCsxoaKf/rMANjZVWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188575; c=relaxed/simple;
	bh=6eHobCTdtSFP1Xv9ktjEOStxsUtNWF18LVqiQv73IGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhpmH2EHgFz1cVMryoGEU0J8Jq3q2hehLKxiU2eNfUqul2GdlLveVtdv1TEJ5L/1lNE19VNpsypxQt2fK+dDCglFMBRDw+meLRHLMl9eEjhEgXC888b3JYJvqFWoEgnKCGv+kSsw3fV6CvSybmD6oxhryflMwEaFm5PPwYnsZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz7yz6Vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz7yz6Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731EE1F000E9;
	Thu, 16 Jul 2026 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188574;
	bh=iynh3mALdGfTeVuUBCsluq6Ns/4eXtdG/rMGWalEpDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hz7yz6VjkJcH4OhxChCfi+2nTnKbplW+xQa/kSuTd4tNeWHzOQBDFhfGj6gHTK0PI
	 tjNWopMkN99H8xbcYueCcVkgnpSuuPv9dfmcjJk7sGOI8RxbtjJRsVkX8lLYTMjvQP
	 rG3OO5EhmEP/X5gYzUSinEs8zAhV5rH/CEYIShcpGC1qnIKtV1yNpA7P4Sd0fkQPYh
	 Ulxul+WK1o1bdFQ7QtLGlzK/kyaMzDmeHCBG5RM9QnMy56ywhs+05gvmidPODbPj4u
	 oGlcXsz13tbYXrCG7A3k2uqFPtuYwch5Rw9iyIuyL6bx7IfBGnujwPWX+RjsmDytPT
	 IcQyW0IDB7whQ==
Date: Thu, 16 Jul 2026 09:56:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
Message-ID: <20260716-monumental-daring-beagle-28e81d@quoll>
References: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716021932.20037-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716021932.20037-5-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Wed, Jul 15, 2026 at 07:19:32PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
> implemented as FPGA soft IP between gmac1 and its PHY. This converter
> provides the RGMII TX/RX clock delays, so the MAC interface selector
> must be configured for GMII while the PHY is configured without delays.
> 
> Add the "altr,socfpga-stmmac-agilex5-tsn" compatible to the match table
> and detect it in probe to force GMII for the MAC interface selector and
> strip the delay bits from phy_interface so the PHY is not configured to
> add delays already provided by the FPGA converter.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v4: Add Reviewed-by from Andrew Lunn.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d288..bf591a68502f 100644
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
> @@ -650,6 +651,15 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
>  	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>  	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
>  
> +	dwmac->mac_interface = plat_dat->phy_interface;
> +
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "altr,socfpga-stmmac-agilex5-tsn")) {

Don't add compatibles around the code. Does not scale. You have driver
match data exactly for that purpose.

> +		dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
> +		if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
> +			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
> +	}
> +
>  	ops->setup_plat_dat(dwmac);
>  
>  	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> @@ -674,6 +684,7 @@ static const struct of_device_id socfpga_dwmac_match[] = {
>  	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
>  	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
>  	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
> +	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_ops },

Otherwise dvices are compatible? They why would you need this entry in
the first place?

Best regards,
Krzysztof

