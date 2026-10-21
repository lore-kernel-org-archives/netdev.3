Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541715;
	b=me/5W7t83Tl6ZYOc8au8CIZ30ba9s5V3HYBp+Qg0idNqIJV4fDMgQR5xpsyN0qEJFV1x
	 8FBCaucOWH4Uw1RUt012x/Mbcqp7c9v+OGNEYC7JL9nPanD4YQ/7dETdsu9NF0lQDGWt3
	 gK7gx7Ej0LJVEhHhXkzMr6bczKJ0p63qRGasfd6w3uJksHP9SwB2ZssYCoA1oFKP+2PWw
	 ow2ciXW4cF7eM7itHcoV78ZEO9QTTCmSymI8kD6KP5E5kt0AwkoZhtKcmzcWaRdKJ1qrF
	 AhEp5Mn7iXSlq1duNO6ZfrPLH/ZkQQaeUWJLSrxeqDUSTmzlSbOmt4PBlSnrS8DrMuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=buJFybofRKAj6f/cOm3YyhAusR+wZtUZbjqKpPWA0mE=;
	b=sP4QfilXUjgRoGBA+v5KwY/tVwdgrJU4lsrd5Eeq3AZRSwFdrmQMdFke+Rxv1hkmbxny
	 /78LcBPX2bASW0AviA06O0bNOyBEnGqWAtrWYN5Iiz6I1AZRckBGHk0UxBG8WX9FPaRsn
	 wnujpOKRfRuWnBn6M2WQwF45Fx7yjlDd1t64u/SY9RkojJWvpBnTU9E/dqYC3q/KbFpKP
	 9FvzrWe+PJsQPvy5VBZ4fwRgmopWscXBBRjBx8Mr4ETNswq2k0CCv4gsqrNb8m+TRhK9Q
	 AKuKfcmH0uibPWQ1AX1RtX8IHCIFYlo7aL+0HJ1G69h4irZEZ8lOUE9uVeECtGnnKaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=WQHE19US;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F2606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 319F2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=WQHE19US
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-157fe9d771bso199410c88.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792541711; x=1793146511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buJFybofRKAj6f/cOm3YyhAusR+wZtUZbjqKpPWA0mE=;
        b=WQHE19USH9U5cqIX3n4xGtsapTcnXA1cYUxwTQybJpgn4ep6GizDYqpEZd9oBDaz6f
         njxHGyduIJy2iqKwNaylf/2dYUHgft2NGKq5v1O9UXJHXg4v2uvBD+j3KOQbfLAjHOkh
         14iJNsV9LjBxcLkO9PRDdCbzAkyQigooeZedUkJzfCtVmRON5LpfsVJIQwa56Ugf4HrY
         yJVSDbz+WhjcplLhGmLPM9tERkVlUScsHm1hk3RhZh2QKjmMxKwY4nnnuHoMbLXdoEGf
         BKvZs753EsG74jDXDCM/zrodfTmUYi3D0aHCwXcs+lpsv5Hm/U8IMt5qm9EasCRAd0wH
         f1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541711; x=1793146511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buJFybofRKAj6f/cOm3YyhAusR+wZtUZbjqKpPWA0mE=;
        b=Wsz6GGDduVARD3+xbSCcaAh31l3ABXR6x0DBvZyYYIFqg/yr5qSZFxV/jsMVVQNcNx
         I3zrRjmaktWrjpY4qz20E8rvcGJEY9N4aAL3a+uoYhcyMHw8ROxZBdEoPh+HUkJqtsVu
         P+fCC2sTeX78CQWgRg6eDxsuZ19CzSh3Af5TkxuxTSm7gVG5ecWjCS9pqlMk1/6KGpxN
         dRZg7RCmRWEbD06GsRXOeR8heXZddX2z3vvtCesSnqvrLGxglXEkiQHzw6wGEgpvpciW
         EmGC/ymwlQ3arF6gBsPswLB8V9Z4jTgrb9Tgly7L0RwDgAt0u60Z3X/jf3UxrmAAcKtw
         wpkA==
X-Forwarded-Encrypted: i=1; AKwUvBx4znKbJAVR0aoZ7nwswlSWpvl5Kiah6znEmAQTn0ai40ScKmrXfBr+UdS3zX22rGWIbDfnB/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbwNBBJEJnAGJviItqb6BDanXxVgKguEAToUTeYr0CEVDPB3x3
	V/oapLs26SDkC7SN6UlQl54SHBo6R+d0BBx/cNQQ6peBVfksp1sbOI+t6/5OkqAjvg==
X-Gm-Gg: AYBFou1stXzrIE8l26TaGvACSmmnNGs2t0zVWaSgYw6V5zvAfm3WkMafcmUYHz3fHS3
	A1EL0sg3ICoHaN/ltSZArE2HDEOP4loxE7t+a8Q5DbvYc4ChxPLEYEb8eGoOA4qw0qApPnbD091
	xYFh2v+IruG/Qdm/KaeihNwKh6DuNG9gSzSzG1y6VIUiu4JWR1MaJCli/uMNYjOvCHac6K/0eka
	gNaUlTF6CWayTOau2RY7nWpoH1ngxWAf02ghmYgjYVVmIz14KeyEXOwBqPtWkuHyIKeoKng66iC
	kyzMFokuj4Au87K6ubxixWGhDtPQXJEiqEQQcLp+2TPUXV1xr6cOLMjulTjoVieTn7fWkOjAdix
	Z0XQpaDxIcNwOQgP8BEVCvu+R4z5LaEyQMVy4w0p/Bdn1Nz1dsbHI+g2bGQ/Xf50JmTHBkbeCcB
	zKCbjuRmbt6uZsX9EG0fI+pHDY5wGBgJwKD3BjBn+zgSDZj2jpijdB3/cZ++Pub0THYKai2wNuQ
	6KFbFu1ZLSpnKoW5Jq2ZBmEwg+IdTF3ZQiyszIVUUeEUg4lRBCdVmhTpQXYk8pLy1Uxm1x81/o=
X-Received: by 2002:a05:7022:ea59:b0:182:94d7:f76a with SMTP id a92af1059eb24-190a728a66dmr496799c88.43.1792541711094;
        Tue, 20 Oct 2026 17:15:11 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1cdsm2249259eec.25.2026.10.20.17.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:15:10 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	richardcochran@gmail.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	theo.lebrun@bootlin.com,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	conor.dooley@microchip.com,
	bcm-kernel-feedback-list@broadcom.com,
	tglx@kernel.org,
	jstultz@google.com,
	sboyd@kernel.org,
	mlichvar@redhat.com,
	olteanv@gmail.com,
	h.feurstein@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/6] net: mdio: bcm-unimac: implement timestamped MDIO writes
Date: Wed, 21 Oct 2026 07:15:02 +0700
Message-ID: <20261021001502.1306545-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179240607580.3135.9897216542640862141@kernel.org>
References: <20261018100257.566267-7-jjc@jclark.com> <179240607580.3135.9897216542640862141@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: Medium]
> The comment says the reference rate is taken to be fixed. Is anything
> actually keeping it fixed? There is no clk_rate_exclusive_get() and no clk
> notifier, so the rate cached at probe can go stale if another consumer or a
> parent change alters it later.

[ ... ]

> Could the driver take clk_rate_exclusive_get() at probe to enforce this
> assumption?

The clock this is for is BCM2711's GISB clock, the SoC's register bus
clock. The firmware sets it, and nothing in Linux changes its rate.
clk_rate_exclusive_get() would also protect its parents, PLLD_PER and
PLLD, which other clocks use, to guard against a change that doesn't
happen.

> [Severity: Medium]
> The commit message says a deferral of the clock lookup is passed on
> so the MDIO bus waits for the clock's provider. Does that work on the
> GENET path?
>
> There the UniMAC device is not bound from DT. bcmgenet_mii_register()
> creates it and calls platform_device_add(ppdev), and the probe result
> of unimac_mdio_probe() is not propagated back through device_add().

[ ... ]

> write_sts is optional, so would it be simpler to treat -EPROBE_DEFER
> like any other error on the pdata path and not offer write_sts? The
> cost is that write_sts would then depend on probe order.
>
> Alternatively, bcmgenet could look up the MDC reference clock itself
> and pass it in struct unimac_mdio_pdata. A deferral would then happen
> in bcmgenet_probe(), where it is actually honoured.

We chose to pass the deferral on because the alternatives seemed worse:
treating a deferral as no clock would make write_sts depend on probe
order; looking up the clock in bcmgenet would hold up Ethernet for an
optional feature, indefinitely if the clock's provider never binds. On
BCM2711 the provider is clk-bcm2835, which is built in and probes before
GENET, so in practice GENET doesn't come up without its MDIO bus.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the new comment makes it
> more visible. unimac_mdio_clk_set() still computes the MDC divider from
> priv->clk, falling back to 250 MHz:

[ ... ]

> Now that ref_clk is available, should unimac_mdio_clk_set() use its rate
> for the divider too?

I agree it's a bug, but it predates this series and is unrelated to it:
unimac_mdio_clk_set() is unchanged, and the write_sts bounds don't
depend on it, since they read the divider back from MDIO_CFG.

James
