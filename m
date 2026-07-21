Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F63B9950;
	Tue, 21 Jul 2026 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621930; cv=none; b=pcjujBOhgpv+oGEN2xrUIddJZ3ks/zuPMZukaFNHFFVqwrYXYGdp3SAivAaTfi/lYDodpA1SD7ikOb7qtX8RSY6ub9IXXgMQvaaJQuUgNPmBN/wnYdIJovXZGKo5k25+KSO8nNp4FeZPvt/blgdru186rrRqs5IgyB6GySjVvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621930; c=relaxed/simple;
	bh=BfSvIy70qS3jR3ozQoDsogLt02uuULZuWC4wCWobQmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVaO0lH+Fw+N4zpykTkiCFqsYsukUlwHxJAtOYR8z7Z4mCss1y+DX7gX0j+pjEYhQOUi0L8k6/HEBIa65eKLJvp38QEXCzLlG8mtBWyKUmjhNjb3I31AkOsau7vMgwmIe4yw0cMuNWzF4mPRphdGakQNIPw3sLjJx2gV/nMezYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jJKXH2Vo; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jJKXH2Vo"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcWLb3069960;
	Tue, 21 Jul 2026 01:18:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	87BJR41hP/wj7LyXw7z0tcdCQ0jjVOug+9qFxCrCLA=; b=jJKXH2VoPLw9DAPTy
	Y1UNSx2wKqW2VQOP0y4lm39B04Rhhg7HEUVP+5G4UXXKnohvCJHzUOYQajJ5uBpl
	iqW9Qw3UYWQ7rtqLmlDKHdDl2kE2zygVBUGJNkrIjw7XysZGHeSfgk1AbAQIVaqQ
	g2Iwl9AldR8wqojmzLDcYgxzVgeW83q/33ipleo44uz0uvoqMf/MrRnLiApgwN54
	D5yLZVsMFS6APJUJHjnbSZw2t924wH+FU6UChv5fuBx62mx0WftNMX7bKxXABQ4I
	DF0iuHT2U6mnR9aiFKuJAawlCLIsnXhOLQAA3EduDZY3njgzffKjeBkEs3SfE2y8
	CdyUg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fhwdkh6ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:39 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8292E3F7091;
	Tue, 21 Jul 2026 01:18:36 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 3/9] octeontx2-pf: switch: Add pf files hierarchy
Date: Tue, 21 Jul 2026 13:48:18 +0530
Message-ID: <20260721081824.1430607-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721081824.1430607-1-rkannoth@marvell.com>
References: <20260721081824.1430607-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Skbs_FlJUVQi_6mFOBwyOTwUzgbAaTpw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfXy4NPJiWY3jCf
 ZDIbBQcbnlzf5t8EwsU0GmF39w/g4MJhsNpBnae2Nqn32N+7L9NlDoENspvlQYcFr8fqjpzHS+J
 TyqCm6CGvR9eCyCXlKcq3bLpD+wmAcw=
X-Authority-Analysis: v=2.4 cv=TrXWQjXh c=1 sm=1 tr=0 ts=6a5f2b5f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Tbk3QSKcrk8eJG6noeMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Skbs_FlJUVQi_6mFOBwyOTwUzgbAaTpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX+kC1GydiN5X0
 78a1ico+uUHUwo2Amwv4RWKSnPh1MDyOYh9jDSQ+YdybwN855ek2ZP2mt2k0vDflR4R5gO1Fnid
 5G1rdKP265amwEf4tAk6yEM8dHhNZRjKvHtxtZKVkAeNN1VZcwcCaeG19vQz1SY1RwQuvlvUACn
 SYEPgb2gT5u7i0QCeG+lGnno0WIvJnqOpIQPHU0gVkqolSQJCOEwu6ZDmqXst5UsmfYie3rKknR
 h/ARW9XRC1+uYXC1ZTBXNPQoCg0YHynwhMnLZ6mqvT9jmDOp/zceXREIOrpuAwIFCyrXVZRzNch
 8ngbOMvq4M7nKh75ozNGC0dZhbl422O5yEZ3cEG0g+qS1Kf8nkRstK05Zi+WTMLgPnRwKEJBhH8
 WL2kidmb4IX5ppbc8vzebakXEdEUM6APDrJVmonxb5eALlZt9XLvMqIt7xH2NHHYFEJTScZJ8/C
 4c3F+uOkh+8hahn7ZeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

Adds CONFIG_OCTEONTX_SWITCH, links stub switch objects into the PF
module, and introduces empty sw_* init/deinit and notifier hooks for
later patches.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/Kconfig    | 10 +++++++++
 .../ethernet/marvell/octeontx2/nic/Makefile   |  5 ++++-
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 16 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     | 13 ++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 16 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      | 13 ++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 21 +++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      | 20 ++++++++++++++++++
 10 files changed, 153 insertions(+), 1 deletion(-)
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
index 883e9f4d601c..123b0af23abd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -9,7 +9,10 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
-               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
+               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o \
+	       switch/sw_fdb.o switch/sw_fl.o
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o
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
index 000000000000..d4314d6d3ee4
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FDB_H_
+#define SW_FDB_H_
+
+void sw_fdb_deinit(void);
+int sw_fdb_init(void);
+
+#endif // SW_FDB_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
new file mode 100644
index 000000000000..41a9c5fb58fa
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fib.h"
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+int sw_fib_init(void)
+{
+	return 0;
+}
+
+void sw_fib_deinit(void)
+{
+}
+
+#endif
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
index 000000000000..cd018d770a8a
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FL_H_
+#define SW_FL_H_
+
+void sw_fl_deinit(void);
+int sw_fl_init(void);
+
+#endif // SW_FL_H
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

