Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486681;
	b=0Utgb94FXvRY1lfa//ImSIS4XEV+NC63kP8LK/7fKJLzu9ZHth5NdZzBIC4pEURpCJsB
	 WUCsyRjYDq+nmR5ql4HgoE1jTwq54GFPMtHXqEgJbaJU5z6hK7Z95Fnfa28zVoeiWPkiJ
	 QeSF3rT8Bf6A6lUjjA6IS8rR5N61hBwtMsV41vR9UyCcUjSTTvyXdPcen2io0N3eePSjP
	 kkTrS51mLVKQEO6R0XpaOLgTEkgUWOLpOPN/HsKYadS+K+5VFf2fYIGslwYzofyHHG+ee
	 CUW8FSASriNKmUDKekaYVJUcdJfQcr9N0stiT4n7GqMMmtlSUPbHH3QWPwzNcZHwEJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486681;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=f2RC02k4kzNCEkVNB0+GicfGGVn/vdjSFeUmhuG7iU8=;
	b=JnoRORtKkNiodKsaZta1ievrz3KmBVJi+EUsaZJNfjUmmsCQxHPAzKilseaafRwEfCHm
	 9HFFokXYZGFN8DIb+/Nuucfd4gYd4zkct3z1KPgFcPHd3RImF5R0rSutURXBQTcX0b0KO
	 JzpxphHXnPbMkRXCuBmNexr4xCx9DoT11nsrHgx6d91p/Nm/LK8NYdIEnDFlHnXE989VU
	 zZA+6/9puWqKKdCsA8lE15BZYXvZO95IoNvaiiyimXnloiuOp/QJgvgk600katRIDWW9q
	 rp9QRXeu97gJZ8OwZ2XeFUJDgj9MAedyqqRDcQNEOuzx0yMcr/YoTYYyNG3durfxb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="McdG56U/";
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244F606A319;
	Tue, 20 Oct 2026 08:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3244F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=McdG56U/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792486687; x=1824022687;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=AG80YPxqxi+pkt3jLWqElJJ+6PD1MdH6CVxrcZj82s4=;
  b=McdG56U/R/HOvn8uLU0siwzVvPo10fW58sg+wwelkDwV4M3yyIEuZBIm
   oUf3OyPBD0v32vznMLvSxSD1HTP4EhPcHBAV9j+9TRaRTlhjofBY8M/gU
   nzeXqOKzRJwuW1tJzj2dxzNEO7xu2i88OvhBLfv3WGTdp+JoBETO+jnfS
   sbCcbrF/IuEN5a2sUl/I/Xr7jk/iJUvJ4jKOwKUiv+NMaz1NT611vuNsl
   xMfjdpPIW1EjMTLeZateG+SyxIIAitDx2E8oF5h5QoMsKiCGXw+4PqU2p
   cSwI4PB5Q+yo3F9qRd0oONd312NNRgO75BdwPDK23UWe3Pfa6P3M1LqDF
   g==;
X-CSE-ConnectionGUID: g1XMydjBTL6qIJKaVNKb0Q==
X-CSE-MsgGUID: +ALR+oy0QVOFf9U4GZMkCw==
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="65303176"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:58:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 20 Oct 2026 01:57:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Oct 2026 01:57:58 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 20 Oct 2026 10:57:27 +0200
Subject: [PATCH net] net: lan969x: don't disable hardirqs in fdma tx clear
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-lan969x-fdma-tx-clear-irq-v1-1-b9f9d1eda317@microchip.com>
X-B4-Tracking: v=1; b=H4sIAPYs12oC/x3MQQqEMAxA0atI1gasSrVeRVwUm2pAO2MqUhDvb
 nH5Fv/fEEmYIgzFDUIXR/6FDFUWMK82LITssqGuaq0qZXCzwWiT0Lvd4plw3sgKshzoet13nTe
 6bRTk/i/kOX3vEQKdMD3PC39ukH1wAAAA
X-Change-ID: 20261019-lan969x-fdma-tx-clear-irq-d86877f96431
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

lan969x_fdma_tx_clear_buf() runs from the NAPI poll and frees the skbs
of completed tx DCBs with napi_consume_skb(), under sparx5->tx_lock.

Before this patch, the lock is taken with spin_lock_irqsave(), so the
skbs are freed with hardirqs disabled. RX skbs are marked for page_pool
recycling, so when such an skb is forwarded back out and its tx
completion frees it here, the free path reaches __page_pool_put_page(),
which warns via lockdep_assert_no_hardirq().

Take tx_lock with a plain spin_lock(), as the only other tx_lock user,
sparx5_port_xmit_impl(), already does. tx_clear_buf() is only called
from softirq context, so disabling hardirqs is not needed.

Found with lockdep enabled (CONFIG_PROVE_LOCKING), which the assert
depends on. Reproduced on lan969x by redirecting received frames out of
another port with tc mirred.

Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index c7e0e58ff0f7..053d125eda65 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -54,10 +54,9 @@ static void lan969x_fdma_tx_clear_buf(struct sparx5 *sparx5, int weight)
 {
 	struct fdma *fdma = &sparx5->tx.fdma;
 	struct sparx5_tx_buf *db;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&sparx5->tx_lock, flags);
+	spin_lock(&sparx5->tx_lock);
 
 	for (i = 0; i < fdma->n_dcbs; ++i) {
 		db = &sparx5->tx.dbs[i];
@@ -83,7 +82,7 @@ static void lan969x_fdma_tx_clear_buf(struct sparx5 *sparx5, int weight)
 		db->used = false;
 	}
 
-	spin_unlock_irqrestore(&sparx5->tx_lock, flags);
+	spin_unlock(&sparx5->tx_lock);
 }
 
 static void lan969x_fdma_free_pages(struct sparx5_rx *rx)

---
base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
change-id: 20261019-lan969x-fdma-tx-clear-irq-d86877f96431

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

