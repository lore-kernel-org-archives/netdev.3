Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3A331A77
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634795; cv=none; b=EyEg8uYLfEVR4lql2dQ+C+b+GilMnAK4PpjvKMgo0tHzBnnJ/K6rjnG4ImJa3F+MbuUsjYIZMa/okR3Qw9KErzicpAE29UYurAfih4ZFzSYoyHEUmlA1Cr6dcuzKPCwaAV8RQKgLfiFWYwLTW0GDZunKYBZniyGGyu0ivzmp3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634795; c=relaxed/simple;
	bh=23LMxSEAIT885DK+6wLvQS8G/bVL9c1H0/jTTSPxv9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lERcNp5qYrMmunKfGR6c6/ya6Qc5oMJrs+g4zFLbiVOBDmdpcWc0RJZbdQe5SV6YMzSzaI/K95aOM9xyETqY4CdxjrUyPScurVPCdgjAg8yjaSV7RP8R/zZwHp+ybpyMl8LTQ+z0pOQFap/46g9u+tQ1fdME4Hd04LroO6Eqa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjQ6gFgD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjQ6gFgD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so85855575e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784634792; x=1785239592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUvV7afmqYlqEipeF9d5m1GMvfoS9Xm8gMJB5ttv1Nk=;
        b=rjQ6gFgD7hJVhwXVc2AfmBaypBRUjSj5jLQCWPooT8ExFeH7O7jP7oOP6c1DC1ns76
         UZhMN5yq9yYpiWAZ3O5Sd1oi/fGO/jvS1oXvTX/RAUEZT2LposDJeXkDx67yYxaHDwkm
         j5Nil5vXs9YWwFGjxofZdS5mSvtYyrbf2u4SjCRAf2hTMOxh6USHvQBxmvX6WM3GccCh
         udPc4SGx8ah8x74uVaK9qXi0SN99Glu4iYTnRmTtTxA9z3x0GE0u3urHurOOB00mK6LS
         39DehCpyHyja5A0pnFB/FcpHXB7MYE472v1d2RmJxAX69zJrW+fLL6KoJyAmt2vcpac8
         /8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784634792; x=1785239592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GUvV7afmqYlqEipeF9d5m1GMvfoS9Xm8gMJB5ttv1Nk=;
        b=tHg7UBpX1bUM7kgm9uotRxYQSGBNpTXl4KtulL/fmNw/T515CAYWCOmsmT/Z0YbIuZ
         0P1k847BMNZkpV+46QcKDAEssEJUq8LXni/f1OchzIYKvAEsGZldHTM7KG3JxTVUc7PX
         j+LzqhoVgo9rMOPzj4MWlMBXu/+oXU/c0CAgUHsXrKWw6u6kVChhidcX4kZiDx0RMoFa
         x5WTXEP0oP+ASNrTPx81pr+/1ym4segSGdMrGx+lhub7pprFwfn3CVyeHTVhDiMK1sA0
         9+mT2iNvvKd3eMMX/djcjkCgJ5GIv05CChIM/n9j7GxAaBQsPvIqOWmvzRc8Ffhnr1DA
         TDbg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0L98XHpNK6p1Is3CvtU+zo86b3yEeL1cIcCwIt8hL6exYWDpi/Q0icc8lj4ivI1fI5dAwHyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5G9fhAGuGxvFilEsqHT+UQjV7UbcMvObU0WDEmYE97vD7Xb6K
	ocErQ37h1cTt7qXi0pId0RYs9gP2mwYmiYo/Wb8Fi8RV787ymtLkxv75
X-Gm-Gg: AfdE7cl73D7DqHzjS/+6MlClVJt99bPsT0VLJg/K+MpckaOnW0zEH/hd1yNVmhCvQDh
	TNLbPn4Y9TFnAx9oAyIRi71kIxUJjBB/s0grz7am11UMIsw6cO6f24l0+ftXAC570h7mW5kYBZ+
	mq+eeU8GNB37lMg9dQmzwYyVf++4t7rBa8loBxE0SchzZXneKMYnuoaI31MwlcFN9q1mT3QRlal
	qS//O38sRLPJkzwDAWRt8lHRrWenuJPv8NGyYp81JzLOB/FuegBCSS9Ay9oS4KzNjvj5uv0er4N
	BcGXFLa/qxYuNgjNyjnNJWYKVnYdTQGMHPgoWGWIPutyHSG32FzNWCZb29wTPUonPofUdha4GJ4
	Y+WoZD4AdCkb+qH50b023MalLOyiy4tvvgzfw6r85V7vY3TiNP3uHeq9eZKjYF2Mhd6Z0P/4v32
	MBt+doLTLMN5BimEd5EvGQnvJQRL93+o8TmlUYrTwNFqf3szdCGw==
X-Received: by 2002:a05:600d:9:b0:495:5e07:649b with SMTP id 5b1f17b1804b1-4955e16aca3mr95087105e9.24.1784634792191;
        Tue, 21 Jul 2026 04:53:12 -0700 (PDT)
Received: from localhost.localdomain (public-gprs192503.centertel.pl. [46.134.91.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm38875194f8f.8.2026.07.21.04.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:53:11 -0700 (PDT)
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
Date: Tue, 21 Jul 2026 13:53:06 +0200
Message-ID: <20260721115306.15144-1-kuncy7@gmail.com>
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

Hi Luiz, Johan, Mieczyslaw,

Resolved, and it was not the driver: the cold-start trunk failure on my
Archer AX55 v1 was a failing power supply. Apologies for the noise, and
thanks for the time you all put into it.

The A/B/A that settles it, same image throughout (v6 series, no
busy-wait, no 0x060C writes, no pre-init delay), same ~10 h power-off:

  old PSU  -> bad on every cold morning (4 documented occurrences)
  new PSU  -> clean, twice (including a 10 h soak)
  old PSU again -> bad again, last night

The last line is the one that matters: putting the old supply back
reproduced the exact same signature - link up at 2.5G/Full, no CRC or
symbol errors on the link, but 326 FCS errors and 326 drop events on
the switch's CPU-facing port, nothing reaching the WAN wire, and the
switch->CPU direction byte-exact clean. Only the switch's SerDes
receiver is affected, and only until the chip is fully re-initialised.

In hindsight the earlier evidence fits: the 180 s pre-init delay
"fixed" it because it gave the supply three minutes to come up, short
power-cycles never reproduced it because the capacitors had no time to
discharge, and a driver re-probe cured it because... well, see below.

> Another test would be to dump all switch regs before the first reset
> and compare what is different from the state after the reset.

Done, via the regmap debugfs. The SerDes-related configuration is
byte-identical between the bad state and the healthy one afterwards:

  SDS_MISC (0x1d11)      bad 0x1f00   good 0x1f00
  SDS_OPTION (0x13c0/c1) bad 0x0000   good 0x0000
  ext-if mode (0x1311)   bad 0x1016   good 0x1016
  MISC_CFG0 (0x130c)     bad 0x0043   good 0x0043

So the driver programs the chip identically in both cases; the failure
is not visible in the register state at all. (The rest of the dump does
differ, but that is counters and statistics, and the "good" dump was
taken after the reset experiments below, so I would not read anything
into it.)

> I would expect the CHIP_RST (bit 0) to clear everything, but you
> never know...

Also done, on the bad state, in the order SDS -> DW8051 -> NIC -> GPH
-> CFG -> SW -> CHIP:

  SDS_RST, DW8051_RST, NIC_RST, GPH_RST: no change at all, the FCS
  error count stays exactly where it was and the trunk stays dead.

  CFG_RST, SW_RST, CHIP_RST: inconclusive. The counters go to zero, but
  so does the switch configuration, so the trunk cannot pass traffic
  afterwards for reasons that have nothing to do with the fault. I
  cannot tell from this whether the datapath was repaired.

  Full driver re-probe (reset + complete re-init): cures it, as always.

The useful half is the first line: none of the resets that leave the
configuration intact repairs the datapath. Whatever the marginal supply
does to that receiver, only a complete re-initialisation clears it -
which is consistent with the register dump showing no difference to
repair in the first place.

I will run one more cold soak tomorrow morning, back on the new supply,
to confirm the A/B/A closes cleanly rather than resting on a single
good/bad pair. I will only write again if that result contradicts the
above.

Nothing here asks for a change to your series. If the maintainers want
a Tested-by for the RTL8367S HSGMII path on this board, it has been
carrying traffic reliably for days now on a healthy supply.

Best regards,
Stanislaw
