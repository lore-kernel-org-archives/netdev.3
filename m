Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B131B838;
	Fri, 31 Jul 2026 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527135; cv=none; b=OvAZjQCwrDOg6pFyEfWeNI5jNKAddFMyOXY+IP3j60clvs0Xf6rZC+cpAlIvoXGcE9BlmNS9UY9MR3149AUyG7lgf4dLpbAij/Z2Zlwv1VQ4Gjz1yNpJ0fo1Q9tWpIfAVxMClM3C9G38J3dj5IbYkFVJrUvJR+vapPL5cmLow9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527135; c=relaxed/simple;
	bh=Ku167mc6VS1WUQLuy2sxRxFCDRFW18JVqGaIrBkDW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clW6HPajhhMC77Hu9PX2uwRJEcmYTJY+t6rf9GK0qqy1bbHYcefHSDiCxqsr8Iwc5Xrp9w8ObBNfYvH+6KIYeWIGhii0y4BpPLMjaPbte3/Turd1Zz2APfeA765nyVkA5V/9O14V7wiekPGvsVsXq1b8OcZu2ydDqfvseZHQszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a9oTq4Pf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a9oTq4Pf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5W+Q/QfhW5ecUtJwIw7eIBmhipW7wtpVeEl9gfAgd9A=; b=a9oTq4Pfw/bJysKKAthYK3LtHc
	zozF8JWaFvSnOmlBKhdPxJy1jURG8d+6I2RGAeBvhmIbdavzORohVOdftdpVYe+yNQrUUVDOF2/c8
	KQiXPE/1WeG5gVa2JzWIM0W6L9we1XC0kFnAOteBoH+g0E8eo4TJVdDrwVRN+hlCOZ08=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wptAb-00FHmk-MU; Fri, 31 Jul 2026 21:45:25 +0200
Date: Fri, 31 Jul 2026 21:45:25 +0200
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
Subject: Re: [PATCH net-next v4 10/12] ax88179_178a: update driver information
Message-ID: <158887d9-50ee-40b3-a801-4ac98428c723@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-10-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-10-2cf1f71b1dd2@birger-koblitz.de>

> -config USB_NET_AX88179_178A
> -	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
> +config USB_NET_AX88179
> +	tristate "ASIX AX88179/179A/178A USB 3.0/2.0 to Gigabit Ethernet"
>  	depends on USB_USBNET
> +	select PHYLINK

It is possible 0-day might complain about the earlier patches, the
build failing because PHYLINK is not selected. You might need this
change in an earlier patch?

> +	select AX88796B_PHY
>  	select CRC32
>  	select PHYLIB

I don't remember the logic, but it could be PHYLINK selects PHYLIB, so
you can remove it here.

	Andrew
