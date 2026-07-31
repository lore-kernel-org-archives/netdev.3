Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082653A0B05;
	Fri, 31 Jul 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490987; cv=none; b=Pf3azHD0bqy9bVX+xYaADGHQmjV8rkkK0AJ4y0CFCq1DFJCSXS+QPccA6CVsNvUaNlY42GfXmWk0PyV6kBffRmiW9GIs6aMxbY89CSyTI0pnHsMgCU2mRWieGTT4QIzxyv9YXnFG0ZkNt5959uaSQhFD7JO3BQ3avYhEmAjA6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490987; c=relaxed/simple;
	bh=dk6iG4YwxgpEf7+AzRmxBal2Ac6q29EUSZCxRAlO4pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyjfKlAzNjiWyATB5AQ/m+WQ43ycx7sB3Trc9SIe98XTSYedRvMGE3W4jDeEaZkgi5qeA0Wl8LlkTZqJWMpRANazVePBYics8jzlIVjymsrdHm48+yJqtqaPE/F03jjwWQ8IYAIicHVAujK8C7Q1AmYVoc71tNsnildBtb/F0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.037052-0.000587578-0.96236;FP=13128517594626278934|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iaIzMna_1785490974;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iaIzMna_1785490974 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 17:42:55 +0800
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
Subject: [PATCH v23 net-next 09/12] net/nebula-matrix: dispatch: add cross-version channel message framework
Date: Fri, 31 Jul 2026 17:42:32 +0800
Message-ID: <20260731094242.2655-10-illusion.wang@nebula-matrix.com>
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

Implement bidirectional channel request/response RPC handlers for 5 dispatch
resource operations: get_vsi_id, get_eth_id, configure_msix_map,
destroy_msix_map, set_mailbox_irq.

- Extend X-macro NBL_DISP_OPS_TBL to pair local dispatch entry points
  with cross-PF mailbox request/response callbacks.
- Add registration helper nbl_disp_setup_msg() to auto-register channel
  response handlers for ops with valid msg_type.
- Introduce NBL_CHAN_RESP_UNIMPLEMENTED dedicated error code for missing
  resource ops implementation on remote PF.
- Add dev_err logging when sending RPC ACK back to remote PF fails.

The existing init_module/deinit_module dispatch entries use msg_type = -1,
so they do not register any mailbox channel handlers and are excluded from
RPC logic.

- Separate local channel transmission errors and remote RPC wire response codes:
  The channel layer returns ACK header err via nbl_chan_send_msg() when wait_ack=1.
  Translate wire protocol defined remote codes NBL_CHAN_RESP_* to standard kernel
  errno at dispatch request wrapper to avoid semantic confusion between wire
  handshake values and system error numbers exposed to upper layers.
- Collapse all fine-grained resource operation sub-errors into generic
  NBL_CHAN_RESP_ERR on wire to keep message payload layout unchanged and
  maintain backward compatibility with legacy firmware.
- Fix unimplemented ops check order in response handler to prevent NULL pointer
  invocation of resource ops.

Add input sanitization for mailbox response handlers:
The driver maintains cross-version interoperability; older peers may send
truncated payloads. Existing min_t() + zero-init local param logic absorbs
partial messages and zero-fills missing fields. To mitigate risk:
1. Allow truncated payloads (0 < data_len < sizeof(param)) for backward
   compatibility, continue zero-filling missing fields.
2. Reject data_len == 0 messages entirely, avoid invoking resource ops
   with all-zero initialized parameters.
nbl_disp_chan_destroy_msix_map_resp carries no input payload and skips
payload length validation.

Note: Serialization mutex protecting concurrent MSIX map and mailbox irq hardware
operations will be added in a separate subsequent patch.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 473 ++++++++++++++++++
 1 file changed, 473 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 8116643859c7..68d239a5c3db 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -6,6 +6,158 @@
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
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_OK:
+		break;
+	default:
+		return ret;
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
+	int copy_len;
+	int ret;
+
+	if (data_len == 0) {
+		err = NBL_CHAN_RESP_ERR;
+		goto ack_out;
+	}
+	copy_len = min_t(size_t, data_len, sizeof(param));
+	memcpy(&param, data, copy_len);
+	if (!res_ops->get_vsi_id) {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
+	} else {
+		ret = NBL_OPS_CALL_RET(res_ops->get_vsi_id,
+				       (p, src_id, le16_to_cpu(param.type),
+					&vsi_id));
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
+	}
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
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_OK:
+		break;
+	default:
+		return ret;
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
+	int copy_len;
+	int ret;
+
+	if (data_len == 0) {
+		err = NBL_CHAN_RESP_ERR;
+		goto ack_out;
+	}
+	copy_len = min_t(size_t, data_len, sizeof(param));
+	memcpy(&param, data, copy_len);
+
+	if (!res_ops->get_eth_id) {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
+	} else {
+		ret = NBL_OPS_CALL_RET(res_ops->get_eth_id,
+				       (p, src_id, le16_to_cpu(param.vsi_id),
+					&result.eth_num, &result.eth_id,
+					&result.logic_eth_id));
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
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
@@ -22,6 +174,264 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
 	return NBL_OPS_CALL_RET(res_ops->init_module, (p));
 }
 
+static int nbl_disp_configure_msix_map(struct nbl_dispatch_mgt *disp_mgt,
+				       u16 num_net_msix, u16 num_others_msix,
+				       bool net_msix_mask_en)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	return NBL_OPS_CALL_RET(res_ops->configure_msix_map, (p,
+				common->mgt_pf, num_net_msix,
+				num_others_msix, net_msix_mask_en));
+}
+
+static int
+nbl_disp_chan_configure_msix_map_req(struct nbl_dispatch_mgt *disp_mgt,
+				     u16 num_net_msix, u16 num_others_msix,
+				     bool net_msix_mask_en)
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
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_OK:
+		return ret;
+	default:
+		return ret;
+	}
+}
+
+static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_param_cfg_msix_map param = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int copy_len;
+	int ret;
+
+	if (data_len == 0) {
+		err = NBL_CHAN_RESP_ERR;
+		goto ack_out;
+	}
+	copy_len = min_t(size_t, data_len, sizeof(param));
+	memcpy(&param, data, copy_len);
+	if (!res_ops->configure_msix_map) {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
+	} else {
+		ret = NBL_OPS_CALL_RET(res_ops->configure_msix_map,
+				       (p, src_id,
+					le16_to_cpu(param.num_net_msix),
+					le16_to_cpu(param.num_others_msix),
+					!!le16_to_cpu(param.msix_mask_en)));
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
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
+	int ret;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+				NULL, 0, NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	switch (ret) {
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_OK:
+		return ret;
+	default:
+		return ret;
+	}
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
+	if (!res_ops->destroy_msix_map) {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
+	} else {
+		ret = NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p, src_id));
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
+	}
+
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
+					     u16 vector_id, bool enable_msix)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_chan_param_set_mailbox_irq param = { 0 };
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_send_info chan_send;
+	int ret;
+
+	param.vector_id = cpu_to_le16(vector_id);
+	param.enable_msix = !!enable_msix;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_MAILBOX_SET_IRQ,
+				&param, sizeof(param), NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	switch (ret) {
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_OK:
+		return ret;
+	default:
+		return ret;
+	}
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
+	bool enable_msix;
+	u16 vector_id;
+	int copy_len;
+	int ret;
+
+	if (data_len == 0) {
+		err = NBL_CHAN_RESP_ERR;
+		goto ack_out;
+	}
+	copy_len = min_t(size_t, data_len, sizeof(param));
+	memcpy(&param, data, copy_len);
+	vector_id = le16_to_cpu(param.vector_id);
+	enable_msix = !!param.enable_msix;
+	if (!res_ops->set_mailbox_irq) {
+		err = NBL_CHAN_RESP_UNIMPLEMENTED;
+	} else {
+		ret = NBL_OPS_CALL_RET(res_ops->set_mailbox_irq,
+				       (p, src_id, vector_id, enable_msix));
+		if (ret)
+			err = NBL_CHAN_RESP_ERR;
+	}
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
+
+	return NBL_OPS_CALL_RET(res_ops->destroy_msix_map, (p,
+				     common->mgt_pf));
+}
+
+static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
+				    u16 vector_id, bool enable_msix)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	return NBL_OPS_CALL_RET(res_ops->set_mailbox_irq, (p,
+				common->mgt_pf, vector_id, enable_msix));
+}
+
+static int nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 type,
+			       u16 *vsi_id)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	return NBL_OPS_CALL_RET(res_ops->get_vsi_id,
+				(p, common->mgt_pf, type, vsi_id));
+}
+
+static int nbl_disp_get_eth_id(struct nbl_dispatch_mgt *disp_mgt, u16 vsi_id,
+			       u8 *eth_num, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	return NBL_OPS_CALL_RET(res_ops->get_eth_id,
+				(p, common->mgt_pf, vsi_id, eth_num, eth_id,
+				 logic_eth_id));
+}
+
 /* NBL_DISP_SET_OPS(disp_op_name, func, ctrl_lvl, msg_type, msg_req, msg_resp)
  * ctrl_lvl is to define when this disp_op should go directly to res_op,
  * not sending a channel msg.
@@ -38,7 +448,62 @@ do {									\
 	NBL_DISP_SET_OPS(deinit_module,				\
 			 nbl_disp_deinit_module,			\
 			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(configure_msix_map,				\
+			 nbl_disp_configure_msix_map,			\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,		\
+			 nbl_disp_chan_configure_msix_map_req,		\
+			 nbl_disp_chan_configure_msix_map_resp);	\
+	NBL_DISP_SET_OPS(destroy_msix_map, nbl_disp_destroy_msix_map,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_DESTROY_MSIX_MAP,			\
+			 nbl_disp_chan_destroy_msix_map_req,		\
+			 nbl_disp_chan_destroy_msix_map_resp);		\
+	NBL_DISP_SET_OPS(set_mailbox_irq,				\
+			 nbl_disp_set_mailbox_irq,			\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_MAILBOX_SET_IRQ,		\
+			 nbl_disp_chan_set_mailbox_irq_req,		\
+			 nbl_disp_chan_set_mailbox_irq_resp);	\
+	NBL_DISP_SET_OPS(get_vsi_id, nbl_disp_get_vsi_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_VSI_ID,\
+			 nbl_disp_chan_get_vsi_id_req,			\
+			 nbl_disp_chan_get_vsi_id_resp);		\
+	NBL_DISP_SET_OPS(get_eth_id, nbl_disp_get_eth_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_ETH_ID,\
+			 nbl_disp_chan_get_eth_id_req,			\
+			 nbl_disp_chan_get_eth_id_resp);		\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *p = disp_mgt->chan_ops_tbl->priv;
+	int ret = 0;
+	int _ret;
+
+#define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, resp) \
+do {									\
+	typeof(msg_type) _msg_type = (msg_type);			\
+	typeof(ctrl) _ctrl_lvl = (ctrl);				\
+	(void)(disp_ops->NBL_NAME(disp_op));				\
+	(void)(func);							\
+	(void)(msg_req);						\
+	(void)_ctrl_lvl;						\
+	if (_msg_type >= 0) {						\
+		_ret = chan_ops->register_msg(p, _msg_type, resp, disp_mgt);\
+		if (_ret < 0 && !ret)					\
+			ret = _ret;					\
+	}								\
 } while (0)
+	NBL_DISP_OPS_TBL;
+#undef  NBL_DISP_SET_OPS
+	if (ret)
+		chan_ops->unregister_all_msg(p);
+	return ret;
+}
 
 /* Ctrl lvl means that if a certain level is set, then all disp_ops that
  * declared this lvl will go directly to res_ops, rather than send a
@@ -126,6 +591,10 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	adapter->core.disp_mgt = disp_mgt;
 	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
 
+	ret = nbl_disp_setup_msg(disp_mgt);
+	if (ret)
+		return ret;
+
 	if (common->has_ctrl)
 		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
 
@@ -134,4 +603,8 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 
 void nbl_disp_remove(struct nbl_adapter *adapter)
 {
+	/*
+	 * All message handlers will be cleaned up inside channel layer
+	 * nbl_chan_remove_common() at final device tear-down
+	 */
 }
-- 
2.47.3

