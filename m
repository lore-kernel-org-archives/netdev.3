Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B213E9F9E
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713203; cv=none; b=EdQ++rWU6/auaWrEcsNLIMZCx6eDgLg1wQmkQ+f4PJN8mfLjOIHbHV2SwvMSeJ0ix/oi3UD/z2+907HOr7p0qW7UMyVWNKQb3XtCsm2teGKncCwwK3jjRtRm+jB/cE9b+ocfCqWVXZ5HeSDxs662Zc4JrqPoW6yZM+PtFlIc1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713203; c=relaxed/simple;
	bh=EbSXcBqMMfveCqy6uhBrPdKT4djWL9ZotePDNSsSOr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFecKkqzvXv2WAX4ch6PjTSkI8qjst+WgdLX6fh1PM0S5+TEg0/PyDMmpGXb3fshwounYnHaQuXYxQgCRTPYXkOlhakmGat8zDkZariNWNivVgylmBxfHfuyQCqDl/6OZKLnsPq00cJ+O/8LGk0L5QBngAyU6xAd7HEfOl8SdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JgPp/hQm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JgPp/hQm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C82F4E4081C;
	Fri, 18 Sep 2026 06:33:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3985460649;
	Fri, 18 Sep 2026 06:33:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70D9511C7B021;
	Fri, 18 Sep 2026 08:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789713196; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ftGzUpVnNIEGoE6GoszZOmgYNmKU7OUqLtpA5Ajpo6w=;
	b=JgPp/hQmS7v2mjAPcx1oSH0N+/rwCpjI6NkxS02z/PBFoX6R0xtzlE1UFF7Xcf/OCCtjU3
	gN1gRrnmvGl0mNhl8eV6rAdz0ArMMcnUUc2LZXlp9aOKKI84aRpEucGVCKZ7SHQSPfYizv
	5rg+K/tfQNuAzUREELMQuJBcsuiDxUndjAnN6/nth3AY+B6tHLnBqBIoRx5DzdNLyfNfDz
	o7SZYZGeiNpqwPWSVVW9QA9hC6Qc6EF9+Df2i1L8Ae5Nw/X6BNOfvVWNYB1mzgdNJVg9B3
	dgcQc8BEZhA6zgjuTF3awLtKRlDFS3bM/H5m6E5aOeZk+agF76MjktGn6E7SOA==
Message-ID: <97fd4b73-258a-44c5-beaa-53141d2807e0@bootlin.com>
Date: Fri, 18 Sep 2026 08:33:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: sun8i: reset the MAC after
 PHY initialization
To: James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
 <20260917-submit-h616-emac1-v1-v3-1-62cb8316e19b@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-1-62cb8316e19b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/17/26 19:55, James Hilliard wrote:
> The MAC software reset needs a running receive clock from the PHY.
> Resetting the MAC at the end of probe therefore fails when the PHY driver
> has not been loaded or its probe has deferred on a missing supplier. The
> failure removes the MAC and its MDIO bus, so loading the missing driver
> later cannot recover the interface without reprobing the MAC.
> 
> Perform the software reset in the DMA reset callback instead. The stmmac
> core calls it during hardware setup after attaching and initializing the
> PHY, and resumes a suspended PHY before reopening or resuming the MAC.
> Keep the existing register clearing after a successful reset and return
> reset errors through the normal hardware-setup error path.
> 
> Remove the unconditional reset from probe. Keep the separate H3 MDIO-mux
> reset after switching the mux and powering the selected PHY, since it is
> needed to latch the selected interface before MDIO accesses.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 50 +++++++++++------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 48c52eb96233..4523a14f5e0c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -269,11 +269,32 @@ static const struct emac_variant emac_variant_h6 = {
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
> +	/* The PHY receive clock must be running for the reset to complete. */
> +	ret = sun8i_dwmac_reset(ioaddr);
> +	if (ret)
> +		return ret;
> +
>  	writel(0, ioaddr + EMAC_RX_CTL1);
>  	writel(0, ioaddr + EMAC_TX_CTL1);
>  	writel(0, ioaddr + EMAC_RX_FRM_FLT);
> @@ -738,27 +759,6 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
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
> @@ -895,7 +895,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
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
> @@ -1217,10 +1219,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
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

