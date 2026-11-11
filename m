Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407490;
	b=DfDw9GrGaSwdPBGBI6DBOYTPeukcZ4iS6Isu0qNyScH/FP3jF93xdFMt/aVnMDtmaxht
	 hbf7tTylrN/qEA/aAyLXm2+yXN6ZtPIi6jSDdumDNXTR9ZxC+kIxDXavRWlSZefqd4QJ0
	 +HLCw6F9RT6yA7PfOPTJGuDeCSXTuS4FW8iUJxmfcjCQ+NN8yQJT2j0BeXIIXr+WShWYG
	 eA40Z+ZZqVDvZO0FDBTD5LIEfTEHE+IBr1Pqe5XM5xqBz0gqet9kVgs91akMG8A8npEYF
	 VIvoxGyJhKp3K67KtdDzrtB2sA6XBTd7ERvxYHEePvjhf6a+mJDnmbFbDkzUucHTxyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407490;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=Ns1YeimGAsOs3Z1Cmj4o6AHpOqtHj5g4xVeuZOEVRn0=;
	b=NyCnosTVBOm1ijxem0foaaBYKaQ5zpeQRvak6wPrgJiwNQ+sVDil8EV2/WdVZJJHXg8O
	 S50IQJnMOL0bYxgkQ3utaY3aIvhkpqlQfRh10rBufBeCpXFHDs07LGB2nWPGrDHzdwOjV
	 TftqqcbPAWk13znfgTQt8yqr5LxeLx9aGEe24Yqh1ixEO51Z7yW7YgcCUQ9VCGO/S7Z1n
	 oJ8Itx0sJtNfkkVJ1GFkMy1WVALIj3CSC82lwGl+1iQZaqwq9uthOt+AKn/p6MhrLkCFl
	 X4tqcjCba8+O9ft2aVozK2A0mENCcRkWm78yqZW9+I4ZX6tUqDj2Q/y6kIhGPRyh8wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=PSWMG4ro;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442A606A33C;
	Wed, 11 Nov 2026 14:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C442A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=PSWMG4ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794407490; x=1825943490;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VYNPjjF2MIMlznZcgdyhsEylSs9Yra3CK6TUB4nM0g8=;
  b=PSWMG4ro69Ljs3+AFrW5WOwzLNRtwQ3vUVeApNQh6KdOZeQL2n4ewm1o
   bWbdLPnoaCorD2TSLiDj/tVySTle2h3IU39z73VvDgWMK2LChwzTi25sh
   dNZ08qtLmzxk/o79EKJsGiL+1Z5v/pmQbKhZe6VQC5FwlqFyo6Mv6XgrU
   GTTvlgEaqz+6CEI++cWl1tiHiJyxUee0pA9RcJO59lYlwXs86gDWuKHq/
   jh39puoQxcZJZA3//yQ81OwI7D3ySYBxNxX56ZcppvlVFvRI42rD76Ke0
   f70ogTyeEi8efKgOWpGNF/WjG6mBzOxsBBXkTc5+lqqKkA6jRHp4gZVAW
   A==;
X-CSE-ConnectionGUID: uDXNW5CRRBOOiUbnJttyfQ==
X-CSE-MsgGUID: M+S++q9YQjKlPD2dacsLXg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="66598087"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 07:31:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 11 Nov 2026 07:31:28 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 07:31:26 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 11 Nov 2026 15:31:11 +0100
Subject: [PATCH net-next v2 1/9] net: sparx5/lan969x: stop the FDMA
 channels properly
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
Message-ID: <20261111-sparx5-mtu-change-v2-1-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
In-Reply-To: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
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

The issues were discovered by an AI code review agent and confirmed
against the datasheet. The fix was tested by unbinding and rebinding the
switch driver on Sparx5 (PCB135) and lan969x (EV23X71A).

Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")
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

