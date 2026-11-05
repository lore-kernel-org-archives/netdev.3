Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887025;
	b=jfXbg69Xhs2FhKw1mAIDIQUiPnE549W6OPZpHd99BGBejjDSkrSfWaXY/pwLddnyu1oi
	 9bLyr6/AyW/Xu59cQQ+EEoTDzWWa0i5bPvNe6c3RueX8uHSG6dZoFutod9pAaPypyJy0e
	 /qlAD0i1CArc8vKW0Zfy9uJpNC2zKNKk9nsNKgmNjnZYFJC05vlK2nv6gD0G1oj/dGnny
	 Sb86VSnMO0ll8T2nk0NvJKk1Blew+Nz8TwTYsA3Dl3aVir8345Fy79CsYpsvRFOsxsIs7
	 4isC7WXAPKBC+GsBuAvUnkynr/ICoo3+L+qpvDkOYN9zb6KqcwVwpT+2eE4/gnTWw7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887025;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=mV0eR3zcFL59/gKxALQPqK/kdG+NtDO8y5QoP7EPEfw=;
	b=mbM4qgi+tsUBIN96ulm0EwgZcr7QtII/8aZ8HLASd3+xSWUsKoh9IPqhisIAN9UU8seg
	 2s1PuKi0goiF1x2rAWQoicWmVQXHpu1XOvlU8GELBrv0SIFl48PCbNnsiCSybWJR52mig
	 yvAIZ9ipOWlRZj3s/QcdGasLNDKoPGeUdBqQcHA5vj/ls+z2STfe6B+hpCl0B98KTW/22
	 7M6zLbXgYcvmTSWcML85LoK2fARDA6HrsVgXquh7Cmr9zy3ejckwM0epKqumLuyTprl+Y
	 +A6eFk6rGgjGLJieC41n7uOHXgbR5HnTDWM42Mwv0Phat4MT67j3FtOHXyOGwIxKmEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Sfn3AZo7;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369B606A336;
	Thu,  5 Nov 2026 13:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7369B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Sfn3AZo7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793887024; x=1825423024;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=88NXNcK6U6Tk7gXrhIP2CLooB+AZ9/2lOZ0n99JxOB0=;
  b=Sfn3AZo7zNRAywMakCEXY/GljzggYBmeQmr+mfHDpuo6AXpnWdHLQPg+
   HNQvjoJawQmam6BK4N0rXnKlM+yf0JNvFZsMS5NwueEYi8c0/daBxv1nQ
   xLOA+Xy+geFRzw4jjE5GFr+quNSpdsSRqf1/wgemSxO2wvcKf0QWhHZjj
   BB9Hl/3DiVuUQu+2rwv1AqqT8X8o98tR4V03wzNobK2iuz2hnT8yuICxN
   W9eJxSrMhh2Ay86FxOiu0EyTeNuWrXR58/KzzMZ89D233NvWCQbtzUvi8
   7VgvokIp9ZPINNuEBQDHxz/wkpgBwHa7UtpqoYx+2/FAIpL/ptebpI1oA
   w==;
X-CSE-ConnectionGUID: KkTdR4AuRu+n78BIXidZOw==
X-CSE-MsgGUID: TZNWC1brQ7aCmVU9PFLTwQ==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="233136487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:57:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 06:57:03 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:57:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:56:36 +0100
Subject: [PATCH net-next 1/9] net: sparx5/lan969x: stop the FDMA channels
 properly
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
Message-ID: <20261105-sparx5-mtu-change-v1-1-f27bab580463@microchip.com>
References: <20261105-sparx5-mtu-change-v1-0-f27bab580463@microchip.com>
In-Reply-To: <20261105-sparx5-mtu-change-v1-0-f27bab580463@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>
X-Mailer: b4 0.14.3

The FDMA channels are activated by setting their bit in
FDMA_CH_ACTIVATE, and are disabled through FDMA_CH_DISABLE, after which
a channel finishes the DCB it is fetching before it becomes inactive,
as shown by FDMA_CH_ACTIVE. The injection and extraction ports are
stopped through INJ_STOP and XTR_STOP.

sparx5_fdma_stop() tries to stop the channels by clearing their bit in
FDMA_CH_ACTIVATE, which has no effect: the register only acts on the
bits that are set, and its bits are cleared immediately by the
hardware. It also never stops the injection port, and waits for
XTR_BUF_IS_EMPTY to be 0, which means that the extraction buffer is not
empty, instead of 1, so the wait always runs until it times out.

Add the FDMA_CH_ACTIVE register, and make sparx5_fdma_stop() disable the
channels and wait for them to become inactive, stop the injection port,
and wait for the extraction buffer to be empty.

The stop sequence is used by the FDMA deinit, and by the FDMA buffer
resize added later in this series.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 46 ++++++++++++++++------
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 11 ++++++
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 15ec9b053824f..bcae0bbd5e44e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -20,6 +20,8 @@
 
 #define FDMA_XTR_BUFFER_SIZE		2048
 #define FDMA_WEIGHT			4
+#define SPX5_FDMA_STOP_SLEEP_US		500
+#define SPX5_FDMA_STOP_TIMEOUT_US	10000
 
 static int sparx5_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 				     u64 *dataptr)
@@ -86,10 +88,6 @@ static void sparx5_fdma_rx_deactivate(struct sparx5 *sparx5, struct sparx5_rx *r
 {
 	struct fdma *fdma = &rx->fdma;
 
-	/* Deactivate the RX channel */
-	spx5_rmw(0, BIT(fdma->channel_id) & FDMA_CH_ACTIVATE_CH_ACTIVATE,
-		 sparx5, FDMA_CH_ACTIVATE);
-
 	/* Disable RX channel DB interrupt */
 	spx5_rmw(0, BIT(fdma->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
 		 sparx5, FDMA_INTR_DB_ENA);
@@ -125,9 +123,9 @@ static void sparx5_fdma_tx_activate(struct sparx5 *sparx5, struct sparx5_tx *tx)
 
 static void sparx5_fdma_tx_deactivate(struct sparx5 *sparx5, struct sparx5_tx *tx)
 {
-	/* Disable the channel */
-	spx5_rmw(0, BIT(tx->fdma.channel_id) & FDMA_CH_ACTIVATE_CH_ACTIVATE,
-		 sparx5, FDMA_CH_ACTIVATE);
+	/* Stop TX fdma */
+	spx5_rmw(FDMA_PORT_CTRL_INJ_STOP_SET(1), FDMA_PORT_CTRL_INJ_STOP,
+		 sparx5, FDMA_PORT_CTRL(0));
 }
 
 void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma)
@@ -447,6 +445,11 @@ static u32 sparx5_fdma_port_ctrl(struct sparx5 *sparx5)
 	return spx5_rd(sparx5, FDMA_PORT_CTRL(0));
 }
 
+static u32 sparx5_fdma_ch_active(struct sparx5 *sparx5)
+{
+	return spx5_rd(sparx5, FDMA_CH_ACTIVE);
+}
+
 int sparx5_fdma_start(struct sparx5 *sparx5)
 {
 	const struct sparx5_ops *ops = sparx5->data->ops;
@@ -468,20 +471,39 @@ int sparx5_fdma_start(struct sparx5 *sparx5)
 
 int sparx5_fdma_stop(struct sparx5 *sparx5)
 {
+	u32 channels = BIT(sparx5->rx.fdma.channel_id) |
+		       BIT(sparx5->tx.fdma.channel_id);
 	struct sparx5_rx *rx = &sparx5->rx;
 	struct sparx5_tx *tx = &sparx5->tx;
 	u32 val;
 
 	napi_disable(&rx->napi);
 
-	/* Stop the fdma and channel interrupts */
+	/* Disable the channels, and wait for them to finish the current DCB */
+	spx5_wr(FDMA_CH_DISABLE_CH_DISABLE_SET(channels), sparx5,
+		FDMA_CH_DISABLE);
+
+	if (read_poll_timeout(sparx5_fdma_ch_active,
+			      val,
+			      !(FDMA_CH_ACTIVE_CH_ACTIVE_GET(val) & channels),
+			      SPX5_FDMA_STOP_SLEEP_US,
+			      SPX5_FDMA_STOP_TIMEOUT_US,
+			      false,
+			      sparx5))
+		dev_warn(sparx5->dev, "Failed to stop FDMA channels\n");
+
+	/* Stop the fdma and the RX channel interrupt */
 	sparx5_fdma_rx_deactivate(sparx5, rx);
 	sparx5_fdma_tx_deactivate(sparx5, tx);
 
-	/* Wait for the RX channel to stop */
-	read_poll_timeout(sparx5_fdma_port_ctrl, val,
-			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val) == 0,
-			  500, 10000, 0, sparx5);
+	/* Wait for the extraction buffer to be empty */
+	read_poll_timeout(sparx5_fdma_port_ctrl,
+			  val,
+			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val),
+			  SPX5_FDMA_STOP_SLEEP_US,
+			  SPX5_FDMA_STOP_TIMEOUT_US,
+			  false,
+			  sparx5);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 1464fd1a1d447..df438be0ec552 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -4713,6 +4713,17 @@ extern const struct sparx5_regs *regs;
 	__REG(TARGET_FDMA, 0, 1, 8, 0, 1, regs->gsize[GW_FDMA_FDMA], 148, r, 8,\
 	      4)
 
+/* FDMA:FDMA:FDMA_CH_ACTIVE */
+#define FDMA_CH_ACTIVE                                                         \
+	__REG(TARGET_FDMA, 0, 1, 8, 0, 1, regs->gsize[GW_FDMA_FDMA], 180, 0, 1,\
+	      4)
+
+#define FDMA_CH_ACTIVE_CH_ACTIVE                 GENMASK(7, 0)
+#define FDMA_CH_ACTIVE_CH_ACTIVE_SET(x)\
+	FIELD_PREP(FDMA_CH_ACTIVE_CH_ACTIVE, x)
+#define FDMA_CH_ACTIVE_CH_ACTIVE_GET(x)\
+	FIELD_GET(FDMA_CH_ACTIVE_CH_ACTIVE, x)
+
 /* FDMA:FDMA:FDMA_CH_CFG */
 #define FDMA_CH_CFG(r)                                                         \
 	__REG(TARGET_FDMA, 0, 1, 8, 0, 1, regs->gsize[GW_FDMA_FDMA], 224, r, 8,\

-- 
2.34.1

