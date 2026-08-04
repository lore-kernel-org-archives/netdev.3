Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A03F6C50;
	Tue,  4 Aug 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854684; cv=none; b=J3+K9FoRY7zbaooLiNE6GZiIOl0ulm51Wg+noRb/RMwFi0O3rVmbSJIi8gslZcZI5B72CPg9JevLq0r4vq9UIqtL74PQZjB6uB7gIcRfM/KXKa4A/NLHZia7bbgp/ySEYbSEsEeN6NBA5YBs/h8vlhjo5YKZDzy/07oOp0AW5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854684; c=relaxed/simple;
	bh=R8f8i+SMdVFGpfr5nD/l7UbuV0J14/4rlc7Upub887c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qV3aY8AMblOksIQgVw5ORPM6cGDvNq7daoS6ZrrJHAqzE7DEcr4ODAUmaCe9eFb/EGEas4Nfe6gozZpKcgiu5Xh4kf7oQkkn2lK1X4icJXIIHZuJ93eLvBuVRYgGvI1LOyUVE1UokNDBH4XDtQDfhCcZNmJFr1rxzyF9kiGgSww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SGp5NuD0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SGp5NuD0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ZUW+r4FCY0U+LwKfUl0eF3OjFw9eBKouwZVjhFevUS0=; b=SG
	p5NuD0aiUnNJjW4FKOYvaYgoP4X/Ix960dvodpnmGbRjCai+YeB/TCF8XaaaudsWFgyHIpAiKTYrh
	dK6kK5FMbbagl36kF8brz2qoAKbdkDLy24ADVx5bzSs99CAZ1YmIaTsrSEgOrVnOYYNJ4vpg2YGXU
	l935Tc2gKon+n3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrGNb-00G0KA-Ov; Tue, 04 Aug 2026 16:44:31 +0200
Date: Tue, 4 Aug 2026 16:44:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liu Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a523: x96qpro+: enable
 Ethernet support
Message-ID: <f2dc4bbb-ed90-4661-ad5c-f8c51075138e@lunn.ch>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
 <20260803101452.2993721-7-andre.przywara@arm.com>
 <ad2e46d5-53db-49b2-a128-7c54883e18eb@lunn.ch>
 <CAGb2v64yH+grXMbxg1te6XHt1PxhUc4Jzch_OdUW50tq2Eg1cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v64yH+grXMbxg1te6XHt1PxhUc4Jzch_OdUW50tq2Eg1cw@mail.gmail.com>

On Tue, Aug 04, 2026 at 11:11:04AM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 4, 2026 at 10:53 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +&gmac1 {
> > > +     clocks = <&ccu CLK_BUS_EMAC1>, <&ccu CLK_MBUS_EMAC1>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&rgmii1_pins>;
> > > +     phy-mode = "rgmii-id";
> > > +     phy-handle = <&ext_rgmii_phy>;
> > > +     phy-supply = <&reg_cldo3>;
> > > +
> > > +     tx-internal-delay-ps = <200>;
> > > +     rx-internal-delay-ps = <500>;
> >
> > 500ns is quite big. How did you come to this value? Do you have the
> > schematic & gerber files? Does the lines look unbalanced?
> 
> Unit is ps, not ns.

Yes, sorry, wrong units. But still 500ps is very big. You have the PHY
adding 2ns, due to rgmii-id, and you add another 500ps?

       Andrew
