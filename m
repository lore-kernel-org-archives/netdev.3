Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5C486408
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336340; cv=none; b=f/th24ci55xLoT5pQKRUZm9Gfn7SMgcALVSsrn1tULtBHq9H6mZ4tmxnSS2fQUAmJiz/DMJNrBmpD30z2yRfhQjEzKDF175QcF0OjHR9/N8p9RcUuEFSsrKqcizrlIK2cHccUqxMJnrOKn6jzRkyRiV0FAtL+PRv/jDkV936U40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336340; c=relaxed/simple;
	bh=KwBI/s/phK6XF5xOttZL38UwP6LQV4XU+uU3Nh61kiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fwi0xHihKu4zTokCJJjjeHtnngig1bm7C4Q8Bb5TPz9WEoHJdkhRt/9d1jLmy6an1pD6OIOHLdzLFPs/uMLu/+3Wt/gpZTqOZI04iqnK9wsJKOx4eQytQRrktTBe8wnb4QQhLj5H/oIHwiAxnsmfNJGGhYYsn34EeFLqiw+H+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bSs/Z3nT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bSs/Z3nT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 22A294E41070;
	Fri, 25 Sep 2026 11:38:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D0ADC6073B;
	Fri, 25 Sep 2026 11:38:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F7B3103290D4;
	Fri, 25 Sep 2026 13:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336334; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=udC1CTmScPSdoLJTLvioroqZ+xERUs9yKL94jLli1yk=;
	b=bSs/Z3nT8iMFQmk4v/kVdx70dYY29rlS0rjpQsbp4FaXxMYKf3qruBNWBcvqlT3oQV7LPo
	0pFssI5Ojy0wFTVem3q24jTadFDNC6OjwNIU1+Ynk9s9zx+Co5Xmosojqr3amxvGgH9gXE
	G+I6iGxkMbp+q4HNxHKjEEOD+YsdcMokaxA342u1kBY6tgWa7Lqc16DhfsqMj01NVilZP6
	vRkxpZjuE2HYcQ7LH2vNJCqcR5U7e6nGHWB1ryNmQJ2ArNPiO9KRQgZZNkwMcad8XYbp45
	JH6hNdDDHPPNNRBsn5RVoDgVJ5hj1Ig2b2iOnwWQV28xYb9lTQQMduy8wb5o4Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v4 00/11] net: dsa: microchip: add periodic output
 support for the KSZ8463
Date: Fri, 25 Sep 2026 13:38:46 +0200
Message-Id: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNQQ6CMBCF4auYrq2hU6DFlfcwLqBMtVFb0laCE
 u5uxYUQl5OX75+RBPQGA9lvRuKxN8E4m458uyHqUtszUtOmm0AGZSahoNfwoh1694i01pVkHBm
 wQpIEOo/aDHPsSCxGanGI5JSWiwnR+ef8pWfz/g1ytgz2jGaU5WlqG1Hyhh8a5+LN2J1y9znUw
 w9XGawwJFxqEEIrVWEp/zFfYrnC/IMFQM01U7Uo1niapjd6b/uiKgEAAA==
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

Patch 1 saves the full request to be able to retrieve all its
information in case of restart

Patches 2 to 4 prepare the driver to accept different kinds of periodic
output settings.

Patches 5 to 10 extract a set of functions from the existing periodic
output support that can be reused by the KSZ8463, avoiding code
duplication as much as possible.

Patch 11 adds periodic output support for the KSZ8463.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v4:
- Add PATCH 1 to fix request configuration at restarts
- PATCH 7: Add checks on the period to ensure divide by zero won't
  happen later. It addresses a corner case spotted by Sashiko on v3
- Link to v3: https://lore.kernel.org/r/20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com

Changes in v3:
- PATCH 10: Fix build error when CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n
- Link to v2: https://lore.kernel.org/r/20260902-ksz-perout-v2-0-6f277fcc9e68@bootlin.com

Changes in v2:
- PATCH 1: Init n_pins for all PTP capable switches
- PATCH 2: Init n_per_out for all PTP capable switches
- Link to v1: https://lore.kernel.org/r/20260831-ksz-perout-v1-0-14202db763b3@bootlin.com

---
Bastien Curutchet (Schneider Electric) (11):
      net: dsa: microchip: fully save the periodic output request
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
 drivers/net/dsa/microchip/ksz_common.c   |  22 ++
 drivers/net/dsa/microchip/ksz_common.h   |   2 +
 drivers/net/dsa/microchip/ksz_ptp.c      | 490 ++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz_ptp.h      |   9 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h  |  16 +
 drivers/net/dsa/microchip/lan937x_main.c |   1 +
 8 files changed, 467 insertions(+), 76 deletions(-)
---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260825-ksz-perout-af9813e12158

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

