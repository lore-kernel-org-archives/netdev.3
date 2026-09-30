Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FF5208A0;
	Wed, 30 Sep 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792698; cv=none; b=ha4tPoeee831fd/CeX2Me6RVWKSEMkSAdIzXch9UWVY/5vEqPYbAzElnzA8YtRPlFSF8k/KGilskRQG36suGc/DvRa4k2PZuL7b810v6p0XMmX+IvirFQZPYWaCMIYK9pHZbUPIDJ0DrG7mAhJo+y9uhVeYJVq5omVckXNhF5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792698; c=relaxed/simple;
	bh=L+K7U1WcqiLuAOv2gCbCl3KGVoS7TydT/8PwqLz6jYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jicD8gJniuTR3qrNFlPAvH9OdRiEHWEdIMU+2N71MdnbxoqUyTLaoxjW822AeU1nCcyjIj/LGOf+hiTWPXRdz+N4r+hS6R0W1OdXgZ2CucTVcOPYSiQMjJr0UOQtuNqyDvVx0oVh0GwnmcfamWSHMNLQpa3TG7mrzwvFJFe51Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mhoNW5pd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mhoNW5pd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G65/tzmmVFTNS2SMwQITuBPf4fxmCQT1XOQruGIjvac=; b=mhoNW5pdKESi3LKFrp1odLugpu
	QUACsfPbbgoOrVdkgygpuEi8JVX0ZpXj0DIBLBcr71T2zM0w60zqAa1OGMSOGp0dauqmzALTBERJk
	ri+YcBRyJ0EEF3XwiDtJhYeczmXcu7xRjUVTUOq4BUA7JeEE3KJZV/awCcIzsrsa0N90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xByz2-008DL2-El; Wed, 30 Sep 2026 20:24:48 +0200
Date: Wed, 30 Sep 2026 20:24:48 +0200
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
Message-ID: <6a635aa0-3489-4d2b-b302-06b793326654@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
 <e5aa5cd8-e805-47d3-a105-07bf1b9eb9b8@lunn.ch>
 <218d4c1cf5f05cd6cc648c01f8a20ec66b95362c.camel@linutronix.de>
 <6416b34a-83ce-4aca-8adf-c8894ca7b3c3@lunn.ch>
 <ad24be6928e33b544f9c8c72ea05f64c2968035f.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad24be6928e33b544f9c8c72ea05f64c2968035f.camel@linutronix.de>

On Wed, Sep 30, 2026 at 07:13:35PM +0200, Vasilij Strassheim wrote:
> On Wed, 2026-09-30 at 17:14 +0200, Andrew Lunn wrote:
> > On Wed, Sep 30, 2026 at 04:00:56PM +0200, Vasilij Strassheim wrote:
> > > On Sat, 2026-09-26 at 00:55 +0200, Andrew Lunn wrote:
> > > > > The controller exposes separate register regions for transaction data
> > > > > and for the shared transaction control and external bus selector
> > > > > register.
> > > > 
> > > > > +examples:
> > > > > +  - |
> > > > > +    mdio@204 {
> > > > > +        compatible = "soce,swip-mdio-23-02";
> > > > > +        reg = <0x204 0xc>, <0x200 0x4>;
> > > > 
> > > > At least in the example, they are not separate?
> > > 
> > > Not separate regions but registers...
> > > I'm obviously bad at documenting things.
> > > 
> > > The current information in the commit message is misleading and
> > > irrelevant. Looking at the bot's feedback, it's at the same time not
> > > clear enough yet that the mdio controller part is mapped within the
> > > switch memory and can't be used separately from it.
> > > 
> > > I will update the commit message to something like this:
> > > Add a binding for the MDIO controller integrated into SoC-e SWIP
> > > Ethernet switch IP cores.
> > > The controller shares the memory of the synthesized switch IP core and
> > > cannot be used independently.
> > 
> > I think part of the issue is the compatible. That suggests it is a
> > separate device, with its own driver. But it is actually driven by the
> > switch driver.
> 
> I can't avoid the compatible right now. Somehow it is still a separate
> functionality. I hope the following example doesn't cause unnecessary
> confusion, but rather helps to understand the system better:
> 
> The relationship between the MDIO controller and the switch core is more
> like that of tools in a Swiss Army knife.
> There are a few standalone tools, such as the knife and the screwdriver.
> These can also be described on their own. But they only make sense when
> they are attached to the knife as a whole. As soon as one takes it
> apart, the individual tools can no longer be used effectively. At the
> same time, no one needs to worry about the screwdriver if they only need
> the knife.

Maybe consider an MFD.

You then do get independent devices.

Also, with the current structure, i'm not sure how the mdio-mux is
getting instantiated. You list it inside the switch node, so i don't
think i will get turned into a platform device and probed. An MFD
might helper, maybe.

There are other switches which are described as MFD, so it is not
unknown.

      Andrew
