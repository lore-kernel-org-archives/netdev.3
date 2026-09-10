Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA24AD7D8
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060324; cv=none; b=qs3p122oPYmFn5pHuAKc88wF18rwrztNIALa1K3W9+4HPe6i58OV5pKsyZVv+mPspJpaoUvkg0Ok5ewmVPoLakTPsuCmlO3eoZIdHpwoqXRYau7JKmVqloXc1X/xZ3XHCjWs2nueRVN0QjHI5Y4cltg2JBowJziv0tO6FKaRp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060324; c=relaxed/simple;
	bh=DRDbh0HEYysmmCWOI83EsRkpQ3bWZP/dM3zvg3VFj74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw9LvBOlpWZrSw+huETMgeR9vyaweItFMd62faUr6AAi/cTQ4zrchWTfS/3trtOBjr4GQLhqIbb60XgXFGIYwpl59PdZYGkJrSbS3lQ+6QCD5do67WqZ/GAf053KhOYdV8maXIKEb/W9r4RhD7IPDAdkIAHkUhtXWJJkUSr4QKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca+3bCQ7; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca+3bCQ7"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66bd7857841so8121253d50.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060300; x=1789665100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dL4nSkvq/uP2qyvgHqZ6XOcTRLRK6KiP/KdTK4+oACY=;
        b=Ca+3bCQ7H7GDEowxECDi1L9ciYn7s25k6CHDrSwADxDJFILwsgM2Dtypod87lQxOul
         +jtELtF4Mw8iS4Pe1AaeAxdgAuppMRAp3yFFmprWoKocE1ZyXubSFNDfQ1VWOjSSUu3U
         Cs1tvTsNdBSr7XUPR4NisiVc9jNaPcuXXvW2JdtaLLkV+Yil7q6XZ8SjMIUBySO3zTe3
         LtlsIUoreDxSq9hIHUCLknuqgQoYk2TFwMdpHCzczHl7jM9AXgnaVtZCZGLsj4zYdX5W
         KP4Uj8On+fYZpbA0ONG+gp/1kiYR82djf54ZbGxVkjQc7N4gai9dTT1PiwyIZr9lSjrf
         yEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060300; x=1789665100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dL4nSkvq/uP2qyvgHqZ6XOcTRLRK6KiP/KdTK4+oACY=;
        b=SLVYoIQUtc1667J5Wp87DgGc0QNp6AI8N9sI913xq0hHH7Yh6LTSBWApyy0M9SL6wj
         XSSdsYgW76Q08Q9ttZ6Ohpgtq/h6+9dBiwDWOUUSuAlb1sIj/o2foOLthqETms62Obcr
         NHpkpkPnxspJnxONrqs8zl8plmbJ8aaJM6yolk09VLlPEGNSXoxAruGEtwYIbE19fQeg
         I4XcWgZpuzG0jxjxAAFt3iAmgoVSUU3XlTM7Cr4zKEFn0d9PokjsxSc9DcVBnM/q/+yD
         PIGSCGf1Xt3a7Rdf3o1x/sQvGcG8ajTsVHWd/rH8yOVE8PKUejPwsxOmG/WKHcP79DIQ
         /SeQ==
X-Gm-Message-State: AFuF++kfrnVUhr1S83wN2k8L6AIFh8JsFkEasZiAoj9e0uHw6VbR6GV6
	Om0bWa331lyIGPXdvTUuKuqP+osgOufxP89J8R2TXtxXM434SEmPHVuuSXsCeA==
X-Gm-Gg: AYBFou3p6gAGGocHxNVFgo6Yb1Lk9RXlV95tN6TwTzM/lCYh+9uO7OUFlpmGoInvZ3b
	gL5XY1KGIkdYv7aahI7eZPlXDpmHi7enWikdHLBCoSvta/dPPTs5fiFG0AGPwl1t+SvbSUXApxs
	AIfY7ohRT320Ht1I47/51l1m6gM9reOLBG/YRBniDfXz7ZohN61WUsewRPkLfDYTool+IxwXLq0
	/PdxLZ2YiSIl2uonmf6Qt5Hgb/pn/z61hCZKSweSaBt6wQMQ/Ib11Ks9arIWXAzVW469wNPF9EE
	OuAK6Jxcr/w0cHGmG4vKKHPtWdPDccfoQofvvRwtI5EDsXwm6WZNHfU2frnwnKwvbhDoP3Ez2qB
	BGFA1o60bpBaGVmdmkQwLM4ILryVzhIM5L5XKrIRL0qUXgoAd2vtRLlJ7tsbIzgT+FBXRWc6SXJ
	1vJ8VqzUXf1AUVh2L4/dXoxsiwYPOLBNL4KOe5A2WjhdIjYf6QCpUgzCTd062D0xQHTF9kK7sF5
	5r4UkiRkhBZedO2e1+aum+lbvKdazP14NGLa+o/9yw4vrzUxxyTtzNVtblM5/z6LQMLaLMKjDAs
	DzJpyRvdZQ==
X-Received: by 2002:a05:690e:4852:20b0:670:4baf:c493 with SMTP id 956f58d0204a3-671246c1565mr108731d50.55.1789060299867;
        Thu, 10 Sep 2026 10:11:39 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:39 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joshua A Hay <joshua.a.hay@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v9 4/7] idpf: support pacing offload
Date: Thu, 10 Sep 2026 13:10:23 -0400
Message-ID: <20260910171131.2532487-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

If skb->tstamp is in the future, program this future delivery txtime
in the transmit descriptor.

TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
the FQ offload_horizon is configured. But device support for pacing
offload must be more robust: it can also be reached through SO_TXTIME.

Bounds check txtime. Only packets with timestamp between now and the
horizon (max_pacing_offload_horizon) are offloaded when pacing offload
is enabled on the device via pacing_offload.

Negotiate the feature with the device using virtchnl. Support is
conditional on
- splitq mode, where tx and tx completion queues are separate, so
  completions can be returned out of order.
- flow scheduling mode, where completions can arrive out of order.
- PTP to ensure the NIC clock is synced to CLOCK_TAI.

These features are negotiated per adapter, but expect all vports to
uniformly request splitq (req_[rt]x_splitq) and flow scheduling
(flow_sch_en) when available.

Packets beyond the horizon are sent immediately with the overflow bit
set.

On device reset, EDT capabilities are re-negotiated with firmware.
If re-negotiation succeeds, dev->max_pacing_offload_horizon is refreshed.
If pacing offload is no longer supported, dev->max_pacing_offload_horizon is set to 0.

Must not be called from netpoll due to ktime_get. But netpoll does not
generate packets with EDT, so no explicit test is needed.

Do not fail device initialization on EDT init error. Log an error, but
continue without EDT, similar to PTP.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v8 -> v9
    - on device reset, re-evaluate and refresh pacing horizons
    - check boolean pacing_offload and use max_pacing_offload_horizon
    - update commit message regarding reset re-negotiation
    - small typo in changelog
  v7 -> v8
    - remove unused variable np in idpf_tx_splitq_set_txtime
  v6 -> v7
    - rebase onto libie changes: adjust idpf_send_get_edt_caps_msg
    - only set horizon if splitq with flow scheduling
    - fail on illegal granularity 0, rather than use hardcoded default
    - zero edt_caps on negotation error, in case of call after reset
    - cache ts_gran_pow2 in idpf_tx_queue to be in hot cache line
    - similar to FQ, add offload slack to avoid pacing < 400ns of now
    - remove now superfluous include netpoll.h
    - reverse xmas tree (1x)
  v5 -> v6
    - move EDT caps from virtchnl2_edt_caps_ilog2 to idpf_edt_caps_ilog2
    - do not fail device init if EDT init failed, same as PTP
    - replace netpoll branch with commit-msg comment
    - add commit-msg comment about device reset
    - add commit-msg about behavior beyond horizon
    - add commit-msg about trusting EDT capability response
  v4 -> v5
    - fix kdoc: idpf.h:738 struct member 'edt_caps' not described..
  v3 -> v4
    - add EDT virtchnl negotiation
    - move endianness fix to its own iwl-net patch
    - update commit-msg: check is against pacing_offload_horizon, not max_..
    - simplify assignment, avoid the le32 assignment in favor of u8 inits
    - replace open coded constant with IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M
    - (minor) fix 24b timestamp comment: is 23b + overflow bit
    - (minor) remove unused parameter
  v2 -> v3
    - use READ_ONCE and read pacing_offload_horizon only once
  v1 -> v2
    - move special zero case up and return early
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 19 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 69 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 60 +++++++++++++++-
 5 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c844c..f214023095ee 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -604,6 +604,16 @@ struct idpf_vport_config {
 	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);
 };
 
+/**
+ * struct idpf_edt_caps_ilog2 - Host parsed EDT capabilities.
+ * @time_horizon_ns: Total time window in nanoseconds.
+ * @tstamp_granularity_pow2: Log2 of timestamp granularity in nanoseconds.
+ */
+struct idpf_edt_caps_ilog2 {
+	u32 time_horizon_ns;
+	u8 tstamp_granularity_pow2;
+};
+
 #define idpf_for_each_vport(adapter, iter) \
 	for (struct idpf_vport **__##iter = &(adapter)->vports[0], \
 	     *iter = (adapter)->max_vports ? *__##iter : NULL; \
@@ -657,6 +667,7 @@ struct idpf_vport_config {
  * @stats_task: Periodic statistics retrieval task
  * @stats_wq: Workqueue for statistics task
  * @caps: Negotiated capabilities with device
+ * @edt_caps: Negotiated EDT capabilities with device
  * @dev_ops: See idpf_dev_ops
  * @cdev_info: IDC core device info pointer
  * @num_vfs: Number of allocated VFs through sysfs. PF does not directly talk
@@ -720,6 +731,7 @@ struct idpf_adapter {
 	struct delayed_work stats_task;
 	struct workqueue_struct *stats_wq;
 	struct virtchnl2_get_capabilities caps;
+	struct idpf_edt_caps_ilog2 edt_caps;
 
 	struct idpf_dev_ops dev_ops;
 	struct iidc_rdma_core_dev_info *cdev_info;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795afcb6..cd1b173e3b27 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -817,6 +817,21 @@ static void idpf_attach_and_open(struct idpf_adapter *adapter)
 	}
 }
 
+static void idpf_vport_set_pacing_offload(struct idpf_vport *vport,
+					  struct net_device *netdev)
+{
+	struct idpf_adapter *adapter = vport->adapter;
+	u32 max_horizon = 0;
+
+	if (adapter->edt_caps.time_horizon_ns &&
+	    idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
+	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
+			     VIRTCHNL2_CAP_SPLITQ_QSCHED))
+		max_horizon = adapter->edt_caps.time_horizon_ns;
+
+	WRITE_ONCE(netdev->max_pacing_offload_horizon, max_horizon);
+}
+
 /**
  * idpf_cfg_netdev - Allocate, configure and register a netdev
  * @vport: main vport structure
@@ -850,6 +865,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 		np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
 		vport->netdev = netdev;
 
+		idpf_vport_set_pacing_offload(vport, netdev);
+
 		return idpf_init_mac_addr(vport, netdev);
 	}
 
@@ -890,6 +907,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	idpf_vport_set_pacing_offload(vport, netdev);
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..97e23ff9faf6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1742,6 +1742,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
 			q->desc_count = rsrc->txq_desc_count;
 			q->tx_max_bufs = idpf_get_max_tx_bufs(adapter);
 			q->tx_min_pkt_len = idpf_get_min_tx_pkt_len(adapter);
+			q->ts_gran_pow2 = adapter->edt_caps.tstamp_granularity_pow2;
 			q->netdev = vport->netdev;
 			q->txq_grp = tx_qgrp;
 			q->rel_q_id = j;
@@ -2408,7 +2409,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
+	desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+
+	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
+	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
+	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
+
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
@@ -3011,6 +3017,63 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
+				      const struct idpf_tx_queue *tx_q,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int offload_slack_ns = 400;
+	u64 ts, now, horizon;
+
+	if (!tx_q->netdev->pacing_offload)
+		return;
+
+	horizon = READ_ONCE(tx_q->netdev->max_pacing_offload_horizon);
+	if (!horizon)
+		return;
+
+	switch (skb->tstamp_type) {
+	case SKB_CLOCK_REALTIME:
+		ts = ktime_to_ns(ktime_add(skb->tstamp,
+					   ktime_mono_to_any(0, TK_OFFS_TAI) -
+					   ktime_mono_to_any(0, TK_OFFS_REAL)));
+		break;
+	case SKB_CLOCK_MONOTONIC:
+		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
+		break;
+	case SKB_CLOCK_TAI:
+		ts = ktime_to_ns(skb->tstamp);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	now = ktime_get_clocktai_ns();
+	if (ts < now + offload_slack_ns)
+		return;
+
+	/* beyond offload horizon? set overflow bit only */
+	if (ts > now + horizon) {
+		tx_params->offload.desc_ts[2] =
+			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
+		return;
+	}
+
+	ts >>= tx_q->ts_gran_pow2;
+
+	/* 0 is valid 23b timestamp, but also means field unset.
+	 * Increase by one to avoid this case
+	 */
+	if ((ts & 0x7fffff) == 0) {
+		tx_params->offload.desc_ts[0] = 1;
+		return;
+	}
+
+	tx_params->offload.desc_ts[0] = ts & 0xff;
+	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
+	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
+}
+
 /**
  * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
  * @skb: send buffer
@@ -3097,6 +3160,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+		if (skb->tstamp)
+			idpf_tx_splitq_set_txtime(skb, tx_q, &tx_params);
+
 		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2..fe0c913f9bb9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -161,6 +161,7 @@ union idpf_tx_flex_desc {
  * @tso_segs: Number of segments to be sent
  * @tso_hdr_len: Length of headers to be duplicated
  * @td_cmd: Command field to be inserted into descriptor
+ * @desc_ts: Flow scheduling offload timestamp
  */
 struct idpf_tx_offload_params {
 	u32 tx_flags;
@@ -174,6 +175,7 @@ struct idpf_tx_offload_params {
 	u16 tso_hdr_len;
 
 	u16 td_cmd;
+	u8 desc_ts[3];
 };
 
 /**
@@ -608,6 +610,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  *	 hot path TX pointers stored in vport. Used in both singleq/splitq.
  * @desc_count: Number of descriptors
  * @tx_min_pkt_len: Min supported packet length
+ * @ts_gran_pow2: Txtime timestamp granularity in nanoseconds (log2).
  * @thresh: XDP queue cleaning threshold
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
@@ -666,7 +669,10 @@ struct idpf_tx_queue {
 	u16 desc_count;
 
 	union {
-		u16 tx_min_pkt_len;
+		struct {
+			u16 tx_min_pkt_len;
+			u8 ts_gran_pow2;
+		};
 		u32 thresh;
 	};
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706973..928de868fa62 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/net/intel/libie/pci.h>
+#include <linux/log2.h>
 #include <net/libeth/rx.h>
 
 #include "idpf.h"
@@ -553,7 +554,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
 			    VIRTCHNL2_CAP_LOOPBACK		|
-			    VIRTCHNL2_CAP_PTP);
+			    VIRTCHNL2_CAP_PTP			|
+			    VIRTCHNL2_CAP_EDT);
 
 	err = idpf_send_mb_msg_stack(adapter, &xn_params, &caps);
 	if (err)
@@ -573,6 +575,54 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 	return err;
 }
 
+/**
+ * idpf_send_get_edt_caps_msg - Send virtchnl get EDT caps msg
+ * @adapter: Driver specific private struct
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_send_get_edt_caps_msg(struct idpf_adapter *adapter)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+		.chnl_opcode	= VIRTCHNL2_OP_GET_EDT_CAPS,
+	};
+	struct virtchnl2_edt_caps caps = {};
+	u64 gran_ns, horizon_ns;
+	int err;
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &caps);
+	if (err)
+		return err;
+
+	if (xn_params.recv_mem.iov_len < sizeof(caps)) {
+		err = -EIO;
+		goto free_rx_buf;
+	}
+
+	memcpy(&caps, xn_params.recv_mem.iov_base, sizeof(caps));
+	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
+	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
+	if (horizon_ns > U32_MAX) {
+		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
+		err = -EINVAL;
+		goto free_rx_buf;
+	}
+	if (!gran_ns || !is_power_of_2(gran_ns)) {
+		dev_warn(&adapter->pdev->dev, "Invalid EDT granularity\n");
+		err = -EINVAL;
+		goto free_rx_buf;
+	}
+
+	adapter->edt_caps.time_horizon_ns = horizon_ns;
+	adapter->edt_caps.tstamp_granularity_pow2 = ilog2(gran_ns);
+
+free_rx_buf:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+
+	return err;
+}
+
 /**
  * idpf_mmio_region_non_static - Check if region is not static
  * @mmio_info: PCI resources info
@@ -3085,6 +3135,14 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		}
 	}
 
+	memset(&adapter->edt_caps, 0, sizeof(adapter->edt_caps));
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
+		err = idpf_send_get_edt_caps_msg(adapter);
+		if (err)
+			dev_err(&adapter->pdev->dev,
+				"EDT init failed, err=%d\n", err);
+	}
+
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
 	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
-- 
2.55.0.1007.g17ff1f9808-goog

