Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F73403F8;
	Wed,  2 Sep 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339446; cv=none; b=ghetIWs8kS6h6eQpcBaj7pQRCtZsE5VEVWjJ+zqNaVeD172XOCSfd8PFFXGeGycXkdhbgIgs/7V+GRJvlf2b66f9VZOSiJPI65HQBiLMk8he/+OikY0hd0wlwpeiMikogvSIZ3mSwcxSyjxY71wE2+e6TEx+Q6BfJnfLqqI2Jbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339446; c=relaxed/simple;
	bh=ugUmVFqIlyiwWs3F+/7/VpAihfisZSjsLOtvx4nQnO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DGhGqjQkSf925onbT8WBI4wS42JU4c5oerN2Rs4rV/LVDTL/6rzMHD/enkEpH24RjVjstbbYbw7AFDe2WK5DeFSk7oaQ9wOvCcubAnVDoytpVE7xa8Ay/DKdd0/ug+aHoBhgh3WeGVgkj1cmEr4nO9w56Qec/5PjZ2hq4rzHnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfHY6NH7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfHY6NH7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8727F4E413FA;
	Wed,  2 Sep 2026 08:57:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47FE46053C;
	Wed,  2 Sep 2026 08:57:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E844111C792AC;
	Wed,  2 Sep 2026 10:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788339440; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pFMEBlZiHa5AAryB2iJjAAYY/vDsG1dvPLc92WL5Eto=;
	b=VfHY6NH7fFS6uu5iclC5kpSW3Ye/hWxLLQzVZrrUPPu9RrurxjRvY9JnmP02PxSwIyom8f
	PAuXEGlww2RGNZGxPpkLJkoYwG5uRgjoEwhmfPUqphGv2/Bjl45ISIFKd7QrbmXJIVjL7f
	LNz7CxoPOhOiWF1bWB5FoQkOaKJVk8TKY6cyHrPWvqs8qQkKzT55Jg9IuXzmrOMQqG2d5X
	vcLykRf662SZqS8oUAkuzwmq/0E9gDJO59rMY+VagM2VGptCVeVwj6WacbNLpBPQlCcPwi
	8tISMtPWqV+c3bZS6X5Qtss4RmoG/ayeUz9pgY7S/me7QXJl5OGr+JFFcq0sig==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 10:57:16 +0200
Message-Id: <DL4PF7CMPTLQ.7BII0H280PHE@bootlin.com>
Subject: Re: [PATCH net 2/2] net: macb: reject an unknown link speed in the
 taprio setup
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
 <20260902080528.2211468-3-f@lex.la>
In-Reply-To: <20260902080528.2211468-3-f@lex.la>
X-Last-TLS-Session-Version: TLSv1.3

Hello Aleksei,

On Wed Sep 2, 2026 at 10:05 AM CEST, Aleksei Sviridkin wrote:
> speed is a u32, so SPEED_UNKNOWN arrives as 0xffffffff and passes the
> "speed <=3D 0" check. A taprio schedule installed while the link is down
> then has its hardware interval limit derived from that value, a limit
> that rounds to 1 ns, and the first entry fails with a misleading
> "exceeds hardware limit". Name the case instead of relying on the
> sign.

I don't understand the

   Name the case instead of relying on the sign.

sentence, it seems to contradict what really happens which is

   SPEED_UNKNOWN [...] passes the "speed <=3D 0" check

> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index a43855db1e45..81530b9257b2 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4324,7 +4324,7 @@ static int macb_taprio_setup_replace(struct net_dev=
ice *netdev,
>  	}
> =20
>  	speed =3D kset.base.speed;
> -	if (unlikely(speed <=3D 0)) {
> +	if (unlikely(speed =3D=3D SPEED_UNKNOWN || !speed)) {
>  		netdev_err(netdev, "Invalid speed: %d\n", speed);
>  		return -EINVAL;
>  	}

The zero case shouldn't happen, it's SPEED_UNKNOWN that can occur often
(on link down). It's basically the same as checking netif_running().

Doesn't the netdev_err() call deserve a fix in the SPEED_UNKNOWN case?
We might be printing "Invalid speed: 4294967295". I don't think we want
two format strings (0 or SPEED_UNKNOWN).
We could do "Invalid speed %d, link-down?\n".

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

