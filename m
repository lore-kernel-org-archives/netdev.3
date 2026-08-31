Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D841A4E6;
	Mon, 31 Aug 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182735; cv=none; b=l3qNWQ8G6momgMI+OHsSTnKdUz5HVm9x+uAi4ilsLyqpjPW7UoX0+xtLd2lY3MH9JSAWDe5we2K9ENfwQ+22dO1v0XqOb4lNNLFcpZnwSe9s+3ne/ljIFX+IoaufpEJhRlv6q2utrb4l8OQgMFgng9muTn4zVJGTcQcYyMo5byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182735; c=relaxed/simple;
	bh=49i3Wy/o01AjTkHrA9kDLscGRch9BQXaI296bI61Rpw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cNfZLYou2dP6W1vbOtEZ7rTNLmCGPGOY7jrnLONx5oWMaSeKA+wn/XpE/HyrzcU9IqR5noOm3sDl36q39KKBvVmh0jgkfReCECeTt3cuVqQWpX2XFb9rF+8S/atx42xM+3m+NH454XE7O1PY5JHPxXNZZGK54T1F0q3V3oOn0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cpkaL1L5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cpkaL1L5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 67CF91A191A;
	Mon, 31 Aug 2026 13:25:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3263960231;
	Mon, 31 Aug 2026 13:25:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 495F711C78B96;
	Mon, 31 Aug 2026 15:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788182729; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=E0ghIy6MOrvwdOv+DJJHyscH/NwmNzOmp32tLip5H8Q=;
	b=cpkaL1L5vz87B8HwxIvG6rhrE/i2iDtFnWgKpSEQY9HkpofkoDFKWNbMi8KmTnni1bRigS
	cT9EYm541DAq4H12JaBCMqEcsbTD5UiFP6zf/0R6BqWA7+ZIRTaL/XX10TNxPGk2NhTzmt
	aLPZRCKkignSUh1iIRdsNPd3xc3th5xviM9PZxEkfSrxS4MYltZxD+ylKRc1/uJZmHk3ut
	9SV9LLDSpC7cGQoCMoMNeH+fb0oATahWfQlj2McmHmXCzdAlGw2Kn29rh3M1s0r4HQQNEt
	FSN0DSuq8dsT4lhkhQtQPMOdF3kEeYW+5UkLqPl7OF7UlBKE/ECrDFR/0hcSbQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 00/10] net: dsa: microchip: add periodic output
 support for the KSZ8463
Date: Mon, 31 Aug 2026 15:25:22 +0200
Message-Id: <20260831-ksz-perout-v1-0-14202db763b3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M0QpAMBSH8VfRuXbKJhqvIheLP05qtI1E3t1y+
 bv4vocCvCBQmz3kcUqQzSWoPKNhsW4Gy5hMutB1YXTFa7h5h9+OyHZqjCqhtKoMpWD3mOT6Zx0
 5RHa4IvXv+wG3zVTyZgAAAA==
X-Change-ID: 20260825-ksz-perout-af9813e12158
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This series aims to add periodic output support for the KSZ8463. The
way the KSZ8463 handles periodic output differs from that of the other
KSZ switches. It therefore needs its own set of perout callbacks
(configure, start, reset, enable, restart).

Patches 1 to 3 prepare the driver to accept different kinds of periodic
output settings.

Patches 4 to 9 extract a set of functions from the existing periodic
output support that can be reused by the KSZ8463, avoiding code
duplication as much as possible.

Patch 10 adds periodic output support for the KSZ8463.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (10):
      net: dsa: microchip: add the number of pins to chip infos
      net: dsa: microchip: add the number of periodic signals to chip infos
      net: dsa: microchip: use dynamic mask to check pulse width validity
      net: dsa: microchip: extract PTP callbacks configuration from PTP registration
      net: dsa: microchip: extract ptp_get_pin
      net: dsa: microchip: extract compute_width
      net: dsa: microchip: extract prepare reset
      net: dsa: microchip: extract time update
      net: dsa: microchip: extract time adjustment
      net: dsa: microchip: add periodic output support for the KSZ8463

 drivers/net/dsa/microchip/ksz8.c         |   2 +
 drivers/net/dsa/microchip/ksz9477.c      |   1 +
 drivers/net/dsa/microchip/ksz_common.c   |   4 +
 drivers/net/dsa/microchip/ksz_common.h   |   2 +
 drivers/net/dsa/microchip/ksz_ptp.c      | 473 ++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz_ptp.h      |   5 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h  |  16 ++
 drivers/net/dsa/microchip/lan937x_main.c |   1 +
 8 files changed, 433 insertions(+), 71 deletions(-)
---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260825-ksz-perout-af9813e12158

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

