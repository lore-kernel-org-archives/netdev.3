Received: from out198-26.us.a.mail.aliyun.com (out198-26.us.a.mail.aliyun.com [47.90.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513935C69F;
	Mon, 31 Aug 2026 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142483; cv=none; b=kQ4UDcNdx8YNUNeYrNJNbRT6JKaRerVvJrTPReMDxp7Q/qKJsvZlRypmn1wizm7x5qL3Kozt33qjBspEEfOV7Y6uQARvI8+mS5vTEMdVA8NW4vCKT5U5eUicBrpOe5qQlhUNzoUCPqmUspHAl/rbg+2277zetnb2YaV/3VRPtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142483; c=relaxed/simple;
	bh=sXuD7AsdUjhMGuMn0ZG3Nu9Fl3UewaTiOxxjrObaHCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXbfGrViCE9XfHMzF6HJiSNdb8lHRCP4xygFULwbop3Mkd1deVfYRLIP2/vHrnTp02BfYhGlhov6x6M6U12ZtlATha0UVXeleOArZr4R5p4oiYKiu046IWD1iM9sDHugl6zbr0NucD0FadMDPIKs+mQpc/R3HxT6/bfZ7AbjzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0622182-0.00270742-0.935074;FP=17757936811476928018|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.j0lvzpU_1788142459;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.j0lvzpU_1788142459 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 10:14:20 +0800
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
Subject: [PATCH v26 net-next 08/10] net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops
Date: Mon, 31 Aug 2026 10:13:59 +0800
Message-ID: <20260831021408.2325-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add bidirectional mailbox RPC for cross-PF resource coordination,
implement request/response handlers for these operations:
configure_msix_map, destroy_msix_map, set_mailbox_irq, get_vsi_id,
get_eth_id.

Dispatch operations are resolved dynamically based on PF control
capability:
- Control PF invokes local hardware operations directly.
- Non-control PF forwards requests via mailbox RPC to the manager PF.

Introduce per-dispatch mutex ops_mutex_lock to serialize mutable
hardware operations including MSI-X map and mailbox IRQ setup.
This eliminates race windows between local control paths and
asynchronous remote mailbox RPC response handlers.

Read-only get_vsi_id() / get_eth_id() only access static init-time
metadata without concurrent modifications, so they require no
locking.

Add helper to register channel response callbacks; extend wire
protocol with new message types and NBL_CHAN_RESP_PERM_DENY error
code. Translate channel wire status codes to standard Linux errnos
to unify error semantics for upper dispatch consumers.

Improve message payload validation for forward compatibility:
reject requests with insufficient payload length, enforce bounds
checks before parsing incoming RPC parameters. Fix unimplemented
operation check ordering to avoid potential NULL pointer
dereferences.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 535 +++++++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   2 +
 .../nbl/nbl_include/nbl_def_channel.h         |   6 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |  16 +
 .../nbl/nbl_include/nbl_include.h             |   2 +
 5 files changed, 560 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 3da5f8351fa4..239d8317a9c5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -3,9 +3,170 @@
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
@@ -25,6 +186,346 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
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
+	struct nbl_chan_send_info chan_send = {0};
+	int ret;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+				NULL, 0, NULL, 0, 1);
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
+	if (src_id > NBL_MAX_PF_SRC_ID) {
+		err = NBL_CHAN_RESP_PERM_DENY;
+		goto ack_out;
+	}
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
@@ -37,6 +538,18 @@ static void nbl_disp_refresh_ctrl_ops(struct nbl_dispatch_mgt *disp_mgt)
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
 
@@ -45,12 +558,16 @@ nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
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
 
@@ -104,14 +621,30 @@ int nbl_disp_init(struct nbl_adapter *adapter)
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
index 42d2dc1ebede..e5bc79e13fac 100644
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
index d5e7da0fef6e..61083a750da4 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -22,12 +22,28 @@ enum {
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index ebf85702cef6..a53138530c54 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -15,6 +15,8 @@
 
 #define NBL_MAX_FUNC					520
 #define NBL_MAX_ETHERNET				4
+/* Product firmware only supports 1/2/4 contiguous PFs (ID 0~3) */
+#define NBL_MAX_PF_SRC_ID				3
 
 enum {
 	NBL_VSI_DATA = 0,
-- 
2.47.3

