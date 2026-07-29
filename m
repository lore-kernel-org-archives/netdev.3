Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175F39A066;
	Wed, 29 Jul 2026 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302102; cv=none; b=o981SJ431x3HoAtka18DPuggNEK6vb10mkWwsq1CWTIuGdI6BLFKiZxJ0PVGlkf/lbib8AUiJICPaLTOLM4QxZ7vybGeM5Tzcbl5qwO4sn/p0RDnB7tyVs1EfOEbttr8ULyG/H781aE6mZXEypIamVpOXbkVshZjdzcueyXvc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302102; c=relaxed/simple;
	bh=Pn0TKFjtcEJOjnNkYVbL8e229J9NzJZe+8IbS+IrGuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bav5XTwIHWBSMVPECve10h79ptE3Ee9hNckkWW3Yg/cWBQ+Rkkas3adv+LXZuSbfOJNIQ6beqS4EzCtu+2zRadKCqTuaD2415XbUmlEj3km0L3yWEj26p2YBV2BL0JqUxK3DldP2bBauAB5tI9TSZTQKSffqcToQIlQhW34equ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QsvbFtAV; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QsvbFtAV"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4eCb11521160;
	Tue, 28 Jul 2026 21:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	RBHdXRtu+K2+MnaGRlbCeJHVWdo202Bb5P/DWwdRVA=; b=QsvbFtAV9CXsjKOOE
	59t50sSaU6X2AM8bYhUPqWsGkhPK9J7EM+WiZ9KCMWAX05nDlTaGcV64XdIP+wkE
	RzA7KPOmSlK/NMF5PfvIhT9iz6T95TskSedFMbr3NqLZZzGAN7JbJayt7CRxvPQn
	NhwY9hzcJM/1AVfrl3HeQjIOqJbr6CCQJYHuw1vhELoDvCFvvpn5+VR7nTv/UQiS
	Mih28s4yXnQvtCCS5agLMDlFZuKtqKprisssIMTFSRDtvbvdyKfKlJQmyj374QOM
	1NoR0zHUP2dp2bT8X28bvID+DbXJgv9w/r2PbIkZJL2bzhsHsyd8S3Fn5LCvNqMd
	K544w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fq06ksxys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 21:51:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Jul 2026 21:51:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Jul 2026 21:51:22 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D7FC63F70A7;
	Tue, 28 Jul 2026 21:51:18 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v6 net-next 3/9] octeontx2-pf: switch: Add pf files hierarchy
Date: Wed, 29 Jul 2026 10:20:53 +0530
Message-ID: <20260729045100.2177958-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729045100.2177958-1-rkannoth@marvell.com>
References: <20260729045100.2177958-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAzNiBTYWx0ZWRfXx08ekwnoDO/u
 4agpobp+bSb6LGo7M/ZQvslqNwITFEo4H1cTkr85+8b+MganZsTJhMVJsiOcklDXmQ1H0K69DEI
 93dcKvgtmkbhDWxY6NDowGG+pZV/XPht/Ued7hILBB4y//4jYlVIj+SKEj8y3UDMqklUEkKoZXz
 WoADVCiP/EbNbPl0ZoYbSHEKCGV3cb5zHW4An00bdeFp7sKsPPXVqEqPUGSC4648I6S1jpefUta
 zD/vzwAoh5LJrXyMiFwhqwBMsUOR0tGeVMYYvvi2mRVP3XM0UIk0mRQfSFSM2lM78CUQlyquZkD
 RqbmIpf2Euit4Fck52K7yveUYpK95qOSZUuUfi3kP7zoJG4E0GatXIZSr+pUanGOw3aKRJdBH/A
 xIoRXqJIYjz77biqlQMZ5VSMY87lSS5fseHy5Bn98as/rrSBlrPCm2l6Tba3TrN4RuoDIXbP4f/
 N3YFm30adqHQSzZ4Emw==
X-Proofpoint-ORIG-GUID: 5V2uxDO9_mgKEYgFOjLzogfcONsUFpdv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAzNiBTYWx0ZWRfXxgIXVgTyDbQc
 di7Tv3pDEgvOQXQ6NJEK/YJ5ULBp+Dikxz8Hqo/l9bvl8uJIQ4TWYyX6JaXzqDVzyNC7MK4bwUm
 drQc0CwktML6pl0cJNIZhtO8uD84Gv4=
X-Authority-Analysis: v=2.4 cv=U8Siy+ru c=1 sm=1 tr=0 ts=6a6986cb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=nuQGcmqZOM9rrSzZNSUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5V2uxDO9_mgKEYgFOjLzogfcONsUFpdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01

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

