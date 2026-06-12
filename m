Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED10366051
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257525; cv=none; b=PixAIDCqrSd5YsGGKw71yMZRy3bE7ZYfHS4+wcuQ9pkHF2eTzRlkmBXPbBOJtW7ANOovdNOHfPUnAv5K0R4eDrSdbfZ5n9JvaZl7Ed33G0o4FsHSbbm6obhisrGSNMJZZ2mb+q56Kg6yPbDZWr+T+y+BO8+KD1xYkvL0LLCTrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257525; c=relaxed/simple;
	bh=VTSxjxhmvNI4LbXuNGTgOAix0RfJAtVADEzWKz5jJZc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BxhUM2mRQC7EDnXsx6iEnF1jOezvGghFgZ92KaFhiZ0DKEojj6rLTU9Q8Cq245YR/nV+KiOdffpVK8G0rTlN6zpsHOgurtRKdL4Xv28mRC+ElGwnHuOWX72GKpdzkWreoj3cBJYcKG+qmh+xRiS2ZNfba8876QIQHMgmvEyX8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N3HmtAk3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N3HmtAk3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C63504E42E5A;
	Fri, 12 Jun 2026 09:45:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 901FE60012;
	Fri, 12 Jun 2026 09:45:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E170106C8567;
	Fri, 12 Jun 2026 11:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781257520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pAP1NcwYrXBK5Nx3wa/X8hgk6oZXZVKocwwn82WV4NA=;
	b=N3HmtAk35VsP1qgGAXQ1tHQqUkfLGYVvab9kzm6RjePDLDHVWsR+DE0xdfJ+P+QeAGdJHN
	ONqTwA50Fo3O5vGfbO3TA/mxy4eEqokbwcDTF+bWoXcsDXs8GNOemORaydA0cNY8zbtpoc
	6fazjWEcphMfwdq/KPYrvqSQ0lZTR3FO+UA+yJZfMSx19foIoEKI0ygjYzOpZJSfiurDTr
	Kr9GYnlaWFtNx+Grr6pxCNGetbXPdaEPJx5y3rfhZijw+4kGHygU+vLl08ALjhwfJNHGRX
	g0kb5TR0/LGkb1h6AS7rwKKX2vrDBmBmySVZh0AM2qKKPMOKGMkTlRuk8OjXcw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 11:45:14 +0200
Message-Id: <DJ6Z39C906LE.1F3XKDDM41UJ8@bootlin.com>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover
 from lost TSTART write
Cc: "Lukasz Raczylo" <lukasz@raczylo.com>, "Steffen Jaeckel"
 <sjaeckel@suse.de>
To: "Andrea della Porta" <andrea.porta@suse.com>, <netdev@vger.kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
In-Reply-To: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Andrea,

On Fri Jun 12, 2026 at 11:01 AM CEST, Andrea della Porta wrote:
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
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index a12aa21244e83..615da65d5d68d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4522,6 +4522,16 @@ static int macb_setup_tc(struct net_device *dev, e=
num tc_setup_type type,
>  	}
>  }
> =20
> +static void macb_tx_timeout(struct net_device *dev, unsigned int q)
> +{
> +	struct macb *bp =3D netdev_priv(dev);
> +
> +	if (net_ratelimit())
> +		netdev_err(dev, "TX stall detected, re-kicking TSTART\n");

Is this standard? It looks odd.

> +	dev->stats.tx_errors++;

I am surprised by this. `tx_errors` would ideally be one per packet that
didn't get sent. Here we increment it once per queue that stalled.

I have a series to address stats issue (and use netdev_stat_ops API).
It is a follow-up to this:
https://lore.kernel.org/netdev/20260428-macb-drop-tx-v2-0-647f5199d8df@boot=
lin.com/

Also this is per-device shared data and we access it without
synchronisation.

Let's drop this increment.

> +	macb_tx_restart(&bp->queues[q]);
> +}

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

