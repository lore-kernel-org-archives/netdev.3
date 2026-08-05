Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDA3D1CA5
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958996; cv=none; b=b+gR9FqUw+BCnWUMI7vOmy47zWffARC5pdSA/JJTFiFzcNeC8bYT7OTtjy0E1v8WE0nyQgP24CuIemKB3TwlVO/BGTkn5Eeh5fxOePdBRPRum2OpzR0T+98L6F7BGlaW3mubvkDDPCIb1AADFoN2QEwg697W2HcvQzeBo9/ydI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958996; c=relaxed/simple;
	bh=rbBsVuKLCmrsZL7ItLz2B6mXnD4jnBfd7ukVYSE6UkE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=qVhjRESICvgCoHM+JAUzkb7L4gLh49peTbQi3now6oJONpYAtqW4xxxD+KYsqF77d2N32DHmH2oAv+ffbQ6OCTovj3710PyK6zjMHsMaHeVukM6IDarCt2XoeBUbmgKCGDqrJXRLeDP3eYnuTJkM79MKML54+LLXDlZwcnQkyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ggg8R7ss; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ggg8R7ss"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1AD614E410FD;
	Wed,  5 Aug 2026 19:43:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E30E5602AB;
	Wed,  5 Aug 2026 19:43:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D65E911C34D71;
	Wed,  5 Aug 2026 21:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785958986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FSNibwG2W6FhqvWZ3S9upC7eG69NTSaHltnAWfgT70M=;
	b=ggg8R7ss8/JW5rAhr+Qr4hv5VkwkdGcmvctv9iYv8IDDTknlR1lFF/KzueYjjdM+sQN0l5
	qh3KnlCYKPdaQ5NzdrhvzzsL0ulr31kFMTt1qT0pymx/TGFyXqYr9+GStStVNJW0ysi1S1
	i7/UAyrfrfdJQmIkXnSACbOYrQCpLzqtjlch8wOwTJurimYE97tenhaKoRQ1++ay2xHOgQ
	XFizKARMwBYxQLTdCsG0i1+3d8fS8vRSvOT28A4tZ/K6gam20mlDPZL8kTW5mEUiFUXazz
	cYgVXZ6eeDoFxIMYJM7IFrz49Qc0fRwS7nEtAr9r24jSESH8iWu0DcpMLoN7Iw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 21:43:03 +0200
Message-Id: <DKH9MEANKO19.1B5B9Y1V1YEXY@bootlin.com>
Cc: <conor.dooley@microchip.com>, <charles.perry@microchip.com>,
 <andrew@lunn.ch>
To: "Nathan Whitehorn" <nwhitehorn@pa.msu.edu>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v3 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729192748.6928-1-nwhitehorn@pa.msu.edu>
 <20260729192748.6928-2-nwhitehorn@pa.msu.edu>
In-Reply-To: <20260729192748.6928-2-nwhitehorn@pa.msu.edu>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nathan,

On Wed Jul 29, 2026 at 9:21 PM CEST, Nathan Whitehorn wrote:
> When used with an offboard transceiver (e.g. an SFP), link state needs
> to be measured at the PCS rather than an onboard PHY. Poll the link
> state when the PCS is active to allow the kernel to detect link state
> changes in this case.
>
> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index d394f1f43b68..c15a9c7e69d3 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
>  	struct macb *bp =3D netdev_priv(dev);
> =20
>  	bp->phylink_sgmii_pcs.ops =3D &macb_phylink_pcs_ops;
> +	bp->phylink_sgmii_pcs.poll =3D true;
>  	bp->phylink_usx_pcs.ops =3D &macb_phylink_usx_pcs_ops;
> =20
>  	bp->phylink_config.dev =3D &dev->dev;

Hardware has an IRQ for that, would you want to use it instead of
polling? The user guide contains more info.

   /* Bitfields in ISR/IER/IDR/IMR */
   ...
   #define MACB_ISR_LINK_OFFSET  9 /* Enable link change interrupt */
   #define MACB_ISR_LINK_SIZE 1
   ...

I've checked with an on-board SGMII PHY and I get an IRQ once unmasked.

If you don't care, then:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

