Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709375;
	b=CT/Q80uo5DUH4h/yf/6sansza5yIncgu4JVxgPydlMMbVYttow1SOhoWDnJlKQsRG2b7
	 q4dDfi/N/Ie9Cf6oHKS9H/kxuBO3QWetav3lgVQPIg6gggLFludoZG4E7K498TPdQA/Ck
	 UEV3IZ4bNH5LDRROD4O2fwJEts4KiI38IbsOWPJjezJ6E5fgCzoE8rLiKfiM/fSvOlHYa
	 +gvJfx7DJSnhQGsuvEvcaBpxYam6vtfdUVdmoa0I1OjzAJ8ZTVD+IOwK9Fo3giyTJ7ym1
	 IwOthI0Twx7z9LclU+dJ/v04G/xVDqvafEQPXW5bai5/sBI8u5p7SnIJuEhogYJctOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709375;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=9+Z2h/X2mUsxSM9yEGidpLi6Z8cJ8eJgG0VxSBUnE9g=;
	b=KjakGiYeNUejIGeJSFpuH5qiMHZT9GJ/f5XA46NSdMdvrIWpJuXlEG+M6DCi5GSA3Lw/
	 ONj5Nu5LA2gzD3fzZqTZoT6IZY6pgi483Rn5orW30EckgESqn7mLtBj9CORm92WF06uCr
	 Mphqg4CkAmiPj08vDEDcYjrIHcI9z805XdJjcWaRqiWM/u6kHrAmzAILtKRE4cNmy4tTX
	 8jlJoTryBI/9TRHTICDysaQr9TSMviOK790OvN/w17mTSzXENRGmtGBYh9sQTKZ5JQ9Gu
	 kxNOHA9vtb1oLeQnw7I82er3fvn/KnxxgWNSQ1DD8/jPI9WKlEvS/ZXFuIC9ue4l3MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=Yl68jCLn;
	arc=none smtp.remote-ip=173.37.86.74
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981F606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C981F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=Yl68jCLn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=21580; q=dns/txt;
  s=iport01; t=1793709374; x=1794918974;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9+Z2h/X2mUsxSM9yEGidpLi6Z8cJ8eJgG0VxSBUnE9g=;
  b=Yl68jCLnvSlqWJtIwN/tbxyVk+4RfNaSgh9sRcVEY0YC7TnA1ZR+fCDe
   SYVTNrjafSWJ0kRzeqRoHu+tQwv+EeRdeNcJ4ap9hBC5QWRDDEVWUtnia
   pcmcNpO0OCedYcBr6MkgxLhvLvdYIihGeIaGYyq4dFOjxe3uVbPeGxMpk
   rbOYKtRhqZDaj6zMJV2QufPD7OItw6swC33Wskw9eUxGplDzW16EJsqXP
   sgPIReVmCqVXmePWlPYGrEkUqBvJAHT2ucRsXYxiAsRCT0tTBvl2POnH7
   5GE/uG5Vf83NbCqW3F9ieI6a15aIjH1kGpfIB5HgIFGJB8n7jayTP41vv
   A==;
X-CSE-ConnectionGUID: p3bmg8GaSASV6X3QoEOwBA==
X-CSE-MsgGUID: ciuSSDF+SFuLVu2mdXJbng==
X-IPAS-Result: =?us-ascii?q?A0AaAABm1Olq/4r/Ja1RCRwBAQEBAQEHAQESAQEEBAEBg?=
 =?us-ascii?q?XwHAQELAYJWgVVDSYRXiBuHOIIhgRaQOIxUFIFqDwEBAQ9RBAEBhAQBgQACj?=
 =?us-ascii?q?hwCJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBAQECAQcFgQ4ThlyQEwIBA?=
 =?us-ascii?q?xoJBFIQJQImAgJGEBmDAoJ1A7scen8zgQGEftlLgWgBCxQBgQouAYVxgm0Bg?=
 =?us-ascii?q?XGECIR9JxuBSUSBFYJzdoQXCAuDdYJqBIMcEogahVaJIgk/gQIcA1ksAVUTD?=
 =?us-ascii?q?QoLBwVjgQUDNRIqFTI8Mh2BIz4XL1gbBgWBHYEHBBOBEoEHXYErKF0BIYEIg?=
 =?us-ascii?q?XYCglGCAAIBSUEOB0VTCSVDEkckIggSCQETGiwKgRo1PAkmPxUMZggDGgVAA?=
 =?us-ascii?q?h8IAg0MdDkQMB4kLwUcJkAQGA1IESw3FRkEPQFuB5INghwBcQFYASEJC0I5B?=
 =?us-ascii?q?C4BDggBGjQRCgICEhkLEScCA5Jgg3+MKIE2a4E1n1yEKYFnoBAzl2iTCJkIo?=
 =?us-ascii?q?20GG4U2gWg8gVkzGggbFYMiUxkPji4W0jsmMj0BAQcCBw4DC4FokAIPFweBT?=
 =?us-ascii?q?wEB?=
IronPort-Data: A9a23:6Dc1ua8wKGKkTEHmCjbLDrUDon+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 jMZUT2HMvaDMGP3e9kkOYy/9xsEupXdz9NhGVBoqCxEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmB4E/rbei5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mtyyHjEAX9gWAtazpPs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kuZocd9bZYCFpnz
 sJGGGs0aT2kmMiflefTpulE3qzPLeHxN48Z/3UlxjbDALN+GNbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZOE0n1lQ/UPrSmM+zj2X+aD1bqHqepLE85C7YywkZPL3FbYaJI4fbGJ8N9qqej
 mnH4l/CLj9ZD/KC7QSYqHegts3FmyyuDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDTdTnWRC85nmesXY0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcCQBcJ7sfLvo4+lFTMQ8xlHarzicf6cQwc2
 BiQpyQ4wrFWhskR2uDjpBbMgimnod7CSQtdChjrY19JJzhRPOaND7FEI3CChRqcBO51lmW8g
 UU=
IronPort-HdrOrdr: A9a23:fbOW2KGC9UAHED70pLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: 9a23:dJWOxmwBKHokvFUC+TWyBgUMQcogfS3yxUz5GHHmOT1QT5CyVnW5rfY=
X-Talos-MUID: 9a23:wvW6rQgRynwyIgs8uzGrcsMpP8Z12J+CJgM2v4gihdTeMCBAGT2bg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,193,1787011200"; 
   d="scan'208";a="544139520"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Nov 2026 12:36:13 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id F312F180001C4;
	Tue,  3 Nov 2026 12:36:12 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 03 Nov 2026 04:36:04 -0800
Subject: [PATCH net v5 2/2] enic: require DEVCMD2 and set the V2 VF mailbox
 source
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-2-2501d1223eff@cisco.com>
References: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-0-2501d1223eff@cisco.com>
In-Reply-To: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-0-2501d1223eff@cisco.com>
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709370; l=22125;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZYWlMDCrTab8smlXEvaXbatJfnGjGQAPdzoSNvy66RE=;
 b=3i/hr66Dy9E1pezaRBECdrax/SEPf5cP3nfGg013J1El0/SvLpr/P0SAryFeeWup6WmhH0kE7
 U+EFaEvOXndAJ+nbDSLZlDnYYeG9ZliCbenWTqLr141PEF47vOQlgbM
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-01.cisco.com

V2 VFs currently transmit mailbox source zero. A deployed async PF
checks that field against the sender identity obtained from CQ metadata,
so VFs other than VF zero cannot register with that PF.

Require DEVCMD2 for V2 PF support and V2 VF probe, preserving the
DEVCMD1 fallback for ordinary PF Ethernet, V1 and usNIC. Enable the
admin QP, then query CMD_SRIOV_STATS_GET while its receive interrupt is
still masked. Validate the returned version and zero-based VF index, and
publish that index as the mailbox source. Permit sends before unmasking
the interrupt so queued notifications can be processed and acknowledged
with a valid source. Sends remain disabled until the ID is valid,
without a separate unknown-ID send check or reliance on PF
retransmission. Query failures use the partial-open close path and its
existing ownership checks.

Keep the coherent statistics target for the vNIC lifetime. Extend the
DEVCMD2 transport with an optional per-call observation of NOT_POSTED,
POSTED or COMPLETED. A posted statistics command without a result leaves
its target unresolved. A later blocking QP or close command result
fences that target through command ordering, including a firmware error
result. Observe close completion in both probe unwind and removal so a
completed close does not leave the statistics target unnecessarily
retained. Pre-submission errors, posted timeouts and NOWAIT posting do
not establish completion. This keeps transport completion separate from
command success and admin WQ/RQ queue-stop proof.

On an unresolved probe failure retain the inert control owner and target
through final containment instead of freeing memory which the command
may still write. Refuse reuse of an unresolved statistics target.

Fixes: 1f0c856b5963 ("enic: add MBOX core send and receive for admin channel")
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h        |  5 ++
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 51 ++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_dev.c    | 44 ++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_dev.h    |  3 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 29 +++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 12 +++-
 drivers/net/ethernet/cisco/enic/vnic_dev.c    | 85 ++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/vnic_dev.h    | 15 +++++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h | 34 +++++++++++
 9 files changed, 263 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index ebe617e752c7..d1f9f2156e0b 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -271,6 +271,11 @@ struct enic {
 	u16 num_vfs;
 	enum enic_vf_type vf_type;
 	bool vf_registered;
+	u16 vf_id;
+	/* A CMD_SRIOV_STATS_GET timeout leaves its persistent coherent target
+	 * device-owned until a later serialized command completes.
+	 */
+	bool sriov_stats_dma_unresolved;
 	u32 pf_cap_version;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 8a063c563a41..6fa27a755e3f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -16,6 +16,7 @@
 #include "vnic_devcmd.h"
 #include "enic.h"
 #include "enic_admin.h"
+#include "enic_dev.h"
 #include "cq_desc.h"
 #include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
@@ -401,12 +402,23 @@ static void enic_admin_teardown_intr(struct enic *enic)
 
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
 {
+	enum vnic_devcmd2_status status;
 	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
 	int wait = 1000;
 	int err;
 
 	spin_lock_bh(&enic->devcmd_lock);
-	err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
+	if (vnic_dev_uses_devcmd2(enic->vdev)) {
+		err = vnic_dev_cmd2_status(enic->vdev, CMD_QP_TYPE_SET,
+					   &a0, &a1, wait, &status);
+		/* Ordered completion fences the earlier statistics DMA target,
+		 * including an error result. Admin queues still need RUNNING == 0.
+		 */
+		if (status == VNIC_DEVCMD2_COMPLETED)
+			WRITE_ONCE(enic->sriov_stats_dma_unresolved, false);
+	} else {
+		err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
+	}
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;
@@ -542,6 +554,8 @@ int enic_admin_channel_open(struct enic *enic)
 			   READ_ONCE(enic->admin_chan_state));
 		return -EBUSY;
 	}
+	if (READ_ONCE(enic->sriov_stats_dma_unresolved))
+		return -EBUSY;
 	/* Keep MBOX sends disabled for the entire open sequence.  It is
 	 * cleared only after every resource is allocated and enabled below,
 	 * so any early error return here leaves sends disabled and a
@@ -590,15 +604,40 @@ int enic_admin_channel_open(struct enic *enic)
 		goto disable_queues;
 	}
 
-	vnic_intr_unmask(&enic->admin_intr);
+	if (enic_is_sriov_vf_v2(enic) &&
+	    READ_ONCE(enic->vf_id) == ENIC_MBOX_DST_PF) {
+		struct vnic_sriov_stats *stats;
+		u32 version;
+		u16 vf_id;
+
+		/* Keep received notifications queued until their ACK can use
+		 * the VF source ID. The statistics query needs QP_ENABLE first.
+		 */
+		err = enic_dev_sriov_stats(enic, &stats);
+		if (err) {
+			netdev_err(enic->netdev,
+				   "Failed to get SR-IOV statistics: %d\n", err);
+			goto disable_queues;
+		}
+		version = le32_to_cpu(stats->ver);
+		vf_id = le16_to_cpu(stats->vf_index);
+		if (version != VNIC_SRIOV_STATS_VERSION ||
+		    vf_id == ENIC_MBOX_DST_PF) {
+			netdev_err(enic->netdev,
+				   "Invalid SR-IOV statistics version %u VF index %#x\n",
+				   version, vf_id);
+			err = -EINVAL;
+			goto disable_queues;
+		}
+		WRITE_ONCE(enic->vf_id, vf_id);
+	}
 
 	/* Only now that the admin WQ/RQ/CQ and interrupt are fully allocated,
-	 * programmed and enabled is it safe to allow MBOX sends.  Clearing this
-	 * earlier opened a window where a concurrent sender (e.g. link-notify
-	 * work scheduled by a post-reset link-up) could call enic_mbox_send_msg()
-	 * against a not-yet-allocated admin_wq and crash.
+	 * programmed and enabled is it safe to allow MBOX sends. Publish send
+	 * readiness before unmasking so queued notifications can be acknowledged.
 	 */
 	WRITE_ONCE(enic->mbox_send_disabled, false);
+	vnic_intr_unmask(&enic->admin_intr);
 
 	netdev_dbg(enic->netdev,
 		   "admin channel open: intr=%u wq_avail=%u rq_avail=%u cq0_color=%u cq1_color=%u\n",
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.c b/drivers/net/ethernet/cisco/enic/enic_dev.c
index 659787f73cf1..7d5298e6df02 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.c
@@ -171,6 +171,50 @@ int enic_dev_intr_coal_timer_info(struct enic *enic)
 	return err;
 }
 
+int enic_dev_close(struct enic *enic)
+{
+	enum vnic_devcmd2_status status;
+	u64 a0 = 0, a1 = 0;
+	int err;
+
+	spin_lock_bh(&enic->devcmd_lock);
+	if (vnic_dev_uses_devcmd2(enic->vdev)) {
+		err = vnic_dev_cmd2_status(enic->vdev, CMD_CLOSE,
+					   &a0, &a1, 1000, &status);
+		/* A close result also fences earlier statistics DMA, including
+		 * an error result. Admin queues still need RUNNING == 0.
+		 */
+		if (status == VNIC_DEVCMD2_COMPLETED)
+			WRITE_ONCE(enic->sriov_stats_dma_unresolved, false);
+	} else {
+		err = vnic_dev_close(enic->vdev);
+	}
+	spin_unlock_bh(&enic->devcmd_lock);
+
+	return err;
+}
+
+int enic_dev_sriov_stats(struct enic *enic,
+			 struct vnic_sriov_stats **stats)
+{
+	enum vnic_devcmd2_status status;
+	int err;
+
+	*stats = NULL;
+	spin_lock_bh(&enic->devcmd_lock);
+	if (READ_ONCE(enic->sriov_stats_dma_unresolved)) {
+		err = -EBUSY;
+		goto unlock;
+	}
+	err = vnic_dev_sriov_stats(enic->vdev, stats, &status);
+	if (status == VNIC_DEVCMD2_POSTED)
+		WRITE_ONCE(enic->sriov_stats_dma_unresolved, true);
+unlock:
+	spin_unlock_bh(&enic->devcmd_lock);
+
+	return err;
+}
+
 /* rtnl lock is held */
 int enic_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.h b/drivers/net/ethernet/cisco/enic/enic_dev.h
index 698d0cb02064..eed1674ff30f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.h
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.h
@@ -40,6 +40,9 @@ int enic_dev_set_ig_vlan_rewrite_mode(struct enic *enic);
 int enic_dev_enable(struct enic *enic);
 int enic_dev_disable(struct enic *enic);
 int enic_dev_intr_coal_timer_info(struct enic *enic);
+int enic_dev_close(struct enic *enic);
+int enic_dev_sriov_stats(struct enic *enic,
+			 struct vnic_sriov_stats **stats);
 int enic_dev_status_to_errno(int devcmd_status);
 
 #endif /* _ENIC_DEV_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 4d616c3732da..3c9937f8856d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2203,6 +2203,12 @@ static bool enic_has_admin_chan(struct enic *enic)
 	       (enic_sriov_enabled(enic) && enic->vf_type == ENIC_VF_TYPE_V2);
 }
 
+static bool enic_control_dma_unresolved(struct enic *enic)
+{
+	return enic_admin_channel_is_quarantined(enic) ||
+	       READ_ONCE(enic->sriov_stats_dma_unresolved);
+}
+
 /* Re-establish the admin/MBOX channel after a reset has re-created the data
  * path.  Mirrors the relevant part of the probe / SR-IOV-enable sequence:
  * reinitialise MBOX and reopen the channel, then for a VF re-run the PF
@@ -2888,6 +2894,12 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 
 	if (enic->vf_type != ENIC_VF_TYPE_V2)
 		return;
+	if (!vnic_dev_uses_devcmd2(enic->vdev)) {
+		dev_warn(&pdev->dev,
+			 "SR-IOV V2 requires DEVCMD2; disabling V2 support\n");
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+		return;
+	}
 
 	/* A successful command means firmware recognizes
 	 * VIC_FEATURE_SRIOV; supported_versions is available
@@ -3072,6 +3084,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	enic = netdev_priv(netdev);
 	enic->netdev = netdev;
 	enic->pdev = pdev;
+	WRITE_ONCE(enic->vf_id, ENIC_MBOX_DST_PF);
 	spin_lock_init(&enic->vf_link_state_lock);
 
 	/* Setup PCI resources
@@ -3139,6 +3152,12 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (err)
 		goto err_out_vnic_unregister;
+	if (enic_is_sriov_vf_v2(enic) &&
+	    !vnic_dev_uses_devcmd2(enic->vdev)) {
+		dev_err(dev, "SR-IOV V2 VF requires DEVCMD2\n");
+		err = -EOPNOTSUPP;
+		goto err_out_vnic_unregister;
+	}
 
 #ifdef CONFIG_PCI_IOV
 	enic_sriov_detect_vf_type(enic);
@@ -3267,6 +3286,8 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				"MBOX VF registration failed: %d\n", err);
 			goto err_out_admin_close;
 		}
+		dev_info(dev, "V2 VF registered, VF index %u\n",
+			 READ_ONCE(enic->vf_id));
 	}
 
 	netif_set_real_num_tx_queues(netdev, enic->wq_count);
@@ -3411,7 +3432,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_dev_deinit:
 	enic_dev_deinit(enic);
 err_out_dev_close:
-	vnic_dev_close(enic->vdev);
+	enic_dev_close(enic);
 	if (enic_admin_channel_is_quarantined(enic))
 		enic_admin_channel_final_recheck(enic);
 err_out_disable_sriov:
@@ -3424,7 +3445,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 #endif
 err_out_vnic_unregister:
-	if (enic_admin_channel_is_quarantined(enic)) {
+	if (enic_control_dma_unresolved(enic)) {
 		/* Normal generic cleanup and CMD_CLOSE have already run. Retain
 		 * only the inert admin/control owners and their PCI reservation.
 		 */
@@ -3494,11 +3515,11 @@ static void enic_remove(struct pci_dev *pdev)
 		}
 #endif
 		enic_dev_deinit(enic);
-		vnic_dev_close(enic->vdev);
+		enic_dev_close(enic);
 		if (enic_admin_channel_is_quarantined(enic))
 			enic_admin_channel_final_recheck(enic);
 		kfree(enic->pp);
-		if (enic_admin_channel_is_quarantined(enic)) {
+		if (enic_control_dma_unresolved(enic)) {
 			/* All generic queues and CPU entry points followed ordinary
 			 * teardown. No admin buffer can return from the network stack.
 			 * Pin the PCI object for the reservation's owner-name pointer;
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 5c93ca49552a..a1f8138d0bbd 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -18,10 +18,17 @@
 #define ENIC_MBOX_POLL_TIMEOUT_US	5000000
 #define ENIC_MBOX_POLL_INTERVAL_US	100
 
-static void enic_mbox_fill_hdr(struct enic_mbox_hdr *hdr, u8 msg_type,
+static void enic_mbox_fill_hdr(struct enic *enic, struct enic_mbox_hdr *hdr,
+			       u8 msg_type,
 			       u16 dst_vnic_id, u16 msg_len, u64 msg_num)
 {
+	u16 src_vnic_id = ENIC_MBOX_DST_PF;
+
+	if (enic_is_sriov_vf_v2(enic))
+		src_vnic_id = READ_ONCE(enic->vf_id);
+
 	memset(hdr, 0, sizeof(*hdr));
+	hdr->src_vnic_id = cpu_to_le16(src_vnic_id);
 	hdr->dst_vnic_id = cpu_to_le16(dst_vnic_id);
 	hdr->msg_type = msg_type;
 	hdr->msg_len = cpu_to_le16(msg_len);
@@ -85,7 +92,8 @@ static int enic_mbox_send_msg_id(struct enic *enic, u8 msg_type,
 		reply_expected = true;
 	}
 
-	enic_mbox_fill_hdr(buf, msg_type, dst_vnic_id, total_len, msg_num);
+	enic_mbox_fill_hdr(enic, buf, msg_type, dst_vnic_id, total_len,
+			   msg_num);
 	if (payload_len) {
 		void *dst = buf + sizeof(struct enic_mbox_hdr);
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
index c8d657e97094..92eec1455ceb 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
@@ -287,8 +287,9 @@ static int _vnic_dev_cmd(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
 	return -ETIMEDOUT;
 }
 
-static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
-			  int wait)
+static int _vnic_dev_cmd2_status(struct vnic_dev *vdev,
+				 enum vnic_devcmd_cmd cmd, int wait,
+				 enum vnic_devcmd2_status *status)
 {
 	struct devcmd2_controller *dc2c = vdev->devcmd2;
 	struct devcmd2_result *result;
@@ -298,6 +299,9 @@ static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
 	u32 fetch_index, new_posted;
 	u32 posted = dc2c->posted;
 
+	if (status)
+		*status = VNIC_DEVCMD2_NOT_POSTED;
+
 	fetch_index = ioread32(&dc2c->wq_ctrl->fetch_index);
 
 	if (fetch_index == 0xFFFFFFFF)
@@ -326,6 +330,8 @@ static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
 	wmb();
 	iowrite32(new_posted, &dc2c->wq_ctrl->posted_index);
 	dc2c->posted = new_posted;
+	if (status)
+		*status = VNIC_DEVCMD2_POSTED;
 
 	if (dc2c->cmd_ring[posted].flags & DEVCMD2_FNORESULT)
 		return 0;
@@ -340,7 +346,10 @@ static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
 	}
 
 	for (delay = 0; delay < wait; delay++) {
-		if (result->color == color) {
+		if (READ_ONCE(result->color) == color) {
+			dma_rmb();
+			if (status)
+				*status = VNIC_DEVCMD2_COMPLETED;
 			if (result->error) {
 				err = result->error;
 				if (err != ERR_ECMDUNKNOWN ||
@@ -363,6 +372,31 @@ static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
 	return -ETIMEDOUT;
 }
 
+static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
+			  int wait)
+{
+	return _vnic_dev_cmd2_status(vdev, cmd, wait, NULL);
+}
+
+int vnic_dev_cmd2_status(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
+			 u64 *a0, u64 *a1, int wait,
+			 enum vnic_devcmd2_status *status)
+{
+	int err;
+
+	*status = VNIC_DEVCMD2_NOT_POSTED;
+	if (!vdev->devcmd2 || vdev->proxy != PROXY_NONE)
+		return -EOPNOTSUPP;
+
+	memset(vdev->args, 0, sizeof(vdev->args));
+	vdev->args[0] = *a0;
+	vdev->args[1] = *a1;
+	err = _vnic_dev_cmd2_status(vdev, cmd, wait, status);
+	*a0 = vdev->args[0];
+	*a1 = vdev->args[1];
+	return err;
+}
+
 static int vnic_dev_init_devcmd1(struct vnic_dev *vdev)
 {
 	vdev->devcmd = vnic_dev_get_res(vdev, RES_TYPE_DEVCMD, 0);
@@ -1046,6 +1080,11 @@ void vnic_dev_unregister(struct vnic_dev *vdev)
 			dma_free_coherent(&vdev->pdev->dev,
 					  sizeof(struct vnic_stats),
 					  vdev->stats, vdev->stats_pa);
+		if (vdev->sriov_stats)
+			dma_free_coherent(&vdev->pdev->dev,
+					  sizeof(struct vnic_sriov_stats),
+					  vdev->sriov_stats,
+					  vdev->sriov_stats_pa);
 		if (vdev->fw_info)
 			dma_free_coherent(&vdev->pdev->dev,
 					  sizeof(struct vnic_devcmd_fw_info),
@@ -1088,6 +1127,11 @@ struct pci_dev *vnic_dev_get_pdev(struct vnic_dev *vdev)
 }
 EXPORT_SYMBOL(vnic_dev_get_pdev);
 
+bool vnic_dev_uses_devcmd2(struct vnic_dev *vdev)
+{
+	return vdev->devcmd2;
+}
+
 int vnic_devcmd_init(struct vnic_dev *vdev)
 {
 	void __iomem *res;
@@ -1295,3 +1339,38 @@ int vnic_dev_capable_rss_hash_type(struct vnic_dev *vdev, u8 *rss_hash_type)
 
 	return 0;
 }
+
+int vnic_dev_sriov_stats(struct vnic_dev *vdev,
+			 struct vnic_sriov_stats **stats,
+			 enum vnic_devcmd2_status *status)
+{
+	u64 a0, a1;
+	int err;
+
+	*stats = NULL;
+	*status = VNIC_DEVCMD2_NOT_POSTED;
+	if (!vdev->sriov_stats) {
+		vdev->sriov_stats =
+			dma_alloc_coherent(&vdev->pdev->dev,
+					   sizeof(*vdev->sriov_stats),
+					   &vdev->sriov_stats_pa,
+					   GFP_ATOMIC);
+		if (!vdev->sriov_stats)
+			return -ENOMEM;
+	}
+
+	memset(vdev->sriov_stats, 0, sizeof(*vdev->sriov_stats));
+	a0 = vdev->sriov_stats_pa;
+	a1 = sizeof(*vdev->sriov_stats);
+	err = vnic_dev_cmd2_status(vdev, CMD_SRIOV_STATS_GET, &a0, &a1,
+				   1000, status);
+	if (!err) {
+		/* Order CPU reads from the coherent target after command
+		 * completion.
+		 */
+		dma_rmb();
+		*stats = vdev->sriov_stats;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.h b/drivers/net/ethernet/cisco/enic/vnic_dev.h
index 7fdd8c661c99..6a4d7ce3b636 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.h
@@ -93,6 +93,8 @@ struct vnic_dev {
 	dma_addr_t linkstatus_pa;
 	struct vnic_stats *stats;
 	dma_addr_t stats_pa;
+	struct vnic_sriov_stats *sriov_stats;
+	dma_addr_t sriov_stats_pa;
 	struct vnic_devcmd_fw_info *fw_info;
 	dma_addr_t fw_info_pa;
 	enum vnic_proxy_type proxy;
@@ -106,6 +108,12 @@ struct vnic_dev {
 
 struct vnic_stats;
 
+enum vnic_devcmd2_status {
+	VNIC_DEVCMD2_NOT_POSTED,
+	VNIC_DEVCMD2_POSTED,
+	VNIC_DEVCMD2_COMPLETED,
+};
+
 void *vnic_dev_priv(struct vnic_dev *vdev);
 unsigned int vnic_dev_get_res_count(struct vnic_dev *vdev,
 	enum vnic_res_type type);
@@ -118,6 +126,9 @@ void vnic_dev_free_desc_ring(struct vnic_dev *vdev,
 	struct vnic_dev_ring *ring);
 int vnic_dev_cmd(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
 	u64 *a0, u64 *a1, int wait);
+int vnic_dev_cmd2_status(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
+			 u64 *a0, u64 *a1, int wait,
+			 enum vnic_devcmd2_status *status);
 void vnic_dev_cmd_proxy_by_index_start(struct vnic_dev *vdev, u16 index);
 void vnic_dev_cmd_proxy_end(struct vnic_dev *vdev);
 int vnic_dev_fw_info(struct vnic_dev *vdev,
@@ -163,6 +174,7 @@ struct vnic_dev *vnic_dev_register(struct vnic_dev *vdev,
 	void *priv, struct pci_dev *pdev, struct vnic_dev_bar *bar,
 	unsigned int num_bars);
 struct pci_dev *vnic_dev_get_pdev(struct vnic_dev *vdev);
+bool vnic_dev_uses_devcmd2(struct vnic_dev *vdev);
 int vnic_dev_init_prov2(struct vnic_dev *vdev, u8 *buf, u32 len);
 int vnic_dev_enable2(struct vnic_dev *vdev, int active);
 int vnic_dev_enable2_done(struct vnic_dev *vdev, int *status);
@@ -177,5 +189,8 @@ int vnic_dev_overlay_offload_cfg(struct vnic_dev *vdev, u8 overlay,
 int vnic_dev_get_supported_feature_ver(struct vnic_dev *vdev, u8 feature,
 				       u64 *supported_versions, u64 *a1);
 int vnic_dev_capable_rss_hash_type(struct vnic_dev *vdev, u8 *rss_hash_type);
+int vnic_dev_sriov_stats(struct vnic_dev *vdev,
+			 struct vnic_sriov_stats **stats,
+			 enum vnic_devcmd2_status *status);
 
 #endif /* _VNIC_DEV_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 90ca06691ebd..9f397df88c50 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -461,6 +461,14 @@ enum vnic_devcmd_cmd {
 	 * in: (u32) a1 = enable (1) / disable (0)
 	 */
 	CMD_QP_TYPE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 97),
+
+	/*
+	 * Get SR-IOV capabilities, resource usage, and this function's logical
+	 * VF index.
+	 * in: (u64) a0 = DMA address of struct vnic_sriov_stats
+	 * in: (u32) a1 = length of the buffer
+	 */
+	CMD_SRIOV_STATS_GET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 98),
 };
 
 #define QP_TYPE_ADMIN	0
@@ -468,6 +476,32 @@ enum vnic_devcmd_cmd {
 #define QP_ENABLE	1
 #define QP_DISABLE	0
 
+#define VNIC_SRIOV_STATS_VERSION	1
+
+struct vnic_sriov_stats {
+	__le32 ver;
+	u8 sriov_vlan_membership_cap;
+	u8 sriov_vlan_membership_enabled;
+	u8 sriov_rss_vf_full_cap;
+	u8 sriov_host_rx_stats;
+	__le32 ig_classifier0_tcam_cfg;
+	__le32 ig_classifier0_tcam_free;
+	__le32 eg_classifier0_tcam_cfg;
+	__le32 eg_classifier0_tcam_free;
+	__le32 ig_classifier1_tcam_cfg;
+	__le32 ig_classifier1_tcam_free;
+	__le32 eg_classifier1_tcam_cfg;
+	__le32 eg_classifier1_tcam_free;
+	__le32 sriov_ig_flow_table_cfg;
+	__le32 sriov_ig_flow_table_free;
+	__le32 sriov_eg_flow_table_cfg;
+	__le32 sriov_eg_flow_table_free;
+	u8 admin_qp_ready[32];
+	__le16 vf_index;
+	__le16 reserved1;
+	__le32 reserved2[256 - 23];
+};
+
 /* CMD_ENABLE2 flags */
 #define CMD_ENABLE2_STANDBY 0x0
 #define CMD_ENABLE2_ACTIVE  0x1

-- 
2.43.0

