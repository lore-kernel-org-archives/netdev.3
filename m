Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C692E7398
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087751; cv=none; b=I5Z/6n7S1xlrKmcLhOqsryX4V9BC1VVg+C1q50KLGNtkLN60gWHZiwnYecIewH+EoiUDzjx0pzORi+ZHlIX4cofXtwDyaGQA2WaRLRG4hpYNtbYDSIob8WZpO+EnFURTtfegFg51aLu60Y8ctoYmPYCXefl/mgNcDLX1iFlg7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087751; c=relaxed/simple;
	bh=zzohzy9JWobljyd6RsmmbQ2VwiVvckUNzXlvTlatJfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMctDuypnyM3ODlZT+3pr4/MmQjRj84B6QmQjTwdTRyeXKW80qAx69/n968JMI3PBQ0jelThqsdj7JBh/m/sAAzU686toM7fTem15oRLSlxefPMPZvaW6h+8pwbF0f9UJihdMhbkb+lzjAWwVeaj7NnHi1+GAncrx2UKIxyLUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=mOGSbzKq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="mOGSbzKq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc61541f8cso17345905ad.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787087749; x=1787692549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=shTsftA/wYts9OPD5P3iDM+SEC7l1+GSIH4cvo8toIA=;
        b=mOGSbzKq3b1fKLfHAT7GR9mh1XP1b6xZiUDSa+TnccN6JHvy06Kgps9mnhVBTgMyDe
         z/MpNkU/8X7N0OZOLM1tums5PG3/HqxUq8WfxjK0lj0gE2+ioz+5uStH/QotByXUxcU3
         lihV2pRjPmJQGzHJsfyvs+QyWiPOB38KcZAY12hH+PR2BnVszdzjwd0Wh5n4NxeI2hLO
         Red7pQN30tudoMYc7b6mavbydXDOjSz5MIPLR9cs+v0DDnWBbqsmAnrXnII5bM6kwG2v
         Dj8bwzxwTavRIP1a0/8MC0R2imeNvBXiOC+njypk8l7K6meH3S998QV7w3maOorgIgMz
         LlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787087749; x=1787692549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shTsftA/wYts9OPD5P3iDM+SEC7l1+GSIH4cvo8toIA=;
        b=TPovg4mafxJHU/sfOhpAPPWOtqXRoQ9A8B1Qo3dDt6kUcqncS4n5a7DLADzGLxpIQ6
         3m1BKB5SEyKb05MTAOtIyBG4ihL4et0lEZWD2HcoKWJSiBVK3CdHQkAZJRZOD7d8sF9E
         73JmA4KNaqPzD95mePcLUnP8V7DSpY46s9VMpX3kSyvvVCZ9EAJjddoLoWBMtCSKkMwc
         8iX36TntxyaPaidDOhEA5YnvOxiUKPubFFJqFFE7RNyH4z55Z2ZDnCeQ2iDbmErL1E8T
         8TAN4rFPgEeNK4/7R4pzEs+KsPsXDrwS68lv/kwFqQqFV5PLZFBOuCGHwZDG34ip3AxY
         cbqQ==
X-Gm-Message-State: AOJu0Yw/JORptU98VaHZkfY+TA1jJ1JGtSt5/9muaIbWHzppEYEuQM4R
	oBbKTItBZY2r3nEt8dry2OOw2nzZHeTzEpKt0r5N13tZGZ0MJCxZG5SFkoLDCqkYFXhz3hkYZIq
	tVm+Q
X-Gm-Gg: AR+sD10rXOtrxy2BOrRX10nv8HdjSOAuwJ8QDHu0feZXnzjpK0gxhAabTGYyYvhp/oY
	jLT3eb1SurGM1Q46Gv4oPJlc5gNuVdlJTUffzSm4FM1rf1WeAYbfw7y39HYjaWhNmw4doqcKKZJ
	fszrF9pqWHqNQ5zDoUEGg14hhQPCioAecYVBWA04Eun9Cl1uAllSKx8RbUDd20PcWs2+FJ71g1A
	118e6yRzKPIKiImZrLePXdGe3TkbBhBQmkRzqyJvkI2SlMtuXKE3PO7gaSnoIVdf6xb4oaVhPZL
	3iiiy0q/cJudiDY/S6oRGWUZ9/8r16SIvR35gAfZJR0q/YUDOqS9DRGx1rxJ4oGj1uRXe01lZa3
	8i4jOa3J/cQ9/eemIvGgaCl8p3QhEUWl5C3B5wjmU8aiDW13fvsGSeOlJVDGvBGUVGmoTpra/Yh
	9IANFKDkYEgmb/UIf4Bwv2LFUF28+lTslheSPMgi/mMQ==
X-Received: by 2002:a17:90b:5630:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-3957f68f7bcmr272542a91.0.1787087749324;
        Tue, 18 Aug 2026 14:15:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96cb6bsm71220a91.2.2026.08.18.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:15:48 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: bnxt: ring the doorbell when SW USO exits early
Date: Tue, 18 Aug 2026 14:15:39 -0700
Message-ID: <20260818211540.2991183-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a burst of packets is handed down to the driver, the driver defers
the doorbell to the end by setting txr->kick_pending = 1. The normal TX
path handles this, but the SW USO path can miss it if it returns
early.

If bnxt_sw_udp_gso_xmit runs but returns early with NETDEV_TX_BUSY and
txr->kick_pending was previously set to 1, then the TX queue can
stall because the driver wrote some BDs but never wrote the doorbell.
The device won't know to do the TX which would generate the completion
that would wake the queue back up.

Fix the success case of bnxt_sw_udp_gso_xmit by clearing
txr->kick_pending when writing the doorbell. When bnxt_sw_udp_gso_xmit
returns, check txr->kick_pending and write the doorbell if
bnxt_sw_udp_gso_xmit returned early and a doorbell is pending.

This TX queue stall was observed on a production system with a netdev TX
watchdog informing about the queue stall.

Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 17 +++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |  4 +---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bc7b37cb74a7..b6cc755f7a04 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -459,8 +459,7 @@ u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 	return md_dst->u.port_info.port_id;
 }
 
-static void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
-			     u16 prod)
+void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr, u16 prod)
 {
 	/* Sync BD data before updating doorbell */
 	wmb();
@@ -485,6 +484,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
 	skb_frag_t *frag;
+	netdev_tx_t ret;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -510,8 +510,17 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	if (skb_is_gso(skb) &&
 	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
-	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
-		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+		/* if the USO code exits early (for example, it returns
+		 * NETDEV_TX_BUSY) make sure we ring any outstanding doorbells
+		 * for any BDs in the ring before returning.
+		 */
+		ret = bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+		if (txr->kick_pending)
+			bnxt_txr_db_kick(bp, txr, txr->tx_prod);
+
+		return ret;
+	}
 
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dc8ec5e5733e..60fbe3cabcf9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -3009,6 +3009,8 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
 u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
+void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+		      u16 prod);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index f317f60414e8..3c58b1d94ac9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -223,9 +223,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	netdev_tx_sent_queue(txq, skb->len);
 
 	WRITE_ONCE(txr->tx_prod, prod);
-	/* Sync BDs before doorbell */
-	wmb();
-	bnxt_db_write(bp, &txr->tx_db, prod);
+	bnxt_txr_db_kick(bp, txr, prod);
 
 	if (unlikely(bnxt_tx_avail(bp, txr) <= bp->tx_wake_thresh))
 		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),

base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
-- 
2.53.0-Meta

