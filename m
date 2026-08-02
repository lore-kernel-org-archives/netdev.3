Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDB233704;
	Sun,  2 Aug 2026 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706600; cv=none; b=K648wyFpWvQkWoYdTu/dtCYLR/7hXk2WgbXC6lu9onIeBk8M/ao8s/gfFB9dnyyT2Q2uqcZmSnnRQnd1vW5/IMCV+YoXCIctEYrpQnPNkGUcuSXhz4V34FLRJnlnNNnoslY3dfq6XKI9b+8PQSHdWYDzSE6OWjxu3BF3nVGt6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706600; c=relaxed/simple;
	bh=3fRBMqroL5V7K1F5imUOyx83zXfQhZJTwOzSbBKpuJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAp1JMe2FUULRNBmVQjT+nlcFXIrYjs1SIDZgNsrhAgf9aablv4XE6qEGfpMQGmeJAU3OfJ/LMMKLPjBW4y447OpS6Na0l8PYEokMiUP6jIPB40IjMelCrsYSrwkqns5pn31rR0/eKqT5MNv1GsmSZ9C1fvKKp8R++VxxAXfKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r6gih2Bb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r6gih2Bb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iN3WJ5QGCt2MM52FJwnL4/FtCo7Tq0VJoroKiPBmr1c=; b=r6gih2BblYb2N3hfkk7KCFadzi
	KxDvXBJHqHAv9vdjNo/NNivmF96fVab8eb3rY12mfHV3kPcWdcjZ3XUoZnyotMmzUQ10USm020wux
	12hYnksulYtwjvzuuRJovY15BlYCi7P1q+N48e/pzJlJOd+UHN6jf1jWDmnyeHpZ2fvc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqdrD-00FcIX-P4; Sun, 02 Aug 2026 23:36:31 +0200
Date: Sun, 2 Aug 2026 23:36:31 +0200
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
Subject: Re: [PATCH net-next v5 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <d7d319c8-9404-43fa-ab44-755c9e612c19@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>

> +static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	const struct ax_bulkin_settings *bulkin_data;
> +	int index = 0;
> +
> +	switch (ax179_data->speed) {

What is setting ->speed?

> +static void ax88179a_mac_link_up(struct phylink_config *config,
> +				 struct phy_device *phy,
> +				 unsigned int phy_mode, phy_interface_t interface,
> +				 int speed, int duplex,
> +				 bool tx_pause, bool rx_pause)
> +{

It should be coming from there, but i don't see any code setting it.

> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
> +	ax88179a_bulkin_config(dev, link_sts);

It might be better to pass speed as a parameter.

I would probably play with ethtool and set the advertised speeds to
only include slower speeds, like 10Half, and make sure the link works
correctly.

	Andrew
