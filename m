Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C153839BD;
	Fri,  7 Aug 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077890; cv=none; b=Jh+PIK6Zg6pxcV6BkxuOxNQXZqeDnX/ziwWt3I1lmGvQ5KoY0YM7u90/qipUso3+YVPzrgkZFQYFnb+I7MBsSI8Zj0VTb0kKkgH7J3yoc30wFeRo2410kxSk3AWTDDo/p5x/3ov/248na3211AOLNzifIDPejQC4GMRLTNK+czU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077890; c=relaxed/simple;
	bh=LuAZw8+lCcVBcbnyjGSPnvwslkNoLpyJp+gR/KMxlEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srIJPcIxVzxlAGLvQkwQtGAqsx7efyn/Qtq6aczBeGiYWRmB+zPazugra7jSMBrsrlsaRAvbYyVkBpq0y2NvtG1d7qhmS/599e1Xo4s8j3weWlkemRLM/8iADrbiI9XnRo6uowPY62YCdRg7bhVHAJSDnuf4JkGFm8Gl/aF1KnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0163363-0.000529495-0.983134;FP=17804098432766986046|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.ig.C9.f_1786077875;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.ig.C9.f_1786077875 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 12:44:35 +0800
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
Subject: [PATCH v24 net-next 09/11] net/nebula-matrix: dispatch: add channel RPC framework & shared hw ops mutex
Date: Fri,  7 Aug 2026 12:44:13 +0800
Message-ID: <20260807044422.2356-10-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
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
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 521 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   2 +
 .../nbl/nbl_include/nbl_def_channel.h         |   1 +
 .../nbl/nbl_include/nbl_include.h             |   1 +
 4 files changed, 525 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 9358651cbf7e..3fef901c8e25 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -3,9 +3,162 @@
  * Copyright (c) 2025 Nebula Matrix Limited.
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
@@ -25,6 +178,341 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
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
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_PERM_DENY:
+		return -EPERM;
+	case NBL_CHAN_RESP_ERR:
+		return -EREMOTEIO;
+	case NBL_CHAN_RESP_OK:
+		return ret;
+	default:
+		return ret;
+	}
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
+	int copy_len;
+	int ret;
+
+	if (src_id > NBL_MAX_PF_SRC_ID) {
+		err = NBL_CHAN_RESP_PERM_DENY;
+		goto ack_out;
+	}
+	if (data_len == 0) {
+		err = NBL_CHAN_RESP_ERR;
+		goto ack_out;
+	}
+	copy_len = min_t(size_t, data_len, sizeof(param));
+	memcpy(&param, data, copy_len);
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
+	int ret;
+
+	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
+				NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+				NULL, 0, NULL, 0, 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+	switch (ret) {
+	case NBL_CHAN_RESP_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case NBL_CHAN_RESP_PERM_DENY:
+		return -EPERM;
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
+	bool en_msix;
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
 static void nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
 {
 	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
@@ -34,6 +522,18 @@ static void nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
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
 
@@ -42,12 +542,16 @@ nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
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
 
@@ -101,12 +605,29 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	adapter->core.disp_mgt = disp_mgt;
 	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
 
+	ret = nbl_disp_setup_msg(disp_mgt);
+	if (ret)
+		return ret;
+
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
 
 void nbl_disp_remove(struct nbl_adapter *adapter)
 {
+	/*
+	 * All message handlers will be cleaned up inside channel layer
+	 * nbl_chan_remove_common() at final device tear-down
+	 */
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
index f06b90075af4..644094c9dd8e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -19,6 +19,8 @@ struct nbl_dispatch_mgt {
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
 	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+	/* use for the caller not in interrupt */
+	struct mutex ops_mutex_lock;
 };
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index 23bdd453ee73..4db33a6e0151 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -17,6 +17,7 @@ enum {
 	NBL_CHAN_RESP_OK = 0,
 	NBL_CHAN_RESP_ERR = 1,
 	NBL_CHAN_RESP_UNIMPLEMENTED = 2,
+	NBL_CHAN_RESP_PERM_DENY = 3,
 };
 
 /*
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 5f33a5de908d..aa61051c8034 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -15,6 +15,7 @@
 
 #define NBL_MAX_FUNC					520
 #define NBL_MAX_ETHERNET				4
+#define NBL_MAX_PF_SRC_ID				3
 /* Used for macros to pass checkpatch */
 #define NBL_NAME(x)					x
 
-- 
2.47.3

