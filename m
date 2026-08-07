Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58033DEAF6
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117357; cv=none; b=QWv/Tpb54GcEvbfCX5wMJfHec8O6c42KrPj4CxMYtu3ThpV9nXUpzZJzf3eg1XnipA9TvCsmLnHr33iZVPScSnL30o23VtRC3HvsfIblBVxRZOAFMU1t9RH2JPOaj9Ww6T4SY81mQdSZikRdahdJ9jCGmI4fV6+qycLUNke1nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117357; c=relaxed/simple;
	bh=/DwQxZKYxzKAnM6uuKzFN49aYnPpfitMqho+GHllLuQ=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:In-Reply-To:
	 References:MIME-Version; b=gt78d+/jGQpFINi+lahMLmVP4LTp41Nby6CYftGI5qSLD/wCPvQz+UmaUVtYmciFCHr77qvoLlOTAHSqaJ2cYR7KQCYAkFntXEam5jVFAbacsx/h6Qoae9lzZltkKufsYKAAq1ox088GQuAnMaiPvD+YtZ8OPMk8yTU7uRyUTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uwk0OhfL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uwk0OhfL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 33EAB1A14B1;
	Fri,  7 Aug 2026 15:42:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 065A9603F0;
	Fri,  7 Aug 2026 15:42:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AD9511C37AEC;
	Fri,  7 Aug 2026 17:42:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786117348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l2EM1qVTp33IEaKssMbVFl9I2kU8kggJOlpOnse3fiA=;
	b=uwk0OhfLTx5g/AwquTM5Rdzvmh3o6uTgWM6AsmiIomZKl1lCFJeRLQ7NZkCV8DSriQHp1E
	KyruN4gpqQz76/HfBVLKlAMuF8Jk5PdDrNszPTZLyFYGyHHc2wlNscjQieELV1e8dzzI3B
	qSHM8TK/64sk+363wutHlfy36J9ErjypoftWqJqcK19+TbOzOOg26g/HA/X4MaESrYjV/K
	5N3dyl/eLl5dnz6/+onr72/HSMb6L76pDnOFO+HS1qIA9nzBPIn/N4VgRGsBSNmiI/psjj
	C5+Dy4l53CK4ii0cyfWa4nfD5f18EY7tI2m8YMGnU3WtIDRdwn3oY/TcxYWujw==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 17:42:22 +0200
Message-Id: <DKITR7P2JKLW.25D186XX8LZ7N@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v8 15/17] net: macb: read ISR inside bp->lock
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
In-Reply-To: <20260805-macb-context-v8-15-bc302ffd1174@bootlin.com>
References: <20260805-macb-context-v8-15-bc302ffd1174@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: eRxBDf4bev4+
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko
https://sashiko.dev/#/patchset/20260805-macb-context-v8-0-bc302ffd1174%40bo=
otlin.com

> commit 2dad125ac3428043e94f084f940a4694a6830209
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: read ISR inside bp->lock critical section
>
> This commit modifies the macb_interrupt handler to acquire the bp->lock
> spinlock before reading the ISR register. If the ISR is empty, it unlocks
> and returns IRQ_NONE, rather than doing an unprotected early read.
>
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -2193,12 +2193,13 @@ static irqreturn_t macb_interrupt(int irq, void=
 *dev_id)
> >  	bool hresp_err =3D false;
> >  	u32 status;
> > =20
> > -	status =3D queue_readl(queue, ISR);
> > +	spin_lock(&bp->lock);
>
> [Severity: High]
> Could this unconditional lock acquisition cause severe latency or lockups
> for shared interrupts?
>
> The IRQ line is registered with IRQF_SHARED. If a shared device triggers
> an interrupt while bp->lock is held elsewhere, the CPU handling it will
> spin in hardirq context with IRQs disabled just to return IRQ_NONE.
>
> Looking at macb_tx_error_task(), it acquires bp->lock and holds it while
> calling macb_halt_tx(), which can poll for up to 14ms. If a shared interr=
upt
> fires during this window, won't it cause severe system latency?

Exactly same review as last iteration. See my reply here:
https://lore.kernel.org/all/DKH4YK5JVVNB.1XC12P899ZJOP@bootlin.com/

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

