Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85166301719
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204364; cv=none; b=a+0sVj5KXvBvNhbWUJDjpdUGvA5EoRVtZ5FkfkYL9ublPgWsrGw/GNQu0Sb10iT8Hfd4dBV6XX2dPKr+p+vnc3sufZXmFnW3vkPsnXujpNjibMRIafEBhQPFPRfKnvlQzLuLINlQzEV+quoNxn42zSZ9iqC0zuXlu0EbjQoXTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204364; c=relaxed/simple;
	bh=wHVpO41KbwSfQZYSXcgGkPXDxMGul9SDmLhGOkHVQmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZzjOgCiTmzvuIodAnVy72BK+SrwMwoM5vhLorUH5kTWmzRj9/IXq+4+Dcpte3IiI+yTwvfPajg5feC3F6VbsJr+QH5rBx+4USNPmvuhEy0+RArT1BnSERRIb8K1VWGFndXGlMltoiaQ5xtzqYUwQ5Qcmn07Lk6esEQBH5d5Rlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbmpPXwm; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbmpPXwm"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80bb41f7f3cso5550027b3.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204361; x=1786809161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QvKHnNOM/jCzUFdYY/yccTGiG9kH2rwW973msEJxySs=;
        b=lbmpPXwmAzWT5zZwucfbwo3aRjJi2dOzwE3wXjCUychQBFbMnL5qZenVJVSrRdIXni
         FIptA6Zq9c0e/gmPyV0cgv66rCh0suB+fNQhimw6EBCiZNM6JKFIlp1Y+aBIWz7XMaMN
         QcUyFywhHXzujiNqNYD55GEq3qEkrrpbbsr0yH0Jy4gp1Ck/cQy8c5EekS8oM+Uz6XaU
         PBKq/bh79NeR7dVQkCsrfg369Puusx2QoWUPEX7WazVxfRi08w3582g/mrVMay9652Ca
         36n/mEXgwuUt0BbSISwq6QTd2SJGEHFRA1FkGkDGL67aOgXEn//2r/tr95aY+Ac3lvqm
         fRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204361; x=1786809161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QvKHnNOM/jCzUFdYY/yccTGiG9kH2rwW973msEJxySs=;
        b=Bd5GJ81scXGGKmhttynlv6llosPhjv7MdzS34M+rLxaZe/F2OsQrbeRBh4vOK3RoTI
         xKXoZiiKJYP/D+4gyJSlbYft9I0DoERM6O/agPIZX91uH5L+kuCcGFAbmBZEU8T/6X+1
         W6mk8tZByHFswybTgoM8imUNsbCI6qkUuV34166bm/H3mCCll7sIeLfSFJGNIpKKXXay
         hmmLa0ZdEiUrDbUcV/CNdXdTyRsi6KkkQbXgQaxqG3mX3CtNr83GIQlvGffA27bklWoB
         NoZO9EvXicJdhpocGlQhg+XX/11FRDzC8Gdle9SvQIv3Dt8GYiBq3DWoptBFBn/zvTkp
         95Ug==
X-Gm-Message-State: AOJu0YyHE8U32gsgvZMsRExHd2/hmIi3gnXaskMVafcSj+M8e7sJH+aX
	WSCBrNMLoy9OevfegJn+7Jh4TNHgBuXFdycTiX44XRBAWF1f0grZqDZndMyzfQ==
X-Gm-Gg: AR+sD10/7qbg70Sbu6hP1w4K3UI6KharRhaZMvjJUVGZBmRLiwA79WRDM1ltk9qjrRV
	Ust2OoNdLHzSaUc4cLpYegAhn424HyrdWCzT5DYMpHBDEB6PsiWVQK25a3UEKY3KMgUB9E8aaUj
	+pOdH/mG2jf62+ydRgZby0X5T6hoafyjHRXEFUeozwt55E14+c/+xw9K4UzRU9zT0ieKxZtGvVU
	8Extx4ry6caXaKrzUW8wuuX6GOFCjJMB0ljBHfXMFg0abR8AoEzrfM+GtYGHYUrI63xd5Q8rp/f
	dBz7iL8NX7Fd0jTCTEqzMYOPmTdRdyAMKAqQMSgPGepLTjyBQSNolwNoiXYOVWyqRZ42jadUTFJ
	S35LxKxEUh//mfI4ZvhleccjqMCZ14aVenUdkE09NBWmPAGa3EzKJlWE132+qY/L/Tdfc8I0BDn
	0rajvV5ru2WduRm+XPj5sNKdQUf2pLY+kwuooq+PAghh/VfB/mu5ZM67YIR28mAHSqZ2+gj+QpE
	gnXnV1+asK9LeVWLN52g5JicOUHMIzQTz6j+y0+Gq9tM1t/UPi1Vit4eEedVt2xLkM27g==
X-Received: by 2002:a05:690c:45ca:b0:81c:e8ab:c4dd with SMTP id 00721157ae682-8225e3f745cmr93483777b3.33.1786204361398;
        Sat, 08 Aug 2026 08:52:41 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f79a6c6dsm27839747b3.48.2026.08.08.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:52:41 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joshua A Hay <joshua.a.hay@intel.com>
Subject: [PATCH net-next v5 3/6] idpf: support pacing offload
Date: Sat,  8 Aug 2026 11:51:41 -0400
Message-ID: <20260808155217.885299-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
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
only advertise EDT when they are met. These features are negotiated
per adapter, but expect all vports to uniformly request splitq
(req_[rt]x_splitq) and flow scheduling (flow_sch_en) when available.

Disable if in netpoll. It does not need the feature, and the ktime
functions are not safe to call in this context.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
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
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 70 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 56 ++++++++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 10 +++
 6 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ec1b75f039bb..c68ccdaa1a3c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -658,6 +658,7 @@ struct idpf_vc_xn_manager;
  * @stats_task: Periodic statistics retrieval task
  * @stats_wq: Workqueue for statistics task
  * @caps: Negotiated capabilities with device
+ * @edt_caps: Negotiated EDT capabilities with device
  * @vcxn_mngr: Virtchnl transaction manager
  * @dev_ops: See idpf_dev_ops
  * @cdev_info: IDC core device info pointer
@@ -720,6 +721,7 @@ struct idpf_adapter {
 	struct delayed_work stats_task;
 	struct workqueue_struct *stats_wq;
 	struct virtchnl2_get_capabilities caps;
+	struct virtchnl2_edt_caps_ilog2 edt_caps;
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
index 99fcd8e298d6..e9068e0a4e5f 100644
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
@@ -3011,6 +3018,63 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
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
+	/* Skip if netpoll: not needed and not safe to call ktime helpers */
+	if (netpoll_tx_running(skb->dev))
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
@@ -3097,6 +3161,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
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
index 8bd6cca64c9b..964eb8aa283f 100644
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
+		return 0;
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
@@ -3547,6 +3592,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		}
 	}
 
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
+		err = idpf_send_get_edt_caps_msg(adapter);
+		if (err) {
+			dev_err(&adapter->pdev->dev, "Failed to get EDT caps: %d\n",
+				err);
+			return -EINVAL;
+		}
+	}
+
 	err = idpf_map_lan_mmio_regs(adapter);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to map BAR0 region(s): %d\n",
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 39fea65c075c..7525146491cd 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -457,6 +457,16 @@ struct virtchnl2_edt_caps {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_edt_caps);
 
+/**
+ * struct virtchnl2_edt_caps_ilog2 - Host parsed EDT caps.
+ * @time_horizon_ns: Total time window in nanoseconds.
+ * @tstamp_granularity_pow2: Log2 of timestamp granularity in nanoseconds.
+ */
+struct virtchnl2_edt_caps_ilog2 {
+	u32 time_horizon_ns;
+	u8 tstamp_granularity_pow2;
+};
+
 /**
  * struct virtchnl2_version_info - Version information.
  * @major: Major version.
-- 
2.55.0.679.g6767b8d81c-goog

