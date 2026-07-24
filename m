Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F241DED2;
	Fri, 24 Jul 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886050; cv=none; b=u26SleYY/vBR2PdAJMaAyyeVAtERRb+FxY3Tk9rAbFkd1o//thcX8xnDGSmKHLohREjaFlBreCGQU4Mqmb58HjTBFgRQkjgBHd4yb+Fmz1bsdIAqkrJyCq/FlyBZqcZXrGmizgkFMnaTVTbe0INQkXXgxIPN9td5qz+18FmL/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886050; c=relaxed/simple;
	bh=6HBhBht0CBzFhMJZGB34z0sSu94QGf007DwKV9PX+bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEqGSb7d39LfwdMwro8AQ9+eDLqvKd+J1xJeDhdhEdoq10rPFZQ0EIfQNSEyMxeINidVHxt/O03R9z0ajx/BatB6VW6fEq4+GPUJqrCDNBkiayQMdZzwGZGfbJgd1t9FOLr4dx4GD2JcUikGGQ0GVsf08z1PwHnUCc/puAQsKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G1qZKoG1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G1qZKoG1"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lTvZ3162839;
	Fri, 24 Jul 2026 02:40:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
	NZHulVud6Szr5EhdNiN1sZB/9p6j6Ej+WnH1We/CjM=; b=G1qZKoG1+g4dxxPLh
	0dXfXCKS4a57IbqLGFXDYbwRXMNVn+wh16WFzFcdYBhgg6TMgcrXK+R6X7S3rYv+
	azW31YOKMqrlyyw86W8y12g6m+nvkXiDpwsCU5PQD8eautBuG8kNA9CHbzoXe6ms
	a2vM0HVT1SZsPGmpChgvBjDrvpuHUx8jXTxjZx8mOMpXEe3OOTYD3Kbm9i7LKhNS
	ensLEFF7KwGQgk6Ltf2r9J6UpHXqUTmxxqB63/dLz2JeWNemBt52qwL6OgfCVb2G
	t+S+WUrLi8b/QF8avUnkoi3AgOkh29RhlqDQHCC9vKXu1Pscsnae7gh2ovN9uVYa
	HrppQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fkvmu15ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:40:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Jul 2026 02:40:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Jul 2026 02:40:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5F14D3F7076;
	Fri, 24 Jul 2026 02:40:37 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v5 net-next 3/9] octeontx2-pf: switch: Add pf files hierarchy
Date: Fri, 24 Jul 2026 15:10:12 +0530
Message-ID: <20260724094018.3213907-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724094018.3213907-1-rkannoth@marvell.com>
References: <20260724094018.3213907-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: plvvHcMAYTpkBR7JH-kBDuMsOW1ykQNy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX6PJL0H1JMZEG
 wRIlEsfYZwGQ9zcwbaFdYsvOc11Gcdma/KZLPL+LOOdBHlmdCI8kNNU3oayRsiW7GVqgF7wNVPJ
 M11RniZeXAerN8mWtFbavdJYBcJWVt8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX5ei+v33x4PZu
 T3/TI9kyJs/ShwiGKp97VYmfZRsCNlMq0LF3QE4M4q2+8yy/pTB/m8k/BouVzEsSzy0RLVjXaB1
 4IfS+rGW+Mj3ux63s+wgfNSVLO9Ppnu0C4UUYkaZeoL4cwu8gsx8C/n588OEJmKc4p5B5stlTUs
 oyjobpea1on2qUg5PtM1K/2ggQ02nZmsyehYyGA26zv8p3WZa6IgNGiy6W2rNLiLFYP1hZGL9OO
 FAJSr8DYpJN+Iua+y1XorsvrWoRyXkLpl4KeOtFds5KkNlraCHf60sSXPojdPLuaAAx72UVKM+I
 ZEjpYSM0iPh0mddkyIxi/ACYsHP3VdsDLAoTFPFDtkTN5nmPwVhBsWpqUZdVfiyVEqksTRj8i6Z
 o2LvBLSbVk1lQ2gLn4cyiW/KFg1pDarQt1+R2oo225CYeQKtavUxmvBIkE0cyFeJoGP7xhLymZa
 4y1yW7A2osQUfQMv5bw==
X-Proofpoint-ORIG-GUID: plvvHcMAYTpkBR7JH-kBDuMsOW1ykQNy
X-Authority-Analysis: v=2.4 cv=GLg41ONK c=1 sm=1 tr=0 ts=6a633318 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=Tbk3QSKcrk8eJG6noeMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01

Adds CONFIG_OCTEONTX_SWITCH, links stub switch objects into the PF
module, and introduces empty sw_* init/deinit and notifier hooks for
later patches.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/Kconfig    | 10 +++++++++
 .../ethernet/marvell/octeontx2/nic/Makefile   |  3 +++
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 16 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 16 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 16 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 21 +++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      | 20 ++++++++++++++++++
 10 files changed, 162 insertions(+)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
index 47e549c581f0..e2fb6dd71078 100644
--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
@@ -28,6 +28,16 @@ config NDC_DIS_DYNAMIC_CACHING
 	  , NPA stack pages etc in NDC. Also locks down NIX SQ/CQ/RQ/RSS and
 	  NPA Aura/Pool contexts.
 
+config OCTEONTX_SWITCH
+	bool "Marvell OcteonTX2 switch driver"
+	depends on (64BIT && COMPILE_TEST) || ARM64
+	depends on OCTEONTX2_PF
+	default n
+	help
+	  This driver supports Marvell's OcteonTX2 switch.
+	  Marvell SWITCH HW can offload L2, L3 flow. ARM core interacts
+	  with Marvell SW HW thru mbox.
+
 config OCTEONTX2_PF
 	tristate "Marvell OcteonTX2 NIC Physical Function driver"
 	select OCTEONTX2_MBOX
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 883e9f4d601c..f072930f7de6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_fdb.o switch/sw_fl.o \
+				       switch/sw_nb.o switch/sw_fib.o
+
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
new file mode 100644
index 000000000000..6842c8d91ffc
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fdb.h"
+
+int sw_fdb_init(void)
+{
+	return 0;
+}
+
+void sw_fdb_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
new file mode 100644
index 000000000000..dc427e8ab7c6
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FDB_H_
+#define SW_FDB_H_
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+void sw_fdb_deinit(void);
+int sw_fdb_init(void);
+#else
+static inline void sw_fdb_deinit(void) {}
+static inline int sw_fdb_init(void) { return 0; }
+#endif
+
+#endif /* SW_FDB_H_ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
new file mode 100644
index 000000000000..12ddf8119372
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fib.h"
+
+int sw_fib_init(void)
+{
+	return 0;
+}
+
+void sw_fib_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
new file mode 100644
index 000000000000..9b72e95f2dd3
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FIB_H_
+#define SW_FIB_H_
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+void sw_fib_deinit(void);
+int sw_fib_init(void);
+#else
+static inline void sw_fib_deinit(void) {}
+static inline int sw_fib_init(void) { return 0; }
+#endif
+
+#endif /* SW_FIB_H_ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
new file mode 100644
index 000000000000..36a2359a0a48
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fl.h"
+
+int sw_fl_init(void)
+{
+	return 0;
+}
+
+void sw_fl_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
new file mode 100644
index 000000000000..7648df59e215
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FL_H_
+#define SW_FL_H_
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+void sw_fl_deinit(void);
+int sw_fl_init(void);
+#else
+static inline void sw_fl_deinit(void) {}
+static inline int sw_fl_init(void) { return 0; }
+#endif
+
+#endif /* SW_FL_H_ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
new file mode 100644
index 000000000000..243611835e3a
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_nb.h"
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+int sw_nb_unregister(void)
+{
+	return 0;
+}
+
+int sw_nb_register(void)
+{
+	return 0;
+}
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
new file mode 100644
index 000000000000..73cc1e99b8ec
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_NB_H_
+#define SW_NB_H_
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_nb_register(void);
+int sw_nb_unregister(void);
+#else
+static inline int sw_nb_register(void) { return 0; }
+static inline int sw_nb_unregister(void) { return 0; }
+#endif
+
+#endif /* SW_NB_H_ */
-- 
2.43.0

