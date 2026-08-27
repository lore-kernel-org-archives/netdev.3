Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77176448D03;
	Thu, 27 Aug 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834884; cv=none; b=XQjMU7ZzoT4USUns/3UwUi8RboiBsZ7jaPaMDEB0jZY7x9qOl4AhMaay7a+gzaDTEJqjSk7Sbkzw+t/pX7B1q77EiP1SsbsSCC7Dil+ZQpqVxG5aKKfQtrOPgHz1uE5mvYO1ee+/xTLanV8CUM3MVeTSVLqIm6c34oTmIO/8Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834884; c=relaxed/simple;
	bh=v1JaVfxuyGv/K74VJD51tsMnf1tz0lr+uJWFqv3nvvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR/lWPb9ELUfH61+ScARpKa9RX6RN6Md03XjOtojRvARmzyt5wNQ4vZJxeHinkgT8ZcvfBnGNSzrjuyvfep1ydoydtG7qJPEZcEpFQ2AZauDZgX2tOSV6ImIk8/uUFcQ+d9hOHJ92qEyw4D+W5ERC4SbFJgrJPlYKPjJkeIMrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JA111HCB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JA111HCB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9GvVHe0werWHOnB5OKAezI41CKNF471yfbWq1NBqM6I=; b=JA111HCBUnv1a1obfctaO5gAQG
	5zsPQXXv8AndgRDdRiSQgyzO1z3QZJL6rvZVgu2I5kFTsMM3r1azON03fbAv37lovBdcbLtUdzSka
	1i7qY5qj2LuSAVHe0etcDlBIvj2I0DW8ZsUJBcdpwwFkoxknUyUYeBzqxp4ql9B0Vvwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzZVy-001fK9-19; Thu, 27 Aug 2026 14:47:30 +0200
Date: Thu, 27 Aug 2026 14:47:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dp83867: add binding for
 output-impedance
Message-ID: <d944329d-9ad5-4acf-a7d3-b2f8eaf1e92c@lunn.ch>
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
 <20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>
 <20260826-salutary-skype-524c69932dc2@spud>
 <87ik4wgfbc.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik4wgfbc.fsf@pengutronix.de>

On Thu, Aug 27, 2026 at 10:04:07AM +0200, Steffen Trumtrar wrote:
> On 2026-08-26 at 17:01 +01, Conor Dooley <conor@kernel.org> wrote:
> 
> > On Wed, Aug 26, 2026 at 02:48:40PM +0200, Steffen Trumtrar wrote:
> > > Currently, the output-impedance can only be set to default, minimum or
> > > maximum or via a nvmem cell.
> > > In cases where there is no backend for a nvmem cell, a value can not be
> > > set.
> > > > Add a DT binding, 'ti,output-impedance-ohms', for specifying the
> > > output-impedance via a fixed value. The existing boolean values for
> > > minimum and maximum still take precedence over the new value.
> > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > > diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > index 7a6fe516bab27..49fafe3ce6f47 100644
> > > --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > @@ -38,6 +38,16 @@ properties:
> > >      items:
> > >        - const: io_impedance_ctrl
> > >  > +  ti,output-impedance-ohms:
> > > +    description: |
> > > +      MAC Interface Impedance control to set the programmable output impedance.
> > > +      Valid range is 0x00 to 0x1f (32 steps).
> > > +      - 0x1f = 35 ohms (minimum impedance)
> > > +      - 0x00 = 70 ohms (maximum impedance)
> > > +      - Step size varies with process.
> > > +    minimum: 0
> > > +    maximum: 31
> > 
> > Your property is named in ohms, but not implemented in ohms.
> 
> So without the -ohms?

No. DT uses real unit, Ohms, Meters, Volts, Degrees Centigrade, Seconds
etc.

Have the driver do the conversion from Ohms to the magical register
value.

	Andrew
