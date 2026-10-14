Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCD1DDC38;
	Wed, 14 Oct 2026 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962271; cv=none; b=YPx60A87hEwrWZCHGSUflx7gaR3WOMb9QWaKUBD74HrYuDue+VvOoMuQOqMnvfwxwOICXQ2NNu6flRU1Ub5fv2oTNEXsbB7MXF222eBW7w3UfJnTYkwCR1ZyR1DUexDzt/uqcnXHhJx9483Sln0Dh5T1/7xNylQTCSwj8MASeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962271; c=relaxed/simple;
	bh=iihjj1fYn7NyVsIg+bb6tj9++ANQWv6EJtVj9B8MstI=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=m8y8dyJPRDZu6wBJaiLm+tNRIeqi2ReVUWUL/J6YPI+ompPKUmZFu2byehLj8Qs1w+0mr7f87XdAe/Yzykv83csUltKo+H8cyXz/C85RcnCRV5Twcbbco/l7Nq5oAEq3Sd9FicEtWQi4hCHXAAMXRkNsLysCC70AU7CEfIe6NUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4Mwl6xdSz5B0w4;
	Wed, 14 Oct 2026 15:17:43 +0800 (CST)
Received: from njy2app03.zte.com.cn ([10.40.13.14])
	by mse-fl2.zte.com.cn with SMTP id 69E7HZLI010430;
	Wed, 14 Oct 2026 15:17:35 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 14 Oct 2026 15:17:37 +0800 (CST)
X-Zmail-TransId: 2afd6acf2c91826-eb06f
X-Mailer: Zmail v1.0
Message-ID: <20261014151737154aqX45e-i_Lc-lVf3c5RwP@zte.com.cn>
In-Reply-To: <20261014151200489685SCIlolykW0NGfL5EtQ@zte.com.cn>
References: 20261014151200489685SCIlolykW0NGfL5EtQ@zte.com.cn
Date: Wed, 14 Oct 2026 15:17:37 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY1IDIvM10gZGluZ2hhaTogYWRkIE1TSS1YIGludGVycnVwdCBwb29scw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69E7HZLI010430
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 15:17:43 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF2C97.000/4j4Mwl6xdSz5B0w4

From: Junyang Han <han.junyang@zte.com.cn>

Allocate the fixed MSI-X vector layout of the device and manage the
vectors in per-purpose pools: the async event queues first, a range
reserved for RDMA in between and the vq queue pairs last. This series
wires up the async pool; the vq pool comes with the netdev series.

IRQs are reference counted so that several event queues can share one
vector. The pool hands out the least loaded matching IRQ once it passes
the pool minimum threshold, and binds newly created IRQs to the least
loaded CPU of the requested affinity mask. Interrupt delivery fans out
through an atomic notifier chain attached to each IRQ, which the async
event queue setup posted later in this series hooks into.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 drivers/net/ethernet/zte/dinghai/Makefile   |   2 +-
 drivers/net/ethernet/zte/dinghai/en_pf.c    |  84 ++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    |   8 +
 drivers/net/ethernet/zte/dinghai/zxdh_irq.c | 406 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.h |  73 ++++
 5 files changed, 572 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.h

diff --git a/drivers/net/ethernet/zte/dinghai/Makefile b/drivers/net/ethernet/zte/dinghai/Makefile
index e2f4da33df59..f4a8f9480291 100644
--- a/drivers/net/ethernet/zte/dinghai/Makefile
+++ b/drivers/net/ethernet/zte/dinghai/Makefile
@@ -4,4 +4,4 @@
 #

 obj-$(CONFIG_DINGHAI_PF) += dinghai10e.o
-dinghai10e-y := en_pf.o
+dinghai10e-y := en_pf.o zxdh_irq.o
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index ddff9b0438fb..d5462ac6468f 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.c
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -8,6 +8,8 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
 #include <net/devlink.h>
 #include <linux/dma-mapping.h>
 #include "en_pf.h"
@@ -27,6 +29,14 @@ static const struct pci_device_id zxdh_pf_pci_table[] = {

 MODULE_DEVICE_TABLE(pci, zxdh_pf_pci_table);

+struct zxdh_pf_irq_table {
+	struct zxdh_irq_pool *async_pool;
+};
+
+/* IRQ compaction thresholds of the async pool, in number of queues. */
+#define ZXDH_PF_ASYNC_IRQ_MIN_COMP	0
+#define ZXDH_PF_ASYNC_IRQ_MAX_COMP	7
+
 void *zxdh_core_alloc_priv(struct zxdh_core_dev *zxdh_dev, size_t size)
 {
 	void *priv = kzalloc(size, GFP_KERNEL);
@@ -485,6 +495,71 @@ static int zxdh_pf_wait_riscv_ready(struct zxdh_core_dev *zxdh_dev)
 	return 0;
 }

+static int zxdh_pf_irq_pools_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_irq_table *pf_irq_table = zxdh_dev->irq_table.priv;
+	struct zxdh_irq_pool *pool;
+
+	pool = zxdh_irq_pool_alloc(zxdh_dev, 0, ZXDH_ASYNC_CHANNELS_NUM,
+				   "zxdh_pf_async", ZXDH_PF_ASYNC_IRQ_MIN_COMP,
+				   ZXDH_PF_ASYNC_IRQ_MAX_COMP);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	pf_irq_table->async_pool = pool;
+
+	return 0;
+}
+
+static void zxdh_pf_irq_pools_destroy(struct zxdh_pf_irq_table *pf_irq_table)
+{
+	zxdh_irq_pool_free(pf_irq_table->async_pool);
+}
+
+int zxdh_pf_irq_table_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_irq_table *table = &zxdh_dev->irq_table;
+	struct zxdh_pf_irq_table *priv;
+	int total_vec;
+
+	priv = kvzalloc_obj(*priv, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	table->priv = priv;
+
+	total_vec = ZXDH_VQS_CHANNELS_NUM + ZXDH_ASYNC_CHANNELS_NUM +
+		    ZXDH_RDMA_CHANNELS_NUM;
+	total_vec = pci_alloc_irq_vectors(zxdh_dev->pdev, total_vec, total_vec,
+					  PCI_IRQ_MSIX);
+	if (total_vec < 0) {
+		dev_err(zxdh_dev->device, "pci_alloc_irq_vectors failed: %d\n",
+			total_vec);
+		return total_vec;
+	}
+
+	return zxdh_pf_irq_pools_init(zxdh_dev);
+}
+
+void zxdh_pf_irq_table_destroy(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_irq_table *table = &zxdh_dev->irq_table;
+
+	zxdh_pf_irq_pools_destroy(table->priv);
+	kvfree(table->priv);
+	pci_free_irq_vectors(zxdh_dev->pdev);
+}
+
+struct zxdh_irq *zxdh_pf_async_irq_request(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_irq_table *table = &zxdh_dev->irq_table;
+	struct zxdh_pf_irq_table *pf_irq_table = table->priv;
+
+	if (!pf_irq_table->async_pool)
+		return NULL;
+
+	return zxdh_get_irq_of_pool(pf_irq_table->async_pool);
+}
+
 static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct zxdh_core_dev *zxdh_dev;
@@ -533,10 +608,18 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_modern_cfg;
 	}

+	ret = zxdh_pf_irq_table_init(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_irq_table_init failed: %d\n", ret);
+		goto err_irq_table;
+	}
+
 	devlink_register(devlink);

 	return 0;

+err_irq_table:
+	zxdh_pf_irq_table_destroy(zxdh_dev);
 err_modern_cfg:
 	zxdh_pf_modern_cfg_uninit(zxdh_dev);
 err_cfg_init:
@@ -554,6 +637,7 @@ static void zxdh_pf_remove(struct pci_dev *pdev)
 	struct devlink *devlink = priv_to_devlink(zxdh_dev);

 	devlink_unregister(devlink);
+	zxdh_pf_irq_table_destroy(zxdh_dev);
 	zxdh_pf_modern_cfg_uninit(zxdh_dev);
 	zxdh_pf_pci_close(zxdh_dev);
 	zxdh_core_free_priv(zxdh_dev);
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
index 730cb084a8ae..3de96488a810 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.h
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -9,6 +9,8 @@

 #include <linux/types.h>

+#include "zxdh_irq.h"
+
 #define ZXDH_PF_VENDOR_ID	0x1cf2
 #define ZXDH_PF_DEVICE_ID	0x8040
 #define ZXDH_VF_DEVICE_ID	0x8041
@@ -78,6 +80,7 @@ struct zxdh_core_dev {
 	struct device *device;
 	struct pci_dev *pdev;
 	struct devlink *devlink;
+	struct zxdh_irq_table irq_table;
 	void *priv;
 };

@@ -118,4 +121,9 @@ int zxdh_pf_device_cfg_init(struct zxdh_core_dev *zxdh_dev);
 void zxdh_pf_modern_cfg_uninit(struct zxdh_core_dev *zxdh_dev);
 int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev);

+/* PF IRQ table (en_pf.c) */
+int zxdh_pf_irq_table_init(struct zxdh_core_dev *zxdh_dev);
+void zxdh_pf_irq_table_destroy(struct zxdh_core_dev *zxdh_dev);
+struct zxdh_irq *zxdh_pf_async_irq_request(struct zxdh_core_dev *zxdh_dev);
+
 #endif /* __ZXDH_EN_PF_H__ */
diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_irq.c b/drivers/net/ethernet/zte/dinghai/zxdh_irq.c
new file mode 100644
index 000000000000..bc5348dfa5ba
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/zxdh_irq.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE DingHai Ethernet driver - IRQ pool management
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ *
+ * Device vectors are managed in per-purpose pools. An IRQ carries a
+ * refcount so that several event queues can share one vector; on
+ * raise, the interrupt is fanned out through an atomic notifier chain
+ * attached to the IRQ.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/xarray.h>
+
+#include "en_pf.h"
+#include "zxdh_irq.h"
+
+static void zxdh_cpu_put(struct zxdh_irq_pool *pool, int cpu)
+{
+	pool->irqs_per_cpu[cpu]--;
+}
+
+/* Release callback of the IRQ kref, called with pool->lock held. */
+static void zxdh_irq_release(struct kref *kref)
+{
+	struct zxdh_irq *irq = container_of(kref, struct zxdh_irq, refcount);
+	struct zxdh_irq_pool *pool = irq->pool;
+
+	lockdep_assert_held(&pool->lock);
+	xa_erase(&pool->irqs, irq->index);
+	zxdh_cpu_put(pool, cpumask_first(irq->mask));
+	/* free_irq() requires the affinity hint to be cleared before it is
+	 * called; the asymmetry with the set path in zxdh_irq_alloc() is
+	 * intentional.
+	 */
+	irq_update_affinity_hint(irq->irqn, NULL);
+	free_cpumask_var(irq->mask);
+	free_irq(irq->irqn, irq);
+	kfree(irq);
+}
+
+/* Drop one reference; returns 1 if the IRQ was released. */
+static int zxdh_irq_put(struct zxdh_irq *irq)
+{
+	struct zxdh_irq_pool *pool = irq->pool;
+	int released;
+
+	mutex_lock(&pool->lock);
+	released = kref_put(&irq->refcount, zxdh_irq_release);
+	mutex_unlock(&pool->lock);
+
+	return released;
+}
+
+static int zxdh_irq_get(struct zxdh_irq *irq)
+{
+	return kref_get_unless_zero(&irq->refcount);
+}
+
+static irqreturn_t zxdh_irq_int_handler(int irq, void *data)
+{
+	struct zxdh_irq *zxdh_irq = data;
+
+	atomic_notifier_call_chain(&zxdh_irq->nh, 0, NULL);
+
+	return IRQ_HANDLED;
+}
+
+static struct zxdh_irq *zxdh_irq_alloc(struct zxdh_irq_pool *pool, int vecidx,
+				       const struct cpumask *affinity)
+{
+	struct zxdh_core_dev *zxdh_dev = pool->dev;
+	struct zxdh_irq *irq;
+	int err;
+	int cpu;
+
+	irq = kzalloc_obj(*irq, GFP_KERNEL);
+	if (!irq)
+		return ERR_PTR(-ENOMEM);
+
+	irq->pool = pool;
+	irq->irqn = pci_irq_vector(zxdh_dev->pdev, vecidx);
+	if (irq->irqn < 0) {
+		err = irq->irqn;
+		goto err_irqn;
+	}
+
+	ATOMIC_INIT_NOTIFIER_HEAD(&irq->nh);
+	snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "%s_%d@pci:%s", pool->name,
+		 vecidx, pci_name(zxdh_dev->pdev));
+
+	err = request_irq(irq->irqn, zxdh_irq_int_handler, 0, irq->name, irq);
+	if (err) {
+		dev_err(zxdh_dev->device, "request_irq failed: %d\n", err);
+		goto err_irqn;
+	}
+
+	if (!zalloc_cpumask_var(&irq->mask, GFP_KERNEL)) {
+		dev_err(zxdh_dev->device, "zalloc_cpumask_var failed\n");
+		err = -ENOMEM;
+		goto err_cpumask;
+	}
+
+	if (affinity) {
+		cpumask_copy(irq->mask, affinity);
+	} else {
+		/* No preference requested; spread over all online CPUs. */
+		for_each_online_cpu(cpu)
+			cpumask_set_cpu(cpu, irq->mask);
+	}
+	irq_set_affinity_and_hint(irq->irqn, irq->mask);
+
+	kref_init(&irq->refcount);
+	irq->index = vecidx;
+	err = xa_err(xa_store(&pool->irqs, irq->index, irq, GFP_KERNEL));
+	if (err) {
+		dev_err(zxdh_dev->device, "xa_store failed for irq %u: %d\n",
+			irq->index, err);
+		goto err_xa;
+	}
+
+	return irq;
+
+err_xa:
+	irq_update_affinity_hint(irq->irqn, NULL);
+	free_cpumask_var(irq->mask);
+err_cpumask:
+	free_irq(irq->irqn, irq);
+err_irqn:
+	kfree(irq);
+	return ERR_PTR(err);
+}
+
+int zxdh_irq_attach_nb(struct zxdh_irq *irq, struct notifier_block *nb)
+{
+	int err;
+
+	if (!zxdh_irq_get(irq))
+		return -ENOENT;
+
+	err = atomic_notifier_chain_register(&irq->nh, nb);
+	if (err)
+		zxdh_irq_put(irq);
+
+	return err;
+}
+
+int zxdh_irq_detach_nb(struct zxdh_irq *irq, struct notifier_block *nb)
+{
+	int err;
+
+	err = atomic_notifier_chain_unregister(&irq->nh, nb);
+	zxdh_irq_put(irq);
+
+	return err;
+}
+
+/* Release one or more IRQs back to their pool. */
+void zxdh_irqs_release_vectors(struct zxdh_irq **irqs, int nirqs)
+{
+	int i;
+
+	for (i = 0; i < nirqs; i++) {
+		synchronize_irq(irqs[i]->irqn);
+		zxdh_irq_put(irqs[i]);
+	}
+}
+
+static void zxdh_cpu_get(struct zxdh_irq_pool *pool, int cpu)
+{
+	pool->irqs_per_cpu[cpu]++;
+}
+
+/* Find the least loaded CPU, i.e. the CPU with the fewest IRQs bound
+ * to it, within the requested mask.
+ */
+static int zxdh_cpu_get_least_loaded(struct zxdh_irq_pool *pool,
+				     const struct cpumask *req_mask)
+{
+	int best_cpu = -1;
+	int cpu;
+
+	for_each_cpu_and(cpu, req_mask, cpu_online_mask) {
+		/* This CPU has no IRQs yet, no need to look further. */
+		if (!pool->irqs_per_cpu[cpu]) {
+			best_cpu = cpu;
+			break;
+		}
+		if (best_cpu < 0)
+			best_cpu = cpu;
+		if (pool->irqs_per_cpu[cpu] < pool->irqs_per_cpu[best_cpu])
+			best_cpu = cpu;
+	}
+
+	if (best_cpu < 0) {
+		dev_err(pool->dev->device,
+			"no online CPU in affinity mask (%*pbl)\n",
+			cpumask_pr_args(req_mask));
+		best_cpu = cpumask_first(cpu_online_mask);
+	}
+	pool->irqs_per_cpu[best_cpu]++;
+
+	return best_cpu;
+}
+
+/* Create a new IRQ from the pool and bind it to the requested mask. */
+static struct zxdh_irq *zxdh_irq_pool_request_irq(struct zxdh_irq_pool *pool,
+						  const struct cpumask *req_mask)
+{
+	const struct cpumask *affinity = req_mask;
+	cpumask_var_t auto_mask;
+	struct zxdh_irq *irq;
+	u32 irq_index;
+	int err;
+
+	if (!zalloc_cpumask_var(&auto_mask, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
+
+	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs,
+		       GFP_KERNEL);
+	if (err) {
+		if (err == -EBUSY)
+			err = -EUSERS;
+		goto err_xa;
+	}
+
+	if (cpumask_weight(req_mask) > 1) {
+		/* Bind to the least loaded CPU of the request. */
+		cpumask_set_cpu(zxdh_cpu_get_least_loaded(pool, req_mask),
+				auto_mask);
+		affinity = auto_mask;
+	} else {
+		zxdh_cpu_get(pool, cpumask_first(req_mask));
+	}
+
+	irq = zxdh_irq_alloc(pool, irq_index, affinity);
+	if (IS_ERR(irq))
+		goto err_alloc;
+
+	free_cpumask_var(auto_mask);
+
+	return irq;
+
+err_alloc:
+	/* Undo the per-CPU accounting done above. */
+	zxdh_cpu_put(pool, cpumask_first(affinity));
+	xa_erase(&pool->irqs, irq_index);
+err_xa:
+	free_cpumask_var(auto_mask);
+	return err ? ERR_PTR(err) : irq;
+}
+
+/* Look for the IRQ with the smallest refcount whose affinity mask is a
+ * subset of the requested mask.
+ */
+static struct zxdh_irq *zxdh_irq_pool_find_least_loaded(struct zxdh_irq_pool *pool,
+							const struct cpumask *req_mask)
+{
+	struct zxdh_irq *irq = NULL;
+	struct zxdh_irq *iter;
+	unsigned long index;
+	int iter_refcount;
+
+	lockdep_assert_held(&pool->lock);
+	xa_for_each_range(&pool->irqs, index, iter,
+			  pool->xa_num_irqs.min, pool->xa_num_irqs.max) {
+		iter_refcount = refcount_read(&iter->refcount.refcount);
+
+		/* Skip IRQs whose mask is not a subset of the request. */
+		if (!cpumask_subset(iter->mask, req_mask))
+			continue;
+		/* IRQ below the minimum threshold found, take it. */
+		if (iter_refcount < pool->min_threshold)
+			return iter;
+		if (!irq ||
+		    iter_refcount < refcount_read(&irq->refcount.refcount))
+			irq = iter;
+	}
+
+	return irq;
+}
+
+/* Request an IRQ for the given mask: share the least loaded existing
+ * matching IRQ once it passes the pool minimum threshold, otherwise
+ * create a new one.
+ */
+static struct zxdh_irq *zxdh_irq_affinity_request(struct zxdh_irq_pool *pool,
+						  const struct cpumask *req_mask)
+{
+	struct zxdh_irq *least_loaded_irq;
+	struct zxdh_irq *new_irq;
+
+	mutex_lock(&pool->lock);
+
+	least_loaded_irq = zxdh_irq_pool_find_least_loaded(pool, req_mask);
+	if (least_loaded_irq &&
+	    refcount_read(&least_loaded_irq->refcount.refcount) < pool->min_threshold)
+		goto out;
+
+	/* No IRQ below the minimum threshold, try to create a new one. */
+	new_irq = zxdh_irq_pool_request_irq(pool, req_mask);
+	if (IS_ERR(new_irq)) {
+		if (!least_loaded_irq) {
+			mutex_unlock(&pool->lock);
+			return new_irq;
+		}
+		/* Could not create a new IRQ for the requested affinity,
+		 * share the existing one.
+		 */
+		dev_warn(pool->dev->device,
+			 "irq pool %s exhausted, sharing irqs\n",
+			 pool->name);
+		goto out;
+	}
+
+	least_loaded_irq = new_irq;
+	goto unlock;
+
+out:
+	/* Holding pool->lock keeps the IRQ alive, so this cannot fail. */
+	zxdh_irq_get(least_loaded_irq);
+	if (refcount_read(&least_loaded_irq->refcount.refcount) > pool->max_threshold)
+		dev_warn(pool->dev->device,
+			 "irq %u overloaded, pool %s, %u refs on this irq\n",
+			 pci_irq_vector(pool->dev->pdev,
+					least_loaded_irq->index),
+			 pool->name,
+			 refcount_read(&least_loaded_irq->refcount.refcount) /
+			 ZXDH_EQ_REFS_PER_IRQ);
+unlock:
+	mutex_unlock(&pool->lock);
+
+	return least_loaded_irq;
+}
+
+/* Request an IRQ from the pool, spread over the online CPUs. */
+struct zxdh_irq *zxdh_get_irq_of_pool(struct zxdh_irq_pool *pool)
+{
+	cpumask_var_t req_mask;
+	struct zxdh_irq *irq;
+
+	if (!zalloc_cpumask_var(&req_mask, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
+	cpumask_copy(req_mask, cpu_online_mask);
+
+	irq = zxdh_irq_affinity_request(pool, req_mask);
+
+	free_cpumask_var(req_mask);
+
+	return irq;
+}
+
+struct zxdh_irq_pool *zxdh_irq_pool_alloc(struct zxdh_core_dev *zxdh_dev,
+					  int start, int size, const char *name,
+					  u32 min_threshold, u32 max_threshold)
+{
+	struct zxdh_irq_pool *pool;
+	u16 *irqs_per_cpu;
+
+	irqs_per_cpu = kcalloc(nr_cpu_ids, sizeof(*irqs_per_cpu), GFP_KERNEL);
+	if (!irqs_per_cpu)
+		return ERR_PTR(-ENOMEM);
+
+	pool = kvzalloc_obj(*pool, GFP_KERNEL);
+	if (!pool) {
+		kfree(irqs_per_cpu);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pool->dev = zxdh_dev;
+	pool->irqs_per_cpu = irqs_per_cpu;
+	mutex_init(&pool->lock);
+	xa_init_flags(&pool->irqs, XA_FLAGS_ALLOC);
+	pool->xa_num_irqs.min = start;
+	pool->xa_num_irqs.max = start + size - 1;
+	strscpy(pool->name, name, sizeof(pool->name));
+
+	/* Thresholds are expressed in queue references, two per IRQ. */
+	pool->min_threshold = min_threshold * ZXDH_EQ_REFS_PER_IRQ;
+	pool->max_threshold = max_threshold * ZXDH_EQ_REFS_PER_IRQ;
+
+	return pool;
+}
+
+void zxdh_irq_pool_free(struct zxdh_irq_pool *pool)
+{
+	u32 cpu;
+
+	WARN_ON_ONCE(!xa_empty(&pool->irqs));
+	xa_destroy(&pool->irqs);
+	mutex_destroy(&pool->lock);
+
+	if (pool->irqs_per_cpu) {
+		for_each_online_cpu(cpu)
+			WARN_ON(pool->irqs_per_cpu[cpu]);
+		kfree(pool->irqs_per_cpu);
+	}
+
+	kvfree(pool);
+}
diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_irq.h b/drivers/net/ethernet/zte/dinghai/zxdh_irq.h
new file mode 100644
index 000000000000..a969e04f3ce4
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/zxdh_irq.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE DingHai Ethernet driver - IRQ pool management
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#ifndef __ZXDH_IRQ_H__
+#define __ZXDH_IRQ_H__
+
+#include <linux/cpumask.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
+
+struct zxdh_core_dev;
+
+/* Number of MSI-X vectors per purpose. The layout of the vector space
+ * is a hardware interface:
+ *   [0, 8)    async event queues
+ *   [8, 14)   reserved for RDMA (unused for now)
+ *   [14, 78)  vq rx/tx queue pairs
+ */
+#define ZXDH_ASYNC_CHANNELS_NUM		8
+#define ZXDH_RDMA_CHANNELS_NUM		6
+#define ZXDH_VQS_CHANNELS_NUM		64
+
+#define ZXDH_MAX_IRQ_NAME	100
+#define ZXDH_MAX_POOL_NAME	16
+#define ZXDH_EQ_REFS_PER_IRQ	2
+
+/* Reference counted interrupt. Event queues share an IRQ through the
+ * notifier chain, which is fired from hard IRQ context.
+ */
+struct zxdh_irq {
+	struct atomic_notifier_head nh;
+	cpumask_var_t mask;		/* interrupt affinity */
+	char name[ZXDH_MAX_IRQ_NAME];
+	struct zxdh_irq_pool *pool;
+	u32 index;			/* vector index */
+	int irqn;			/* Linux IRQ number */
+	struct kref refcount;
+};
+
+/* Pool of vectors dedicated to one purpose, identified by the
+ * [xa_num_irqs.min, xa_num_irqs.max] vector range.
+ */
+struct zxdh_irq_pool {
+	char name[ZXDH_MAX_POOL_NAME];
+	struct xa_limit xa_num_irqs;
+	struct mutex lock;		/* serializes IRQ creation */
+	struct xarray irqs;
+	u32 min_threshold;		/* in queue references */
+	u32 max_threshold;		/* in queue references */
+	u16 *irqs_per_cpu;		/* number of IRQs bound per CPU */
+	struct zxdh_core_dev *dev;
+};
+
+struct zxdh_irq_table {
+	void *priv;
+};
+
+struct zxdh_irq *zxdh_get_irq_of_pool(struct zxdh_irq_pool *pool);
+int zxdh_irq_attach_nb(struct zxdh_irq *irq, struct notifier_block *nb);
+int zxdh_irq_detach_nb(struct zxdh_irq *irq, struct notifier_block *nb);
+void zxdh_irqs_release_vectors(struct zxdh_irq **irqs, int nirqs);
+struct zxdh_irq_pool *zxdh_irq_pool_alloc(struct zxdh_core_dev *zxdh_dev,
+					  int start, int size, const char *name,
+					  u32 min_threshold, u32 max_threshold);
+void zxdh_irq_pool_free(struct zxdh_irq_pool *pool);
+
+#endif /* __ZXDH_IRQ_H__ */
-- 
2.27.0
