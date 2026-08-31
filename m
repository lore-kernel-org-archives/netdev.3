Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5035AC20;
	Mon, 31 Aug 2026 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142471; cv=none; b=akY3ZWfAgLhiVhi37pry2+DgBuUKPWKMlW7uVrMyN1+b3YDJzoxdlxieLJgjfRxOXSGiNB7GMhVxwCnwm9jUzOCszqhP69UKn0CDgApxliJqKxkESzJwt3yBqPXGR1EtFntYnrzS7C9XZiNq7I1rAKCgKWwOy/EqnHALRmqfBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142471; c=relaxed/simple;
	bh=Q+tjNO5+DomEF73/LizYpunrqEBtR/1O2WK7vL6NLXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7d7wATF0lGNJWCrsZ2uN6xDsn6l4r5A82EaUoce7ylpF+Ms7/2zPy/geF8vbYXVFLKeE0blNTyGOEOcgoZJXzd0CPFnG4A/piGYntbTj9qZ7X2ekzjlLMPVinfbFUY+j4bN4WoVM+i2OEpnMF9PSVvzzP4XQTxAOhhCJgk/lqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0296641-0.00568381-0.964652;FP=16597855045546411538|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.j0lvzmE_1788142458;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.j0lvzmE_1788142458 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 10:14:19 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v26 net-next 07/10] net/nebula-matrix: dispatch: add control-level routing core infrastructure
Date: Mon, 31 Aug 2026 10:13:58 +0800
Message-ID: <20260831021408.2325-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Implement core dispatch layer infrastructure for control-plane routing:
Allocate dispatch management structure and dispatch ops table
Provide init_module/deinit_module wrapper callbacks for chip resource ops
Introduce ctrl_lvl bitmask tracking; enable MGT level only for Control PF

Regular PF NET level routing will be added in a subsequent patch.
Kerneldoc on nbl_dispatch_ops documents that init_module/deinit_module
must only be invoked on Control PF behind has_ctrl guard.

This skeleton establishes dispatch management flow. It adds forward
definitions of channel wire ABI structures and response enums required
for later channel RPC framework, without implementing message handling.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 117 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  23 ++++
 .../nbl/nbl_include/nbl_def_channel.h         |  40 ++++++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  40 ++++++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   8 ++
 7 files changed, 231 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index be314b909d66..b7eebd89b4d1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -10,4 +10,5 @@ nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_hw/nbl_resource.o \
 		nbl_hw/nbl_interrupt.o \
 		nbl_hw/nbl_chip.o \
+		nbl_core/nbl_dispatch.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index dd24ebec0171..4d8cea8d8ab3 100644
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
index 000000000000..3da5f8351fa4
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
+	/* All dispatch objects allocated via devm */
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
new file mode 100644
index 000000000000..a7e5802344b4
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index 61dd97c779ef..42d2dc1ebede 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -13,6 +13,12 @@ struct nbl_adapter;
 
 typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
 
+enum {
+	NBL_CHAN_RESP_OK = 0,
+	NBL_CHAN_RESP_ERR = 1,
+	NBL_CHAN_RESP_UNIMPLEMENTED = 2,
+};
+
 /*
  * Mailbox wire opcodes, stable wire ABI shared between driver and firmware.
  * Each opcode has a fixed assigned number to preserve compatibility.
@@ -39,6 +45,32 @@ enum nbl_chan_state {
 	NBL_CHAN_STATE_NBITS
 };
 
+struct nbl_chan_param_cfg_msix_map {
+	__le16 num_net_msix;
+	__le16 num_others_msix;
+	__le16 msix_mask_en;
+	__le16 rsvd;
+};
+
+struct nbl_chan_param_set_mailbox_irq {
+	__le16 vector_id;
+	u8 en_msix;
+	u8 rsvd;
+};
+
+struct nbl_chan_param_get_vsi_id {
+	__le16 vsi_id;
+	__le16 type;
+};
+
+struct nbl_chan_param_get_eth_id {
+	__le16 vsi_id;
+	u8 eth_num;
+	u8 eth_id;
+	u8 logic_eth_id;
+	u8 rsvd[3];
+};
+
 struct nbl_board_port_info {
 	u8 eth_num;
 	u8 eth_speed;
@@ -46,6 +78,14 @@ struct nbl_board_port_info {
 	u8 rsv[5];
 };
 
+static_assert(sizeof(struct nbl_chan_param_cfg_msix_map) == 8,
+	      "nbl_chan_param_cfg_msix_map size must be 8 bytes");
+static_assert(sizeof(struct nbl_chan_param_set_mailbox_irq) == 4,
+	      "nbl_chan_param_set_mailbox_irq size must be 4 bytes");
+static_assert(sizeof(struct nbl_chan_param_get_vsi_id) == 4,
+	      "nbl_chan_param_get_vsi_id size must be 4 bytes");
+static_assert(sizeof(struct nbl_chan_param_get_eth_id) == 8,
+	      "nbl_chan_param_get_eth_id size must be 8 bytes");
 static_assert(sizeof(struct nbl_board_port_info) == 8,
 	      "nbl_board_port_info size must be 8 bytes");
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 000000000000..d5e7da0fef6e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,40 @@
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
+	NBL_DISP_CTRL_LVL_NET,
+	NBL_DISP_CTRL_LVL_MAX,
+};
+
+/**
+ * struct nbl_dispatch_ops - dispatch control plane operation callbacks
+ * @init_module: dispatch layer initialization, ONLY valid on Control PF,
+ *               caller must check has_ctrl guard
+ * @deinit_module: dispatch layer cleanup, ONLY valid on Control PF,
+ *                 caller must check has_ctrl guard
+ * Warning: All ops except init_module/deinit_module can be safely called
+ * on PF/VF; init/deinit hooks are control-PF exclusive to prevent NULL ptr.
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
index 1aafed2d46d7..5d5c0bbf418c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -11,6 +11,7 @@
 #include "nbl_include/nbl_def_channel.h"
 #include "nbl_include/nbl_def_hw.h"
 #include "nbl_include/nbl_def_resource.h"
+#include "nbl_include/nbl_def_dispatch.h"
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
@@ -48,7 +49,13 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	ret = nbl_res_init_leonis(adapter);
 	if (ret)
 		goto res_init_fail;
+
+	ret = nbl_disp_init(adapter);
+	if (ret)
+		goto disp_init_fail;
 	return adapter;
+disp_init_fail:
+	nbl_res_remove_leonis(adapter);
 res_init_fail:
 	nbl_chan_remove_common(adapter);
 chan_init_fail:
@@ -59,6 +66,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	nbl_disp_remove(adapter);
 	nbl_res_remove_leonis(adapter);
 	nbl_chan_remove_common(adapter);
 	nbl_hw_remove_leonis(adapter);
-- 
2.47.3

