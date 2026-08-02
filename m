Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626E2931D3;
	Sun,  2 Aug 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683997; cv=none; b=ZGmyqObB7eNNdzRWj8zOS1UaagUEKvhEf1ijXI7DiZrqEyBMylivALd2w6FDrzPEfTxr70771IvxTtMMv16xWATQIPBWSikfvWQXT0loUM+TZlupvMZBLagfn6gqii9/I66CkQvlxtdH4f78ROIk8NpU2GclwQZJd+Oz2gfysPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683997; c=relaxed/simple;
	bh=1HGDrMZ1BqpI9hUWlFku6bWHehw4KUPQbxACLf/zSBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIbHj9VIjg5B0V3q7L9Yo42A7Dlj/BTqE786LZ7nZ/QLIBcPg9oo754Zo6E2XlFXPgVcCH+k0UJfysxGtPXhiUUmmS4A8gRtEbVlFn/6QEYatL4e4DAORH5ZRY/+0QosdSZpAO4MV1L9zrU07q9DN2j4BqgQG1WfDCGaIs1bzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u/0i0lfy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u/0i0lfy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z0iZTbjCu+gfJgRQt1mMeYmu8eVDQV+4fRYL8uwZYK4=; b=u/0i0lfybCTJSYExtr1Uw0vxtn
	Nx7C6sUcYSujLOoYXNwABTyDo1VUA5n7QDbPAnLqCRLrVGi6SQzBP2DhJAZBVAlmf7yVG7FUFcfgJ
	jevye1Vhb3DEE4iNL7RwlkajiQRndE69KmejwyJaSEYkBs56K0bBbitBBzCNhsqTUkrc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqXyT-00FaSJ-CD; Sun, 02 Aug 2026 17:19:37 +0200
Date: Sun, 2 Aug 2026 17:19:37 +0200
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
Message-ID: <4106e359-aec0-4f38-b74f-e9757a48eebb@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-7-coiaprant@gmail.com>
 <2847036.GUH7pLUipS@diego>
 <CALj3r0gqvFZPb2SKRMPwf9chCx076rwCnXEoOMFch_V-fOKV6w@mail.gmail.com>
 <0e9d16df-7332-446b-9321-ce3de3111ffa@lunn.ch>
 <CALj3r0guMmNRN4EBbKz7stPNMSqkLBvms643YXBEDMzqHHM=FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0guMmNRN4EBbKz7stPNMSqkLBvms643YXBEDMzqHHM=FA@mail.gmail.com>

On Sun, Aug 02, 2026 at 11:28:12AM +0800, Coia Prant wrote:
> Hi Andrew,
> 
> Thanks for the detailed questions. I've looked into the clock tree
> more carefully.
> 
> > Do you have documentation for these Combo PHYs?
> 
> Yes, the information is available in the Rockchip RK3568 TRM
> (Technical Reference Manual).
> The relevant clock tree details are also mentioned in upstream
> discussions and patches.
> 
> > Can these clocks be enabled/disabled?
> 
> The 100 MHz input clock to the Combo PHY is a prerequisite for its operation.
> It is generated by the SoC's internal PPLL and fed to the PHY through
> a fixed divider.
> It is not a gate that can be individually enabled or disabled by
> software; it is part of the
> PHY's fundamental operating conditions.
> 
> > And how is the Combo PHY fed with a clock? Does it have an external oscillator/crystal?
> 
> The Combo PHY is fed by an internal 100 MHz clock derived from the PPLL.
> Specifically, the PPLL runs at 200 MHz, and this is divided by 2 to provide the
>  100 MHz clock input to the Combo PHY.
> So, it does not use an external oscillator or crystal for its main
> reference clock;
> it's generated internally by the SoC.
> 
> To summarize:
> - The 125 MHz clocks (xpcs_gmac0_clk / xpcs_gmac1_clk) are outputs
> from the Combo PHY.
> - The Combo PHY itself is clocked by an internal 100 MHz clock from the PPLL.
> - This is all internal to the SoC and does not involve a board-level oscillator.
> 
> I hope this clarifies the clock architecture.

So what is the purpose of the fixed-clock DT nodes?

If you want to describe the hardware, is the PPLL in DT? Should you
then add a fixed divider to give 100MHz? And then a fixed multiplier
to give 125MHz?

   Andrew
