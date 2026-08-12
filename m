Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872073AFD1C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521841; cv=none; b=oZHt4JuhRKxM/mLLH8bL/4bzXNeAt10YhVql7VXJE8xLgQhv9Nxjq5uDZT5S9kOHrzRZj1Pd6C6TICSlqIRftptpym6l2D4+Yuyr/dBWnx2hi9eZTxIgIb7F1Sm14xAQexB5plLPRCA4+ot81MxZ4KTRHqfAxmPoY1pJxI3yB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521841; c=relaxed/simple;
	bh=Zj8ljX2iP4cV10Q/+qiv29C4kXrtslw6skNOnU5A4zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huHcbLGW+Kym29ND2XJqHCL6FKLoHtE07J14fsCpbMvePtobFpBjBX8myiy4UckWlq1MXUM4RqyN7rhEBJIJeFjwDXBN17A4tv9kapJaY90XQYUN3frwrm5vxLCS0X9LU5jpLSQnm8Xv2HeXOUlF0gxWpBiH30ZIsfJphMWTPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j0AIb3B1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j0AIb3B1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1E4EF1A15AE;
	Wed, 12 Aug 2026 08:03:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E5C726045E;
	Wed, 12 Aug 2026 08:03:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25DBE11C4C93D;
	Wed, 12 Aug 2026 10:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786521832; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T4UQOD2lvOpEjM3yH3RxEruIPXtMmVbNk2g8lQpYEao=;
	b=j0AIb3B1YgWH14fKOVyvuAJ40iQrkDBbHRgtwEX+ESZWp/l2ymMNy9TMbenBxAZjxXZNLh
	43HPoqxwiUk2Rd3uenFVdWdvN1iVSE7s5VOg24ph8mdQe5+Ope8LRty5AiRaqFNvePws9v
	TOZUnecHpiMoOoAeSInX3KiV+yVUmHWMQRTikWyZ/hAftkByk8e+IkbCB+g8Z04uNf3ntp
	OOc9qnK3gDrATUvsLVIkSLkGZ2Gqoxhy/xRbDBZCZfIqyzKsqZFEY1/cNbU/6EQ1mUw0Io
	/z00LMS7E8Snay6HySxzHCtjy/Eoq8wwHDPSY2Re4lvOrinAmFcFgqzAcqjhUA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 12 Aug 2026 10:03:21 +0200
Subject: [PATCH net-next v9 07/17] net: macb: refuse set_ringparam on EMAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-macb-context-v9-7-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
In-Reply-To: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
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

