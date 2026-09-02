Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D23ED5B2
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343066; cv=none; b=toWOvZS32jtiQ4YLN6vzoOBI2/pZfub0fLPyS3NjpL75mYwS/FwOmHZZX08nx/YcYR4PelMWr0ASXfjEirvXcShh4NE3/dSvkE66dMpLW8HYfNGS6tqEVo079xHfLC7HPwxagCRjIJWlCrg2kvHW29st7bdBTQJvTZtcBbimXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343066; c=relaxed/simple;
	bh=L09e8O4bJ2vjdcyt8bSaxZ5+yflALwEDgHh35FHwGVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rLtSKNz/DUhcuVJK3svOkASJdIyUyeOeMWkItG9aZuYUzQZwhzCVVG2Eu+hvTbw5CzSC6cwT3X9cykN+Y6hXTnYtKlfBo4kMgDLxSitaELrPG2KZqls9uEEulC4LyKg9/xXywAf1/J93kCpo0jWPBsJ45cyTBsNCLU0nWfzuFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vu4Ep/76; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vu4Ep/76"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8C2934E41428;
	Wed,  2 Sep 2026 09:57:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 579CC6053C;
	Wed,  2 Sep 2026 09:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63EED11C7930A;
	Wed,  2 Sep 2026 11:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343060; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=RTajQvpZKAY1ewUOktwAygv2WKLHyU04qkbLMJ18phE=;
	b=vu4Ep/76JZt0FXxKCCX6PvKX1EsD70NKN0/kxiSdgr5/pQUsFiDu+Rslk4GMaLjKFpuCBk
	S0VLboBO+Ka2S/W28vm1zK+PhjeCAlT928NOvlLXDBfN6VdxfP/AcG60U/3aHCH4f7w2h2
	FY+5srUk5ArGUXMTYkxoZ5YZ3D5D/oaAGagacPnhuyYFG8CCAFSALiCysCZWULLM/eBLCu
	ynQkzohakbXZKpOE4iysj3EokbHzGpuc0wRokawqVAPfLgTdvcBN09WhnAW0StFp+wvwrK
	i+YJM9MlcM4V+b6+3IA3tQxnXgUgo95Ah+E+TOvi8lljwj0gVKpz32yF58x7QA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v2 00/10] net: dsa: microchip: add periodic output
 support for the KSZ8463
Date: Wed, 02 Sep 2026 11:57:30 +0200
Message-Id: <20260902-ksz-perout-v2-0-6f277fcc9e68@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NQQ6CMBBFr0Jm7RimFURX3sOwoDDIRG1JWwlKu
 LsNbly+vPz3FwjshQOcswU8TxLE2QRql0E7NPbGKF1iULkq80oVeA8fHNm7V8SmP1WkmRQVFaT
 B6LmXeYtdwXJEy3OEOplBQnT+vb1MtPlfUNN/cCLMkQ5JdeZYaqMvxrn4ELtv3RPqdV2/fP0Mw
 rAAAAA=
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
Changes in v2:
- PATCH 1: Init n_pins for all PTP capable switches
- PATCH 2: Init n_per_out for all PTP capable switches
- Link to v1: https://lore.kernel.org/r/20260831-ksz-perout-v1-0-14202db763b3@bootlin.com

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
 drivers/net/dsa/microchip/ksz_common.c   |  22 ++
 drivers/net/dsa/microchip/ksz_common.h   |   2 +
 drivers/net/dsa/microchip/ksz_ptp.c      | 473 ++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz_ptp.h      |   5 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h  |  16 ++
 drivers/net/dsa/microchip/lan937x_main.c |   1 +
 8 files changed, 451 insertions(+), 71 deletions(-)
---
base-commit: f7f619ecda5761bd48578764ef5ff9e8fd97b916
change-id: 20260825-ksz-perout-af9813e12158

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

