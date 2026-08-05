Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732DD3A254D
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952767; cv=pass; b=DLsHLApS/mAFlua1F9ps3Vge1PKm5nXGWVHeXs4ZKZqaQX4e/3WeuvByowgUcVrZml1PZl1OJigEtkI9S0KRsama2L37FZwG4ACSsK/cBKPCkRWcCg3asADlkBkZLz4BhXLGpYQuI2X9ntKEWb0yV3NT0yZHD2JaY2iXnqkUpQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952767; c=relaxed/simple;
	bh=aeYSQT3FXjaOBvh0uMd55x+rlChxsaw1A+rLw4jTkg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc0/oWz2YZher4cc0j/bjdeGv1s1KjPu+wn6TPiy1/CRiVH/j+G0gULQ51jsqczeIBRBH51fNfc52mx0J6sZ7GtzmwtVkG0cohjChScMCY/i+kVH7j04Y8QnHk+nt5erGjCdupSmTA7SNfJsqraTwQ9fmsWHMFM9kj33Lq05zXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+HqCdi2; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+HqCdi2"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66899c7b57bso1729754d50.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952765; cv=none;
        d=google.com; s=arc-20260327;
        b=NxaAnGmB84wQjg6PRorhDWtF5CDs07DrFNlAIp1CTl3yTWhweIrWfUi+z9jNeJ3sJg
         E9tQLHF3VFzqiIoAFEjMiAw6rpkiiy5Rjsd0Z+ilPCY2VPCLDIyxQ1wqrXDov0fwuDOz
         t6G+fyIED7vcwK3sOBGQuVD1qnVe7fAXKYIRM8i9iCUci722dog1r32bWWIrCWtt8GF0
         rrX0z81ui5LGHMuXb6v3kI0WnMnjZAZaYkV9dTVln1nTNwCGPnnj1r16fnMOP0udLF1H
         3sg/yIS3j9yPQqX9CLsrL365+Fgh5ZPplEiWo4Q+t/t532OiH3c4oNzA+Wi9xjpeRn6Q
         +vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+wyTOsOhMbrjsG5p+fyN9W7BAiLbQ+uysDt19/fvIFY=;
        fh=RN2s/FuU0Ja6XwUeYmFSg10h88btNmpyVen9UKeyin0=;
        b=XmgBF06eRL7ow9769uPTiWAmkGsb3XszcphfiN243+C8IwToGMcO69nc2A1an163/S
         Fas9xzNdptDwWxmT5KuEG2QN04Vgf4ugOi5xyQPnHhQ4HpvKk4Ztoe7RyKw6QEsQl1dF
         8mRpy7ox5da82MFsez9I0J2eu3u66mn/R80DCAObgLgcWpa1biDn+V3zbOBJrjuryymc
         244xxDQ12PLIZarmNgu+0xM4vttpi2R9kSAB5/3UewzOY58orkfYuzNfZ9gZLpxp9rJ6
         4dOQuEx3FnOXaI1h5Buy8IOpfV98/ZIyq2i8UoBSKgWFzEpz7Tg4mEodEwZplW/8XPT/
         z4Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785952765; x=1786557565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+wyTOsOhMbrjsG5p+fyN9W7BAiLbQ+uysDt19/fvIFY=;
        b=G+HqCdi2KCZ1RyKwjaUjedik8DMtvcSVnDKACzPYij+NAnj4G03ZN1L/F2YY9ZhnwY
         VByCmVSARhPR1k4eethJAldbN61B8g2s25NOQo/h1LXPPihry1Y66c0dhwm0vFKaYIWm
         C4+Ki0YgLQDnNOxMORVdpNSFDErOG6PcWveAUk+5wjq2CdfetlmE4YBM6dmEP+XwEmKc
         FiAixSkRCLfKie9YyFoVhmNgZyBtcw7ioIKv7wk8s9DRSlQYw4GE3shZsVCqnXAWuh3U
         ex07uJ5vA5Av3ARY7VfDapRaWw7+6Qlm3uCBzr5rliHcoCg4j6omFf6j2n+gKHSQKiK4
         i8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952765; x=1786557565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wyTOsOhMbrjsG5p+fyN9W7BAiLbQ+uysDt19/fvIFY=;
        b=dueX3B8Q17dKMDp/J257UCgaqbNqjXFngz5YsR1WnHKcBWCMVmdXn4P+OGrJhSWzoK
         bB4yE59L9S3dF2S46jJrBnwYwy1mHtb4tiUrwCdPf9BJY2BYzrMhsDlhIxSLNemQR9St
         5rhNF85ZMu4k4sj9yxZWzS3qDsI3TsHz1YbDdy/Zdv9p5b2BC2KN4odT8rpUuRPZlGs2
         x2v7yXAayhYrTaoAMwte+WGfXLr5XCOf4mqQTp53x9WHQD31tyMbklyBV5iN/GcF0vmI
         pik5FEO4GvYrJIDejK4hDjr/6G3382ViYenrxVRLWJJtl1AkWM1ONhn+RkcmMaDA6GV7
         finA==
X-Gm-Message-State: AOJu0YxCJeoNZiS7DblFyhK+xjaKcosa1F9dXKUotJ4F0W9iNU7xjWe4
	6pBR/x//cAs8Cikh0rZhn5OuPyEpUrwds9Im8W/zl6wM572K1r90p42BFmlRxijKlyX0kSfnF3i
	NxPhyEJcJLUyuv/3UasSNnOSRoGBtqjg=
X-Gm-Gg: AR+sD10wK4/9rrqgjgvLQJw17vcHYz0g6dI05oh8Z7VZ2NMEBHuwzElhStBXmEJ+I1s
	Dhv3ygq4V6tJHpDkjxEbEjWjayOPyM5nJYpVlFk6URFG3IChNY7srTZfTzopPOgkPDZ6KV15TNb
	QXWu1qIsU3q8X0u7jlOhfNkTqsVnFLRdiBm76nuFLjOLmS3kHlALrLQBn9NQjltrZOo5YMGJMVf
	Qeg1+kj8ELiBSUwA8lGbarC40r8tT84xajX0k1+5Bpb569lZOGDXMiwMNSEQiWd2PM6VzaAOsg/
	/7Qb9IyPrLtECYKgug78Fm5eoPbAEVm/f5YDCDxkEfAHe1eJZcsyrirujbkrlbppZmFDEI5sFao
	v3EqDlwZur6DwILuGfA1SZqy9iZjKIRp9i0dmmSqRmfE5jfxXYaAGsObGxmTbTP7I0rxw0mUiFB
	5EfUxJGRPs
X-Received: by 2002:a53:e7c8:0:b0:667:e8a3:ebd4 with SMTP id
 956f58d0204a3-6699aa3f5famr3962930d50.4.1785952765402; Wed, 05 Aug 2026
 10:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729202953.704662-1-rosenp@gmail.com>
In-Reply-To: <20260729202953.704662-1-rosenp@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 5 Aug 2026 19:59:14 +0200
X-Gm-Features: AUfX_mwH7OW5X0tcQwIjhHMnkD54dcsOFADG303XCg3R58NG3i8hEI2f2Jf_ybY
Message-ID: <CAOiHx=mdMQ-uZCUW16ynrJcbp555tWq=2b5wMMZ8hQQm6PD31A@mail.gmail.com>
Subject: Re: [PATCHv3 net-next] net: dsa: b53: srab: propagate errors from
 init helpers
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2026 at 10:29=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Convert b53_srab_prepare_irq() and b53_srab_mux_init() from void to
> int-returning functions so probe failures are properly propagated.
>
> b53_srab_prepare_irq() now returns -ENOMEM on allocation failure and
> -EPROBE_DEFER if any port IRQ is not yet available.
>
> b53_srab_mux_init() now returns PTR_ERR on ioremap failure instead of
> silently ignoring it.
>
> Check and propagate both return values in b53_srab_probe() so the
> driver core sees the real error instead of always reaching
> b53_switch_register().
>
> Add error handling in probe as a result of b53_srab_prepare_irq().
>
> Move mux_config out of private struct. This was needed when devm was not =
used.
>
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v3: move mux_config to function.
>  v2: address memory leak in b53_srab_prepare_irq().

Please also mention any review comments you addressed in the
changelog. I don't see any mention of changing the condition in
b53_srab_mux_init().

>  drivers/net/dsa/b53/b53_srab.c | 46 ++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_sra=
b.c
> index b9939bbd2cd5..81bfd5cd1022 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c

(snip)

> @@ -622,6 +628,7 @@ static int b53_srab_probe(struct platform_device *pde=
v)
>         const struct of_device_id *of_id =3D NULL;
>         struct b53_srab_priv *priv;
>         struct b53_device *dev;
> +       int err;
>
>         if (dn)
>                 of_id =3D of_match_node(b53_srab_of_match, dn);
> @@ -651,10 +658,23 @@ static int b53_srab_probe(struct platform_device *p=
dev)
>
>         platform_set_drvdata(pdev, dev);
>
> -       b53_srab_prepare_irq(pdev);
> -       b53_srab_mux_init(pdev);
> +       err =3D b53_srab_prepare_irq(pdev);
> +       if (err)
> +               return err;
> +
> +       err =3D b53_srab_mux_init(pdev);
> +       if (err)
> +               goto err_irq;

Tbh, I'm not sure if it is a good idea to abort probing on error here.
The mux only applies to 2 of the 6? potential ports, so at worst those
two ports won't work, but other ports should continue to work fine.
And I think reduced functionality is preferable to no functionality;
with a non-probing switch it will likely be harder to recover the
device.

(The values read out from mux could even just be passed on via
phy-mode properties on the ports in the device tree, but that would
require changing the driver ...).

Best regards,
Jonas
