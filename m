Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F540F722;
	Tue, 11 Aug 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438502; cv=none; b=g0OnT3sMv30nkaUS/38ZaOdEhLYqCt4OKVdcgreimfOMSVs1XvdHFa6VBDfwDf83xfDQcsyMydt6IqzOKTuOO6ghmTnEmOdMzCegZ0k/Q4rqviNh/XF1SwbLpY4ihefXPgC3700oHKjtXq3KDv7HT0O3345rU4NtNgc3yx2o+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438502; c=relaxed/simple;
	bh=Pn0TKFjtcEJOjnNkYVbL8e229J9NzJZe+8IbS+IrGuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=re9ju/xmjAv60bbxsAEeTyDfqRf76WBaRUpbLtvu0CZtAlVlXAHpiHlEtaPiWUcn+q2mN+GrdzQzXhlDtFlhO6EevnJiVIXRJRmUGWsDwGP9qySdvATVnq/LHVFtMrjSqBO5R2b2EwpjgKZTSsqLut/Vo29xcX9ny1Tc9SIeUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ep9y1oNA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ep9y1oNA"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ANSVLw2812470;
	Tue, 11 Aug 2026 01:54:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	RBHdXRtu+K2+MnaGRlbCeJHVWdo202Bb5P/DWwdRVA=; b=Ep9y1oNAEmeOP1aih
	EjgAlJWE7ZL5Bw6FpBQ2e8zCQsL5Z0oy2wHrHhvWKKxLpK2NrY/21LeIBfi7Be9S
	nyjQUYFTEqA9IPXgYQVPK7bmxgw6JLTn/VJYJ9Nj82+srZoGd8eeYnhOTnySLx1t
	FJ4lFXYTRq5PH1fKP5oH+gfC3DC5iU5SSTXm1wzVxB/c0g3DLKr2ulzvjs+f47zY
	cccsCD+P440eCi3j9Tz28uy3Ef2atjnHwAmt8DDcuPkcR57ku2NNbkGkiYnKJQrU
	5Vvec8wAACqqT02xq8cvjHRQrle/o2mo5RlIvRxAZxXuFwtj9/uBcBOGPR0Q9q+i
	yrhQQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fyrbg175j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 01:54:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 01:54:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 01:54:36 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A4A7F3F706B;
	Tue, 11 Aug 2026 01:54:33 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v8 net-next 3/9] octeontx2-pf: switch: Add pf files hierarchy
Date: Tue, 11 Aug 2026 14:24:00 +0530
Message-ID: <20260811085406.3227312-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811085406.3227312-1-rkannoth@marvell.com>
References: <20260811085406.3227312-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FuY1OWrq c=1 sm=1 tr=0 ts=6a7ae34e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=nuQGcmqZOM9rrSzZNSUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: JtHKBtiKHfUXAfVdGaQq-hTJW5wvVyLO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfX+EFWVhhrasqU
 qwebDJCBMoIhkN+7Y+HzDUIcsL7xExXlWiOcWQAMn/qN0oyi8r4Y2t4qgS3VlhBpK5mzGgxIpCk
 Eq6rkebkxVK7oIunQnlhsUMFLBhDr7A=
X-Proofpoint-GUID: JtHKBtiKHfUXAfVdGaQq-hTJW5wvVyLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfX0RphBFAX7ZBV
 p7mD6dvqAzXEB0x7oU2Gumh5NoLGKdMDFjuEbOHus0t5CnoqUcxEerqboSHiC2Tnb2teHUAFAMP
 61qmW4mI6ue1cpNvlyydU+DihcFfV2LTqGTjJQhHn+t+AxrUolQHhRU1OqExVA8Cb//hVEAg9iA
 9Io2pPfGeN4YEe8jKmp6WjeTkw1AJXdneGWRY7gxPZV7eFQxSDHVJ4OJT0jDB/Vn6i41pN3MhlA
 Nz6qdgwA5kklsNvQfp2vGe/oGLZPFcBL1o+ZPj2tJFxtT43iLsPurm8rx54tik7hA161Hmi27qc
 tlS9oba+Ngw22jFji8StbjxomFd0NKcEzfcVT+XqXoo47Z9tLL2ybqE7LEPOgi5UXoHcQK++Xy1
 Dr2+BbWUtCxVtflQumgfo4MpQfNVWuu3CZh25sY3QGOugPOoyQ/Jg81GCyWoW8xHTp/sReiMfBa
 YVcrTA+e73n6dYee2ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01

Adds CONFIG_OCTEONTX_SWITCH, links stub switch objects into the PF
module, and introduces empty sw_* init/deinit and notifier hooks for
later patches.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/Kconfig    | 10 +++++++++
 .../ethernet/marvell/octeontx2/nic/Makefile   |  5 ++++-
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 19 +++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 16 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 18 ++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      | 20 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 21 +++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      | 20 ++++++++++++++++++
 10 files changed, 168 insertions(+), 1 deletion(-)
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
index 883e9f4d601c..27590b94133b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -9,7 +9,10 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
-               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
+               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o switch/sw_fdb.o \
+	       switch/sw_fl.o
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o
+
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
new file mode 100644
index 000000000000..500451e85b50
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fdb.h"
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fdb_init(void)
+{
+	return 0;
+}
+
+void sw_fdb_deinit(void)
+{
+}
+
+#endif
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
index 000000000000..f2811d69f815
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fl.h"
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fl_init(void)
+{
+	return 0;
+}
+
+void sw_fl_deinit(void)
+{
+}
+#endif
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

