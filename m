Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD816422E24;
	Tue,  1 Sep 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284377; cv=none; b=MBcbZccF/zluJI7ZTsAbTrPK5Io63mf0JJzmK1pEHQ/b/1L0HMjEsXuSjEE0nUIT6KTJ/r4REqmSTPqR/GOX8AdF64jHTnSai5kxcR3LFcOw1cMdmYLqFsoVifM39m4Upvh3EgqdeCqn9K7wgsm5IeTgHT2jrtDHBUBEFfvAC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284377; c=relaxed/simple;
	bh=brRgzf3Ss+Y5Pn8Ig7krN1Wiwxb17pE/jkPm9QUAUU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKV7M9yuetQTsJFY/+zCEqSNy0ST6eFnOzl7fCSSRoOWschDgc16En9h1lEguWhezFFpFBY81kl+AwKuVpDi8zfCGywlklAEoGipQO0MSzXtJsEo97gyKzteWLds+O/ltuJorbzhtHtO1ks/tk4bE9Oh+4gYR4HSDUuP6Z5qGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Q3mD/obx; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Q3mD/obx"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1A6F11CBE4;
	Tue, 01 Sep 2026 19:39:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788284369; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=yaYTcMwqtVa0M3yBiLEIENksGgWSisux8D+DJ66BhD4=;
	b=Q3mD/obxohhoQhJx1+DWjTpFtl+CbFlJA6miIe2cUUTHHESUbF3nFo9vuetc8Lyscg90jY
	7aN5IE50F9pf6hz1IpweuXGok78zqbmK3be4P46aPxLv1HCN88cW9CJDy2vCFP9kohQyha
	auLBsDr17PGILLLOu7629EsIUWt1yrEG6DRur/R/VZjdmqozuTNeYy0H3G69lozgxp/tVZ
	Rj0gHqpCQB5ersro1kOYlc5MqoWojd6frrwSLFmM0BtgLbns7US14QUDi/bCJmtuuoAcCF
	zDpQgLDCbcIODQ8P6TSyAPAZN3LaY5SsBFodf1DXw+fJDfdVYGUpB7Wml6ITbA==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yicong Hui <yiconghui@gmail.com>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [net,PATCH v1] net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down
Date: Tue,  1 Sep 2026 19:39:14 +0200
Message-ID: <20260901173925.96183-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

KSZ8851 errata sheet DS80000716D-page 4 Module 3 [1] states that,
when issuing a software power-down (PMECR[1:0] = 10) followed by a
power-on (PMECR[1:0] = 00), the receiver circuit can fail to start
properly preventing communication. The Transmitter will still send
data, but no data will be received.

The errata sheet also includes a workaround, which states that,
it is recommended that the software power-down feature not be used.

Implement that workaround and drop the entry into software power-down
mode. The ks8851_write_mac_addr() calls entry into normal power-on
mode at the very beginning of the function, therefore dropping the
second call to enter software power-down mode is sufficient here.
The ks8851_net_stop() can only be called after ks8851_net_start()
was already called, and ks8851_net_start() also makes the MAC enter
normal power-on mode, therefore it is also fine to drop the call to
enter software power-down mode from ks8851_net_stop().

This will lead to slight increase in power consumption, but it also
fixes a sporadic problem which occurs at least on KSZ8851-16MLL, on
which this fix is tested.

[1] https://ww1.microchip.com/downloads/en/DeviceDoc/80000716D.pdf

Fixes: 3ba81f3ece3c ("net: Micrel KS8851 SPI network driver")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yicong Hui <yiconghui@gmail.com>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/micrel/ks8851_common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 4afbb40bc0e4a..cd8dfca22720b 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -139,17 +139,14 @@ static int ks8851_write_mac_addr(struct net_device *dev)
 	ks8851_set_powermode(ks, PMECR_PM_NORMAL);
 
 	for (i = 0; i < ETH_ALEN; i += 2) {
 		val = (dev->dev_addr[i] << 8) | dev->dev_addr[i + 1];
 		ks8851_wrreg16(ks, KS_MAR(i), val);
 	}
 
-	if (!netif_running(dev))
-		ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
-
 	ks8851_unlock(ks);
 
 	return 0;
 }
 
 /**
  * ks8851_read_mac_addr - read mac address from device registers
@@ -502,16 +499,14 @@ static int ks8851_net_stop(struct net_device *dev)
 	ks8851_lock(ks);
 	/* shutdown RX process */
 	ks8851_wrreg16(ks, KS_RXCR1, 0x0000);
 
 	/* shutdown TX process */
 	ks8851_wrreg16(ks, KS_TXCR, 0x0000);
 
-	/* set powermode to soft power down to save power */
-	ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
 	ks8851_unlock(ks);
 
 	/* ensure any queued tx buffers are dumped */
 	while (!skb_queue_empty(&ks->txq)) {
 		struct sk_buff *txb = skb_dequeue(&ks->txq);
 
 		netif_dbg(ks, ifdown, ks->netdev,
-- 
2.53.0

