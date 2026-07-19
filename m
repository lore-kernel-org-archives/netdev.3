Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59A50276
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423357; cv=pass; b=WUu8symVAcaskJ/phE8ieu7Z68Bc9+E2I5FA0JN9pOTNFoZQzvZHcn4aeI0G2i59SAAc4eM4HsKa4YqfWpX8w6fenPPE+KNKuPja8vIXJEoLE5VcnJ+Uw2xb1HrKslVAd/PeTltwOGJOpDKGMp3JZ6TZg2PwOenPYjSJOLE04QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423357; c=relaxed/simple;
	bh=w5U6y/tJDTzrKttFgxs0Qya2jP+JxrQMqmMReAIwnnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKRFYW+PJgRB78nrIsITuEHSOceaXbcp2Twneh6z9udGJ9GbEgDPcdAdvuvCi8EgYelFiUyqR07niv1RVCPGNHkegpNAYDphPsba5L96ItlflM3aZg7As3Zt73FhOI+fB0ExVtTyaOKXQIthEuZGShJNzJYzISCzB6H5wuvDQhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2uzfOtg; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2uzfOtg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso13254364a12.3
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 18:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784423354; cv=none;
        d=google.com; s=arc-20260327;
        b=QwS56wMVIqDCpxs1bkgTE1+r6PnuZbtbr1IfYt75HmLT8wLLjdAKWyehg2U+K4EUfz
         Ky+G2TpSDQPn3CzeUFdBTBpf4GHRm5hAqrqZvKT7RPYPLyMVAaRkwX045o6t91Tal61n
         0LIp32NgOObh11g9mNqry4N0bJwkaL3tWMa9XR/binnhfnrBg9aOoQwoXt9yCHqDsOGp
         6YlCmruJT2KyoEJxTi7JhaEGaxDDsvmI8GwKXoRvVcz58BOmPa7QRXAeG43yZi56pTFv
         voA9aIExLw5sQpG/gyd7unDFexrZlAJL7wCYUYirVJ1S0QPGY9AGpA3zFOfxvaUFK/7Z
         /zTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rSTLdXI0MyRppPlH1tT8qGVbecFqVWpzSi78PfqoozQ=;
        fh=weJttZ7urlHDwFjNeCEWVQyxW2jhaXC3D+d0HrOxRQU=;
        b=gWgonRMMRUIFWvaOPhVsLPsoyY8v/+OIKuYvakFf3y4vuJAzbQawTSOT7wopXYUWPp
         hD78M58ODAt6dWpGV4Nt8DGQJm/2gom+JpPG3ztF+ccuiI2a4jcN6ZVcXCN6muVzffT6
         8xV48cPmHZdvW9RdaYlVxTdOlw9zGhE0RRjrSwpAPnWDPboVo77ujPSMhXZwZ92EuStm
         DobGKHP3M1/9OWi5co+twmBPuwVtV478OsreYJNy7UVFgX7C/seCOi48VfkXpXeNFfWr
         0J9vOJkn8BGb5LGuGgUb7LVfIpRwf1nbVijX1NMMDYW3qdFkcnYfstkvK/jS7OW+hqtC
         F7KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784423354; x=1785028154; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSTLdXI0MyRppPlH1tT8qGVbecFqVWpzSi78PfqoozQ=;
        b=i2uzfOtgehCWdjRVZU6E30DbyVUZD12+kAXu1w4DAceREvNYWoHGBb8jKWs06dhFeG
         VxFi8nhjWaFjl49onh8QjMXAPMROCB1p/bHDsi1qNNv0o+QS/5p1ea6u3ft23jR64H3A
         QDcNCJJ+dwJMq42srRyXRyXzNjDuiLhkY1U4pBkyggL49VJlBlc1cQeSHnKHZzBtyUv3
         q610KwNLvgtc+UAi6S/FAXeSp5eg+uqbv3+halNGakvyATczCVN0FLgRMxHylGfcruek
         qfHcEJkyaZZONd7fpab+gcXRKdtC0QUhoKuvu56qR+lkPjalS622XOMLrYaprrgzG+77
         V5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784423354; x=1785028154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rSTLdXI0MyRppPlH1tT8qGVbecFqVWpzSi78PfqoozQ=;
        b=C0B3yqddW1LJjSTmFRPnX0NtTarY5PmOIDmk6Jjdkd9/JtTPZAecHZARZV9LlcDmos
         vajT6MKh+h1sdeb2oyiv+39kNjiQ69brhaV79Zh0MuatBBkm0kedf2BL8y0Aq6an5wX9
         3eevJV2LmQ2NITn8mOHN0gG37ypuLN4yMGyBdZtj9gr3e6+heSyPTjFDZPCuh0UteAal
         34DPI7y5JOKjGp91rJwairpPc/SScZ/KeqA0ZZHypC9/L1SJ/LiO43FnNcQJqwqTxvDj
         OM0g8aCcadqnl4j4ZUaXkGZFt6QkhC7V1C3/b0wu6a3jLtympdlD4/+tpE2Q4/ORMxI/
         Zvqg==
X-Forwarded-Encrypted: i=1; AHgh+RqJExyX6MjxSR0qhw2BecRFWvpt8DJ+ybwTmfrWDVTNriDZJ+VdT5AKGBM5KDeUdPdOVLL9ZjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwxvPjAExFT7m21rFvxJEYyxoxnfDzAV+J1ZDIr63nMRtOSic
	4y2aP2sSa/unE061vLdSEm+dzkFH87RNzSuAAgdLMHA6oXxeDra/yXTOxzvrKnR54tvGb41C1Xo
	GPhBCDpFZTxDn2jB2WUJ6sDgbXpWmxwg=
X-Gm-Gg: AfdE7clyXtWT5XIwvi9s7lr95xtpEw4DAUtwEZyhtfA5ACGCWVYJ+PnL+MuamHd+kv4
	CNohXcx4onm/SKpfbaEzd5RnvUIWBiRBfKGSxJ5OnO69uomO8LoUjK8aBWnwvmxXQ49k+CreaOl
	REWcKKAkXIUYetoiHBEfHtVPlNRY6rWgM0BXjATOEv/LI7DFOdStLCB7X8jf68C2mrZjBv1q/xr
	AK2AGgpRo+sbGdJzpQhBcYvKwSNEGKJk/1yG6/tFkpoIOT1ivqX9LN7R4w9yQjBbnmPzt0RamJi
	4kp4ztkrtugMCHx1O4w=
X-Received: by 2002:a17:907:9803:b0:c12:3e8e:2ac1 with SMTP id
 a640c23a62f3a-c16b48074dcmr394742066b.51.1784423353685; Sat, 18 Jul 2026
 18:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJq09z6bqVdtmuf0LVe_WjVYM9GmjaNiqjnOALLut4jCoZBLRQ@mail.gmail.com>
 <20260718075549.91288-1-kuncy7@gmail.com>
In-Reply-To: <20260718075549.91288-1-kuncy7@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 18 Jul 2026 22:09:01 -0300
X-Gm-Features: AUfX_mz-CLu4X2SDFizle0b8NuKJsVUliP2atr7624qFX3XkMCZVY-CX5Nn51Bo
Message-ID: <CAJq09z4TX=LFOX7iq2g_JwkjtLM1U_Q=aYvAkd123LgOwZNyUw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: Stanislaw <kuncy7@gmail.com>
Cc: Johan Alvarado <contact@c127.dev>, Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
	Linus Walleij <linusw@kernel.org>, Alvin Sipraga <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Hi Luiz, Mieczyslaw,
>
> > Stanislaw, do you have a reset pin or a reset controller configured?
>
> Yes - a reset GPIO, no reset controller:
>
>   reset-gpios = <&tlmm 33 GPIO_ACTIVE_LOW>;
>
> on the switch node. So on this board the probe path does run both
> resets: the GPIO hard reset from rtl83xx_probe() plus the soft reset
> during setup. That is worth stressing, because the re-probe that cures
> the cold-soak state performs *exactly the same sequence* - same GPIO
> reset, same soft reset, same full init - as the probe that lands in
> the bad state. The only difference is that it is the second run. So
> it does not look like a missing reset; more like something about the
> very first init pass on cold silicon.

That might eliminate the cause as the sw reset being less effective.

> On "loading too early": the driver is a module here and probes ~20 s
> after power-on (rootfs mount), so the rails have long been up by then.
> That said, 20 s of a cold board is a different thermal/electrical
> state than the same board a minute after a reboot, and short
> power-cycles (~1 min) never reproduce the issue - only a multi-hour
> soak does.

When I said too early, I meant other components that interact with the
switch. Maybe they are not ready. Try to skip the module loading
during boot and load it a minute (or more) later. If it works, we have
an indication that is not the switch.

> Next cold morning I'll do the reset-bit isolation on the degraded
> state, per Luiz's map, before falling back to the full re-probe.

Another test would be to dump all switch regs before the first reset
and compare what is different from the state after the reset. Maybe
depending on the previous switch state, it may require more time to
recover from reset. I suggest the regmap debugfs.

If the double probe works, you can also incrementally duplicate the
process until you reach the point where it works. My 2-cent guess is
the eee reg set by the jam table. And you could also add some sleeps
to check if it is time related or just state related. This is
fundamental to track the issue (state or time related).

It would also be great if you could isolate how long you have to keep
the device off to reproduce the issue. Try a simple binary search.
Reducing this test window will speed up the tests.

Regards,


> Best regards,
> Stanislaw
