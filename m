Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532555;
	b=iNO963ySAQuIDzSLk/FEGi2Bi22Mwi5xZd+KoHrmG84igvRNSvMDsE5JX+GNprrNWdVB
	 GlSu/BMIfIFZKTHtSGH1ritlK7Y2PJoupgC9MJa0stylzm+j3043mcTCuXK6hWF3bW8dA
	 h7ltgfv7+hIYzNYyd3sjeoUASy9g4uPSjB5L1ruh3wuI2UV0y7b5CttLh9YACNTDojde6
	 TLPo25cCd53J34IFUMbXjomWLqBJFJzfL6KXRj2Hme3V7WTeRaet0gE0fwBl+8Z+YtFKG
	 ML8i3x75oSqWN/GcmVhCfR2MC+843aE9A9oabxQGuLHpu+ABHSU+lp+FJ382J4s2NOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532555;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=EZoVk953tdpmRXAVkVQyjR2UGZ+9j5515QF7WBP1WBk=;
	b=C06ZRKcEELizGEUfddMax7e8qqWLDkzuSmah4+05wPD/N4UgRVjsaO+R6CaZ0HfoOJ+H
	 Nki76xmsifdKuCtEQTEa8BgHlxu2VD9o9RV+5rwlEf1wvRhqyiSoeg1nVZJRWp3oqMavQ
	 Dm/kzH47JYjZOhJky0J0iwDVQD1IOsKO29DZ/4trO0tNYzjmrxLxpE+KKeQdfTmsAsUPz
	 P2r73rpciogEtiAYvmHct/bPRawvhlg/M2Kskk7/CYDeTfsclUQaC12IiEFL7P7Q7PnJr
	 lYrSQfaRWByUXcR7N3eTUG8pYrUQb8RkipU33PDffDDZpk8k13527PXOsY6jZDWBbQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Ws+kLsKd;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9F606A319;
	Tue, 20 Oct 2026 21:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D9F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Ws+kLsKd
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A89AA161F;
	Tue, 20 Oct 2026 23:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792532549; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EZoVk953tdpmRXAVkVQyjR2UGZ+9j5515QF7WBP1WBk=;
	b=Ws+kLsKdofv/SfwkZRiBLhQLma9RauatD4xtoDQ9QDvSn0F5ryDf0YijpfI6Wvg8ZQV5RB
	j3VeYj2rqX4Yhxa/DJhf6INhNVyjMs9LI/K26NERS5DEYu1guli7OnTrfHeWPyC7+ubEo7
	JnROMakMNrMn6HaRt6H5tmj2qb0pRMc6Js5NajLCPZvtjTO9uVGopp1nfL3LSHCska2hd/
	tKO3okH0wkDsTUbTYiEpmnC4aDDljhSleVGOhe9CX7bGHV+oeP+jiRyZHm6eThm1QWpTbi
	p1IefVOjmDDh3+RWnTBSWjATy9oRZhTiRijuBFGVqHXHhabRe+s4GzSwncbhWw==
Date: Tue, 20 Oct 2026 23:42:26 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>,
 Alexey Orishko <alexey.orishko@gmail.com>,
 Greg Suarez <gsuarez@smithmicro.com>,
 =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
CC: Breno Leitao <leitao@debian.org>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mikkel Eskildsen <mke@visotia.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_1/2=5D_net=3A_usb=3A_cdc=5Fncm=3A_d?=
 =?US-ASCII?Q?on=27t_enable_BHs_in_tx=5Ffixup_under_netpoll?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261020-cdc-ncm-netpoll-v1-1-682184384b49@tipi-net.de>
References: <20261020-cdc-ncm-netpoll-v1-0-682184384b49@tipi-net.de> <20261020-cdc-ncm-netpoll-v1-1-682184384b49@tipi-net.de>
Message-ID: <C3957DEA-5A45-4371-A7F2-72DB1F61C404@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3



On October 20, 2026 9:16:55 AM GMT+02:00, Nicolai Buchwitz <nb@tipi-net=2E=
de> wrote:
>netpoll holds the txq lock and calls ndo_start_xmit() with IRQs off but
>BHs on=2E The spin_unlock_bh() in cdc_ncm_tx_fixup() then runs pending
>softirqs=2E If one of them transmits, it spins on the txq lock that
>netpoll holds=2E With netconsole on a cdc_ncm device this ends in a soft
>or hard lockup=2E
>
>Use spin_lock_irqsave(), which is safe both under netpoll and on the
>normal xmit path=2E
>
>Fixes: c84ff1d6dff3 ("cdc_ncm: reduce driver latency in the data path")
>Reported-by: Mikkel Eskildsen <mke@visotia=2Ecom>
>Closes: https://lore=2Ekernel=2Eorg/netdev/PRAP189MB185019A5A8D411482BB6E=
0CDA9982@PRAP189MB1850=2EEURP189=2EPROD=2EOUTLOOK=2ECOM/
>Tested-by: Mikkel Eskildsen <mke@visotia=2Ecom>
>Signed-off-by: Nicolai Buchwitz <nb@tipi-net=2Ede>
>---
> drivers/net/usb/cdc_ncm=2Ec | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/usb/cdc_ncm=2Ec b/drivers/net/usb/cdc_ncm=2Ec
>index 35db38cb3e4a2=2E=2Eb579442f4a272 100644
>--- a/drivers/net/usb/cdc_ncm=2Ec
>+++ b/drivers/net/usb/cdc_ncm=2Ec
>@@ -1524,6 +1524,7 @@ cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff=
 *skb, gfp_t flags)
> {
> 	struct sk_buff *skb_out;
> 	struct cdc_ncm_ctx *ctx =3D (struct cdc_ncm_ctx *)dev->data[0];
>+	unsigned long irqflags;

x-mas, argh =2E=2E=2E broken before and after, will fix this in v2=2E

But let's hear what/if clashiko will add, before I mark it cr in pwbot =2E=
=2E=2E

> [=2E=2E=2E]
