Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DC3F328F;
	Fri, 24 Jul 2026 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912531; cv=none; b=lq7FViI/nT2c2zhp+rmOEfveiOgv3SGCyLAq6cRg2MDLmASsjQbr3D5e3222FS0ldejtjiFRQcr9Chfrj9EbHdPg7E744A7hhtPXKyUgFZj3ABkPOlpEO9O8lu5jq5tyipvI/D9MpV8uz5n7dmnhMcW0niPVT6ta+M+cEr4NSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912531; c=relaxed/simple;
	bh=Av5o1z3S7Om5Rcjzxpjb/Z4njDbe4SlSxek5qvfKU4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6RUiEYHgjhbY+/t08usRex9xcl4eWhPDxJXFOKuLkCrAx+RpgRycS3UXbizzw946vdX6e0R7fHpqmKdXQeGdDQbouPFmNwudJH7b8NSYFTj41Il33lVVKqtA30D9CZ6sJI1n2LbMcOOKS8XZDQ4KBRxT4mSqB2YaOzxw9Fy6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bDUpTM+1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bDUpTM+1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aO1mXl3mf/wMOEdjf/dwtDS9upxpl7kKAe4lyTEBksI=; b=bD
	UpTM+1HN2lAfiL734yqb1pPssiambUPrX99rBjNq4ZUZY8QjfY4bW3xIkk62nlUY/D48tXSLOaH3a
	v26Y4yS68pZrLUIBIvRXe5brYlcXmjTR7X9aBrQRJsPbqoEzufgOdiUqFrSE7lOc1i34my7fdHhbt
	aDEPWlYcFKsSKMg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnJHa-00E1on-Ts; Fri, 24 Jul 2026 19:01:58 +0200
Date: Fri, 24 Jul 2026 19:01:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 07/13] ax88179_178a: Obtain speed and duplex
 from Interrupt URB
Message-ID: <434f6f0b-40ce-4f2c-95ac-1fe24ce38366@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-7-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724-ax88179a-v3-7-bdde4f905883@birger-koblitz.de>

> @@ -506,6 +507,9 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
>  	le32_to_cpus((void *)&event->intdata1);
>  
>  	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
> +	data->speed = (((__force u32)event->intdata1) >> 8) & 0x7;
> +	data->full_duplex = (((__force u32)event->intdata1) >> 12) & 0x1;
> +	data->link = link;
>  
>  	if (netif_carrier_ok(dev->net) != link) {
>  		usbnet_link_change(dev, link, 1);

usbnet_link_change() calls netif_carrier_off(). With phylink, phylink
is in charge of the carrier.

I would also be careful with speed. What is it actually returning?

Think about when you turn autoneg off:

ethtool    -s    devname   [speed N]   [lanes N]   [du‐
            plex half|full]            [port tp|aui|bnc|mii]
            [mdix auto|on|off]    [autoneg on|off]

If i do ethtool -s eth42 speed 100 autoneg off

The PHY does not have valid speed information in its advertise
registers. The LP values are probably also wrong. phylib will set the
speed the PHY is doing in its forced mode. Is the firmware clever
enough to understand this and return the correct thing?

The phylink link up callback will however tell you the truth. I would
trust it over firmware.

     Andrew
