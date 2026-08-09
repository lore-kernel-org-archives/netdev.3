Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A1222565;
	Sun,  9 Aug 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786308502; cv=none; b=CYBRyaE2Y5oMX0oc2xya/LO9Nzi86kbndLz9fX1KWaJjb1BSkW3jX3N3ZOH/vypaurTqStAnJjwJDdQwMkcKJCQn13ORQAZPz88MWeqYpdnxuFOrp2fKKvyBd1BGVZeFTkaT3GPQ4b3vyMG86oZzz8grk62fPSR4NFdYErh1x+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786308502; c=relaxed/simple;
	bh=HLpJp80FlMCBzlIt368eeBJmHp79hllT5wgbVD5a4Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV9ORJcxADMLcS4vikszXbeaICh2nz9zuEAaOAbKMqFRPu9Ao4tEYJ4dQE6xehV+cv5qv2hHsd2KEhxkyp4GjMh8gnts7q3ooneFlkB2B+A1Tn/2PcN2Ayu7TdJ6+F+ktFZOrrAv4CIEVvJyqqbNae6Rt0WlOOMFRzjzXp8I4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kdr9KCh+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kdr9KCh+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vFRzRsJvdQfoaVpRhHu8kA76hzkMXRgK/C4FrAQRxYc=; b=kd
	r9KCh+LP8EXD0CX+qfDtrIwtWvgVmzWieXw5l5Wa7F/UyNgsoIV/xKrXbkH/QfOStiIMyY3nSskXZ
	5oen0QVslb/WCvTb2zXD7bbBsb/QYeAsYhup3wqkailJNYbNpYaGXYN4VLtKIc+Ww83mJjcuEe9vb
	fec5D+2ifOfNoZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtARJ-00Gqxq-HQ; Sun, 09 Aug 2026 22:48:13 +0200
Date: Sun, 9 Aug 2026 22:48:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: mfd: x-powers: Add AC200
Message-ID: <e8b813e2-eccb-4292-9ecc-15ee656ee6d5@lunn.ch>
References: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
 <20260806-submit-acx00-of-dynamic-v1-v4-1-9bf2f7441632@gmail.com>
 <0cdd9998-51e7-40eb-8c01-54684f6944dc@lunn.ch>
 <CADvTj4oa=G0WYAG1Hw9se3dCXxer24X-L0Oe2X-D14m7FpLOFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4oa=G0WYAG1Hw9se3dCXxer24X-L0Oe2X-D14m7FpLOFg@mail.gmail.com>

On Sun, Aug 09, 2026 at 01:33:22PM -0600, James Hilliard wrote:
> On Sun, Aug 9, 2026 at 9:34 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +description:
> > > +  The AC200 is a mixed-signal companion IC containing audio, video, RTC and
> > > +  Fast Ethernet PHY functions. Its control registers are accessed over I2C.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: x-powers,ac200
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description:
> > > +      AC200 input clock. When using the Ethernet PHY, its configured rate must
> > > +      be 24 or 27 MHz, matching the rates encoded by the documented EPHY clock
> > > +      selector.
> >
> > What is the scope of this clock. Is the PHY the only consumer?
> 
> No. This is the AC200's external CKI system-clock input, not an
> EPHY-local clock.

O.K, good.

> > > +  ephy-vcc-supply:
> > > +    description: 3.3 V supply for the Ethernet PHY analog front end
> >
> > This sounds to be specific to the PHY, so the PHY driver should be the
> > consumer, not the MFD as a whole. That then would allow the PHY to
> > perform power management, turn the regulator off when the link is
> > admin down, so suspended.
> 
> EPHY_VCC is specific to the Ethernet PHY, even when a board connects it
> to the same physical 3.3 V regulator as other AC200 supply pins. The
> regulator core will retain the shared rail while any other consumer
> still has it enabled.
> 
> For v5 I have removed ephy-vcc-supply from the AC200 MFD node and moved
> the supply to the Ethernet PHY package. Both variants now use a common
> vcc-supply property, connected to EPHY_VCC on AC200 and VCC1 on AC300.

Great, thanks

	Andrew
