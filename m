Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606083;
	b=nl9rxzbT0dB99hiFZ4wgell6L2FY8IMBTq3drsYADzLbnJTNIce29o06iyTEvdMeokcy
	 JiJN4Hh60bv9eR0U6/ScgZFb5SsWMEc5H5FNX5Z59ILuvFa+KwEnYgfmXNcMFf0M5kYFu
	 kLoQ0giB7aBF4+fDvBAz5YWuk+FZS8DdH26a2y4dfa3dfu5w0fONpSZ4poCZOCc7283uy
	 uF1d7/EZzFe4N+j/AfTxb8m6b5nwGmDWkg1N5/zdBQBXpa1E7D6NKRTbtrhHr6jDYV6vD
	 rVsTkpgyc5F/kV5XiNBcbF/rt5Y032AeG7pKvV8xO1jUfyweasFpxq8mMkim8ulMhMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606083;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=loTYYDFpf/M60VzrS2qI1kBuQB2Lx+dVCUsixUWqMCY=;
	b=sWCOPjzjLeMIBuZ0grkSQ85KlLPSdaH1iUlFFvPxKXmT6gj9kIMiw5Mp40GpFMjHeXqn
	 K1taXYDzHJnbX5xdRMO/1DehWzJm1Hu7ZZU1hZXnbjWoyxiiVXLb9KkwOB1VZCBIfTxxV
	 uyLI1R4lO7IdatO1OJl0s07lFFYHQURDKEG3QjDtNHFmnB9p326wi9TW0XPr/bd/m3ch8
	 OaoefR55OyMPsPfAmHjZkzEBHwZ8BnLs7cwXDG9lwBak09QcOm8O0ooNM0xjLaBlU2C9m
	 7ivczvmlRye7pe6pjbKN7Dpu8up5+JB0FB/T6vw3vy0Xap6B3XXBVZJoIxq08YiWWIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.170
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C225606A333;
	Mon,  2 Nov 2026 07:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C225606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0284641-0.00368443-0.967852;FP=11986311137920161282|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jumCpYS_1793606071;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jumCpYS_1793606071 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 15:54:32 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v33 net-next 5/8] net/nebula-matrix: dispatch: add control-level routing core infrastructure
Date: Mon,  2 Nov 2026 15:54:06 +0800
Message-ID: <20261102075424.2165-6-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
References: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Allocate the dispatch management state and ops table and wire the
init_module and deinit_module wrappers to the resource ops.  Add a
ctrl_lvl bitmap to track control privileges; only the MGT level is
defined, and it is enabled only on the control PF.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 117 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  23 ++++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  54 ++++++++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   8 ++
 6 files changed, 205 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index be314b90..b7eebd89 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -10,4 +10,5 @@ nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_hw/nbl_resource.o \
 		nbl_hw/nbl_interrupt.o \
 		nbl_hw/nbl_chip.o \
+		nbl_core/nbl_dispatch.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index dd24ebec..4d8cea8d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -17,12 +17,14 @@ enum {
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	struct nbl_resource_ops_tbl *resource_ops_tbl;
+	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
 struct nbl_core {
 	struct nbl_hw_mgt *hw_mgt;
 	struct nbl_resource_mgt *res_mgt;
+	struct nbl_dispatch_mgt *disp_mgt;
 	struct nbl_channel_mgt *chan_mgt;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
new file mode 100644
index 00000000..966fee2d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "nbl_dispatch.h"
+
+static void nbl_disp_deinit_module(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	if (res_ops->deinit_module)
+		res_ops->deinit_module(p);
+}
+
+static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	if (res_ops->init_module)
+		return res_ops->init_module(p);
+	return -EOPNOTSUPP;
+}
+
+static void nbl_disp_set_ctrl_bit(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
+{
+	set_bit(lvl, disp_mgt->ctrl_lvl);
+}
+
+static void nbl_disp_refresh_ctrl_ops(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
+
+	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
+		disp_ops->init_module = nbl_disp_init_module;
+		disp_ops->deinit_module = nbl_disp_deinit_module;
+	}
+}
+
+static struct nbl_dispatch_mgt *
+nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
+{
+	struct nbl_dispatch_mgt *disp_mgt;
+	struct device *dev = common->dev;
+
+	disp_mgt = devm_kzalloc(dev, sizeof(*disp_mgt), GFP_KERNEL);
+	if (!disp_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	disp_mgt->common = common;
+	return disp_mgt;
+}
+
+static struct nbl_dispatch_ops_tbl *
+nbl_disp_setup_ops(struct device *dev, struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops_tbl = devm_kzalloc(dev, sizeof(*disp_ops_tbl), GFP_KERNEL);
+	if (!disp_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+
+	disp_ops = devm_kzalloc(dev, sizeof(*disp_ops), GFP_KERNEL);
+	if (!disp_ops)
+		return ERR_PTR(-ENOMEM);
+
+	disp_ops_tbl->ops = disp_ops;
+	disp_ops_tbl->priv = disp_mgt;
+
+	return disp_ops_tbl;
+}
+
+int nbl_disp_init(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_resource_ops_tbl *res_ops_tbl =
+		adapter->intf.resource_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		adapter->intf.channel_ops_tbl;
+	struct device *dev = &adapter->pdev->dev;
+	struct nbl_dispatch_mgt *disp_mgt;
+	int ret;
+
+	disp_mgt = nbl_disp_setup_disp_mgt(common);
+	if (IS_ERR(disp_mgt)) {
+		ret = PTR_ERR(disp_mgt);
+		return ret;
+	}
+
+	disp_ops_tbl = nbl_disp_setup_ops(dev, disp_mgt);
+	if (IS_ERR(disp_ops_tbl)) {
+		ret = PTR_ERR(disp_ops_tbl);
+		return ret;
+	}
+
+	disp_mgt->res_ops_tbl = res_ops_tbl;
+	disp_mgt->chan_ops_tbl = chan_ops_tbl;
+	disp_mgt->disp_ops_tbl = disp_ops_tbl;
+	adapter->core.disp_mgt = disp_mgt;
+	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
+
+	if (common->has_ctrl)
+		nbl_disp_set_ctrl_bit(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
+
+	nbl_disp_refresh_ctrl_ops(disp_mgt);
+	return 0;
+}
+
+void nbl_disp_remove(struct nbl_adapter *adapter)
+{
+	/* Dispatch structures are allocated via devm */
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
new file mode 100644
index 00000000..a7e58023
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DISPATCH_H_
+#define _NBL_DISPATCH_H_
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_resource.h"
+#include "../nbl_include/nbl_def_dispatch.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+struct nbl_dispatch_mgt {
+	struct nbl_common_info *common;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 00000000..b5a69516
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_DISPATCH_H_
+#define _NBL_DEF_DISPATCH_H_
+
+#include <linux/types.h>
+
+struct nbl_dispatch_mgt;
+struct nbl_adapter;
+enum {
+	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_MAX,
+};
+
+/**
+ * struct nbl_dispatch_ops - dispatch control plane operation callbacks
+ * @init_module: chip-wide datapath init, forwarded to the resource layer
+ *               (res_ops->init_module() and then hw_ops->init_module());
+ *               on leonis it programs the chip-wide datapath registers and
+ *               sets driver_status=true.  Returns -EOPNOTSUPP if the
+ *               resource layer installs no init_module op.  Control-PF
+ *               exclusive: the pointer is NULL on a function without
+ *               has_ctrl, so the caller must check has_ctrl first.
+ * @deinit_module: chip-wide teardown, forwarded the same way; on leonis
+ *               it clears driver_status, which starts an asynchronous
+ *               firmware per-PF cleanup pass with no completion status
+ *               bit, waited for best-effort only.  The caller must have
+ *               stopped the mailbox channel and drained all in-flight
+ *               mailbox DMA before calling it, see nbl_dev_remove().
+ *               Returns void.  Control-PF exclusive, same NULL rule as
+ *               @init_module.
+ *
+ * These callbacks are not dispatch-layer setup/teardown: the dispatch
+ * structures are devm-allocated in nbl_disp_init(), and nbl_disp_remove()
+ * only documents why no explicit teardown is needed. They forward
+ * chip/firmware control down to the layers below instead: a control-PF
+ * function calls the resource ops directly.
+ */
+struct nbl_dispatch_ops {
+	int (*init_module)(struct nbl_dispatch_mgt *disp_mgt);
+	void (*deinit_module)(struct nbl_dispatch_mgt *disp_mgt);
+};
+
+struct nbl_dispatch_ops_tbl {
+	struct nbl_dispatch_ops *ops;
+	struct nbl_dispatch_mgt *priv;
+};
+
+int nbl_disp_init(struct nbl_adapter *adapter);
+void nbl_disp_remove(struct nbl_adapter *adapter);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 3c711f9d..fc4488fb 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -12,6 +12,7 @@
 #include "nbl_include/nbl_def_channel.h"
 #include "nbl_include/nbl_def_hw.h"
 #include "nbl_include/nbl_def_resource.h"
+#include "nbl_include/nbl_def_dispatch.h"
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
@@ -58,7 +59,13 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	ret = nbl_res_init_leonis(adapter);
 	if (ret)
 		goto out_chan_remove;
+
+	ret = nbl_disp_init(adapter);
+	if (ret)
+		goto out_res_remove;
 	return adapter;
+out_res_remove:
+	nbl_res_remove_leonis(adapter);
 out_chan_remove:
 	nbl_chan_remove_common(adapter);
 out_hw_remove:
@@ -69,6 +76,7 @@ out:
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	nbl_disp_remove(adapter);
 	nbl_res_remove_leonis(adapter);
 	nbl_chan_remove_common(adapter);
 	nbl_hw_remove_leonis(adapter);
-- 
2.51.0.windows.1

