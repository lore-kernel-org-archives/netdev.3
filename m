Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4413F329F;
	Tue,  4 Aug 2026 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809325; cv=none; b=Y9BYEXmIeFwXwFrcDC74CD2V5HobAcFHyJgt7YGQBzJBxp4L7uSEIPLPADzRZJ6l5cmH2hOe5avOTM6jI6Z9RY/4v+xxwEzsGr1ylFUK61QywbBppT7epQ2REV2x6mExpB2Z3z/CTi0vqgxcjYZrVZjV1XBA3t+yEpkxsLytoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809325; c=relaxed/simple;
	bh=lG1npyH/N3XxCott4dScsf4E27x9td+0vqWynAnKvFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfcqrCfeSxpPHNeSIM8DyALAW+xAGG34TTL3kTXwOYQhHyIZ7+xeddsVWP3n13r4EDI9kpX0gAhjLGz/xFaJBLDc9ra8LvUtb4nN1+uqnC+WTdoqdL9FylTj4PHt4hEnmjH4766FoPvd9m+DpJ1rLL9l6JUW04KbfRqnLZawTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hysqWGGq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hysqWGGq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U2EK07+wqnSMzescspEC9qsT2233v6Xmazp/HC0ovbI=; b=hysqWGGqjQ64vonaJgoLWb0oEB
	rPgAjIo1dk2UsVdsLFuox1nd/XEI2HqSWifXpDZUEpuYBDU9PLd18FApx1m/exERlbbBZ9Sj/+lX5
	bVSBi/u5JCsCQB8CcSpoHAMSCT0zAhN8+zp5Wzm/dxgI/nCRtxYQ6jupp6hekYPKCz9g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr4Zg-00FtJQ-3B; Tue, 04 Aug 2026 04:08:12 +0200
Date: Tue, 4 Aug 2026 04:08:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 1/5] net: pcs: mtk-lynxi: check regmap reads in
 mtk_pcs_lynxi_get_state()
Message-ID: <b2f3f283-90f0-458f-ad0e-1745cf38b008@lunn.ch>
References: <cover.1785368701.git.daniel@makrotopia.org>
 <b58d5d99dddd67e35a6f14a14a6ad63d8b3fbadc.1785368701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58d5d99dddd67e35a6f14a14a6ad63d8b3fbadc.1785368701.git.daniel@makrotopia.org>

On Thu, Jul 30, 2026 at 01:14:38AM +0100, Daniel Golle wrote:
> mtk_pcs_lynxi_get_state() ignores regmap_read()'s return value; a
> failed read leaves bm and adv holding uninitialized stack values
> which are then decoded into the reported link state. The regmaps
> backing the MT7531 SGMII PCS instances sit on an MDIO bus where
> reads can fail. Check both reads and leave the state untouched on
> error.
> 
> Fixes: 4765a9722e09 ("net: pcs: add driver for MediaTek SGMII PCS")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
