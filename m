Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58C4D9F62
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612325; cv=none; b=NcjGLXwZkoaIaQ8rQFGli32iVYvzMpO3am7vFdTbU5kI3OSkTcwqR0R7rP0GRUE8k8OE3PGmFS6Sk60hgfnYZ1uw6+noePl9DJbSsU3ZTscaWzfBK2m47jezrxXKM+DdKxaVMt8wali2oi9F3WPS9zOwAyUtxZFtR/09hUCI1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612325; c=relaxed/simple;
	bh=AOO/rNbtYn/XV+z6aJLsYODwFNDUGFoFh+PHNDW0M2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/U7EVS/wv93lA/Kz+KxBu9v2sRv2Ol15ElnSm/8a8M4lz3nNjhfxuPmj9BAOE5GYg4tXGB4x+sncy+GPQWGp1YiKbjxhyM8DFe9vdiOp7ooTVkZkPaq0QdYpLeKgQQS6IwV+obLsZhR2lFVoTmmjb8DR/JnoQuza6+f6GJUjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el8IAS8H; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el8IAS8H"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so12669515e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612321; x=1791217121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSDv0oMqDQGMqVMxgulpjHU/XgBmZQ/St3zf1qwBsuM=;
        b=el8IAS8HS/Qw2N/7f9OT/6rcIlNx2El9mT2P7ubxrKUTQaj6ONGhczs0z4Os93LIdd
         kY2vKlF2aO3Wwnb9wBeB+qTNJ5QJHdWZ5U2nd6S6ZmK1fbepZI+0Ol61USPkaKei40ZL
         XOG13KrEMj+mwz7OSehPHU8z9IYBqH2B79pUnxH/tw4nRjGmovLDJVIFIA+er0VoBLJD
         Lx2JCW+EEAQgC2RL5dmGT10rjSGbuNRt+IpQvyXT6ybwSXIJABCl310a5OkWUpfD5ct8
         Rsph6pdcx8f/oKnWpJDM+6h1YGayXZeSjpZAIAkep2aOp9ysrWsTFvWa9UGklF3lZ4lx
         VkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612321; x=1791217121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSDv0oMqDQGMqVMxgulpjHU/XgBmZQ/St3zf1qwBsuM=;
        b=HPyVwCoO2BuifevLL1pnDODI06xZtrjUZ78An/M2Sz1/YTv5Cg7uoSnGIGeRHnyBqG
         ogluOqP+aWCbtYwHo4L6aUGZsKOptJG2B2J8sHAV0y2oC/Ao/ojEnDUFE63+43tSbZs/
         syEh/a50PXbahcFxraxUai9MsHhWcU30/RdCTYeSlg/5g5EGqUlIC+4lprNJ7A5VtKDd
         7r7GG/gvbGbV985kkgSNVCHT8FRpGNIy6cqOIL6oNdKjCay2e1zSEgdQqxuNCgYHVZaq
         hVysPXJvdQmVIckh9qzGuGmpiUR9+HIGqKqm/LUY4a3Ppi+nOx4lRrFZ+rG/EaiKPTmt
         4wQA==
X-Forwarded-Encrypted: i=1; AKwUvBx70Un6ysHqKrdLU51+QXaX/y8dCuMAK79WS0AoHni0qWx/eaQqoZ7L+bkj3ccQKgNGxWH9xbs=@vger.kernel.org
X-Gm-Message-State: AFuF++kDtMyD+EP1JBGqlGZS392/Zt1xgkmmznyvy3QM5xyo745obTJC
	E0qcswuRnYr3VXfxS9R22TOGNffITri4kRc7iwN+SCy8nqAZ5CH9ADER
X-Gm-Gg: AYBFou1rICHKPevRzD9HDQ3WRAbhjIwtqGgFTtLWJ5qQuwfOPXYgR3BjcQW4JvlxTCL
	py2Bw6vKfSj+pwGS96GKuxkb/RhDueb+u62WYhROxb4vtcSuyJ6XySeiAkTOc9KfncGiXGzuTJk
	SwJwVX+gBOU2bg5v2WRyCvU7R1Fk1LN7AwC2ttKiauQ6XkE39LxF4tjyZRgzTjPB9fFuQdvn6eN
	Q8UHnb48Dijs2bmBNSF8C8N/6M6xb4vo01ZdiB+ZhQfNnOtl4ZTSDrHpUjezXC8l0l5t2nzFgHy
	YZWVOjEv4Cm9nuWDMgXRBtU2K1BCNX9nhdZ6WGRfaENWdqALwtHSLxy4m8NY5eUlHek/Hw544HL
	SY9ys7T3ElG887Zzq7PAqTRfnmaZL7NAZsq7eB27Rb+VXdsrrOAHp6BD8jtN2nRektSIvNqjJWF
	lCk/71Hiy7Qe0BPgVtbvblxX8hQlQF0rnsH0PgZ4T8O6YlIoOnZZj65UJSJnnC2CO6xL5KVVEJt
	OSAQXa01b1gY0PL9LGY1jrLoOTzOHaTH27a435meUF2E0gMr/gx2XMKUuTdkeQ/fETCiKgP2jLA
	FVDCyQ==
X-Received: by 2002:a05:600c:a30b:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-49ffaa33f7amr92371915e9.13.1790612321314;
        Mon, 28 Sep 2026 09:18:41 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm4813715e9.1.2026.09.28.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:18:40 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Mon, 28 Sep 2026 18:18:28 +0200
Message-ID: <20260928161830.351199-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bridged IPv6 packets can lose their VLAN tag or acquire an unrelated tag
when conntrack-reassembled packets are refragmented. On a VLAN-aware
bridge, this can send fragments with a different VLAN tag from the one
selected for forwarding.

br_nf_push_frag_xmit() restores the VLAN tag from per-CPU storage, but
only the IPv4 branch of br_nf_dev_queue_xmit() saves it. The IPv6 branch
leaves the saved tag from the previous IPv4 refragmentation on that CPU.
Newly allocated fragments do not inherit the tag through
ip6_copy_metadata().

Commit d7b597421519 ("netfilter: bridge: restore vlan tag when
refragmenting") added VLAN tag restoration for IPv4 only, shortly after
IPv6 refragmentation was introduced.

Move saving the L2 header and VLAN tag into br_nf_save_frag_data() and
call it from both branches, so IPv6 fragments use the current packet's
VLAN information.

Fixes: efb6de9b4ba0 ("netfilter: bridge: forward IPv6 fragmented packets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 45 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f43916..ec69d6254e340 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -832,6 +832,25 @@ static unsigned int nf_bridge_mtu_reduction(const struct sk_buff *skb)
 	return 0;
 }
 
+/* Fragments may not inherit the MAC header or VLAN tag. */
+static void br_nf_save_frag_data(struct sk_buff *skb)
+{
+	struct brnf_frag_data *data = this_cpu_ptr(&brnf_frag_data_storage);
+
+	if (skb_vlan_tag_present(skb)) {
+		data->vlan_tci = skb->vlan_tci;
+		data->vlan_proto = skb->vlan_proto;
+	} else {
+		data->vlan_proto = 0;
+	}
+
+	data->encap_size = nf_bridge_encap_header_len(skb);
+	data->size = ETH_HLEN + data->encap_size;
+
+	skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
+					 data->size);
+}
+
 static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
@@ -866,28 +885,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	 */
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) &&
 	    skb->protocol == htons(ETH_P_IP)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv4(net, skb))
 			goto drop;
 
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-
-		if (skb_vlan_tag_present(skb)) {
-			data->vlan_tci = skb->vlan_tci;
-			data->vlan_proto = skb->vlan_proto;
-		} else {
-			data->vlan_proto = 0;
-		}
-
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = br_nf_ip_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
@@ -895,20 +899,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	}
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV6) &&
 	    skb->protocol == htons(ETH_P_IPV6)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv6(net, skb))
 			goto drop;
 
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = ip6_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
-- 
2.53.0

