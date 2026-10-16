Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1FF47ECCB;
	Fri, 16 Oct 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165705; cv=none; b=NL72o45K0e1WBmh8QT/e44QzXxJZnOnJLcfOBRIs5CNHVuCtEDo8tthQoXjDviDKSisDjmROwvZur4hcSiBYZEmRPMXrY1v7oVCh3VzhDMlyPAUCasaKXvnE6bLAktXmtx7aqM2A0/RyKyoVnUh97b8Coo+Czw9RDiWgLXml+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165705; c=relaxed/simple;
	bh=MWQolsQMP/R0xFMm25F4SiAZYHr1og2dwTLxkuZYUYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc3yqKZknsRHIdpF4pdDNHcP6Bch7TYBav7mSJ3Q6jXMVN81tmpwvGL59yxf/bQWgKU9dHC+Z/ibq5KOG9jYgu4EC2W/9yLRJ9J9xSM/gC5nnLgM75JtT3oGSHpbtEz2gGqmbrGcYzKBoW5pKA5wvS57g2unRBvb4ooW/QZ7gqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2nnl7trS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2nnl7trS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QunjdoyS2VP8sVHK+P0nXc1zdB5/E8xy4McPChK5nU8=; b=2nnl7trSgRrRUbAJxW1SdJLoWN
	K04uHr8nJfWn8jwwmC7nWzH0RF3e2neTXAB/KvB6LoE+YfjktMLA2/NREFk2DVUV6Ye601vessMks
	ui1BXN10jjodbJUb58fqOwUYCyRlAoMiv1zQGtaQ85Jh1M8OSm0j9ztH9exwJI3proO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHkAF-00BAwL-HC; Fri, 16 Oct 2026 17:48:11 +0200
Date: Fri, 16 Oct 2026 17:48:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@kernel.org>, kernel@collabora.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v3 7/9] net: stmmac: mediatek: use TX clock
 phase shift in RGMII mode with 1Gbps speed
Message-ID: <1f347450-a68b-44e2-8b57-53204eb61e55@lunn.ch>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
 <20261016-dwmac-mediatek-mt8189-v3-7-25daf2bbcf35@collabora.com>
 <eabe305d-bb0f-4927-919a-21b025ec145d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabe305d-bb0f-4927-919a-21b025ec145d@bootlin.com>

> > +static void mt8195_fix_mac_speed(void *priv, phy_interface_t interface,
> > +				 int speed, unsigned int mode)
> > +{
> > +	struct mediatek_dwmac_plat_data *priv_plat = priv;
> > +	const struct mediatek_dwmac_variant *variant;
> > +	struct mac_delay_struct *mac_delay;
> > +	u32 tx_delay_stage_val, reg_offset;
> > +	u32 reg_val = 0;
> > +
> > +	if (!priv_plat)
> > +		return;
> > +
> > +	mac_delay = &priv_plat->mac_delay;
> > +	variant = priv_plat->variant;
> > +
> > +	if (!mac_delay->tx_delay ||
> > +	    (interface != PHY_INTERFACE_MODE_RGMII &&
> > +	     interface != PHY_INTERFACE_MODE_RGMII_RXID))
> > +		return;
> 
> I don't think this is right. PHY_INTERFACE_MODE_RGMII in that context comes
> from the devicetree, and therefore means "RGMII delays are implemented through
> traces on the PCB", the MAC isn't supposed to insert any. RXID means "TX delays
> are on PCB, RX delays are internal).
> 
> I'd expect the condition here to be:
> 
> > +	if (!mac_delay->tx_delay ||
> > +	    (interface != PHY_INTERFACE_MODE_RGMII_ID &&
> > +	     interface != PHY_INTERFACE_MODE_RGMII_TXID))
> > +		return;

I would maybe base it on the value of tx-internal-delay-ps. If it is
2000, then add the delay here. But that has implications for the
interface mode value passed to the PHY.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

We could keep mt8195 KISS, and reject all these properties, and let
the PHY add the delays.

	Andrew
