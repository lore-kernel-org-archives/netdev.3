Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D383246EB;
	Sat,  5 Sep 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613417; cv=none; b=WhgE1AyD83Lt2xmok3eQjRD1gXrYp09dlNW1cr4x8/My2Wpixtko3XgdyzdIaM8YsM+m3ZrwZVjQTTJmtOQE1Ujzg/LlLnPqh9TNxtU2Ysj8HP1HZc/4ktTiph4++VSxAGNqSFxAjKJDh9XQwj/VDLf1eOrGAnOej6ityCALm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613417; c=relaxed/simple;
	bh=LN2Nl+oClp30FFetV91S+xfkBUUmuWAqX2WMaLyGerI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8IYUhEug0BZ3fJ7IyYgIAMQSFXot5PH9tFm4PMA3HYOStC2SjH0luGfvNJU5rjMmCXlRycSVwy5q7Xbwrz6sFG77256LqXgL5WEwYlWP0oN8hRRAOau2YyM5ftXrBTyL/JlGorbD2WOySOqoOvzQ6JNcsShBQWnlCvzhDA8o0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=DWrOPE1n; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="DWrOPE1n"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FF2311D93E;
	Sat, 05 Sep 2026 15:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788613409; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CRm27CIkzUHms/d9b2xD02yImE+Y8Zj9TkTzg37Uq88=;
	b=DWrOPE1njNwaU+IihP/3ekiaqHXwmS70YcEtC6Fs/uC4z1dKwEUC+2ru3mSf43rICrWZEm
	KklH7CxOXJEZJk4SJDE8VimnaEzP4WAgzb5VlIn9mrfds8x020qK2duzQ4JXq3ch1/FDr6
	b7fttbCDt7sJcFqDEsDJCTlo6ioyMI3m+r3PCIAXh9wQqa7+IsePKY4SypVMP7yMKqWlGw
	QnJmmTnzm4gG6K6jwcWSbgkasTvkU1MBK5r1O3EVoY0Sy8j1PtYz/almrrsBd6cL0wwkhR
	VLA7sWz6QRGX2Mr8DNc2d6xspxubWAkvPYIYb5CXih2m7KCBympvU9TCKDfkyA==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [net,PATCH v2] net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down
Date: Sat,  5 Sep 2026 15:02:32 +0200
Message-ID: <20260905130327.203851-1-marex@nabladev.com>
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

This will lead to a slight increase in power consumption, but it also
fixes a sporadic reliability problem on at least KSZ8851-16MLL, which
is where the problem was reported and this fix was tested.

[1] https://ww1.microchip.com/downloads/en/DeviceDoc/80000716D.pdf

Fixes: 3ba81f3ece3c ("net: Micrel KS8851 SPI network driver")
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yicong Hui <yiconghui@gmail.com>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: - Add RB from Sebastian
    - Update ks8851_net_stop() description based on input from Jakub
---
 drivers/net/ethernet/micrel/ks8851_common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 4afbb40bc0e4a..d49f281c78676 100644
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
@@ -474,16 +471,15 @@ static int ks8851_net_open(struct net_device *dev)
 }
 
 /**
  * ks8851_net_stop - close network device
  * @dev: The device being closed.
  *
  * Called to close down a network device which has been active. Cancel any
- * work, shutdown the RX and TX process and then place the chip into a low
- * power state whilst it is not being used.
+ * work and shutdown the RX and TX process.
  */
 static int ks8851_net_stop(struct net_device *dev)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
 
 	netif_info(ks, ifdown, dev, "shutting down\n");
 
@@ -502,16 +498,14 @@ static int ks8851_net_stop(struct net_device *dev)
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

