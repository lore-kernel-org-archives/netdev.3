Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8B3EB118;
	Wed,  8 Jul 2026 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493629; cv=none; b=jvMGpzZboCSAcCHg3k1gN+JQsFCq9yilHbErqvO5LQFZ9qzjCJIuzaFSnXUrWkDLh4Zcq6dPg2lCDoUNCOB+eytrIxv5YtZBI5Fx1e2v+gQAoKc/jolbjLgszCVQ0vJSl6lMCtjZyadfg3fs3sW+jfhruaBSph4+//grBwdkMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493629; c=relaxed/simple;
	bh=ZmnlpUgUo6tqSNWefd+tXrXJsqCP5o7rtpTqXYW5GqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvrd5kejIo6cw8VFRZh8kyE6klEKNQguXvGRpMyGjIRFCn+lmFPz3ahV6GplQWO3ptfyPKWcG3wGvd0e+mBFu5zWKDBQvAUXFpTcCw49/DND9EOYFiLlRzic/ZoHq1sB1UaYn1z3qUrFQifMcGIJGgXbPV/h++2+btbJXYDi6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00947012-0.000692723-0.989837;FP=17759800071504446498|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iG5uJBR_1783493275;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iG5uJBR_1783493275 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 14:47:56 +0800
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
Subject: [PATCH v21 net-next 10/12] net/nebula-matrix: dispatch: add resource ops lock protection
Date: Wed,  8 Jul 2026 14:47:36 +0800
Message-ID: <20260708064742.35391-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add mutual exclusion lock for resource ops that modify shared hardware state:
1. Introduce ops_mutex_lock, init/destroy in dispatch setup/remove paths
2. NBL_OPS_CALL_LOCK_RET wrapper to wrap resource ops with lock hold
3. Wrap configure_msix_map / destroy_msix_map / set_mailbox_irq with lock
4. Fix teardown order inversion bug: unregister all channel message handlers
   before mutex destroy, eliminate potential lockdep splat or mutex corruption
5. Cleanup registered message handlers on nbl_disp_setup_msg() failure path

Depends: dispatch core routing + channel message framework patches

The read-only get_vsi_id/get_eth_id ops access static init-time data
without concurrent writer, so no lock required for them.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 40 ++++++++++++-------
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h | 18 +++++++++
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index e083dbf78543..2a04249df7a4 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -153,9 +153,9 @@ static int nbl_disp_configure_msix_map(struct nbl_dispatch_mgt *disp_mgt,
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->configure_msix_map, (p,
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
 				     common->mgt_pf, num_net_msix,
-				     num_others_msix, net_msix_mask_en));
+				     num_others_msix, net_msix_mask_en);
 }
 
 static int
@@ -195,10 +195,10 @@ static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
 
 	copy_len = data_len < sizeof(param) ? data_len : sizeof(param);
 	memcpy(&param, data, copy_len);
-	ret = NBL_OPS_CALL_RET(res_ops->configure_msix_map,
-			       (p, src_id, le16_to_cpu(param.num_net_msix),
-			       le16_to_cpu(param.num_others_msix),
-			       le16_to_cpu(param.msix_mask_en)));
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
+				    src_id, le16_to_cpu(param.num_net_msix),
+				    le16_to_cpu(param.num_others_msix),
+				    le16_to_cpu(param.msix_mask_en));
 	if (ret)
 		err = NBL_CHAN_RESP_ERR;
 	if (!res_ops->configure_msix_map)
@@ -237,7 +237,8 @@ static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
 	int err = NBL_CHAN_RESP_OK;
 	int ret;
 
-	ret = NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p, src_id));
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p,
+				    src_id);
 	if (ret)
 		err = NBL_CHAN_RESP_ERR;
 	if (!res_ops->destroy_msix_map)
@@ -289,8 +290,8 @@ static void nbl_disp_chan_set_mailbox_irq_resp(void *priv, u16 src_id,
 	memcpy(&param, data, copy_len);
 	vector_id = le16_to_cpu(param.vector_id);
 	enable_msix = !!param.enable_msix;
-	ret = NBL_OPS_CALL_RET(res_ops->set_mailbox_irq,
-			       (p, src_id, vector_id, enable_msix));
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->set_mailbox_irq, p,
+				    src_id, vector_id, enable_msix);
 	if (ret)
 		err = NBL_CHAN_RESP_ERR;
 	if (!res_ops->set_mailbox_irq)
@@ -311,8 +312,8 @@ static int nbl_disp_destroy_msix_map(struct nbl_dispatch_mgt *disp_mgt)
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p,
-				     common->mgt_pf));
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p,
+				     common->mgt_pf);
 }
 
 static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
@@ -322,8 +323,8 @@ static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
 	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
 	struct nbl_common_info *common = disp_mgt->common;
 
-	return NBL_OPS_CALL_RET(res_ops->set_mailbox_irq, (p,
-				     common->mgt_pf, vector_id, enable_msix));
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->set_mailbox_irq, p,
+				     common->mgt_pf, vector_id, enable_msix);
 }
 
 static int nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 type,
@@ -401,6 +402,8 @@ static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
 	int ret = 0;
 	int _ret;
 
+	mutex_init(&disp_mgt->ops_mutex_lock);
+
 #define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, resp) \
 do {									\
 	typeof(msg_type) _msg_type = (msg_type);			\
@@ -417,8 +420,10 @@ do {									\
 } while (0)
 	NBL_DISP_OPS_TBL;
 #undef  NBL_DISP_SET_OPS
-	if (ret)
+	if (ret) {
 		chan_ops->unregister_all_msg(p);
+		mutex_destroy(&disp_mgt->ops_mutex_lock);
+	}
 	return ret;
 }
 
@@ -515,6 +520,12 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	if (common->has_ctrl)
 		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
 
+	/* This bit must be set for adapters with net capability,
+	 * otherwise dispatch ops will be not set..
+	 */
+	if (common->has_net)
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
+
 	return 0;
 }
 
@@ -525,4 +536,5 @@ void nbl_disp_remove(struct nbl_adapter *adapter)
 	struct nbl_channel_mgt *p = disp_mgt->chan_ops_tbl->priv;
 
 	chan_ops->unregister_all_msg(p);
+	mutex_destroy(&disp_mgt->ops_mutex_lock);
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

