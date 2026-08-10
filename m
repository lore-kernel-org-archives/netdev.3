Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D9390C85
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338885; cv=none; b=YzG9fVe0ERdgkcNAWaURPixSZeJmek3ZawMja+5RbZUeKhe5yr/0hr4vsmNjXzLfOUupJBi1jeuqcRGjJspEMBnHT0SZ2FcDIfnYzhxotjOi5sRA1voI0b254BoVgQjfoukhSJL96WASubsIY9MQzVCP6y71Ne7vnLugLiy+cRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338885; c=relaxed/simple;
	bh=eCssZys0Hn6a4+ZLYncsAF1JZfudlQz2mvC+Ys50qC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkfAkAAlVvc3sMbrRftK/wrnsD1itTBjfzTX5moZWreoxCf925K6SM3JV3lUbKOsMezovuafdw9dYYWQzZwGZ5vD9QIfjXYtcdKaOihzPmtba7GyIvz+3HX1i412wWH4o3ZS/5XErF2UPbQOjHfol8qbJpmtClnh6qVaEB90+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S/4lP5OE; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S/4lP5OE"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1944807a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338883; x=1786943683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hzn58ICnunINZQSBCbPlBNIGjo8oSCyrNMdluBbATs=;
        b=s0rjSk+0vMR/qnCNjKkSLbTekZaf8nQNjd93imttJGm6q00kQlTyNF+T8hfnD6w3+d
         AL+9t52Xh6CKYlJLwngVF2egjvZyttiPzf+vlFkDX3cdFJ8CcKQdsMlKy9N+xBWrQfUQ
         gT/yu68kSMnnAL71kKuarrH23HIo/emv5qLBcMkHTc5UrEMPy2fXjP/1vXDxEo2bTXXY
         1ARTYylK2Tp0uo9CPSztMbeFSafQPFqKtyVHqJd6mkt933RUiIyf7DjcdH0PuZmAt7uk
         vlDFXzMEZHmhO9XLZLFdLWAvDYWQFORIgMJvLnExpjNzCKJ6yVHK0HXlqwAI2p7q+qAv
         8ZtQ==
X-Gm-Message-State: AOJu0YwtEupMl1pK5DhJDnLdI6/LfxX/Y51sZgbXmYp6De4gjdm0wWXa
	LByuOteG9mFyNKDQpnjWo7m7NwCcRTceYcfKq5hm+0V/Y1/ZjE6ogjsHS01EUSPMSTjrhxuYUzv
	iaIJjK1iVIRbPEgxF95CXAigUBVcF8/DycfjVSBjX2Mk49KA7S2/nGSMcnlk9EaOcE0nfpCMzyQ
	j5SC+vQLOYcyRLqjXTgQ4n7UMz8h0+fR1koIkaOZSiza8OkvcGfKFtwv7N785TZXaUgvHvTqYxl
	jBTf/gGUdk=
X-Gm-Gg: AR+sD12uoiXL3xFtgyT15u6SmMC+VKl+q59yd3wLUN3u1QAxAmcvnWTAChJFeTBJRm8
	RMMDaEPMX6M/g7+bjpGQq25MWcq8RLe/55meZ3On8RR4vW4R/kngjpKAm5sDT9rjAEgKTBQh1DJ
	lMO2ESfShr1WZAL1JDHpn0oqgdkkcdDlU72QsB+/YXvEgA3bEsBSzXdZiRPpI/pxjhqkzGNHGs7
	RF8KyAAcZhv0WuApXiTyIRF9BAjP4QToQF+u98tJvrxPwVq+hasymXyxPgwWFJ2kOxqH1Eh+gB/
	fm6108rVlCIlw1vLuPicfI78Ets56dwSciz0ogr5TmuOzbl826gahLNX9c7d5eQyk/SG5Us3A7O
	U2xup4Mh0ozam5F6eZjzcZ5hfsgOsBxfpFK+SPTJgDcl22rjtCqOijr/NCbRey3z+/EeAPN3qhg
	TnhYQbkIdnLvKged/rQnTriKYdgQLFQA0jIOo=
X-Received: by 2002:a17:90b:52c4:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-392620e70b5mr23926471a91.10.1786338882801;
        Sun, 09 Aug 2026 22:14:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3925fe8ee28sm4885705a91.3.2026.08.09.22.14.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bf321d786so18868861cf.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338881; x=1786943681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hzn58ICnunINZQSBCbPlBNIGjo8oSCyrNMdluBbATs=;
        b=S/4lP5OEdmPOKikZbX/cBXyfYmwQoYk7nZnnBBjy+XoL5mEB4moKHjTHcsPefsNelh
         o3iefJ9x9px506uJMnQ7+cJqsRaZ/F+fkodnrVDJoYk0Vc7W6mT5X/wsd8ppY8Nwg3BV
         Q219weWFUtM90BRm26kadgvL6mwXyCjNb7D5k=
X-Received: by 2002:a05:622a:356:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52d18e1a65fmr208417421cf.5.1786338881424;
        Sun, 09 Aug 2026 22:14:41 -0700 (PDT)
X-Received: by 2002:a05:622a:356:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52d18e1a65fmr208417191cf.5.1786338880954;
        Sun, 09 Aug 2026 22:14:40 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:39 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v6 01/15] bnxt_en: Add Midpath channel information
Date: Sun,  9 Aug 2026 22:13:44 -0700
Message-ID: <20260810051358.1244418-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810051358.1244418-1-michael.chan@broadcom.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Midpath channels (MPCs) are rings for hardware control paths.  These
control paths are used to offload kTLS directly to the hardware
without going through firmware.  This patch adds the basic information
structures for these MPCs.

An MPC is basically a TX and completion ring pair with a HW TLS block
as the destination.  Two MPC channel types are used to offload
connections to the TX crypto engine (TCE) and the RX crypto
engine (RCE) respectively.  In the driver, we re-use the
bnxt_tx_ring_info and bnxt_cp_ring_info control structs for the MPCs.

This patch also adds the CONFIG_BNXT_TLS Kconfig option to conditionally
include the MPC logic.  The first few patches in the series add the MPC
support.  kTLS support will be added later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v6:
Make sure mpc capability is only updated during reset or ifdown/up.
---
 drivers/net/ethernet/broadcom/Kconfig         |  9 ++++
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 12 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 26 ++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 47 +++++++++++++++++++
 6 files changed, 97 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index f0bac0dd1439..b33b66f038b8 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -255,6 +255,15 @@ config BNXT_HWMON
 	  Say Y if you want to expose the thermal sensor data on NetXtreme-C/E
 	  devices, via the hwmon sysfs interface.
 
+config BNXT_TLS
+	bool "Broadcom NetXtreme-C/E TLS offload support"
+	default y
+	depends on BNXT && TLS_DEVICE
+	depends on TLS=y || BNXT=m
+	help
+	  Say Y if you want to enable Transport Layer Security (TLS) hardware
+	  encryption and decryption offload on supported NetXtreme-C/E devices.
+
 config BNGE
 	tristate "Broadcom ThorUltra Ethernet device support"
 	depends on PCI
diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index debef78c8b6d..0506574c007a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,3 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 25099077fe4f..ae3b8b1b8228 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -76,6 +76,7 @@
 #include "bnxt_hwmon.h"
 #include "bnxt_gso.h"
 #include <net/tso.h>
+#include "bnxt_mpc.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9953,6 +9954,15 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	}
 	bp->tso_max_segs = le16_to_cpu(resp->max_tso_segs);
 
+	/* mpc capability can only change during FW reset and ifdown/ifup */
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state) ||
+	    test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
+		if (resp->mpc_chnls_cap)
+			bnxt_alloc_mpc_info(bp, resp->mpc_chnls_cap);
+		else
+			bnxt_free_mpc_info(bp);
+	}
+
 hwrm_func_qcaps_exit:
 	hwrm_req_drop(bp, req);
 	return rc;
@@ -16569,6 +16579,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
@@ -17240,6 +17251,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 44ea8fc7b766..f204e2a6b769 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2453,6 +2453,8 @@ struct bnxt {
 
 	u8			tph_mode;
 
+	struct bnxt_mpc_info	*mpc_info;
+
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
new file mode 100644
index 000000000000..86087e538550
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_mpc.h"
+
+void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
+{
+	if (!bp->mpc_info)
+		bp->mpc_info = kzalloc_obj(*bp->mpc_info);
+	if (bp->mpc_info)
+		bp->mpc_info->mpc_chnls_cap = mpc_chnls_cap;
+	else
+		netdev_warn(bp->dev, "Unable to allocate MPC info\n");
+}
+
+void bnxt_free_mpc_info(struct bnxt *bp)
+{
+	kfree(bp->mpc_info);
+	bp->mpc_info = NULL;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
new file mode 100644
index 000000000000..cd3f268a3a29
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_MPC_H
+#define BNXT_MPC_H
+
+/* Mid path channel (MPC) definitions.  An MPC is special TX/completion
+ * ring pair to send/receive control plane data to the TCE and RCE
+ * (Transmit/Receive Crypto Engine) HW blocks.
+ */
+
+enum bnxt_mpc_type {
+	BNXT_MPC_TCE_TYPE = RING_ALLOC_REQ_MPC_CHNLS_TYPE_TCE,
+	BNXT_MPC_RCE_TYPE = RING_ALLOC_REQ_MPC_CHNLS_TYPE_RCE,
+	BNXT_MPC_TYPE_MAX,
+};
+
+#define BNXT_MAX_MPC		8
+
+struct bnxt_mpc_info {
+	u8			mpc_chnls_cap;
+	u8			mpc_cp_rings;
+	u8			mpc_ring_count[BNXT_MPC_TYPE_MAX];
+	struct bnxt_tx_ring_info *mpc_rings[BNXT_MPC_TYPE_MAX];
+};
+
+#define BNXT_MPC_CRYPTO_CAP    \
+	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
+
+#define BNXT_MPC_CRYPTO_CAPABLE(bp)					\
+	((bp)->mpc_info ?						\
+	 ((bp)->mpc_info->mpc_chnls_cap & BNXT_MPC_CRYPTO_CAP) ==	\
+	  BNXT_MPC_CRYPTO_CAP : false)
+
+#ifdef CONFIG_BNXT_TLS
+void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
+void bnxt_free_mpc_info(struct bnxt *bp);
+#else
+static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
+{
+}
+
+static inline void bnxt_free_mpc_info(struct bnxt *bp)
+{
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_MPC_H */
-- 
2.51.0

