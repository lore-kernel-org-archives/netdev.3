Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026B2BE7DC;
	Tue, 16 Jun 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617064; cv=none; b=HomasPm93u9W21y3/oK+h4PAoZgU6y2dsYjnUaeLokd3pAc/hgpnFT4xtfz13aHUoEr2i9N5xmXEjzLUXoiv/rqYsd5N59EETp2cH1r940CR46UkP+09caTO8g6v1j0SmkVADZoS4Wk6TrwRy1C8ywLhGOe0LS0qXDbkd0ZRQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617064; c=relaxed/simple;
	bh=TrtCcEuIui9hc0pJE63RFg99uG9mJUW6f+MR1oXzjCE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DLfUV4zOPNeLWDP9hxXZ0d7zEktolVcZL9VwY5srfen8HRTJp4ZCiOxzPTVkEskDHSA5ejR0rSAf7dxZ+rYcc+vO7zAIyHYVRiT+GokVSf+wVpLQFmcXnFHMPqL0Zwd5W+E8zdlWuRQs18oMZ0+RfWX/Mnstavn94mLtqutWKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=eQT4332t; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="eQT4332t"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89462A1D1C;
	Tue, 16 Jun 2026 15:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781617049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ISjZXEgmv27RFkS8r2XqxozAUDEv0fYySMy3KWEs29w=;
	b=eQT4332tf/zYqpBlwY8OJ6Qk1xp4dS9v4JFmUT+4jlqT0TO2NBKmVmuieT3pScmXjjzjSr
	7y6l2no0BtxnfT/Etm0kw8LZcVeg3NoVQ7BamOKzG3ozpCkY6eYC7XwJlWCS2LS/WgLY4g
	2zt46906UC95xM5/6oOZxmqWM/FTZ8BQDTOpNJCSb4fEdevueYL+n4H6Rep9vSzqgVYshs
	JwLUgH3B7fehHMw3CHMChDHN4ysfKhfpvpJIX2RUIwXdqSVWTntj4medkEOjRhmsJPzLmK
	6NZAT/uO1hgkLmHfNItVFeZgnFxuqLQ8penUMKY56F3UebaBp6BGLDPTpBsVzg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 15:37:25 +0200
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
Subject: Re: [PATCH v2] net: macb: add TX stall timeout callback to recover
 from lost TSTART write
In-Reply-To: <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
References: <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
Message-ID: <37227460d97a7bcf2257f72bc8b827bb@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 16.6.2026 15:23, Andrea della Porta wrote:
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
> 
> CHANGES IN v2:
> 
> - dropped the rate-limited log message
> - avoid incrementing tx_error as this is per packet
> 
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index a12aa21244e83..fd282a1700fb9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4522,6 +4522,13 @@ static int macb_setup_tc(struct net_device *dev, 
> enum tc_setup_type type,
>  	}
>  }
> 
> +static void macb_tx_timeout(struct net_device *dev, unsigned int q)
> +{
> +	struct macb *bp = netdev_priv(dev);
> +
> +	macb_tx_restart(&bp->queues[q]);
> +}
> +
>  static const struct net_device_ops macb_netdev_ops = {
>  	.ndo_open		= macb_open,
>  	.ndo_stop		= macb_close,
> @@ -4540,6 +4547,7 @@ static const struct net_device_ops 
> macb_netdev_ops = {
>  	.ndo_hwtstamp_set	= macb_hwtstamp_set,
>  	.ndo_hwtstamp_get	= macb_hwtstamp_get,
>  	.ndo_setup_tc		= macb_setup_tc,
> +	.ndo_tx_timeout		= macb_tx_timeout,
>  };
> 
>  /* Configure peripheral capabilities according to device tree

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
