Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827D1DDFE;
	Fri, 31 Jul 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510506; cv=none; b=WcrFDQnS8VSUPOOv2LkgjuYPbaVhSyzeTL7aJ0pR4jK6vReYSCrw45qv8Ru9oz65jLK2NbhvkEGiYm2uQlFkRSp9EJTOIsb/1oFw80+zcNPxF049HPmeuW6SR5f2nAaNXgQsTgB7yotfjaP+R6KYz4ud5qPqcTxf1UZNiXl9s2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510506; c=relaxed/simple;
	bh=dAFrMsjElGKgQjF61rHApntBCeOZW+uZCqqzaVoS13g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=s71o+12uaiBKV0XM04D4qIwHp2V1YCuzfYHRWO6NokBHOOSAvoAxWO3NA3wqztlajB1vGqIRc4D39l6uM09WH7VPw3bdUKnQlO5tA3B7x2BIIE656Apj+44naCqEXEj3l9fsNPu/i/dHcOCPZK3TPxCl+F1+Pk9jpld/hAEVk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q8hFrFp7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q8hFrFp7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AA71A4E41054;
	Fri, 31 Jul 2026 15:08:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7BED86039A;
	Fri, 31 Jul 2026 15:08:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AA9811C169CC;
	Fri, 31 Jul 2026 17:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785510496; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AqwJLNffhEijlwXS2P/9oemkN76WDCRtQMlw4W7W8Eg=;
	b=Q8hFrFp75+VwqXh8/iNJAW/1Vi2t5j+Udb5GPecauqYX7fsLss9MuFrpCIG42fZcJXKclM
	AN3YCcl1gGzEHo6+lQ7akzVQgoVjI2nIXPjh4pVxIXOHWePFNnLDhPcfdwR5nHXR8huMdZ
	JK0gBRkATl8BXdBs1ncWSLzzBl95bDM07+KTo6BN8psKZvHCjT66bhcpEWa5vXC3UHmYbv
	yjbsXJa5VGqbOFrJpjoOtwcbnGrMga8EaL6ww2JY9AsiluZCAIkQc/yM7/dZdU2363de4G
	dwg1l4TjgehHagEqnkBhrEoJBimKJtuWwNL4gJxpq0Jc+gevZN7/OmnpM8prXQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 17:08:12 +0200
Message-Id: <DKCUN8JD8OK8.23HEZPJRTZCMB@bootlin.com>
Subject: Re: [PATCH net-next v5 13/15] net: macb: read ISR inside bp->lock
 critical section
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
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-13-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-13-569b1852bc7f@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Replies to sashiko reviews!
https://sashiko.dev/#/patchset/20260724-macb-context-v5-0-569b1852bc7f%40bo=
otlin.com

sashiko-netdev had nothing to say on this patch.

> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 4c94c23d925a2..c832b6c1b98cd 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -2185,12 +2185,13 @@ static irqreturn_t macb_interrupt(int irq, void=
 *dev_id)
> >  	struct net_device *netdev =3D bp->netdev;
> >  	u32 status;
> >
> > -	status =3D queue_readl(queue, ISR);
> > +	spin_lock(&bp->lock);
>
> [Severity: High]
> Does unconditionally acquiring this lock introduce a recursive deadlock w=
ith
> netconsole?
>
> If a network error occurs, macb_tx_error_task() acquires bp->lock and cal=
ls
> netdev_err(). If netconsole is active, it attempts to transmit the log
> immediately by invoking macb_poll_controller(), which disables local
> interrupts and directly calls macb_interrupt() on the same CPU:
>
> macb_tx_error_task()
>    spin_lock(&bp->lock);
>    netdev_err();
>       ...
>       macb_poll_controller()
>          macb_interrupt()
>             spin_lock(&bp->lock); // self-deadlock
>
> Previously, macb_interrupt() would read the ISR register first and safely
> return IRQ_NONE if status was zero (which is normal during a synthetic
> netpoll invocation), avoiding the lock.

yes, good catch. Let's move the printk() calls out of the atomic
section. This is the only place where it could cause issues, no other
printk() lives in the bp->lock critical section.

Both netdev_err() calls are deferred to after the end of the section.
We drop the netdev_dbg() call. We all prefer small & simple atomic
sections anyway.

> [Severity: High]
> Could acquiring this lock before checking the interrupt status cause late=
ncy
> spikes for other devices sharing this IRQ line?
>
> The MACB interrupt is registered using IRQF_SHARED. This means
> macb_interrupt() is invoked when any device sharing the IRQ line raises
> an interrupt. Since bp->lock can be held for up to 14 milliseconds with
> local interrupts disabled (e.g., in macb_tx_error_task() polling
> macb_halt_tx()), other devices might be starved while spinning on this
> lock before even checking if MACB raised the interrupt.

Yes, but we have no other way. Reading the ISR status outside bp->lock
can lead to bugs. Reading it inside can lead to increased latency
spikes. Make it correct first then make it fast.

(A past iteration proposed reading it inside and out. I wasn't
 satisfied and neither were reviewers. We dropped that.)

The 14ms topic is a pre-existing issue with macb_tx_error_task() which
we won't address in this series. I don't know in what case it could
occur. Anyway, sharing your MACB IRQ lane with a critical peripheral is
a theoretical setup that most likely doesn't exist.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

