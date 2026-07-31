Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F43B4E8C;
	Fri, 31 Jul 2026 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490989; cv=none; b=tRJ5TEMOYMZY5NuwoV35vs86PWYarArO8hiimSvad3hNIW+OUxM7xxriUZJlHUfPL4I81Z5NrarZRHn8+7TbH8dOnj5njRoESMdQMvNIrzjPPi+i0Wix5iIDTOxXArbnJp7l/5mH/8A616Sj3Kk68AR9G8bTGWuBUmZU8VzuZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490989; c=relaxed/simple;
	bh=w/ihjB8bjl2+2zgRRuNirf8CtcbhATq1QTIyZi710WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFTF1hr/zWyGXmk+pOr3NSIV9HfmP4k7Ag4XNvq/C8THFj5W+tcNLPtKapfAsMUnKQ9yJKSgTfFKEAKvUX7Wed5KK12HLUHiGPdsjWD+EnanvEwBxQGWlfeHOaVE/M/y8bCDcxjPUPaFt+aGXdFlcG3xaCo3KcEg4HXegSB5h2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.014879-0.000630168-0.984491;FP=17750930343273874594|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iaIzMpJ_1785490975;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iaIzMpJ_1785490975 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 17:42:56 +0800
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
Subject: [PATCH v23 net-next 10/12] net/nebula-matrix: dispatch: add mutual exclusion lock for shared hardware resource ops
Date: Fri, 31 Jul 2026 17:42:33 +0800
Message-ID: <20260731094242.2655-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731094242.2655-1-illusion.wang@nebula-matrix.com>
References: <20260731094242.2655-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add ops_mutex_lock to serialize concurrent hardware-modifying dispatch
resource operations, preventing race conditions between PF local calls
and remote mailbox message handlers that manipulate MSI-X mapping and
mailbox IRQ state.

1. Introduce disp_mgt->ops_mutex_lock, initialized via devm_mutex_init
   at disp_mgt allocation time; symmetrically destroyed automatically
   by devres on device detach, eliminating double mutex_destroy risk.
2. Add NBL_OPS_CALL_LOCK_RET macro to wrap hardware-modifying ops with
   exclusive lock protection for unified locking semantics.
3. Wrap configure_msix_map / destroy_msix_map / set_mailbox_irq with
   ops_mutex_lock; these ops mutate shared MSI-X and IRQ hardware state
   and can race between local PF control paths and cross-PF mailbox RPCs.
The read-only get_vsi_id / get_eth_id routines only consume static
init-time metadata with no concurrent writers, so they require no locking.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 46 +++++++++++++------
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h | 16 +++++++
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 68d239a5c3db..5cbc5f6684a3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Nebula Matrix Limited.
  */
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include "nbl_dispatch.h"
 
@@ -182,9 +183,9 @@ static int nbl_disp_configure_msix_map(struct nbl_dispatch_mgt *disp_mgt,
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->configure_msix_map, (p,
-				common->mgt_pf, num_net_msix,
-				num_others_msix, net_msix_mask_en));
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
+				     common->mgt_pf, num_net_msix,
+				     num_others_msix, net_msix_mask_en);
 }
 
 static int
@@ -243,11 +244,12 @@ static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
 	if (!res_ops->configure_msix_map) {
 		err = NBL_CHAN_RESP_UNIMPLEMENTED;
 	} else {
-		ret = NBL_OPS_CALL_RET(res_ops->configure_msix_map,
-				       (p, src_id,
-					le16_to_cpu(param.num_net_msix),
-					le16_to_cpu(param.num_others_msix),
-					!!le16_to_cpu(param.msix_mask_en)));
+		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt,
+					    res_ops->configure_msix_map, p,
+					    src_id,
+					    le16_to_cpu(param.num_net_msix),
+					    le16_to_cpu(param.num_others_msix),
+					    !!le16_to_cpu(param.msix_mask_en));
 		if (ret)
 			err = NBL_CHAN_RESP_ERR;
 	}
@@ -301,7 +303,8 @@ static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
 	if (!res_ops->destroy_msix_map) {
 		err = NBL_CHAN_RESP_UNIMPLEMENTED;
 	} else {
-		ret = NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p, src_id));
+		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map,
+					    p, src_id);
 		if (ret)
 			err = NBL_CHAN_RESP_ERR;
 	}
@@ -372,8 +375,8 @@ static void nbl_disp_chan_set_mailbox_irq_resp(void *priv, u16 src_id,
 	if (!res_ops->set_mailbox_irq) {
 		err = NBL_CHAN_RESP_UNIMPLEMENTED;
 	} else {
-		ret = NBL_OPS_CALL_RET(res_ops->set_mailbox_irq,
-				       (p, src_id, vector_id, enable_msix));
+		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->set_mailbox_irq,
+					    p, src_id, vector_id, enable_msix);
 		if (ret)
 			err = NBL_CHAN_RESP_ERR;
 	}
@@ -394,8 +397,8 @@ static int nbl_disp_destroy_msix_map(struct nbl_dispatch_mgt *disp_mgt)
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p,
-				     common->mgt_pf));
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p,
+				     common->mgt_pf);
 }
 
 static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
@@ -405,8 +408,8 @@ static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->set_mailbox_irq, (p,
-				common->mgt_pf, vector_id, enable_msix));
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->set_mailbox_irq, p,
+				     common->mgt_pf, vector_id, enable_msix);
 }
 
 static int nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 type,
@@ -532,12 +535,16 @@ nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
 {
 	struct nbl_dispatch_mgt *disp_mgt;
 	struct device *dev = common->dev;
+	int err;
 
 	disp_mgt = devm_kzalloc(dev, sizeof(*disp_mgt), GFP_KERNEL);
 	if (!disp_mgt)
 		return ERR_PTR(-ENOMEM);
 
 	disp_mgt->common = common;
+	err = devm_mutex_init(common->dev, &disp_mgt->ops_mutex_lock);
+	if (err)
+		return ERR_PTR(err);
 	return disp_mgt;
 }
 
@@ -598,6 +605,15 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	if (common->has_ctrl)
 		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
 
+	/*
+	 * For non-control PF with network capability, enable net control
+	 * level.
+	 * All dispatch ops declared with NBL_DISP_CTRL_LVL_MGT fall back
+	 * to remote mailbox msg_req handlers when MGT bit is not set.
+	 */
+	if (common->has_net)
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
index f06b90075af4..ea0971bfe59d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -13,12 +13,28 @@
 #include "../nbl_include/nbl_def_common.h"
 #include "../nbl_core.h"
 
+#define NBL_OPS_CALL_LOCK_RET(disp_mgt, func, ...)			\
+({									\
+	typeof(disp_mgt) _disp_mgt = (disp_mgt);			\
+	typeof(func) _func = (func);					\
+	typeof(_func(__VA_ARGS__)) _ret = 0;				\
+									\
+	if (_func) {							\
+		mutex_lock(&_disp_mgt->ops_mutex_lock);			\
+		_ret = _func(__VA_ARGS__);				\
+		mutex_unlock(&_disp_mgt->ops_mutex_lock);		\
+	}								\
+	_ret;								\
+})
+
 struct nbl_dispatch_mgt {
 	struct nbl_common_info *common;
 	struct nbl_resource_ops_tbl *res_ops_tbl;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
 	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+	/* use for the caller not in interrupt */
+	struct mutex ops_mutex_lock;
 };
 
 #endif
-- 
2.47.3

