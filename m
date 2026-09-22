Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0B53D9EF;
	Tue, 22 Sep 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078613; cv=none; b=ebqPN35dBjFZJlIx1XsZ352WbMqFRriKiBW6Fh63NKfFjcZZ5nOfjp9yDDCLwYeJH4kLUYowcoQBLJutymVeQwXCDjqaxcC7exJrAEzRkmTBO4OoB9+UMHLdDkEkj3dwXuVde2M3ICgnlzuBZ17FOxkkGakc58GIUs5gFIi3G6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078613; c=relaxed/simple;
	bh=45J+KLpvlZjAJxAx9hLRL5c2mNI9C+49Jux0z+8TIdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSA4nuJaLycofeoFJXeOqvmqR4GOvTWV71csHcxCHGHuc74f1s7mD7U0eodia5JRdltkSuA/qJOTEQXBMgMaJgDX8gtKSTJj/KtLNQKGU2SY3p0QF+oyC9J/ZqRkOIqLfB28oGtmxxNxOd8vyiEy20mY1Lqk215tuRJkT6yUmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0899838-0.00233551-0.907681;FP=17748942668922799670|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jK4DPV5_1790078599;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jK4DPV5_1790078599 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 20:03:20 +0800
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
Subject: [PATCH v29 net-next 6/8] net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops
Date: Tue, 22 Sep 2026 20:03:03 +0800
Message-ID: <20260922120311.86593-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add bidirectional mailbox RPC for cross-PF resource coordination,
implementing request/response handlers for five operations:
configure_msix_map, destroy_msix_map, set_mailbox_irq, get_vsi_id,
get_eth_id.

Dispatch operations are resolved dynamically based on PF control
capability via nbl_disp_refresh_ctrl_ops():
- Control PF (NBL_DISP_CTRL_LVL_MGT): invokes local hardware ops
  directly.
- Non-control PF with net capability (NBL_DISP_CTRL_LVL_NET):
  forwards requests via mailbox RPC to the manager PF.
- Neither level set: all dispatch ops are NULL.

Introduce per-dispatch mutex ops_mutex_lock to serialize mutable
hardware operations (cfg_msix_map, destroy_msix_map, set_mailbox_irq).
The mutex protects both local control-PF call paths and asynchronous
remote mailbox RPC response handlers to eliminate race windows.
Read-only get_vsi_id() / get_eth_id() access static init-time metadata;
disp_ops table updates only happen during probe, so no runtime
concurrent modification.

nbl_disp_setup_msg() registers five dispatch-layer wire message
response handlers with the channel layer:
NBL_CHAN_MSG_CONFIGURE_MSIX_MAP, NBL_CHAN_MSG_DESTROY_MSIX_MAP,
NBL_CHAN_MSG_MAILBOX_SET_IRQ, NBL_CHAN_MSG_GET_VSI_ID,
NBL_CHAN_MSG_GET_ETH_ID.
Message IDs are non-contiguous to preserve compatibility with reserved
and deprecated message entries.

Extend wire protocol with new message types.

Every responder validates:
- src_id against common->max_pf at runtime; rejects VF and
  out-of-range function IDs with -EPERM;
- incoming payload length against the expected parameter struct size
  before parsing;
- unimplemented operation via NULL function pointer check before
  dispatch.

Remote responders return standard Linux errnos directly on the wire.
Transport errors are returned unchanged from chan_ops->send_msg().
get_vsi_id_req() and get_eth_id_req() verify chan_send.ack_len
matches sizeof(result) before dereferencing the response, rejecting
truncated ACKs with -EREMOTEIO to prevent adoption of zeroed
identifiers from a short reply.

destroy_msix_map responder clears the mailbox QINFO MSIX routing
(MSIX_IDX / MSIX_IDX_VALID) as Step 0 before tearing down the
MSI-X map, ensuring a recycled global vector cannot trigger an
interrupt owned by a different function.

cfg_msix_map pre-allocates all coherent DMA buffers and global
vector indices before destroying the old configuration, then swaps
the new resources into the per-function entry to avoid interrupt
loss during reconfiguration.

RPC caller precondition: disable mailbox IRQ_RDY and switch send_msg
to polling path before invoking cfg_msix_map / destroy_msix_map RPC,
because responder modifies mailbox MSIX routing and ACK cannot rely
on interrupt wakeup.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 538 +++++++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   2 +
 .../nbl/nbl_include/nbl_def_channel.h         |   5 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |  17 +
 4 files changed, 561 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 966fee2dec8b..d12ef8683528 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -3,9 +3,176 @@
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
+		return -EREMOTEIO;
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
+		err = -EREMOTEIO;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+
+	if (res_ops->get_vsi_id) {
+		ret = res_ops->get_vsi_id(p, src_id, le16_to_cpu(param.type),
+					  &vsi_id);
+		if (ret)
+			err = -EREMOTEIO;
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
+		return -EREMOTEIO;
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
+		err = -EREMOTEIO;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+
+	if (res_ops->get_eth_id) {
+		ret = res_ops->get_eth_id(p, src_id, le16_to_cpu(param.vsi_id),
+					  &result.eth_num, &result.eth_id,
+					  &result.logic_eth_id);
+		if (ret)
+			err = -EREMOTEIO;
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
@@ -25,6 +192,347 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
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
+/*
+ * Precondition: caller must disable mailbox IRQ_RDY and switch send_msg
+ * to polling path before issuing cfg_msix_map RPC.
+ * The responder will disable mailbox MSIX routing during resource ops,
+ * so ACK cannot rely on interrupt wakeup.
+ */
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
+		err = -EREMOTEIO;
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
+		if (ret)
+			err = -EREMOTEIO;
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
+/*
+ * Precondition: caller must disable mailbox IRQ_RDY and switch send_msg
+ * to polling path before issuing destroy_msix_map.
+ * The responder will disable mailbox MSIX routing during resource ops,
+ * so ACK cannot rely on interrupt wakeup.
+ */
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
+		if (ret)
+			err = -EREMOTEIO;
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
+		err = -EREMOTEIO;
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
+		if (ret)
+			err = -EREMOTEIO;
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
@@ -34,9 +542,22 @@ static void nbl_disp_refresh_ctrl_ops(struct nbl_dispatch_mgt *disp_mgt)
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
 
@@ -45,12 +566,16 @@ nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
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
 
@@ -104,14 +629,25 @@ int nbl_disp_init(struct nbl_adapter *adapter)
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
+	 * Dispatch structures are allocated via devm.
+	 * Message handlers registered by nbl_disp_setup_msg() are owned by
+	 * channel layer; they are unregistered in nbl_chan_remove_common(),
+	 * not here.
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
index c9c99c967037..5aa16d4cd432 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -31,6 +31,11 @@ typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
index b0daabb05d39..61083a750da4 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -12,6 +12,7 @@ struct nbl_dispatch_mgt;
 struct nbl_adapter;
 enum {
 	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_NET,
 	NBL_DISP_CTRL_LVL_MAX,
 };
 
@@ -21,12 +22,28 @@ enum {
  *               caller must check has_ctrl guard
  * @deinit_module: dispatch layer cleanup, ONLY valid on Control PF,
  *                 caller must check has_ctrl guard
+ * @cfg_msix_map: configure function msix mapping table
+ * @destroy_msix_map: tear down msix mapping resource
+ * @set_mailbox_irq: bind mailbox interrupt to specified msix vector
+ * @get_vsi_id: resolve VSI ID by type
+ * @get_eth_id: resolve eth port info from VSI ID
+ *
  * Warning: All ops except init_module/deinit_module can be safely called
  * on PF/VF; init/deinit hooks are control-PF exclusive to prevent NULL ptr.
  */
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

