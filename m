Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF23E7BC6;
	Mon, 14 Sep 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404850; cv=none; b=E+iJEyEjfDdnVV+zyET673T/s99YoWptsla9Eqk9WsL6QQwdKjvGQ4vVhebXTPtPd/4QuVYAjyLkjZTuVYgNuCZ3d9VFufLXSGqP1yUM+VQ26obi+3UIoWscz+qF65LODK7JWcdMXzd+gMZyb2OfCkfGDQMclD/nHg6BT3hLcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404850; c=relaxed/simple;
	bh=ut5HCh/KD5+YXQ4y1JCalbQ4vsSeHz9aZjPvGryhHK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcgxOFMitbb97kc2oyYlo2RuAm8lOaQIoTxwLAIP8iJ42SFHokLwMc64IDvv1RL0Nf+wIoJFApe+8h+P6a4OpbScxcIakOAYYOQmPJprnwMryU5kO5I+vRG7xOiXR/nEdirHm8HwefFunqy9S2uuSrAB5RByvDJfO9Ap3qAz/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oMZHL/CY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oMZHL/CY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c8qx/n3bAQtpTa5yG5DIesMaxep0tMIz6CFEJ1CkwWg=; b=oMZHL/CY0iFEwS9FsU2TaRn3df
	yWPbvYbuo+hT5jitUImF89l1A3yM47+A16SYjIe3eXjUOyiXW7t5Eqf5iauzmBySkIEdV4IEdYs2j
	f8jIXrDYpoeuD6Zp4v7YScvGXLEiTxaCRiiZV+NK67nwPkDe+RCrFQ3FHlzk3C+Eq2mk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x69wL-0057Dd-4j; Mon, 14 Sep 2026 18:53:57 +0200
Date: Mon, 14 Sep 2026 18:53:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Birger Koblitz <mail@birger-koblitz.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <3103b046-fa19-4b59-af4a-f326783eda4f@lunn.ch>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
 <18c931ca985a82a044c9269743fb4fb7@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c931ca985a82a044c9269743fb4fb7@tipi-net.de>

> > +static const struct net_device_ops ax88179a_netdev_ops = {
> > +	.ndo_open		= usbnet_open,
> > +	.ndo_stop		= usbnet_stop,
> > +	.ndo_start_xmit		= usbnet_start_xmit,
> > +	.ndo_tx_timeout		= usbnet_tx_timeout,
> > +	.ndo_get_stats64	= dev_get_tstats64,
> > +	.ndo_change_mtu		= ax88179_change_mtu,
> > +	.ndo_set_mac_address	= ax88179_set_mac_addr,
> > +	.ndo_validate_addr	= eth_validate_addr,
> > +	.ndo_eth_ioctl		= usbnet_mii_ioctl,
> 
> dev->mii.mdio_read is never initialized for ax88179a, so
> dev->mii.mdio_read()
> through usbnet_mii_ioctl() is a NULL function pointer.
> 
> Something like:
> 
>   static int ax88179a_mii_ioctl(...)
>   {
>   	struct ax88179_data *data = netdev2data(net);
>   	return phylink_mii_ioctl(data->phylink, ifr, cmd);
>   }

Is this transitory? Does a later patch fix this up?
The aim is to remove all dev->mii accesses.

	Andrew
