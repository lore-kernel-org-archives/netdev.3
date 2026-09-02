Received: from mail-ej2-f8.google.com (mail-ej2-f8.google.com [74.125.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8B4A5EBB
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364328; cv=none; b=aPIlpvywbRxkKD5plQ0PVjJ75GRHpwcrFP/lh6Fe00/S0xsGh9ocaW1hP8zeLjw2/AhC1OWsm/EiF1KPzWM/misqlWpTzESCC2NtOAxSYyGqnNBpjCaj3SK28vykwNtv+rVsfFo0kmZh7gMjBx3xsVS+4hxt+56PKyarqTk8l1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364328; c=relaxed/simple;
	bh=vVm001jlaTvw8RyCZJ0ImpzcGhyw2diLqM0GQvZJp5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnWTZkRrl3Y29r18yYSdvG1MaK4jKsQKq6RnqP5sXXcN1ksf0OCusmiAVMHYwft3IiCLkWzAR2hMik3aH6vwvWu0G2LWSAiqwb3WLEQlt0wTn+PQomnIxTp9lTDDm2OkOEsuqobNJ47n4BVqplZZC4plAlGge5+d5kGL5lXwdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=QoliFjGm; arc=none smtp.client-ip=74.125.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="QoliFjGm"
Received: by mail-ej2-f8.google.com with SMTP id a640c23a62f3a-c254113e9beso36366066b.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788364324; x=1788969124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYT1wpgmmF4A2seGhMcChmpltzwukxsYVo40VLDCkr4=;
        b=QoliFjGm+fCUDKyjbEnXJSlkMDPNQak4kQe8W1N1tbnawRBe3t0hIhQp8P8LUy/TWr
         GsdJn8R4lbhdi1ROyy0GrpUbUu0jbIxjuRYXfZDORcmzgnDhsZYGVTy8BFxUz/LHbr/1
         3KD1fnypfOM/WUC8MtG4kQm+Sbt/A6VVZSgOgop/dqD+n0BVxsDwIjBcCvpso1BNTa3N
         LucrDRnaICs0u3XqYPEnKntmCvZfVHJnM0usDhza2eNbDR7WbfyatFVHAR/Q8h4oyuI/
         tMIydxhw5Jy3lSFiI2oB6ihb6grZeFcSMEZ/HF8zbCsUzHqQIMEpgt+iyHwSeW14/Pde
         XL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364324; x=1788969124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYT1wpgmmF4A2seGhMcChmpltzwukxsYVo40VLDCkr4=;
        b=N1rFlBspNFHqdVrUJLEjptI2mzIy+We85f4pWomPKbW8jb7VWN9ZVYD1RXIRZlQ5CW
         GhrZXBRLk0VcaqzSdEZzSjiXErN8pjThwqzqv2IfRBwJkVuG7fOIg6bn4zYH668h+WDv
         amusJl1FxvlkKEf/C2JAqlp/+pGKn5RFf3WhHuoZwsIWqcPffuykejG4jLLm+uv6yZSg
         80QjZ1/BPPbRCyEY/rySErHLbM+/HxbduXMBsOpPf13Bk7stLJlZRuEETn/eN07aS1Wv
         lhY6zRF5lThUTNQlnbznikICDkNmAs36OWinDHHyQVtGLw9Zb3f56TSDURoAjR3vyG2H
         KLHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSp16Gd96iDtkKqJ46/9xEidWzf4DasO/+3YuuTR0IIuSRyMNQ7P2EgPshtXBJRFItSn/HdSo=@vger.kernel.org
X-Gm-Message-State: AFuF++keaPgBAXYS8I6aWI+qrOW9uD6XFLhjaDGP7dg1E9FLIbc0eaIG
	7f7ugPYjDAW5c7XZjb6Qh53tqlyskApMW/zceacGB/Dse4lcb10xFJ8oDLJng67OMA==
X-Gm-Gg: AYBFou0Z19MQHB/ruwLpMeS3IZ5ofrYivqliafl7Sdpjv/JgHKdjTFhHbL7smdJG7vI
	CxS8MzF9FCdyi1R9OrrBZ2KiV5TTkdMOMw2hzf9iwAJzmhyqw12yrxlAbkWyRSAJ+Z1EunjAdnl
	UYuqOwyhheSuNL5Ghz+e6Img0nxdckLm4mqG2g+itoAtpZ3+H+SC970qSkBy8jBo/9fLl4rVta6
	7e+9U/EEAp08rkeyUjHIpBFUzYNiP9FER7J/B+QJ0Mm37gn/KH5WKfzTxlUyknAljCl7t8PL7Qo
	GSGmolLNDXSHlemsxQLV0d41FbDlRZ4pX86Hxv4h9aNLa7rJxIzVFPfbItuHnaQSKzuJleq6tPJ
	hLfqIXGeQOgseGidXhqy/mMusM+kPouxQw+bF6z+0E9wDhtwYBQNfAUA69646UbBp9kRnOrn+8K
	0jtz/7KWnIJiOzrdUl1n/N4VxLiTbI+wg60CcGLtSdUEvTCTVKK/eX/F6IniHIQqLnXAizCyii1
	RiCds3DGmujReEaU0doNkNdWep+Ss2/OggBD38gF37nRLOGWE1/Hnk6ShPdmJq0muVdP/X9mHBj
	pQjXocvi7x/VzZC8FkCoK0Zhg431qZvNGvb5+GjulQIj4YYTr3kaOL6XNaNUZ4UymgBSbGEamib
	uoL4Sa+YY5eOp/to9SU3dH30QHXosHCuqHZIEa10eeLp30uXbQ7UoELT+unto2Bp6N0we6Hqzpi
	ifRLqwf9pw048=
X-Received: by 2002:a17:907:3f88:b0:c21:450d:cd7e with SMTP id a640c23a62f3a-c25d53be168mr376567466b.9.1788364323750;
        Wed, 02 Sep 2026 08:52:03 -0700 (PDT)
Received: from Desktop (pd9513d53.dip0.t-ipconnect.de. [217.81.61.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03fbb75sm160187366b.49.2026.09.02.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:52:03 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v2 1/2] netfilter: flowtable: carry a priority into the offload
Date: Wed,  2 Sep 2026 17:51:35 +0200
Message-ID: <20260902155136.4963-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The packets the flowtable forwards bypass the rules that classified
the connection, so a priority set by "meta priority set" ahead of
"flow add" reaches the qdisc only on the packets that traversed the
ruleset before the flow existed; the rest keep the priority they
arrived with, which for a forwarded packet is normally none. A flow
rule handed to a driver has the same gap: it describes NAT,
encapsulation and the output device, but not how the flow should be
treated on the way out, so hardware with priority queues can only
fall back on the DSCP the packet carries.

Store skb->priority of the packet that created the flow. The software
fast path applies it to the packets it forwards; the hardware path
emits it as FLOW_ACTION_PRIORITY, the action act_skbedit already
emits on the tc path, so the rule handed to the driver describes what
the software path does. A flow without a priority emits no action and
leaves skb->priority of the packets it forwards alone.

Of the in-tree consumers of these rules, mtk and airoha ignore the new
action as they do FLOW_ACTION_CSUM. mlx5 has no parser for it and
rejects the rule, so a flow with a priority stays on the software path
there, as a flow with PPPoE encapsulation already does.

The flowtable holds one flow for both directions and the expression
runs once, so the priority applies to both; per-direction
classification is not carried.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
Changes in v2:
- apply the priority on the software fast path as well, in the IPv4
  and IPv6 flowtable hooks, so a flow forwarded in software and one
  forwarded by hardware get the same treatment (Lorenzo Bianconi)
- describe it in nf_flowtable.rst
- add the selftest in 2/2

v1: https://lore.kernel.org/netfilter-devel/20260901092632.369248-1-julius@bairaktaris.de/

The consumer of the emitted action is a DSA driver for the IPQ8074 PPE,
maintained in OpenWrt; measured there, "meta priority set" ahead of
"flow add" places hardware-offloaded flows in the port's priority
queues, and with hardware offload disabled a 30 MB IPv4 and a 30 MB
IPv6 transfer both land in the stamped priority band with only the
handshake traversing the ruleset. The selftest in 2/2 passes on this
series and fails on the base commit, x86_64 under QEMU, three runs
each. The mtk and airoha hunks are compile-tested only. The new field
grows struct flow_offload by eight bytes on 64-bit; the entry allocates
from its own kmem_cache, so no allocation-class change.

 Documentation/networking/nf_flowtable.rst       |  4 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c        |  1 +
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c |  1 +
 include/net/netfilter/nf_flow_table.h           |  1 +
 net/netfilter/nf_flow_table_ip.c                |  6 ++++++
 net/netfilter/nf_flow_table_offload.c           | 11 +++++++++++
 net/netfilter/nft_flow_offload.c                |  5 +++++
 7 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/nf_flowtable.rst b/Documentation/networking/nf_flowtable.rst
index d757c21c10f2..5844ab19aec6 100644
--- a/Documentation/networking/nf_flowtable.rst
+++ b/Documentation/networking/nf_flowtable.rst
@@ -71,7 +71,9 @@ forwarding path including the Netfilter hooks and the flowtable fastpath bypass.
 
 The flowtable entry also stores the NAT configuration, so all packets are
 mangled according to the NAT policy that is specified from the classic IP
-forwarding path. The TTL is decremented before calling neigh_xmit(). Fragmented
+forwarding path. The TTL is decremented before calling neigh_xmit(). The flow
+also stores the priority of the packet that created it, so a priority set before
+``flow add`` applies to the packets that the flowtable forwards. Fragmented
 traffic is passed up to follow the classic IP forwarding path given that the
 transport header is missing, in this case, flowtable lookups are not possible.
 TCP RST and FIN packets are also passed up to the classic IP forwarding path to
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 92611802801e..2afce76ad131 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1161,6 +1161,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
 		case FLOW_ACTION_REDIRECT:
 			odev = act->dev;
 			break;
+		case FLOW_ACTION_PRIORITY:
 		case FLOW_ACTION_CSUM:
 			break;
 		case FLOW_ACTION_VLAN_PUSH:
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index 99b28aaa7cc4..4ee99e8e4a34 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -378,6 +378,7 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		case FLOW_ACTION_REDIRECT:
 			odev = act->dev;
 			break;
+		case FLOW_ACTION_PRIORITY:
 		case FLOW_ACTION_CSUM:
 			break;
 		case FLOW_ACTION_VLAN_PUSH:
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index f2e2771f188f..23218c8cbc3d 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -202,6 +202,7 @@ struct flow_offload {
 	unsigned long				flags;
 	u16					type;
 	u32					timeout;
+	u32					priority;
 	struct rcu_head				rcu_head;
 };
 
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index c8c29a9a1684..c85e2d608c32 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -509,6 +509,9 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 	ip_decrease_ttl(iph);
 	skb_clear_tstamp(skb);
 
+	if (flow->priority)
+		skb->priority = flow->priority;
+
 	if (flow_table->flags & NF_FLOWTABLE_COUNTER)
 		nf_ct_acct_update(flow->ct, tuplehash->tuple.dir, skb->len);
 
@@ -1104,6 +1107,9 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 	ip6h->hop_limit--;
 	skb_clear_tstamp(skb);
 
+	if (flow->priority)
+		skb->priority = flow->priority;
+
 	if (flow_table->flags & NF_FLOWTABLE_COUNTER)
 		nf_ct_acct_update(flow->ct, tuplehash->tuple.dir, skb->len);
 
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 801a3dd9ceea..caaadffc2563 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -696,6 +696,17 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 	    flow_offload_eth_dst(net, flow, dir, flow_rule) < 0)
 		return -1;
 
+	if (flow->priority) {
+		struct flow_action_entry *entry;
+
+		entry = flow_action_entry_next(flow_rule);
+		if (!entry)
+			return -1;
+
+		entry->id = FLOW_ACTION_PRIORITY;
+		entry->priority = flow->priority;
+	}
+
 	tuple = &flow->tuplehash[dir].tuple;
 
 	for (i = 0; i < tuple->encap_num; i++) {
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 32b4281038dd..ca91924b4de3 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -117,6 +117,11 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (tcph)
 		flow_offload_ct_tcp(ct);
 
+	/* The packets the flow forwards in its place bypass the rules that
+	 * classified this one; carry the result with the flow.
+	 */
+	flow->priority = pkt->skb->priority;
+
 	__set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
 	ret = flow_offload_add(flowtable, flow);
 	if (ret < 0)

base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
-- 
2.53.0

