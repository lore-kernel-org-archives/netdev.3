Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D623D7D94;
	Thu,  9 Jul 2026 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579363; cv=none; b=BYFf8LYWtEFRZds+orcrwDBGlYs1jiVetmR5e/ccpQDzV/QdbVFowp9JcMDPWLoedBZxcdLJAV6TUeQ3YxdNi69gw1jFssGZgo4fwpnQQGVrTcENF/kxXFIsIy7qRSOtVVkWCsGQl/f1kgvzd4WOUkgL1RqTJdgdtc6zGS3LDl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579363; c=relaxed/simple;
	bh=sIqRl8nj7fhsaHoNfU6gxSrWFODdtNEWV4abkjTv10o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TPizz+da5F9c7W/qHYGNBqwjjW3UndGEHBVo6drpOvkxvx2b0C7M49LXP34ZVzXTCLv26SpLZfhy7810D9vs+gQZ5fSCbF/eSjk1TxCCkKt3iis2QF4O6oI61OB8JMBVgHvLyvUfB2nUK2Vv09NnAg+kF0tHyQ4bP9XAbOeHTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JkQ335j6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JkQ335j6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E640CC2F4C0;
	Thu,  9 Jul 2026 06:42:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4BD45FF03;
	Thu,  9 Jul 2026 06:42:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D6FD11BC2145;
	Thu,  9 Jul 2026 08:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lHI43/71o6g//1+/ZN/imjts4lJXPoUki77Sz72H31M=;
	b=JkQ335j6G+s1i1qOOPfvRWiH9Oc0IwSeCIDySDgrekWvvStt8oqt6oYDvE3+t9eZF/zDF7
	/IF76CVF+wgAAxPI+jh//jutbeTaw3vEPpMICfK6sgg6Ym9zUhtuC29f9iG/a2JX0FI0I7
	vmcajRU+Wj6pYeGK4EZaNrb1oEsyElOpGzClfgO/fVavxdG1SdVqY7V4gjRw/klGUopLyl
	FqKYB7r1IwBsxvjhhfU9LRBkm7Rrx0hcAgLLznlVKClaNSK4U5gdtjTlEz43ZWcMPOuz8O
	grnbJ9agQOg3GR0oX9CSgm/dvDkEIJXZD1rTh53/+txqj3uC5xggMbFqKK8UuQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 00/10] net: dsa: microchip: add PTP support for
 KSZ8463
Date: Thu, 09 Jul 2026 08:42:26 +0200
Message-Id: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL73YI9KOsq0YfVWktgolJSdPekz
 4GZecCTY/LQZw84OtnzYRIUeQbzpsxKyEtiKEXZiFZI3P2Nhi60waLu5DJVQklVa0iFdaQ5/rc
 BDIUkxgDj+36758snZwAAAA==
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

Patches 1 to 4 add interrupt support for the KSZ8463
Patches 5 to 10 add the PTP support for the KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
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
 drivers/net/dsa/microchip/ksz_ptp.c     | 261 ++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_ptp.h     |  16 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  10 +
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       | 229 ++++++++++++++---------
 9 files changed, 713 insertions(+), 138 deletions(-)
---
base-commit: a6cfd2762eb18cde4eb34906599ffa7b07c2ed60
change-id: 20260708-ksz-new-ptp-f98db30a8a4f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

