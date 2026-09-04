Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BC4A3F3F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530138; cv=pass; b=FouYqBa64NKuDjAM+myLmS5u4bc8tWaWfSmnFXBfZjzHpp+8u69F3TM/9dWxQsXV1WBQ/XPn+gw3ndNj0NiuedBnRzpvooFOYx85ER65A140IaYgvvuKA5Z2VyWnge5x7hv1tZfCzAMLj/W+F8c/UaQikfJW/NhVs0OxUZP4hFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530138; c=relaxed/simple;
	bh=aYGTw43PGiruYrbCRK8lrDyOCcUgVMqsAo0cR/fDfeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mfw0ljRzhjqfTFEpT+fNIpsqFJb1nAK/+fCXSRYoyUeOGnhJh/ZEOlTUheyzzzaBrrQPAPgRGgk6wdG0HtdAvf3ADnOoyY4rJmWF0saKQ5p06pDqAPWOqzDUI/YVgmo9CCMKpDQo++dYrU+A+G+GOquKw3p3fxRSnN72W6ZMCZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCxxW9q4; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCxxW9q4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c250c6a6a6eso140631466b.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 06:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788530134; cv=none;
        d=google.com; s=arc-20260327;
        b=sMTCKcstnAZoP2zdVVQ2F1+3x3tF6JnnjncP3NqUt85eYQrgo24goElQYsxWAX9Vdc
         X0s3xPzENQCE37RdkGdRfpqQB/r+2LkESwBOMQjNH23N8LVzIJKKAdHKz/oLfWqEFvzT
         N9eTCTNxpoKWwp7H022d/tXFON6s5geXxbpwnKxCW+9O82SSmusO1NZQumdcZxkd2Csr
         Djx448oddRT1O0VPLzSEnJFC1MFXu7GbVSQ9HDLDQKPqAE6xCopkS//MDVy7XLUBXt3e
         cGjGJItmnco4BjPZJ0yh7tMgnWce+J2Ut2c59/sYBpBg93pdNVUb1WjRsB4Be4pHtZ7j
         gzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        fh=b0p9c4fINhY3Nun16CVGMj+nYgZgTurjVR+p6IDHVck=;
        b=eRcWoajx6swhMkMzRKHmQWUjqRi5YVBMfmWKumqDDllawHCZMs5V5dmBiGv6MpP/OV
         7YNCf3nUnOIRInC1v6dQvoPVtomjZnlV+mf0fpwHY+uorjiwg2ERwrrYJjY9mIaG3zkE
         l5yyc6/Bl7W38ey3TxW567N2EKZxem3Ho3vzawGGm5/boJIvEMfjTpmNmPSqmTmg9Tu1
         7yd25opqTcc0IsyOZWuhtmffjuDDk/KyYdIB1GD2yKWlvdjGVLge404ZpqlAO6Nw1BHc
         S85BnfwPpH5TLC3GewjtakEPknjj7G67GFB7Z2NWzOPs4IZHQwJPxj7Bu/nQcBdrJN78
         Dpiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788530134; x=1789134934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        b=kCxxW9q41x6acDRBBZDVjfyTyqKRt/evee3/RMJ64zlf6SHrFgHtykPwYzwvAi3wVJ
         ZRIv7vOTkQh2Lr2n+smSk6EZDeGERL2XnUVdkdmbijX3sIq8nHQIT4bwdKQG9VlBvxBC
         8naCTVcUFcfSQHMrBLpJQGzu74JQ2aIQws7AXtvIxc14zHervNOo4KbpAp1FFOqd1BDh
         8sOIjGi6BVaoHydFmTO+nYefEIeAAEsXLvyc/0L2/jipTutRInYXfOINnr0YZQVJnXHl
         C2LFuM/tqHwSMwJQDQ8c+FIBz7PMpJ9MUu/9P80i1Y2oORNVkVuubgrLsPndLlRYakJI
         4DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530134; x=1789134934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        b=BqAJb/8UWrvLuqfrQcK2T4yA2VWSfxOiTlIuzbiiLYceCfdb39BdgWTunOWvkYWjqz
         AINxxe4BFZImsUUV6bzKSdz212Vga7czWQ7fox7jZY4UiHI5qjc9qo83wN9Zh51g3920
         ryMDrK0wh/Ynyhf/JJRar7STsx22eR1tGuZRnVboBae415v1UKFrahX2MBijVTRQA3il
         sdlDMtnSTX/WmdwisFVj7xvhvzRzH5NDQ4TP+GTK64aa6YgYoh/uOdd+ZBSzf079EGFV
         ecccvEPmwq/j1k4nqevKMAmXkXrsQ7pD7K7ypeOLGrQCWlUuiFGN1CwxnAUMnMqQaaWT
         corA==
X-Forwarded-Encrypted: i=1; AKwUvBycthP/+wDiJfbVYzCdtrYcIpIsLixJ6c31JiqjhqRgwYN8xJ1LKq/vKmXVddm+T9v200QlD6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nYGof90msRjk2QHcqsZb9GKjlbXPBqPhFgZH8+3ciNHBFyiXKM
	qvsmFSbsaLPwvFkn/jQDQobWUXqlDh9KP6aGqK4CBeY/LKtlPzYDh+JMcN/fwQce43BZKH8WMj9
	ez9Ih4nsXN4y/Yjc8JwS45irX3/vdvgQ=
X-Gm-Gg: AYBFou1A9NBDB6+stQw3aPYJyeHwt0xlCmoYwdYR3Ino8k7TS8V+U21ON1u9WK92R5v
	Gl+rJlwc7dImP68CJ7ne5YlnRPjv1s1w1Wba3uJQ2CR9EHfxt7bRV4fLSNV5cCl5pfoSdOnI9gB
	KuVz31AgThWvPao+nZs+nEfGmTT124fuRN5ICh81d72hrnzZgMi41wcz0brkBhHzEBQGiqsfQYt
	ztuHCFJ96bMmc3sdYBt8N7mZh7y8yUY64PrSnXDNNSH/UQP+Yyi4XpsxjMamG0PKHA6lR78uTkq
	vDovBoQvOku4n1Z55Xiruk9MuUvzswrylgAtWhukot5gFFdyQ7+DuqQ+OtRN
X-Received: by 2002:a17:907:720f:b0:c25:5d2:acf0 with SMTP id
 a640c23a62f3a-c260c8c21d3mr311924666b.8.1788530134042; Fri, 04 Sep 2026
 06:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-21-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-21-s-vadapalli@ti.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 4 Sep 2026 10:55:19 -0300
X-Gm-Features: AcwNN1WkMLBcSKjjx-549nVRZ1ZETkJHm5sDyQYa7o61EdbIDExabOintEMeFfo
Message-ID: <CAJq09z44PfcEKsoH9eP+c5rxmzQ52hQO33k8sO-e6po1bpE6rQ@mail.gmail.com>
Subject: Re: [PATCH net-next 20/33] net: dsa: realtek: rtl8365mb: Remove comma
 after sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	linusw@kernel.org, alvin.sipraga@analog.com, clement.leger@bootlin.com, 
	justin.chen@broadcom.com, dlan@kernel.org, rogerq@kernel.org, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	opendmb@gmail.com, andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, 
	amadeus@jmu.edu.cn, kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, 
	horms@kernel.org, vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 4 de set. de 2026 =C3=A0s 01:39, Siddharth Vadapalli
<s-vadapalli@ti.com> escreveu:
>
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/r=
ealtek/rtl8365mb_main.c
> index 4c305756116c..f8220d832e46 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -3352,7 +3352,7 @@ const struct realtek_variant rtl8365mb_variant =3D =
{
>
>  static const struct of_device_id rtl8365mb_of_match[] =3D {
>         { .compatible =3D "realtek,rtl8365mb", .data =3D &rtl8365mb_varia=
nt, },
> -       { /* sentinel */ },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rtl8365mb_of_match);
>
> --
> 2.51.1
>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
