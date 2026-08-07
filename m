Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926818E02A;
	Fri,  7 Aug 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115800; cv=none; b=Qbg3C9u/w//vA+ECABIFBubxY6qJgtC8PP8f6NHBDlym9D0b3WmqMoQ3LQkwMFbfTDFPTwlYqrMxi869mxeOzS8jjmbvi8Gqr2MDwwCk1o3FC/VQFrx+KeyXCE8eyWu/J9BZlcwdDe9U0aSuHWHTDbxULU/82EH9boERhKLVWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115800; c=relaxed/simple;
	bh=UvocAg3ssEQfupWjn4SJUuX/LPuRRrl1A5Oq7glsHM8=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:In-Reply-To:
	 References:MIME-Version; b=KpLvVgwtn5fYdxxcckYaVUAFAPW8qIfra2NCBjuG25QorN8uKDHvSgfDhGURYbXMDbHdEG1E7/lZAwSSdz85u8baYNF9w6oun9nvJTfl4K+Nubo4xCnkemD4euHGbntGt1mttKNqmbZI4cY/1WHsZrEvnC92nwhwXnSD4zrkr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gUQqdk6j; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gUQqdk6j"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CC2CC4E4102C;
	Fri,  7 Aug 2026 15:16:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A9A2603F0;
	Fri,  7 Aug 2026 15:16:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6896B11C37AAE;
	Fri,  7 Aug 2026 17:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786115794; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8+Ky5jzqJLJfUctSoR23BzlUi671iAEE+fJJ/pfDe64=;
	b=gUQqdk6jwkFHnsYHv3FShRHkGyS2TTB2KvMPAnO16VkGi7Vt/3S3XGCTZIdzQ3ChnyEysI
	JC7hm9UhLHtaSZxgQuW3eKyEuQqn7zEnPmmWGZJdOhotcO7F20uQmC3ahlQO85t5IGCR5d
	m6o2PhA7fV6kYuBgAhm1p7kepDFHDAom59wPrbgKH8G1OuDO9symkwBHBMJgn7N90c9b5M
	SFCnxIzl/d8GDab2eLGFzRa3BaJWeGwrLQOIO0XIaXvmu8Rzo6BZi4yLL8Ub+/PglJL399
	PQeYK2CYRI9K9mWx3ZwrGwOe7FcbWzrcbk7do0H/GtI+HqMfv79FLXWgGMwu9A==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 17:16:30 +0200
Message-Id: <DKIT7ESS4R1T.3UZ8I3167ENWV@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v8 12/17] net: macb: change function signatures
 to take contexts
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
In-Reply-To: <20260805-macb-context-v8-12-bc302ffd1174@bootlin.com>
References: <20260805-macb-context-v8-12-bc302ffd1174@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: dC6z6MhrOLuy
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko
https://sashiko.dev/#/patchset/20260805-macb-context-v8-0-bc302ffd1174%40bo=
otlin.com

> commit c728638bed1b685fcac80f81dd0aefb9dae1f050
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Subject: net: macb: change function signatures to take contexts
>
> To support parallel contexts, this patch updates multiple functions to
> take a context pointer directly rather than reading it from the active
> context (bp->ctx). Functions handling queues are also updated to accept
> the queue index explicitly.
>
> > @@ -3307,7 +3330,7 @@ static int macb_close(struct net_device *netdev)
> >  	netif_carrier_off(netdev);
> >  	spin_unlock_irqrestore(&bp->lock, flags);
> > =20
> > -	macb_free(bp);
> > +	macb_free(bp->ctx);
> >  	kfree(bp->ctx);
> >  	bp->ctx =3D NULL;
>
> [Severity: High]
> Could the context pointer be used after it is freed?
>
> If a TX or HRESP error interrupt fires right before macb_close() disables
> hardware interrupts, it will schedule queue->tx_error_task or
> bp->hresp_err_bh_work.
>
> In macb_close(), the active network context (bp->ctx) is freed and set to=
 NULL,
> but cancel_work_sync() is not called to stop the pending work items.
> When the work runs, it will attempt to read queue->bp->ctx or bp->ctx,
> resulting in a NULL pointer dereference or use-after-free.

Pre-existing issue but not flagged as such.
Related to the close op, not context swapping.

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

