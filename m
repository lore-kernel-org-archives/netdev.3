Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A63803FD;
	Mon,  3 Aug 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774742; cv=none; b=qZSkzeU40WdsLeGUFDuWcg6taLlzDiuhCmHbvsO0MjLx8SHtmhUO3PSE8xDTqJRik8KcqC2G7LuS2UzCVc7M0RWDgd3n2EWzTELD2GCVYEIDhWwsg4lV9/ijgQrDShTVe2iW4F/IiR1EuKNuIx4l2Y7Q5d4v2XneHs7ocx+hgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774742; c=relaxed/simple;
	bh=fdqF9c67fniYYzIJQDpGs6qADfKmr+6SCWcYUvhD8zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbgdI6gTuTMhksQEp59Uq+4VLYdBD+IhkFxnwYjnsJpCqcOatPkxwfsrvqIM3dQmwGQ2gNeic6UyBf37yrdcH6Zq5OAWI9igGIuzsP6e47scz+kuMlS0LrFiNfzAfrR7GoJCLQZfD8f/D1/r60OHV2YLR32j+AJ/ISxJSvo+RSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3NWzv4tA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3NWzv4tA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uhUCHY2HggE8qh9TbFRiDJVHzcI9WSEZn9xsfpP9N2w=; b=3NWzv4tAhlFRh8IU/rSUXlKKeD
	sBdHynR+Om2uXAVUehD68exDveLxmJcE7jMvYLQBgtIfVmnrKvhCnDRU/nfY8aidevNw1K+SsgIi1
	pwG9scFYdFkkoAXQ45zVV6FtEJiCp/P2dN9zoBPpnL5SxssfT3b/g37l9DXJneQ8iq64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqvaD-00Flrf-KZ; Mon, 03 Aug 2026 18:32:09 +0200
Date: Mon, 3 Aug 2026 18:32:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 0/4] net: dsa: Add SoC-e DSA driver
Message-ID: <a79b951c-9635-412e-8103-0e40fe49bc48@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <50e4f195-f810-470b-b05a-97f622e6efc4@lunn.ch>
 <8a5ec5c7d76d634293bd8c78a078d536ed516c08.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5ec5c7d76d634293bd8c78a078d536ed516c08.camel@linutronix.de>

On Mon, Aug 03, 2026 at 05:22:35PM +0200, Vasilij Strassheim wrote:
> On Wed, 2026-07-29 at 18:56 +0200, Andrew Lunn wrote:
> > On Wed, Jul 29, 2026 at 06:36:53PM +0200, Vasilij Strassheim wrote:
> > > Add initial support for the DSA driver for SoC-e FPGA-based (IP core)
> > > Ethernet switches.
> > 
> > Let me start with a dumb question. Is this a true soft core switch,
> > which is synthesised and running in the FPGA? Or is it hardware at the
> > edge of the FPGA SoC?
> 
> I should have made that clearer right away. This is a true soft-core
> switch that is synthesized and runs in AMD FPGAs.

Only AMD FPGAs? Or you have only used it with AMD FPGS?

> I have a version in which both the MAC and the switch are synthesized
> in FPGA, and two hardware PHYs are connected to the switch. The switch
> provides an MDIO bus for the PHYs.
> 
> > 
> > If it is synthesised, do we have to deal with different synthesis
> > options? Are there registers which indicate what these options are?
> 
> While setting up the switch, users will need to explore various
> synthesis options. Once it's up and running, it should be possible to
> load a preconfigured bitstream into the FPGA without having to deal with
> these options in the DSA driver. The device Tree should then match the
> configuration.

This is where we often run into issues. The driver sometimes makes
assumptions about how the device has been synthesised. Somebody
synthesise it differently, it breaks, and the driver has to be changed
without breaking backwards compatibility.

If the hardware actually enumerates itself, tells us how it has been
configured for synthesis, and the driver looks at these registers, you
tend to have less assumptions and so less issues later.

This is also one area what DT is not so great. You are not actually
describing hardware. Clearly, it is not software, but it is malleable,
jellyware. The less you put in DT, the more you get from the jellywere
itself, the better.

	Andrew
