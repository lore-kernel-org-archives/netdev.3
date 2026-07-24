Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C4439012;
	Fri, 24 Jul 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902094; cv=none; b=sPnZlLgJ505w2yiW33fcke8FhMlbPJDVchD+VoFIKZnQXaZrpqcJaiCm3qCFsv98Bpsn1neiDMo2ecO3pcCJUIuGSf9jQCC+ddLdeuwIsef5FHFUB7zhO1qk6pBBPx+At5mx1lTZ/2+x3rcoOtNNqabeVbtXFtV+pT3nmxUcx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902094; c=relaxed/simple;
	bh=257OyDgYbMvkHNleTJ+0nLh5+gUlb4k+2Nt5FeeMgRs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=W/ukouwGQJW3+BoaRYEx4hFzCGmiwp2+CI9LY4u2UqhO/f6xupHYCEvmrsTuOQ1p7YGz4QBmRrQBnV8f9hxjMHFOnYoF4Epsehol2c7vDjgXac92au2SEkB4AV2NvhsVu25u61M4a2oIbQLWWRTqdSYnOBuT9CInv34UI19mUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IIwDcb+w; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IIwDcb+w"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0F004E40F30;
	Fri, 24 Jul 2026 14:08:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63F5D6039A;
	Fri, 24 Jul 2026 14:08:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D518411C10BEF;
	Fri, 24 Jul 2026 16:08:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784902088; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lPgDLvp5ka4HUGXHiCTR3jQaAsbu195S+HPkPvHcRk0=;
	b=IIwDcb+wMZ+GgNRtXL/ju8UbHIOiPytL7Oyq/x7EOHHYHLhTuyB9ARNx9YCkOV0AGJ/C7X
	+C18AOzW96FuwJ43XTLrRm1WwKpysFprV9eNqc35Wx+kLhx+Ea1UpJ6/BvDpAL/STvOXMi
	r84aikz3b9DI15MTMJaFW6fMgMPYrmoYBeLttFJrhCSpYKwkdYv1MvDvBtZHB/n/H08WQ3
	EY6esQbtLrPkm+XGt8LkfZ8fjR1CnhYej3RJdEeEfSExFbwAx4QiKTaJY/ZBClASEwwb0s
	/UhhW3PK1g4bK76jjVZSRKYTi//5VsEY3S8UfKw2YdMaYXONt00pfyOe6wiFBQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 16:08:04 +0200
Message-Id: <DK6UZDTOYBC3.2E101XECYQOYG@bootlin.com>
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
Subject: Re: [PATCH net-next v4 14/15] net: macb: use context swapping in
 .set_ringparam()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-14-0acbe7f10cdb@bootlin.com>
 <ca25adb833a2dc5031434ebe33c3b8eb@tipi-net.de>
In-Reply-To: <ca25adb833a2dc5031434ebe33c3b8eb@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

On Sun Jul 19, 2026 at 12:53 PM CEST, Nicolai Buchwitz wrote:
> On 17.7.2026 21:48, Th=C3=A9o Lebrun wrote:
>> ethtool_ops.set_ringparam() is implemented using the primitive close /
>> update ring size / reopen sequence. Under memory pressure this does not
>> fly: we free our buffers at close and cannot reallocate new ones at
>> open. Also, it triggers a slow PHY reinit.
>>=20
>> Instead, exploit the new context mechanism and improve our sequence to:
>>  - allocate a new context (including buffers) first
>>  - if it fails, early return without any impact to the interface
>>  - stop interface
>>  - update global state (bp, netdev, etc)
>>  - pass buffer pointers to the hardware
>>  - start interface
>>  - free old context.
>>=20
>> The HW disable sequence is inspired by macb_reset_hw() but avoids
>> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
>>=20
>> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
>> over register writes which would be redundant (because values have not
>> changed).
>>=20
>> The generic context swapping parts are isolated into helper functions
>> macb_context_swap_start|end(), reusable by other operations=20
>> (change_mtu,
>> set_channels, etc).
>>=20
>> Introduce a new locking primitive (mac_cfg_lock mutex) to serialise=20
>> swap
>> with phylink MAC callbacks. Avoid stopping phylink to avoid a slow PHY
>> retrain. Those callbacks grab phydev->lock if it exists so we could
>> imagine grabbing that from the swap op, but phydev->lock doesn't exist
>> in the SFP case.
>>=20
>> AT91 EMAC is handled differently as their buffer management is separate
>> and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
>> context swapping for them.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      |   5 +
>>  drivers/net/ethernet/cadence/macb_main.c | 162=20
>> +++++++++++++++++++++++++++++--
>>  2 files changed, 158 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb.h=20
>> b/drivers/net/ethernet/cadence/macb.h
>> index ac2f2d8065d7..93e513cf1fbb 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -1361,6 +1361,8 @@ struct macb {
>>  	struct macb_queue	queues[MACB_MAX_QUEUES];
>>=20
>>  	spinlock_t		lock;
>> +	/* Serializes context swap against phylink MAC callbacks. */
>> +	struct mutex		mac_cfg_lock;
>>  	struct clk		*pclk;
>>  	struct clk		*hclk;
>>  	struct clk		*tx_clk;
>> @@ -1421,6 +1423,9 @@ struct macb {
>>  	struct delayed_work	tx_lpi_work;
>>  	u32			tx_lpi_timer;
>>=20
>> +	/* ISR must not drive NAPI & BH mechanisms. Protected by bp->lock. */
>> +	bool			ctx_swap;
>> +
>>  	u32	rx_intr_mask;
>>=20
>>  	struct macb_pm_data pm_data;
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index c832b6c1b98c..5792647eb0a6 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
>> [...]
>
>> +
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		/* Must be done before NAPI is disabled. */
>> +		cancel_work_sync(&queue->tx_error_task);
>> +
>> +		napi_disable(&queue->napi_rx);
>> +		napi_disable(&queue->napi_tx);
>> +		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
>> +	}
>> +
>> +	/* Must be done after napi_tx is disabled. */
>> +	cancel_delayed_work_sync(&bp->tx_lpi_work);
>> +
>> +	/* Can finally disable software Tx; need to wait until napi_tx and
>> +	 * tx_error_task cannot be scheduled as either might wakeup Tx.
>> +	 */
>> +	netif_tx_disable(bp->netdev);
>
> Shouldn't netdev_tx_reset_queue() come after netif_tx_disable()? Tx is
> still running here, so an xmit right after the reset adds bytes to the
> DQL that never get completed (macb_free() frees the old skbs without
> netdev_tx_completed_queue()). Not sure, but that could leave the queue
> stopped by BQL forever?

I don't see how the queue could be stopped by BQL forever, just a long
term small drift. But it's a bug!

Moved netdev_tx_reset_queue() to after netif_tx_disable() and before
TE writel.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

