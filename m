Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959896;
	b=W5LEkKjmbiZ6qzpl1VFCr9viAevnz3vJk4dmmjEGwcuAMfgTgjEFn9eY0Epg1qspWYk9
	 YLxBMGQ9KxqnotuWhNoTnehU1eE7uEZgVBkBCGHqHV1T+dPPMuKlGHhV/y8AfREEG2hMz
	 I1WPS2hkAnDFzUtAJENcXCIiQubBVLuyjkllH8DN3zY6UQZtiB7q88Y9IUBl3exWQrPk1
	 PInNACbFuacPtaBQgcy9oAbKla5+BxBlyS44XudYFuKIGXvm5FufapocNh8CpE9qMK297
	 hJU1JvNtwP5LYAsO0p+6k71jXD9nvW5+OH5ISvdw1r3GwwK/td3HYp11HuWNT2E/RgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959896;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=6ogeEWksxpSUWmxEpBUUGjIXdCyDlrjJdIfYEM0KO6U=;
	b=ye7CHwOcaDic7L82+SvvYM5U4Wu9zl5xcrOyboxVRP//DJ2D1o78FXgqD5bj92kHMm7Y
	 rJ2xbxKmXNBTNWavyYUl1LF/yqL33VHqwzOxHrFAoEEOqcjODkCd0tH92jwDqCB5W3QEJ
	 fvuoXVOzRpBBsIgO2uR9RJsgTbmrqRlv4Ry94L+IYvMb1yCxrZ8mUmIixBmVoUVlnDyCJ
	 F/o/q9RjACdhEBJE/eHcHFNBrMuNJtlVOsVEpdQOm+ts6irLu+OAmxaPDRToxXaLi4VON
	 tDr8nW8qcJRHq0kkUYDV4IYELARBb98tVpBV4RHygW7jceRGMxVV3X+wjcvWj9bet+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=I5CrbdBu;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11841606A33B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11841606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=I5CrbdBu
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 58A394E41401;
	Fri,  6 Nov 2026 10:11:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 259005FFBC;
	Fri,  6 Nov 2026 10:11:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31F8B103291F9;
	Fri,  6 Nov 2026 11:11:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793959891; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6ogeEWksxpSUWmxEpBUUGjIXdCyDlrjJdIfYEM0KO6U=;
	b=I5CrbdBuFxZWEIZBIc49EI2RZqfWkGbm2L+NrRyTZJ1N7ucRBbZshseI6mtnf2iQ3+ecuf
	TZG5FPUEC8BVovD0Lf4OeEwwfYCnCw5cabRSLhaM/tpvKlEXiVUqyphsti7+20dCBbX7eR
	3QfM1qOkrHcwXrRl7p/4ajr228FR1M8E4ae6lcwSWl6JoJyv+x90JYK+ArGk9c2k1OvUd1
	M5vAWbaCSezXJFI6izU+WQDs5QUa8CnH0sYx+gcaQHkSYdKStZ9qWmZtJsof/RYe5gRp6L
	+mwvNx385Qq0wRzYny1U2cmcT6XKsQ5q2WxsH7uFmqOSYqfLA5CN/lBtmnjinQ==
Message-ID: <69be2cfe-e296-4f90-ad19-0bd48a83e287@bootlin.com>
Date: Fri, 6 Nov 2026 11:11:22 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 01/13] phylink: Add phylink_mac_interrupt
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Jianhui Xu <neuromoments@gmail.com>,
 Emir Beganovic <beganovic.emir@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
 <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/6/26 08:21, Birger Koblitz wrote:
> Add the phylink_mac_interrupt() function to phylink, which
> passes a link-change interrupt received by the MAC to phylib.
> This function can be used by drivers which want to avoid
> polling the PHY and instead rely on an interrupt received by
> the MAC when a link-change happens.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

> ---
>  drivers/net/phy/phylink.c | 20 ++++++++++++++++++++
>  include/linux/phylink.h   |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index e885da1c28311a12a869e29ceb3c96886f31adc6..a87eaa2f3db5bef8fe56e12b90375bdb7f9c52e7 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1616,6 +1616,26 @@ static bool phylink_link_is_up(struct phylink *pl)
>  	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
>  }
>  
> +/**
> + * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + *
> + * Passes a link-change interrupt received by the MAC to phylib.
> + * This function may be called in interrupt context, and therefore cannot take
> + * a mutex. However, it is safe to assume that the reference to phy does not
> + * disappear during the call, as only an SFP module may be unplugged to make a
> + * PHY disappear. SFP modules however do not support interrupts.

I don't see the relevance of PHY SFP supporting interrupts or not here,
this just re-triggers the PHY state machine. Looks like a comment to
make sashiko happy.

Anyways, I'm OK with the approach, maybe reword that comment if you need
to respin,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> + */
> +void phylink_mac_interrupt(struct phylink *pl)
> +{
> +	struct phy_device *phy;
> +
> +	phy = pl->phydev;
> +	if (phy)
> +		phy_mac_interrupt(phy);
> +}
> +EXPORT_SYMBOL_GPL(phylink_mac_interrupt);
> +
>  static void phylink_resolve(struct work_struct *w)
>  {
>  	struct phylink *pl = container_of(w, struct phylink, resolve);
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 3a88a69882a610afb868b55df6f6e77aea918649..a7b6294cc4a075bd2aaa43ed6484de17a6cb88b1 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -768,6 +768,7 @@ int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
>  int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
>  int phylink_speed_down(struct phylink *pl, bool sync);
>  int phylink_speed_up(struct phylink *pl);
> +void phylink_mac_interrupt(struct phylink *pl);
>  
>  #define phylink_zero(bm) \
>  	bitmap_zero(bm, __ETHTOOL_LINK_MODE_MASK_NBITS)
> 

