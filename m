Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD53B961E;
	Fri, 12 Jun 2026 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267007; cv=none; b=aNdvpXHUJVS+bGOME2NUTNYDZxTBZa/XNlZdib4B7c71hbIof++339Tt0l9yPv0CzjFwKXjClob9bulen9ClViPvgbkT2inOQ172Bnidou+qUz+jqo1gsrBh8WWQvVFNPsyMOqMQw5Z30/lr+UDU17FRRa8hc3CLKZGZTfHfCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267007; c=relaxed/simple;
	bh=IbToR+lgAdquklu+/Eg3oXONevqkJpD4GGPeq1xag3o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sx7yK1UsoMdpyLyCxbv+M84r4/GnusBJkQPTVgk2D3kCmJxOC43gQmqgKINSCgNtCoV0rrmw9CojllqH0VUJNEgdy2KAZhBmyN4ypDYzwuya1HrZNiQ02k3t+lIbSjgGy1ZUFKf6nKS1mQ0GEl0xVTN9vUKxbNwRDynJHTjYTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=4whu0Hbt; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="4whu0Hbt"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB711A1D1C;
	Fri, 12 Jun 2026 14:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781266999; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7q2XrxfHI2F4jC37A/2Ev7F1/EsKe9OT+qstuGZnrow=;
	b=4whu0HbtqP7CAZkbptcPO+iuHD6llV2oz5jiUJPMJGp3yLDVWB3SFMfvRWkesTLCuuzMNG
	/CVciNVYLYBlcA4IsEJHwo3TAYqZyC2jwc8NWQjn/TrJZLrj460vpyaodY7yyKJjXGWb1Y
	wx18lJkaNft7PAJM/X8hAlBc/mq5KG0YSSAzuKfYYCShUIDzeO/izD/ZX5dtnHkQU6mELm
	LijkAr2M+J9og+CAZRhFC0tf9Gt2fMyvlUbqIISqpnQIJawQLfORnKXKT+sYPAQfJpQkLL
	cxJkoyxrz0/9fabgm3gpCDtix3jhMNF08SRYGr71e+aVt5DCvEMAFRK95/Kc5Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 14:23:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: netdev@vger.kernel.org, Theo Lebrun <theo.lebrun@bootlin.com>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, Lukasz Raczylo <lukasz@raczylo.com>,
 Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover from
 lost TSTART write
In-Reply-To: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
Message-ID: <dbc25b24865a1ad92555bc826bef4267@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrea

On 12.6.2026 11:01, Andrea della Porta wrote:
> From: Lukasz Raczylo <lukasz@raczylo.com>
> 
> The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
> the TX queue.
> While the exact root cause is not yet fully understood, it is likely
> related to a hardware issue where a TSTART write to the NCR register
> is missed, preventing the transmission from being kicked off.
> 
> Implement a timeout callback to handle TX queue stalls, triggering the
> existing restart mechanism to recover.
> 
> Link: 
> https://lore.kernel.org/all/20260514215459.36109-1-lukasz@raczylo.com/
> Fixes: dc110d1b23564 ("net: cadence: macb: Add support for Raspberry Pi 
> RP1 ethernet controller")
> Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> Co-developed-by: Steffen Jaeckel <sjaeckel@suse.de>
> Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
> Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index a12aa21244e83..615da65d5d68d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4522,6 +4522,16 @@ static int macb_setup_tc(struct net_device *dev, 
> enum tc_setup_type type,
>  	}
>  }
> 
> +static void macb_tx_timeout(struct net_device *dev, unsigned int q)
> +{
> +	struct macb *bp = netdev_priv(dev);
> +
> +	if (net_ratelimit())

Do we need the net_ratelimit() check (and message) here? AFAIU the 
watchdog core already prints a message for every timeout.

> +		netdev_err(dev, "TX stall detected, re-kicking TSTART\n");
> +	dev->stats.tx_errors++;
> +	macb_tx_restart(&bp->queues[q]);
> +}
> +
>  static const struct net_device_ops macb_netdev_ops = {
>  	.ndo_open		= macb_open,
>  	.ndo_stop		= macb_close,
> @@ -4540,6 +4550,7 @@ static const struct net_device_ops 
> macb_netdev_ops = {
>  	.ndo_hwtstamp_set	= macb_hwtstamp_set,
>  	.ndo_hwtstamp_get	= macb_hwtstamp_get,
>  	.ndo_setup_tc		= macb_setup_tc,
> +	.ndo_tx_timeout		= macb_tx_timeout,

The commit message describes it as RP1 specific, but it gets applied to 
all other variants?

>  };
> 
>  /* Configure peripheral capabilities according to device tree

Thanks
Nicolai
