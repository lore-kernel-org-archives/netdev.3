Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B344606D;
	Thu, 27 Aug 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837625; cv=none; b=uDpwGGfYYf/omMmXc429T+x4w8qEoskyPtyTjP9Rs2CNUdLDPvOl3II+lZWvOFalwESjhpERxNvTIUvKRAhE1B/PsEtN86pEBf2a+BYqQjNYy1eEie5aEV9X8cq1Brqw4paqhAR7GRochaOfxg/ryzPbHWeMzAZmjhi5O8VGznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837625; c=relaxed/simple;
	bh=aikjkH4eA9w6grwtrnwsLSLiV0hqYSJ5yEX6K35R6h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwzEguP4ufmdKAOY966DpKHI0CHtEGIQMB/hccF2WujM6z0qSM503qFFsbSHcLp5tP1fs6WKjuvwk25VkChRHC88MzKG67H/j8tZxweCtw1TcW8IzwHcq7ZGbFhrvktmlCBwUzOOQ09rFJ5Slu7o9yHd1qLGvfGY6/oEuQwvpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ratatoskr.pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:c3a7:c242:e5e7:34c7])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 41D9B201B99;
	Thu, 27 Aug 2026 15:33:32 +0200 (CEST)
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Andrew Davis
 <afd@ti.com>,  Heiner Kallweit <hkallweit1@gmail.com>,  Russell King
 <linux@armlinux.org.uk>,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dp83867: add binding for
 output-impedance
In-Reply-To: <d944329d-9ad5-4acf-a7d3-b2f8eaf1e92c@lunn.ch> (Andrew Lunn's
	message of "Thu, 27 Aug 2026 14:47:30 +0200")
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
	<20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>
	<20260826-salutary-skype-524c69932dc2@spud>
	<87ik4wgfbc.fsf@pengutronix.de>
	<d944329d-9ad5-4acf-a7d3-b2f8eaf1e92c@lunn.ch>
User-Agent: mu4e 1.14.3; emacs 30.2
Date: Thu, 27 Aug 2026 15:33:31 +0200
Message-ID: <87a4q74ris.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed

On 2026-08-27 at 14:47 +02, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Aug 27, 2026 at 10:04:07AM +0200, Steffen Trumtrar wrote:
> > On 2026-08-26 at 17:01 +01, Conor Dooley <conor@kernel.org> wrote:
> > 
> > > On Wed, Aug 26, 2026 at 02:48:40PM +0200, Steffen Trumtrar wrote:
> > > > Currently, the output-impedance can only be set to default, minimum or
> > > > maximum or via a nvmem cell.
> > > > In cases where there is no backend for a nvmem cell, a value can not be
> > > > set.
> > > > > Add a DT binding, 'ti,output-impedance-ohms', for specifying the
> > > > output-impedance via a fixed value. The existing boolean values for
> > > > minimum and maximum still take precedence over the new value.
> > > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > > > diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > > index 7a6fe516bab27..49fafe3ce6f47 100644
> > > > --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > > @@ -38,6 +38,16 @@ properties:
> > > >      items:
> > > >        - const: io_impedance_ctrl
> > > >  > +  ti,output-impedance-ohms:
> > > > +    description: |
> > > > +      MAC Interface Impedance control to set the programmable output impedance.
> > > > +      Valid range is 0x00 to 0x1f (32 steps).
> > > > +      - 0x1f = 35 ohms (minimum impedance)
> > > > +      - 0x00 = 70 ohms (maximum impedance)
> > > > +      - Step size varies with process.
> > > > +    minimum: 0
> > > > +    maximum: 31
> > > 
> > > Your property is named in ohms, but not implemented in ohms.
> > 
> > So without the -ohms?
> 
> No. DT uses real unit, Ohms, Meters, Volts, Degrees Centigrade, Seconds
> etc.
> 
> Have the driver do the conversion from Ohms to the magical register
> value.

Fair enough and I agree, but the datasheet says:

Output impedance approximate range from 35-70 Ohm in 32 steps. Lowest being 11111 and highest being 00000. Range and step size will vary with process.

I mean, the difference will be miniscule, but the binding can't specify the exact ohm value, because it is not guaranteed to be correct. There are more values than steps and even the range is only an approximate range.

So, just allow values between 35 and 70 in the binding and then convert that value to something near the truth in the driver?


Best regards,
Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
