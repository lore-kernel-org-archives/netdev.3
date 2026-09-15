Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0C4A92ED;
	Tue, 15 Sep 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474068; cv=none; b=OkjfjdKdgy8WxvzgtFixcp4fgFao3qZhrIliLCd/pHzDT/tnEbyk0QOkVDhBH5gNBY691c6gH8AvPtZkJ0UMik4mf+Afoq528j+XggLAff4xwuYHjWnzW+BuI+tNuwJFHWqmlFz0pQ57Id07nM8tGEAiD930z1l8DMBk1vG0ZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474068; c=relaxed/simple;
	bh=s9oVkLo1daobsfJLd6n1LFEMGX6OlrsS48VKJHc2j/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBr7Ucqy9SXYCVn5k3xQncLosdBxs8ZL2rtNkI414z/8ogo1qPRa/rq/OJ2KCLRj7vPxahGuf4iOeSJw4IONN70DQzzlOPRcY20wunxpZisDBhTL2yL/autCrDQy2JdkGw5nGyo8A5WTxSCEbgUwsDAjKk6eWd3ZiM1YGEBCRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W7ZgmFEY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W7ZgmFEY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fqU/sd7/18zTuJcmee2d1KzmmMsh8LLR6os9ylhXGdI=; b=W7ZgmFEYJqjbMPt6jSgi/0XjWA
	Jw1PUrvFexjsckF8oij31n5Fo3lqwFX+tcLl2eWNYqAx2m1/0grW6AdyvaQAyohcFJUocsy6768sX
	fOjIKWcAQMKMkL+1qe1aB7HaVa2ORpPEQ9cf+uQkQKIxEnHsGFTvVro0K+REH7QQ8SZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6RwZ-005Gei-8N; Tue, 15 Sep 2026 14:07:23 +0200
Date: Tue, 15 Sep 2026 14:07:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <8a9ddbff-01e6-4a0d-98a3-ddc06ec30055@lunn.ch>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
 <18c931ca985a82a044c9269743fb4fb7@tipi-net.de>
 <3103b046-fa19-4b59-af4a-f326783eda4f@lunn.ch>
 <9a4ad1ba-0d98-4a5d-b18d-742f82337641@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4ad1ba-0d98-4a5d-b18d-742f82337641@birger-koblitz.de>

On Tue, Sep 15, 2026 at 02:01:48AM +0200, Birger Koblitz wrote:
> On 9/14/26 18:53, Andrew Lunn wrote:
> > > > +static const struct net_device_ops ax88179a_netdev_ops = {
> > > > +	.ndo_open		= usbnet_open,
> > > > +	.ndo_stop		= usbnet_stop,
> > > > +	.ndo_start_xmit		= usbnet_start_xmit,
> > > > +	.ndo_tx_timeout		= usbnet_tx_timeout,
> > > > +	.ndo_get_stats64	= dev_get_tstats64,
> > > > +	.ndo_change_mtu		= ax88179_change_mtu,
> > > > +	.ndo_set_mac_address	= ax88179_set_mac_addr,
> > > > +	.ndo_validate_addr	= eth_validate_addr,
> > > > +	.ndo_eth_ioctl		= usbnet_mii_ioctl,
> > > 
> > > dev->mii.mdio_read is never initialized for ax88179a, so
> > > dev->mii.mdio_read()
> > > through usbnet_mii_ioctl() is a NULL function pointer.
> > > 
> > > Something like:
> > > 
> > >    static int ax88179a_mii_ioctl(...)
> > >    {
> > >    	struct ax88179_data *data = netdev2data(net);
> > >    	return phylink_mii_ioctl(data->phylink, ifr, cmd);
> > >    }
> > 
> > Is this transitory? Does a later patch fix this up?
> > The aim is to remove all dev->mii accesses.
> > 
> 
> No, unfortunately, this is an mii-leftover. I thought that
> usbnet was emulating the mii ioctl somehow, not that it was expecting
> to be able to use a mii_mdio_read. I will remove the
> >>> +	.ndo_eth_ioctl		= usbnet_mii_ioctl,
> line, entirely.

It would be nice to use what is proposed, so the ioctl keeps working.

You can test it with mii-tool.

    Andrew
