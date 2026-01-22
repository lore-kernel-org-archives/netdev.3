Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66731D735
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088474; cv=none; b=gAAWhfqKA89Gm1woFsrGRbyrD9Ghm1PV9m5gPlKIE68YovmiZTSZRLVo1k1ui1fScPmsDa59HRer8OZ2Cog7VUERT2pJgpwWCn43G/Ir2BRo6ua+zaJu+rgXHYR8gG7teNynDVHAvgkQawwsj7xyOEmWn/zanfCsQZMgjRszbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088474; c=relaxed/simple;
	bh=BIijEftzm8tqAfHFDR9frriPj9CLtv4pJAHgkUQlbdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMQ8RSUhXrQjxtp4DfKPAXAmIgBcv1Y9uICxbvQ80W/VEEKVjnX2jCrK6ZAywshAxoWLEaQ9ABqgfJ2XIw/yRWsScZFuRADD/A9KW37MBXfwNQfJaZeknNN0u/uj/EZ8nCYmm+N3vj3revlBz+OWLb0G6MxmrjJzOEZCJqlZYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ae68+X5l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ae68+X5l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 866281A2A7A;
	Thu, 22 Jan 2026 13:27:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5BF8F606B6;
	Thu, 22 Jan 2026 13:27:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C519A119B8048;
	Thu, 22 Jan 2026 14:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769088470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=djGfwvmrTmNc0irErrvCNhFoMsaGmfcYs58l7bW923c=;
	b=ae68+X5lxnXt3XxxV8P6iz6PoMUYRdUJGGLlXRF7vfa+mIAiR7SjoWAXG9dIq3XTDFhn6L
	aYBpU124e9ASWeHYraDHPb/mihWhpMwkaVpHGzWn7af5JwaLE9N20WbT4SJV3ErBMZvA7r
	oWMm09Cz25wGgVvPXsGZXKAFljOYg7afcm8S2hswmg0YLvgxFRhqL0bCKK/Qp89G4/wRdG
	NtALMWgdDxOGYxy/63tZq6RxvdR3E7Hu6MGZtqCck3nc80saBWCnSIszt64M4P5cCpsMpW
	2/wPWZs5fTKYFUYRyWTW5REvrbFkoL2gxgmQTc95+xyJILvrZD1elyZjH7dZ+Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 22 Jan 2026 14:27:40 +0100
Subject: [PATCH net-next v2 6/8] net: dsa: microchip: Enable Ethernet PTP
 detection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-ksz8463-ptp-v2-6-b6683f5ce50b@bootlin.com>
References: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
In-Reply-To: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

KSZ8463 needs to enable the Ethernet PTP detection to fire the
interrupts when a timestamp is captured.

Enable Ethernet PTP detection.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index cafb64785ef4c7eb9c05900a87148e8b7b4678e5..fcc2a7d50909c4e6a8cf87a3013c3c311c1714b0 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -947,8 +947,8 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	/* Currently only P2P mode is supported. When 802_1AS bit is set, it
 	 * forwards all PTP packets to host port and none to other ports.
 	 */
-	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS,
-			PTP_TC_P2P | PTP_802_1AS);
+	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE,
+			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE);
 	if (ret)
 		return ret;
 

-- 
2.52.0

