Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F43AE191;
	Sun,  2 Aug 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684362; cv=none; b=d8Ns5mK85TqGu1LhjEBrlHnbsGlgZyP5/+9djQVEpRqm1mGuYXOTKz/f4yVJa3du71X8+Q+DBcwemGmbNZ/bphwFsBiWhWtB3g1CJcyICYeBvx710E9NNoOX2JhMjufEVMqzWm84Qa3bILJr6B6y+a0y2BCo4w59dv/YCLwOk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684362; c=relaxed/simple;
	bh=Vxf5thWk00daPDcZKYKOSwRNZi+A9b94cc0kIZBtOB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIWgXGoqznPhOhUrKNzuThmGYAzklLPLkv5bO/QOjavJW18+j8o5o3odlmrAHxpZ2y4/ZoiP/v/ptr4RvHmK/rOeEZ0T8RWa4dBpttUkM4m2nb4uW1YkK6vBpUKj4/FH6IVIFRl55oWNRU55dqbSPiMk7MSYLy7sRWUTeyRrmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PUK/ifSI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PUK/ifSI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p7qQMF3v+xLAQh+yg1MRpiH5BmtndEv3J+ce1D6fBkA=; b=PUK/ifSIxGu3nZnng7/y3kKWcR
	g5AiRywqQkEm68pvGCNHM4OmPDIqT7OOZZ9Y2D22P40JZn1gR4M6EDHIkONa3s5lyQL6OKLTR1gfP
	jy19tUmmdLnjHRr92kXTEiQw4E8Nd9xozhygyea4KW84QHjXjp1bEPT9Hd2GzweRVqu4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqY4W-00FaVZ-S5; Sun, 02 Aug 2026 17:25:52 +0200
Date: Sun, 2 Aug 2026 17:25:52 +0200
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
Subject: Re: [PATCH net-next v4 06/12] ax88179_178a: Add VLAN offload support
 for AX88179A
Message-ID: <3e4c8938-3969-46ff-9d95-e8c4a45591ba@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-6-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-6-2cf1f71b1dd2@birger-koblitz.de>

On Fri, Jul 31, 2026 at 06:19:06PM +0200, Birger Koblitz wrote:
> The AX88179A-based chips support VLAN offload. Add configuration
> support in netdev_ops. Features supported are:
> NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
> and NETIF_F_HW_VLAN_CTAG_FILTER.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/ax88179_lib.c      |   2 +
>  drivers/net/usb/ax88179a_devices.c | 100 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index 7b5c17a01df2deac2cc0210bc88193be1abfbe23..26c874b31beafac796264e46ecc942b4bd460ac0 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -348,6 +348,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
>  {
>  	u8 tmp;
>  	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data = dev->driver_priv;
>  	netdev_features_t changed = net->features ^ features;

So reverse christmas tree is normal for netdev. This is right way up
christmas tree, and the existing code is broken, so O.K.

> +static int ax88179a_set_features(struct net_device *net, netdev_features_t features)
> +{
> +	u8 tmp;
> +	int ret;
> +	struct usbnet *dev = netdev_priv(net);
> +	netdev_features_t changed = net->features ^ features;

This however is new code, so should be correct.

	Andrew
