Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B53FC5C3;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600492; cv=none; b=Qz4r30zkKRHHXcp4RCBGi1ELdYuzca37iY4Sfvrvk10/fn1NmXFRVfDAqA/0cf7t8zElrbfWLhugjtuAT83sS4MIbhRmnexVJlEb952BLcI5sJ+E89jgNVYMkpQXZB26m8I3yx/4P/rJ8tAawRf7u3KfJra0jzPErK6d9aBnepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600492; c=relaxed/simple;
	bh=cpsPDNbTObDrhmsVuo4YfvMITcMiSGI6Oq8yYAd7T/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgYJtNFTe34Gd8y8SSJ9ieNxAhaiBCV58bqVv4eCLt4W6BPGNcOM9OV/zicsjJ1P3GX226nlHUVcso/GiuYw4vtITw7+zciLYD9qSXZhJ30qLH1hixqhkfE7lcOw+10pFRF9mqKOGvZuRohALeSVD5MRZelQS1KIdSF8tSMQxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRi4SNM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRi4SNM3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCD44C2BCF7;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784600491;
	bh=cpsPDNbTObDrhmsVuo4YfvMITcMiSGI6Oq8yYAd7T/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BRi4SNM3bu4DYAD3lTBhsXpWpyBHNp9CjMQl2iukycipnGDZr7f+pStlDKaLzieMv
	 7I/1Yd72Ky+o1j+MS4FlLR2bcGS5bgKMOEZUE62RUQsNkS8xMXj/ufPRXFO9Sa/aqD
	 4ucPt11Lo7bMIEjo6ACqfgC5+CPQQRJqwS/fUeOAszFqjcZyeOHHPcduXlF2poUQgQ
	 ePqhZlu0bpBG7oKt/cAgo8g3iGr/Ybobw4JZYk6hUxffMhwVnBtteEwq6fuunGau17
	 eBPSQJ/53zLU4j8RVz0PyewKseGO0pQln3Gi9zJnd1zqkPGyfTPqn4xHXwxq8eChTy
	 Unmh3a/6EtRgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D4C44520;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 20 Jul 2026 19:20:35 -0700
Subject: [PATCH net v4 1/3] net: ethernet: oa_tc6: Protect skb pointer used
 by two different kernel instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-fix-race-condition-and-crash-v4-1-8273e2f38a1f@onsemi.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
In-Reply-To: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784600442; l=5762;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=PtJKXxiHIQ65kW4ADgjT422PMBMh9A+ziMoUoFppues=;
 b=oJHhMqZ0P+P1VXVB3w7NrLpJoIFeXU+WdK75pJrqVkAFct8tSf3tI07VkThX5l9MlIa1HpOBd
 rsVZkSUMVP0B9ohNDU2Wk+3VoYeyhhEf0/05hyafYEMZQbbtZzTnTwd
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Threaded IRQ uses waiting_tx_skb. Transmit path also uses
this pointer without any mutual exclusion protection. As a
result, it might leak skb buffer, particularly threaded IRQ
runs in the middle of tranmsmit path, near skb_linearize.

Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v4
  - No change
changes in v3
  - Added the missed out spin lock protection for
    waiting_tx_skb and disable_traffic flag
changes in v2
  - added the missing prefix to the title
---
 drivers/net/ethernet/oa_tc6.c | 100 +++++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 0727d53345a3..5b24cce4f9b5 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -652,6 +652,26 @@ static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
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
@@ -663,26 +683,30 @@ static void oa_tc6_cleanup_ongoing_rx_skb(struct oa_tc6 *tc6)
 
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
 
@@ -693,9 +717,15 @@ static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
 static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
 {
 	u32 regval = INT_MASK0_ALL_INTERRUPTS;
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
@@ -1136,8 +1166,7 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
 			if (ret == -EAGAIN)
 				continue;
 
-			oa_tc6_cleanup_ongoing_tx_skb(tc6);
-			oa_tc6_cleanup_ongoing_rx_skb(tc6);
+			oa_tc6_free_ongoing_skbs(tc6);
 			netdev_err(tc6->netdev, "Device error: %d\n", ret);
 			return ret;
 		}
@@ -1159,15 +1188,20 @@ static irqreturn_t oa_tc6_macphy_threaded_irq(int irq, void *data)
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
 
@@ -1250,18 +1284,22 @@ EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
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
 
@@ -1393,7 +1431,9 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
  */
 void oa_tc6_exit(struct oa_tc6 *tc6)
 {
+	spin_lock_bh(&tc6->tx_skb_lock);
 	tc6->disable_traffic = true;
+	spin_unlock_bh(&tc6->tx_skb_lock);
 	disable_irq(tc6->spi->irq);
 	oa_tc6_phy_exit(tc6);
 	oa_tc6_free_pending_skbs(tc6);

-- 
2.43.0


