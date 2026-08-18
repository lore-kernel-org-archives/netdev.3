Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173A3AE1A3
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065693; cv=none; b=AKAwOv6WixF9BG2iO34qcGCPCBF3jlouSFeU340aUh+SMnSUotR+UFLDmfRE5xAlUnU2SpmPe2b7LKKhk4/STrneWEspPk/ghWupRSmZZOZECRyfxLPRJpUe7ZER4NCHWxVzU+TwT0g9C+cQioS0a6OuqAegJ/IVMri1dQ8rGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065693; c=relaxed/simple;
	bh=2+julbhixxofNca4aNVTNk/zs/niG81pBE7X/ZshghQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKpsZrSqNcnHyqObpAl95DRgsSdwPNkQGBOX3gBOMPyr6ZzQwO7w7MJ4aLzioPiM4W6nYYqL8nh1zDNycHJUOBxGYZMtXfTvPoxeP7y6XZ+1cHo33QSeEpndSbunu2japyFEXxnJcvhHnORKNfnTzvyyWdXaroc8ZFH9SIWsKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oNTo82IJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oNTo82IJ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f84023916so4506825f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787065690; x=1787670490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhoaR4OOIJXqNDBU5cYw/oNUY2j8DBMQ31bUaBG3FrI=;
        b=oNTo82IJq/abI6MPKvzq56gdRVyQAauvRWOFGT86hjSwM0yMPOCXDzpFdUbdYQY4zO
         kWWGtq18ygq1EcLtTtqVGL992Zo58LiRmTYWm0bXpzQG7MbXnXNm9B0A2evTOK6H8t/7
         s8eyF+LBvotRjla6rv0juZBLboTKH4CcKNWJ8Znsarkk9jMF93HAEGYSvaRxD1/L4ww8
         sgyradiv+3BntZOeBmgSZGyCcabcXhgHF0shcDPbZ9lpCb9yJE7J08IAKfaI4izJE/7u
         8T83qm71dbR8Hsjrln5ETw9oJ4Y8ehwvL3FaRbaNUQDC1OY20HFfG6iDrlJe5ET7x1Ch
         1ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065690; x=1787670490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DhoaR4OOIJXqNDBU5cYw/oNUY2j8DBMQ31bUaBG3FrI=;
        b=Yz72E2biSh51DTEao5z7QsK/oAorY4HtjioBFONfMsr5j4tTZgDDg8x8gAsMcS9hF6
         L+AuSZeY2E4wbDr3JE7LGnW6eL+usXftYIb0pKVOsPYwmYBbsgsvgW9nmEaDbRqXuan5
         u7KmHzeMFVpfMasvKQKpMhPBs+uCPnq0cx9J2v+jPUr7+CFTRG2chUie0WqW7MwAQeWO
         PSbSlK53S85jYA/wmltzc2IJyry2wZKHtqk/SdjBNA/ecKutFxU7/1RclOYyA9JhuRM3
         77SefIzA5mK91ML3ppdmg1l2EavnVp+xhJDnDLh8HnhXw2m7mWnMkdQpxT0Db8ZCJPJc
         y6LA==
X-Gm-Message-State: AOJu0YyMGqFDSjvrIMzWdvd0i0H2OOmMAXrRlY/7qFjO8DcV64aX4DYd
	GDkloGngAH1nRGoAUADrT3QMjNkQmOjG9zyS/XmDcOiwfnNYQuogMX7XD4IPfU9IEhK4WRB+o8l
	pZENO
X-Gm-Gg: AR+sD12KMVCL7DrjX+C0qAsoi0N2mLLyDtlBL/NLHvUmnYiAQ3fBSRg/xdI1YQ3FLFx
	95LJ1rYhLY/rYqTVhB16GKJDYiSrdfLHN/Ek0ZccS5fcKx24V0ynumSgYK25xVBSaitHrLTAnDO
	IT21URuc7W7W3pn2JJxIOMthzR+Zbz5oUeWo6XIyf2kv8phgTZfsNECqWDpC8PIyyQRcXEKQGBT
	egfVfhgC54GYhe7OgGGkTV0RikSJRzcWxsYSrQvb0QtQOv30jWeGsn9xjnQefcoc5MLXRHjsu9a
	uqPU9MC3pfVUrJPHD2uXIt5XE1dnlmANpAI4vanVMv6n3AyBYSs0xiSPCGvd6QCaiE7zyUuCnX+
	hgIuPhINNZfaTQ3NvZXQkxxnxWLQytzStqSzPabH99MzF+4qHiYV1EYct4TfcwBQdMIi/2Sy77R
	sR2/IARWZ2er1+L5pqzMFDMHfRXLhAYR6lPRCoANdQ2OFq72CpyilGq1VuEooLD+q9jGhDOIMkF
	5OjfXBwtKA=
X-Received: by 2002:a05:6000:47:b0:47f:eac2:6f55 with SMTP id ffacd0b85a97d-482a90cd11fmr11978229f8f.19.1787065689829;
        Tue, 18 Aug 2026 08:08:09 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a9f0dec2sm7924392f8f.10.2026.08.18.08.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:08:09 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 1/2] net: bridge: arp/nd proxy: fix reading neigh ha
Date: Tue, 18 Aug 2026 18:07:55 +0300
Message-ID: <20260818150756.890025-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818150756.890025-1-razor@blackwall.org>
References: <20260818150756.890025-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently neigh ha address is read directly, but that can result in
torn/partial reads if the neigh is being updated. Use neigh_ha_snapshot
to take a stable snapshot of the address.

Fixes: 057658cb33fb ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: - use ETH_ALEN instead of MAX_ADDR_LEN, the bridge devices all use
      ETH_ALEN and vxlan allows arp/nd reduce only when not in raw/gpe
      so it also always uses ETH_ALEN
    - align ha to 2 bytes because ether_addr_copy() expects it (Sashiko)

 net/bridge/br_arp_nd_proxy.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 23eb6931a2b4..fd65d6af4f35 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -195,13 +195,15 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 	n = neigh_lookup(&arp_tbl, &tip, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
+		u8 ha[ETH_ALEN] __aligned(2);
 
 		if (!(READ_ONCE(n->nud_state) & NUD_VALID)) {
 			neigh_release(n);
 			return;
 		}
 
-		f = br_fdb_find_rcu(br, n->ha, vid);
+		neigh_ha_snapshot(ha, n, n->dev);
+		f = br_fdb_find_rcu(br, ha, vid);
 		if (f) {
 			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
@@ -211,10 +213,10 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			    br_is_neigh_suppress_enabled(dst, vid)) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
-						    sha, n->ha, sha, 0, 0);
+						    sha, ha, sha, 0, 0);
 				else
 					br_arp_send(br, p, skb->dev, sip, tip,
-						    sha, n->ha, sha,
+						    sha, ha, sha,
 						    skb->vlan_proto,
 						    skb_vlan_tag_get(skb));
 				replied = true;
@@ -252,7 +254,7 @@ struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
 }
 
 static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
-		       struct sk_buff *request, struct neighbour *n,
+		       struct sk_buff *request, struct neighbour *n, u8 *ha,
 		       __be16 vlan_proto, u16 vlan_tci)
 {
 	struct net_device *dev = request->dev;
@@ -310,7 +312,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 		ipv6_eth_mc_map(&in6addr_linklocal_allnodes, eth_hdr(reply)->h_dest);
 	else
 		ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
-	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
+	ether_addr_copy(eth_hdr(reply)->h_source, ha);
 	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
 	reply->protocol = htons(ETH_P_IPV6);
 
@@ -340,7 +342,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	na->icmph.icmp6_override = 1;
 	na->icmph.icmp6_solicited = dad ? 0 : 1;
 	na->target = ns->target;
-	ether_addr_copy(&na->opt[2], n->ha);
+	ether_addr_copy(&na->opt[2], ha);
 	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
 	na->opt[1] = na_olen >> 3;
 
@@ -369,7 +371,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 		__vlan_hwaccel_put_tag(reply, vlan_proto, vlan_tci);
 
 	netdev_dbg(dev, "nd send dev %s dst %pI6 dst_hw %pM src %pI6 src_hw %pM\n",
-		   dev->name, &pip6->daddr, daddr, &pip6->saddr, n->ha);
+		   dev->name, &pip6->daddr, daddr, &pip6->saddr, ha);
 
 	if (p) {
 		dev_queue_xmit(reply);
@@ -472,24 +474,26 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	n = neigh_lookup(&nd_tbl, &msg->target, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
+		u8 ha[ETH_ALEN] __aligned(2);
 
 		if (!(READ_ONCE(n->nud_state) & NUD_VALID)) {
 			neigh_release(n);
 			return;
 		}
 
-		f = br_fdb_find_rcu(br, n->ha, vid);
+		neigh_ha_snapshot(ha, n, n->dev);
+		f = br_fdb_find_rcu(br, ha, vid);
 		if (f) {
 			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
 			if (br_is_neigh_suppress_enabled(dst, vid)) {
 				if (vid != 0)
-					br_nd_send(br, p, skb, n,
+					br_nd_send(br, p, skb, n, ha,
 						   skb->vlan_proto,
 						   skb_vlan_tag_get(skb));
 				else
-					br_nd_send(br, p, skb, n, 0, 0);
+					br_nd_send(br, p, skb, n, ha, 0, 0);
 				replied = true;
 			}
 
-- 
2.47.3

