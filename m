Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28013F4DF3;
	Mon, 27 Jul 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147660; cv=none; b=GEUUi8aCqHyFAvoXuQi7yoX0yj83L1eY+rLMVHiIzsYF8FBMHxT4zWQbPGcZNpLlyMG7xraAMDoQ085i/K44+6zpzq77nXCGgwl/94orfj6mRgD0sQ447gZanztiR5B2qkEJX5yfikaHazRmCWoGHpeeGXsn/9QkNCSmX7LgBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147660; c=relaxed/simple;
	bh=rnu6X2pJt4x6mWKpVqd92woCFP22WdO5nlIFRmh+jC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLt9T/mXFJSwO7C6iviblNjTH80Mwib/C9rxdtjvNad1wLaNLCB3dTXzSofKjQITVAbLmVR3q2fq22GQJS2hVRSaB0HcA0yC1o/H3l/4pVkwXPXxf7BbpxGkgrAEHIwqKF96RIUajXH5pPe+p+9I8/09wE+SBI5YpdsJQwQdKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z2LvTuZ6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z2LvTuZ6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E00741A128C;
	Mon, 27 Jul 2026 10:20:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AAF04601BE;
	Mon, 27 Jul 2026 10:20:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C8C311C1319F;
	Mon, 27 Jul 2026 12:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785147654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=RVOWw/WS8TLltO0HR3fHhbhidjo9Z47lbx+xvA9KS00=;
	b=Z2LvTuZ6hRoKGVk6pxzPkO4BcToeeM70FJjFjDC3UBqR36bHhS4t1OCJUbQd92maOugQJK
	W2e0J3zipXRGGTfgmX8Qesouv0E+6WvJwLIfujNYHpr7oJb3ZqSBzXF179mYuqPhpzNPaq
	clRG+KA5WvzhNAmQ6kBj8QHs1Jgjguea9EFAmPKQMO38pPuqplWah5a3cRlIqVf6VZafdX
	lyDEIsJBNhZ5arVsJhebW/S6KffamYoXs3pcnU3SDLx2LlN1Weyu3xwCd/xDcPulnkbrrm
	x1DmCv8kA6l63CMbyTWz1FEH1YlXUTezGyv7g/Uv6xaMQH9BCmBbookjMmQZFQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v3 00/10] net: dsa: microchip: add PTP support for
 KSZ8463
Date: Mon, 27 Jul 2026 12:20:42 +0200
Message-Id: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw7CIBREf8XctZhbaC115X8YF31cLFGhAYLVp
 v8uIS7scjJzzizgyWnycNot4Chqr61JQex30I+tuRHTQ8rAkR+xRsnu/sMMvdgUJqYaOXQCW9m
 WChIxOVJ6zrYLGAppOAe4pmbUPlj3zjexyP3P2GyMsWDIRFkq5Ipq0dC5szY8tDn09plNkf/Rh
 djSPNE1x6bHCitJakuv6/oFHVikzvAAAAA=
X-Change-ID: 20260708-ksz-new-ptp-f98db30a8a4f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This series adds PTP support for the KSZ8463.

The KSZ8463 differs quite a lot from other KSZ switches supporting PTP:
it has a different interrupt logic and a different 'PTP engine'.

This third iteration addresses two more Sashiko comments from v2. I
didn't address some other Sashiko comments, I said why in the v2 thread.

Patches 1 to 4 add interrupt support for the KSZ8463
Patches 5 to 10 add the PTP support for the KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v3:
- PATCH 8:
  - Initialize KSZ_SKB_CB(skb)->tstamp to 0 to prevent from exposing
    uninitialized memory in case of failure
  - Remove the skb->ip_summed line as this series only support L2 PTP
- PATCH 10:
  - Add a check on the register's address before applying the offset in
    ksz_read_ts()
- Link to v2: https://lore.kernel.org/r/20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com

Changes in v2:
- PATCH 1:
  - Modify the commit log to explain why IRQ setup isn't done on KSZ8463
- PATCH 4:
  - Fix the error code path in ksz8463_ptp_port_irq_setup().
  - Change the IRQ request/free orders to register/unregister the top level
    handler first/last
- PATCH 8:
  - Free the skb if its linearization fails
  - Downgrade ip_summed to CHECKSUM_NONE when clearing the reserved
    field of the PTP header
- PATCH 10:
  - Ensure the skb is linearized before accessing the PTP header
- Link to v1: https://lore.kernel.org/r/20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com

---
Bastien Curutchet (Schneider Electric) (10):
      net: dsa: microchip: implement ksz8463_setup()
      net: dsa: microchip: split ksz8_config_cpu_port()
      net: dsa: microchip: allow the use of other IRQ operations.
      net: dsa: microchip: add PTP interrupt handling for KSZ8463
      net: dsa: microchip: adapt port offset for KSZ8463's PTP register
      net: dsa: tag_ksz: move the KSZ8795 tag handling below ksz_xmit_timestamp()
      net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations
      net: dsa: microchip: add KSZ8463 tail tag handling
      net: dsa: microchip: explicitly enable detection of L2 PTP frames
      net: dsa: microchip: add two-steps PTP support for KSZ8463

 drivers/net/dsa/microchip/ksz8.c        | 311 +++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz8_reg.h    |   1 +
 drivers/net/dsa/microchip/ksz_common.c  |  15 +-
 drivers/net/dsa/microchip/ksz_common.h  |   6 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 271 +++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_ptp.h     |  16 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  10 +
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       | 233 +++++++++++++++---------
 9 files changed, 727 insertions(+), 138 deletions(-)
---
base-commit: a6cfd2762eb18cde4eb34906599ffa7b07c2ed60
change-id: 20260708-ksz-new-ptp-f98db30a8a4f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

