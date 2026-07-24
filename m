Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114F41A79E
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901949; cv=none; b=PPRIZ+Sx31KXJAQ3j7vYHf+CPQ9CEGbVwGwlU3AfBFPAEG00bFXZu5Y3hblEU9x3N8oyPH/qyLZZ2QYYmjt0GSN8rPI0qN9M9BJqiTuJBRg7kTKVeLcvYxWAbuU2nY/ry3T/HrysU21qCvD3l0232G51p87NK67MPbnUN36wnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901949; c=relaxed/simple;
	bh=eVPLDsdD89K2TGrSG8oVm3FANMh0vjCIxBt2s7PROQs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=rnUNgf0SMQ2RiB8Qi9jAKAJ2LMSEAEOhalTSq+3NZMbA4wUpVBXSkFU3l/zdt1yTrVbRfvhdOASqslc9IgUNf7+trbaZ3rTCXSNVIXik45eTq0d7RI1YtHPYoVIowyiqPypHCHqc+m+oEFbFSTYN2KkzKCcGKBlbyqzjRwT4MK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jnsZs6ff; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jnsZs6ff"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B7A9F4E40F2F;
	Fri, 24 Jul 2026 14:05:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C4C560395;
	Fri, 24 Jul 2026 14:05:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16FFE11C12569;
	Fri, 24 Jul 2026 16:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784901944; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6fksmPJr9Q7kO/HBpvavDlpG72c+2uj4oIcabIgThBA=;
	b=jnsZs6ffk7r710Tqk5ffNO85UTrPO63kNQjU5631LBRThmSRq8ZzMFvuFoTCzCh86SK85d
	4EBd8L5z6tL9pKR1g2WvprXVk2TPdVenlHwjUMxR/sAY6Vz5KAZVQFBiRA/yCGBm2RFHY+
	aInC6cLLpwBzK12jJ3s4tQtLWBkwn8f2PYM/7pIKt4Cg0TIEfYrEGtKDXVodNyiTcbHmw7
	fDtDI8os0JChEY9y5g9+xCrOoaV12pXnBWgbepzm/klwawEgJcfRtJb461CXThaHm0Z84y
	T8NKiEhHaX1FL68WzXFK4lW/GMfJWctqm5w0O+bPN8fJyG5f3DvH0fQASn9pKg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 16:05:40 +0200
Message-Id: <DK6UXJNY823U.32CIMUE9VMVKW@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v4 11/15] net: macb: change function signatures
 to take contexts
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-11-0acbe7f10cdb@bootlin.com>
 <a6ae2cec6d910378e790d52cc3fd1a00@tipi-net.de>
In-Reply-To: <a6ae2cec6d910378e790d52cc3fd1a00@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

On Sun Jul 19, 2026 at 12:46 PM CEST, Nicolai Buchwitz wrote:
> On 17.7.2026 21:48, Th=C3=A9o Lebrun wrote:
>> For parallel MACB context to start become a reality, many functions=20
>> need
>> to stop operating on bp->ctx (the currently active context) and instead
>> work on a context they get passed. That context might be
>> (1) the new one that is getting allocated and initialised, or,
>> (2) the old one to be freed.
>>=20
>> To reduce bug surface area, taint those functions to *only* take a
>> context `struct macb_context *ctx` and no `struct macb *bp`. That way,
>> no bug of using `bp->ctx` instead of `ctx` will ever occur.
>>=20
>> We also convert functions that take a `struct macb_queue *queue` to
>> instead take `struct macb_context *ctx, unsigned int q`, with q
>> indexing ctx->txq[] and ctx->rxq[].
>>=20
>> Full list:
>>=20
>>    macb_adj_dma_desc_idx()
>>    macb_tx_ring_wrap()
>>    macb_tx_desc()
>>    macb_rx_ring_wrap()
>>    macb_rx_desc()
>>    macb_get_addr()
>>    gem_rx_refill()
>>    macb_init_rx_ring()
>>    gem_free_rx_buffers()
>>    macb_free_rx_buffers()
>>    macb_tx_ring_size_per_queue()
>>    macb_rx_ring_size_per_queue()
>>    macb_free()
>>    gem_alloc_rx_buffers()
>>    macb_alloc_rx_buffers()
>>    macb_alloc()
>>    gem_init_rx_ring()
>>    gem_init_rings()
>>    macb_init_rings()
>>=20
>> Note about gem_rx_refill(): it ends with a netdev_vdbg() that prints=20
>> the
>> queue pointer. Change to print the queue index because we do not have
>> access to the queue anymore.
>>=20
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      |   7 +-
>>  drivers/net/ethernet/cadence/macb_main.c | 398=20
>> ++++++++++++++++---------------
>>  2 files changed, 215 insertions(+), 190 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb.h=20
>> b/drivers/net/ethernet/cadence/macb.h
>> index c551d7db8ebe..ac2f2d8065d7 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -1196,11 +1196,12 @@ static const struct gem_statistic=20
>> queue_statistics[] =3D {
>>=20
>>  struct macb;
>>  struct macb_queue;
>> +struct macb_context;
>>=20
>>  struct macb_or_gem_ops {
>> -	int	(*mog_alloc_rx_buffers)(struct macb *bp);
>> -	void	(*mog_free_rx_buffers)(struct macb *bp);
>> -	void	(*mog_init_rings)(struct macb *bp);
>> +	int	(*mog_alloc_rx_buffers)(struct macb_context *ctx);
>> +	void	(*mog_free_rx_buffers)(struct macb_context *ctx);
>> +	void	(*mog_init_rings)(struct macb_context *ctx);
>>  	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
>>  			  int budget);
>>  };
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 7574418d5094..d396a307310b 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
>> [...]
>
>> @@ -5083,7 +5107,7 @@ static int at91ether_start(struct macb *bp)
>>=20
>>  	addr =3D rxq->buffers_dma;
>>  	for (i =3D 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
>> -		desc =3D macb_rx_desc(queue, i);
>> +		desc =3D macb_rx_desc(bp->ctx, 0, i);
>
> AFAIU at91ether_open() doesn't set bp->ctx->info at this point in the
> series, so with CONFIG_MACB_USE_HWSTAMP=3Dy this should oops on ifup:
>
>      macb_rx_desc()
>        macb_adj_dma_desc_idx()
>          macb_dma_ptp(ctx->info)   -> NULL deref
>
> The next patch adds the missing assignment to at91ether_open(), so
> only bisection is affected. Maybe move that line here or into patch 9?

Yes, IDK why/how I landed on this.

=E2=9F=A9 # This looks much more sensible.
=E2=9F=A9 git log -L:at91ether_open:drivers/net/ethernet/cadence/macb_main.=
c net-next/main..macb-context

net: macb: unify device pointer naming convention
net: macb: unify variable naming convention in at91ether functions
=3D> variable renames

net: macb: introduce macb_context struct for buffer management
=3D> adds allocation with `bp->ctx =3D kzalloc_obj(...)` and cleanup on err=
or

net: macb: make `struct macb` subset reachable from macb_context struct
=3D> adds `bp->ctx->info =3D &bp->info;` when introducing info

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

