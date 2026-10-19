Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15633DDDD2;
	Mon, 19 Oct 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414355; cv=none; b=PIbOpbTpmolv4qdbaVUYMjzOdyU3o3XMekJr21qT+ER48FICMTq3lvCVkgtq31GgQrPVMHRdx6aJ/DQBZERggxyD4ivYa5fOjrRSrE3UYNX7mWWPfOuzyTwoB2ZT47OUWM1E3JJkchDxxTz13nzVXC3C0HIKDlKjtJhgPznoTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414355; c=relaxed/simple;
	bh=w2VeGlZBbxG5ZCWetKbFg1zbEFOtnl5wOp6izwN0bcE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Jff9jMaQ8L0VC0hcLmdL3VU/E4sbeaoWOs8FgCew6ZK6lbIkwtjBevofD0ROO/GVpzY3AozFkwlSg0alK2/EgY3fgHp5/wWjh8O8lIStl5FxleIBIXbGBBM2pP1tyIcVTO8/0aK9pkiZBw8L5W1bBk5wNjoMY8UfkQb1/w4ocIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ujuL6CZX; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ujuL6CZX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4296A156C;
	Mon, 19 Oct 2026 14:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792414350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sTQ3s+VlvanVN3XiSVNNqOr6UbCLcC2uXpq+HoxI8yc=;
	b=ujuL6CZXalo6dl7tL/6ltG4pKz8ikd8pFuS2aTt5Un/30uziovbwzuhPVV5gBA9zmEx+Y4
	S79/WcnjeZ32BqiOkIgl2EdHBMIzwHHyLzmhpF6+5tDZxmojkHi78f1PuGnFdSXPq55HSq
	V+KTKQaomc4+BDpUMeo2Fbr2UjcnMozEkKeLZykw6VcPJrpFK5vEI4qWDhLqBK4o1fIXEp
	oaX8QCKqF/1z4HUwxSIJ3Ju9ZTcO+rMVSVtbTGivtE1Y/hvnVN93r+tQI8/CHgo17Rcl+E
	GKWSakVoVVQsb8DxzWEIvcN16uT/t7+leyeB34XbkSf7JiwpuzxjUZWzfWAeFw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 14:52:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Valerio <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 2/3] net: macb: implement
 ethtool_ops.get|set_channels()
In-Reply-To: <20261016-macb-set-channels-v5-2-90ce0c0b8e75@bootlin.com>
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
 <20261016-macb-set-channels-v5-2-90ce0c0b8e75@bootlin.com>
Message-ID: <45fae7a00024b7d07cd3250d4f2b5b48@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 16.10.2026 18:58, Théo Lebrun wrote:
> bp->num_queues is the total number of queues and is constant from 
> probe.
> Introduce bp->max_num_queues which takes the current role of
> bp->num_queues and allow `0 < bp->num_queues <= bp->max_num_queues`.
> MACB/GEM does not know about Rx/Tx specific queues; it only has
> combined queues.
> 
> set_channels is reserved to devices with MACB_CAPS_QUEUE_DISABLE.
> The tieoff workaround would not work as packets would still be routed
> into queues with a tieoff descriptor.
> 
> Implement .set_channels() operation by refusing if netif_running(). We
> need context-swapping support upstream for proper on-the-fly channel
> count change.
> 
> Note we refuse the operation if any TAPRIO rules are in place on queues
> that would get disabled. If we allow the operation to take place, then
> a transmission window would be reserved but unusable.
> 
> Nit: fix an alignment issue inside gem_ethtool_ops which does not
> deserve its own patch.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

> [...]

> +static int macb_set_channels(struct net_device *netdev,
> +			     struct ethtool_channels *ch)
> +{
> +	struct macb *bp = netdev_priv(netdev);
> +	unsigned int count = ch->combined_count;
> +	int ret;
> +
> +	/* MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE/BIT0 in
> +	 * the per-queue RBQP/TBQP registers disable Tx/Rx queues. If we 
> don't
> +	 * have that capability we can have multiple queues but we must 
> always
> +	 * run with all enabled.
> +	 */
> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
> +		return -EOPNOTSUPP;
> +
> +	/* TODO: reuse context swapping once it is merged. */

Once context swapping is merged, this needs to be addressed in v6 ;-)

> +	if (netif_running(bp->netdev))
> +		return -EBUSY;
> +
> +	/* If we allow disable a queue which has TAPRIO active, we'll keep a
> +	 * transmission window which will be unusable.
> +	 */
> +	if (bp->taprio_gated_queues >> count) {
> +		netdev_err(bp->netdev, "TAPRIO schedule gates queues >= %u; destroy 
> the qdisc before reducing channels\n",
> +			   count);
> +		return -EBUSY;
> +	}

I think this can get stuck:

- delete the  taprio qdisc after the link has been down for a while
- device is is runtime suspend
- taprio setup bails out before _destroy() is called
- ethtool -L keeps failing with -EBUSY, even though there is no qdisc 
anymore

Something like:

   ip link set eth0 up
   tc qdisc replace dev eth0 root taprio ... flags 0x2
   ip link set eth0 down
   sleep 1
   tc qdisc del dev eth0 root
   ethtool -L eth0 combined 1

> [...]

Thanks,
Nicolai
