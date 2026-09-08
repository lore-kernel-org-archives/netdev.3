Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3738B7D9
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852478; cv=none; b=KtRtRyg0H1nT4GYb9R49ZeaLDCrTuiPHLYPPEO69KcCwaizHhcWQRQS+zQufjQqC2HKPOjY4Hjx6Qm0s79se5LARNS3ow7gMqoR6Ih4UA5MZtzNGMMuLO4BYNaehwZ/XCVxbtP5eE8serdJ3SCJlBWXajqNk9RJyFSJDBUj6cPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852478; c=relaxed/simple;
	bh=p1ZcMHGo68iCWyW/brIIWAXY278T8hlmIapDoVvZ+rE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=av5vHaOgK2K0SkEJfgemhNl54LDxZJBYYrWc9KtjThSzwmpx+BLsJlf8OCSlDAKV7DysHpNgDNZD/Pe2Cw8JOtwZhfm2QvNZoXNZcUS86LLt5eHmtRgIMhd2Ofczl1cnplF9L8gojsU9v2kEyHhNk/60DeaPNzxQ2Mz/kOK6pdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=At/jTLZR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="At/jTLZR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A80DD1A1A51;
	Tue,  8 Sep 2026 07:27:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F0B1603C4;
	Tue,  8 Sep 2026 07:27:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98DEE11C7AF1B;
	Tue,  8 Sep 2026 09:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788852466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=YMCM4ejLgCs5i3vF09xaernSR5tuvNenK7m4oOC/9/w=;
	b=At/jTLZRCjQyQpjAPIvPXJBdB8g3EFbvh6K9BJwC+aiktiofqtFJoGrtNFKc2bgZuHNG9B
	rmAT1brTHxKAWlbsYGa90I/jo5hlMFdsI9pznDTwrqMpxAKk78gam+NaGd1TVNR7NCoic5
	3ZfDyAmXZXqm2T10hykkH0Q9KqFWMwC7ikT8nkN4LHzGW8zX4ii7VALXTfrvQ9eq/FqBoT
	MgM/dmqKQJHCW4Vct1nWcjqiFXJvggMIb8vM4BkSrjsP5onRVSiThsEICnlo9o++Nw88eH
	6g5JmUVynMHaU/yShg7CprXkDI705d8mF77xW5cH6qOhB7tK2Ovr0Lg5p87bIQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v3 00/10] net: dsa: microchip: add periodic output
 support for the KSZ8463
Date: Tue, 08 Sep 2026 09:27:40 +0200
Message-Id: <20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNTQ7CIBgFr9KwFsOPpdSV9zAuWvphiQoNIKk2v
 bsEF9rly2TmLSiANxDQsVqQh2SCcTYPvquQGjt7BWyGvBEjTBDJanwLbzyBd8+IO91KyoEyWku
 UhcmDNnOJnZGFiC3MEV0yGU2Izr/KS6KFf4Oc/gcTxQTTQ0ZD3wje81PvXLwbu1fuUUKJ/eSWs
 I3Msiw0axqtVAtCbuV1XT+sTXMZ7QAAAA==
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
Changes in v3:
- PATCH 10: Fix build error when CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n
- Link to v2: https://lore.kernel.org/r/20260902-ksz-perout-v2-0-6f277fcc9e68@bootlin.com

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
 drivers/net/dsa/microchip/ksz_ptp.h      |   6 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h  |  16 ++
 drivers/net/dsa/microchip/lan937x_main.c |   1 +
 8 files changed, 452 insertions(+), 71 deletions(-)
---
base-commit: f7f619ecda5761bd48578764ef5ff9e8fd97b916
change-id: 20260825-ksz-perout-af9813e12158

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

