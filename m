Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045137F8AA;
	Fri,  7 Aug 2026 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129991; cv=none; b=I8+mf/27qDSo8PzTwhxxRidFYylgBi8sY8lzNfJ4p1D4d/lSHbkhvxqW6PlgK/+s4l1Uxf/HrU+c0qxh5VONd4SPfzUtPungJAuZyB5hPssBQm24VRKkbQLRZVQJqlmuJ2NKBGpOXOQb77kpyGD8NsR7VnR1e7bpFhSMi2zTyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129991; c=relaxed/simple;
	bh=yQbcUd6JtTzeVkyQ3RniHclFITim8iZ+bkV9OKoCHUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5D+PnZ2KaEu/4BHCkpQ99Dh3szRJdV/ghCFyb1T7tih2BIdxqOcwjJihEEV2nuJy6ywie8z1jmHijaqjyKWosNskbGQoFpUt5TUJ6+L7vokS/SWVCm6+UZJcM+h27BxgmKTktSSwlDJoGdOgaTIbGGviCUwwgmEUvrCc0t8hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QtDyr2l4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QtDyr2l4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V6uTTcQlK3qB/9kXDLzsw1fvgBeNj5RhwcMHVsYbj2w=; b=QtDyr2l4YKxTjkZynaAE8iWRLR
	3DXW7WO7AMa6cq81puGnb6YHXPrEVSO1XmadlBnbn8d1x6zGJA45OaYS2OEUSWzfS2sXwgYrZAHQR
	dan/DNpsRZZjVc5w6MiR09zWFZjgv/qyzaUsgfKqFhw8cdlY7OuKEkuLdklrkr2SnAMQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsQ01-00GdE9-AH; Fri, 07 Aug 2026 21:12:57 +0200
Date: Fri, 7 Aug 2026 21:12:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v5 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <7b28d6aa-da49-426f-a117-f9464fdc4d9c@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
 <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
 <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>
 <f2a99d04-6d61-4cc2-814d-cfe1ef9b1395@lunn.ch>
 <7a91e550-ac70-4423-9aed-9f4406e71fe8@birger-koblitz.de>
 <527d31e5-1731-4925-bf7f-a567f3fb3774@lunn.ch>
 <6c165b0d-5e24-4b01-8057-1bef9fac851b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c165b0d-5e24-4b01-8057-1bef9fac851b@birger-koblitz.de>

> I also would like to add another feature to phylink separately. All the USB
> Ethernet controllers have a feature where the controller sends a USB Interrupt
> URB to the host when the link state changes. It would be great if instead
> of polling, this could be used to trigger a read_status() of the PHY instead
> of polling it constantly over USB. This would work like the equivalent of the
> PHY link state change interrupts. Basically, the host driver would, upon
> receiving a link change interrupt URB trigger a similar code path in phylink
> as a link change interrupt by a PHY triggers. Ideally, this could be something
> that usbnet would help drivers to set up. Would that make sense?

There are already a few different implementations of this.

phylib has phy_mac_interrupt(). You might just want to put a phylink
wrapper around this. You would still have the polling, but calling
this would trigger an immediate poll, speeding things up a bit. You
might be able to disable the polling with PHY_MAC_INTERRUPT.

These is also phylink_mac_change(). But as the name suggests, that is
about the MAC seeing a change in state, not that it knows the PHY
changed state. I don't think it triggers phylib.

Another option is to implement a Linux interrupt
controller. mv88e6xxx_g1_irq_setup_common() is one example which i
wrote. The Marvell Ethernet Switch chips have embedded interrupt
controllers, including PHY interrupts.  The switch chip has one output
pin often connected to a GPIO which can trigger an interrupt. When
that GPIO interrupt fires, it calls mv88e6xxx_g1_irq_thread_fn() to
dispatch the interrupt. That then uses handle_nested_irq() to pass on
the interrupt to anything which has called request_irq() with the
appropriate values. Now phylib has that, phy_request_interrupt(). For
that to work, you need phydev->irq set. That comes from
mii_bus->irq[]. So when creating your MDIO bus, you first create the
interrupt controller, and then set bus->irq[],
mv88e6xxx_g2_irq_mdio_setup(). phylib should then glue it all
together.

	Andrew

