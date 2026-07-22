Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1A43C054
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753107; cv=none; b=meXSdKK49PTOEgLd2PoiDniCm+riRqulBKhrfpJZE3nB9X6LNunWUNXL0+7Mxcd9ylBaYyJzpPGtgMRWhlBSWZu6SxqOS8BCkDK78vKA0V13sPMC6sRAWMnVUAhvhp63aq3SG507Kp8rrRLgYVbFa6jXuSuzLvpHl7Fs1LVqe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753107; c=relaxed/simple;
	bh=0ckXo2GuDUqUsvz+wGWoTuYkxw6HW4MHwQs2lbrrwyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyIBZXV2eHAehXlTqCGdkpinNfTg/oGkA5nF4l4G/DT3XFNHWnSf++QsxwnxesDRLZ38lOlhB0eYE34QEhkWnbbTgCuvcOYEWBwWsg39k1o58kW0/PfCsRzRqzdHHTDqJOK5aV4/B6HCWtXAQVhSPSnIGZVO9ZbcJSaCFUSD09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxnbcPbf; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxnbcPbf"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81eaf3709b4so109538497b3.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753105; x=1785357905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGkDEu6T7GmWPqo1WDqQr5U8lZAudgCZAQVUJZdhVNo=;
        b=pxnbcPbfhCKVGwqcQ3Sp9W8C2WD+EGbE2iMR7JCspTah/mwaO4L+bZojoqL/6c0bgU
         fGQ/qzmRaVuuUGlRfr1Ef6f/kzkwZphZ/YwwSrlzSZqGCSFzABI/ucFuSMhHp+oic/0/
         EJKnuPcON58BWPKmV1phV+ZdMK7K9YeDV4vT/IrnXMmgx5UUXVbWLTr5+vWaNWQBrZj0
         K+t0Cw9H2TZP1o0gkYMq0VIGKgh0fbNz8RdUfXPaICPNh75xPPRoNpBn8p350WK9s0Gp
         P4UjL9nmt4yasBbn2IOQO2AaiA0xEs/x//fEcK93WuIwWQFvtTz4qi49fWueNsyOtWZx
         4Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753105; x=1785357905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KGkDEu6T7GmWPqo1WDqQr5U8lZAudgCZAQVUJZdhVNo=;
        b=nNFp7HpOSbFSlfOjTDEi8d2mFqpW7wtNnTLk8y81d5TSZ/iknrj8VDahduz9PMeuTF
         3mOUTqF/ULIjwflydFx7+b/3RfDqmsfuLY6TRiy9ZGh5Z3U3vg9opfO+effjaGq9RoMD
         yFKS/VtaD/bCmefEJoF5eOlGpkhouFVizH0mrHcdMUudHAEYAecMQ6tYVDRSJFs87NIN
         Bv5J0QmAikKGobdgPhjcHAEbpJCrFHTxvd/qvPtPM8qh/YBhW0EWfPwnfYEgTt6eunQr
         TNU7dw+SqjMxlacFPx/3J2NnMzol+FYvGtTmqOJYFPTnBfaftQkj7QzBRyt1q/+vhvGO
         AFfg==
X-Gm-Message-State: AOJu0Yyn+7cCvwnUacNoKnrFDk8AMo7coF49tJ7z9sTZBE9hK91uzXhx
	ZOa3hYxG4vAuA24H05f8XrqaCfgfuZijCz+9+DqZ+r1L1sa3LYvfksc09MmJeT9q
X-Gm-Gg: AR+sD13b+N9FERRNz6fJ7Efsbs9GHlLi4iBym4oAX9nHFfiPdz96vVFDIY38sffdXZZ
	hTYcnK4bsNZgSnyL+wA6RtWaszK2ehCzKeSvqi12xpm5o/vlYssCe9mK/XwBdtXsuyDgdukkdXH
	noyYr3enlToHXFCLQSHGSxOxuvdX+Kw/ukRyhiH+NaODrTd38LypprC3kAFvLMG0qGR5ZvIgoW0
	K+QeNbdRQRuqotQr7y7IZDJbSO+rNdDxQ8LOGvzJvduzzEgkcqOQrTPUpA1HvUY6cIz2pXI9OXy
	Gy+p+4oAkPcDKn9rzzPViDWHum56M2q11IozJWes0n4rnqn6pMJ+5Qx3T7BY8hvudLcoNNJL669
	u+p8cb2+4JWA+4+BDQKu3baEnzYyFcJisGKf7SK6EHq4rRhnebcLnVkCJnfGMB+Pgipkryw7QbB
	NAavypUjDu2aA+Q8EVhUtIYSAic59fQAfaJEuJe6NO4+h7ymfDTZdu8qtKlze7pW1oC/I4ZjMg2
	NW95sP++bmkUZr9
X-Received: by 2002:a05:690c:480c:b0:81e:79f0:48b8 with SMTP id 00721157ae682-81f4c140332mr676957b3.7.1784753104498;
        Wed, 22 Jul 2026 13:45:04 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm19506797b3.6.2026.07.22.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:45:04 -0700 (PDT)
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
	Joshua A Hay <joshua.a.hay@intel.com>
Subject: [PATCH net-next v2 3/7] idpf: support pacing offload
Date: Wed, 22 Jul 2026 16:43:49 -0400
Message-ID: <20260722204454.3234605-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
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
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 65 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
 4 files changed, 73 insertions(+), 2 deletions(-)

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
index 566b08ca3a6c..1ccfaeb35193 100644
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
@@ -3011,6 +3017,59 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct idpf_tx_queue *tx_q,
+				      const struct sk_buff *skb,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int ts_gran_pow2 = 9;
+	u64 ts, now;
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
+	if (ts > now + ((u64)skb->dev->pacing_offload_horizon * NSEC_PER_USEC)) {
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
@@ -3097,6 +3156,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+		if (skb->tstamp && skb->dev->pacing_offload_horizon)
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

