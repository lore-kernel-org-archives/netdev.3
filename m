Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915B44F557;
	Wed, 30 Sep 2026 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754372; cv=none; b=ecLb6lpgml8VpsEZDwnurqviHKG2aTzSHVezFJfTjTf0hEQto/bBfq8cV9+E1WzIi3KI66BbsMVNESe9sQO8ywR4YSPEaWRJro2BdEBM4aOur7ADkGWz47IBlI3y5Wrwwrj965GC5d4xWaooADVnYJ1LULJUiYyssD4ETdH/x7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754372; c=relaxed/simple;
	bh=nvGBz05PQL7TBFxG78iW6YO30fpji/1etEFgt0zEPxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnCF1xBhYv88zd7zZWj/yfy5/l812REHLNrpEUDJBAxWT0Yqgyfdt3rpdnAerW65+MZtIMHRKwCtTW3sWAm0BTSxkXYfec3NltGvuYRZOH7UNa7DHAkF55URO4C/0CfGh8pXb5qTmUiLMp4kG8MDimdosHXIb2RZukxiPTtN3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhgabHwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhgabHwN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E22FC4AF19;
	Wed, 30 Sep 2026 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790754372;
	bh=nvGBz05PQL7TBFxG78iW6YO30fpji/1etEFgt0zEPxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NhgabHwNC0oUzZoTpyLAeH35BUF1WGf6IF5J1dJEKQ3DaVz2WgwnTweYbM0JuHpWe
	 JIxGOXDiNjccugp2fpfaF9XP90rVJq0+BM8UoJISR2/KtDqR23OROiBnOseTVMYsfV
	 uJo+fCsVcQBPacLXXbahvWR5oCtgtxsUSZmmiT/EkdhOl1401BefuHoewg1jNFOIio
	 Hpi2hgqB2+Efi/6BxWwSubzskuaSiXi8bXNQoQVyQ7Odm3Ci0AdFttwUtq17Ef+Mt0
	 0dX2H9ADymhc67d6qkAoNDUdHBo6L6o2IKuvsUv39Gj4UPNOk7eJtUI32myI89AkWM
	 AGyjgnNS4tYvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A22CA5FC4;
	Wed, 30 Sep 2026 07:46:12 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Wed, 30 Sep 2026 15:46:09 +0800
Subject: [PATCH v9 2/6] net: wwan: t9xx: Add control plane transaction
 layer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-t9xx_driver_v1-v9-2-3248b9256956@compal.com>
References: <20260930-t9xx_driver_v1-v9-0-3248b9256956@compal.com>
In-Reply-To: <20260930-t9xx_driver_v1-v9-0-3248b9256956@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jack Wu <jackbb_wu@compal.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, 
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, 
 Minano Tseng <Minano.tseng@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Robert Yu <robert_yu@compal.com>, 
 Jeff Chang <Jeff_Chang@compal.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790754369; l=4860;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=uRaR7LXWts9xSG1pICFj0duFvYSLuyCLHNcuT1Xp8Iw=;
 b=FQGFJTsopdan3Dy37SlJ1AuYAdM49N5ISKdHxFy85ZfIVQsSr0OZBdYOuFOrLSrrVbbwynDV2
 WUG/rK8Zt5DA6qW1pXYYxzuWZ0+S5u6METIfeMV2wWv+3Dr2ZMCsHMN
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com

From: Jack Wu <jackbb_wu@compal.com>

Introduce the control plane and transaction layer framework
for the T9XX WWAN driver. This patch adds the core data
structures (mtk_ctrl_blk, mtk_ctrl_trans) and initialization
entry points that subsequent patches build upon.

The control plane block (ctrl_blk) serves as the central
context for managing the transaction layer, port layer, and
FSM interactions. The actual DMA engine and TX/RX service
implementations are added in subsequent patches.

Signed-off-by: Jack Wu <jackbb_wu@compal.com>
---
 drivers/net/wwan/t9xx/Makefile              |  1 +
 drivers/net/wwan/t9xx/mtk_ctrl_plane.c      | 44 +++++++++++++++++++++++++++++
 drivers/net/wwan/t9xx/mtk_ctrl_plane.h      | 22 +++++++++++++++
 drivers/net/wwan/t9xx/mtk_dev.h             |  3 ++
 drivers/net/wwan/t9xx/pcie/mtk_pci.c        |  1 +
 drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h | 21 ++++++++++++++
 6 files changed, 92 insertions(+)

diff --git a/drivers/net/wwan/t9xx/Makefile b/drivers/net/wwan/t9xx/Makefile
index bd6063c85c2b..0a07507f1ddf 100644
--- a/drivers/net/wwan/t9xx/Makefile
+++ b/drivers/net/wwan/t9xx/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -I$(src)
 obj-$(CONFIG_MTK_T9XX) += mtk_t9xx.o
 
 mtk_t9xx-y := \
+	mtk_ctrl_plane.o \
 	pcie/mtk_pci.o
diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
new file mode 100644
index 000000000000..fa2ab8c3e757
--- /dev/null
+++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, MediaTek Inc.
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include <linux/device.h>
+
+#include "mtk_ctrl_plane.h"
+
+/**
+ * mtk_ctrl_init() - Initialize the control plane block.
+ * @mdev: Pointer to the MTK modem device.
+ *
+ * Allocates and initializes the control plane block
+ * associated with @mdev.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+int mtk_ctrl_init(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_blk *ctrl_blk;
+
+	ctrl_blk = devm_kzalloc(mdev->dev, sizeof(*ctrl_blk), GFP_KERNEL);
+	if (!ctrl_blk)
+		return -ENOMEM;
+
+	ctrl_blk->mdev = mdev;
+	mdev->ctrl_blk = ctrl_blk;
+
+	return 0;
+}
+
+/**
+ * mtk_ctrl_exit() - Clean up the control plane block.
+ * @mdev: Pointer to the MTK modem device.
+ *
+ * Clears the control plane block pointer. The allocation
+ * itself is managed by devres and freed on driver detach.
+ */
+void mtk_ctrl_exit(struct mtk_md_dev *mdev)
+{
+	mdev->ctrl_blk = NULL;
+}
diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.h b/drivers/net/wwan/t9xx/mtk_ctrl_plane.h
new file mode 100644
index 000000000000..c141876ef95d
--- /dev/null
+++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022, MediaTek Inc.
+ */
+
+#ifndef __MTK_CTRL_PLANE_H__
+#define __MTK_CTRL_PLANE_H__
+
+#include <linux/kref.h>
+#include <linux/skbuff.h>
+
+#include "mtk_dev.h"
+
+struct mtk_ctrl_blk {
+	struct mtk_md_dev *mdev;
+	struct mtk_ctrl_trans *trans;
+};
+
+int mtk_ctrl_init(struct mtk_md_dev *mdev);
+void mtk_ctrl_exit(struct mtk_md_dev *mdev);
+
+#endif /* __MTK_CTRL_PLANE_H__ */
diff --git a/drivers/net/wwan/t9xx/mtk_dev.h b/drivers/net/wwan/t9xx/mtk_dev.h
index 329e5e6695df..84fcd980110b 100644
--- a/drivers/net/wwan/t9xx/mtk_dev.h
+++ b/drivers/net/wwan/t9xx/mtk_dev.h
@@ -31,12 +31,15 @@ enum mtk_dev_evt_d2h {
 	DEV_EVT_D2H_ASYNC_HS_NOTIFY_MD	= BIT(6),
 };
 
+struct mtk_ctrl_blk;
+
 /* mtk_md_dev defines the structure of MTK modem device */
 struct mtk_md_dev {
 	struct device *dev;
 	void *hw_priv;
 	u32 hw_ver;
 	char dev_str[MTK_DEV_STR_LEN];
+	struct mtk_ctrl_blk *ctrl_blk;
 };
 
 #endif /* __MTK_DEV_H__ */
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
index 34ee823119fc..c2c2b824ff31 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_pci.c
+++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 
 #include "mtk_dev.h"
+#include "mtk_trans_ctrl.h"
 #include "mtk_pci.h"
 #include "mtk_pci_reg.h"
 
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
new file mode 100644
index 000000000000..d6de4c43b529
--- /dev/null
+++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022, MediaTek Inc.
+ */
+
+#ifndef __MTK_TRANS_CTRL_H__
+#define __MTK_TRANS_CTRL_H__
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "mtk_dev.h"
+
+struct mtk_ctrl_trans {
+	struct mtk_ctrl_blk *ctrl_blk;
+	struct mtk_md_dev *mdev;
+};
+
+#endif

-- 
2.34.1


