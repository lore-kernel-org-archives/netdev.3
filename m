Received: from out198-8.us.a.mail.aliyun.com (out198-8.us.a.mail.aliyun.com [47.90.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66E36212F;
	Wed, 19 Aug 2026 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098687; cv=none; b=KbRcCbDsaw1BO7JnsVam569d55KJoU+dbxvajBL8x9wK75KOtyzAk5Fwo51qpSoBQAuw/T48qO0h2qLN6/bXoNDiPIw6aojuWdroQLtBMRvuFCfUUrgFnWUZ+FvsoGLbm91tIxNfq+wpkZmew0nveSG1nAWxp86BH6I5MQZm3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098687; c=relaxed/simple;
	bh=sI2XRb8O0vltovS8+65Jlo5wL2kzxZ1uM5BLKSRyoh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ0GDKnsOyOQBiQG1PmtHFXiygirL/5Fn5UEr8XY7O3A879NxZAr53A1bePw49Q9EG8qN6v9Myufwa2rDulJm/JjwkjU7vG1f+92jaO9JYfKvqaRy29l6BgrT8le6tuMAyabEkDnEBof3O6qtt56RVNgu2IOyU+Awnlt1OwoEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0661094-0.00251807-0.931372;FP=17742169539844130326|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iqi7neC_1787098337;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iqi7neC_1787098337 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 08:12:18 +0800
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
Subject: [PATCH v25 net-next 08/10] net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops
Date: Wed, 19 Aug 2026 08:11:10 +0800
Message-ID: <20260819001117.46785-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
References: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add bidirectional mailbox RPC support for cross-PF resource management,
providing request/response handlers for configure_msix_map, destroy_msix_map,
set_mailbox_irq, get_vsi_id and get_eth_id.

Dispatch ops are routed according to PF control capability:
- Control PF invokes local hardware operations directly.
- Non-control PF forwards requests via mailbox RPC to manager PF.

Add helper to register channel response callbacks, extend wire protocol with
new message types and NBL_CHAN_RESP_PERM_DENY error code. Translate RPC
wire status codes to standard kernel errnos to avoid semantic ambiguity
for upper layers.

Improve payload handling for backward compatibility: accept truncated
messages with zero-padding, reject empty payloads to prevent invalid ops.
Fix unimplemented ops check order to avoid potential NULL pointer calls.

Introduce per-dispatch mutex to serialize hardware-modifying operations
such as MSI-X map and mailbox IRQ configuration, eliminating races between
local control paths and asynchronous remote mailbox RPC handlers.
The read-only get_vsi_id / get_eth_id routines only consume static
init-time metadata with no concurrent writers, so they require no locking.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 524 +++++++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   2 +
 .../nbl/nbl_include/nbl_def_channel.h         |   6 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |  16 +
 .../nbl/nbl_include/nbl_include.h             |   1 +
 5 files changed, 548 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 3da5f8351fa4..9bff196b5f3c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -3,9 +3,162 @@
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
+	struct nbl_chan_send_info chan_send;
+	int ret;
+
+	param.type = cpu_to_le16(type);
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_GET_VSI_ID,
+				&param, sizeof(param), &result,
+				sizeof(result), 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	switch (ret) {
+	case NBL_CHAN_RESP_OK:
+		break;
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_PERM_DENY:
+		return -EPERM;
+	default:
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
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id = 0;
+	int ret;
+
+	if (data_len < sizeof(param)) {
+		err = NBL_CHAN_RESP_ERR;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+
+	if (res_ops->get_vsi_id) {
+		ret = res_ops->get_vsi_id(p, src_id, le16_to_cpu(param.type),
+					  &vsi_id);
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
+	} else {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
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
+	struct nbl_chan_send_info chan_send;
+	int ret;
+
+	param.vsi_id = cpu_to_le16(vsi_id);
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_GET_ETH_ID,
+				&param, sizeof(param), &result,
+				sizeof(result), 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	switch (ret) {
+	case NBL_CHAN_RESP_OK:
+		break;
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_PERM_DENY:
+		return -EPERM;
+	default:
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
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	if (data_len < sizeof(param)) {
+		err = NBL_CHAN_RESP_ERR;
+		goto ack_out;
+	}
+	memcpy(&param, data, sizeof(param));
+
+	if (res_ops->get_eth_id) {
+		ret = res_ops->get_eth_id(p, src_id, le16_to_cpu(param.vsi_id),
+					  &result.eth_num, &result.eth_id,
+					  &result.logic_eth_id);
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
+	} else {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
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
@@ -25,6 +178,343 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
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
+	struct nbl_chan_send_info chan_send;
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
+	switch (ret) {
+	case NBL_CHAN_RESP_OK:
+		break;
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_PERM_DENY:
+		return -EPERM;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	default:
+		return -EREMOTEIO;
+	}
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
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	if (src_id > NBL_MAX_PF_SRC_ID) {
+		err = NBL_CHAN_RESP_PERM_DENY;
+		goto ack_out;
+	}
+	if (data_len < sizeof(param)) {
+		err = NBL_CHAN_RESP_ERR;
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
+			err = NBL_CHAN_RESP_ERR;
+	} else {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
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
+	struct nbl_chan_send_info chan_send;
+	u8 dummy;
+	int ret;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+				&dummy, 0, NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	switch (ret) {
+	case NBL_CHAN_RESP_OK:
+		break;
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_PERM_DENY:
+		return -EPERM;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	default:
+		return -EREMOTEIO;
+	}
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
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	if (src_id > NBL_MAX_PF_SRC_ID) {
+		err = NBL_CHAN_RESP_PERM_DENY;
+		goto ack_out;
+	}
+	if (res_ops->destroy_msix_map) {
+		mutex_lock(&disp_mgt->ops_mutex_lock);
+		ret = res_ops->destroy_msix_map(p, src_id);
+		mutex_unlock(&disp_mgt->ops_mutex_lock);
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
+	} else {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
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
+	struct nbl_chan_send_info chan_send;
+	int ret;
+
+	param.vector_id = cpu_to_le16(vector_id);
+	param.en_msix = !!en_msix;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_MAILBOX_SET_IRQ,
+				&param, sizeof(param), NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	switch (ret) {
+	case NBL_CHAN_RESP_OK:
+		break;
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_PERM_DENY:
+		return -EPERM;
+	default:
+		return -EREMOTEIO;
+	}
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
+	int err = NBL_CHAN_RESP_OK;
+	bool en_msix;
+	u16 vector_id;
+	int ret;
+
+	if (data_len < sizeof(param)) {
+		err = NBL_CHAN_RESP_ERR;
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
+			err = NBL_CHAN_RESP_ERR;
+	} else {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
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
+	if (ret)
+		chan_ops->unregister_all_msg(p);
+	return ret;
+}
+
 static void nbl_disp_set_ctrl_bit(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
 {
 	set_bit(lvl, disp_mgt->ctrl_lvl);
@@ -37,6 +527,18 @@ static void nbl_disp_refresh_ctrl_ops(struct nbl_dispatch_mgt *disp_mgt)
 	if (test_bit(NBL_DISP_CTRL_LVL_MGT, disp_mgt->ctrl_lvl)) {
 		disp_ops->init_module = nbl_disp_init_module;
 		disp_ops->deinit_module = nbl_disp_deinit_module;
+		disp_ops->cfg_msix_map = nbl_disp_cfg_msix_map;
+		disp_ops->destroy_msix_map = nbl_disp_destroy_msix_map;
+		disp_ops->set_mailbox_irq = nbl_disp_set_mailbox_irq;
+		disp_ops->get_vsi_id = nbl_disp_get_vsi_id;
+		disp_ops->get_eth_id = nbl_disp_get_eth_id;
+	} else {
+		disp_ops->cfg_msix_map =
+			nbl_disp_chan_cfg_msix_map_req;
+		disp_ops->destroy_msix_map = nbl_disp_chan_destroy_msix_map_req;
+		disp_ops->set_mailbox_irq = nbl_disp_chan_set_mailbox_irq_req;
+		disp_ops->get_vsi_id = nbl_disp_chan_get_vsi_id_req;
+		disp_ops->get_eth_id = nbl_disp_chan_get_eth_id_req;
 	}
 }
 
@@ -45,12 +547,16 @@ nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
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
 
@@ -104,14 +610,30 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	adapter->core.disp_mgt = disp_mgt;
 	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
 
+	ret = nbl_disp_setup_msg(disp_mgt);
+	if (ret)
+		return ret;
+
 	if (common->has_ctrl)
 		nbl_disp_set_ctrl_bit(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
 
+	/*
+	 * For non-control PF with network capability, enable net control
+	 * level.
+	 * All dispatch ops declared with NBL_DISP_CTRL_LVL_MGT fall back
+	 * to remote mailbox msg_req handlers when MGT bit is not set.
+	 */
+	if (common->has_net)
+		nbl_disp_set_ctrl_bit(disp_mgt, NBL_DISP_CTRL_LVL_NET);
 	nbl_disp_refresh_ctrl_ops(disp_mgt);
 	return 0;
 }
 
 void nbl_disp_remove(struct nbl_adapter *adapter)
 {
-	/* All dispatch objects allocated via devm */
+	/*
+	 * All dispatch objects allocated via devm
+	 * All message handlers will be cleaned up inside channel layer
+	 * nbl_chan_remove_common() at final device tear-down
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
index b2e0a670ff13..439e90798875 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -17,6 +17,7 @@ enum {
 	NBL_CHAN_RESP_OK = 0,
 	NBL_CHAN_RESP_ERR = 1,
 	NBL_CHAN_RESP_UNIMPLEMENTED = 2,
+	NBL_CHAN_RESP_PERM_DENY = 3,
 };
 
 /*
@@ -36,6 +37,11 @@ enum {
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
index 96e4c6320fb2..dea9f36e002f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -23,12 +23,28 @@ enum {
  *               caller must check res_mgt->common->has_ctrl before invoking
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index ebf85702cef6..a74ed95b2b0c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -15,6 +15,7 @@
 
 #define NBL_MAX_FUNC					520
 #define NBL_MAX_ETHERNET				4
+#define NBL_MAX_PF_SRC_ID				3
 
 enum {
 	NBL_VSI_DATA = 0,
-- 
2.47.3

