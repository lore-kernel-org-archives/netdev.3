Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213F4B5CAC
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446391; cv=none; b=qTy5zbybE0EFHHglL+yfwDYql958OsptpJGawkO19d39eycHGPiRTIy4gRzSkuIZwNSEksJatsUTNWzHFloGeZ+jdaL4rtu0Cvwe6eO1m6uf2H8u7R1cqjrAvxUTLe6H9HgNFhGxXkP4ziSgl5y0sOkWqAdEWEfZf+aTfDT853U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446391; c=relaxed/simple;
	bh=bK/m/cytu5FPpGsR64HzrpjGw17A7EhkAcGmrtAxlTI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NUTwb4L6tqPvvrUqtMlYPHDCUTMF2lxlUaRNAq6/auZJfxCn7ozco4G6Fv08e/+NuAPR5Xfq7XOJby4b7jD2OA4rxgSPlgZTPUU/8pR9f6aoKl1F2Uq1+Caj4SKSPH3CxJI+99qNctmwBmZTmd7FFIqNyiqyDs16jfTjkqXM74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYXrf+wD; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYXrf+wD"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c01ff996dso18965511cf.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788446382; x=1789051182; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wcsjQqCcvOaYuhn2HLpYXCepuV85Bsbo9z9yxZWhjgU=;
        b=qYXrf+wD96rrSC7WlzdzaRs/qRgIQ5nN7kNkIP1Y+iZFnvAzWfECT9di47Nzl8mxdl
         Y0fP38aefkhdF/P/OwWyICa1QmyRdbPRR5cdFyy1ULEuZ8hQpDvDeosm5NelUHeOgAoV
         a3poUh35xvp5G/MyAHS8gsoFSjH0J7qUy0DqdTOkbH3+2j5GFSWMAQampDvQEMvqUSTr
         SEvyD28QARSe+L0i8BcLBzVNiR2T+SYuou8Y5S4ClzDw/D6Nj8eCX4sEcHLJrqU6NeuH
         /Q0OLvH1YV6Bmzj5BEP5+FYI99VcDJu4BF807vIJEwA401kyw6raLbCnIPy/FnKpC7Lv
         O8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446382; x=1789051182;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcsjQqCcvOaYuhn2HLpYXCepuV85Bsbo9z9yxZWhjgU=;
        b=e1cVbuqBAozdoQbhM+hx165jdyc2JbkRfxICDGn1TnlJSU5bAvEwc+RHiyj65JvhFp
         y8tZHqa4leusAd0rXANJgvCTfZG8o5ywxGFYh07UzUzwPZW0OuxPY79fvEU/t8bB5m9J
         zT7yFFDMMuZt3dkVLQa3f15wXRq3pu8YYkiYDtU+E4Hna+20Lhe6dcHpdzt/74eQ8GU9
         V3LRNvK4ZfFj0vwXnjRPLFzA9Q3eziMf39YeWtl1t002i3JYxNOZXxloT82/LSNUC7OZ
         DSInAysfl682NI6j8aQ+ZhHeFWHGR77TpJjK32LWR6YrqcdGrIU9pLN1zGI4LrdtePhp
         nOlw==
X-Forwarded-Encrypted: i=1; AKwUvByF/Yu+bRgR/96HprHRF+MVcHZELUHZ8eG73iBQ7cfZ7b7alt198mZu4CKuGloMzDqKNVpBOYk=@vger.kernel.org
X-Gm-Message-State: AFuF++kmO3XNwn4c3gM1a5M1mQxA7P5Cuo1Gsa4G//EJJGEzbhCdXmMM
	BQx2b2IBk4Ef/eJaszogDDDJyIdIlhA51FSQuknlZHhArhECdlAK83CSNm0Uz7qogBbhFeLA8bV
	QovHHpq53JBygHg==
X-Received: from qtpp12-n1.prod.google.com ([2002:a05:622a:9cc:10b0:52f:9f67:cb6a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5e10:0:b0:52f:b77b:c8e8 with SMTP id d75a77b69052e-530524bc056mr9916311cf.28.1788446381504;
 Thu, 03 Sep 2026 07:39:41 -0700 (PDT)
Date: Thu,  3 Sep 2026 14:39:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903143940.1180513-1-edumazet@google.com>
Subject: [PATCH v2 net] bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Hangbin Liu <liuhangbin@kylinos.cn>, Jay Vosburgh <jv@jvosburgh.net>
Content-Type: text/plain; charset="UTF-8"

In bond_do_alb_xmit() and rlb_arp_xmit(), make sure to unclone
skb head via skb_cow_head() before modifying the source MAC address
(Ethernet header and ARP payload) to avoid silent corruption if
the skb is shared or cloned. Avoid caching the header pointers
across skb_cow_head().

In rlb_arp_xmit(), only modify arp->mac_src if it differs from
tx_slave->dev->dev_addr to avoid an unnecessary copy and head
reallocation.

Also, we should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue,
and remove now redundant skb_reset_mac_header() calls.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: Jay Vosburgh <jv@jvosburgh.net>
---
v2: Use ether_addr_equal_64bits() per Sashiko AI agent feedback
v1: https://lore.kernel.org/netdev/20260902125809.2910366-1-edumazet@google.com/

 drivers/net/bonding/bond_alb.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 654f051d0023929a48536c378996e0ef39b75d88..43ac8e28e41828d30fb66f6f562bee5c1af630a7 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -678,9 +678,15 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 	if (arp->op_code == htons(ARPOP_REPLY)) {
 		/* the arp must be sent on the selected rx channel */
 		tx_slave = rlb_choose_channel(skb, bond, arp);
-		if (tx_slave)
+		if (tx_slave &&
+		    !ether_addr_equal_64bits(arp->mac_src,
+					     tx_slave->dev->dev_addr)) {
+			if (unlikely(skb_cow_head(skb, 0)))
+				return NULL;
+			arp = (struct arp_pkt *)skb_network_header(skb);
 			bond_hw_addr_copy(arp->mac_src, tx_slave->dev->dev_addr,
 					  tx_slave->dev->addr_len);
+		}
 		netdev_dbg(bond->dev, "(slave %s): Server sent ARP Reply packet\n",
 			   tx_slave ? tx_slave->dev->name : "NULL");
 	} else if (arp->op_code == htons(ARPOP_REQUEST)) {
@@ -1340,7 +1346,6 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 				    struct slave *tx_slave)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
-	struct ethhdr *eth_data = eth_hdr(skb);
 
 	if (!tx_slave) {
 		/* unbalanced or unassigned, send through primary */
@@ -1351,7 +1356,9 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 
 	if (tx_slave && bond_slave_can_tx(tx_slave)) {
 		if (tx_slave != rcu_access_pointer(bond->curr_active_slave)) {
-			ether_addr_copy(eth_data->h_source,
+			if (unlikely(skb_cow_head(skb, 0)))
+				return bond_tx_drop(bond->dev, skb);
+			ether_addr_copy(skb_eth_hdr(skb)->h_source,
 					tx_slave->dev->dev_addr);
 		}
 
@@ -1375,8 +1382,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
 	struct ethhdr *eth_data;
 	u32 hash_index;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	/* Do not TX balance any multicast or broadcast */
 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
@@ -1428,8 +1434,7 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 	u32 hash_index = 0;
 	int hash_size = 0;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP: {
-- 
2.55.0.970.g62bdec98f9-goog

