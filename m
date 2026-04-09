Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19347328B62;
	Thu,  9 Apr 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768177; cv=none; b=d+OkkLs3Zaq7mGha1oMxUEGjZsojcxHqwM1ex+8Goz1TVxWtb/tTdpHq0bzeLG0At0gWwOXy9hLnKd0kj7O1Bfjc25ceMItfnXqKcyuyvFglqhG+CYDrQFRqHy7dx8ij8EutTp8ji28LK35bhxZfCtdlpfFoZO7tLxS4qeQdaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768177; c=relaxed/simple;
	bh=xfwcNmlh4TZJyBxoyEhAeYqVYN+I/sx0Zfp+ERRAeMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiUs4EQbSDj4B1GIE/in0G5ZNDKOw2paDf86BkmgYkLLgqefSQc2sNGM9LTXY/HtZUyOXV7UO5YocecitopoMIN/6UZ8O/HOAPDpSPHbbPg6vvb/xYOblr/aCUj8HjY32B42E8p/+nkVdkdUZNky96Qtg5bGFwemCdqHuvyvYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wAwPv-000000004sK-1ih8;
	Thu, 09 Apr 2026 20:55:59 +0000
Date: Thu, 9 Apr 2026 21:55:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Frank Wunderlich <linux@fw-web.de>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>, Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC net PATCH v1] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes
 configuration
Message-ID: <adgSXDUn-oL6V_TK@makrotopia.org>
References: <20260409133344.129620-1-linux@fw-web.de>
 <20260409164942.wbmwtkpd5d5zibyy@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409164942.wbmwtkpd5d5zibyy@skbuf>

On Thu, Apr 09, 2026 at 07:49:42PM +0300, Vladimir Oltean wrote:
> I notice Arınc, listed by ./scripts/get_maintainer.pl drivers/net/dsa/mt7530.c,
> and Felix, listed by ./scripts/get_maintainer.pl drivers/net/ethernet/mediatek/mtk_eth_soc.c,
> are not on CC. Maybe they have more info.
> 
> Only the switch port has a chance of having a non-zero default polarity
> setting? (coming from the efuse, if I understood this discussion properly)
> https://lore.kernel.org/netdev/C59EED96-3973-4074-A4D8-C264949D447E@linux.dev/
> The GMAC doesn't?

Yes, vendor SDK uses DT mediatek,pnswap{,-rx,-tx} properties only for the
SoC GMACs. For MT7531 there are **no** strap pins deciding the SerDes
polarity, and also no software-way to override the defaults in the vendor
SDK.

However, the MT7531 datasheet quite clearly states:
Register 000050EC QPHY_WRAP_CTRL -- QPHY wrapper control
Reset value: 0x00000501

BIT 1 RX_BIT_POLARITY -- RX bit polarity control
 1'b0: normal
 1'b1: inverted

BIT 0 TX_BIT_POLARITY -- TX bit polarity control (TX default inversed in MT7531)
 1'b0: normal
 1'b1: inverted

Hence the best would be to just assume the documented default in the driver
as well.

A quick register dump using the BPi-R3 confirms that this applies to *both*
SerDes PCS on MT7531A (port 5 and port 6) equally, both read 0x00000501
after reset.
