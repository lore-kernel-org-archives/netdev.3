Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0783379982
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097755; cv=none; b=EopurZMZDYe+2Tl280stepmVtLQonpjxusmJH2n2vN7U0GZDGnSNqJ01IHgYYBhFWtsW/I1tDVovDrirKGbO9AuFpiHnh602lw9MboVCJKrzqoALQ0/wXe6zQ0OI/ffmZR+v6c7terbrBtTBXXjrv5C6iuTj+QgJmy0avJ+imiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097755; c=relaxed/simple;
	bh=83NI0y9RPFCIVGWaHYRx42AI3Zq0opwakrwX7UddjCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujJJRMqIhdmWe1DGY1WSa0PeZbJFlnnI87n/Qe8Wt+1YJQlKNPysuYn1BbN72GA1P6nqDeQPWRmHFRutA0QadagTzhH7CsbFnLIKM+fh5ElZcVMXGxOigjxZnjI9Vz3nzmR+JsMsHaLx2fMzaR+iqAoWfvtn52jjuy23yU9B1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tI7IpIfI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI7IpIfI"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f52945098so31656157b3.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097753; x=1785702553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3E0WKON44+XYc7hAeNaPmiZcV1t8dHjLp5r5GD6IbA=;
        b=tI7IpIfIBNl3tkAX8aNTiB5b+YNvx9UsMvM1zEYx61/mSgoZqtm/hV9ULhwo2tRGG7
         rmwsTfgVZm3QwjLAJIkus2sZrpQYvZvtyT/nGRloImE8deqNLKO9CwuIDPYxK0zqz1e+
         3x0UnXWLGpDmiNC1yYvFxVVirFMt5AWqTSm0JSjn+nEgs2WBbalB61BrTTyGlk4NIXO6
         Rttknl5Pe4sU1TqfX+fKEJtKrn/l0Rn+2YoO2JcK35cxBAq+EVPxu/YojENuGz2ssRy0
         NckqoXkvRom/VrVNA3kW7JfQzeqVk+jTW7iQK2wbZHN6s7GRr+S2PjlgJJHLgFHWPZ0E
         1CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097753; x=1785702553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3E0WKON44+XYc7hAeNaPmiZcV1t8dHjLp5r5GD6IbA=;
        b=mhs/BcL1VJQqWGGuBQk2IYmpTCvoY00tXp7YLHJztRrKLg875qayM6Yv5AXWVSMDq3
         Apwg8iBSt0m1ZGNVderfqe02w3xRGyg40flnnUyeLMijcFLiFSuRh9rrN+txVxXbl8fF
         8F3PmMw+SuOqIYqs7A8Fw58W75Y76ncvvf0TVrx9C8D67EC926z6RM+ybE01hbosT+87
         Pq+l901VxWRVLC+FNeAb5jVMmI/oAtXiVCxjwSbKCNiTK0ObMbsSvJOn3cIVRCO3ds2/
         u48gpDe98Yeg0wbM5y0saVtzoKijr8F3Y2VU/Kpa7tZbC1egyL5tmgoHPW07ejlLAt2n
         mfaA==
X-Gm-Message-State: AOJu0YzkhqLgeUr3jnskZGPQQMuIrt2ucr+9r+mfYyHl6mBrUWHKex2L
	BdO+7ZvaS//GzLzEnyWrmKHHkNZEg6T78R0GJOghwiizIHSp4oSHcDD8tIpfIB7V
X-Gm-Gg: AR+sD109pilAbteKDH08Go5do72+QjKa/XCtuPTpTOxvGbs3bFDhJhXcu7yIdq/4RWn
	TUGvvytnBtgbDqV4SejGXWlhv/Cj7CKdEsp+KxkQOwD7CIvtwQA+C2c3LHZc0ikLVcJ6KOZkKcZ
	RG2UTeuOx7OLUupFjM+Bj+bfnGwWSqzOfbhdyjlGAddIWGvCcpydzwUuLQp7dSZbpSXGwg712bV
	VfUn+sS46j83zdaIK9gNcs6841QvYSuY6I0Q66EZR08yX1bIHy6UFSe1YMHX94eu2diaY3lYV8w
	83abaQNSqjUpqIzvqdY8R2pJRmdM3ptqHIBYwAcyPJb0hheRF1Seje7wvkjMZ71tkVrcilr5rwF
	NLfqlOHfAmgKnYY4k5poKPPg0RZMB0Tc7mFxcCfcKFtafgXeSLaLs66xal0HyyXVHc8hXTKPBiT
	F9AccZQhuQGLH0FAmMIiNhRALeCU5QlZJcQPI6+5VNNqa+7BMbmZFq3YxIVnuQHoYh5KrYLy2W
X-Received: by 2002:a05:690c:1c:b0:7cf:d535:9970 with SMTP id 00721157ae682-81f63b8f57emr21411897b3.20.1785097752556;
        Sun, 26 Jul 2026 13:29:12 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:12 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	mohsin.bashr@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Joshua A Hay <joshua.a.hay@intel.com>
Subject: [PATCH net-next v3 3/7] idpf: support pacing offload
Date: Sun, 26 Jul 2026 16:28:47 -0400
Message-ID: <20260726202902.760552-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
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
the FQ offload_horizon is configured.

But device support for pacing offload must be more robust. It can also
be reached through SO_TXTIME.

Bound check txtime. Only packets with timestamp between now and the
horizon (max_pacing_offload_horizon) are offloaded.

Support only in splitq mode, where tx and tx completion queues are
separate and so completions can be returned out of order.

Assume that the NIC clock is PTP synchronized to CLOCK_TAI. This
can later be refined, e.g., to a custom CLOCK_AUX.

Disable if in netpoll. It does not need the feature, and the ktime
functions are not safe to call in this context.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v2 -> v3
    - use READ_ONCE and read pacing_offload_horizon only once
  v2: https://lore.kernel.org/netdev/20260722204454.3234605-4-willemdebruijn.kernel@gmail.com/
  v1 -> v2
    - move special zero case up and return early
  v1: https://lore.kernel.org/netdev/20260706133433.3142805-4-willemdebruijn.kernel@gmail.com/

Sashiko, ignore pre-existing issues.

Sashiko, ignore that idpf_tx_splitq_set_txtime may have a benign race
by calling ktime_mono_to_any twice to get TAI to REALTIME offset.

fixup idpf
---
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  5 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 69 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index bb99d9e7c65d..5ddf347927dc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1801,7 +1801,8 @@ static void idpf_get_ts_stats(struct net_device *netdev,
 static const struct ethtool_ops idpf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
-	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+				  ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON,
 	.get_msglevel		= idpf_get_msglevel,
 	.set_msglevel		= idpf_set_msglevel,
 	.get_link		= ethtool_op_get_link,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..de4170c2aa3b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -888,6 +888,11 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	if (idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
+	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
+			    VIRTCHNL2_CAP_SPLITQ_QSCHED))
+		netdev->max_pacing_offload_horizon = 128000;
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 566b08ca3a6c..8f11de57c8bc 100644
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
@@ -2408,9 +2410,13 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
+
+	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
+	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
+	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
 }
 
 /**
@@ -3011,6 +3017,63 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct idpf_tx_queue *tx_q,
+				      const struct sk_buff *skb,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int ts_gran_pow2 = 9;
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
+	if (ts > now + (horizon * NSEC_PER_USEC)) {
+		tx_params->offload.desc_ts[2] = 1 << 7;
+		return;
+	}
+
+	ts >>= ts_gran_pow2;
+
+	/* 0 is valid 24b timestamp, but also means field unset.
+	 * Add 512 ns (ts_gran_pow2) to avoid this case
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
+			idpf_tx_splitq_set_txtime(tx_q, skb, &tx_params);
+
 		/* Set the RE bit to periodically "clean" the descriptor ring.
 		 * MIN_GAP is set to MIN_RING size to ensure it will be set at
 		 * least once each time around the ring.
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..865408b57b0d 100644
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
-- 
2.55.0.229.g6434b31f56-goog

