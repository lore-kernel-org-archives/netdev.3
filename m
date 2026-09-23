Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCE57F742;
	Wed, 23 Sep 2026 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201724; cv=none; b=bDAORV8r2G5lcGVYNI2Gp2xVbKh1x0bs8AOKGW8iaIAxjAqqAOWxgOVkXq/YPbyWJ4WR2vNu6FcO+qU+C1mZbZl6SkZgKF+/glRwJ2OwIzcdFsEDfB1W9NVcfgTXebpRUrvrj2tWD6uHjEEp5aCCojVL3BsxiVi4gwM/2BTKh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201724; c=relaxed/simple;
	bh=vvKESw6I+hIKU2hGfXRgMp8Mg6v4aVJvVLhN6roNhZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVsekjB4uewUCDzSiltlJ9sGlEtMxbKDLFm09MhHcssHD5RunsIQwiFbixwbBNChPTFj2Y7fhBGyCAF2AhvO3ID9aFeOT4fZ/yxoUTkb4n+dvjYKWrHnAi7UxOO32eamVd/R/8ylMIdSezJRFerl/8cu5w+alI2BzPtoYiBpI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iNuptB2o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iNuptB2o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mLaZ6QMAlChH6Bas+cLTUExn52jNXV5CR8pfGjWWblA=; b=iNuptB2oIZhXrkQPyxHmWroghF
	onbceDSy5Aw6UTSEruhdhedVchiiIiwpBpcRkJDV/IenuwgLaaqGZbwrdhek5HrabtFtYXPJLVxWf
	lYJJOVf2J2fSDQ/JN6oPtHWm/32fpHCs+FIKA/vR4iq+yjUE6NcQ0vRgjjy8iLA4RirA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9VF2-006sqK-7V; Thu, 24 Sep 2026 00:15:04 +0200
Date: Thu, 24 Sep 2026 00:15:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v3 0/5] net: stmmac: Add support for Allwinner
 A733 GMAC210
Message-ID: <d02ff8f9-c708-4319-922b-69ab085ed9e5@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>

>  * Tx-delay: The vendor kernel ships with a Tx delay of 2.16ns. It may seem
>    to work at first but breaks under heavy load. The vendor kernel is
>    configured for an external RGMII clock, which cannot work on the A7A:
>    the 125MHz input and 25MHz reference output are not wired to the PHY.
>    It was most likely not tested on this board. A 1.62ns Tx delay works
>    well.
> 
> DT example is available here (gated on CCU and pinctrl mainline support
> currently):
> https://github.com/jbrun3t/linux/commit/aa6f3a5ce4cd6e09ff9be1828915bfe8e87c57df

&gmac0 {
	phy-mode = "rgmii-id";
	phy-handle = <&ext_rgmii0_phy>;
	phy-supply = <&reg_swout1>;
	pinctrl-names = "default";
	pinctrl-0 = <&gmac0_pins>;

	tx-internal-delay-ps = <1620>;
	rx-internal-delay-ps = <1800>;

Something does not seem correct here. rgmii-id means the PHY is adding
2ns of delay. The MAC is adding an additional 1.6 to 1.8 ns. The total
is way too big when the standard says 2ns.

Is the PHY adding 2ns?

	Andrew
