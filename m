Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FDC35CBB8;
	Tue, 27 Jan 2026 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527061; cv=none; b=JFOVj3VkZY65hD4av9H8SRLZY8b2dHdbscMJ1imMmQ+4rCk5P5IpYHPFL1qz7k19cWrzGn2b7zmwO5m9vKJrFpxUuds51ojbWfAQ0bJLPnfHNccwjq3DxOYx0ca5531Gmne/sO/bbQJO31yTU1NTi8yqHOXM/n59qxkbW6Epies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527061; c=relaxed/simple;
	bh=gmhD44L1K9tLudyPg622CFQJdiQBqosgYt3gwdurMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjyy17BTVGnzlp+5Tga5R9k47r4zprQSb+HyNfNssn4obihfedHU2f5vxUcB1WM47J2E+mWqWMR4V74L5qXuVMhQsWacUFu2xbEsyXyw0pIew0wuWLE0asgWcajL19ikTO3gbbKyp/BPFVmpFNl/9PlvpSeDF6tu39Dl0WQqe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pI9qkzvu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pI9qkzvu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZVh052NF40220AWAqRlV3TkXB/pLRow1eBVBsLhpPPk=; b=pI9qkzvuh9ZDIMnTPnQKFVkG/p
	wdEN50YVxEZV47ubYV+IF8h7+5JuCrLjnr4XITbJn0KsVpV6p4P3iJUF6EGdJxWIhtJsLvlTaPZmd
	FxOQS6mq8hG+jNsCevTeiywb1IEYaXeqJOWuk6n0kTUXFS6jaNz4Mx8px8l8wyL0vfVw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkkoq-004yQu-1s; Tue, 27 Jan 2026 16:17:28 +0100
Date: Tue, 27 Jan 2026 16:17:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 00/14] net: stmmac: SerDes, PCS, BASE-X, and
 inband goodies
Message-ID: <34469896-9ea8-4f82-891f-0b57253f6cc5@lunn.ch>
References: <aXNEwBW3OA1xLEUj@shell.armlinux.org.uk>
 <aXN5BFXMshnhwBQ7@oss.qualcomm.com>
 <aXPo5R1Q-qWG3r3l@shell.armlinux.org.uk>
 <aXjSbu6L6ICYOPiJ@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjSbu6L6ICYOPiJ@oss.qualcomm.com>

> I added additional debug prints, and I think the crash is due to
> BMSR_ESTATEN not being set in GMAC_AN_STATUS.
> 
> During pcs_init, BIT(8) of GMAC_AN_STATUS is 0:
> [    7.985913] [DBG] GMAC_AN_STATUS = 8
> 
> Therefore, this check:
> 	if (readl(spcs->base + GMAC_AN_STATUS) & BMSR_ESTATEN) {
> 		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> 			  spcs->pcs.supported_interfaces);
> 
> 		/* Only allow 2500Base-X if the SerDes has support. */
> 		ret = dwmac_serdes_validate(priv, PHY_INTERFACE_MODE_2500BASEX);
> 		if (ret == 0)
> 			__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> 				  spcs->pcs.supported_interfaces);
> 	}
> fails, and PHY_INTERFACE_MODE_2500BASEX never gets set in
> pcs.supported_interfaces. Pardon my naivete, but does the
> BMSR_ESTATEN bit not being set break some standard?

You might want to check the IEEE 802.3 standard. It is free to
download from IEEE.

The original C22 register definitions only supported 10 and
100Mbps. In order to support 1G, more registers are needed. The
BMSR_ESTATEN bit indicate the PHY supports having more status bits in
register 15. Register 15 then indicates if 1000BaseX, 1000Base-T is
supported.

If the SERDES supports 1000BaseX, it should have BMSR_ESTATEN set, and
register 15 should indicate 1000BASE-X.

	 Andrew
