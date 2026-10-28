Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190558;
	b=V9Ijy1qMkTozQfbUmTsV0Rm/+3j9YHd+NBNQEjoqcdLY/6PEYTRV5aD0dF1/oMXGNghH
	 OQ0Tj2iV6ZpouKg7o+8U16BlM/Wgf9p6k/pyCfMs7x5Art+CPWQpIsEffhioS633Voibp
	 asjKfTg2e7o3i+1glBptc/PFzST72et1lAUKq80KzIn+RCWizJwIZH/R7/UdQjVhM5IMB
	 c3kebRNkdGrERvSPg/LOzl/bX8zWVgMCRErmrnPpa0O78l9iWUVnEGrXCql/PZ2EKjmdf
	 fqmdSRoKaBPPFs0aavQlxkrHvtN7EDQ1YIpASQhUUrv7gEQv8HJwb/62/ug+Kh53VSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190558;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=sum+6SOo6fPr4wojZMJ/HsdG/QxP8iiWGofKkRuMS1M=;
	b=M6S0nHD5SxmWh5ipx/Q2ksDTGKqxoGJ3auH06HA5lTy3eFECPcKisT8IdUslqbtMT/Gz
	 zhK+z3uUETbYKHjuKNOed5kTUafl0PG5Vw0JYjz0r08MwIq/NT3kTmu+DE1ff/D7WtwQp
	 BIZZCPiC67LIj/o87QRKgKLajivlwExrfYrDNFx9DEtySIEryIkfj75SUuj2sR8ApQtYU
	 uaWZBNf8OPYrqG0fv9/aBGCcJOg8LKYvC7epPv8Q2/sn0DjBF4AW1jHgonWcDeI/y1gJj
	 ofXQ6tvxDod5dVvRtpHjEuslqFHybdsLTQYeV+gLScxTwRz92BB/dB7j1EDb0cosQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=OIeTSxkE;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B91606A31A;
	Wed, 28 Oct 2026 12:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=OIeTSxkE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sum+6SOo6fPr4wojZMJ/HsdG/QxP8iiWGofKkRuMS1M=; b=OIeTSxkEVEyNnKkle53WGtuvkZ
	4QPsQXrPuG3ysSTXNKb1A9KeiGyBKadA1zp93MsEorhYJ12wPx7/9ZK7/WAHrYWRF+gV/pYRWsCC5
	YGvVChI+oL7M5/9vB/XnbuhBGquvyooySQ/6nwz/2UKrj9OU6DG9a/TRn2xVJ3KAVzl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xM2lx-00D6fN-W5; Wed, 28 Oct 2026 13:28:53 +0100
Date: Wed, 28 Oct 2026 13:28:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 2/7] dt-bindings: net: dsa: mediatek,mt7530: add
 passthrough mode
Message-ID: <a566aad7-754c-4960-b018-4471a0068344@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-3-cjd@cjdns.fr>
 <a031f089-0b96-4fc0-b878-6af13414524f@lunn.ch>
 <521b930f-0bf9-4373-bfbf-3e2570661ec9@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521b930f-0bf9-4373-bfbf-3e2570661ec9@cjdns.fr>

On Wed, Oct 28, 2026 at 12:27:18PM +0100, Caleb James DeLisle wrote:
> 
> On 28/10/2026 03:04, Andrew Lunn wrote:
> > On Wed, Oct 28, 2026 at 01:13:12AM +0000, Caleb James DeLisle wrote:
> > > MT7530 switches can be configured to blindly pass packets between their
> > > CPU/upstream port and a downstream DSA port, in particular, without
> > > altering the MediaTek DSA Tag on the packets. This mode is used in some
> > > integrations where an SoC integrated switch exists, but a more capable
> > > MCM switch is added to effectively replace it.
> > > 
> > > Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> > > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > > index 90b3582b7619..e29fb8693498 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > > @@ -73,6 +73,13 @@ description: |
> > >         Check out example 7.
> > > +  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
> > > +  mode. In this mode, traffic is unconditionally passed between the CPU port
> > > +  and the DSA port which links to a second switch. To use passthrough mode, the
> > > +  upstream switch is configured with a DSA link to the downstream switch. In
> > > +  passthrough mode the upstream switch is restricted, with no other ports or
> > > +  switch configuration allowed.
> > > +
> > >   properties:
> > >     compatible:
> > >       oneOf:
> > Looking at just what is here, all i see is a comment. There is no new
> > property? Yet the subject is "add passthrough mode"?
> 
> 
> Indeed, I used "add" to mean "add documentation of". Per my reply on patch
> 3, I think we really prefer to avoid special properties and let this
> constitute (very) limited support for a switch hierarchy.
> 
> If there's another verb you think makes a better commit line, I'd be happy
> to adjust.

[Goes and looks at mediatek,mt7530.yaml]

So pass through is not an existing property. You are also not adding a
new property 'passthrough'.

What you appear to be saying is that the MT7530 and MT7531 are hard
coded by the driver into pass through mode? So it is in effect a
property of the compatible? So maybe put this comment next to the
compatible? And make the subject/commit message talk about the
compatible being hard coded for pass through?

Looking forward, what happens when somebody wants to use the switch as
a switch? Or you figure out how to do proper D in DSA? It becomes
messy because you need to add a property indicating the compatible
should actually be a switch?

So maybe you really do need a property?

But DT describes hardware, and pass through is configuration. So maybe
it should not be in DT at all, Maybe the driver needs to look at the
DT tree, figure out a port is used as a DSA port, and put the switch
into pass through all on its own? Once D in DSA is supported, the
addition ports become available, but no other changes are needed in
the DT blob?

Sorry, going around in circles, but hopefully it helps you think about
the big picture.

	   Andrew
