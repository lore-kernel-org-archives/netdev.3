Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2443DA56
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622974; cv=none; b=SU9fl+mNDLOsEQ+bZEB1OHWO6FD28YscuBsErx+USXZgAXG+3p4PTArDuBvvDsUdOj+Sn2iRy7rG8RjHvNm/rOlQryuf2rCPkvvpbsj5k+V/4DlMInK2AWlY8WPaZ/2UHgakop/6M2qCLp2PiYiiMM1YnR5DtavduD9IVgAGG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622974; c=relaxed/simple;
	bh=EBs7aK9Ax6fMaFCay5iPgFUdd3Tp5vEneucNpM5vdFM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=btA9AEQD3oPDG+68BMCMsO+e0//SOuNHzOv3YYAS2lGg0RaIQ85FhpRkeXA+BVHSgphMek5/sZo2VVJ8sabnwlRnvhnDvmFO5GoXyV57DQamWV8ZahGdH1nGGx+qjMigqtaRnexE+KjwlwYSzlBbbr074Tl+ndFZREe41q+8yVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NVv3zrua; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NVv3zrua"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 114054E42F1D;
	Tue, 16 Jun 2026 15:08:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D096B601A9;
	Tue, 16 Jun 2026 15:08:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEA1D106C9EBE;
	Tue, 16 Jun 2026 17:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781622479; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EBs7aK9Ax6fMaFCay5iPgFUdd3Tp5vEneucNpM5vdFM=;
	b=NVv3zruaGYxD6uLc0Dkz0jkCucJNGC7apCS+4WPn2sVbSFDx2QGIYsz261nmI+KsXjmz6C
	KPHnro43cSEKKy2lbClsVYbRKSOLJJwjav+H+tvFIelYyNA1APl2ElxYXKrp58GcZtNNT9
	0/xnKQyZWDnb0nQqGI5kQVH+bLnFji5CX1PmxXrpqllh56i1F49ui10N5G+WqtfP1nkXL/
	8ptRGhQhgawEHVGSyGYwvTcbdLp58+T88NcQx31GPXc53ycBQy3ZUkkyvUAx+kndq2r05h
	z2w9pUPkCscZ3sxtvljDmyUQz91sy1Ur4jImarFbfRLL3l5xUYAMq2SumoiVLg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 17:07:54 +0200
Message-Id: <DJAKGHKZGUI2.29AHYNFX4LGBJ@bootlin.com>
Cc: "Lukasz Raczylo" <lukasz@raczylo.com>, "Steffen Jaeckel"
 <sjaeckel@suse.de>
To: "Andrea della Porta" <andrea.porta@suse.com>, <netdev@vger.kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>, "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2] net: macb: add TX stall timeout callback to recover
 from lost TSTART write
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
In-Reply-To: <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Andrea,

On Tue Jun 16, 2026 at 3:23 PM CEST, Andrea della Porta wrote:
> From: Lukasz Raczylo <lukasz@raczylo.com>
>
> The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
> the TX queue.
> While the exact root cause is not yet fully understood, it is likely
> related to a hardware issue where a TSTART write to the NCR register
> is missed, preventing the transmission from being kicked off.
>
> Implement a timeout callback to handle TX queue stalls, triggering the
> existing restart mechanism to recover.
>
> Link: https://lore.kernel.org/all/20260514215459.36109-1-lukasz@raczylo.c=
om/
> Fixes: dc110d1b23564 ("net: cadence: macb: Add support for Raspberry Pi R=
P1 ethernet controller")
> Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> Co-developed-by: Steffen Jaeckel <sjaeckel@suse.de>
> Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
> Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Thanks for this V2.

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Any news from the Raspberry Pi community about this bug investigation?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

