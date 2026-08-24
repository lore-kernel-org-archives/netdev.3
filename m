Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DEE38B12A;
	Mon, 24 Aug 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608689; cv=none; b=E13wdu5Bqm+dC+Qy7tGZT+wsKQm2LvWrvCon5+RyiaVVETzFLuKvi72hPA46GJ2bNzi18kpw4cbukJW02mzq1CGlzA09Dg7r4PaT22YE8Q/GlQUEIuVLUbfRNGhGXPOHlx8sBODb32Q0Z7RMpSVvqLbKBFO2Ky6g7patIIQaSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608689; c=relaxed/simple;
	bh=pkAFmJuigvYgIsrAovteyZ5PCkK4XR7yCyJwVK79lOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKV4D0WUabeKN+5iQClspNMgmmIlU2PNeLFLcYpuUCyc3j1z8Rr2cANuVrUhjCJa15nosQMAH5g8KV/RfpEX95ZVtezPk0sCxBanmvOqtPeM8UPIMbZW3ONBIrxGdoP4idADhwJ9CRzph8DM78DLK74JsZahbsJ20U45amwqDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHAQNdWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHAQNdWt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6644DC2BCF6;
	Mon, 24 Aug 2026 21:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787608689;
	bh=pkAFmJuigvYgIsrAovteyZ5PCkK4XR7yCyJwVK79lOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gHAQNdWta2qMJ5gX84QFYn6Hm/ztH7pCwH4fcIJGRzl3zW87Q3gUNRF6R8gTdR0DR
	 XKHLxFdRQsGaI9owkdZilzMwIc23OcvNrTBs3plVTzFADAcCDszkMEv3XHLOca/a2A
	 JVnU4Rvv5AdXb0UgP3TTMpsegIvz2+/DJD6fbTrPxUDV51R7m7ufLaWVVMxu1fJmXG
	 bHKFzn6e+3G68/4EXveOZDOoM94JSwT3B+B5riINaquVtuz+FDHhl3xsujHHNByeaP
	 cXMjd6xTdPFMIIurUXy04H2Pi9DVBhfdokEUGMDIJJaNzmDTuFtw7+dc1wD4XQEw8U
	 a1G154V7u2fjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE0C5DF9C;
	Mon, 24 Aug 2026 21:58:09 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 24 Aug 2026 14:57:58 -0700
Subject: [PATCH net v7 1/4] net: ethernet: oa_tc6: Protect skb pointer used
 by two different kernel instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-fix-race-condition-and-crash-v7-1-4323279b18f2@onsemi.com>
References: <20260824-fix-race-condition-and-crash-v7-0-4323279b18f2@onsemi.com>
In-Reply-To: <20260824-fix-race-condition-and-crash-v7-0-4323279b18f2@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787608678; l=7080;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=zqk3r2t3r0sl1kUOPXDn+qOEFsXyzxoQsJMxF5xeQzc=;
 b=sB9bIaVM88lFlnw/KUXod1fPaDgSPHXP4I1u9ng0unEAsJ6FDkLrXyzIme6vUOSI2m5moBfxl
 PhwRLVfye7vC9/tWyb1Gn+JHvXHQVDHGhyaZvQ0Hr3BsifGL7vjStZO
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Threaded IRQ uses waiting_tx_skb. Transmit path also uses this pointer
without any mutual exclusion protection. As a result, it might leak skb
buffer, particularly if threaded IRQ sets disable_traffic true after
start_xmit already checked and found that disable_traffic being false,
if they happen to run on different cores.

On fatal error, where disable_traffic is set, transmit function drops the
packet and return NETDEV_TX_OK. Due to this change, skb_linearize call
is moved up to the beginning of the transmit function.

Since skb buffer may be freed from different contexts, dev_kfree_skb_any
is used to free skb buffer now, replacing one of the kfree_skb call.

oa_tc6_exit disables the irq before setting disable_traffic true.

Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - Updated the comment section for start_xmit function.
  - disable_irq is called first before setting disable_traffic flag
changes in v5
  - Fixed the typo in commit message
changes in v4
  - No change
changes in v3
  - Added the missed out spin lock protection for waiting_tx_skb and
    disable_traffic flag
changes in v2
  - added the missing prefix to the title
---
 drivers/net/ethernet/oa_tc6.c | 109 +++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 417c15d1ff42..2f45001be0f5 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -693,6 +693,26 @@ static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
 }
 
+/* Called when a frame that is meant to be transmitted, is dropped. */
+static void oa_tc6_drop_tx_skb(struct oa_tc6 *tc6, struct sk_buff *skb)
+{
+	if (skb) {
+		tc6->netdev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+	}
+}
+
+static struct sk_buff *oa_tc6_detach_waiting_tx_skb(struct oa_tc6 *tc6)
+{
+	struct sk_buff *skb;
+
+	lockdep_assert_held(&tc6->tx_skb_lock);
+	skb = tc6->waiting_tx_skb;
+	tc6->waiting_tx_skb = NULL;
+
+	return skb;
+}
+
 static void oa_tc6_cleanup_ongoing_rx_skb(struct oa_tc6 *tc6)
 {
 	if (tc6->rx_skb) {
@@ -704,26 +724,30 @@ static void oa_tc6_cleanup_ongoing_rx_skb(struct oa_tc6 *tc6)
 
 static void oa_tc6_cleanup_ongoing_tx_skb(struct oa_tc6 *tc6)
 {
-	if (tc6->ongoing_tx_skb) {
-		tc6->netdev->stats.tx_dropped++;
-		kfree_skb(tc6->ongoing_tx_skb);
-		tc6->ongoing_tx_skb = NULL;
-	}
+	oa_tc6_drop_tx_skb(tc6, tc6->ongoing_tx_skb);
+	tc6->ongoing_tx_skb = NULL;
 }
 
 static void oa_tc6_cleanup_waiting_tx_skb(struct oa_tc6 *tc6)
 {
-	if (tc6->waiting_tx_skb) {
-		tc6->netdev->stats.tx_dropped++;
-		kfree_skb(tc6->waiting_tx_skb);
-		tc6->waiting_tx_skb = NULL;
-	}
+	struct sk_buff *skb;
+
+	spin_lock_bh(&tc6->tx_skb_lock);
+	skb = oa_tc6_detach_waiting_tx_skb(tc6);
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	oa_tc6_drop_tx_skb(tc6, skb);
 }
 
-static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
+static void oa_tc6_free_ongoing_skbs(struct oa_tc6 *tc6)
 {
 	oa_tc6_cleanup_ongoing_tx_skb(tc6);
 	oa_tc6_cleanup_ongoing_rx_skb(tc6);
+}
+
+static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
+{
+	oa_tc6_free_ongoing_skbs(tc6);
 	oa_tc6_cleanup_waiting_tx_skb(tc6);
 }
 
@@ -734,9 +758,15 @@ static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
 static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
 {
 	u32 regval = OA_TC6_INT_MASK0_ALL_INTERRUPTS;
+	struct sk_buff *skb;
 
+	spin_lock_bh(&tc6->tx_skb_lock);
 	tc6->disable_traffic = true;
-	oa_tc6_free_pending_skbs(tc6);
+	skb = oa_tc6_detach_waiting_tx_skb(tc6);
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	oa_tc6_drop_tx_skb(tc6, skb);
+	oa_tc6_free_ongoing_skbs(tc6);
 	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
 	oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
 	oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
@@ -1177,8 +1207,7 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
 			if (ret == -EAGAIN)
 				continue;
 
-			oa_tc6_cleanup_ongoing_tx_skb(tc6);
-			oa_tc6_cleanup_ongoing_rx_skb(tc6);
+			oa_tc6_free_ongoing_skbs(tc6);
 			netdev_err(tc6->netdev, "Device error: %d\n", ret);
 			return ret;
 		}
@@ -1200,15 +1229,20 @@ static irqreturn_t oa_tc6_macphy_threaded_irq(int irq, void *data)
 	 * no need to attempt spi transfer, once it fails. Pending skbs
 	 * are already freed.
 	 */
-	if (!tc6->disable_traffic) {
-		while (tc6->int_flag ||
-		       (tc6->waiting_tx_skb && tc6->tx_credits)) {
-			ret = oa_tc6_try_spi_transfer(tc6);
-			if (ret) {
-				disable_irq_nosync(tc6->spi->irq);
-				oa_tc6_disable_traffic(tc6);
-				break;
-			}
+	spin_lock_bh(&tc6->tx_skb_lock);
+	if (tc6->disable_traffic) {
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		return IRQ_HANDLED;
+	}
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	while (tc6->int_flag ||
+	       (tc6->waiting_tx_skb && tc6->tx_credits)) {
+		ret = oa_tc6_try_spi_transfer(tc6);
+		if (ret) {
+			disable_irq_nosync(tc6->spi->irq);
+			oa_tc6_disable_traffic(tc6);
+			break;
 		}
 	}
 
@@ -1287,23 +1321,30 @@ EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
  * @tc6: oa_tc6 struct.
  * @skb: socket buffer in which the ethernet frame is stored.
  *
- * Return: NETDEV_TX_OK if the transmit ethernet frame skb added in the tx_skb_q
- * otherwise returns NETDEV_TX_BUSY.
+ * Return: NETDEV_TX_OK either on successful queueing of the packet for
+ * transmission, or on packet getting dropped. Packet can be dropped due to
+ * failure in linearizing the buffer or disable_traffic is set due to
+ * earlier fatal error. Returns NETDEV_TX_BUSY when there is no room
+ * to queue the packet.
  */
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 {
-	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
-		netif_stop_queue(tc6->netdev);
-		return NETDEV_TX_BUSY;
-	}
-
 	if (skb_linearize(skb)) {
-		dev_kfree_skb_any(skb);
-		tc6->netdev->stats.tx_dropped++;
+		oa_tc6_drop_tx_skb(tc6, skb);
 		return NETDEV_TX_OK;
 	}
 
 	spin_lock_bh(&tc6->tx_skb_lock);
+	if (tc6->waiting_tx_skb) {
+		netif_stop_queue(tc6->netdev);
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		return NETDEV_TX_BUSY;
+	}
+	if (tc6->disable_traffic) {
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		oa_tc6_drop_tx_skb(tc6, skb);
+		return NETDEV_TX_OK;
+	}
 	tc6->waiting_tx_skb = skb;
 	spin_unlock_bh(&tc6->tx_skb_lock);
 
@@ -1462,8 +1503,10 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
  */
 void oa_tc6_exit(struct oa_tc6 *tc6)
 {
-	tc6->disable_traffic = true;
 	disable_irq(tc6->spi->irq);
+	spin_lock_bh(&tc6->tx_skb_lock);
+	tc6->disable_traffic = true;
+	spin_unlock_bh(&tc6->tx_skb_lock);
 	oa_tc6_phy_exit(tc6);
 	oa_tc6_free_pending_skbs(tc6);
 }

-- 
2.43.0


