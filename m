Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683A31F9BD;
	Wed,  9 Sep 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980487; cv=none; b=Ug+ykopVYdJJWCf+cVHskChNtfYxL3ge9a5KkNAG7wnW8wLh4J6dAhypATJek9IM/m7Ns95kYyj/aEoUzM9OpLU7FzGGoY3Mf17274ldYPvfzRSc7OBuTChzR6KVTAJ8EV8SCKfH4Exih2s/IDQVuj41+yxvZdSmB6w4QXzPCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980487; c=relaxed/simple;
	bh=wOYpV9+kjOSeRztAds1dW6IO0mPN7/x23ns19noRwvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqMun9bZhGnU7YYEIMKFbO9S25ostFeD/6FOC+sY2ceNa0z08VYJWZW4LZodsZZMDXIXIe0nONcCqQ2UjSIeisUvENfd9a6gB7ihUqE8A+Bu0ATuJE4PUWkpviGNd5ZspWPk1hh2rwdLBSW5TB+fUPnltXHp6K+mhiiWDxtygaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zOsDRFRz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zOsDRFRz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4B+JtYnaN3jovWrVTtixgnxDuklodZXdvo3NMICFkTo=; b=zOsDRFRzoTis9Dak8q3yKb9spD
	Zu936BpafKqNr/usumC1wIe0kkMMbVPxVZ86J0GNMIhqCb8lXZPPsRmyqiQqwL1vwwftxToYdyyyw
	e3mhS/tZHQMxKLRjd39l9GLMSTUfe7+m7q7JJM+OaYKCIrcxYJJDIUSK3FYj7RJ7e05g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4NXm-004MfQ-A1; Wed, 09 Sep 2026 21:01:14 +0200
Date: Wed, 9 Sep 2026 21:01:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ericwouds@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2 0/7] net: mdio: an MDIO device driver for
 the Airoha EN8811H
Message-ID: <44f163ed-8362-4aad-99c9-f8709dfbed76@lunn.ch>
References: <20260908155707.4164559-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908155707.4164559-1-f@lex.la>

On Tue, Sep 08, 2026 at 03:57:00PM +0000, Aleksei Sviridkin wrote:
> The Airoha EN8811H answers its PHY ID from power-on, but it is an MD32
> microcontroller until the host loads firmware into its volatile RAM.
> Today one driver owns both roles: the PHY driver downloads the firmware
> from .probe(), which works only when the files are readable by then and
> leaves the reset line in the hands of a PHY node whose detach wipes what
> was loaded.

I think because you are sending this as RFC, the AI bots are ignoring
it. I also think it is not getting build testing etc.

> What I am asking:
> 
>  1. The binding lets software timing pick the topology: the same chip
>     on the same board is a plain PHY node when its firmware is in the
>     bootloader, and an MCU with a child bus when the firmware arrives
>     with the rootfs. Move the files into an initramfs and the
>     recommended description changes without a wire moving. The hardware
>     argument that does hold is narrower - the reset line belongs to the
>     MD32 core rather than to the PHY the firmware creates, and a PHY
>     node that owns it wipes the firmware on detach - and it argues for
>     the MCU node, not for the child bus. If the child bus has to be
>     justified by hardware too, I do not have that argument, and the
>     honest options are to describe the chip one way always, or to say
>     plainly in the binding that this is a driver model choice. Which
>     would you rather see?

One way to argue it is that the MDIO bus it connected to the MCU. The
MCU, once booted, forwards the MDIO bus through to the PHY part of the
package.

>  3. Removing the parent MDIO controller reaches this driver's remove
>     with the child PHY attached, and nothing pins the parent's owner.
>     Closing it wants a way for a bus to tell its PHYs' consumers to let
>     go, which is a phy-core change. The failed-resume path above wants
>     the same channel for "re-initialise" rather than "let go", so that
>     is two uses for one mechanism. Is it worth doing here?

Consider a normal setup, what happens when you remove the MDIO
controller when the PHY is directly connected?  And look at what MDIO
mux drivers do, which is not so different a use case.

>  4. MDIO_AIROHA_EN8811H sits in the "MDIO controller drivers" menu,
>     though it drives a device on a bus and not a controller. The
>     mdio-mux entries set the precedent, but say if you want it
>     elsewhere.

It is fine. I would also add a select or depends on the PHY driver
Kconfig stanza to link it to the MDIO_AIROHA_EN8811H driver.

>  5. The child bus accepts exactly one address, the one this node
>     occupies on the parent, and I do not think the schema can say so.
>     What it does say now is that a child named ethernet-phy@N is
>     validated as one, and that it must not carry reset-gpios or its
>     timings - the whole reason this node exists is that a PHY-node
>     reset is what phy_detach() asserts, and it erases the firmware.
>     What it cannot say is that a differently named child is refused:
>     mdio.yaml's own patternProperties evaluates any node@hex and its
>     additionalProperties: true admits the rest, so unevaluatedProperties
>     has nothing left to reject. Is prose enough for the address, and is
>     there an idiom I am missing for the rest?

Prose is enough. And C code to catch DT authors who get it wrong. But
you also need to be careful to not break backwards compatibility when
the PHY driver is used alone.

>  6. include/linux/mdio/mdio-airoha-en8811h.h is named for the driver
>     that consumes it, while its four neighbours in that directory name
>     the driver that implements them - here the implementation is
>     drivers/net/phy/air_phy_lib.c. Where should this header live, and
>     should the MAINTAINERS entry that now claims it also claim the
>     library files it declares?

The location is fine. MAINTAINERS need to list it. What you might want
to do is list it twice, once in the PHY driver MAINTAINERS record, and
again in the MDIO driver section. Any changes need to be coordinated
in both, so all Maintainers should get notified.

    Andrew

---
pw-bot: cr
