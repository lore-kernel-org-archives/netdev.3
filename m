Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2032824B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353897; cv=none; b=XVZ/uKQZRiQu+8iX882OXFsiB1zejwrM3vtubvM1tRS3CqiWzsEmljkyK3DO/Z3duH8i/ANf/QhuptDJBec3MPsbaR/ey3hGQPzeL+pMSBarJlm1/LYIoCckeRaLYnbO8tdAGizvTlQUEkXaDVycoWmosfGgOP2Eyv0vTSaShiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353897; c=relaxed/simple;
	bh=AZkSoc+LX+Zys6+rUBEVWW4bcyNMbwH0ZtLsMicOQys=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PBtvHWkvrPyVxEtt+nDhxw1ureYmdqbdnHmcEyIII8M/tDhrc17Mc6o9+Jjw/fga2QBVCqYap05rXLXJIBcFgZoroktPJYq42N6CLcOHeme/jyZd3ecz+z+Zb7/zPt3ahUsDum2U0cKIcGHwd7Md79pvKv1j0LJaGsYSbdHM7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ui11FnuQ; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ui11FnuQ"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ffe24490bso24978681cf.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788353891; x=1788958691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eR6JjRH50MEhDDiYrqwTLYf/MTdbs2G9sfC9/W7oCr0=;
        b=Ui11FnuQOkFAIfYWzGW3DA8AHBv1zJJdCNuVXNn7+hT7P5LpojwAKwAD3ciGit8zkN
         UaQqR8S9kqZswHsYuYgIQIAjA3VY8LCVRRXGj6HGna2HeytK/FR34iHFwwwr1SvgHnX4
         Xkh02r/Q31GNhD/J288XOfRhPT+Ua33Bo0wqSd0hbGKe5Kyix/8DK4Y1/TYUHXzr5/OO
         KdFbBJkLrfTWGMbIhR/asgpOSDNsosjRkLhpeUWDi7VTfmDY+3ncLblkdWrg3FGaOrCN
         hm2v2ldDhcRQpzZlCw5Uz+kRK28xdEmFC0Y86/IyekjrPhgNGxxyf1fV7YifHklnVL/e
         S3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353891; x=1788958691;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eR6JjRH50MEhDDiYrqwTLYf/MTdbs2G9sfC9/W7oCr0=;
        b=g13lBsnqnF3Q3owMJaH1FsCH1JWRgLaUC86Wwc5UGatmSrtxeJ1OxMVKjjLa0g03US
         wgVu5GNkwgXaI9Is1Ved/0zNaLcC/jul4Mdq18XqYxJV61dp6TEnflvtBYITorW+logN
         axqlLvX1PR/+NbJirGAqU4anfzgMIUdqOX7uTREUTal7wWRMvLaQ0NOmcJXq6pIrnLmr
         eMl0Glalg276ZXcRRqVZ0/p9y2sBNtyu7vRtf3tYC/2rQr7vFEkSTcm9XLyLdLJoTl0X
         D9dUv/Gn/6KTokahoHsLrBW86EbquoVLH2MQ3p8Y/2uV89U+lBV317V+kkgfM6wpo+Rm
         E8lw==
X-Forwarded-Encrypted: i=1; AHgh+Rqu/w9Yu+j5H2+oh1ZYMX5VyOxMV5F+dJHxfbKwPSuIN+Mgo+qC5VbBYNeOxy8d4BpOblHj0ZA=@vger.kernel.org
X-Gm-Message-State: AFuF++k595H6Rmfdcxy9ediT314Hi5YKkwtGDsqiRwOE28QW/rMAsnbs
	BdZcmhv/mqvm6sVxnnFphgXb2Fsf+DzFbcfgAhqYVroisi8JK4S5SXC4S9UUK8KKRzc7zKOv01G
	gAnFV+Nzj9VmPWw==
X-Received: from qtmr26.prod.google.com ([2002:ac8:425a:0:b0:52a:a661:63f5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5e10:0:b0:52f:b0f9:e4f2 with SMTP id d75a77b69052e-53036b97d24mr46514001cf.1.1788353890588;
 Wed, 02 Sep 2026 05:58:10 -0700 (PDT)
Date: Wed,  2 Sep 2026 12:58:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902125809.2910366-1-edumazet@google.com>
Subject: [PATCH net] bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Jay Vosburgh <jv@jvosburgh.net>
Content-Type: text/plain; charset="UTF-8"

In bond_do_alb_xmit() and rlb_arp_xmit(), make sure to unclone
skb head via skb_cow_head() before modifying the source MAC address
(Ethernet header and ARP payload) to avoid silent corruption if
the skb is shared or cloned. Avoid caching the header pointers
across skb_cow_head().

In rlb_arp_xmit(), also check that
tx_slave != rcu_access_pointer(bond->curr_active_slave)
before modifying arp->mac_src. When tx_slave is the active slave,
arp->mac_src already matches its hardware address, so we can avoid
an unnecessary copy and head reallocation.

Also, we should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue,
and remove now redundant skb_reset_mac_header() calls.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Jay Vosburgh <jv@jvosburgh.net>
---
 drivers/net/bonding/bond_alb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 654f051d0023929a48536c378996e0ef39b75d88..5f750f08a144791589b5ed0f44b1b68ab99e6e61 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -678,9 +678,13 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 	if (arp->op_code == htons(ARPOP_REPLY)) {
 		/* the arp must be sent on the selected rx channel */
 		tx_slave = rlb_choose_channel(skb, bond, arp);
-		if (tx_slave)
+		if (tx_slave && tx_slave != rcu_access_pointer(bond->curr_active_slave)) {
+			if (unlikely(skb_cow_head(skb, 0)))
+				return NULL;
+			arp = (struct arp_pkt *)skb_network_header(skb);
 			bond_hw_addr_copy(arp->mac_src, tx_slave->dev->dev_addr,
 					  tx_slave->dev->addr_len);
+		}
 		netdev_dbg(bond->dev, "(slave %s): Server sent ARP Reply packet\n",
 			   tx_slave ? tx_slave->dev->name : "NULL");
 	} else if (arp->op_code == htons(ARPOP_REQUEST)) {
@@ -1340,7 +1344,6 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 				    struct slave *tx_slave)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
-	struct ethhdr *eth_data = eth_hdr(skb);
 
 	if (!tx_slave) {
 		/* unbalanced or unassigned, send through primary */
@@ -1351,7 +1354,9 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 
 	if (tx_slave && bond_slave_can_tx(tx_slave)) {
 		if (tx_slave != rcu_access_pointer(bond->curr_active_slave)) {
-			ether_addr_copy(eth_data->h_source,
+			if (unlikely(skb_cow_head(skb, 0)))
+				return bond_tx_drop(bond->dev, skb);
+			ether_addr_copy(skb_eth_hdr(skb)->h_source,
 					tx_slave->dev->dev_addr);
 		}
 
@@ -1375,8 +1380,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
 	struct ethhdr *eth_data;
 	u32 hash_index;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	/* Do not TX balance any multicast or broadcast */
 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
@@ -1428,8 +1432,7 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 	u32 hash_index = 0;
 	int hash_size = 0;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP: {
-- 
2.55.0.966.g6673acef38-goog

