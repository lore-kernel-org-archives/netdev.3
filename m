Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE5277035;
	Mon,  2 Mar 2026 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474499; cv=none; b=MzUqTInzOLjwCxujpc01bV793fQGY/wNAN4aFLL0aENsohg7mt2wQfPKFAXHZXnT+o9oEaJJTajYBoBs+xnwLBWV99/BGJQYC6cbfM2M4VjklGRDW60qLZTBidKm9CsGp/J7Jfla1B/AQbTlawyUpoOEct3/h3BAceXz9fWV7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474499; c=relaxed/simple;
	bh=F47aI2Jg9+VkUKB1QAIKB1gqgTBlbVQDpUe7PE+d7ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2OVlx8UqhrQDfyfxpOMuoiLarLCcFhoDGGPf5G3roeG288OLqH47MiND2E5X418aD2fHT63YZjYLFeGoz1tHzgSg2jlBWKnfFSqOr6408E2ULyA4nGffZbL8h1FoirwM0fDA+nOkHQJWZWeHk8/OYtkdTx60w4EaiH4TiLMFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gGtDOT+Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gGtDOT+Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3XVxUv9VFGIs66kBS1ywELCiYjFlBgmw/wMttbaL4lM=; b=gGtDOT+Qt9xtniDHEqZTXpL5qE
	q02Tcwgb3cHkjMblOBuBCbnaCjoXE4LWITTF6Pbgt3mOd0CUE3tpHk1aIKfaXPJWMi0G7ieaQPr6E
	iNMRM8hf+ka/Mvo37+L2xxLWHCKicGbduW6+B4dkJBjyyCfSre6dmbfp0B1MdAmooAxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx7a3-009iZ2-HU; Mon, 02 Mar 2026 19:01:19 +0100
Date: Mon, 2 Mar 2026 19:01:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v6 4/5] net: ftgmac100: Support rgmii delay in
 old dts with AST2600
Message-ID: <4a3975a5-f002-4c32-b45f-0f04edbfd25f@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-4-68319a4c4110@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-rgmii_delay_2600-v6-4-68319a4c4110@aspeedtech.com>

>  static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
> -					     u32 rgmii_tx_delay,
> -					     u32 rgmii_rx_delay,
> -					     phy_interface_t phy_intf)
> +					     s32 rgmii_tx_delay,
> +					     s32 rgmii_rx_delay,

You introduced these parameters in the previous patch. Please get the
types correct from the start.

	Andrew
