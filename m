Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C93ACF02;
	Sat,  1 Aug 2026 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618347; cv=none; b=rKAtZ4/+b/hBF2+MwGmZR/rdHNcBc4fkRNeaG2k7tVuT0DZ4HPr9LwPeE0EISvca7HZdp22F0PkYfb4WFUkrJjjav90sQCnE9o02vpsCTOQPsETZKfs2BcWSobOlhy2mkBqvUgrkbIBP6GPI8CwxvgFWGmYPjEmOeOLmluVtJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618347; c=relaxed/simple;
	bh=LoaJ2VApIXg5OTyTu8/XNBtMZkbgqaI42vYyscptUL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXtyFALk9mKCrMXzd6ObCW54BvbBcDBy3gAMtf2huXQOKUxwr4O/FPBHaqvyXnNnTbrBYD/CslBJ893iuRehsCdcHeJ7f8MDlTxY87w33kdazlRO8tx4kl4GOaL5zrUCeNlvE6UuV1NS6ndXA+7RH+/d6+ACWJv4eBKQND/v5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cajt7qcb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cajt7qcb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OzuU/6al2UfdQ5v0OA/wKgoPuo/ckl60pBteNAIG7Bg=; b=cajt7qcbPewc6StlNWT0gPfcpr
	q1nmIElq44xq5JoRJv2z6hW6LnevssnezFbfyt45BhYJQL/mPv8ejmUUcBMqK1mlF4fqo5BcXomXE
	g5siVixGy1UBu3H1zIsM2t1ozEzlsdvxC/HTOTWlaoTZmo3N1DzCS/TGNSeBZ5SSQJ5g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqGta-00FQKK-Ny; Sat, 01 Aug 2026 23:05:26 +0200
Date: Sat, 1 Aug 2026 23:05:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 05/10] arm64: dts: rockchip: rk3568: add XPCS and
 fixed-clock nodes
Message-ID: <0e9d16df-7332-446b-9321-ce3de3111ffa@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-7-coiaprant@gmail.com>
 <2847036.GUH7pLUipS@diego>
 <CALj3r0gqvFZPb2SKRMPwf9chCx076rwCnXEoOMFch_V-fOKV6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0gqvFZPb2SKRMPwf9chCx076rwCnXEoOMFch_V-fOKV6w@mail.gmail.com>

> During my tests, I found that the 125 MHz clocks (`xpcs_gmac0_clk` /
> `xpcs_gmac1_clk`) are actually outputs of the Naneng Combo PHY
> (SerDes) when it's initialized for SGMII/QSGMII mode, rather than
> independent board-level oscillators.

Do you have documentation for these Combo PHYs? Can these clocks be
enabled/disabled? And how is the Combo PHY fed with a clock? Does it
have an external oscillator/crystal?

     Andrew
