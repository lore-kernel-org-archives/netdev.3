Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B31A267;
	Wed, 28 Jan 2026 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636746; cv=none; b=JgW3NNajiOyyOU9mozf40PZ/6wKjYiiKDtyLkDm1NRAMfPNyGKhr6XGY9hLk/NcsEV6d/IbGIFqsTD5FYSUME5562A0rkcDBTw46COQJKXBt8VVxDLffUV5n2sk91cisA82w+UF/GwceeNj4PU4rxd3DBlhoixwKTziOo9kV1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636746; c=relaxed/simple;
	bh=G9jVy6IaUc8xwMRV/EbT+4BkwQyONvaIh3LQYR1VmTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa7jAryXEuLAiAufxgFOD2e8S5acM1RT+vgHfTf1uwdUkju+3wJI8DDGTSh4YoPHhs9w3zLeY7uXAtZbViHm1HEgravsuqikAL8Bls5zP+6MQYnBNDsngwIX9b7g4LuZNWBYdeHavMrcdMAm0mWqtTxnLYxNYdOwOZPlKbKWCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XP29vZNe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XP29vZNe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=eRNNdhYMgq20mFtzfNKVPJV8CTtJi4n1za6OfLaID3I=; b=XP
	29vZNeUQvObmsRmKvt+rydwfC83L4Nm6jZrcu81PBpcq8blxbg56qMKD7jGRpIaL7zjMxveGTfQMb
	0iz02paHH98KDGme7Gduf00e74FSttphUTpJQdE9hKSYnmUd6t8tYoX51oZTRb9my85NAj6Hd6/r9
	d7IQc4yGlsV4n14=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlDLw-005HSL-L1; Wed, 28 Jan 2026 22:45:32 +0100
Date: Wed, 28 Jan 2026 22:45:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Message-ID: <9f6b520c-203d-48cc-8bef-18959672052c@lunn.ch>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <fe9385a5-170f-474c-af8d-24bbfa5eb3ab@lunn.ch>
 <CAOf5uwkr0Rmb_x0U88JAfozCQpkOoFOZ-V7BNteVZfcnNQF-Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwkr0Rmb_x0U88JAfozCQpkOoFOZ-V7BNteVZfcnNQF-Lw@mail.gmail.com>

On Wed, Jan 28, 2026 at 10:04:03PM +0100, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Wed, Jan 28, 2026 at 9:51 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > The issue was with the out-of-band reset coming from the FEC driver
> > > which doesn't honor the phy state-machine.
> >
> > Could you explain this is more details. Is the FEC doing something
> > wrong?
> 
> The fact that the phy should be reset when the clk is provided to it, is not
> connected at all with the fec. I think that fec_main does not register itself
> as clock provider, You "should" define the phy to have a clock if this is needed
> during the restoration and we should not give any "magic" at controller level.

Do we know which clock the PHY is consuming?

The FEC has code for the clock "enet_out" which it enables and
disables. If the PHY is also consuming this clock, we could also make
it a consumer. The CCF reference counts enables/disables of clocks, so
if the PHY enables it, the MAC won't be able to disable it.

    Andrew
