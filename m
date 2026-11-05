Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793865396;
	b=TqjmXHJdt+po/Ncaz9h59Bk+Ct+WZW1Me0Wd1E8k/eozACC3IqS1Etfo2U4vgRUY7H/j
	 bKWLM/VKni0qwDzKo8y6F3WCUFVyyALretgg9viJlaMa6/cM1jf2CkvWoLl5dA1DQzq8I
	 TXKOyKhCtaWQn7FXakMR6vO1DLTqVU+EPyUywayUJDUvY6MMeZLgoAmsUdEoPcwuIVcQb
	 ckUjokGDVHIwLly9P8aYMbssZ11dKyoUgqKNrEJYdcgTFArQ0RC72Nv7KgcplW6cNnGJP
	 0MeWIQwNN5M/lrZxUSIDbe0d6LYlKXO6GauADK3dLFoyGy2Ax5eBZiufozRRJcNW4uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865396;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=d+cEXz8UxGPuqQ5Mf2QjoAOu8C3Tu/pSpc0uPcOqFz4=;
	b=sv3EAI2JoqnbaBsEp4/Dp9oqsAJCnJGzevrJVZYy8fY6W2NXcXe5t0i+iOhe/W6ZiSJU
	 uncrlbpXrZzhY5fkka+XTWTdXJ3In4hPKjuL8JEtRevuUX/mVbs81+zakFj5nOaovP5T+
	 MiNdBvJ8fqce7GDjZ05wDlfyTnSvmK71wPyucDIqUnehga5jC8MZVpe/8uvsr1JFXqh74
	 wIt/6lCleb3sUQy6uay3YdYBrhtA4cMBCY+zPELyJWaGGm/OEfbPbOFbj5jZuO1Gie0D0
	 zG0LpfjBX/edZqMHLrVUdli7XGJIJ037vV7HRAv7bk6GnSmykm6mtjsbUiP4WZOwI0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zel3JzDq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48E606A31B;
	Thu,  5 Nov 2026 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zel3JzDq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793865395;
	b=lWNi/GZ7JyG+pVT7ur6gIYEtmT7jw/W8qxZ+YgNXfGf8xwHZI+lqvdHevQGWTwKnHpEx
	 0xKyw/BKTBoazgTAtEQqPfZfwGAKdEbQZlZGTbzEeERyvGbewK4l/pBEmRx+Uheen2ZhL
	 AvEnQ28PbrWdWw1iz2rtTFdZn43MCyv90oMtpyrtIFtEZglrgl7E1yKRatoRQYUOyp6+n
	 IxRClyIgDzI2/xak6yPCIsW5MeLJBZkPananSE6+GXH5b9cWC7jFqvdpDLQzLKpGb6LJZ
	 JFtL4RqadQx3zWIcpdMcidjhGgRl31RcDzH80bcokRA9W+6lKXdc58CxidOph8HOTzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793865395;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=d+cEXz8UxGPuqQ5Mf2QjoAOu8C3Tu/pSpc0uPcOqFz4=;
	b=oVBdV2FTB8MVjXelJ9tF0gFDz/oKp5R7uvtpETTEv8ILPKkPsVCa/gGUlNhH/2E9Sfq3
	 ShDwcTVkQK6qw24MHwcRvyKO1mH1wyu0MecT55oLfNN994qeMEREBFfzqPv87evyn9/eg
	 rXpJJTKLxPaLYUaPT/8yUFXJBNmEuTOo0Sub3VtvKgxGWxNeA2tfLWm8aVv3HkCxXhWpz
	 M1fuE2OZWXNbE/15hfpyCyNbnAWXp6Y/xc2qGBCTkh2diBQ9Ys/trOD+6oBEmpSrmDI0r
	 PYtMqfGIKEHEKoOBwTJosxBxJ/r8HvcQX79ggUPtY/RUq9Bd7Kwd4/PwMY0EM4hTv1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 853061F0093A;
	Thu,  5 Nov 2026 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793865395;
	bh=d+cEXz8UxGPuqQ5Mf2QjoAOu8C3Tu/pSpc0uPcOqFz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Zel3JzDqodF0nGiBeCjbXvs4FCxZur/6TqWOJxL5uMIblqWgENckAqpN7d3qwvNwY
	 RqYjursG0EWgQpfNVyNO10iacDghMiPIAe7tScStdaNzRiXsIaWV+7rJiLQ01BVVwl
	 C/NKdSQ64A7p6U+nAu+zfXTYRSk+RMOq255aCNuuJEyI4DuRxW49AXhCKEN6NaiJpZ
	 0V4O1eEB6X0Vp9+yB6RRvxiz111YUSbwMyAJWWnAQ31+7jPmVd2FA11hKWL1zm8xUr
	 Vq8jjUgrpOlAmiPGq/dcHD8kg1+uukjg5mahONF30E6s99DGc90YL6uxxkex0tH76L
	 nSWZzdyMQPsuQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 07F454715D;
	Thu,  5 Nov 2026 07:56:34 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Thu, 05 Nov 2026 15:56:28 +0800
Subject: [PATCH v11 2/6] net: wwan: t9xx: Add control plane transaction
 layer framework
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-t9xx_driver_v1-v11-2-2084aa512864@compal.com>
References: <20261105-t9xx_driver_v1-v11-0-2084aa512864@compal.com>
In-Reply-To: <20261105-t9xx_driver_v1-v11-0-2084aa512864@compal.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793865391; l=4974;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=bZSBCrepq6pzXVTWgSsPcjFEwaLd8BCjmEh0yOmNpvo=;
 b=d62eTKghqpXgcUJGyskYwgawcj1LD6sZT+Na7KiyMj8sEMHV4C+yE4DSv71uNMjkUAZd/WYnh
 +K77rL4XSq8APH3dDQkCOnNCXcyorHMZB9aGcClkBp5e7DgBHnFcXjd
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com
Content-Transfer-Encoding: 7bit

From: Jack Wu <jackbb_wu@compal.com>

Introduce the control plane and transaction layer framework
for the T9XX WWAN driver. This patch adds the core data
structures (mtk_ctrl_blk, mtk_ctrl_trans) and initialization
entry points that subsequent patches build upon.

The control plane block (ctrl_blk) serves as the central
context for managing the transaction layer, port layer, and
FSM interactions. The actual DMA engine and TX/RX service
implementations are added in subsequent patches, and
mtk_ctrl_init() and mtk_ctrl_exit() get their first callers
there, in pcie/mtk_trans_ctrl.c.

Signed-off-by: Jack Wu <jackbb_wu@compal.com>
---
 drivers/net/wwan/t9xx/Makefile              |  1 +
 drivers/net/wwan/t9xx/mtk_ctrl_plane.c      | 46 +++++++++++++++++++++++++++++
 drivers/net/wwan/t9xx/mtk_ctrl_plane.h      | 21 +++++++++++++
 drivers/net/wwan/t9xx/mtk_dev.h             |  3 ++
 drivers/net/wwan/t9xx/pcie/mtk_pci.c        |  1 +
 drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h | 19 ++++++++++++
 6 files changed, 91 insertions(+)

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
index 000000000000..81f6b3fbc0bd
--- /dev/null
+++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
@@ -0,0 +1,46 @@
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
+ * associated with @mdev.  Runs once per bind; the allocation is
+ * devres managed and is released at unbind, not by
+ * mtk_ctrl_exit().
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
index 000000000000..46f1ab9f0551
--- /dev/null
+++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022, MediaTek Inc.
+ */
+
+#ifndef __MTK_CTRL_PLANE_H__
+#define __MTK_CTRL_PLANE_H__
+
+#include <linux/skbuff.h>
+
+#include "mtk_dev.h"
+
+struct mtk_ctrl_blk {
+	struct mtk_md_dev *mdev;
+	void *ctrl_hw_priv;
+};
+
+int mtk_ctrl_init(struct mtk_md_dev *mdev);
+void mtk_ctrl_exit(struct mtk_md_dev *mdev);
+
+#endif /* __MTK_CTRL_PLANE_H__ */
diff --git a/drivers/net/wwan/t9xx/mtk_dev.h b/drivers/net/wwan/t9xx/mtk_dev.h
index fc25418bb957..ff3cbaa4329e 100644
--- a/drivers/net/wwan/t9xx/mtk_dev.h
+++ b/drivers/net/wwan/t9xx/mtk_dev.h
@@ -28,12 +28,15 @@ enum mtk_dev_evt_d2h {
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
index 902bcbe1512e..27785092b2f7 100644
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
index 000000000000..9b42f33bd008
--- /dev/null
+++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022, MediaTek Inc.
+ */
+
+#ifndef __MTK_TRANS_CTRL_H__
+#define __MTK_TRANS_CTRL_H__
+
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "mtk_dev.h"
+
+struct mtk_ctrl_trans {
+	struct mtk_md_dev *mdev;
+};
+
+#endif

-- 
2.34.1


