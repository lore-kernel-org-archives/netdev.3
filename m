Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB75A5132;
	Tue,  8 Sep 2026 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894643; cv=none; b=PxQFXPJ4rFTFG6mPbc1CdBa53ls81LVN5NZ8+CpJpJv9mDULtYGyhJ7C6s8vSE5bvNBhSjOGBVYeTX9SqAwBs24kM/cwy00peWm8kBeqA/1kDmdhhT7sj3n0odgOV2D4HfQSl/M02kMmgKwf9VQU834QT3G030kVKbzPVuvaAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894643; c=relaxed/simple;
	bh=UB+elDH9fL9e7rU2w0OYCl7Zw8p4Ewx0PKVNLlTwTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGRj+JpQDXjLLsb3nMKDmmylU/5fPR98tbC0C1saZU+n90zwMc0NEOUxdPRa+nLWAe9F3AYruWYN/B0ggxrKKRKWOSVapnJ+cwQsXHe+uzJhS04zRGpSNWzFoDOKG/p9RxyqgLQZJCGrD1yqd3sVi2aegGglCrKtTlD6GK2ytSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=baP90ovS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="baP90ovS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MKMYqfrBrMYn/5yN5icicfB7HmLakHz70UZ6nQbvNdw=; b=baP90ovSn7yOGV68CQ06bT8wE1
	k0BGocz5+SarcWptS3sR04aBuqrSN74A9bXsORuET3nbqB1sVHekniMG9n0B6bcOq1QHk2xI+qPbH
	1m3tiFro2xqEJwLmMaUpBp0kD8INOOvi//B1SJIGCCy7J57jVh6cUZNSe7c0Kv6ge1Wo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x41DC-003yBG-It; Tue, 08 Sep 2026 21:10:30 +0200
Date: Tue, 8 Sep 2026 21:10:30 +0200
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
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <df6dc527-8b4a-4775-828a-2633369277cd@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
 <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
 <041e2884bc1aa1725a86efd413e2e3301b54d91d.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041e2884bc1aa1725a86efd413e2e3301b54d91d.camel@linutronix.de>

On Tue, Sep 08, 2026 at 08:15:35PM +0200, Vasilij Strassheim wrote:
> On Mon, 2026-09-07 at 21:04 +0200, Andrew Lunn wrote:
> > > +    patternProperties:
> > > +      '^mdio@[0-9a-f]+$':
> > > +        $ref: /schemas/net/mdio.yaml#
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          reg:
> > > +            maximum: 30
> > > +            description:
> > > +              MDIO controller output index, which must be lower than the
> > > +              number of implemented switch ports.
> > 
> > Is there a relationship between an MDIO bus and a port?
> 
> Yes, there is a one-to-one relationship for this IP. The MDIO bus
> selector corresponds to the switch port index.
> 
> > 
> > I'm just wondering if the MDIO bus should be a property of the
> > port. There are switch which have an MDIO bus per port.
> > 
> 
> I see this model in the new NETC switch binding. I will move the
> optional mdio node below the corresponding ethernet-port@N and derive
> the selector from the port's reg.

Since this is an FPGA, i assume there are no internal PHYs. Mixed mode
is not something FPGAs do. There are sometime "interesting"
relationships between port number and address on the MDIO bus. But
without internal PHYs you don't need to worry about this.

> > > +patternProperties:
> > > +  '^(ethernet-)?ports$':
> > > +    patternProperties:
> > > +      '^(ethernet-)?port@[0-9a-f]+$':
> > > +        $ref: dsa-port.yaml#
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          reg:
> > > +            maximum: 30
> > > +            description:
> > > +              Switch port index. Supported switch configurations have
> > > +              up to 31 ports, numbered from 0 through 30.
> > 
> > 30 seems odd. Is 31 something special? 
> > 
> 
> The hardware stores the port count directly in a 5-bit field, so 31 is
> the maximum representable count. Therefore, valid zero-based port
> indices range from 0 to 30. The switch documentation is unclear about
> the encoding, but I tested a three-port configuration and the field
> contained 3.

So in theory, a 0 port switch is possible!

   Andrew
