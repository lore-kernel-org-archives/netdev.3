Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2911F0E25;
	Wed,  1 Jul 2026 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889087; cv=none; b=PUqrTCxq7yrhVUW995GyHGyXHrrCfN807gNutORrGGYO7gfYfKOaKMSHRaIGiqyfR+83uZesbhWeuro9oJEalIENORzUMTLGLVTYPkpKcGWkGqEVFFGuqA1RYfbksQJJgDm/4Nx/wpF3m/EIZ4LjREmaIV8d+W72JKKbOI+LfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889087; c=relaxed/simple;
	bh=bLdoS07tbGVp0trP/myZ9hyqCySu9UwIvaC5xa43064=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cBqf/hPqhc/0F8u39PmRrts9ITewjM1mE5MosjVJVLMF5mUGwmAd9BMhUE06lBo9LHUsFBUk9TYj5rjLDVl5rbEPj5oFMnmbUM0+yJBxLodYG7Kh7LHx+6vXWnNbqBG9NwNXdyFthSYQXECncbFOe7jpQdNErcco1YMogWgwfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ECc5Rtjw; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ECc5Rtjw"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C86CA38D4;
	Wed,  1 Jul 2026 08:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782889074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f4MXihyQe/D1JcyYwuGidDbu2z428fVDqLCoOVo9Fkw=;
	b=ECc5RtjwiMclFiVSL5OJt3SfN3jQ5hY0grzQXHMb8+2W52nX0/KIqpKgYcaZ9BYS3KUrBt
	CZX1pP+APWFeftxw2bxJCbpmfGtKqsyv22truxGJdSjOyAfHatVZxuh/m/92ciB7yy+BHv
	B7E+bpIu0SRA9VEsURfrDH2BzIpEZUxCAIzbVTxRhM3JSfQ771VAZxIm7W3KPD1yyslH/4
	DsuLdmcnmuyg+Fto0d9s0u9XcNgrvFGPPGRcdYtWXMb5nHiR93Y6pzngimQzbiYV1+N/Lr
	+KkxF4NX6mkqGr27/vH9szEHVEzn5atiSJtIo8YNfJfjaXMQkz8Tx/DZ3hV09g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Jul 2026 08:57:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: enrico.pozzobon@dissecto.com
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Woojung.Huh@microchip.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: disable VLAN filter in promiscuous
 mode
In-Reply-To: <20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f@dissecto.com>
References: <20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f@dissecto.com>
Message-ID: <c5cd452bae7891e386458e93c0d2df45@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Enrico

On 30.6.2026 16:15, Enrico Pozzobon via B4 Relay wrote:
> From: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> 
> The hardware VLAN filter (RFE_CTL_VLAN_FILTER_) drops VLAN-tagged 
> frames
> whose VID has not been registered via lan78xx_vlan_rx_add_vid(). It is
> left enabled in promiscuous mode, so packet capture (e.g. tcpdump or
> Wireshark) does not see tagged frames for unregistered VIDs.
> 
> Clear the filter while the interface is promiscuous and restore it from
> NETIF_F_HW_VLAN_CTAG_FILTER otherwise. Enforce the same condition in
> lan78xx_set_features() so netdev_update_features() cannot re-enable the
> filter while promiscuous.
> 
> Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 
> Ethernet device driver")
> Signed-off-by: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> ---
> Currently, on microchip lan7801, enabling promiscuous mode does not
> result in VLAN tagged packets being captured. This patch fixes this,
> forcing the RFE_CTL_VLAN_FILTER_ flag to be off when promiscuous mode 
> is
> enabled.
> ---
>  drivers/net/usb/lan78xx.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index c4cebacabcb5..a1a53ef85cb9 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1525,7 +1525,14 @@ static void lan78xx_set_multicast(struct 
> net_device *netdev)
>  	if (dev->net->flags & IFF_PROMISC) {
>  		netif_dbg(dev, drv, dev->net, "promiscuous mode enabled");
>  		pdata->rfe_ctl |= RFE_CTL_MCAST_EN_ | RFE_CTL_UCAST_EN_;
> +		/* bypass VLAN filter so all tagged frames are captured */
> +		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
>  	} else {
> +		if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +			pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
> +		else
> +			pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
> +
>  		if (dev->net->flags & IFF_ALLMULTI) {
>  			netif_dbg(dev, drv, dev->net,
>  				  "receive all multicast enabled");
> @@ -3074,7 +3081,9 @@ static int lan78xx_set_features(struct net_device 
> *netdev,
>  	else
>  		pdata->rfe_ctl &= ~RFE_CTL_VLAN_STRIP_;
> 
> -	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +	/* keep VLAN filter off while promiscuous */
> +	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +	    !(netdev->flags & IFF_PROMISC))
>  		pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
>  	else
>  		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;

nit: Could this be addressed as helper for both callers?

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
