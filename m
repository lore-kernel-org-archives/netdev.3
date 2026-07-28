Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B513BBFC2
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225564; cv=pass; b=dT19FdBUD+NyRgYD1hP1VaG5PGKeRvxDi/hZr4YqVGmoLuuiWElUNkQQibv1ki3Ke79De63uevJDu448P1NoH1hKVkNo1fcUidJkxjsA07cBZFVaXyy+SGPE7Saksre0FBWG2Au24xnTm2l2FSX1+01xBbAsz10RMMxmU8glUHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225564; c=relaxed/simple;
	bh=Vu771L3KJgqpqegeR1+C5GwNLHjiefhQGf6WSAOh8p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9eYwGoixFqcf9H/k1MIQsmkK0qpg+20g4tgDRUd2p5MPRfg8mgibdB7NepTAUTV/IUeJlKAZTmvZIPoYUC4Q8Njn5juddBxrDISRqVkAE4ns4MOiA5Pt261Bn38BHXIAfywqgJXjHu7xIvyTylw06+6mqud1WYUB8CdEerLXP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxMIDlJ/; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxMIDlJ/"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66843304cbaso5353899d50.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 00:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785225562; cv=none;
        d=google.com; s=arc-20260327;
        b=jndcwEyrr4I6KyR8jDRKple5zeFY5uGzDBv47Xu9oCDW7vTZ9HculkYWPYnBNc2SiK
         FjJlI2SM5QoWn+64D6EvZDrgGFq4ARF7u5Kpl25etPTAfIJPRJvWjiSFaYaDFKxiZTSK
         v2qktVom5TP0JaMS11sYePiCficlzo0Rxan0d46v+gC05V5TWrNxu7zceQHX24cvjSQv
         sGhHaB0Sz45gdwjHjV1o5SrtWMznvlGzjkX3lGLcUoP1iwnGJlxd3myq5tIPLz1/0WyS
         TP0+vz9VJoBSfGHOTtaKcMV9mnYqXHVa4u/Ln1QOmS00pO2Gt6Kjgxrh9+ojXhxA8os9
         UYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kETMsb7b06jRZi84F/ghO6+rlpZsWnET42JFE4apTQw=;
        fh=RN2s/FuU0Ja6XwUeYmFSg10h88btNmpyVen9UKeyin0=;
        b=SRUAlmi2jkvneKkw93Qc3PFZiwz9w3s2RbyHfmXyPfJfMZUaymRUBcDTByiex6+iTs
         O793VDkDQ4+rrphqVhcjYm+LYeDjCp8w8COJfR6Tl8rpszHuikdVjqQ0UqUeAL3Y4n7d
         /qmUaWOa96O9xgDBZ0tmJIrU7poBWw5UhBcsvv9MmOv3tWW+wAFB6dREuNpc+a1t/mrh
         LFhx+nqx70zFIyhB23SZm2W+D4dVWsDS7wcVO8OAu2sxpj91s0L2I+Fj2S3YhbaoYdA6
         aeVhvnedUrV95DGE767xtZ/z9fxzIZXbrbXvSR391/6SBh/B2l+LAgCjjt9MCDSZIKYr
         jfPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785225562; x=1785830362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kETMsb7b06jRZi84F/ghO6+rlpZsWnET42JFE4apTQw=;
        b=QxMIDlJ/4VeIiJNVvRwpaaDT/6LPRBRZqGREH5d2XlYTBOkfHldWXwIz50o/5SLALC
         lFomCUWN4aN287hDzBDZYvv060lMFZuA4AIn9SLLeZzqmDL8o8hEfsAwlwcvcM0+d+Qs
         70BGNBnCyufQXx3uoYGEXWWfHoZt6KYttPVDE4j7N76qvo9bSelZv5JwktRP2iDgZ2Fi
         +/DkTTqbKXzNFGCmqX2eEWv6YX5cmbZHKOf2Af6/9Wrd9N+l4iEML/qpUvZbecfs5+/h
         IMPAH9ih2Ek/LFRq/dg7mutnNgtvZlC9P06iTzUPZcZVVtBEQkG87Mn8cEexHrcUtjt7
         fHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785225562; x=1785830362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kETMsb7b06jRZi84F/ghO6+rlpZsWnET42JFE4apTQw=;
        b=qdWaKz/zaQ8eaKFNlcaLCcu7e9CmgkGtkYIERXnM9MKp+FH9NcVnFpUgR9Xeahb+/W
         prqnT6/kXGz2ePdxAkPVF+MldLdfsnZRsoOs4SzsWNKRNCYimyH3II8ums/7ofaWNqll
         THroXNqkPsaA6CZbNXDN9oQhqDt48BQNkcvM/T3lvT2wymmJ73TrhE3xaRfk0gPmi55n
         xp5ND9tSvNTTMMNbtRr3KBIWq/QEiwqZ6nE6f8HHATQRdTBViII3Dz577rqdSek48Abd
         X58CFKWCz3H2yYBW4ky75psLj+YkRTQbn+J+W/Ja/WNvwUBnJi6UBECSnP1ZGyzquMvK
         LEoQ==
X-Gm-Message-State: AOJu0YwdXytwSTtwg6phomoXFeo/b/nJuWuisKMtRQ7K16iS93wUCf0o
	ywclcLESJyu9GZT2U0bvZPvaC1VMsVBr7Qu3/h7AQAJg5E0OkMMpcDSCKkMXwV6ApTxNhOQU/bC
	meOSDq7ki6y27TFtxXzWDwVq/sxddPXE=
X-Gm-Gg: AR+sD1266SsyxOhlMWwiHLvR9ny6pX6QeuOBSjr1AXU7gQoXJtBd8ZQvYO3qvNyofiM
	1yecaxQqZA8BXw1koICdKOBCjfQL4Aik1RmdV48rG3vdzVsq9p3o/o7Hg5TAfFt3cBQVTn2jKXn
	dxfU1C8M6suEmN9Hrd65qEqouZoQ3QscSTTC4vwWE2q1ioGz0kn2m+fV4eJE9+yVIyu2e+blnX9
	v7T8Grb9/esWxa6537t7HLHkC88cSaeWqf15kZRSxqVmP5Qk7DP5ivr+JoaD1P8Jh5K0dl83IE5
	KZK7naoiVdnW126S5CaaoDhmazdh21xFbs0eYx7BMvFBBw==
X-Received: by 2002:a05:690e:c44:b0:668:96a9:e6e with SMTP id
 956f58d0204a3-669056de542mr387414d50.40.1785225561762; Tue, 28 Jul 2026
 00:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727234049.287278-1-rosenp@gmail.com>
In-Reply-To: <20260727234049.287278-1-rosenp@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 28 Jul 2026 09:59:10 +0200
X-Gm-Features: AUfX_mwyxGjI9HtjR4oaiXEJKRoeefefYLVLUr0R8POboGMh13I9FoOw80K6qGc
Message-ID: <CAOiHx==kU-CHtL07OfQcxzOjdnzYwhO7MnS+WD8wcCRC8Ce84g@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: dsa: b53: srab: propagate errors from
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

On Tue, Jul 28, 2026 at 1:40=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
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
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: address memory leak in b53_srab_prepare_irq().
>  drivers/net/dsa/b53/b53_srab.c | 36 ++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_sra=
b.c
> index b9939bbd2cd5..289504321f3e 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -531,7 +531,7 @@ static void b53_srab_intr_set(struct b53_srab_priv *p=
riv, bool set)
>         writel(reg, priv->regs + B53_SRAB_CTRLS);
>  }
>
> -static void b53_srab_prepare_irq(struct platform_device *pdev)
> +static int b53_srab_prepare_irq(struct platform_device *pdev)
>  {
>         struct b53_device *dev =3D platform_get_drvdata(pdev);
>         struct b53_srab_priv *priv =3D dev->priv;
> @@ -551,18 +551,22 @@ static void b53_srab_prepare_irq(struct platform_de=
vice *pdev)
>
>                 name =3D kasprintf(GFP_KERNEL, "link_state_p%d", i);
>                 if (!name)
> -                       return;
> +                       return -ENOMEM;
>
>                 port->num =3D i;
>                 port->dev =3D dev;
>                 port->irq =3D platform_get_irq_byname_optional(pdev, name=
);
>                 kfree(name);
> +               if (port->irq =3D=3D -EPROBE_DEFER)
> +                       return port->irq;
>         }
>
>         b53_srab_intr_set(priv, true);
> +
> +       return 0;
>  }
>
> -static void b53_srab_mux_init(struct platform_device *pdev)
> +static int b53_srab_mux_init(struct platform_device *pdev)
>  {
>         struct b53_device *dev =3D platform_get_drvdata(pdev);
>         struct b53_srab_priv *priv =3D dev->priv;
> @@ -572,11 +576,11 @@ static void b53_srab_mux_init(struct platform_devic=
e *pdev)
>         int ret;
>
>         if (dev->pdata && dev->pdata->chip_id !=3D BCM58XX_DEVICE_ID)
> -               return;
> +               return -ENODEV;

I don't think this is correct. If you look at the b53_srab_of_match[]
table, only some srab devices have BCM58XX_DEVICE_ID, so returning an
error code here would break probing all other srab devices.

Just returning 0 here is not enough though ...

>
>         priv->mux_config =3D devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(priv->mux_config))
> -               return;
> +               return PTR_ERR(priv->mux_config);

... since some devices don't have match data, so their pdata is
unpoulated and the above check would still allow them, so they would
then be rejected here.

So the above check should be if (!dev->pdata || dev->pdata->chip_id !=3D
BCM58XX_DEVICE_ID) return 0;

Best regards,
Jonas
