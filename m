Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F34137A2;
	Mon, 31 Aug 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182411; cv=none; b=iyjYKzpRB4UI3OdcVwWyLpX5ZTcJIWiyhb0dngjeVgrgP4Ld6zYmN5eP8R8xsMaCt2/LwdeLz92mVhCJppR5hImfjpozS0ot/hhRMXYjOILAvQ8XBIBqQDfxh0sCwMF5fP6krXCrn8xy0Q1Tqkz3iZwE2Yx7d3b4CH6gC0BsdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182411; c=relaxed/simple;
	bh=Dh3dAWEzll3rD3GGX48H2FJ/tKX2uElCHSSFbvFrTyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jkdee0VsYspIyeZ/HrPRZO14X417J/VyYJOG+TpifZiXWEvLQJ06tSP+i4cTOd4tH9R9gT+cuFeSxFPWX1Pn3R+yIA1j6Y3/8lsRnXDDap9ict0dclHG+DcXLgvQvWvpaYgJr0bq7Y7SRbMxp7twX2VaU0a8GAHeAdqNg+IJovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BaaY+wHN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BaaY+wHN"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBBjUu536832;
	Mon, 31 Aug 2026 06:19:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	FBHxHBtV940PYcboD9ayOq2X7pShJ/n7jkc04FZo4E=; b=BaaY+wHNg/mzhvr62
	aIgebXlqu0b6T9e1QATMgXgzZlzClCvvQrKazmcuKtdbDyX70oaHih8s6L7B/f4Y
	xSIm7t6zj+4GZ1p/0ltceAJQNV/nyJWYZuBnH23i94v74gTcOkLuigrD6RhYll59
	B+IA7bzZ5NJ40RWc5OnaTWkTThdAy2wWz2XO52lh946+NHRqBw/M6et/SfarTISk
	SBWukg6KjlMGhPsZwIGtg6sZJbAEpTvTd07WMI/7sVrxGH0iZQBFAm4jey0p9obC
	Y9OYJsvEoBrlgNQRrc/jzibTOsb4LSPRVpwYhl7JOeJTed6WFzrNf9UdB9LHHj7J
	5TJeg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8jfbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:19:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:19:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:19:58 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 71E5A3F7089;
	Mon, 31 Aug 2026 06:19:55 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v9 net-next 1/8] octeontx2-af: switch: Add AF to switch mbox and skeleton files
Date: Mon, 31 Aug 2026 18:49:37 +0530
Message-ID: <20260831131944.2649362-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831131944.2649362-1-rkannoth@marvell.com>
References: <20260831131944.2649362-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX1aztEmVK2tPg
 ySRZph8LG6SgcaQoWnfncEVFWtKhZa88GbriKnsbwBsADUq0MHf7rP+OKRC9IGf5r6tbzZzXjVY
 BgUzillWgv31xESXrWT9Q3Gv60teyDYozSpb/ryaW6useGX/jsz0u30/jxobH55PzXP6G0lm07n
 ydH1Y44mc8SZf0+hv86Geo+ZCirHzKoJ0p1tDbtwiynRQcmOb2uIBecU6jpk8rKfFbDFYuII3++
 kTFlRI443C/NIXGnuairIsBzqcuGgyf5Nd65vp3lmet0razth199QSg1W4XmIMKyseo8EKxP74Y
 sCYYfNFOwe2w6H0Nr/YzKH8JvMLqGAMd1Qwm8poAkx3Kx2xHQkRjnYebR40W1001kH41cjRXqz0
 hVBnf2CS7q2SZPR20qQRgXXfBM/6W5/lUpqcCvbGd54GA4eEswsJj/rBDd/bN0jg9pYZaM+7BMC
 b0HVeoMEcHNr9prgnsA==
X-Proofpoint-GUID: zN2SJdwlwTLnzX7k0GdKGLFmTL1dKLvT
X-Proofpoint-ORIG-GUID: zN2SJdwlwTLnzX7k0GdKGLFmTL1dKLvT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX7LkErkutMjKQ
 GMQSARrGQ08A32kOcYWICQNRkdpEIHjZFUHjDKS5c3rwW+aFefzYNmmNuN7+gB6/gGJz6aQFm/j
 ST0JJ5VEM6zCEB/+fuoUR+8+AOtn+EE=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a957f7f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=ANdAxFAa8r43KH1w-rAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

The Marvell switch hardware runs on a Linux OS. This OS receives
various messages, which are parsed to create flow rules that can be
installed on HW. The switch is capable of accelerating both L2 and
L3 flows.

This commit adds mailbox messages used by the Linux OS (on arm64) to
send events to the switch hardware, along with skeleton handler
functions:

  fdb messages:    Linux bridge FDB messages
  fib messages:    Linux routing table messages
  fl messages:     Flow acceleration tuple and actions (FL_NOTIFY)
  fl stats:        Host-initiated flow counter polling (FL_GET_STATS)

fl_tuple defines the flow acceleration match tuple exchanged over the
mailbox. It currently carries IPv4 five-tuple and L2 match fields only.
IPv6 flow acceleration is not supported in this patch and will be added
in a follow-up change extending the mailbox ABI.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 118 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   |  21 ++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |  11 ++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   |  14 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |  11 ++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   |  14 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |  11 ++
 8 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 91b7d6e96a61..82dd387308c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -3,7 +3,7 @@
 # Makefile for Marvell's RVU Admin Function driver
 #
 
-ccflags-y += -I$(src)
+ccflags-y += -I$(src) -I$(src)/switch/
 obj-$(CONFIG_OCTEONTX2_MBOX) += rvu_mbox.o
 obj-$(CONFIG_OCTEONTX2_AF) += rvu_af.o
 
@@ -12,5 +12,6 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
+		  switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o\
 		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
 		  cn20k/npa.o cn20k/npc.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..854696d2a35f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -164,6 +164,14 @@ M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
 M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
 M(REP_EVENT_NOTIFY,     0x00f, rep_event_notify, rep_event, msg_rsp) \
+M(FDB_NOTIFY,		0x010,  fdb_notify,				\
+				fdb_notify_req, msg_rsp)		\
+M(FIB_NOTIFY,		0x011,  fib_notify,				\
+				fib_notify_req, msg_rsp)		\
+M(FL_NOTIFY,		0x012,  fl_notify,				\
+				fl_notify_req, msg_rsp)		\
+M(FL_GET_STATS,		0x013,  fl_get_stats,				\
+				fl_get_stats_req, fl_get_stats_rsp)	\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -1812,6 +1820,116 @@ struct rep_event {
 	struct rep_evt_data evt_data;
 };
 
+#define OTX2_FDB_ADD	BIT_ULL(0)
+#define OTX2_FDB_DEL	BIT_ULL(1)
+#define OTX2_FIB_CMD	BIT_ULL(2)
+#define OTX2_FL_ADD	BIT_ULL(3)
+#define OTX2_FL_DEL	BIT_ULL(4)
+#define OTX2_DP_ADD	BIT_ULL(5)
+
+struct fdb_notify_req {
+	struct  mbox_msghdr hdr;
+	u64 flags;
+	u8  mac[ETH_ALEN];
+	u8  rsvd[2]; /* explicit tail padding */
+};
+
+/* Zero-initialize before populating fields shared with switch OS. */
+struct fib_entry {
+	u64 cmd;
+	u64 gw_valid : 1;
+	u64 mac_valid : 1;
+	u64 vlan_valid: 1;
+	u64 host    : 1;
+	u64 bridge  : 1;
+	u64 ipv6  : 1;
+	u64 rsvd : 58;
+	__be16 vlan_tag;
+	u16 rsvd1;
+	u32 dst_len;
+	u8 dst6_plen;
+	u8 gw6_plen;
+	u8 rsvd2[2]; /* explicit padding before address unions */
+	union {
+		__be32 dst;
+		__be32 dst6[4];
+	};
+	union {
+		__be32 gw;
+		__be32 gw6[4];
+	};
+	u16 port_id;
+	u8 nud_state;
+	u8 rsvd3;
+	u8 mac[ETH_ALEN];
+	u16 rsvd4; /* explicit tail padding */
+};
+
+struct fib_notify_req {
+	struct  mbox_msghdr hdr;
+	u16 cnt;
+	u16 rsvd[3]; /* explicit padding for entry[] 8-byte alignment */
+	struct fib_entry entry[16];
+};
+
+struct fl_tuple {
+	__be32 ip4src;
+	__be32 m_ip4src;
+	__be32 ip4dst;
+	__be32 m_ip4dst;
+	__be16 sport;
+	__be16 m_sport;
+	__be16 dport;
+	__be16 m_dport;
+	__be16 eth_type;
+	__be16 m_eth_type;
+	u8 proto;
+	u8 rsvd_l3[3]; /* explicit padding before MAC addresses */
+	u8 smac[6];
+	u8 m_smac[6];
+	u8 dmac[6];
+	u8 m_dmac[6];
+	u64 is_xdev_br : 1;
+	u64 is_indev_br : 1;
+	u64 uni_di : 1;
+	u64 rsvd_br : 61;
+	u16 in_pf;
+	u16 xmit_pf;
+	u16 rsvd;
+	u16 rsvd_align; /* explicit padding before u64 features */
+	u64 features;
+	struct {				/* FLOW_ACTION_MANGLE */
+		u8		offset;
+		u8		type;
+		u16		rsvd;
+		u32		mask;
+		u32		val;
+#define MANGLE_ARR_SZ 9
+	} mangle[MANGLE_ARR_SZ]; /* 2 for ETH, 1 for VLAN, 4 for IPv6, 2 for L4. */
+#define MANGLE_LAYER_CNT 4
+	u16 mangle_map[MANGLE_LAYER_CNT]; /* 1 for ETH,  1 for VLAN, 1 for L3, 1 for L4 */
+	u8 mangle_cnt;
+	u8 rsvd_tail[3]; /* explicit tail padding */
+};
+
+struct fl_notify_req {
+	struct  mbox_msghdr hdr;
+	u64 cookie;
+	u64 flags;
+	u64 features;
+	struct fl_tuple tuple;
+};
+
+struct fl_get_stats_req {
+	struct  mbox_msghdr hdr;
+	u64 cookie;
+};
+
+struct fl_get_stats_rsp {
+	struct  mbox_msghdr hdr;
+	u64 pkts_diff;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
new file mode 100644
index 000000000000..1f8b82a84a5d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
+				  struct fl_get_stats_req *req,
+				  struct fl_get_stats_rsp *rsp)
+{
+	return 0;
+}
+
+int rvu_mbox_handler_fl_notify(struct rvu *rvu,
+			       struct fl_notify_req *req,
+			       struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
new file mode 100644
index 000000000000..cf3e5b884f77
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_FL_H
+#define RVU_SW_FL_H
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
new file mode 100644
index 000000000000..5f805bfa81ed
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
+				struct fdb_notify_req *req,
+				struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
new file mode 100644
index 000000000000..ff28612150c9
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_L2_H
+#define RVU_SW_L2_H
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
new file mode 100644
index 000000000000..2b798d5f0644
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fib_notify(struct rvu *rvu,
+				struct fib_notify_req *req,
+				struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
new file mode 100644
index 000000000000..ac8c4f9ba5ac
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_L3_H
+#define RVU_SW_L3_H
+
+#endif
-- 
2.43.0

