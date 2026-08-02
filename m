Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2183C2D;
	Sun,  2 Aug 2026 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707099; cv=none; b=SYI7A4pjtLRnsoYRDUZ5Ht3cxvB7Ef3K/LientvUXpDNgfSJktl0F4ETp4vBRkDsYRPbIOXZX+yT5EXxNkOQd9HAKOHNhdeuKzQltHil57QrRMmfkCXuypXT3Y8Ewa2wL/BIasewTLowJkEXWUXym8uZkFCjvpqxcBXuP6f7dBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707099; c=relaxed/simple;
	bh=xbs3B0tReUMlOE7jYcpyUz7h5xbCG/PmS0h7lhmZpms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI1KNqqnOSAwjdLNguXh6KLkoM71DpW/ezx+2V0s4ztFUQJYejhHTRnezGktWpWkaeEo2XiaWNtbY7BDTRdgcmcm0QKiRxqdXN1B24pk8lKwXZ0JKzBXC4ONCDq7PoXPTJr0KiTTE9Yeie4Z14J25EMmdw2LKPH0xL2vjL0tXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tdfFhQJC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tdfFhQJC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=01Bs5WoZ4BZK5nysYzUQ6E3qGgvuOftWioQblDzGGJg=; b=tdfFhQJCRUheqk59sVTSWf7EmQ
	0+R0pQfMHUQZp5iu3r5ilLQoSqEKDNXYHEztp8Zgd3pUKnWeTFL/ZyofMalwxrgpllpI1ZOt6L+qu
	NibPy4N6fAOQIu+54waHitbUlMLpgKGbcP050cuv34Wq7GA6kdjVDep2pH3LvbRs35VI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqdzE-00FcMP-Sm; Sun, 02 Aug 2026 23:44:48 +0200
Date: Sun, 2 Aug 2026 23:44:48 +0200
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
Subject: Re: [PATCH net-next v5 09/13] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
Message-ID: <1cf1c0c8-d7a7-4ff8-9a9d-02dcc993ac14@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-9-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-9-dcb9fea4acd4@birger-koblitz.de>

> +	/* Enable WoL */
> +	if (priv->wolopts) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
> +		if (priv->wolopts & WAKE_PHY)
> +			tmp8 |= AX_MONITOR_MODE_RWLC;

Have you tested WoL?

WoL is somewhat complex because it can be done in the PHY or the
MAC. If it can be done in the PHY, you can power off the MAC. If the
MAC needs to do it, it needs to stay awake.

But what i don't get is how the MAC is implementing WAKE_PHY?

    Andrew
