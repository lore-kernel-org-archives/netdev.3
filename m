Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFF4921B1;
	Wed, 19 Aug 2026 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787162828; cv=none; b=JSS9JKTAIg7PjyOTLLRv9b8nLFbVApneyXD6VD9eXdWv37fGX4eUw8t2fyESbMeRJcNPCVTYtaCtKOSYSirv5ZFky26kGv4tMuo70NVzJgrMMABjmbTRVeja/xRIvtDfzNKk9GfIfTQ9HfZ1uSaRGme0vvg7nvZV8HWq0JypCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787162828; c=relaxed/simple;
	bh=wuA+/M1D4tVUocac/6KwaSqlkHwO90FUw0MnjVv/TuU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=FgxngYMaig6DdIsZkaiHmHOytG0vXP8wfVkv2VrV8/bzzLFUNUZZPA0NpujuY5KfNFF/o7hU27kwBNT7neH3kyNffRy9L6lKzLdIH4DxcPAfXgcK99qv+ajKcs+62/JLV1XI2akRlZ8BotYfuN5mIUCMGgcYKR4+UE0mBL+3qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xs1lIoqT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xs1lIoqT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 058284E412D3;
	Wed, 19 Aug 2026 18:06:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA9A15FF42;
	Wed, 19 Aug 2026 18:06:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1483B11C75A25;
	Wed, 19 Aug 2026 20:06:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787162814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UtKKwJWTWrF6YD1/aLXj9fOOKMtR2RBTpgcfToLoVvs=;
	b=Xs1lIoqTsJE2DuM9HIDg6Kc3CEgAmHyWA2kSeRttzNTMUYvV4dfoT4ZUmFBV4f46uMG37b
	8yEHAu+hWmvp1aCcJXksC2J9ziGRBocfuR7MIV2dQL5UbOtXEDoPV+02ppIjdcc4zKzb0T
	fPBuCLDhDdNLyVuhFwr+r69KYF5018g5ikpwXuQbneD3BWivZm4nlu8CZDUOCM4LT5dffL
	xz31gglFdzKvzqAciJYGS2v391o8WLIMEwUZdilyCQcIGmZMfADhcO4zKhq8AmP2Fp0MH8
	CZD48V/i+MLa4ukjfcF9bVdhbFs9ZeopB8AJYcrFVP4XNARbM4rpZp5s02FuRQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 20:06:48 +0200
Message-Id: <DKT4CBU8YB5G.2W0766H2NU6Y8@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of
 CONFIG_OF block
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Nathan Chancellor" <nathan@kernel.org>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
In-Reply-To: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nathan,

On Wed Aug 19, 2026 at 3:14 AM CEST, Nathan Chancellor wrote:
> Commit 5262eab9462a ("net: macb: allocate tieoff descriptor once across
> device lifetime") moved macb_alloc_tieoff() and macb_free_tieoff() into
> a CONFIG_OF block, breaking the build when it is disabled:

That commit message is somewhat off: the commit created the two
functions, it didn't move them around. But indeed I was wrong in the
location where I created them (argh I hate #if/ifdef blocks, especially
long ones).

Can reproduce using my host toolchain easily:

   =E2=9F=A9 unset ARCH CROSS_COMPILE
   =E2=9F=A9 make mrproper
   =E2=9F=A9 make defconfig
   =E2=9F=A9 ./scripts/config -e COMMON_CLK -e MACB
   =E2=9F=A9 make olddefconfig
   =E2=9F=A9 make drivers/net/ethernet/cadence/
   =E2=9F=A9 echo $?
   2

Here is an alternative fix proposal: let's drop the #ifdef. It will
avoid any future error. Almost all drivers have no #ifdef as such:

=E2=9F=A9 git grep -l MODULE_DEVICE_TABLE drivers/ | wc -l
7458
=E2=9F=A9 git grep -l MODULE_DEVICE_TABLE drivers/ | xargs git grep -l CONF=
IG_OF | wc -l
391

Yes, I know this means the match table land in the module in !OF case.
Almost everyone on the ML I've seen seem to consider that it's trivial.
Apparently it's even useful because some ACPI can match on compatible,
somehow.

Opinions?

>   drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
>   drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit decla=
ration of function 'macb_alloc_tieoff' [-Wimplicit-function-declaration]
>    5951 |         err =3D macb_alloc_tieoff(bp);
>         |               ^~~~~~~~~~~~~~~~~
>   drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit declar=
ation of function 'macb_free_tieoff' [-Wimplicit-function-declaration]
>    5973 |         macb_free_tieoff(bp);
>         |         ^~~~~~~~~~~~~~~~
>
> Moving macb_alloc_tieoff() from its original positive does not appear to
> be necessary, so move it and macb_free_tieoff() back out of the
> CONFIG_OF block to clear up the error.

Apart from the typo already reported, I'm guessing the original position
is the one from previous macb_init_tieoff() functions. Yes I don't see
a reason for the move.

> Fixes: 5262eab9462a ("net: macb: allocate tieoff descriptor once across d=
evice lifetime")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This does not apply to net currently but I assume net will be fast
> forwarded when net-next-7.3 is merged.
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 64 ++++++++++++++++----------=
------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 1476bce77f34..96a7e7777e62 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2776,6 +2776,38 @@ static int macb_alloc(struct macb *bp)
>  	return -ENOMEM;
>  }
> =20
> +static int macb_alloc_tieoff(struct macb *bp)
> +{
> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
> +		return 0;
> +
> +	bp->rx_ring_tieoff =3D dma_alloc_coherent(&bp->pdev->dev,
> +						macb_dma_desc_get_size(bp),
> +						&bp->rx_ring_tieoff_dma,
> +						GFP_KERNEL);
> +	if (!bp->rx_ring_tieoff)
> +		return -ENOMEM;
> +
> +	macb_set_addr(bp, bp->rx_ring_tieoff,
> +		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
> +
> +	bp->rx_ring_tieoff->ctrl =3D 0;
> +
> +	return 0;
> +}
> +
> +static void macb_free_tieoff(struct macb *bp)
> +{
> +	if (!bp->rx_ring_tieoff)
> +		return;
> +
> +	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
> +			  bp->rx_ring_tieoff,
> +			  bp->rx_ring_tieoff_dma);
> +	bp->rx_ring_tieoff =3D NULL;
> +}
> +
>  static void gem_init_rx_ring(struct macb_queue *queue)
>  {
>  	queue->rx_tail =3D 0;
> @@ -5507,38 +5539,6 @@ static int eyeq5_init(struct platform_device *pdev=
)
>  	return ret;
>  }
> =20
> -static int macb_alloc_tieoff(struct macb *bp)
> -{
> -	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
> -	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
> -		return 0;
> -
> -	bp->rx_ring_tieoff =3D dma_alloc_coherent(&bp->pdev->dev,
> -						macb_dma_desc_get_size(bp),
> -						&bp->rx_ring_tieoff_dma,
> -						GFP_KERNEL);
> -	if (!bp->rx_ring_tieoff)
> -		return -ENOMEM;
> -
> -	macb_set_addr(bp, bp->rx_ring_tieoff,
> -		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
> -
> -	bp->rx_ring_tieoff->ctrl =3D 0;
> -
> -	return 0;
> -}
> -
> -static void macb_free_tieoff(struct macb *bp)
> -{
> -	if (!bp->rx_ring_tieoff)
> -		return;
> -
> -	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
> -			  bp->rx_ring_tieoff,
> -			  bp->rx_ring_tieoff_dma);
> -	bp->rx_ring_tieoff =3D NULL;
> -}
> -
>  static const struct macb_usrio_config mpfs_usrio =3D {
>  	.tsu_source =3D 0,
>  };
>
> ---
> base-commit: 61eb236c41c2a4717015dff18016a75a5eb90052
> change-id: 20260818-macb-fix-no-of-build-eee72c7cf20d
>
> Best regards,
> -- =20
> Cheers,
> Nathan



Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

