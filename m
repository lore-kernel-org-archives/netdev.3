Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC4335BBB
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586753; cv=none; b=bCy+Ak6h+1ipQkPJ8Vd2oBuEmLiVgmsqBVj39D+TY/V6YqheB5UPBovut5KUWNXRLodkUQKqqtfWPz3WuZwmQZDFP0BjCuUfwgIP6fIsyibNJNs235XXXJ883s+8tZfUmsHtP69Km1Sd2nysLRgDo2YkLmuwkzPknw/uLkFN0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586753; c=relaxed/simple;
	bh=zec+55ab3YT0w77903VBswCAY9sd9YekVCua/TwHj8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNvtgbx1eWkMHJ+yRI9r8/hDJxZ3ANBom08sdftm7uIRrlqErS1BfphGsDT0dNvHhODvRkTZqGW10OoYFx3Xhxp5knLaWkqdlDtdAEy6rfyVCYcr9sx+1svLwFT/xego7VmGC536GdCmh90n/h3gVql7N5ncI/OcjUG2wpSBi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3N4nju4; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3N4nju4"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6688dfaed31so2313287d50.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586750; x=1787191550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5su3Sb+fRiGsTSCMy9qYdzylpcx583cxA2pyRChJkI=;
        b=Z3N4nju4ORF9dgdqwZUQ6elu4r1sbdRBJaB9qm9uYLJnoRVmiithEX5nPWJCqsk+h+
         Y98c9kSv7FnANPiGhn1RD7jicYmyQGJOG3f8jyFP0+dVrqjXytpj7VEyJaN0x8b7ZwVT
         RIJpIX9tZi7x0flz9bSQEyypuiFx0o1LmmnNFAMrthuJ0Hvlf1q/y3RlqOk4YWTlAhSo
         bKu6En7zQlXkBD8Rz0M9QuRxrjW5FJKNu89qm9HpzgLFVNh57ol/xQTXyQxtCyFEIzxg
         G+pYs2tySKQBXWogiTpEtn8L8VYfAPHNSKEM0XDQgaDvkLL4ZFhSvSOzB2rqPjY7BnXS
         Z1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586750; x=1787191550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5su3Sb+fRiGsTSCMy9qYdzylpcx583cxA2pyRChJkI=;
        b=KLUovVb4CQmxWS2kC7v3vfOaPJCmtF3Yajm8QlVn6QhkI0avoCEia0WSF1jxF/9ORt
         w0/U1KVOkNRP+AkjtON4aRE41GK4sMeosiMg3KsKquPd46/Q9gaE4iiQFHABSClpgjkE
         hWrUtRmBPubPxQLHry8lSSdvhbmxYGxpxEfn4hnx5tzVWRvSYc23jYWieuchubg4fhu9
         UN1KPHzYj4OX1krSlKfHXea3saJ6mMI8UYZo7OpdM6cjoomU9C1DXeBF4gfZsVl2ghz+
         JJBohrNsE83a5L/e+RLsfDDVV7OWteNOhWWeQFUtjNvjbuEl0teUiQ6lKsPidvDQ3h5L
         1U6A==
X-Gm-Message-State: AOJu0YwI1ggPlQVyc8eIKrSj3OfwYV1O7jlE/fMEDjxv0fSvXmu6AalS
	S/qX8Tn+w4anG9HVu3mBHvlmrPp5CZkanlQUNJHyeUk/FAszuOOXp3odQWDcKA==
X-Gm-Gg: AR+sD11W6HWaxMuEJgSH3yLxH3saUTvCLXRcGym7ozEf6sOd6AfjZUc4CqidbNT+PRR
	OTgpjYGL3+rXpM4HZv4XbvzXzem+3tv1nwRWO85slm7ooLhdFwgtIjboG1mAwOatACOhRU9WZgY
	CW67wdkt7Nw7uDjBBEkSiiFnVQcvcwzrVpADvPqy5B5iaIXcBe6dWsv7ktBDz4mKda20E8EFOeA
	4t5QkxhLy8GtzLdZmHTJp+1q0qP1pp85kderMbMRqbaijgL7AqEP7LtsYQOdtKT+ZFHo6TvTUo5
	EphJ2JNxud8crjdx/OgiFbZTWI14B9cIrNPYh/xnyqD3gJsZfHNdEe53w35ZU36Oc4AtRWabo7A
	ekEE/M3uyYfp6w3MyUvGL3pb1gfjGWZHmCuxAFL5yKPF5g+c/1FLdY1OVUE/5Y5VND/bWC2SqfD
	F5J8V7OGD9qQMvlONrbSfpdtFlYEtGPWFDvWok9XSRN4qlFRfRDIpB5UaTX+NfJ0vAJjy1czrQd
	GztrVmCWCp9vHczi8vNKyKKbkpuSoZn+8Jbna3IMpF8GbA43vLjh/dAzYg=
X-Received: by 2002:a53:c9cd:0:b0:662:89c8:4a62 with SMTP id 956f58d0204a3-66c514c07a5mr1028203d50.18.1786586750330;
        Wed, 12 Aug 2026 19:05:50 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e74870sm226899d50.6.2026.08.12.19.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:05:49 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/6] idpf: support pacing offload
Date: Wed, 12 Aug 2026 22:03:58 -0400
Message-ID: <20260813020529.3506539-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
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

Do not explicitly check for these preconditions. Trust the firmware to
only advertise EDT when all are met. These features are negotiated
per adapter, but expect all vports to uniformly request splitq
(req_[rt]x_splitq) and flow scheduling (flow_sch_en) when available.

In general, firmware response is trusted to be correct. If not, EDT
would be the least of the worries. In particular, granularity is
trusted to be a power of two, no check needed. And time_horizon_ns
is a range expressible given the chosen granularity.

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
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 66 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 53 ++++++++++++++-
 5 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ec1b75f039bb..4eb2fbe2a62b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -605,6 +605,16 @@ struct idpf_vport_config {
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
 struct idpf_vc_xn_manager;
 
 #define idpf_for_each_vport(adapter, iter) \
@@ -658,6 +668,7 @@ struct idpf_vc_xn_manager;
  * @stats_task: Periodic statistics retrieval task
  * @stats_wq: Workqueue for statistics task
  * @caps: Negotiated capabilities with device
+ * @edt_caps: Negotiated EDT capabilities with device
  * @vcxn_mngr: Virtchnl transaction manager
  * @dev_ops: See idpf_dev_ops
  * @cdev_info: IDC core device info pointer
@@ -720,6 +731,7 @@ struct idpf_adapter {
 	struct delayed_work stats_task;
 	struct workqueue_struct *stats_wq;
 	struct virtchnl2_get_capabilities caps;
+	struct idpf_edt_caps_ilog2 edt_caps;
 	struct idpf_vc_xn_manager *vcxn_mngr;
 
 	struct idpf_dev_ops dev_ops;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index bb81e620c5c8..106e59dd5fad 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -888,6 +888,9 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	if (adapter->edt_caps.time_horizon_ns)
+		netdev->max_pacing_offload_horizon = adapter->edt_caps.time_horizon_ns;
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 99fcd8e298d6..c020ad1e2265 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
+#include <linux/netpoll.h>
+
 #include "idpf.h"
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+
+	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
+	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
+	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
+
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
@@ -3011,6 +3018,59 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
+				      struct idpf_tx_splitq_params *tx_params)
+{
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
+	if (ts < now)
+		return;
+
+	/* beyond offload horizon? set overflow bit only */
+	if (ts > now + horizon) {
+		tx_params->offload.desc_ts[2] =
+			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
+		return;
+	}
+
+	ts >>= np->adapter->edt_caps.tstamp_granularity_pow2;
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
@@ -3097,6 +3157,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+		if (skb->tstamp)
+			idpf_tx_splitq_set_txtime(skb, &tx_params);
+
 		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 908dfa28674e..86e881c697cc 100644
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 8bd6cca64c9b..fd3550cc248d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include <linux/export.h>
+#include <linux/log2.h>
 #include <net/libeth/rx.h>
 
 #include "idpf.h"
@@ -1001,7 +1002,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
 			    VIRTCHNL2_CAP_LOOPBACK		|
-			    VIRTCHNL2_CAP_PTP);
+			    VIRTCHNL2_CAP_PTP			|
+			    VIRTCHNL2_CAP_EDT);
 
 	xn_params.vc_op = VIRTCHNL2_OP_GET_CAPS;
 	xn_params.send_buf.iov_base = &caps;
@@ -1019,6 +1021,49 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 	return 0;
 }
 
+/**
+ * idpf_send_get_edt_caps_msg - Send virtchnl get EDT caps msg
+ * @adapter: Driver specific private struct
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_send_get_edt_caps_msg(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_edt_caps caps = {};
+	struct idpf_vc_xn_params xn_params = {
+		.vc_op = VIRTCHNL2_OP_GET_EDT_CAPS,
+		.send_buf = {
+			.iov_base = &caps,
+			.iov_len = sizeof(caps),
+		},
+		.recv_buf = {
+			.iov_base = &caps,
+			.iov_len = sizeof(caps),
+		},
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	ssize_t reply_sz;
+	u64 gran_ns, horizon_ns;
+
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz < sizeof(caps))
+		return -EIO;
+
+	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
+	if (horizon_ns > U32_MAX) {
+		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
+		return -EINVAL;
+	}
+
+	adapter->edt_caps.time_horizon_ns = horizon_ns;
+	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
+	adapter->edt_caps.tstamp_granularity_pow2 = gran_ns ? ilog2(gran_ns) : 9;
+
+	return 0;
+}
+
 /**
  * idpf_send_get_lan_memory_regions - Send virtchnl get LAN memory regions msg
  * @adapter: Driver specific private struct
@@ -3547,6 +3592,12 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		}
 	}
 
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
+		err = idpf_send_get_edt_caps_msg(adapter);
+		if (err)
+			dev_err(&adapter->pdev->dev, "EDT init failed, err=%d\n", err);
+	}
+
 	err = idpf_map_lan_mmio_regs(adapter);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to map BAR0 region(s): %d\n",
-- 
2.55.0.691.gc56d675ccc-goog

