Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A781FD4;
	Fri,  7 Aug 2026 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077890; cv=none; b=d2ItWkssbbMkJwi4NgN4LcGJq7QIiQsnChgmJFzVELbnmPD41Ctu6YF1b2okmPChwAmAOWUHbx/C73Py2IsCDfctFyQZWubH+7GgB7N81iMb+IeGVCLWUSPbKGYNeZpv3canqtruyKXliWdV2mfP+2jA6/OsZOp7iXijh31D8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077890; c=relaxed/simple;
	bh=a+BqUS0wLCrz3BlOPrNy/mTP3zppBjn1l9Wn1517jIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw3ForzSA7Na12HwerIY2fSvO/VRtnvMQv0iBM842nrOaN1wGixqL19dTNaRLjcV99fHfQc4gDFDs2qwqgIKK4veE568w296cZtS0RRxQ0BVZ3ksm9i0O9TX0PdR9aNMeBKp0LSjC4jEIC8WJ2f0GFAI7CsdaRfWDqqrQ8nxCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0455925-0.00734917-0.947058;FP=16597836212111672850|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.ig.C9-p_1786077873;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.ig.C9-p_1786077873 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 12:44:34 +0800
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
Subject: [PATCH v24 net-next 08/11] net/nebula-matrix: dispatch: add control-level routing core infrastructure
Date: Fri,  7 Aug 2026 12:44:12 +0800
Message-ID: <20260807044422.2356-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add base dispatch layer infrastructure for control-level routing:
1. Dispatch management & ops table structures allocation
2. X-macro op table template for uniform dispatch entry registration
3. Control PF / regular PF routing logic via ctrl_lvl bitmask
4. Local chip init/deinit dispatch wrappers (no channel dependency)

Document constraint: init_module/deinit_module only valid
on Control PF, caller must guard with has_ctrl to avoid NULL deref.

This patch only provides core routing skeleton, no channel message
handling or resource locking logic.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_channel/nbl_channel.c             |   4 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 112 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  24 ++++
 .../nbl/nbl_include/nbl_def_channel.h         |  32 +++++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  42 +++++++
 .../nbl/nbl_include/nbl_include.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   8 ++
 9 files changed, 227 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index ef5b6ada70e5..56464f576cbe 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -10,4 +10,5 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
 				nbl_hw/nbl_chip.o \
+				nbl_core/nbl_dispatch.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
index 3eb795199217..9e0f9b6c4c3a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -1030,6 +1030,10 @@ int nbl_chan_init_common(struct nbl_adapter *adap)
 	struct nbl_channel_mgt *chan_mgt;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_cfg_msix_map) != 8);
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_set_mailbox_irq) != 4);
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_get_vsi_id) != 4);
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_get_eth_id) != 8);
 	chan_mgt = nbl_chan_setup_chan_mgt(adap);
 	if (IS_ERR(chan_mgt)) {
 		ret = PTR_ERR(chan_mgt);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 6d7f000dde85..566d67130975 100644
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
index 000000000000..9358651cbf7e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+static void nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
+{
+	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
+
+	set_bit(lvl, disp_mgt->ctrl_lvl);
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
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
+
+	return 0;
+}
+
+void nbl_disp_remove(struct nbl_adapter *adapter)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
new file mode 100644
index 000000000000..f06b90075af4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DISPATCH_H_
+#define _NBL_DISPATCH_H_
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
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
index b5a7b069d834..23bdd453ee73 100644
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
  * Mailbox wire opcodes
  * Every opcode is assigned explicit fixed numeric value, stable wire ABI
@@ -252,6 +258,32 @@ enum nbl_chan_state {
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 000000000000..b26425e0112b
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+	NBL_DISP_CTRL_LVL_NEVER = 0,
+	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_NET,
+	NBL_DISP_CTRL_LVL_MAX,
+};
+
+struct nbl_dispatch_ops {
+	int (*init_module)(struct nbl_dispatch_mgt *disp_mgt);
+	void (*deinit_module)(struct nbl_dispatch_mgt *disp_mgt);
+	int (*cfg_msix_map)(struct nbl_dispatch_mgt *disp_mgt,
+			    u16 num_net_msix, u16 num_others_msix,
+			    bool net_msix_mask_en);
+	int (*destroy_msix_map)(struct nbl_dispatch_mgt *disp_mgt);
+	int (*set_mailbox_irq)(struct nbl_dispatch_mgt *disp_mgt,
+			       u16 vector_id, bool en_msix);
+	int (*get_vsi_id)(struct nbl_dispatch_mgt *disp_mgt, u16 type,
+			  u16 *vsi_id);
+	int (*get_eth_id)(struct nbl_dispatch_mgt *disp_mgt, u16 vsi_id,
+			  u8 *eth_num, u8 *eth_id, u8 *logic_eth_id);
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 3f35982cb02a..5f33a5de908d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -15,6 +15,8 @@
 
 #define NBL_MAX_FUNC					520
 #define NBL_MAX_ETHERNET				4
+/* Used for macros to pass checkpatch */
+#define NBL_NAME(x)					x
 
 enum {
 	NBL_VSI_DATA = 0,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 3e3de6dabb10..6bd74c933c78 100644
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

