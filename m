Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B71494804
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058968; cv=none; b=e9FMSX8fedlIDjlxWZovwINyURWoPf5/5iqcTIsTT0xKFdL1V5od75uXPpeBryQC7k8oq4PTzwGX0deUlDAR+L1KSZkGB42DGKd0qgcnDr873Nm4S858PSvF5wWjZPtyMDHPL3QgjztRmq4ExCFeTIiEQjmDDEK0q2Bg6Lkbe5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058968; c=relaxed/simple;
	bh=3bdn9jmOH2t7uERidw5u29M6ehrSIUzIwslb9bSBwXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeUAbo0vG/uSVqN3J/Sz/Cl+Csl8pbjcKiF8JcMsS015lix8e0EV6gBNBDbZ0RPGAmgAEr5W973TU8TeXiG7rdu0bENnVLog9AP10zO21xbjSXx8rFr6ShgpKVfc4rInrYcui4vTrMIwPP5lb2CQBwtIoiqi2BmL0zKyuDO0P7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmgLIZtN; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmgLIZtN"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664e3ed58bcso2349191d50.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058966; x=1786663766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uk1DBhl2SjEAtDClBoBuZQ0iwRCMwuffCjBsfq5FWJI=;
        b=EmgLIZtNgNBrC0MY2uoas03f1zwahtyRoAhxVC7TLQDNjFTkqKqlrf1ipGtM8jWq3U
         ovJEiyBeTkt2xBgGqH3ZiGsV24lsPDMPwi3t/lqMcRYgTq04yMaoDs7Mz93Hy2J4Ethb
         VqzGXj5U9CcrLesl71fG2e8k5YfaCiv43ckVKLJ6LyVGO2A4zKrRqRR07U7wo52596ew
         rvUdWsLRGOE2fhFeY5ijfp3rs80qBOzfwcKuqhllXBNrXCg1Ef78js97pqnxKRoBZwiR
         sY+KlVrfiDF2hVfHWirIPWid4YiXULvInUpmRe1jaysx3rAwKF/Bki4P6HfmlmQl5aNv
         sIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058966; x=1786663766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uk1DBhl2SjEAtDClBoBuZQ0iwRCMwuffCjBsfq5FWJI=;
        b=L2qwewdZPWY2ryHtQ79pT1hR0/deSR2L7PAq/IErpOXagFZzPHfRHad+ghkgXInRJP
         aimGp62Mhg+4AmXKk/ylqeU3JVFEox+74lzJF7ScE5gBfXyDhCpnd5eJ7PpVbbTOtEf9
         uhbt7MqkZdgXjd2QP2nPNtL79VmgekpVtUD4xEmnWuxRHuRwm+EOXIc/vY6v8chICZde
         X4MUAwUqvXs9/D6kXfjU2AuYeo8FzqHkpGuUUe9X6xv//HZQJnVqVISLO0+125NvBsTr
         iYAzCcmFEqD/NAaK0sJnCTcjcx26bZCDxsM91/RPEx8KjXJ8Ge+cRUJQ67/E/5sCVnnV
         5iDw==
X-Gm-Message-State: AOJu0Yyw6d0wZz+UbzPrvkEd8228y7eZfq5UBscsDXzMaeWQaBJvy3Ff
	HZ9VfexzP1ZjM5Azydh0vKJXn5nPjfxJd6gdNrIXhBWaLhsYkpoNiUkhPsMXvA==
X-Gm-Gg: AR+sD13BcdamYO54B556w7ZqEbUJEis2tlnmFiUyth5Rzfva1P0hLbQK8OdvCOLvCuR
	3cwdRu7UgEFR4ernn4E5gP/PQ10hJP4n2CLka97eCzamVM5YPsGFQ+YEOmB//42GwILDjgI1gdy
	tzrkUTQgcZG/EPt/8clkbUunNjV9FnXJNbjIGMEN9kwz1xcnBZeoGOjFPr9njUUrP4bd4lJTIu6
	1/m7xe8zdO62QcRPziPG5gio7npYFwiqdbRn6arAmBpsq5MQOOuEXTKCTo9jV7f1xh7izhMDIjC
	657p6BjM6pyG6A9dM8dcmb4Crj2nEwTvoHaQgPZyJ+EnANQLp1Y9Q6FDwTaGn+yMKETIcZNrm62
	Z3XEGy4nc2pyluNQODcHOTeqF0hYASNpJ8Ds0CovvXca5tpct0Lil5zinnrtyl/dFXOWyCV94yV
	cUCO+GBylDUJI0NH8ISMrlTg2eLQ/Ek3lQzJiNk2VaeKOktC8Zl1lAVXeUW5SVz4xqz+x/IFB8Q
	uQiFwan2P0OWJnRoHENPhEYb1g5n6uEekpr3gWcSIMyXclqsJtioqBqh6Q=
X-Received: by 2002:a05:690e:148e:b0:664:c5f8:e342 with SMTP id 956f58d0204a3-66abad2350fmr4751115d50.3.1786058965577;
        Thu, 06 Aug 2026 16:29:25 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:29:24 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 3/6] idpf: support pacing offload
Date: Thu,  6 Aug 2026 19:26:00 -0400
Message-ID: <20260806232913.4020403-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
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
 drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 70 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 56 ++++++++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 10 +++
 6 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ec1b75f039bb..03bca27b2724 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -720,6 +720,7 @@ struct idpf_adapter {
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

