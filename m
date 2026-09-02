Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C339FCAE;
	Wed,  2 Sep 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337953; cv=none; b=TKxltc8NUgtenp/mzQciGEV9wDPXcmWoln3pV5fXxfz9vW8kqTzWXbmUmxCdGQuAKvwPsETzPmUX9NNcoAlvh+LxIe/0Tt69ADcetHiwRojlw4rkKG9HJsc+Gl7Yx8CCF7VeUcb87xG0Ub1Tkzfw6x7rjTqzPxVLVEfNPB5M+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337953; c=relaxed/simple;
	bh=ezKgrojVYa7NV8qx2djOQ2aLoukbAOVSGt/2qj1wvWM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CyHy+rQU+ZxAU2ReWdhp676t+S7FEHHDMei8Zh3KIQI0kE5SWMR55u4tQnTFxrRvhOrvMXbKJ9+F3Tu+lCmLqyhaLGT6CGuyEZ2r9TfPuYwJRsaSgsGj1raVF1hvANBY+trNkppo+jpXTVy6iqeJQMQmzQmVbspMa87Rs+NA0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QMXVjgy9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QMXVjgy9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0AD551A193E;
	Wed,  2 Sep 2026 08:32:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CFAD36053C;
	Wed,  2 Sep 2026 08:32:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E16511C79305;
	Wed,  2 Sep 2026 10:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788337945; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9siiNjXPf+3lQwXCdsGCE+5hGvyR9DC4S4y1EZ+6xDI=;
	b=QMXVjgy9052pA0iZPQdbYZd832rIZiuj/Hc7u/d1HxLRxw57fF2JEm13cxeRl8xkXPt4cO
	vK4TKVvaGLDQAE02rKg6EBCeCwdlKivwA63JwvDZoyESgW5VU2tfmhJl2ln0RXNNLPd+wy
	cKYWTEiTrdrpnfX9SvNeeF9HHaYpQtPGpjAQ28XkWS4FMU28N8owIsInvit1UkkbIJU09z
	gHZNLgQgjo09Edk5aKI+OBx5ixPfZuKL/FJssPshjDRM7Z9qG333AfOdZlH39U/fAQWHC7
	lsQHrRFGCbPX+qm8VygwzJVvDIHStGWQRVPapAEh6ZhN5EwAMLeQtCNoNhqyEQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 10:32:21 +0200
Message-Id: <DL4OW4OXWPGJ.201FKXDFSTRI4@bootlin.com>
Subject: Re: [PATCH net 1/2] net: macb: zero the link settings taprio reads
 back
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Russell King" <linux@armlinux.org.uk>,
 "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Aleksei Sviridkin" <f@lex.la>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260902080528.2211468-1-f@lex.la>
 <20260902080528.2211468-2-f@lex.la>
In-Reply-To: <20260902080528.2211468-2-f@lex.la>
X-Last-TLS-Session-Version: TLSv1.3

Hello Aleksei,

On Wed Sep 2, 2026 at 10:05 AM CEST, Aleksei Sviridkin wrote:
> phylink_ethtool_ksettings_get() fills only what the current link mode
> provides. With no PHY attached it writes port and supported; on a fixed
> or in-band link it also writes speed and duplex, but only if
> base.rate_matching already reads RATE_MATCH_NONE, a field it never
> writes itself and so takes from the caller. The ethtool core zeroes the
> structure on every path into the op, so its callers never notice; the
> taprio path passes a stack variable and reads a speed nobody wrote.
>
> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Agreed on the fix.

Could we improve the commit message? Point how straightforwardly the
case where uninitialised memory might be used, which is the main thing
we care about. See how the following is easier to parse out (for humans):

   phylink_ethtool_ksettings_get(bp->phylink, &kset) gets called with
   uninitialised kset but kset is not only an out-param. In some cases
   kset->base.rate_matching might be read.

   ... explain the cases in question ...

> ---
>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 76ee4f506033..a43855db1e45 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4297,7 +4297,7 @@ static int macb_taprio_setup_replace(struct net_dev=
ice *netdev,
>  	struct macb_queue_enst_config *enst_queue;
>  	struct tc_taprio_sched_entry *entry;
>  	struct macb *bp =3D netdev_priv(netdev);
> -	struct ethtool_link_ksettings kset;
> +	struct ethtool_link_ksettings kset =3D {};
>  	struct macb_queue *queue;
>  	u32 queue_mask;
>  	u8 queue_id;

Let's try to respect reverse xmas tree as we grow a variable.
I know it wasn't perfect before.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

