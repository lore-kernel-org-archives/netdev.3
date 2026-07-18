Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B33033E8
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361361; cv=none; b=Spjcx+NQsiJ3lvSdNEzyBTWJ4RZTYSMKpSIVfanU8QK2SzbWJrWhq17YJwGYyx0Bq5/+Bbo7BSH8tmgNYQdij4a+mpXYBzNJMc2cRYqK2Ks4Ntq9hlbVaxk5Ndn6VnFM4LtCxxMzKMNAplfNXqrP+ymvy+OzB28sX73+m0ChRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361361; c=relaxed/simple;
	bh=938bOJnd7G3fEFnQqsXJyC++I5P/8chu57RekHReoPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe5MsXRR2520O8E3qfxBMQpzt8t9PhTImvdEWeX65unEb4j1xl8zoQjSPEFPp2XUsnin3U5tIrwKK8S26g9mEErvd2bVi90OZ9n8eQ+vrjCU9vbjKAhPx286EmVhYXn6kpy2y579UuKXTQf0w1B3jFDDCCt2IIXZpBt7c7W6slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qoud3nos; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qoud3nos"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0148201fbso4241225e87.3
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784361358; x=1784966158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DTuHUBF12LCmuu5LhhKk5CzbF9HbdGvjqCxvdiP6aTk=;
        b=Qoud3nos/zukZhWOaCwzEOblazxHPAmG3fCIrxdyHJQnjwXhyx/FJxLL3Ugo19+mQR
         lPVoQc2MVuhG9GpMcd+dtT53JXG3ZRQkj+a3N7WrYkzqpluPzI7tzYCq/zEnxSFua/aM
         nnQKPTFjIIG/BbycKRYuEgDRit0WZhJYPHurkOY4U1wMQfvgVk3WAummccgGt5gkL4qh
         gE34IA62AVzEraSwFGXn/hPwd3WhpINN7OMxgjLImOCJVMeR1KYoiQhkiJ3/bNT4Cp25
         Z2rG0b+OjtjGTo0P9wwRc6jGlgoL5mJCSzfVVegpaUqWFNTy5/10EbtR5lmeajXZsFqm
         jhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361358; x=1784966158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DTuHUBF12LCmuu5LhhKk5CzbF9HbdGvjqCxvdiP6aTk=;
        b=QmV4KM53mM+oTg3gAE+WyNyEdYVhG7j8QEApbk+MKqQ39p8QpLnagfm2ZX+iHhwcAT
         N0P1UpxR9+lh1mPz8byd7/JI3J+D+V1xwv6OekbR+YL5oo7twasgjPomRikG+D6d2Skp
         MR0Z/LOP6fsPu8WUX1lU78fJW1ZJqSo1JWqF3dXPu5XrvqsNAI51ugxz0FcRnY5We9zf
         Yp8+bwc1KrN/IcXdLcxtivcXpOfeMdRBwGa8a015szn3SvbjNJGLIIJoCmyQz1ia8EMR
         psd1ABFXVGek0b+QURNjI6BKziVp4obuCp0pmdrXaH2gp2mAlMoJZnK7NIiawa86Ss4r
         4u+g==
X-Forwarded-Encrypted: i=1; AHgh+RpnuVWfZX4KdYlQKJ+sf1QYL1Gmr1NITtAzxohVQHSNpLvC1rmI5iUra+JJNCbrLEOCri8Vyk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQRQBBMOx6j9ncf8YsS5xEcumGiIyVDEWoqeVykF0sycid4O1
	PPtYCi4eqPTyfx/ZGVJK3gd19YV70FtY4uMjBgj5ZFSXV6PPLniIfjYF
X-Gm-Gg: AfdE7ckRrlbmoMXJSkaMlkwhyC3mEkhsGKmZGniz8440hp69VgijDB3ugXb2CiG10r1
	2Ew5X5r60tRX8DwmPQsQJEWmH4b4rip4+2tRXRyZDe3ZoEWyyPmQxrJpr1uSr1aqhC9bgH2OQjT
	r/Wf+rk6Lc7MhkrmIohQ95/ZBJ0bVR7YxsU9Q/7zMEY1+DC9pY+pq9iIgmvYCVdmARrUkOEc2/+
	gLb2N1b/43htXyaOx9vcjDBLMooZ08qViLOzEsN2GWvwJvMcNQJrCK25ICfYWBl3klvgoS3rn1r
	dZRgBGU+DukVSpGjBr9SEFQpI8DbvtK36Ie0hYbtMsYEpOD0yr2P4VUV4thvHD8IMIXoQRlznvs
	vmkVN6gIXOJP3MlRZGJ+QQJjohkijz+nCT0VaAs1TpVDiP6GyFqVMCTXdOCBuH/idVbyvsgu+Wd
	VglATGiu1EGtI1FBxPPKY4/dsdUIA8YvjPMV3e/2Rx/WaeriJiqS1A
X-Received: by 2002:a05:6512:108a:b0:5b2:8abb:2334 with SMTP id 2adb3069b0e04-5b28f9b0206mr1203395e87.51.1784361357360;
        Sat, 18 Jul 2026 00:55:57 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs693195.centertel.pl. [5.184.251.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e25290sm839179e87.73.2026.07.18.00.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:55:55 -0700 (PDT)
From: Stanislaw <kuncy7@gmail.com>
To: Johan Alvarado <contact@c127.dev>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Alvin Sipraga <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
Date: Sat, 18 Jul 2026 09:55:49 +0200
Message-ID: <20260718075549.91288-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJq09z6bqVdtmuf0LVe_WjVYM9GmjaNiqjnOALLut4jCoZBLRQ@mail.gmail.com>
References: <CAJq09z6bqVdtmuf0LVe_WjVYM9GmjaNiqjnOALLut4jCoZBLRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz, Mieczyslaw,

> Stanislaw, do you have a reset pin or a reset controller configured?

Yes - a reset GPIO, no reset controller:

  reset-gpios = <&tlmm 33 GPIO_ACTIVE_LOW>;

on the switch node. So on this board the probe path does run both
resets: the GPIO hard reset from rtl83xx_probe() plus the soft reset
during setup. That is worth stressing, because the re-probe that cures
the cold-soak state performs *exactly the same sequence* - same GPIO
reset, same soft reset, same full init - as the probe that lands in
the bad state. The only difference is that it is the second run. So
it does not look like a missing reset; more like something about the
very first init pass on cold silicon.

On "loading too early": the driver is a module here and probes ~20 s
after power-on (rootfs mount), so the rails have long been up by then.
That said, 20 s of a cold board is a different thermal/electrical
state than the same board a minute after a reboot, and short
power-cycles (~1 min) never reproduce the issue - only a multi-hour
soak does.

Your reset-bit map is exactly the experiment this bench needs. Next
cold-bad morning I will try the individual reset bits (SDS_RST, SW_RST,
CHIP_RST, DW8051_RST...) on the degraded state, before falling back to
the full re-probe, to find the minimal action that cures it. I'll
report what I find.

> Please repeat the test only with the fix "the ~98 ms PLL-settle delay
> plus the 0x060C-0x060F Local Jam Table analog calibration".

Done - last night's cold soak ran an image with only those two changes
on top of the v6 series (busy-wait reverted). Result: the bad state
came up as usual, no improvement - consistent with Johan's analysis of
where those writes actually land.

This time I had ethtool on the box before curing it, so here is the
per-port MIB of the bad state (~35 min after the cold boot, switch
reporting 2.5G/Full link up on the SerDes, wan 1G/Full to the wire):

  CPU -> switch direction (broken):
    eth0 (SoC gmac1):        995 frames / 282,945 octets tx, no errors
    switch port 6 (SerDes):  dot3StatsFCSErrors: 506
                             etherStatsDropEvents: 506
    wan wire egress:         zero - no ifOut counters at all, although
                             the kernel handed ~990 frames for tx

  switch -> CPU direction (clean):
    p06_ifOutOctets: 172,231 == eth0 rx octet count: 172,231
    byte-exact, zero errors - that's why ingress from upstream works

So the cold-soak bad state is now precisely characterized: over half of
the frames arriving from the SoC FCS-fail at the switch SerDes ingress
and are dropped (and nothing reaches the wan wire), while the switch's
transmit side is byte-exact clean. Since a full re-probe of the switch
alone cures it - the SoC side is never touched - the bad half is the
switch's SerDes receiver, left in that state by the first cold init.

Next cold morning I'll do the reset-bit isolation on the degraded
state, per Luiz's map, before falling back to the full re-probe.

Best regards,
Stanislaw
