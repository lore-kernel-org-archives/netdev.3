Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850322;
	b=ziWVa6hSgsYf5m79omRMdRZRB1a0vMlAi0H1bp8nL+C7KFxgNGpUB4N/Hq2t5ELxyMzi
	 iBk1ivsdQl3qxKuSD22YU19ds3QQMvfxAqe3n2bhL1f95fB+1pxZYp6Tg/pCwWyfmd4KQ
	 58EVRCfbQcWk1r5AMO0NfRcMz/WzfEFTq52yPIIViQfKPb71fgPvBn8V31JA7BDzX5Gv1
	 pGSF1uTJw1+kvQJhdBo3SGhyL+KDYj+oxz5igiUqTgRx4FoTTA3Q/vGyUFfRGF2n0Pz+s
	 dl/cHaINh+50Q8M8YxAHLDlsvgN6mYVCSo4kY2srbJswONp2P3i5Yj56grM1J/8xHvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850322;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IDxRGNGz0YjnXi+jLYlxg1F6TuStgL9eYp4V9snUFVA=;
	b=ipPJRCRBYM7AfKU6VSzLt8aTDwnN4qKAOd0usRXNu9sZ5oICq2UcS/nOptqEWJA/BA0l
	 FeQ2+wVGk20Uc2ib0qkavc+B5Q7XC+hFFHQrKJfsy9z4BJWB72cTdlFiBR9LJIqlg1GH6
	 xB7aUhfekjzde3JYnksQ8jACO8V+PK8PBx5ST1/3FAnHlC3TiAx5RUNgw7Z94XbJLqaqj
	 K+VjoRaOSYVJnpgdtOhFmbUOgZam/2gxf1Zg5xZ8oRwfgTuGnhps8rmgbsH6ZchNL08Gf
	 N0wLsUmJyFs+tBrk7yIq3x2L8evTA0Lpq6ISOzzv2rZ2qKvX41LrCYKaMZRlTK2HU2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86827606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86827606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3u002480;
	Wed, 4 Nov 2026 19:45:07 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 08/12] cxgb4: Add T7 support to the filter infrastructure.
Date: Thu,  5 Nov 2026 08:15:45 -0500
Message-Id: <20261105131549.547554-9-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261105131549.547554-1-bharat@chelsio.com>
References: <20261105131549.547554-1-bharat@chelsio.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T7 introduces a number of changes in filter-related register fields,
firmware work request formats and CPL definitions. Update the filter
code to use the appropriate T7-specific encodings while preserving
existing behavior on earlier adapters.

The changes include:
- Use T7 reply channel and queue number encodings in filter-related
  CPL requests.
- Add T7-specific filter capability validation using the new TP filter
  field definitions.
- Enable validation and programming of the SYN-only filter field,
  which is supported on T7.
- Adjust FW_FILTER_WR construction to match T7 semantics where the
  RX channel is no longer programmed through the legacy field.
- Add support for T7 active-open filter requests using the T7 CPL
  layout and T7 filter tuple encoding.
- Update filter resource handling to work correctly across T6 and T7
  devices.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 214 ++++++++++++------
 1 file changed, 141 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 657d96b9e2f6..c9182c69cc7e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -66,9 +66,14 @@ static int set_tcb_field(struct adapter *adap, struct filter_entry *f,
 
 	req = (struct cpl_set_tcb_field *)__skb_put_zero(skb, sizeof(*req));
 	INIT_TP_WR_CPL(req, CPL_SET_TCB_FIELD, ftid);
-	req->reply_ctrl = htons(REPLY_CHAN_V(0) |
-				QUEUENO_V(adap->sge.fw_evtq.abs_id) |
-				NO_REPLY_V(no_reply));
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		req->reply_ctrl = htons(T7_REPLY_CHAN_V(0) |
+					T7_QUEUENO_V(adap->sge.fw_evtq.abs_id) |
+					NO_REPLY_V(no_reply));
+	else
+		req->reply_ctrl = htons(REPLY_CHAN_V(0) |
+					QUEUENO_V(adap->sge.fw_evtq.abs_id) |
+					NO_REPLY_V(no_reply));
 	req->word_cookie = htons(TCB_WORD_V(word) | TCB_COOKIE_V(ftid));
 	req->mask = cpu_to_be64(mask);
 	req->val = cpu_to_be64(val);
@@ -249,32 +254,53 @@ static int validate_filter(struct net_device *dev,
 			   struct ch_filter_specification *fs)
 {
 	struct adapter *adapter = netdev2adap(dev);
-	u32 fconf, iconf;
+	u32 fconf, iconf, chip_ver;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 	/* Check for unconfigured fields being used. */
 	iconf = adapter->params.tp.ingress_config;
 	fconf = fs->hash ? adapter->params.tp.filter_mask :
 			   adapter->params.tp.vlan_pri_map;
 
-	if (unsupported(fconf, FCOE_F, fs->val.fcoe, fs->mask.fcoe) ||
-	    unsupported(fconf, PORT_F, fs->val.iport, fs->mask.iport) ||
-	    unsupported(fconf, TOS_F, fs->val.tos, fs->mask.tos) ||
-	    unsupported(fconf, ETHERTYPE_F, fs->val.ethtype,
-			fs->mask.ethtype) ||
-	    unsupported(fconf, MACMATCH_F, fs->val.macidx, fs->mask.macidx) ||
-	    unsupported(fconf, MPSHITTYPE_F, fs->val.matchtype,
-			fs->mask.matchtype) ||
-	    unsupported(fconf, FRAGMENTATION_F, fs->val.frag, fs->mask.frag) ||
-	    unsupported(fconf, PROTOCOL_F, fs->val.proto, fs->mask.proto) ||
-	    unsupported(fconf, VNIC_ID_F, fs->val.pfvf_vld,
-			fs->mask.pfvf_vld) ||
-	    unsupported(fconf, VNIC_ID_F, fs->val.ovlan_vld,
-			fs->mask.ovlan_vld) ||
-	    unsupported(fconf, VNIC_ID_F, fs->val.encap_vld,
-			fs->mask.encap_vld) ||
-	    unsupported(fconf, VLAN_F, fs->val.ivlan_vld, fs->mask.ivlan_vld))
-		return -EOPNOTSUPP;
-
+	if (chip_ver >= CHELSIO_T7) {
+		if (unsupported(fconf, T7_FCOE_F, fs->val.fcoe, fs->mask.fcoe) ||
+		    unsupported(fconf, T7_PORT_F, fs->val.iport, fs->mask.iport) ||
+		    unsupported(fconf, T7_TOS_F, fs->val.tos, fs->mask.tos) ||
+		    unsupported(fconf, T7_ETHERTYPE_F, fs->val.ethtype,
+				fs->mask.ethtype) ||
+		    unsupported(fconf, T7_MACMATCH_F, fs->val.macidx, fs->mask.macidx) ||
+		    unsupported(fconf, T7_MPSHITTYPE_F, fs->val.matchtype,
+				fs->mask.matchtype) ||
+		    unsupported(fconf, T7_FRAGMENTATION_F, fs->val.frag, fs->mask.frag) ||
+		    unsupported(fconf, T7_PROTOCOL_F, fs->val.proto, fs->mask.proto) ||
+		    unsupported(fconf, T7_VNIC_ID_F, fs->val.pfvf_vld,
+				fs->mask.pfvf_vld) ||
+		    unsupported(fconf, T7_VNIC_ID_F, fs->val.ovlan_vld,
+				fs->mask.ovlan_vld) ||
+		    unsupported(fconf, T7_VNIC_ID_F, fs->val.encap_vld,
+				fs->mask.encap_vld) ||
+		    unsupported(fconf, T7_VLAN_F, fs->val.ivlan_vld, fs->mask.ivlan_vld))
+			return -EOPNOTSUPP;
+	} else {
+		if (unsupported(fconf, FCOE_F, fs->val.fcoe, fs->mask.fcoe) ||
+		    unsupported(fconf, PORT_F, fs->val.iport, fs->mask.iport) ||
+		    unsupported(fconf, TOS_F, fs->val.tos, fs->mask.tos) ||
+		    unsupported(fconf, ETHERTYPE_F, fs->val.ethtype,
+				fs->mask.ethtype) ||
+		    unsupported(fconf, MACMATCH_F, fs->val.macidx, fs->mask.macidx) ||
+		    unsupported(fconf, MPSHITTYPE_F, fs->val.matchtype,
+				fs->mask.matchtype) ||
+		    unsupported(fconf, FRAGMENTATION_F, fs->val.frag, fs->mask.frag) ||
+		    unsupported(fconf, PROTOCOL_F, fs->val.proto, fs->mask.proto) ||
+		    unsupported(fconf, VNIC_ID_F, fs->val.pfvf_vld,
+				fs->mask.pfvf_vld) ||
+		    unsupported(fconf, VNIC_ID_F, fs->val.ovlan_vld,
+				fs->mask.ovlan_vld) ||
+		    unsupported(fconf, VNIC_ID_F, fs->val.encap_vld,
+				fs->mask.encap_vld) ||
+		    unsupported(fconf, VLAN_F, fs->val.ivlan_vld, fs->mask.ivlan_vld))
+			return -EOPNOTSUPP;
+	}
 	/* T4 inconveniently uses the same FT_VNIC_ID_W bits for both the Outer
 	 * VLAN Tag and PF/VF/VFvld fields based on VNIC_F being set
 	 * in TP_INGRESS_CONFIG.  Hense the somewhat crazy checks
@@ -793,9 +819,12 @@ static int del_filter_wr(struct adapter *adapter, int fidx)
 int set_filter_wr(struct adapter *adapter, int fidx)
 {
 	struct fw_filter2_wr *fwr;
+	unsigned int chip_ver;
 	struct filter_entry *f;
 	struct sk_buff *skb;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
+
 	if (fidx < adapter->tids.nhpftids)
 		f = &adapter->tids.hpftid_tab[fidx];
 	else
@@ -883,8 +912,10 @@ int set_filter_wr(struct adapter *adapter, int fidx)
 	if (f->fs.newsmac)
 		fwr->smac_sel = f->smt->idx;
 	fwr->rx_chan_rx_rpl_iq =
-		htons(FW_FILTER_WR_RX_CHAN_V(0) |
-		      FW_FILTER_WR_RX_RPL_IQ_V(adapter->sge.fw_evtq.abs_id));
+		htons(FW_FILTER_WR_RX_RPL_IQ_V(adapter->sge.fw_evtq.abs_id));
+	if (chip_ver <= CHELSIO_T6)
+		fwr->rx_chan_rx_rpl_iq |=
+			htons(FW_FILTER_WR_RX_CHAN_V(cxgb4_port_e2cchan(f->dev)));
 	fwr->maci_to_matchtypem =
 		htonl(FW_FILTER_WR_MACI_V(f->fs.val.macidx) |
 		      FW_FILTER_WR_MACIM_V(f->fs.mask.macidx) |
@@ -993,7 +1024,9 @@ void clear_filter(struct adapter *adap, struct filter_entry *f)
 		t4_free_encap_mac_filt(adap, pi->viid,
 				       f->fs.val.ovlan & 0x1ff, 0);
 
-	if ((f->fs.hash || is_t6(adap->params.chip)) && f->fs.type)
+	if ((f->fs.hash ||
+	     (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T6)) &&
+	     f->fs.type)
 		cxgb4_clip_release(f->dev, (const u32 *)&f->fs.val.lip, 1);
 
 	/* The zeroing of the filter rule below clears the filter valid,
@@ -1296,20 +1329,16 @@ static void mk_act_open_req6(struct filter_entry *f, struct sk_buff *skb,
 			     unsigned int qid_filterid, struct adapter *adap)
 {
 	struct cpl_t6_act_open_req6 *t6req = NULL;
+	struct cpl_t7_act_open_req6 *t7req = NULL;
 	struct cpl_act_open_req6 *req = NULL;
+	u32 chip_ver;
+	__be32 opt2;
+	__be64 opt0;
 
-	t6req = (struct cpl_t6_act_open_req6 *)__skb_put(skb, sizeof(*t6req));
-	INIT_TP_WR(t6req, 0);
-	req = (struct cpl_act_open_req6 *)t6req;
-	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ6, qid_filterid));
-	req->local_port = cpu_to_be16(f->fs.val.lport);
-	req->peer_port = cpu_to_be16(f->fs.val.fport);
-	req->local_ip_hi = *(__be64 *)(&f->fs.val.lip);
-	req->local_ip_lo = *(((__be64 *)&f->fs.val.lip) + 1);
-	req->peer_ip_hi = *(__be64 *)(&f->fs.val.fip);
-	req->peer_ip_lo = *(((__be64 *)&f->fs.val.fip) + 1);
-	req->opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
-					f->fs.newvlan == VLAN_REWRITE) |
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
+				   f->fs.newvlan == VLAN_REWRITE) |
 				DELACK_V(f->fs.hitcnts) |
 				L2T_IDX_V(f->l2t ? f->l2t->idx : 0) |
 				SMAC_SEL_V((cxgb4_port_viid(f->dev) &
@@ -1319,52 +1348,90 @@ static void mk_act_open_req6(struct filter_entry *f, struct sk_buff *skb,
 				ULP_MODE_V(f->fs.nat_mode ?
 					   ULP_MODE_TCPDDP : ULP_MODE_NONE) |
 				TCAM_BYPASS_F | NON_OFFLOAD_F);
-	t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs,
-								      f->dev)));
-	t6req->opt2 = htonl(RSS_QUEUE_VALID_F |
-			    RSS_QUEUE_V(f->fs.iq) |
-			    TX_QUEUE_V(f->fs.nat_mode) |
-			    T5_OPT_2_VALID_F |
-			    RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
-			    PACE_V((f->fs.maskhash) |
+	opt2 = cpu_to_be32(RSS_QUEUE_VALID_F |
+			   RSS_QUEUE_V(f->fs.iq) |
+			   TX_QUEUE_V(f->fs.nat_mode) |
+			   T5_OPT_2_VALID_F |
+			   RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
+			   PACE_V((f->fs.maskhash) |
 				   ((f->fs.dirsteerhash) << 1)));
+
+	if (chip_ver >= CHELSIO_T7) {
+		t7req = (struct cpl_t7_act_open_req6 *)__skb_put(skb, sizeof(*t7req));
+		INIT_TP_WR(t7req, 0);
+		req = (struct cpl_act_open_req6 *)t7req;
+		t7req->opt0 = opt0;
+		t7req->opt2 = opt2;
+		t7req->params = cpu_to_be64(T7_FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	} else {
+		t6req = (struct cpl_t6_act_open_req6 *)__skb_put(skb, sizeof(*t6req));
+		INIT_TP_WR(t6req, 0);
+		req = (struct cpl_act_open_req6 *)t6req;
+		t6req->opt0 = opt0;
+		t6req->opt2 = opt2;
+		t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	}
+
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ6, qid_filterid));
+	req->local_port = cpu_to_be16(f->fs.val.lport);
+	req->peer_port = cpu_to_be16(f->fs.val.fport);
+	req->local_ip_hi = *(__be64 *)(&f->fs.val.lip);
+	req->local_ip_lo = *(((__be64 *)&f->fs.val.lip) + 1);
+	req->peer_ip_hi = *(__be64 *)(&f->fs.val.fip);
+	req->peer_ip_lo = *(((__be64 *)&f->fs.val.fip) + 1);
 }
 
 static void mk_act_open_req(struct filter_entry *f, struct sk_buff *skb,
 			    unsigned int qid_filterid, struct adapter *adap)
 {
 	struct cpl_t6_act_open_req *t6req = NULL;
+	struct cpl_t7_act_open_req *t7req = NULL;
 	struct cpl_act_open_req *req = NULL;
+	u32 chip_ver;
+	__be32 opt2;
+	__be64 opt0;
+
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
+				   f->fs.newvlan == VLAN_REWRITE) |
+			   DELACK_V(f->fs.hitcnts) |
+			   L2T_IDX_V(f->l2t ? f->l2t->idx : 0) |
+			   SMAC_SEL_V((cxgb4_port_viid(f->dev) &
+				       0x7F) << 1) |
+			   TX_CHAN_V(f->fs.eport) |
+			   NO_CONG_V(f->fs.rpttid) |
+			   ULP_MODE_V(f->fs.nat_mode ?
+				      ULP_MODE_TCPDDP : ULP_MODE_NONE) |
+			   TCAM_BYPASS_F | NON_OFFLOAD_F);
+	opt2 = cpu_to_be32(RSS_QUEUE_VALID_F |
+			   RSS_QUEUE_V(f->fs.iq) |
+			   TX_QUEUE_V(f->fs.nat_mode) |
+			   T5_OPT_2_VALID_F |
+			   RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
+			   PACE_V((f->fs.maskhash) |
+				  ((f->fs.dirsteerhash) << 1)));
+	if (chip_ver >= CHELSIO_T7) {
+		t7req = (struct cpl_t7_act_open_req *)__skb_put(skb, sizeof(*t7req));
+		INIT_TP_WR(t7req, 0);
+		req = (struct cpl_act_open_req *)t7req;
+		t7req->opt0 = opt0;
+		t7req->opt2 = opt2;
+		t7req->params = cpu_to_be64(T7_FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	} else {
+		t6req = (struct cpl_t6_act_open_req *)__skb_put(skb, sizeof(*t6req));
+		INIT_TP_WR(t6req, 0);
+		req = (struct cpl_act_open_req *)t6req;
+		t6req->opt0 = opt0;
+		t6req->opt2 = opt2;
+		t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	}
 
-	t6req = (struct cpl_t6_act_open_req *)__skb_put(skb, sizeof(*t6req));
-	INIT_TP_WR(t6req, 0);
-	req = (struct cpl_act_open_req *)t6req;
 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ, qid_filterid));
 	req->local_port = cpu_to_be16(f->fs.val.lport);
 	req->peer_port = cpu_to_be16(f->fs.val.fport);
 	memcpy(&req->local_ip, f->fs.val.lip, 4);
 	memcpy(&req->peer_ip, f->fs.val.fip, 4);
-	req->opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
-					f->fs.newvlan == VLAN_REWRITE) |
-				DELACK_V(f->fs.hitcnts) |
-				L2T_IDX_V(f->l2t ? f->l2t->idx : 0) |
-				SMAC_SEL_V((cxgb4_port_viid(f->dev) &
-					    0x7F) << 1) |
-				TX_CHAN_V(f->fs.eport) |
-				NO_CONG_V(f->fs.rpttid) |
-				ULP_MODE_V(f->fs.nat_mode ?
-					   ULP_MODE_TCPDDP : ULP_MODE_NONE) |
-				TCAM_BYPASS_F | NON_OFFLOAD_F);
-
-	t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs,
-								      f->dev)));
-	t6req->opt2 = htonl(RSS_QUEUE_VALID_F |
-			    RSS_QUEUE_V(f->fs.iq) |
-			    TX_QUEUE_V(f->fs.nat_mode) |
-			    T5_OPT_2_VALID_F |
-			    RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
-			    PACE_V((f->fs.maskhash) |
-				   ((f->fs.dirsteerhash) << 1)));
 }
 
 static int cxgb4_set_hash_filter(struct net_device *dev,
@@ -1663,7 +1730,7 @@ int __cxgb4_set_filter(struct net_device *dev, int ftid,
 	if (ret)
 		goto free_tid;
 
-	if (is_t6(adapter->params.chip) && fs->type &&
+	if (chip_ver >= CHELSIO_T6 && fs->type &&
 	    ipv6_addr_type((const struct in6_addr *)fs->val.lip) !=
 	    IPV6_ADDR_ANY) {
 		ret = cxgb4_clip_get(dev, (const u32 *)&fs->val.lip, 1);
@@ -2140,12 +2207,13 @@ void filter_rpl(struct adapter *adap, const struct cpl_set_tcb_rpl *rpl)
 
 void init_hash_filter(struct adapter *adap)
 {
-	u32 reg;
+	u32 reg, chip_ver;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	/* On T6, verify the necessary register configs and warn the user in
 	 * case of improper config
 	 */
-	if (is_t6(adap->params.chip)) {
+	if (chip_ver >= CHELSIO_T6) {
 		if (is_offload(adap)) {
 			if (!(t4_read_reg(adap, TP_GLOBAL_CONFIG_A)
 			   & ACTIVEFILTERCOUNTS_F)) {
-- 
2.39.1

