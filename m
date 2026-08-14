Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D8335066
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740762; cv=pass; b=DuXciGDqlnx7eZ6mNizfR89VjE1FcScrUG5NtHxUC4l4vXDJUQqgOLsI1xxEfLw6Ct9jEIZ0p3S5pABaGa1h5e/xu2YDLIk4jBNj7LfOUwqS2+MhCgPTUq8Okmv9nhjH40YP/o5Y+BguOdyL69tsLEdY8izpF7QbMWGfUbqOWHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740762; c=relaxed/simple;
	bh=sCXphBC86pYZZvHSb0Fr8gFS0TiY8BtblF7I6Bksz7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoJ4Ca3kTwILgOKpVTESSRqALCjnsA7ooHY64pwW2SYs/IrI6Wz+cVt9a1p0OIjZnlt8BELgKCeBHzatii9dC+nhFHYSLwMyTfL2S3iO4cmb9u4FiOPtT6Q6L+tfoMFwD2qGNcV1hM/QM2/38XtgshXEvhk14s0LxpIkuO6OLaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THsSwmBm; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THsSwmBm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2020421077so259748966b.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786740759; cv=none;
        d=google.com; s=arc-20260327;
        b=KVgW1W4xGgyNcAhaZdRN442adVuNlH+lHWurlY1TcS9LWZTdKVvZ5zsT7KmficSU0h
         b7qihb1AhgPCaaDT3V00u2Bakgk9BeY3JJjNvlIE6qWgGrfi1XvlcNhaB53vq43mxRD8
         DSyI0P/3XHUfb70QMMUu1vlQqekhKffkMqzMlFyd30NxrQM3GcBokLHQU0oitner2t5Z
         eVWmwYm+pEIv4MQ4cbDDQE+MrOq54rZjv2ZJqMc7sHhUPxlCqW0G+PFxzjNvLmQbT/Gg
         9JPcquYzsCUoAl5GMly/fqzTb9il/NGx6irIGypQH+l4x3RpIfGdYXiaKl8peJB+mhwJ
         mUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HhJM1+u+XBDc26vzSs4VoT6h5ApyY8D1IUkRZCnGVMU=;
        fh=kiGWOQGqEV96Gs9rj4Rr1A4uy7Q2lNzcTOS0r71b3fM=;
        b=bWQV/rXj6zvWg9CSrnk3ipnCznpaKzQbSaYZY9iqm6njCJ2BG76+1nfFCRjJv2R0lO
         vTr8xmcDPwFgDEoNaVq+96b9WiGzrYueiSeEgQVDtVzLLF+DKon0naEcni7o/ltqMdrb
         uDxnxv1yPBmqM+BuVSGS7i2m/VabJSPx9Ui4Ld2piw46MWJx1Io4Pmaq8r6MtEPXk8LP
         nJrNy/tIW4gO0Zi50MaxrnzWl4X4m1geVmOtRBfJmq229bIpfUAAxddrr9rKE8wPty77
         YAMmKTmDI+0GdEQVoDhxq3QHQwi3Kjy0aASoa+a1DtTSr680YBfo6B4/g2xb6oa9mWoH
         aDOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786740759; x=1787345559; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhJM1+u+XBDc26vzSs4VoT6h5ApyY8D1IUkRZCnGVMU=;
        b=THsSwmBmk8bh9FNq0l4VcYRmSW6dxBEkzeIW0mVDrhCCQZa4qjIfu//KQweoZfdTqu
         7Ewwk+poj4XA0r+dqv8eFGEQ1XN0D5FPW8rbzqNLpeFBNyQsCKu21goQ9NHsIm7dxyi8
         bAqkYJtD+du9CJDb25qRW8vHr/MtFms56HvEDXOajl94E5XUXLadHX20lYIGmWiHT3Of
         WgVLPnQ2xrRldmuNkRH65GLKOI7Az0uslHuPiZ3X5dJ8iG/j8bMs2cWOQRwt2fB5L1PD
         lvmmJsKbafgxcUq9g0YyoK7HaDA1DSXVkpuV4owrZ9modR2/bJus/rXDO42q5qMY1mUM
         zd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740759; x=1787345559;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HhJM1+u+XBDc26vzSs4VoT6h5ApyY8D1IUkRZCnGVMU=;
        b=VsXaZf7WId2YHyXwzh2TMOQHITztMh0JgqPcp8ta4qlXJVmuypdtOnn9qZQBwQpu3v
         rLuSWRqt+A+9+0OX4OXO+YEY82i+r1bz+GJM8mGrttx2bHqV0gIevG1HfgtJtvHCFfc0
         tXdjYYVhOHHj6eT+39ovYgBQFqe00KfW6qU/gMu6nOH6ujWu0xu62Asxqn3AQkZQwl2K
         RGRvppqDKVnJosE1NYglmoKrxIWvalIMKEZoLswDLEyVbRTqjc+AaP5QTgiQhn2IFCWx
         7RmJ5i0WrPxT8eYNxnJyOe8kKnb/eXxyT7Vpfqty2tWdWZWs1D6L8IPKO3KaTjWAAt+Z
         0zqA==
X-Forwarded-Encrypted: i=1; AHgh+RqyTbMHzR0bM0HD+E0zyL9uwHs6Qmkx2b7iLffdD9Mq+wsctTrqid/yJ2KTFMzacGXMoC2ufGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/TG02V1euh4VtzL0wuwKEE7k3p2zEi5ZuKiDELWadrA2XLd0
	x/Dd7dZov3npt8ccmtN4vzDj1Npwq21j15heGwjK4qxv8wNXzC6i68Kj1VSYYE45wHOgi4zQkEY
	2vXXIxzdx7y0dzCW7MZqQwGNziz8NuYU=
X-Gm-Gg: AR+sD125d3+oTqyGQ9Yz/ARcdXJObWn+1bbZUx+QUvxherUX7z7D2G+PFOCi58N7NM1
	BucJiTJWMd4XMZr/OwfXVZnzE4Pop7Dj4uObGCSAomUQHGTD2AzRWDkukaIOsunZ+JFKHKABDRs
	9FvcG0BZv62rK+ytT2Q2JdcPZmn/76c6gKdFTZNWfCjfDvgkxmvujvBSB01ofXJ1Min+n27yZSX
	z/zoTuDIAelr7inQqljtvGj9XuKpWxUN77QmFoXno/H41slq2Pnj8+4dB6wu+AH/h+gHdiJPz9u
	Qk3mcE0gJDxKmSqfE2gXZV1WyhQVTxnp2g6Kg3M7e16R5g==
X-Received: by 2002:a17:906:6a16:b0:c15:ffd3:da25 with SMTP id
 a640c23a62f3a-c212a227198mr373446366b.28.1786740758577; Fri, 14 Aug 2026
 13:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
In-Reply-To: <20260814110102.2362246-1-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 14 Aug 2026 17:52:25 -0300
X-Gm-Features: AcwNN1XSoGZ8XocejXkOXlwfv9yvHFGD5JzSQPVIQnEYHTUZK0vIvcyD9MEc8z0
Message-ID: <CAJq09z6RuFCDtaYLMavR8prsjw4mQM3br4jO09uHv0S8yUGK-Q@mail.gmail.com>
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use gpiod_set_value_cansleep
 for reset GPIO
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, stable@vger.kernel.org, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>
> rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> the probe path, which may sleep and is not timing-critical.  When the
> reset GPIO is provided by a sleeping controller such as an I2C I/O
> expander, gpiod_set_value() warns:
>
>   WARNING: drivers/gpio/gpiolib.c:4030 at gpiod_set_value+0x44/0x80, CPU#1: kworker/u16:4/61
>   Hardware name: B&O MAP CA33 Rev f (UNKNOWN) (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   pc : gpiod_set_value+0x44/0x80
>   lr : rtl83xx_probe+0x1d8/0x3a0
>   Call trace:
>    gpiod_set_value+0x44/0x80 (P)
>    rtl83xx_probe+0x1d8/0x3a0
>    realtek_mdio_probe+0x24/0xa0
>    mdio_probe+0x38/0x78
>    really_probe+0xc4/0x3e0
>    __driver_probe_device+0x15c/0x1b8
>    driver_probe_device+0xb4/0x120
>    __device_attach_driver+0xb8/0x1a0
>    bus_for_each_drv+0x88/0xf0
>    __device_attach+0xa0/0x1d8
>    device_initial_probe+0x54/0x68
>    bus_probe_device+0x38/0xa0
>    deferred_probe_work_func+0xb8/0x120
>    process_one_work+0x184/0x4e8
>    worker_thread+0x188/0x308
>    kthread+0x130/0x150
>    ret_from_fork+0x10/0x20
>
> Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
> be used without triggering the warning.
>
> The reset GPIO has been driven with the non-sleeping gpiod_set_value()
> since the driver was added in v4.19.  The call has since been refactored
> across several files - from realtek-smi.c / realtek-mdio.c into the common
> rtl83xx.c module and then into the rtl83xx_reset_assert() and
> rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
> applies as-is only to kernels that carry those helpers (v6.9+); older
> stable kernels need the same gpiod_set_value_cansleep() conversion at the
> corresponding open-coded call sites.
>
> Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/realtek/rtl83xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index 09fd64880232..8121ec12fd8b 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -334,7 +334,7 @@ void rtl83xx_reset_assert(struct realtek_priv *priv)
>                          "Failed to assert the switch reset control: %pe\n",
>                          ERR_PTR(ret));
>
> -       gpiod_set_value(priv->reset, true);
> +       gpiod_set_value_cansleep(priv->reset, true);
>  }
>
>  void rtl83xx_reset_deassert(struct realtek_priv *priv)
> @@ -347,7 +347,7 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
>                          "Failed to deassert the switch reset control: %pe\n",
>                          ERR_PTR(ret));
>
> -       gpiod_set_value(priv->reset, false);
> +       gpiod_set_value_cansleep(priv->reset, false);
>  }
>
>  /**
> --
> 2.47.3
>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Regards,

Luiz
