Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A438BA3D
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292727; cv=none; b=WElu4tylusjR/oGRtdcqu+2OihDzz7Y4CY8a3YTfDavECfT24dHzzvKKzyTI3HhdFaE7CcXs3AQ59tVhAq9ewu9hitiIvVTAEegma9cC0j5/+9dv3SiXmISpnoV3Nn6B4miMSWT3iwRst3qGSjGL7yYlqSwGlWp2s4vv78qFxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292727; c=relaxed/simple;
	bh=g9RMEgiWClw5ItELtTqqQ0t+lmH5QNeGIam5qd1XJjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRa/pVogZlQ3yo6zNKrp35iY0t7bZfeSbYzudUlG8WSV659EuVP6vVdXxCebMa8uCjwGF8g6eGsYXd3yp2dRvWI8zTxb6gsEzn1MEwTLKESYx6IcfU6XdvrPaCttiWQYDsro/xHM7iJjpgaehb3hKl3sx2GkbdX9ooV2vqmLF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCfMCubP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCfMCubP"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b018fe8318so3739474e87.3
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784292724; x=1784897524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JY69kVNM1HjHKOX0LM99C+ydMzmKJRYOseNmpgyzZYE=;
        b=oCfMCubPTxNMbZ9fp6owAqhwB3anBcJU5sCUDhU+5IEVufFu5q8a7gWjheCy9znoa6
         VOmaIlV6PkUXCTB+eAt+YvnKppYAoCMU8Wl+F/zODMWcXKMK2iGIrP52isyCARb6FyB9
         knQv+D1jJBLtTrx/eRXVBJuyMR6Ef9Hk2buwc+MScW2Ox772dL0vOowDM3lhwN6gwlLs
         Pyg8PP/WION3q0J9SzFg67EgwjPecM5FPrO5WJb8yQfuZCpSjMjquawU4xMiI3mYYQiD
         8abtiYWppI6h4wjPr+oT0hANfDoovaBJKeQK+TumqYuAcYYIPbq9amL8KKYF/IL9xbVw
         DM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292724; x=1784897524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JY69kVNM1HjHKOX0LM99C+ydMzmKJRYOseNmpgyzZYE=;
        b=bL7OzY491Dj160W/xFp7kvxHnSG+xREMQAk9UAphH0OuVdEfihsZugdwUsOLXZZbi3
         eSqXf4uDSwECRnG3k2sUtiMs5EJiuemUKJ4PUw399k9e/3lFo+YxmKp0AuwUQ7zHcG3G
         To2+bkEZKTHanvcHOgClKqL6JVx54QeAkR5uA21ZOiOhQTU3+zSOzum83dGo1Wq4Nv+M
         67Dmp6ducm+CL23XqBoYlJbz4fap0yx9LcdiWlZ76LWAL/RI7pxB/j18qW4hzxJLl4ju
         bamgFs7uPqdT9Il7x7CmX2GKX+re98YVJBdJ4xbd4Pt+4UHh7dOHgy+sjWkAVnEIJLJf
         fdFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPL/Skwx93HxjJi4DZTia80xBiGU1u9EW2bHjL7JLxfw1BJ7prPBURaMKkwCFRJirO7R/eGDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd53g1HMuixVs+10Yp/QI1Wf12q3Ma7GyoYwT7zm+yx4EXdaJO
	148CWyUs8UfEuMOStSIjdTxZJAaV8sxpzPjou3JbteieizpttWjbXfSn
X-Gm-Gg: AfdE7cnICMu/6Sd5ee0sVAQTTw4QFYPi/1GoBK8VWnGVZXnFygq5ub5ekm42a4Hs3fm
	ZjTnNrvYJ/sq6QJz6LCY3N3YCvRCgmT7Czv4QrGxxTYGaH6Ja+ddSxIuLEIdYdSg+WulHVN8/7p
	qkMWatWARghjvPiRrf9N0Xt3FQ1TustUFa4plqKi/TgJoSupMSZRW9ZdeqyKzWhKj2TsDtAAWqG
	B8HRXpQ4GJwskaGMmn1orr6Yu0d2WGeves8mOiXmG1S6Bc7TkPxs47JL9AtqbDq+91d+thVhc1y
	2obFSMJYrr8hzxb+6bkuqjDqm55+aqPsonaCLZZ+iWVyOXHmlZ14eIeklNs4/NnnO7xapYOTFWK
	21LI+b06FFu6HQa3HT4IYng5PLWuQCF0VlISXSNI5aCTvGwx98U01pPkyN51+v1YKW26Fi6StHG
	09EohYl2x0lGwf/gWqhOY6Ea2NNiy293ZvpFc=
X-Received: by 2002:a05:6512:6202:b0:5b1:5f28:2198 with SMTP id 2adb3069b0e04-5b28f8732bamr486267e87.3.1784292724137;
        Fri, 17 Jul 2026 05:52:04 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c10:dac8:fc6a:1741:e55e:e7c4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291d9a8easm315661e87.27.2026.07.17.05.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:52:03 -0700 (PDT)
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
Date: Fri, 17 Jul 2026 14:51:55 +0200
Message-ID: <20260717125155.18915-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e252cb3c-bfb2-4d62-aec7-e04b9aafe223@yahoo.com>
References: <e252cb3c-bfb2-4d62-aec7-e04b9aafe223@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I have been testing this series on a second RTL8367S board: a TP-Link
Archer AX55 v1, where the switch SerDes runs HSGMII (2500base-x) on
external interface 1 to an IPQ5018 gmac1 (stmmac, fixed-link), on an
OpenWrt 6.12 kernel. Some cold-boot results that may be relevant to the
calibration discussion.

Test image carried, on top of the v6 series:
 - the SDS indirect-access busy-wait fix, and
 - the ~98 ms PLL-settle delay plus the 0x060C-0x060F "Local Jam
   Table" analog calibration proposed in this thread.

Result: after the router sat powered off overnight (multi-hour cold
soak), the first boot still came up with the trunk degraded - in this
run completely dead. The switch reported link up (2.5G/Full), no
CRC/symbol error counters moving, but dot1dTpPortInDiscards climbing
on the CPU-facing port, and the WAN never got a DHCP lease (ping:
sendto: Network unreachable). Milder runs of the same state show
55-70 % packet loss with sub-ms RTT on the frames that do pass. So on
this board the analog calibration, like the BMCR data-path reset and
the busy-wait before it, does not prevent the cold-start bad state.

What does cure it, without a reboot: a full driver re-probe. Unbinding
and re-binding the switch device re-runs the whole probe path - the
GPIO hardware reset of the RTL8367S plus the complete chip init (all
jam tables) - and the trunk comes back clean immediately:

  ----- BEFORE: ping upstream router
  ping: sendto: Network unreachable
  ----- BEFORE: CPU port discards
  dot1dTpPortInDiscards: 17 (climbing)
  ===== echo <dev> > .../unbind ; echo <dev> > .../bind =====
  ... wan: Link is Up - 1Gbps/Full - flow control rx/tx
  ----- AFTER: ping upstream router
  20 packets transmitted, 20 received, 0% packet loss

A soft reboot fixes it the same way (sometimes on the second try).
Short power-cycles (~1 min off) do not reproduce it; only a multi-hour
cold soak does. Anything that resets the SerDes without the full chip
re-init (BMCR data-path reset, repeated reset pulses) leaves the bad
state in place - one variant I tried even reports the port healthy
after a reset pulse while the datapath keeps mangling frames.

To me this points away from the SerDes analog front-end tuning values:
the first full init on cold silicon lands the chip in a bad state, and
a repeated full init clears it, hours later, with the silicon warm or
cold. That looks more like an ordering/settling problem in the early
init sequence than like the calibration vector itself.

On the hardware-health question raised elsewhere: the board looks
clean, no bulging/dried capacitors, and the 3.3 V and 1.8 V rails
measure correct. But this is a single unit, so I cannot rule out a
marginal sample - the cold-soak state does reproduce reliably here
every morning, which at least makes it a good test bench.

Happy to test any patch or instrumented build on this hardware.

Best regards,
Stanislaw
