Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B62382390;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488142; cv=none; b=gQwVPgAtnAAatxV+TZcLSSHo4zP0ee/PqWj5he3RbCwdjmwxrmnJhZeCS+1UlOhzXgP9sXSeoG2nSqck6/5AYywKOw5/n6L++9so6D/DM6Om9bMoHLepAU3nVIkswK8DwhYETXhQrT2Cu0ClCb8mBFpdv5/4wqvLN/s4WodsW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488142; c=relaxed/simple;
	bh=Q+gKrkpRPwP2RIn5A26eqqxVy5AJXmzKMBt9gEF1uco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNgE3NBDphiNiw3guJuQqKC+qZC/FWSt+BzCfa7yhGNv6kUtERgc3qx7PoNpOz3on9G5gn/kXqBKkoSeu36RykUys/W0+0e9niCIGo7EJC0bpQYt/np2cTqxkZOLo+ywcb9bfvFJX2rJPEtVFBIbUffBdRS2O2IgtMzW0/aO3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZRkguzM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZRkguzM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C16D1C2BCB8;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782488141;
	bh=Q+gKrkpRPwP2RIn5A26eqqxVy5AJXmzKMBt9gEF1uco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QZRkguzMKkPlhCX+QqBjSOVPcBXdAU/AqpUuwBOvMQrk+ScWHNsbc6N5SyeUMyQ1P
	 oPQFqsXO04eOZfitrdCl2AvDA99n8HMGdEoaUSZGaR8+H9ldO+1tsJ7Gw29VR6F0oX
	 /d6f+RMz963zk++QYRePEqZr7pIqOt+Dndv0d8v3FStDbAAP1aFR4jrDJMTu+sfotQ
	 +ChVVB06i3OU1QjyQ8Xsc2oJ0Fa19jwtnQk39sh3I1XRHWnK6Hz7e3ru6t3EEKerlw
	 q+iqRY7/2rygC12z1WEKYJCJcROgbur50/Tw7sn2zJu8T1m36PR5aevnC/r3F02Q2q
	 9DgCIlqv558qQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFF2C43211;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 26 Jun 2026 08:35:18 -0700
Subject: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer used
 by two different kernel instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
In-Reply-To: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782488122; l=2044;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=OkjZJSbSIVA4fByvXNyRrpLjXQomQvmd6ZJgYvG5XgU=;
 b=UMRuwZkIa/Yobi9/XzCOTZxNiYxds3C1KEyZpyMxocgmrmZd0FFAIu7myEWkBUN0Wai/E8Qzm
 5PlY0JoaNgRDUoyOAeYpVQmi7Ji7goQBj5sXkcpT/B6wFzhxHAcV7ur
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
changes in v2:
  added the missing prefix to the title
---
 drivers/net/ethernet/oa_tc6.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 0727d53345a3..3fd4851ee66d 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -672,10 +672,16 @@ static void oa_tc6_cleanup_ongoing_tx_skb(struct oa_tc6 *tc6)
 
 static void oa_tc6_cleanup_waiting_tx_skb(struct oa_tc6 *tc6)
 {
-	if (tc6->waiting_tx_skb) {
+	struct sk_buff *skb;
+
+	spin_lock_bh(&tc6->tx_skb_lock);
+	skb = tc6->waiting_tx_skb;
+	tc6->waiting_tx_skb = NULL;
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	if (skb) {
 		tc6->netdev->stats.tx_dropped++;
-		kfree_skb(tc6->waiting_tx_skb);
-		tc6->waiting_tx_skb = NULL;
+		kfree_skb(skb);
 	}
 }
 
@@ -1250,11 +1256,6 @@ EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
  */
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 {
-	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
-		netif_stop_queue(tc6->netdev);
-		return NETDEV_TX_BUSY;
-	}
-
 	if (skb_linearize(skb)) {
 		dev_kfree_skb_any(skb);
 		tc6->netdev->stats.tx_dropped++;
@@ -1262,6 +1263,11 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 	}
 
 	spin_lock_bh(&tc6->tx_skb_lock);
+	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
+		netif_stop_queue(tc6->netdev);
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		return NETDEV_TX_BUSY;
+	}
 	tc6->waiting_tx_skb = skb;
 	spin_unlock_bh(&tc6->tx_skb_lock);
 

-- 
2.43.0


