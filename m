Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716D4A64F0
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060542; cv=none; b=pFhkiL3C1tLUL2YSfP8PY0O0G+RXcGxmrhnjtL4ijfyiBqzX5oq8SR+ythscNQN3WaXM7xXqcq+NAfrqwNc9i7YagQSZZGQ0lsH3FXRjGmuixQ7kK6uAnp44XEc3wCKzrh8aSKhTPm8ZC72eHAWzWyu3OjRDK69cOCko8wdG5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060542; c=relaxed/simple;
	bh=6dkRJLP/5BVAiu7H1TmYvn256NTDtpUQJ1vIReWXtjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLSCo7sPCc7mw6OTGUssc70a6amf4bqg0hiMi2/lY3upue5UrdfDYbtaWx6blGGCQ2Crv2b+IprdwqYRdK2nddctoohCbFSiiKBmL/J6UjIp0607zLUTrXOWEAejOepMyoKohZqztGL90RkhoxDCGQZgk7XAbpoSMn5o01+Z1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YFAWr1LL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YFAWr1LL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 790801A0FBD;
	Tue, 22 Sep 2026 07:02:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49D5A60580;
	Tue, 22 Sep 2026 07:02:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1E2010329239;
	Tue, 22 Sep 2026 09:02:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790060536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ssQctI4h9bdCd7Y/524FINFJI5J01KhR4UPJhm0pNBM=;
	b=YFAWr1LLVPWBrxuMYK0hZGy1a9yCo0Nryg9J/+kO3L8XBlB5PwXIeteAPxAyT4nVS9qe4b
	GPOc2KqgV06I4V9vWpO2WPZUpnljfwYP5gKWtfMY3aJ+GGg3rMX5jYtp955pzYzH8GGjrY
	vUAov3HahwFm+Gcex1Z2BBpHI6r4Xii9g9w6/EvWYqPCI8iUzNnoppvERzT3sFdc4ZEaH4
	3zuJKBdjX6sqM6Ylt6v5n2Zr80SEA2eeefyT/7lexB9WbF6VtyjDfz1NEdE6bTIYv7QyRn
	PzY3wJXFJ3ZWHaN8A7l73tH08UG6fl5M67qjFINyf7Enh8Tqfww6Mw6IoX9yow==
Message-ID: <3c1a0626-f3f7-49ea-8029-2c4cbb994ef9@bootlin.com>
Date: Tue, 22 Sep 2026 09:02:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/3] net: stmmac: sun8i: reset the MAC after
 PHY initialization
To: James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 LABBE Corentin <clabbe.montjoie@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: Alastair D'Silva <alastair@d-silva.org>,
 Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260921-submit-h616-emac1-v1-v5-0-ada661ed9e9b@gmail.com>
 <20260921-submit-h616-emac1-v1-v5-1-ada661ed9e9b@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260921-submit-h616-emac1-v1-v5-1-ada661ed9e9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/22/26 02:45, James Hilliard wrote:
> The MAC software reset needs a running receive clock from the PHY.
> Resetting the MAC at the end of probe therefore fails when the PHY driver
> has not been loaded or its probe has deferred on a missing supplier. The
> failure removes the MAC and its MDIO bus, so loading the missing driver
> later cannot recover the interface without reprobing the MAC.
> 
> Perform the software reset in the DMA reset callback instead. The stmmac
> core calls it during hardware setup after attaching and initializing the
> PHY, and resumes a suspended PHY before reopening or resuming the MAC.
> Mask interrupts before requesting the reset and retain the existing
> DMA and interrupt-register clearing even if the reset times out. Return
> reset errors through the normal hardware-setup error path.
> 
> Remove the unconditional reset from probe. Keep the separate H3 MDIO-mux
> reset after switching the mux and powering the selected PHY, since it is
> needed to latch the selected interface before MDIO accesses.
> 
> Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Tested on H2S that it doesn't break the platform,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 53 +++++++++++------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 48c52eb96233..9598c386bb21 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -269,11 +269,33 @@ static const struct emac_variant emac_variant_h6 = {
>  #define SYSCON_ETCS_EXT_GMII	0x1
>  #define SYSCON_ETCS_INT_GMII	0x2
>  
> +static int sun8i_dwmac_reset(void __iomem *ioaddr)
> +{
> +	u32 v;
> +
> +	v = readl(ioaddr + EMAC_BASIC_CTL1);
> +	writel(v | 0x01, ioaddr + EMAC_BASIC_CTL1);
> +
> +	/* The timeout was previously set to 10ms, but some board (OrangePI0)
> +	 * need more if no cable plugged. 100ms seems OK
> +	 */
> +	return readl_poll_timeout(ioaddr + EMAC_BASIC_CTL1, v,
> +				  !(v & 0x01), 100, 100000);
> +}
> +
>  /* sun8i_dwmac_dma_reset() - reset the EMAC
>   * Called from stmmac via stmmac_dma_ops->reset
>   */
>  static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>  {
> +	int ret;
> +
> +	writel(0, ioaddr + EMAC_INT_EN);
> +
> +	/* The PHY receive clock must be running for the reset to complete. */
> +	ret = sun8i_dwmac_reset(ioaddr);
> +
> +	/* Leave DMA and interrupts disabled even if the reset timed out. */
>  	writel(0, ioaddr + EMAC_RX_CTL1);
>  	writel(0, ioaddr + EMAC_TX_CTL1);
>  	writel(0, ioaddr + EMAC_RX_FRM_FLT);
> @@ -281,7 +303,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>  	writel(0, ioaddr + EMAC_TX_DESC_LIST);
>  	writel(0, ioaddr + EMAC_INT_EN);
>  	writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);
> -	return 0;
> +	return ret;
>  }
>  
>  /* sun8i_dwmac_dma_init() - initialize the EMAC
> @@ -738,27 +760,6 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
>  	writel(v, ioaddr + EMAC_TX_FLOW_CTL);
>  }
>  
> -static int sun8i_dwmac_reset(struct stmmac_priv *priv)
> -{
> -	u32 v;
> -	int err;
> -
> -	v = readl(priv->ioaddr + EMAC_BASIC_CTL1);
> -	writel(v | 0x01, priv->ioaddr + EMAC_BASIC_CTL1);
> -
> -	/* The timeout was previously set to 10ms, but some board (OrangePI0)
> -	 * need more if no cable plugged. 100ms seems OK
> -	 */
> -	err = readl_poll_timeout(priv->ioaddr + EMAC_BASIC_CTL1, v,
> -				 !(v & 0x01), 100, 100000);
> -
> -	if (err) {
> -		dev_err(priv->device, "EMAC reset timeout\n");
> -		return err;
> -	}
> -	return 0;
> -}
> -
>  /* Search in mdio-mux node for internal PHY node and get its clk/reset */
>  static int get_ephy_nodes(struct stmmac_priv *priv)
>  {
> @@ -895,7 +896,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
>  		/* After changing syscon value, the MAC need reset or it will
>  		 * use the last value (and so the last PHY set).
>  		 */
> -		ret = sun8i_dwmac_reset(priv);
> +		ret = sun8i_dwmac_reset(priv->ioaddr);
> +		if (ret)
> +			dev_err(priv->device, "EMAC reset timeout\n");
>  	}
>  	return ret;
>  }
> @@ -1217,10 +1220,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "Failed to register mux\n");
>  			goto dwmac_mux;
>  		}
> -	} else {
> -		ret = sun8i_dwmac_reset(priv);
> -		if (ret)
> -			goto dwmac_remove;
>  	}
>  
>  	pm_runtime_put(&pdev->dev);
> 

