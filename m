Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916953B52EF;
	Wed, 30 Sep 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781325; cv=none; b=Z/aoZKGd4QSdBriSYoM80KeNUAiOrTkbi4SQc5/XJYrB3DZAVRoE+UTum92ArqNId4RMXVl3+TozYEJWX0a0FbqzmJwD0Co1c8dc1mJfv1ju0qHQk3J/cEBOl4B/fMWYIIvC8U9A4T+aiBP3M/DScoeGk87irr2UpBAYuklME80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781325; c=relaxed/simple;
	bh=qz4Fg/NZMFtt5917sEIV3AYeWWMbkgLWb/OXlGiNprs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o35z8vM5FcfxC2t4SDBDN/hNUmtoKQbRybq7Pzzzux93TUXh1T3myomCne9OaqcXOWzgE3s67vp1+/fMbgN8ylxtMpBB+WFbIx7GrphKdqxYDhVDW3GDuwwwmRFtUfBCJkpj0b5cQcEl1RWwrlgNLxbBPqhhKyGMWSfT04B9C9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cxo4EFjX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cxo4EFjX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W5+GFw8PoAhUib0JdEYgzsHo9FUQvwW3oG2G/RwOtA4=; b=cxo4EFjXrOpjd6NOsdsxEmjzcx
	A7XtcDPkTIZTP4wAvWHu2cEm8875JLtVIh/tLwFANyBIGDHPpH1im3SGF5L5tAwj3puzWeyne3moA
	3cuMNJHxYFZ17RhOn/5gI2uJWH4kdzoxd6u5J4q6Hn2r15VcSOEGpbgU3XPmVDWtlnaw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBw1J-008Bft-Lw; Wed, 30 Sep 2026 17:14:57 +0200
Date: Wed, 30 Sep 2026 17:14:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 2/8] dt-bindings: net: Add SoC-e SWIP MDIO
 controller
Message-ID: <6416b34a-83ce-4aca-8adf-c8894ca7b3c3@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
 <e5aa5cd8-e805-47d3-a105-07bf1b9eb9b8@lunn.ch>
 <218d4c1cf5f05cd6cc648c01f8a20ec66b95362c.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218d4c1cf5f05cd6cc648c01f8a20ec66b95362c.camel@linutronix.de>

On Wed, Sep 30, 2026 at 04:00:56PM +0200, Vasilij Strassheim wrote:
> On Sat, 2026-09-26 at 00:55 +0200, Andrew Lunn wrote:
> > > The controller exposes separate register regions for transaction data
> > > and for the shared transaction control and external bus selector
> > > register.
> > 
> > > +examples:
> > > +  - |
> > > +    mdio@204 {
> > > +        compatible = "soce,swip-mdio-23-02";
> > > +        reg = <0x204 0xc>, <0x200 0x4>;
> > 
> > At least in the example, they are not separate?
> 
> Not separate regions but registers...
> I'm obviously bad at documenting things.
> 
> The current information in the commit message is misleading and
> irrelevant. Looking at the bot's feedback, it's at the same time not
> clear enough yet that the mdio controller part is mapped within the
> switch memory and can't be used separately from it.
> 
> I will update the commit message to something like this:
> Add a binding for the MDIO controller integrated into SoC-e SWIP
> Ethernet switch IP cores.
> The controller shares the memory of the synthesized switch IP core and
> cannot be used independently.

I think part of the issue is the compatible. That suggests it is a
separate device, with its own driver. But it is actually driven by the
switch driver.

       Andrew
