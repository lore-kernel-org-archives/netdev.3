Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB619443
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784446531; cv=none; b=Te9H2CLxJzcN8euvNBPvJAeT01MLnGcMf7jszZhMqgZEDDZzWOur2rYz7IjGCsKpnM2CRU0aJcLYUnBiTh7AUiJHi5C7e8vj0wxlyIh5oQwB/H2imaCDiMw9nEpA0IsIhRZuAdmOtLXchcNmqsVJ96LNhfyc9KQeHamaZ0X90TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784446531; c=relaxed/simple;
	bh=4ecBlAcbYQf2cS+lrV+mfChuXK9dvIG474QSj/Aj9KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/lIAJXe0eHAa95u1DZtaadrA4otAy9/hyKTprD7MB4l4708YIct7jLL2xGJxEdW9hQeVg19Pvz5KN1Oerq2f3nhBH8oDyiSr/1ouPCwqxzX0bqfWgwDAZFutFQ2TV+t26QSQUexk4819nKCdekTHZhZku0qwnZDk6Q070AVIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZtUrjb9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZtUrjb9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4798bea72f9so4702541f8f.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784446529; x=1785051329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Imm+2HdKzD/NJViR1a5kBtUfxMpdoo/1H9QI/inJ3Ik=;
        b=NZtUrjb9VTAqAM3mVZxFrpIcPbVP9dDroJhTd1q4m6K8i7pqVRYqBSwG4SH8e5+E02
         MuAlfAIm3Bm+GjLC6I+pOj6TgwirlACQ6rsrYNhtVnppEIhpudPHmpefKNfOXjVdEIpe
         cv3mTIHQht+f/ZafvvpmHwujvlMexZV4EWoYlzkODeGt/HVUtv4Y6wKNbv0kE6+RS3nH
         rOR/Vko9IJWEangB5ay0mog+RQtcPZGQXK1tBQ9hyA5NkVpwdLuZPDUlzXjvZsRXyzrM
         dpb9EQU13mKdiQeuRqdaMkBiyj/8ipNr3OzRfapaz/CL63FsOfjufePWNP3fux43EVhl
         XKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784446529; x=1785051329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Imm+2HdKzD/NJViR1a5kBtUfxMpdoo/1H9QI/inJ3Ik=;
        b=N0/XwhNW2hAyvWZsDHXUPSZQ2YLLvuvXKe/TjBRWa+YSgREGekC7qsjYd794qlG4Gc
         GIqgFwmYwh075bu/tqr6DZosVv06sWCPBO60uzA3bnvIUBKKxA5Xhu7VejXcJFd1dfaM
         2jCz19opuBWb462xaCMbr2ut7YJ7SUZWSBCA9YNYt/RBtEAt0GL6Ah5xJI46niTedHYL
         axCzaQ+XNc64OcOiQS8Kl+lJCzQj17wmnkzWberpX18E+XkBcMjkkXPCj9jcfPtbz2JT
         zpDYTyz0IG+C4L9uFB45Bm3HzWZWKyaUC3vic8+b56sM3lw6kGsXAw2xBSIGWULEIzC+
         2Okw==
X-Forwarded-Encrypted: i=1; AHgh+RrkmRnoaBRe8eZzncATYqaw8OJChgFPgfjQeiITHdoLgpL3m1K2L3pyru/vLrd+pSHGjP0psRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKLm8eKWrTelMweK/GlhmZhdI8+NaouRUV3SYkb8+R3aU62nFi
	/PfznM+ViioX2jxJsbBbkmjswwhBLNXVE5VpCuiMPRPg9imif4a3uag5
X-Gm-Gg: AfdE7ckm9+HQZ/O4rhcZvhm+NDrwUfSUOyIbRQwQVGT1p6z+ZfHy/0f8MGYBRyOaQzJ
	VKrgTze75Etw0XbKGAhQLHlQ7qdpmZygDQMvngSms5AwZVTBwQnKDmWFTlvXqTpphgb0E6xheGO
	rl+4m71sPy3ZgyAIeUTdkH2HHEuUQB7TDBWa6K+RkCQc19w0cFcgZZFI5S6Bl2HoE0mFH1AtYRt
	fO2HvEXxYP2AFvhNGkpLa9F2uzdpOZGaCV6kW8pCVoZDdNIiYYhI64p1bgy7jRyhxrPdpcLvrGY
	PXIj5GNb44nB4PbOYk2EILp1UGucSyoCZdZIL/9nDmKhMGpRBeVUbwLvqA6JmUxtzGKZgdiobkA
	Xz4LaYS0dCzNopYb9fw1V5qJSXRD1xP37rwQMdn4P8/3KL2TXF7Z7OnpcdoHhsZFSlQICWKDyWK
	BgfFAXP9pCugesoBdXXOyqMrgGwJAeIAvayI4QosPDNHv1zoZmR1kVM90/mRTRHyU=
X-Received: by 2002:a5d:5d82:0:b0:472:aaba:faed with SMTP id ffacd0b85a97d-47f6232c345mr10116308f8f.31.1784446528361;
        Sun, 19 Jul 2026 00:35:28 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs693195.centertel.pl. [5.184.251.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f69e5eff1sm11116540f8f.19.2026.07.19.00.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 00:35:27 -0700 (PDT)
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
Date: Sun, 19 Jul 2026 09:35:19 +0200
Message-ID: <20260719073519.10947-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJq09z4TX=LFOX7iq2g_JwkjtLM1U_Q=aYvAkd123LgOwZNyUw@mail.gmail.com>
References: <CAJq09z4TX=LFOX7iq2g_JwkjtLM1U_Q=aYvAkd123LgOwZNyUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Two updates from the bench: last night's cold-soak result, and a
correction about the reset GPIO.

1) A 3-minute pre-init wait PREVENTS the bad state.

Last night's image carried a plain msleep(180000) at the top of
rtl83xx_probe(), before anything touches the chip - and nothing else
on top of the v6 series (no busy-wait, no 0x060C writes). After ~10 h
powered off, the first init landed clean for the first time: 0 FCS
errors on the SerDes CPU port, 0 drop events, DHCP lease right away,
0% loss on the trunk. Every comparable soak before (same hardware,
overnight off, no wait) came up degraded. Single morning so far - I
will repeat it - but this is the first thing that has *prevented* the
state rather than cured it after the fact.

During those 180 s the chip is powered and out of its (bus-level)
reset, just untouched by the driver. So your time-vs-state
discriminator leans "time": the very same init sequence that lands
bad when run at t=3.5 s lands clean when run at t=187 s. It does not
fully separate "the switch needs time" from "something else on the
board needs time", but nothing else shows any distress at t=3.5 s -
the SoC-side MAC/PCS come up fine, and even in the bad state the
switch's transmit direction is byte-exact clean.

2) Correction: the realtek driver performs NO hard reset here.

I mis-stated this earlier: reset-gpios on this board sits on the MDIO
*bus* node (the IPQ5018 MDIO bus driver toggles it once at bus init),
not on the switch node. rtl83xx_probe() therefore sees neither
reset_ctl nor a reset gpio and the hard-reset branch never runs - I
confirmed it with a print inside that branch. So the curing re-probe
is a pure *soft* full init (detect + complete setup/jam-table
sequence, the only chip reset being the soft one in setup), no pin
involved. The "double reset in probe" scenario does not apply on this
board at all.

3) Next steps, along your suggestions:

- Bisect the required off-time with the no-wait image, to get
  reproductions on demand instead of one per night.
- On the next on-demand bad state: full register dump via regmap
  debugfs, bad state vs. post-cure, plus the reset-bit isolation.
- Then bisect the wait itself (180 s -> 90 -> 45 ...) to find the
  threshold - that number should hint at which physical process we
  are waiting out.

Best regards,
Stanislaw
