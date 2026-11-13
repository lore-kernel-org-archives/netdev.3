Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591529;
	b=3Gh7S6B0NwUfznuZW9OHuu2hI7eXKsODrvrt3/wLJsw6Ypp7BS+dFPAK0gZVLfxexPNV
	 7mWeDSQLebgp/kynlxae7gG7zMwWd7QegmetjkVjCvL+MXiDP0L0ovYgxRxM6nA4nneuf
	 kDZoJb8GkooAPSoIG5t2NvF7l1VcwOu05YN8g8z5IzM/rwpdE1tf4ejCs8+Y93P9R/hh7
	 hw45ie9xn2QkvjI4pvJKRPDYYwZgtDRX0FovHKD2maOMBZ5SQhnZUySCd/UVHFwuozmm5
	 J5WjwH7sWcnmIM5urcsxFILWPtPcdgL1OHMWWiM6mjsXyxdGw+gFdjD0NBAtvnZouQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591529;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Subject:
	 Cc:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=18VHZc5HLRKwdrmd0bezDz/JEVjzq8cueX1HfhddlAU=;
	b=MAneK4RGsFVKsCvGW/UKBlDPZk+VKC9Jq9NaT7vuY1NHlA3W/JYzILcJVZ9bLyBwnpzl
	 gsbbHP+NHvDB4sJaztKzAjuSzFVC4TKeiE1+67efTzvHBv5AiYrUIh5Es5WF7MRTc2w/6
	 V9puWXyFythFPkV+0RIgS0ShBQRgAL9aysa85jQ8lfsp9vu3TvEy40PP8uFwCIwAVI49H
	 p3vGwY9cM0WDBJzMTrAhomicLjcfZmbMc+J5BlXECKjDbH7Tkbn9VvNX981Oiir43uinQ
	 DFKcuQPjZF1pYvM7otJK1WctBmquhUhG6hgz65CtUu97PAyVHWZNGbFpMmMHi+9wXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LmKpmcX0;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78762606D850
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78762606D850
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LmKpmcX0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6C01AC4F755;
	Fri, 13 Nov 2026 17:38:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 578DE60015;
	Fri, 13 Nov 2026 17:38:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D873711BC0467;
	Fri, 13 Nov 2026 18:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794591525; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=18VHZc5HLRKwdrmd0bezDz/JEVjzq8cueX1HfhddlAU=;
	b=LmKpmcX0xqT7E2UQflP220j6/R4jYXQl72JhnSJPULRTVQfbDd5ZtkOasx5Dd2bx8letxT
	RemZSinpjiqR9XmiTyGFa/OuhukXSoPibcK1YcabYZI02lC27BgljfSPM1DXOEi8zvLf5C
	v3TdYOyu40QjB+AM9ZqKoupcpRLZ/z3I9kQdPH/rVy+YG7OEf3xCn4Me/ntFbS7tbcyqSI
	ZMl0sCwmQL+i7189AyR+HUoChP5quOZ+J0TeWtFrO1LEsq5cVqlpOYNSsNFI/PLK5HKM30
	monTPEMadHbcEKZdKhHvVNK1dZwykHjiDwn8MO/Cn/oHDzxXmS4iC/Gftku7bA==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 18:38:41 +0100
Message-Id: <DMU9LNJOVW85.UJLCC6X6EON3@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 2/3] net: macb: implement
 ethtool_ops.get|set_channels()
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
 <20261016-macb-set-channels-v5-2-90ce0c0b8e75@bootlin.com>
 <45fae7a00024b7d07cd3250d4f2b5b48@tipi-net.de>
In-Reply-To: <45fae7a00024b7d07cd3250d4f2b5b48@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Oct 19, 2026 at 2:52 PM CEST, Nicolai Buchwitz wrote:
> On 16.10.2026 18:58, Th=C3=A9o Lebrun wrote:
>> bp->num_queues is the total number of queues and is constant from=20
>> probe.
>> Introduce bp->max_num_queues which takes the current role of
>> bp->num_queues and allow `0 < bp->num_queues <=3D bp->max_num_queues`.
>> MACB/GEM does not know about Rx/Tx specific queues; it only has
>> combined queues.
>>=20
>> set_channels is reserved to devices with MACB_CAPS_QUEUE_DISABLE.
>> The tieoff workaround would not work as packets would still be routed
>> into queues with a tieoff descriptor.
>>=20
>> Implement .set_channels() operation by refusing if netif_running(). We
>> need context-swapping support upstream for proper on-the-fly channel
>> count change.
>>=20
>> Note we refuse the operation if any TAPRIO rules are in place on queues
>> that would get disabled. If we allow the operation to take place, then
>> a transmission window would be reserved but unusable.
>>=20
>> Nit: fix an alignment issue inside gem_ethtool_ops which does not
>> deserve its own patch.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>
>> [...]
>
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
>> [...]
>
>> +static int macb_set_channels(struct net_device *netdev,
>> +			     struct ethtool_channels *ch)
>> +{
>> +	struct macb *bp =3D netdev_priv(netdev);
>> +	unsigned int count =3D ch->combined_count;
>> +	int ret;
>> +
>> +	/* MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE/BIT0 in
>> +	 * the per-queue RBQP/TBQP registers disable Tx/Rx queues. If we=20
>> don't
>> +	 * have that capability we can have multiple queues but we must=20
>> always
>> +	 * run with all enabled.
>> +	 */
>> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
>> +		return -EOPNOTSUPP;
>> +
>> +	/* TODO: reuse context swapping once it is merged. */
>
> Once context swapping is merged, this needs to be addressed in v6 ;-)

Done! The patch changed a lot, for the better. num_queues is now part of
the context, as any context "parameter" should be. It had no place in
the global interface struct.

This highlights a few callbacks that are reading num_queues while
interface might be down. I've not attempted to fix those yet. :-)

https://lore.kernel.org/netdev/20261113-macb-set-channels-v6-0-5de59d9e7f02=
@bootlin.com/

>
>> +	if (netif_running(bp->netdev))
>> +		return -EBUSY;
>> +
>> +	/* If we allow disable a queue which has TAPRIO active, we'll keep a
>> +	 * transmission window which will be unusable.
>> +	 */
>> +	if (bp->taprio_gated_queues >> count) {
>> +		netdev_err(bp->netdev, "TAPRIO schedule gates queues >=3D %u; destroy=
=20
>> the qdisc before reducing channels\n",
>> +			   count);
>> +		return -EBUSY;
>> +	}
>
> I think this can get stuck:
>
> - delete the  taprio qdisc after the link has been down for a while
> - device is is runtime suspend
> - taprio setup bails out before _destroy() is called
> - ethtool -L keeps failing with -EBUSY, even though there is no qdisc=20
> anymore
>
> Something like:
>
>    ip link set eth0 up
>    tc qdisc replace dev eth0 root taprio ... flags 0x2
>    ip link set eth0 down
>    sleep 1
>    tc qdisc del dev eth0 root
>    ethtool -L eth0 combined 1

Good catch. I was able to reproduce this. Fixed by running

   // macb_taprio_destroy()
   netdev_reset_tc(netdev);
   bp->taprio_gated_queues =3D 0;

Even if the interface is down.
We skip over the hardware reconfig however.

Thanks for the review,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

