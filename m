Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9436E498;
	Thu, 23 Jul 2026 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779619; cv=none; b=u7LokL4jWObmObPh/5L2IXqGb/PcwxHDlOL27/SviR7Yifsh4vPTqKzqj7yA1aSIg30nYtxF6onzdCYxva/zH3pZuCZ0QKpmwC7YQznf6toCFKtnjG+f0E44OuH5PNSzcd6tXmCK4GL/nDtpjwkduosSK+WFpuaZS3QfL5yV2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779619; c=relaxed/simple;
	bh=fPp6bbFf5haVo4d6SRJ/idakzEoPUWsTX43gchsdbxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULrRX3LCZe+MLtQrKKlSMFQiBK0lGC8gefVb4dXJweU4kaqcasOi9H7y+LOmzacwGhGhs9UtyEro2qMgSSFg/xM9fn++k/8x9gC5tT8gVVBEfL0hxKEum2J2JvTrv1iRliAj7LgDbRXOxESgciS6Q/Bg7AYDJBgsCoCZ47xX+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0101343-0.000570734-0.989295;FP=16318644926429185186|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iSkYuZF_1784779284;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iSkYuZF_1784779284 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Jul 2026 12:01:25 +0800
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
Subject: [PATCH v22 net-next 10/12] net/nebula-matrix: dispatch: add mutual exclusion lock for shared hardware resource ops
Date: Thu, 23 Jul 2026 12:01:02 +0800
Message-ID: <20260723040110.91410-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
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
4. Fix cleanup ordering: unregister all channel message handlers before
   hardware resource teardown to avoid lockdep splats and invalid mutex
   access after destruction.
5. Complete message handler cleanup on nbl_disp_setup_msg() failure
   path to avoid leaked callback registrations.

The read-only get_vsi_id / get_eth_id routines only consume static
init-time metadata with no concurrent writers, so they require no locking.

Functional note: Enable NBL_DISP_CTRL_LVL_NET for adapters with
common->has_net set, ensuring net-level dispatch operation handlers
are properly wired into the dispatch op table.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 47 ++++++++++++-------
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h | 18 +++++++
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index c82c336f50e5..175250f95250 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Nebula Matrix Limited.
  */
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include "nbl_dispatch.h"
 
@@ -173,9 +174,9 @@ static int nbl_disp_configure_msix_map(struct nbl_dispatch_mgt *disp_mgt,
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
@@ -227,14 +228,15 @@ static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
 	if (!res_ops->configure_msix_map) {
 		err = NBL_CHAN_RESP_UNIMPLEMENTED;
 	} else {
-		ret = NBL_OPS_CALL_RET(res_ops->configure_msix_map,
-				       (p, src_id,
-					le16_to_cpu(param.num_net_msix),
-					le16_to_cpu(param.num_others_msix),
-					le16_to_cpu(param.msix_mask_en)));
+		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt,
+					    res_ops->configure_msix_map, p,
+					    src_id,
+					    le16_to_cpu(param.num_net_msix),
+					    le16_to_cpu(param.num_others_msix),
+					    le16_to_cpu(param.msix_mask_en));
 		if (ret)
 			err = NBL_CHAN_RESP_ERR;
-		}
+	}
 
 	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP, msg_id,
 		     err, NULL, 0);
@@ -281,7 +283,8 @@ static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
 	if (!res_ops->destroy_msix_map) {
 		err = NBL_CHAN_RESP_UNIMPLEMENTED;
 	} else {
-		ret = NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p, src_id));
+		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map,
+					    p, src_id);
 		if (ret)
 			err = NBL_CHAN_RESP_ERR;
 	}
@@ -344,8 +347,8 @@ static void nbl_disp_chan_set_mailbox_irq_resp(void *priv, u16 src_id,
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
@@ -365,8 +368,8 @@ static int nbl_disp_destroy_msix_map(struct nbl_dispatch_mgt *disp_mgt)
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p,
-				     common->mgt_pf));
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p,
+				     common->mgt_pf);
 }
 
 static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
@@ -376,8 +379,8 @@ static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->set_mailbox_irq, (p,
-				common->mgt_pf, vector_id, enable_msix));
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->set_mailbox_irq, p,
+				     common->mgt_pf, vector_id, enable_msix);
 }
 
 static int nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 type,
@@ -503,12 +506,16 @@ nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
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
 
@@ -569,6 +576,14 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	if (common->has_ctrl)
 		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
 
+	/*
+	 * This flag must be enabled for adapters with network capability;
+	 * otherwise NET-layer dispatch operation handlers will not be
+	 * registered.
+	 */
+	if (common->has_net)
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
index f06b90075af4..722758354ff2 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -13,12 +13,30 @@
 #include "../nbl_include/nbl_def_common.h"
 #include "../nbl_core.h"
 
+#define NBL_OPS_CALL_LOCK_RET(disp_mgt, func, ...)			\
+({									\
+	typeof(disp_mgt) _disp_mgt = (disp_mgt);			\
+	typeof(func) _func = (func);					\
+	typeof(_func(__VA_ARGS__)) _ret = 0;				\
+									\
+	mutex_lock(&_disp_mgt->ops_mutex_lock);				\
+									\
+	if (_func)							\
+		_ret = _func(__VA_ARGS__);				\
+									\
+	mutex_unlock(&_disp_mgt->ops_mutex_lock);			\
+									\
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

