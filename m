Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26742F7F09;
	Mon, 28 Sep 2026 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598780; cv=none; b=OBzmbWIH1QTrjX1bB2wQHiuvQ/26u4kwWvhVmO768UUgMZkDS9SbV/0Y4zGNaYtTzTnSL/JTJbI1kVy7kDUSplul3TY62ogPw1YHvJIiSE+p7bzniJGf1XfOK+PjyaDkxkpL4sEpBkEi+JWf9LnuEOJtVTAD/ZuEgBSEAZyeSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598780; c=relaxed/simple;
	bh=CH5Td25jkvJCBGorkL7O+AzqlEQHOvce1HAfVJZ+Wrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZquNlK5eL04pU02GKTpDpJiM2FV9oH4IkpEClocmSK35Y5UIwIoRmCx6JUdVA8eonB91V63DlLrhTbVdZZ01df7C6tuxF+LYAPtYRSaBseB1pn2EAQdRlNuiRX6KPnHZDsGCn/oOn7and8LZrYeVH6x0bFJBpt0hR4/b3JQGd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.094249-0.0020222-0.903729;FP=17748801931422877494|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jQ6tpmH_1790598765;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jQ6tpmH_1790598765 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 20:32:46 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v30 net-next 6/8] net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops
Date: Mon, 28 Sep 2026 20:32:31 +0800
Message-ID: <20260928123237.88994-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928123237.88994-1-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Implement bidirectional mailbox RPC framework for cross-PF resource management,
adding request/response handlers for five core dispatch operations:
configure_msix_map, destroy_msix_map, set_mailbox_irq, get_vsi_id, get_eth_id.

Dispatch operations are dynamically resolved based on PF capability level:
- Management PF: invokes local hardware resource ops directly.
- Net-capable non-management PF: forwards operations to manager PF via RPC.
- Other functions: all dispatch ops are null and return -EOPNOTSUPP.

Add per-dispatch mutex to serialize mutable hardware operations including
MSIX map configuration/destruction and mailbox IRQ setup. The mutex covers
both local PF call paths and remote RPC response handlers to eliminate
concurrent modification race conditions. Read-only VSI/ETH ID lookup APIs
access static init metadata without serialization requirements.

Register five non-contiguous mailbox message handlers for the new RPC
operations, preserving backward compatibility with reserved message IDs.
All responders enforce strict runtime validation:
- Reject VF/out-of-range PF IDs with -EPERM;
- Validate incoming payload length before parsing;
- Check function pointer existence before invoking resource ops.

Fix error propagation by forwarding native Linux errnos from remote
resource operations instead of unconditionally returning -EREMOTEIO.
Only truncated ACK responses return -EREMOTEIO to distinguish protocol
errors from legitimate operation failures. Transport layer errors are
passed through unchanged from channel send routines.

For MSIX map reconfiguration, pre-allocate DMA buffers and vector indices
prior to tearing down old configurations to prevent interrupt loss.
Destroy path clears mailbox MSIX routing entries upfront to avoid stale
interrupt triggers from recycled hardware vectors.

Document RPC caller preconditions for MSIX map operations: disable mailbox
IRQ_RDY flag and use polling send path, as responders modify mailbox MSIX
routing and cannot rely on interrupt-based ACK wakeup. Extend the same
implicit precondition to set_mailbox_irq for future caller safety.

Clarify module teardown semantics in comment: dispatch message handlers
are owned by the channel layer and unregistered in nbl_chan_remove_common(),
with strict stop ordering preventing use-after-free or stale execution.
Narrow kernel-doc warning to clarify new ops are PF-capability bounded,
not available for VF functions.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 565 +++++++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   2 +
 .../nbl/nbl_include/nbl_def_channel.h         |  39 ++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  16 +
 4 files changed, 621 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 966fee2dec8b..e6a5e53e9d2d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -3,9 +3,178 @@
  * Copyright (c) 2026 Nebula Matrix Limited.
  */
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include "nbl_dispatch.h"
 
+static int nbl_disp_chan_get_vsi_id_req(struct nbl_dispatch_mgt *disp_mgt,
+					u16 type, u16 *vsi_id)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_get_vsi_id result = { 0 };
+	struct nbl_chan_param_get_vsi_id param = { 0 };
+	struct nbl_chan_send_info chan_send = {0};
+	int ret;
+
+	param.type = cpu_to_le16(type);
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_GET_VSI_ID,
+				&param, sizeof(param), &result,
+				sizeof(result), 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	if (ret)
+		return ret;
+	if (chan_send.ack_len != sizeof(result)) {
+		dev_err(disp_mgt->common->dev,
+			"get_vsi_id: short ACK, ack_len=%u expected %zu\n",
+			chan_send.ack_len, sizeof(result));
+		return -EBADMSG;
+	}
+	*vsi_id = le16_to_cpu(result.vsi_id);
+	return 0;
+}
+
+static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_param_get_vsi_id result = { 0 };
+	struct nbl_chan_param_get_vsi_id param = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int err = 0;
+	u16 vsi_id = 0;
+	u32 rel_pf_id;
+	int ret;
+
+	ret = nbl_common_func_id_to_rel_pf_id(disp_mgt->common, src_id,
+					      &rel_pf_id);
+	if (ret) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (rel_pf_id >= disp_mgt->common->max_pf) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (data_len < sizeof(param)) {
+		err = -EBADMSG;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+
+	if (res_ops->get_vsi_id) {
+		ret = res_ops->get_vsi_id(p, src_id, le16_to_cpu(param.type),
+					  &vsi_id);
+		/* Forward the resource errno verbatim to the requester */
+		if (ret)
+			err = ret;
+	} else {
+		err = -EOPNOTSUPP;
+	}
+
+	result.vsi_id = cpu_to_le16(vsi_id);
+ack_out:
+	nbl_chan_fill_ack_info(&chan_ack, src_id,
+			       NBL_CHAN_MSG_GET_VSI_ID, msg_id, err,
+			       &result, sizeof(result));
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_VSI_ID);
+}
+
+static int nbl_disp_chan_get_eth_id_req(struct nbl_dispatch_mgt *disp_mgt,
+					u16 vsi_id, u8 *eth_num, u8 *eth_id,
+					u8 *logic_eth_id)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_get_eth_id result = { 0 };
+	struct nbl_chan_param_get_eth_id param = { 0 };
+	struct nbl_chan_send_info chan_send = {0};
+	int ret;
+
+	param.vsi_id = cpu_to_le16(vsi_id);
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_GET_ETH_ID,
+				&param, sizeof(param), &result,
+				sizeof(result), 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	if (ret)
+		return ret;
+	if (chan_send.ack_len != sizeof(result)) {
+		dev_err(disp_mgt->common->dev,
+			"get_eth_id: short ACK, ack_len=%u expected %zu\n",
+			chan_send.ack_len, sizeof(result));
+		return -EBADMSG;
+	}
+	*eth_num = result.eth_num;
+	*eth_id = result.eth_id;
+	*logic_eth_id = result.logic_eth_id;
+
+	return 0;
+}
+
+static void nbl_disp_chan_get_eth_id_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_chan_param_get_eth_id result = { 0 };
+	struct nbl_chan_param_get_eth_id param = { 0 };
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_ack_info chan_ack;
+	int err = 0;
+	u32 rel_pf_id;
+	int ret;
+
+	ret = nbl_common_func_id_to_rel_pf_id(disp_mgt->common, src_id,
+					      &rel_pf_id);
+	if (ret) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (rel_pf_id >= disp_mgt->common->max_pf) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (data_len < sizeof(param)) {
+		err = -EBADMSG;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+
+	if (res_ops->get_eth_id) {
+		ret = res_ops->get_eth_id(p, src_id, le16_to_cpu(param.vsi_id),
+					  &result.eth_num, &result.eth_id,
+					  &result.logic_eth_id);
+		/* Forward the resource errno verbatim to the requester */
+		if (ret)
+			err = ret;
+	} else {
+		err = -EOPNOTSUPP;
+	}
+ack_out:
+	nbl_chan_fill_ack_info(&chan_ack, src_id,
+			       NBL_CHAN_MSG_GET_ETH_ID, msg_id, err,
+			       &result, sizeof(result));
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_ETH_ID);
+}
+
 static void nbl_disp_deinit_module(struct nbl_dispatch_mgt *disp_mgt)
 {
 	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
@@ -25,6 +194,357 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
 	return -EOPNOTSUPP;
 }
 
+static int nbl_disp_cfg_msix_map(struct nbl_dispatch_mgt *disp_mgt,
+				 u16 num_net_msix, u16 num_others_msix,
+				 bool net_msix_mask_en)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+	int ret;
+
+	if (!res_ops->cfg_msix_map)
+		return -EOPNOTSUPP;
+	mutex_lock(&disp_mgt->ops_mutex_lock);
+	ret = res_ops->cfg_msix_map(p, common->mgt_pf, num_net_msix,
+					  num_others_msix, net_msix_mask_en);
+	mutex_unlock(&disp_mgt->ops_mutex_lock);
+	return ret;
+}
+
+/*
+ * Precondition: caller must disable mailbox IRQ_RDY and switch send_msg
+ * to the polling path before issuing this RPC. The responder rewrites
+ * the requester's mailbox MSI-X routing during the resource op, so the
+ * ACK cannot rely on interrupt wakeup while routing is in flux.
+ */
+static int
+nbl_disp_chan_cfg_msix_map_req(struct nbl_dispatch_mgt *disp_mgt,
+			       u16 num_net_msix, u16 num_others_msix,
+			       bool net_msix_mask_en)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_cfg_msix_map param = { 0 };
+	struct nbl_chan_send_info chan_send = {0};
+	int ret;
+
+	param.num_net_msix = cpu_to_le16(num_net_msix);
+	param.num_others_msix = cpu_to_le16(num_others_msix);
+	param.msix_mask_en = cpu_to_le16(!!net_msix_mask_en);
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
+				&param, sizeof(param),
+				NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static void nbl_disp_chan_cfg_msix_map_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_param_cfg_msix_map param = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int err = 0;
+	u32 rel_pf_id;
+	int ret;
+
+	ret = nbl_common_func_id_to_rel_pf_id(disp_mgt->common, src_id,
+					      &rel_pf_id);
+	if (ret) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (rel_pf_id >= disp_mgt->common->max_pf) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (data_len < sizeof(param)) {
+		err = -EBADMSG;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+
+	if (res_ops->cfg_msix_map) {
+		mutex_lock(&disp_mgt->ops_mutex_lock);
+		ret = res_ops->cfg_msix_map(p, src_id,
+					    le16_to_cpu(param.num_net_msix),
+					    le16_to_cpu(param.num_others_msix),
+					    !!le16_to_cpu(param.msix_mask_en));
+		mutex_unlock(&disp_mgt->ops_mutex_lock);
+		/* Forward the resource errno verbatim to the requester */
+		if (ret)
+			err = ret;
+	} else {
+		err = -EOPNOTSUPP;
+	}
+ack_out:
+	nbl_chan_fill_ack_info(&chan_ack, src_id,
+			       NBL_CHAN_MSG_CONFIGURE_MSIX_MAP, msg_id,
+			       err, NULL, 0);
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP);
+}
+
+/*
+ * Precondition: caller must disable mailbox IRQ_RDY and switch send_msg
+ * to the polling path before issuing this RPC. The responder retargets
+ * the requester's mailbox MSI-X routing during the resource op, so the
+ * ACK cannot rely on interrupt wakeup while routing is in flux.
+ */
+static int nbl_disp_chan_destroy_msix_map_req(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_send_info chan_send = {0};
+	int ret;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+				NULL, 0, NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_ack_info chan_ack;
+	int err = 0;
+	u32 rel_pf_id;
+	int ret;
+
+	ret = nbl_common_func_id_to_rel_pf_id(disp_mgt->common, src_id,
+					      &rel_pf_id);
+	if (ret) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (rel_pf_id >= disp_mgt->common->max_pf) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (res_ops->destroy_msix_map) {
+		mutex_lock(&disp_mgt->ops_mutex_lock);
+		ret = res_ops->destroy_msix_map(p, src_id);
+		mutex_unlock(&disp_mgt->ops_mutex_lock);
+		/* Forward the resource errno verbatim to the requester */
+		if (ret)
+			err = ret;
+	} else {
+		err = -EOPNOTSUPP;
+	}
+ack_out:
+	nbl_chan_fill_ack_info(&chan_ack, src_id,
+			       NBL_CHAN_MSG_DESTROY_MSIX_MAP, msg_id,
+			       err, NULL, 0);
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_DESTROY_MSIX_MAP);
+}
+
+/*
+ * Precondition: caller must disable mailbox IRQ_RDY and switch send_msg
+ * to the polling path before issuing this RPC. The responder rewrites
+ * the requester's own mailbox MSI-X routing (MSIX_IDX / MSIX_IDX_VALID)
+ * before the ACK is sent, so the ACK cannot rely on interrupt wakeup
+ * while routing is in flux.
+ */
+static int nbl_disp_chan_set_mailbox_irq_req(struct nbl_dispatch_mgt *disp_mgt,
+					     u16 vector_id, bool en_msix)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_chan_param_set_mailbox_irq param = { 0 };
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_send_info chan_send = {0};
+	int ret;
+
+	param.vector_id = cpu_to_le16(vector_id);
+	param.en_msix = !!en_msix;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_MAILBOX_SET_IRQ,
+				&param, sizeof(param), NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static void nbl_disp_chan_set_mailbox_irq_resp(void *priv, u16 src_id,
+					       u16 msg_id, void *data,
+					       u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_chan_param_set_mailbox_irq param = { 0 };
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_ack_info chan_ack;
+	int err = 0;
+	u16 vector_id;
+	u32 rel_pf_id;
+	bool en_msix;
+	int ret;
+
+	ret = nbl_common_func_id_to_rel_pf_id(disp_mgt->common, src_id,
+					      &rel_pf_id);
+	if (ret) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (rel_pf_id >= disp_mgt->common->max_pf) {
+		err = -EPERM;
+		goto ack_out;
+	}
+	if (data_len < sizeof(param)) {
+		err = -EBADMSG;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+	vector_id = le16_to_cpu(param.vector_id);
+	en_msix = !!param.en_msix;
+
+	if (res_ops->set_mailbox_irq) {
+		mutex_lock(&disp_mgt->ops_mutex_lock);
+		ret = res_ops->set_mailbox_irq(p, src_id, vector_id, en_msix);
+		mutex_unlock(&disp_mgt->ops_mutex_lock);
+		/* Forward the resource errno verbatim to the requester */
+		if (ret)
+			err = ret;
+	} else {
+		err = -EOPNOTSUPP;
+	}
+
+ack_out:
+	nbl_chan_fill_ack_info(&chan_ack, src_id,
+			       NBL_CHAN_MSG_MAILBOX_SET_IRQ, msg_id,
+			       err, NULL, 0);
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_MAILBOX_SET_IRQ);
+}
+
+static int nbl_disp_destroy_msix_map(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+	int ret;
+
+	if (!res_ops->destroy_msix_map)
+		return -EOPNOTSUPP;
+	mutex_lock(&disp_mgt->ops_mutex_lock);
+	ret = res_ops->destroy_msix_map(p, common->mgt_pf);
+	mutex_unlock(&disp_mgt->ops_mutex_lock);
+	return ret;
+}
+
+static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
+				    u16 vector_id, bool en_msix)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+	int ret;
+
+	if (!res_ops->set_mailbox_irq)
+		return -EOPNOTSUPP;
+	mutex_lock(&disp_mgt->ops_mutex_lock);
+	ret = res_ops->set_mailbox_irq(p, common->mgt_pf, vector_id, en_msix);
+	mutex_unlock(&disp_mgt->ops_mutex_lock);
+	return ret;
+}
+
+static int nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 type,
+			       u16 *vsi_id)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	if (res_ops->get_vsi_id)
+		return res_ops->get_vsi_id(p, common->mgt_pf, type, vsi_id);
+	return -EOPNOTSUPP;
+}
+
+static int nbl_disp_get_eth_id(struct nbl_dispatch_mgt *disp_mgt, u16 vsi_id,
+			       u8 *eth_num, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	if (res_ops->get_eth_id)
+		return res_ops->get_eth_id(p, common->mgt_pf, vsi_id,
+					   eth_num, eth_id, logic_eth_id);
+	return -EOPNOTSUPP;
+}
+
+static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *p = disp_mgt->chan_ops_tbl->priv;
+	int ret = 0;
+	int _ret;
+
+	_ret = chan_ops->register_msg(p, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
+				      nbl_disp_chan_cfg_msix_map_resp,
+				      disp_mgt);
+	if (_ret < 0 && !ret)
+		ret = _ret;
+
+	_ret = chan_ops->register_msg(p, NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+				      nbl_disp_chan_destroy_msix_map_resp,
+				      disp_mgt);
+	if (_ret < 0 && !ret)
+		ret = _ret;
+
+	_ret = chan_ops->register_msg(p, NBL_CHAN_MSG_MAILBOX_SET_IRQ,
+				      nbl_disp_chan_set_mailbox_irq_resp,
+				      disp_mgt);
+	if (_ret < 0 && !ret)
+		ret = _ret;
+
+	_ret = chan_ops->register_msg(p, NBL_CHAN_MSG_GET_VSI_ID,
+				      nbl_disp_chan_get_vsi_id_resp,
+				      disp_mgt);
+	if (_ret < 0 && !ret)
+		ret = _ret;
+
+	_ret = chan_ops->register_msg(p, NBL_CHAN_MSG_GET_ETH_ID,
+				      nbl_disp_chan_get_eth_id_resp,
+				      disp_mgt);
+	if (_ret < 0 && !ret)
+		ret = _ret;
+
+	return ret;
+}
+
 static void nbl_disp_set_ctrl_bit(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
 {
 	set_bit(lvl, disp_mgt->ctrl_lvl);
@@ -34,9 +554,22 @@ static void nbl_disp_refresh_ctrl_ops(struct nbl_dispatch_mgt *disp_mgt)
 {
 	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
 
+	memset(disp_ops, 0, sizeof(*disp_ops));
 	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
 		disp_ops->init_module = nbl_disp_init_module;
 		disp_ops->deinit_module = nbl_disp_deinit_module;
+		disp_ops->cfg_msix_map = nbl_disp_cfg_msix_map;
+		disp_ops->destroy_msix_map = nbl_disp_destroy_msix_map;
+		disp_ops->set_mailbox_irq = nbl_disp_set_mailbox_irq;
+		disp_ops->get_vsi_id = nbl_disp_get_vsi_id;
+		disp_ops->get_eth_id = nbl_disp_get_eth_id;
+	} else if (test_bit(NBL_DISP_CTRL_LVL_NET, disp_mgt->ctrl_lvl)) {
+		disp_ops->cfg_msix_map =
+			nbl_disp_chan_cfg_msix_map_req;
+		disp_ops->destroy_msix_map = nbl_disp_chan_destroy_msix_map_req;
+		disp_ops->set_mailbox_irq = nbl_disp_chan_set_mailbox_irq_req;
+		disp_ops->get_vsi_id = nbl_disp_chan_get_vsi_id_req;
+		disp_ops->get_eth_id = nbl_disp_chan_get_eth_id_req;
 	}
 }
 
@@ -45,12 +578,16 @@ nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
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
 
@@ -104,14 +641,40 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	adapter->core.disp_mgt = disp_mgt;
 	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
 
+	ret = nbl_disp_setup_msg(disp_mgt);
+	if (ret)
+		return ret;
+
 	if (common->has_ctrl)
 		nbl_disp_set_ctrl_bit(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
 
+	if (common->has_net)
+		nbl_disp_set_ctrl_bit(disp_mgt, NBL_DISP_CTRL_LVL_NET);
 	nbl_disp_refresh_ctrl_ops(disp_mgt);
 	return 0;
 }
 
 void nbl_disp_remove(struct nbl_adapter *adapter)
 {
-	/* Dispatch structures are allocated via devm */
+	/*
+	 * Dispatch structures are devm-allocated and freed at detach.
+	 *
+	 * The five responders registered by nbl_disp_setup_msg() are
+	 * owned by the channel layer (xarray of handlers) and are never
+	 * unregistered here. This is safe because the teardown order
+	 * guarantees no responder can run after this point:
+	 *
+	 *   mailbox teardown
+	 *     -> cancel_work_sync(clean_mbx_task)   // drain RX work
+	 *     -> nbl_chan_teardown_queue()          // stop HW queue,
+	 *                                                 // join clean task,
+	 *                                                 // active=false
+	 *     -> nbl_chan_remove_common()
+	 *          -> destroy_wq()                       // no new work
+	 *          -> nbl_chan_remove_msg_handler()      // free handler nodes
+	 *
+	 * By the time devres frees disp_mgt, the mailbox queue is stopped
+	 * and the handler xarray is empty, so no responder can touch
+	 * res_mgt->intr_mgt after nbl_intr_mgt_stop() has cleared it.
+	 */
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
index a7e5802344b4..8549048f76e9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -18,6 +18,8 @@ struct nbl_dispatch_mgt {
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
 	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+	/* use for the caller not in interrupt */
+	struct mutex ops_mutex_lock;
 };
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index bf971121d2ec..5583c465ac16 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -30,6 +30,11 @@ typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
  */
 enum nbl_chan_msg_type {
 	NBL_CHAN_MSG_ACK = 0,
+	NBL_CHAN_MSG_CONFIGURE_MSIX_MAP = 17,
+	NBL_CHAN_MSG_DESTROY_MSIX_MAP = 18,
+	NBL_CHAN_MSG_MAILBOX_SET_IRQ = 19,
+	NBL_CHAN_MSG_GET_VSI_ID = 21,
+	NBL_CHAN_MSG_GET_ETH_ID = 67,
 	/* mailbox msg end */
 	NBL_CHAN_MSG_MAILBOX_MAX,
 };
@@ -39,6 +44,32 @@ enum nbl_chan_state {
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
@@ -46,6 +77,14 @@ struct nbl_board_port_info {
 	u8 rsv[5];
 };
 
+static_assert(sizeof(struct nbl_chan_param_cfg_msix_map) == 8,
+	      "nbl_chan_param_cfg_msix_map size must be 8 bytes");
+static_assert(sizeof(struct nbl_chan_param_set_mailbox_irq) == 4,
+	      "nbl_chan_param_set_mailbox_irq size must be 4 bytes");
+static_assert(sizeof(struct nbl_chan_param_get_vsi_id) == 4,
+	      "nbl_chan_param_get_vsi_id size must be 4 bytes");
+static_assert(sizeof(struct nbl_chan_param_get_eth_id) == 8,
+	      "nbl_chan_param_get_eth_id size must be 8 bytes");
 static_assert(sizeof(struct nbl_board_port_info) == 8,
 	      "nbl_board_port_info size must be 8 bytes");
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
index b3398591035b..74ff69fe8512 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -12,6 +12,7 @@ struct nbl_dispatch_mgt;
 struct nbl_adapter;
 enum {
 	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_NET,
 	NBL_DISP_CTRL_LVL_MAX,
 };
 
@@ -21,6 +22,11 @@ enum {
  *               caller must check has_ctrl guard
  * @deinit_module: dispatch layer cleanup, control-PF exclusive,
  *                 caller must check has_ctrl guard
+ * @cfg_msix_map: configure function msix mapping table
+ * @destroy_msix_map: tear down msix mapping resource
+ * @set_mailbox_irq: bind mailbox interrupt to specified msix vector
+ * @get_vsi_id: resolve VSI ID by type
+ * @get_eth_id: resolve eth port info from VSI ID
  *
  * Warning: init_module/deinit_module are control-PF exclusive. The five
  * resource ops (cfg_msix_map, destroy_msix_map, set_mailbox_irq,
@@ -33,6 +39,16 @@ enum {
 struct nbl_dispatch_ops {
 	int (*init_module)(struct nbl_dispatch_mgt *disp_mgt);
 	void (*deinit_module)(struct nbl_dispatch_mgt *disp_mgt);
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
 };
 
 struct nbl_dispatch_ops_tbl {
-- 
2.47.3

