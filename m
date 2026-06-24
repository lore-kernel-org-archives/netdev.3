Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEC3D6CB6;
	Wed, 24 Jun 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315601; cv=none; b=udXNcVyEbUip0sD262KkFmGcE8OsXm1dGN7VX7kDSHfxzUWzi1ONzM0QoB5DTMuFzW1kzlLVLtnVGMLBgW5EJKSD+5giOiuzSUfPpo6EQH3StPIbTCBFFNRQfeWtQn+PUPyJB8AVKwNfGAgLizOx89QSad9bNv1DhKPs0nR6Fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315601; c=relaxed/simple;
	bh=pCja0bMwasFN1DRcO6/tgjWRmJZBBZXfwggkYuX4OlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcwEdmc7d/sBjE2ms5/Yxih3kWot43YD1DS8Kzd8ZWc8U1EbJf2YkVhszhfXBjyo78pYlnwb/j77vGNZzbaODTHbtRdUku9TowmlGUuGBjEPSwNyAUEMnjCnyP/j9pIyjg3MbF9IM4f78K6SzQCYECqsjD6vgPuXPE5Q+GP3lbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ePY2ywc1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ePY2ywc1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yHAPNcQ5EKyi7n1ik7WzWF+RwYT1Afv+h7uAsSVT37U=; b=ePY2ywc1fQl0LEsKtNKvYMHLoq
	puhjGDFNEGFC4FwqspAIfys1IPAcHKK1DeRyboD+Jd/8E1mWjL4XTkueom1bn3nUD7DhacZv31AUP
	SWTDPYLfX5jLbXN2TpZKB6UrFPgcqZ9o6tWnkQkEb29+dbQgSnS5omx9mK9GPQBqAr8I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcPhP-0096s7-BA; Wed, 24 Jun 2026 17:39:35 +0200
Date: Wed, 24 Jun 2026 17:39:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 4/7] net: stmmac: dwmac-rk: Enable refout clock for RGMII
Message-ID: <bb50eb6a-561b-4e48-b8ed-2ed5a17b6a1c@lunn.ch>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
 <20260624-rv1126-alientek-dlrv1126-v1-4-5aef608a3f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-4-5aef608a3f64@gmail.com>

On Wed, Jun 24, 2026 at 04:44:41PM +0800, Yanan He wrote:
> Some Rockchip GMAC integrations use clk_mac_refout as an external PHY
> reference clock even when the MAC is configured for RGMII.
> 
> RV1126 boards can route CLK_GMAC_ETHERNET_OUT to the external PHY as a
> 25 MHz reference clock. If the driver does not acquire and enable this
> clock in RGMII mode, the common clock framework may disable it as unused
> and the PHY can lose its reference clock.
> 
> Enable the refout clock handling for RGMII in addition to RMII.
> 
> Signed-off-by: Yanan He <grumpycat921013@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e68926..f6fdc0c5b475 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1112,7 +1112,8 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>  	bsp_priv->clk_enabled = false;
>  
>  	bsp_priv->num_clks = ARRAY_SIZE(rk_clocks);
> -	if (phy_iface == PHY_INTERFACE_MODE_RMII)
> +	if (phy_iface == PHY_INTERFACE_MODE_RMII ||
> +	    phy_iface == PHY_INTERFACE_MODE_RGMII)

Apart from Heiko commenting that this patch is completely wrong, there
are 4 RGMII modes, not one. You should of used
phy_interface_mode_is_rgmii().

    Andrew

---
pw-bot: cr
 
