Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DA3DEACB;
	Mon, 20 Jul 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542517; cv=none; b=PgF7EqN8cJdaswbRjIKOqIuFXLZK4+fF8yursCDtb92v/yLfriC1PbZQn7ijYHvIHdRDQ3JYxkD8ln67kptziPyFWvqlvDFnGNr7mlnXLunBDxoYsejQMWIcoC7XYtXd8FkM4yWMPvWjyuvESlZI2OXNezV/h6s0wWR2WcYQmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542517; c=relaxed/simple;
	bh=Mu/CFtyyFonl/BCxGpThL1LhlJ9a1jrMhd+zo6kwyQQ=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ivwDFZXQdInNKyQjjhl4H/ycMwI+5xxGRXTiuvv0tRcLlAXsxmkgQLT1L7SkCYS2Lg7YiBJdnM8VWb3i/h0p55715PzsdNuucBdXXF0DBCFN6JHkzv1WNvU+IiPTdVqqruUz/JT1FojW8/c3O5OVSMDSlesjm9cGlSrBMQqGKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4h3bwz1FFcz55y1s;
	Mon, 20 Jul 2026 18:14:59 +0800 (CST)
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl2.zte.com.cn with SMTP id 66KAEmhw098358;
	Mon, 20 Jul 2026 18:14:48 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 20 Jul 2026 18:14:50 +0800 (CST)
X-Zmail-TransId: 2afb6a5df51a1c6-51805
X-Mailer: Zmail v1.0
Message-ID: <202607201814508607WgwfRziVS5D44YN2_V69@zte.com.cn>
In-Reply-To: <20260720180651288d3b9DAp__Lfvo2x2PkMfC@zte.com.cn>
References: 20260720180651288d3b9DAp__Lfvo2x2PkMfC@zte.com.cn
Date: Mon, 20 Jul 2026 18:14:50 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY5IDIvMl0gZGluZ2hhaTogYWRkIGhhcmR3YXJlIHJlZ2lzdGVyIGFjY2VzcyBhbmQgUENJCiBjYXBhYmlsaXR5IHNjYW5uaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66KAEmhw098358
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 20 Jul 2026 18:14:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A5DF523.000/4h3bwz1FFcz55y1s

From: Junyang Han <han.junyang@zte.com.cn>

Implement PCI configuration space access, BAR mapping, capability
scanning (common/notify/device), and hardware queue register
definitions for DingHai PF device.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 drivers/net/ethernet/zte/dinghai/dh_queue.h |  54 ++++
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 270 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    |  49 ++++
 3 files changed, 373 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/dinghai/dh_queue.h

diff --git a/drivers/net/ethernet/zte/dinghai/dh_queue.h b/drivers/net/ethernet/zte/dinghai/dh_queue.h
new file mode 100644
index 000000000000..afac67f7147c
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/dh_queue.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE DingHai Ethernet driver - PCI capability definitions
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#ifndef __DH_QUEUE_H__
+#define __DH_QUEUE_H__
+
+/* This is the PCI capability header: */
+struct zxdh_pf_pci_cap {
+	__u8 cap_vndr;		/* Generic PCI field: PCI_CAP_ID_VNDR */
+	__u8 cap_next;		/* Generic PCI field: next ptr. */
+	__u8 cap_len;		/* Generic PCI field: capability length */
+	__u8 cfg_type;		/* Identifies the structure. */
+	__u8 bar;		/* Where to find it. */
+	__u8 id;		/* Multiple capabilities of the same type */
+	__u8 padding[2];		/* Pad to full dword. */
+	__le32 offset;		/* Offset within bar. */
+	__le32 length;		/* Length of the structure, in bytes. */
+};
+
+/* Fields in ZXDH_PF_PCI_CAP_COMMON_CFG: */
+struct zxdh_pf_pci_common_cfg {
+	/* About the whole device. */
+	__le32 device_feature_select; /* read-write */
+	__le32 device_feature;	/* read-only */
+	__le32 guest_feature_select; /* read-write */
+	__le32 guest_feature;		/* read-write */
+	__le16 msix_config;		/* read-write */
+	__le16 num_queues;		/* read-only */
+	__u8 device_status;		/* read-write */
+	__u8 config_generation;	/* read-only */
+
+	/* About a specific virtqueue. */
+	__le16 queue_select;		/* read-write */
+	__le16 queue_size;		/* read-write, power of 2. */
+	__le16 queue_msix_vector;	/* read-write */
+	__le16 queue_enable;		/* read-write */
+	__le16 queue_notify_off;	/* read-only */
+	__le32 queue_desc_lo;		/* read-write */
+	__le32 queue_desc_hi;		/* read-write */
+	__le32 queue_avail_lo;		/* read-write */
+	__le32 queue_avail_hi;		/* read-write */
+	__le32 queue_used_lo;		/* read-write */
+	__le32 queue_used_hi;		/* read-write */
+};
+
+struct zxdh_pf_pci_notify_cap {
+	struct zxdh_pf_pci_cap cap;
+	__le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
+};
+
+#endif /* __DH_QUEUE_H__ */
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index 27ab35d69920..ae5a77ddaca5 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.c
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -8,7 +8,9 @@
 #include <linux/pci.h>
 #include <net/devlink.h>
 #include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
 #include "en_pf.h"
+#include "dh_queue.h"

 MODULE_AUTHOR("Junyang Han <han.junyang@zte.com.cn>");
 MODULE_DESCRIPTION("ZTE DingHai series Ethernet driver");
@@ -110,6 +112,265 @@ void zxdh_pf_pci_close(struct zxdh_core_dev *zxdh_dev)
 	pci_disable_device(zxdh_dev->pdev);
 }

+int zxdh_pf_pci_find_capability(struct pci_dev *pdev, u8 cfg_type,
+				u32 ioresource_types, int *bars)
+{
+	int pos;
+	u8 type;
+	u8 bar;
+
+	for (pos = pci_find_capability(pdev, PCI_CAP_ID_VNDR); pos > 0;
+	     pos = pci_find_next_capability(pdev, pos, PCI_CAP_ID_VNDR)) {
+		pci_read_config_byte(pdev,
+				     pos + offsetof(struct zxdh_pf_pci_cap,
+							cfg_type), &type);
+		pci_read_config_byte(pdev,
+				     pos + offsetof(struct zxdh_pf_pci_cap, bar), &bar);
+
+		/* ignore structures with reserved BAR values */
+		if (bar > ZXDH_PF_MAX_BAR_VAL)
+			continue;
+
+		if (type == cfg_type) {
+			if (pci_resource_len(pdev, bar) &&
+			    pci_resource_flags(pdev, bar) & ioresource_types) {
+				*bars |= (1 << bar);
+				return pos;
+			}
+		}
+	}
+
+	return 0;
+}
+
+void __iomem *zxdh_pf_map_capability(struct zxdh_core_dev *zxdh_dev, int off,
+				     size_t minlen, u32 align,
+				     u32 start, u32 size,
+				     size_t *len, resource_size_t *pa,
+				     u32 *bar_off)
+{
+	struct pci_dev *pdev = zxdh_dev->pdev;
+	void __iomem *p;
+	u32 offset;
+	u32 length;
+	u8 bar;
+
+	pci_read_config_byte(pdev,
+			     off + offsetof(struct zxdh_pf_pci_cap, bar), &bar);
+	pci_read_config_dword(pdev,
+			      off + offsetof(struct zxdh_pf_pci_cap,
+						offset), &offset);
+	pci_read_config_dword(pdev,
+			      off + offsetof(struct zxdh_pf_pci_cap,
+						length), &length);
+
+	if (bar_off)
+		*bar_off = offset;
+
+	if (length <= start) {
+		dev_err(zxdh_dev->device, "bad capability len %u (>%u expected)\n",
+			length, start);
+		return NULL;
+	}
+
+	if (length - start < minlen) {
+		dev_err(zxdh_dev->device, "bad capability len %u (>=%zu expected)\n",
+			length, minlen);
+		return NULL;
+	}
+
+	length -= start;
+	if (start + offset < offset) {
+		dev_err(zxdh_dev->device, "map wrap-around %u+%u\n", start, offset);
+		return NULL;
+	}
+
+	offset += start;
+	if (offset & (align - 1)) {
+		dev_err(zxdh_dev->device, "offset %u not aligned to %u\n", offset, align);
+		return NULL;
+	}
+
+	if (length > size)
+		length = size;
+
+	if (len)
+		*len = length;
+
+	if (minlen + offset < minlen ||
+	    minlen + offset > pci_resource_len(pdev, bar)) {
+		dev_err(zxdh_dev->device,
+			"map custom queue %zu@%u out of range on bar %u length %lu\n",
+			minlen, offset, bar,
+			(unsigned long)pci_resource_len(pdev, bar));
+		return NULL;
+	}
+
+	p = pci_iomap_range(pdev, bar, offset, length);
+	if (!p) {
+		dev_err(zxdh_dev->device, "unable to map custom queue %u@%u on bar %u\n",
+			length, offset, bar);
+	} else if (pa) {
+		*pa = pci_resource_start(pdev, bar) + offset;
+	}
+
+	return p;
+}
+
+int zxdh_pf_common_cfg_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct pci_dev *pdev = zxdh_dev->pdev;
+	int common;
+
+	/* check for a common config: if not, use legacy mode (bar 0). */
+	common = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_COMMON_CFG,
+					     IORESOURCE_IO | IORESOURCE_MEM,
+					     &pf_dev->modern_bars);
+	if (!common) {
+		dev_err(zxdh_dev->device,
+			"missing capabilities, leaving for legacy driver\n");
+		return -ENODEV;
+	}
+
+	pf_dev->common = zxdh_pf_map_capability(zxdh_dev, common,
+						sizeof(struct zxdh_pf_pci_common_cfg),
+						ZXDH_PF_ALIGN4, 0,
+						sizeof(struct zxdh_pf_pci_common_cfg),
+						NULL, NULL, NULL);
+	if (!pf_dev->common) {
+		dev_err(zxdh_dev->device, "pf_dev->common is null\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int zxdh_pf_notify_cfg_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct pci_dev *pdev = zxdh_dev->pdev;
+	u32 notify_length;
+	u32 notify_offset;
+	int notify;
+
+	/* If common is there, these should be too... */
+	notify = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_NOTIFY_CFG,
+					     IORESOURCE_IO | IORESOURCE_MEM,
+					     &pf_dev->modern_bars);
+	if (!notify) {
+		dev_err(zxdh_dev->device, "missing notify cfg capability\n");
+		return -EINVAL;
+	}
+
+	pci_read_config_dword(pdev,
+			      notify + offsetof(struct zxdh_pf_pci_notify_cap,
+				notify_off_multiplier),
+		&pf_dev->notify_offset_multiplier);
+	pci_read_config_dword(pdev,
+			      notify + offsetof(struct zxdh_pf_pci_notify_cap,
+				cap.length), &notify_length);
+	pci_read_config_dword(pdev,
+			      notify + offsetof(struct zxdh_pf_pci_notify_cap,
+				cap.offset), &notify_offset);
+
+	/* We don't know how many VQs we'll map, ahead of the time.
+	 * If notify length is small, map it all now. Otherwise,
+	 * map each VQ individually later.
+	 */
+	if (notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
+		pf_dev->notify_base = zxdh_pf_map_capability(zxdh_dev, notify,
+							     ZXDH_PF_MAP_MINLEN2,
+							    ZXDH_PF_ALIGN2, 0,
+							    notify_length,
+							    &pf_dev->notify_len,
+							    &pf_dev->notify_pa, NULL);
+		if (!pf_dev->notify_base) {
+			dev_err(zxdh_dev->device, "pf_dev->notify_base is null\n");
+			return -EINVAL;
+		}
+	} else {
+		pf_dev->notify_map_cap = notify;
+	}
+
+	return 0;
+}
+
+int zxdh_pf_device_cfg_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct pci_dev *pdev = zxdh_dev->pdev;
+	int device;
+
+	/* Device capability is only mandatory for
+	 * devices that have device-specific configuration.
+	 */
+	device = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_DEVICE_CFG,
+					     IORESOURCE_IO | IORESOURCE_MEM,
+					     &pf_dev->modern_bars);
+
+	/* we don't know how much we should map,
+	 * but PAGE_SIZE is more than enough for all existing devices.
+	 */
+	if (device) {
+		pf_dev->device = zxdh_pf_map_capability(zxdh_dev, device, 0,
+							ZXDH_PF_ALIGN4, 0, PAGE_SIZE,
+						       &pf_dev->device_len, NULL,
+						       &pf_dev->dev_cfg_bar_off);
+		if (!pf_dev->device) {
+			dev_err(zxdh_dev->device, "pf_dev->device is null\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+void zxdh_pf_modern_cfg_uninit(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct pci_dev *pdev = zxdh_dev->pdev;
+
+	if (pf_dev->device)
+		pci_iounmap(pdev, pf_dev->device);
+	if (pf_dev->notify_base)
+		pci_iounmap(pdev, pf_dev->notify_base);
+	pci_iounmap(pdev, pf_dev->common);
+}
+
+int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct pci_dev *pdev = zxdh_dev->pdev;
+	int ret;
+
+	ret = zxdh_pf_common_cfg_init(zxdh_dev);
+	if (ret) {
+		dev_err(zxdh_dev->device, "zxdh_pf_common_cfg_init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = zxdh_pf_notify_cfg_init(zxdh_dev);
+	if (ret) {
+		dev_err(zxdh_dev->device, "zxdh_pf_notify_cfg_init failed: %d\n", ret);
+		goto err_map_notify;
+	}
+
+	ret = zxdh_pf_device_cfg_init(zxdh_dev);
+	if (ret) {
+		dev_err(zxdh_dev->device, "zxdh_pf_device_cfg_init failed: %d\n", ret);
+		goto err_map_device;
+	}
+
+	return 0;
+
+err_map_device:
+	if (pf_dev->notify_base)
+		pci_iounmap(pdev, pf_dev->notify_base);
+err_map_notify:
+	pci_iounmap(pdev, pf_dev->common);
+	return ret;
+}
+
 static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct zxdh_pf_dev *pf_dev;
@@ -146,6 +407,12 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = zxdh_pf_pci_init(zxdh_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "zxdh_pf_pci_init failed: %d\n", ret);
+		goto err_pf_init;
+	}
+
+	ret = zxdh_pf_modern_cfg_init(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_modern_cfg_init failed: %d\n", ret);
 		goto err_cfg_init;
 	}

@@ -154,6 +421,8 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;

 err_cfg_init:
+	zxdh_pf_pci_close(zxdh_dev);
+err_pf_init:
 	mutex_destroy(&pf_dev->irq_lock);
 	mutex_destroy(&zxdh_dev->lock);
 	zxdh_core_free_priv(zxdh_dev);
@@ -169,6 +438,7 @@ static void zxdh_pf_remove(struct pci_dev *pdev)
 	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;

 	devlink_unregister(devlink);
+	zxdh_pf_modern_cfg_uninit(zxdh_dev);
 	zxdh_pf_pci_close(zxdh_dev);
 	mutex_destroy(&pf_dev->irq_lock);
 	mutex_destroy(&zxdh_dev->lock);
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
index 65eac936505b..58c5da9a09ff 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.h
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -17,6 +17,24 @@
 #define ZXDH_PF_DEVICE_ID	0x8040
 #define ZXDH_VF_DEVICE_ID	0x8041

+/* Common configuration */
+#define ZXDH_PCI_CAP_COMMON_CFG	1
+/* Notifications */
+#define ZXDH_PCI_CAP_NOTIFY_CFG	2
+/* ISR access */
+#define ZXDH_PCI_CAP_ISR_CFG		3
+/* Device specific configuration */
+#define ZXDH_PCI_CAP_DEVICE_CFG	4
+/* PCI configuration access */
+#define ZXDH_PCI_CAP_PCI_CFG		5
+
+#define ZXDH_PF_MAX_BAR_VAL		0x5
+#define ZXDH_PF_ALIGN4			4
+#define ZXDH_PF_ALIGN2			2
+#define ZXDH_PF_MAP_MINLEN2		2
+
+#define ZXDH_DEV_MAC_HIGH_OFFSET	4
+
 enum zxdh_coredev_type {
 	DH_COREDEV_PF,
 	DH_COREDEV_VF,
@@ -36,7 +54,26 @@ struct zxdh_core_dev {
 };

 struct zxdh_pf_dev {
+	struct zxdh_pf_pci_common_cfg __iomem *common;
+	/* Device-specific data (non-legacy mode)  */
+	/* Base of vq notifications (non-legacy mode). */
+	void __iomem *device;
+	void __iomem *notify_base;
+	void __iomem *pf_sriov_cap_base;
+	/* Physical base of vq notifications */
+	resource_size_t notify_pa;
+	/* So we can sanity-check accesses. */
+	size_t notify_len;
+	size_t device_len;
+	/* Capability for when we need to map notifications per-vq. */
+	s32 notify_map_cap;
+	u32 notify_offset_multiplier;
+	/* Multiply queue_notify_off by this value. (non-legacy mode). */
+	s32 modern_bars;
 	void __iomem *pci_ioremap_addr[6];
+	u64 sriov_bar_size;
+	u32 dev_cfg_bar_off;
+	bool packed_status;
 	bool bar_chan_valid;
 	bool vepa;
 	struct mutex irq_lock; /* Protects IRQ operations */
@@ -48,5 +85,17 @@ struct zxdh_pf_dev {
 void *zxdh_core_alloc_priv(struct zxdh_core_dev *zxdh_dev, size_t size);
 void zxdh_core_free_priv(struct zxdh_core_dev *zxdh_dev);
 void zxdh_pf_pci_close(struct zxdh_core_dev *zxdh_dev);
+int zxdh_pf_pci_find_capability(struct pci_dev *pdev, u8 cfg_type,
+				u32 ioresource_types, int *bars);
+void __iomem *zxdh_pf_map_capability(struct zxdh_core_dev *zxdh_dev, int off,
+				     size_t minlen, u32 align,
+				     u32 start, u32 size,
+				     size_t *len, resource_size_t *pa,
+				     u32 *bar_off);
+int zxdh_pf_common_cfg_init(struct zxdh_core_dev *zxdh_dev);
+int zxdh_pf_notify_cfg_init(struct zxdh_core_dev *zxdh_dev);
+int zxdh_pf_device_cfg_init(struct zxdh_core_dev *zxdh_dev);
+void zxdh_pf_modern_cfg_uninit(struct zxdh_core_dev *zxdh_dev);
+int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev);

 #endif /* __ZXDH_EN_PF_H__ */
-- 
2.27.0
