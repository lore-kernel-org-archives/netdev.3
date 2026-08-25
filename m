Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42562485CC3;
	Tue, 25 Aug 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670276; cv=none; b=WHwIOERqRkQAXm/Q9rghNQ6Bg8GGZBUCv1UYb0hF1nkjn6clFvKXT6i67YnGfT9eRqbJ1XKP0eogv34wfv6Y+K1PH/0hFO+1+ae+tQXlmMfL5JbjxUBg2Ran5icZX+gTCqGyfy+g3dAGctjhU3BcECOFlXuFg3rzwK1rR7o+StE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670276; c=relaxed/simple;
	bh=oM4dSbkkMqU45DCiETA2sg0BS3SJpCkREXR7ZaubRrI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MZU24cqzrXQXljEGEYdwSNWMZcqEYaQ6v5yAeAIOyau3u0ohkZU1j7Y0w4fLyYRz6TbOjOM8FV/K8ih4BD7Rp2EqCMvYjbgMmeo7m+FMSN4mvTrw2MKIGTTj/N+GXV6EnrI2N9Y6L6dR3Ch5C8kH+S6An2Js+VuKXegmjgVi3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VrzU2FS9; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VrzU2FS9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8B05A3A02;
	Tue, 25 Aug 2026 17:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787670257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=54Wje8N0OCytnmZ5gfVOInlcNWNNV3F/Vi3MUHcqPco=;
	b=VrzU2FS90DDJSSQTHE8ieco8hFLyj9HD7td9BI07GFV0acj5XiCJPA8D6tN4ryQ691sJv6
	OszMuclOHsjcFn/2kRKtswFt1Txa1RPrfFwdlLveQn6yvQW8FlvMzK8F5aTCR240BpqiXe
	UXzbhWoUDC0Zp/gctnt6OAP6DAS70pfe6EihPXZu+9qPkAzznSbxul1fIls/OMAteu2ujl
	Fyhpcj9sbkkYn7PxSSLMenaUp+m9h/T88oDmCImW3NfK7j4KOghSyk4kopquQc/r0GcHm9
	ADuSLxOJHLqyNCXxVjlyczWR3Dm8EwNCnLj0GZHF2E2aX9YcLjPzBS7npqR1IQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 17:04:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Jonathan Bell <jonathan@raspberrypi.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
In-Reply-To: <20260824134703.766708-2-nb@tipi-net.de>
References: <20260824134703.766708-1-nb@tipi-net.de>
 <20260824134703.766708-2-nb@tipi-net.de>
Message-ID: <d1f02ab923c0464fa73cafa75a21943d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Replying to netdev's sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/message/20260824134703.766708-2-nb%40tipi-net.de:

> --- Patch [1]: [PATCH net 1/2] net: macb: exclude software FCS from TX 
> byte statistics ---
> commit 24acee751440b1a44c9e16688554df0848ab621a
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
>     net: macb: exclude software FCS from TX byte statistics
> 
>     Frames going through macb_pad_and_fcs() get padded and four FCS
>     bytes appended, and TX completion then accounts the grown skb->len.
>     tx_bytes is supposed to exclude the FCS, and frames padded by the
>     hardware are counted without the padding anyway, so these frames
>     show up too large in the statistics.
> 
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > index 76ee4f5060335..623d072a271d0 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -1322,8 +1322,8 @@ static void macb_tx_error_task(struct work_struct *work)
> >  				bp->netdev->stats.tx_packets++;
> >  				queue->stats.tx_packets++;
> >  				packets++;
> > -				bp->netdev->stats.tx_bytes += skb->len;
> > -				queue->stats.tx_bytes += skb->len;
> > +				bp->netdev->stats.tx_bytes += tx_skb->skb_len;
> > +				queue->stats.tx_bytes += tx_skb->skb_len;
> >  				bytes += skb->len;
> >  			}
> >  		} else {
> 
> This is a pre-existing issue, but does macb_tx_error_task() leak BQL 
> bytes for
> dropped pending packets?
> 
> When recovering from a TX error, macb_tx_error_task() iterates through 
> the TX
> ring. For pending descriptors that did not successfully transmit, the 
> code calls
> macb_tx_unmap(bp, tx_skb, 0) which frees the SKB.
> 
> However, it appears to fail to accumulate the freed SKB's length into 
> the bytes
> accumulator. When netdev_tx_completed_queue() is subsequently called, 
> these
> leaked bytes are never reported to BQL, which could permanently retain 
> these
> charged bytes and stall the TX queue.

Looks like it. The dropped frames never get a completion credit, and DQL
only gets reset on close. This is independent of the statistics change,
so I would address it in a follow-up fix. Objections?

> This is another pre-existing issue, but does macb_tx_error_task() 
> modify the TX
> ring pointers without holding the appropriate lock?
> 
> macb_tx_error_task() acquires bp->lock and issues a non-blocking stop 
> to the
> queues via netif_tx_stop_all_queues(). It then manipulates the ring 
> pointers
> queue->tx_head and queue->tx_tail.
> 
> However, the fast-path macb_start_xmit() protects these identical 
> pointers
> using queue->tx_ptr_lock.
> 
> Since netif_tx_stop_all_queues() does not wait for an already-running
> macb_start_xmit() to complete, could macb_tx_error_task() zero out the 
> ring
> pointers while macb_start_xmit() is concurrently populating descriptors 
> on
> another CPU?

AFAIU yes, stopping the queues doesn't wait for a start_xmit that's
already running. Taking tx_ptr_lock there before bp->lock, in the same
order as start_xmit, should fix that. I would handle this together with 
the
BQL issue in a follow-up series.

> [ ... ]
> > @@ -2485,6 +2487,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
> >  		return ret;
> >  	}
> >
> > +	skb_len = skb->len;
> > 	if (macb_pad_and_fcs(&skb, netdev)) {
> 
> This isn't a bug introduced by this patch, but does macb_pad_and_fcs() 
> append
> an FCS before verifying TX ring space, which could corrupt the SKB upon 
> retry?
> 
> [ ... ]
> 
> Because the network stack will subsequently retry transmitting this 
> identical
> SKB, and its length is now larger, will macb_pad_and_fcs() compute a 
> new CRC
> over the old FCS and append a second, duplicate FCS, eventually 
> corrupting the
> payload once tailroom is exhausted?

Yes, and the copy path looks worse: the stack can requeue an skb the 
driver already
consumed. I'll do the ring space check before touching the skb at all. 
After that
point the driver never returns NETDEV_TX_BUSY, so swapping the skb 
should be fine.

> This is also a pre-existing issue, but does macb_pad_and_fcs() modify 
> shared SKB
> data for cloned packets and break nonlinear SKB layouts?
> 
> If an SKB is cloned (e.g., multicast, TCP retransmissions) or nonlinear 
> (paged
> fragments), and its length is already >= ETH_ZLEN (60 bytes) so padlen 
> <= 0,
> and it has at least 4 bytes of tailroom, the code skips the 
> reallocation check:
> 
> 	if (padlen <= 0) {
> 		/* FCS could be appeded to tailroom. */
> 		if (tailroom >= ETH_FCS_LEN)
> 			goto add_fcs;
> 
> It then directly appends 4 bytes of FCS via skb_put_u8(). For cloned 
> SKBs, this
> modifies shared memory data. For nonlinear SKBs, skb_put() illegally 
> extends the
> linear part, which could trigger a panic in skb_panic().

The cloned part looks right. The nonlinear case IMHO can't trigger 
today:
skb_tailroom() is 0 for nonlinear skbs, so they go down 
skb_copy_expand(),
which linearizes them anyway.

I'll order the cloned check before the in-place FCS path.
