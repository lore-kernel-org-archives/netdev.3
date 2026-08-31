Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3D3A7597
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211952; cv=none; b=VrBWheqsdy0OOyxXRF2VOhbsEqL2LES5CiI7McmQI5mPcvANlf1ZHYDkwUcS7QsKGbZtFIM9hldwy5sKf3aeRZGq+vmVVXRhaLex1DMbfCQfDgZlkXfsGw9UdFJoPFmcnbyNPnfWMTVFwwEWNnZxDzomurYrCibhAvfrNaGM9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211952; c=relaxed/simple;
	bh=UXxkUsIqEsEzs/jJY1EGRRQB+fhz+Cexsk1VQ2BxJgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpRvIrzFEgJ0AnRYohAViYsS++ThmTgMsh9L0t/XX3y8zidMN16sEqrGA1mzdnIFsLeIralVHHTZAx5F3qXZA5rO27biiu1LCo+FWQsHS0BCDm4zhgn0ks2hjdhOGr4hp2FJGEHsGsQ/nNWHccwveLl81EUmqzhAGR4jeWedBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sxjp4ZzC; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxjp4ZzC"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c744a00edso279577d50.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211949; x=1788816749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+xh4irkGrNqEP3jQLO2npXYxgHpOapd0GnPuNzoPoI=;
        b=Sxjp4ZzCKcyyCPQJh2DI4NBXiXdRI4ohHSV8BuMp9S5vRq1gJ9E0lE8om7QMr4iptx
         N27/Bh5PkwP8iBwhfJ7VyJFpjMFBeR8xjbc/dD7ZppdubEdSyyE44jJMIszI3GRYfpVA
         DrRcI/VyeRJVZ5AeTNfOb2NLPIyMKOX+8RlSlNQYCnYDrGnCY9trlgQscTWX1MJAF2/u
         OtRE8sqdkqTTPbRbPkPWFIs9NmZcz/X3P7t1Gq/16WGTlXYoMtDJ/yJDVjgWqwiIl0go
         +lifij8PiI3RPcUV9Xp7tlAGMikeNB0rii9ietu6w5eAY936uuGxb+/HHN60TQM4WlAe
         sQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211949; x=1788816749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+xh4irkGrNqEP3jQLO2npXYxgHpOapd0GnPuNzoPoI=;
        b=qFcGelF8Lk9Jl70zwZWax7ViweV73tEOR3pr5xYkpTT14jjlZ7yOXjMPh+nDu3NJQd
         qIsvkRFnMhOzsxrr4S1HYXTxe6s1W2paWnets8BhpSlcaV+I7s3biESPTz62A191HB7h
         fWj6UWFHJrqEd3RHv4EDrwAz++Lk9RUHq9E5stVr0tmrTt2zNpvYPFH3BYNZwexepQly
         NGuWXgHvwXJIxWrh3sBDcNkb2zHyyyMu40/O6oHbo351tXw7h2giB9FUXuw54QlRq93a
         j1jLdp69voJw0AYzp0lEQ1q59+3IuCNkFSDLUeyZVXB1J6Yxdl9k4+2RLV1NAH/4In+1
         GMXw==
X-Gm-Message-State: AFuF++lcR5LvRNYJJBub4eRU/pLbztivq6F0vvkK+DxQZHi7xc1a0Oti
	qCS/+Se1azxl2eeWFfnbmdK1+SeryI0/cE6ZTNg+UDF9YGcUMQ9n269nsQP+6w==
X-Gm-Gg: AYBFou3V4qei7ODFqJQ3NKqFaTfMidOLsNkTBvDi0e0fy92pZ0ElJ05iFbuDmvGOccb
	tr1o8BNGG5DFienSA4bGE9BdARfMa/L1mPaPss/V4eY8aiLScD1g6qsKqlIWyaUxLI7YMnPn7VT
	VzosDD5S1Oecwyioy5//oEmk3IBDhmjnwpVz38pTmXFFGnjfT6ViaVpBSHNznqGpnhKc1DYFr+8
	Nsz2xF95DTAceK5Pz3Dm69k6tncZnn9K6tLNbvBgmg8G/eFI7DyYuJCabnTgO8HMIH52Y7biF80
	osZ3NhGYtJCLxL6tb4LOtaLY6T67RYpPpuOGLCGLO/+vdY6Xzd5ldyC71j5EBNKo6r9yPExcODJ
	O4xt6+eYv1eSKmPXFTrXfs8049td82O3z24KMKr9SG9I6UBRpLwPt3wcbETzcB71P5djqbIfXEv
	HBXNApZiqWsgAXwkBu58ZueYFHOc+MyW5NSdST615aJJpS50NyHGY2zAa0y8Kz2SVWjVD1FrXuX
	twOycajylrdRhXPQnzwTj4APVyXHWtr7PNrpTNPsIKyh+1nnFCn1RBmY5ylEHbp3pZflhMW2xY=
X-Received: by 2002:a53:e6c2:0:b0:667:b84f:e402 with SMTP id 956f58d0204a3-66e4c77121amr6459642d50.50.1788211948871;
        Mon, 31 Aug 2026 14:32:28 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8616243a833sm45474307b3.13.2026.08.31.14.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:32:28 -0700 (PDT)
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
	Joshua A Hay <joshua.a.hay@intel.com>
Subject: [PATCH net-next v7 3/6] idpf: support pacing offload
Date: Mon, 31 Aug 2026 17:26:12 -0400
Message-ID: <20260831213221.1370774-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
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
horizon (pacing_offload_horizon) are offloaded.

Negotiate the feature with the device using virtchnl. Support is
conditional on
- splitq mode, where tx and tx completion queues are separate, so
  completions can be returned out of order.
- flow scheduling mode, where completions can arrive out of order.
- PTP to ensure the NIC clock is synced to CLOCK_TAI.

These features are negotiated per adapter, but expect all vports to
uniformly request splitq (req_[rt]x_splitq) and flow scheduling
(flow_sch_en) when available.

Do not explicitly check all preconditions. Trust the firmware to
only advertise EDT when all are met. In general, firmware response is
trusted to be correct. If not, EDT would be the least of the worries.
In particular, granularity is trusted to be a power of two. And
time_horizon_ns is a range expressible given the chosen granularity.

Packets beyond the horizon are sent immediately with the overflow bit
set.

On device reset, dev->pacing_offload_horizon, fq offload_horizon and
granularity are not re-negotiated. It is safe to assume that firmware
does not change these EDT capabilities across resets.

Must not be called from netpoll due to ktime_get. But netpoll does not
generate packets with EDT, so no explicit test is needed.

Do not fail device initialization on EDT init error. Log an error, but
continue without EDT, similar to PTP.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
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

Sashiko, ignore pre-existing issues.

Sashiko, ignore that idpf_tx_splitq_set_txtime may have a benign race
by calling ktime_mono_to_any twice to get TAI to REALTIME offset.
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  6 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 67 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 60 ++++++++++++++++-
 5 files changed, 150 insertions(+), 3 deletions(-)

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
index 827c795afcb6..c2ad3fdf72aa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -890,6 +890,12 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	if (adapter->edt_caps.time_horizon_ns &&
+	    idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
+	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
+			     VIRTCHNL2_CAP_SPLITQ_QSCHED))
+		netdev->max_pacing_offload_horizon = adapter->edt_caps.time_horizon_ns;
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..4d7a28ca22dd 100644
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
@@ -3011,6 +3017,61 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
+				      const struct idpf_tx_queue *tx_q,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int offload_slack_ns = 400;
+	struct idpf_netdev_priv *np = netdev_priv(skb->dev);
+	u64 ts, now, horizon;
+
+	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
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
@@ -3097,6 +3158,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
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
index 1caf52706973..030ecd9b6c41 100644
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
+	if (!gran_ns) {
+		dev_warn(&adapter->pdev->dev, "EDT granularity undefined\n");
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
 
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
+		err = idpf_send_get_edt_caps_msg(adapter);
+		if (err) {
+			dev_err(&adapter->pdev->dev, "EDT init failed, err=%d\n", err);
+			memset(&adapter->edt_caps, 0, sizeof(adapter->edt_caps));
+		}
+	}
+
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
 	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
-- 
2.55.0.897.gb25b4bd76c-goog

