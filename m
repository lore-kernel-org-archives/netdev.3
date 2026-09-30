Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A9522F1F;
	Wed, 30 Sep 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793704; cv=none; b=LJcruH1qL2KyvSnj1Bww0CUFs5yMvu0txewcMio6a+hvhYW3R1b3SZvmvzYxY9mWWOpvk8LoGSBAyhmtM3d5KlGpbU6KQGtyzg3+ijfsz9uu4PEly6HtcHs9XIkwwvbTmk7Q3S9YS3jTMRyVOJwdE/XwqKIUYkcvptjX/gXfJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793704; c=relaxed/simple;
	bh=vmjP8Tex0+H/WcKzIpQcGZmnMzy0W0KVgazviDdv/cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEianbP758I/QGgXt//WVSGHzgrokqKO3nJqrNvpM4aMt+bflZ871Qx87v1NStk/yx7Lg+rhTcUeTg49VwRXtBzaXSY8T7P1AteyMxp5EKSFqJG0XBPQFStxJrmWX8NS3IMaXFApkWYH39m8Y3D6/l+teGQjJj00S0S3D8cmos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Swy1bb+M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Swy1bb+M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ICF5bNdCJvAqLns4h4Ears0x7zH7gmbf4YhNlZN3Ps=; b=Swy1bb+M60cKDjkkPe/VIqiM01
	d0FkwWWVDDrsT/x3Bnlm7991gzU6UrAzMLzh2KQX6cIkXdmw7We38OuL7JdYUomfukZUFVOU3sder
	5xpwsuWFo6zLlQDjEN6ZvhvUV22VH0gaPaEXb+IGbhJwCSnKcl9noUotLV5vmtckBp8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBzFG-008DXx-HH; Wed, 30 Sep 2026 20:41:34 +0200
Date: Wed, 30 Sep 2026 20:41:34 +0200
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
Subject: Re: [PATCH net-next v3 8/8] net: dsa: soce: Disable unsupported
 hardware STP
Message-ID: <e4396a39-05fd-4474-837c-9c6182fea52e@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-8-ddebafcb9ba7@linutronix.de>
 <ea1f498f-fce6-4e9b-8afb-10d16ac12f08@lunn.ch>
 <d94de82e27e28b18320f31e2690cb85673832411.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d94de82e27e28b18320f31e2690cb85673832411.camel@linutronix.de>

On Wed, Sep 30, 2026 at 08:29:37PM +0200, Vasilij Strassheim wrote:
> On Sat, 2026-09-26 at 01:24 +0200, Andrew Lunn wrote:
> > On Wed, Sep 23, 2026 at 12:39:35PM +0200, Vasilij Strassheim wrote:
> > > The driver does not implement hardware STP offloading yet.
> > 
> > What exactly do you mean by STP offload? Can it do the actual
> > protocol? No DSA switch can do that, we always use the software
> > implementation. I'm not even sure it is possible to offload the actual
> > protocol.
> 
> That's not a complete offload. The documentation says:
> "The Spanning Tree protocols is supported as a mixed hardware and
> software solution. In the hardware section, IP core is in charge of
> forwarding BPDU frames to/from the CPU port and managing frames
> according to the STP port states."
> And:
> "Spanning Tree (STP/RSTP/MSTP) algorithm runs in a software application
> in the CPU. The CPU is in charge of configuring the switch port states
> based on the processed BPDU frames."

This sounds about normal, nothing special. The switch has to be
involved, since it needs to pass BPDU frames when the port is in
blocked state, etc.

> There are a few registers for this. However, it's enough to just turn
> off the feature and use only the software implementation in Linux.

It is going to be more interesting when you get to offloading. If the
switch is not synthesised with this feature, you cannot offload
hardware bridging, it needs to stay in software.

	Andrew
