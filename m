Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6E3A1D02;
	Sun, 23 Aug 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514015; cv=none; b=saIjTWssuwADfCqoC73FXiMZnK7nNNasGbxnqMS/d1NG87axuqq+aYJWp1fi1s4M8SFOogx9GhjCCzqKLM7W9CmMmZXVcVm/QjcShSsbdnVwexB3mrp80wtSltL91slgHpMyu2kigkNal9H/Zsgr3nk+PZjCjXbp4105t/OtEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514015; c=relaxed/simple;
	bh=2umvfrpeC8ex6BPqWN1rMBLE7f/qYPjL9joYOfMYyk8=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=UH6gOLz6zvwWrm8p2eT7M9cUxxOAdimXCCvGnzF/hQOJgKhl9ra5kYbuQ3OmKNkEE4801S/dW/KFMR1VSW38//S87mTnT+pAvEqpPZuETnEJtbAegMiwptidOEA+5ofcjEVkrGORqggjVe80Up9BMw6LP+K36d5O0F/S7dkiYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hSksP6wpDz52SFx;
	Mon, 24 Aug 2026 03:40:09 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl1.zte.com.cn with SMTP id 67NJdxLQ086352;
	Mon, 24 Aug 2026 03:40:00 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 24 Aug 2026 03:40:04 +0800 (CST)
X-Zmail-TransId: 2afb6a8b4c9462c-2b034
X-Mailer: Zmail v1.0
Message-ID: <20260824034004555dx-gJtT5B5Yw_sQ447U0O@zte.com.cn>
In-Reply-To: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
References: 20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn
Date: Mon, 24 Aug 2026 03:40:04 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYxIDMvM10gZGluZ2hhaTogYWRkIGFzeW5jIGV2ZW50IHF1ZXVlIGZvciBmaXJtd2FyZQogbm90aWZpY2F0aW9ucw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67NJdxLQ086352
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 24 Aug 2026 03:40:09 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A8B4C99.000/4hSksP6wpDz52SFx

From: Junyang Han <han.junyang@zte.com.cn>

Add the event queue table and the first async event queue, fed by the
RISC-V management core of the firmware. The queue owns one MSI-X
vector taken from the async pool and, on interrupt, reads the event_id
from the PF receive sub-channel of the BAR message area, maps it to
an event type and fans it out through the per-event-type notifier
chains of the table. The PF probe creates and tears down the queue
through the existing IRQ pool interfaces.

The BAR message channel handshake that tells the firmware which
vectors to signal comes with the BAR message subsystem in a later
series; the PF side wired here is live as soon as that channel is
enabled. Subscribers for the RISCV_READY event register on the
notifier chains in later series as well.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 drivers/net/ethernet/zte/dinghai/Makefile  |   2 +-
 drivers/net/ethernet/zte/dinghai/en_pf.c   |  31 +++--
 drivers/net/ethernet/zte/dinghai/en_pf.h   |   2 +
 drivers/net/ethernet/zte/dinghai/zxdh_eq.c | 145 +++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.h |  61 +++++++++
 5 files changed, 232 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.h

diff --git a/drivers/net/ethernet/zte/dinghai/Makefile b/drivers/net/ethernet/zte/dinghai/Makefile
index f4a8f9480291..2dc6d68cc0e1 100644
--- a/drivers/net/ethernet/zte/dinghai/Makefile
+++ b/drivers/net/ethernet/zte/dinghai/Makefile
@@ -4,4 +4,4 @@
 #

 obj-$(CONFIG_DINGHAI_PF) += dinghai10e.o
-dinghai10e-y := en_pf.o zxdh_irq.o
+dinghai10e-y := en_pf.o zxdh_irq.o zxdh_eq.o
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index 8e76a1905fd2..74c79d39ea8a 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.c
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -488,7 +488,8 @@ static int zxdh_pf_irq_pools_init(struct zxdh_core_dev *zxdh_dev)

 static void zxdh_pf_irq_pools_destroy(struct zxdh_pf_irq_table *pf_irq_table)
 {
-	zxdh_irq_pool_free(pf_irq_table->async_pool);
+	if (pf_irq_table->async_pool)
+		zxdh_irq_pool_free(pf_irq_table->async_pool);
 }

 int zxdh_pf_irq_table_init(struct zxdh_core_dev *zxdh_dev)
@@ -532,18 +533,17 @@ void zxdh_pf_irq_table_destroy(struct zxdh_core_dev *zxdh_dev)
 {
 	struct zxdh_irq_table *table = &zxdh_dev->irq_table;

-	zxdh_pf_irq_pools_destroy(table->priv);
+	if (table->priv)
+		zxdh_pf_irq_pools_destroy(table->priv);
 	kvfree(table->priv);
+	table->priv = NULL;
 	pci_free_irq_vectors(zxdh_dev->pdev);
 }

+/* Fetch a vector from the async pool for one async event queue. */
 struct zxdh_irq *zxdh_pf_async_irq_request(struct zxdh_core_dev *zxdh_dev)
 {
-	struct zxdh_irq_table *table = &zxdh_dev->irq_table;
-	struct zxdh_pf_irq_table *pf_irq_table = table->priv;
-
-	if (!pf_irq_table->async_pool)
-		return NULL;
+	struct zxdh_pf_irq_table *pf_irq_table = zxdh_dev->irq_table.priv;

 	return zxdh_get_irq_of_pool(pf_irq_table->async_pool);
 }
@@ -608,12 +608,26 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_irq_table;
 	}

+	ret = zxdh_pf_eq_table_init(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_eq_table_init failed: %d\n", ret);
+		goto err_eq_table;
+	}
+
+	ret = zxdh_pf_eq_table_create(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_eq_table_create failed: %d\n", ret);
+		goto err_eq_table;
+	}
+
 	devlink_register(devlink);

 	return 0;

+err_eq_table:
+	zxdh_pf_eq_table_destroy(zxdh_dev);
 err_irq_table:
-	kvfree(zxdh_dev->irq_table.priv);
+	zxdh_pf_irq_table_destroy(zxdh_dev);
 err_cfg_init:
 	zxdh_pf_pci_close(zxdh_dev);
 err_pci_init:
@@ -629,6 +643,7 @@ static void zxdh_pf_remove(struct pci_dev *pdev)
 	struct devlink *devlink = priv_to_devlink(zxdh_dev);

 	devlink_unregister(devlink);
+	zxdh_pf_eq_table_destroy(zxdh_dev);
 	zxdh_pf_irq_table_destroy(zxdh_dev);
 	zxdh_pf_modern_cfg_uninit(zxdh_dev);
 	zxdh_pf_pci_close(zxdh_dev);
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
index 09592b9de6cf..49e1ee9ed8b9 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.h
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -9,6 +9,7 @@

 #include <linux/types.h>

+#include "zxdh_eq.h"
 #include "zxdh_irq.h"

 #define ZXDH_PF_VENDOR_ID	0x1cf2
@@ -81,6 +82,7 @@ struct zxdh_core_dev {
 	struct pci_dev *pdev;
 	struct devlink *devlink;
 	struct zxdh_irq_table irq_table;
+	struct zxdh_eq_table eq_table;
 	void *priv;
 };

diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_eq.c b/drivers/net/ethernet/zte/dinghai/zxdh_eq.c
new file mode 100644
index 000000000000..f1d7eeec1ae4
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/zxdh_eq.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE DingHai Ethernet driver - event queue plumbing
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ *
+ * Async event queues are the delivery path for firmware notifications:
+ * a queue owns one MSI-X vector of the async pool and fans interrupts
+ * out to the per-event-type notifier chains of the event queue table.
+ * The BAR message channel handshake that tells the firmware which
+ * vectors to signal comes with the BAR message subsystem in a later
+ * series; the PF side wired here is live as soon as that channel is
+ * enabled.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+
+#include "en_pf.h"
+#include "zxdh_eq.h"
+#include "zxdh_irq.h"
+
+/* PF side of the event queue table: one async EQ fed by the RISC-V
+ * management core.
+ */
+struct zxdh_pf_eq_table {
+	struct zxdh_eq_async riscv_eq;
+};
+
+/* Fetch the event_id the RISC-V core posted in the PF receive
+ * sub-channel of the BAR message area. The field lives at byte offset
+ * 2 of the 12-byte message header, so a single 32-bit read of the
+ * sub-channel start covers it.
+ */
+static u16 zxdh_eq_event_id_get(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	void __iomem *subchan;
+
+	subchan = pf_dev->pci_ioremap_addr[0] + ZXDH_BAR_MSG_SUBCHAN_RECV;
+
+	return ioread32(subchan) >> 16;
+}
+
+static enum zxdh_eq_event_type zxdh_eq_event_type_get(u16 event_id)
+{
+	if (event_id == ZXDH_MSG_MODULE_RISC_READY)
+		return ZXDH_EQ_EVENT_TYPE_RISCV_READY;
+
+	/* Only the RISC-V ready notification is dispatched in this
+	 * series; the remaining firmware events arrive with the BAR
+	 * message subsystem.
+	 */
+	return ZXDH_EQ_EVENT_TYPE_MAX;
+}
+
+static int zxdh_eq_async_riscv_int(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct zxdh_eq_async *eq = container_of(nb, struct zxdh_eq_async, irq_nb);
+	struct zxdh_core_dev *zxdh_dev = eq->priv;
+	enum zxdh_eq_event_type event_type;
+
+	event_type = zxdh_eq_event_type_get(zxdh_eq_event_id_get(zxdh_dev));
+	if (event_type == ZXDH_EQ_EVENT_TYPE_MAX)
+		return NOTIFY_DONE;
+
+	atomic_notifier_call_chain(&zxdh_dev->eq_table.nh[event_type],
+				   event_type, NULL);
+
+	return NOTIFY_OK;
+}
+
+int zxdh_pf_eq_table_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_eq_table *table = &zxdh_dev->eq_table;
+	struct zxdh_pf_eq_table *priv;
+	int i;
+
+	priv = kvzalloc_obj(*priv, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	table->priv = priv;
+
+	mutex_init(&table->lock);
+	for (i = 0; i < ZXDH_EQ_EVENT_TYPE_MAX; i++)
+		ATOMIC_INIT_NOTIFIER_HEAD(&table->nh[i]);
+
+	return 0;
+}
+
+int zxdh_pf_eq_table_create(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_eq_table *pf_eq_table = zxdh_dev->eq_table.priv;
+	struct zxdh_eq_table *table = &zxdh_dev->eq_table;
+	struct zxdh_eq_async *eq = &pf_eq_table->riscv_eq;
+	int err;
+
+	mutex_lock(&table->lock);
+
+	eq->priv = zxdh_dev;
+	eq->irq = zxdh_pf_async_irq_request(zxdh_dev);
+	if (IS_ERR(eq->irq)) {
+		err = PTR_ERR(eq->irq);
+		goto unlock;
+	}
+
+	eq->irq_nb.notifier_call = zxdh_eq_async_riscv_int;
+	err = zxdh_irq_attach_nb(eq->irq, &eq->irq_nb);
+	if (err) {
+		zxdh_irqs_release_vectors(&eq->irq, 1);
+		eq->irq = NULL;
+	}
+
+unlock:
+	mutex_unlock(&table->lock);
+
+	return err;
+}
+
+void zxdh_pf_eq_table_destroy(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_eq_table *pf_eq_table = zxdh_dev->eq_table.priv;
+	struct zxdh_eq_table *table = &zxdh_dev->eq_table;
+	struct zxdh_eq_async *eq;
+
+	if (!pf_eq_table)
+		return;
+
+	eq = &pf_eq_table->riscv_eq;
+
+	mutex_lock(&table->lock);
+	if (eq->irq) {
+		zxdh_irq_detach_nb(eq->irq, &eq->irq_nb);
+		zxdh_irqs_release_vectors(&eq->irq, 1);
+		eq->irq = NULL;
+	}
+	mutex_unlock(&table->lock);
+
+	mutex_destroy(&table->lock);
+	kvfree(table->priv);
+	table->priv = NULL;
+}
diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_eq.h b/drivers/net/ethernet/zte/dinghai/zxdh_eq.h
new file mode 100644
index 000000000000..4965ca15912a
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/zxdh_eq.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE DingHai Ethernet driver - event queue abstraction
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#ifndef __ZXDH_EQ_H__
+#define __ZXDH_EQ_H__
+
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+
+struct zxdh_core_dev;
+struct zxdh_irq;
+
+/* BAR message area: shared-memory mailbox between the driver and the
+ * firmware, split into sub-channels of 2048 bytes. Notifications from
+ * the RISC-V management core are posted to the PF receive sub-channel,
+ * one interval above the area base.
+ */
+#define ZXDH_BAR_MSG_OFFSET		0x2000
+#define ZXDH_BAR_MSG_SUBCHAN_INTERVAL	2048
+#define ZXDH_BAR_MSG_SUBCHAN_RECV	(ZXDH_BAR_MSG_OFFSET +	\
+					 ZXDH_BAR_MSG_SUBCHAN_INTERVAL)
+
+/* event_id of the "RISC-V core ready" firmware notification, carried
+ * at byte offset 2 of the BAR message header.
+ */
+#define ZXDH_MSG_MODULE_RISC_READY	13
+
+/* Event types the upper layers can subscribe to over the per-type
+ * notifier chains of the event queue table. The full catalogue lives
+ * in the firmware; only the ones dispatched in this series are named.
+ */
+enum zxdh_eq_event_type {
+	ZXDH_EQ_EVENT_TYPE_RISCV_READY = 0,
+	ZXDH_EQ_EVENT_TYPE_MAX,
+};
+
+/* Asynchronous event queue delivering firmware notifications to the
+ * driver without a request/reply handshake.
+ */
+struct zxdh_eq_async {
+	struct zxdh_irq *irq;
+	struct notifier_block irq_nb;
+	void *priv;
+};
+
+struct zxdh_eq_table {
+	/* Notifier chains fanned out by event type. */
+	struct atomic_notifier_head nh[ZXDH_EQ_EVENT_TYPE_MAX];
+	/* Serializes async EQ create/destroy. */
+	struct mutex lock;
+	void *priv;
+};
+
+int zxdh_pf_eq_table_init(struct zxdh_core_dev *zxdh_dev);
+int zxdh_pf_eq_table_create(struct zxdh_core_dev *zxdh_dev);
+void zxdh_pf_eq_table_destroy(struct zxdh_core_dev *zxdh_dev);
+
+#endif /* __ZXDH_EQ_H__ */
-- 
2.27.0
