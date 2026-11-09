Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256136;
	b=0jt9xDtlZj7+4CquAx+tbqMh3EzL3ZIngCSsyfd8ZiegrMXCI8RR4QHmHNBs5/SVivq3
	 MZsFhYClOa1eVOuE61Z+5q0zpFCRqe22OcGr15aooliFI7XDRQTW/buM6sij+SExEMQyo
	 /Gi7XIXnEq9tBpiYMR4yB05KeybSGVEKtgFMsrAvqRvBb5bBCHHO4MW3rmx7YMbaWq1JD
	 L4U/Nndpg5PNGansa/tNakTBe4UnPGaoYssESFvV/ds62kmpOQblRxKMb+5rZEblcx5BZ
	 74Zrvv36Qp4H3thRVX2IzqXhHuUdOi9U4/4ymwZghKeLMFq7dG4woKvOWwFNA0o2ySg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256136;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Last-TLS-Session-Version;
	bh=O8bWXtQs5tyhPqTBhmBjUN2HbzWi04nLxsVKERMlLnY=;
	b=yurXnaXZW71vRqm6FoCj2P7S6XAMdb3vhep4spK6YpuU7A5H8odyHKQDuR9kEzo8wi8L
	 wp9Q3sdVjPBQAMscAqt+9owwoF3/6VR6tHJca1+qsAV8NIkZT1iZTiBwdsfWutuUsNHgY
	 yjlVxGhGdSw2S6uZohxLlGe8s/Hz+JlZ39a4yCI+czSr7yIkJHgglzeefoU3mv3N/Ujyj
	 /bVUarROI8ZgHyHyVFRG+Nn6AKNvxI8AwEqec9t3vyKGB0I2k9hTOTB2GCnw+b80zZRvK
	 SjHXA6fyhZGsJxCQQBPWcMJFcvyBkbyuEWDYM+NvGPaZqCtW9XsEg2LfXITOWQ1/EKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=OfLuCSba;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439A606A321;
	Mon,  9 Nov 2026 20:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7439A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=OfLuCSba
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 085A8A1583;
	Mon, 09 Nov 2026 21:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794256131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O8bWXtQs5tyhPqTBhmBjUN2HbzWi04nLxsVKERMlLnY=;
	b=OfLuCSbabGbXKxsEWTqsxyM3H3PDPY0x1vCeUaij/McT8+ZLIk+jVIiEn81OsUSWcQyp+y
	EL0A2/Et5KjkhkSyrVBg5SKA52z7ZzgkT2HENFFUWlylMZ2fNRx2qMvOwMLyrTPuVt8CBk
	PL773vnoj0kE8Lyom1RbSv+Ljwd2FHKa7ynPAFMsvm62xWbdGUoJpaxB8T10Dtww2tTy5M
	ESYBAVQ4lTHKf5aWyPpRZXk9tJbaIeMGe45Q2hz7KSosP8+t0aBPQuHWjRp+THYnOh1yGU
	g4FXLYpwsReFK27ZXMrn/09xpMwviqO1DUJedIC+eIILUh5OrPHION4rBAwizQ==
Message-ID: <62513008af14da4a6fb35e1a9566146dca0efbef.camel@tipi-net.de>
Subject: Re: [PATCH net] net: bcmgenet: cap the Tx queue threshold at the
 ring size
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
 	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, 	justin.chen@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, 	razor@blackwall.org,
 kerneljasonxing@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 21:28:48 +0100
In-Reply-To: <179424433591.994134.17565447879442853727@kernel.org>
References: <20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de>
	 <179424433591.994134.17565447879442853727@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2026-11-09 at 17:12 +0000, netdev-bot+sashiko@kernel.org wrote:
>  [...]


> [Severity: High]
>=20
> Does this fully fix the stall on queues 1 to 4 when
> CONFIG_MAX_SKB_FRAGS
> is 31 or more? The wake threshold is now capped, but the per-skb
> admission
> check at the top of bcmgenet_xmit() has not changed:
>=20
> bcmgenet_xmit() {
> =C2=A0=C2=A0=C2=A0 ...
> 	if (ring->free_bds <=3D (nr_frags + 1)) {
> 		if (!netif_tx_queue_stopped(txq))
> 			netif_tx_stop_queue(txq);
> 		ret =3D NETDEV_TX_BUSY;
> 		goto out;
> 	}
> =C2=A0=C2=A0=C2=A0 ...
> }
>=20
> free_bds can never be larger than ring->size (32). So an skb with
> nr_frags >=3D 31 gets rejected even when the ring is completely empty.
>=20
> In that case nothing is in flight, so no Tx-done interrupt arrives
> and
> bcmgenet_tx_poll() never wakes the queue. The watchdog is the only
> wake
> source left:
>=20
> dev_watchdog()
> =C2=A0 bcmgenet_timeout()
> =C2=A0=C2=A0=C2=A0 bcmgenet_tx_reclaim(dev, ring, true);
> =C2=A0=C2=A0=C2=A0 BCMGENET_STATS64_INC((&ring->stats64), errors);
> =C2=A0=C2=A0=C2=A0 netif_tx_wake_queue(txq);
>=20
> The qdisc then retries the same requeued skb and gets NETDEV_TX_BUSY
> again, so the queue stops again.
>=20
> Wouldn't that leave the queue, and every flow hashed to it, stuck for
> good? The "NETDEV WATCHDOG: transmit queue N timed out" message and
> the
> error count from the commit message would then come back every
> watchdog_timeo.
>=20
> The core does not keep such skbs away from the driver. The driver
> advertises NETIF_F_SG, and it has no ndo_features_check and no
> skb_linearize() fallback. Highly fragmented skbs can come from
> MSG_ZEROCOPY, from splice, or from forwarded traffic.
>=20
> Should bcmgenet_xmit() also handle skbs where nr_frags + 1 >=3D ring-
> >size?
> It could linearize or drop them, or clear NETIF_F_SG for them in
> ndo_features_check.
>=20
> > =C2=A0	ring->clean_ptr =3D start_ptr;
> > =C2=A0	ring->c_index =3D 0;
> > =C2=A0	ring->free_bds =3D size;
>=20
> [ ... ]

Another angle, also pre-existing, but lets fix this properly with
another patch in v2. Long term goal should be to get rid of the
undersized queues (see my response to Florian)

--
pw-bot: cr

--=20
Nicolai Buchwitz <nb@tipi-net.de>
