Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C7433032
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787749; cv=none; b=R1DJ/kkUqqeMGhwtIXeseeVo1jKYcvjzsi8xy+GfuBuF26j76m2grfOQeFpz4PZIObzEXeBAilfsCkVnu0xzBn/7xjo5++7yHxsgatImb8OOcd3NX2u8zG+Lfkmg4p89S0Cb3Eak6w4J19YV5qCDg0+2ZsyCjk1OZA085ajI2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787749; c=relaxed/simple;
	bh=Zj8ljX2iP4cV10Q/+qiv29C4kXrtslw6skNOnU5A4zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJACSGc7aypMFQzzJHOgokDwyIhvIIR+GvCTliUjQSQ1aE10THPY88utR3gOt/ExplN5+oH05SwNgr6AMM2HfHKpg/F0ZwVSXTAvQqhZtgpYcCWE8FZT4N3zr/t7+2yA+xlaV9TkO6SczJWu37aXPq8Dr1l1POVNiebTKE5KfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pyEND/lS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pyEND/lS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 123A91A13DF;
	Mon,  3 Aug 2026 20:09:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D33B96029B;
	Mon,  3 Aug 2026 20:09:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BD2F11C31859;
	Mon,  3 Aug 2026 22:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785787741; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T4UQOD2lvOpEjM3yH3RxEruIPXtMmVbNk2g8lQpYEao=;
	b=pyEND/lScTJwLrHC48goSXzzPgB9r52kxnTxmm7/TS1/OLNcIPl5B2CEZjunXJGJwtksdX
	2Mtk7EaNMi+oxNtb0bftP+m/SauGWnpl0iFiMiZ3xIBrqe/W5s/jL4G/dwWBt2Tc0eZKax
	LJl6gc17qgCJHFPwcDUeBx2BACG1U5TbGljDEnwwWMl3MNIhjB/XSh/3kB8Vsx+66G3T7z
	RFVEO+8R0OSLnX1QtFTqNjsxQFbUXKkJC8nM/JOPnMMGYAPkK8Gft8H5UOez0FWCCqRaKF
	to8ZFIgAl4OYMEtN6hRonZ4Gqi1W5OYrNGUMMa4kDRkIalFM83LIUzOuL5r2fQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 03 Aug 2026 22:08:14 +0200
Subject: [PATCH net-next v7 07/17] net: macb: refuse set_ringparam on EMAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-macb-context-v7-7-4d7d4af04849@bootlin.com>
References: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
In-Reply-To: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

EMAC has never supported changing ring sizes: RX is hardcoded to 9 and
TX is the tiniest ring buffer you can imagine.

Make sure the operation fails early rather than silently succeed and
storing values in bp->configured_{rx,tx}_ring_size that are never read
in the EMAC case.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index af351d30adab..1476bce77f34 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3687,6 +3687,9 @@ static int macb_set_ringparam(struct net_device *netdev,
 	u32 new_rx_size, new_tx_size;
 	unsigned int reset = 0;
 
+	if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
+		return -EOPNOTSUPP;
+
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 

-- 
2.55.0

