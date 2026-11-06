Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941007;
	b=qydf7EEzRVrYAdS9Q39PrSn4pAL24AflF7args/skrjmY9b/LDUGAQRU7z/Fyq0XFHwK
	 iC88f4T4eCE+VITO9IEEMDTPM8sCjD6Me5m+jguXzaiS5nwBYxs3GAr5YNk6mrBUjqWaI
	 nxa6Ub47Wfqpy1G1jaVrB9JfWxW6hRh+FVK5roAc5XLaomcPDCMd7Cwx9vcvm5N6kDwdo
	 /c/IZviPnjmq6UcVECP/2Rwvc4DkJ0PpajUzyKI7TsYLN/B8QAqM+pZ3yfHOBLPbusglI
	 GuL6OE8RBjAaxRPp9rkmVKZbA9QgM1n2kTbrT5K23RI8INaMtn+vHfMSLqh/9kLMNOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941007;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Szz/L74P4ZxwcnTiA6qSmRwy6fnIBNaaufURzzgG9tc=;
	b=UdG7zEG0B14VTAgtCZ9VrN/PCnbGS/UrOAib/fKvpFg/hLweBVenjiMS4E6lgPcv2Xwp
	 zltMRIjIsogE8kn1RGE2WRcKuqyiyiVH2CMTIb4XzWU3GVf0y2HfpMrcNovTQ/ZJ8h40B
	 R+QU3u6um8bSG1dFTo/vN3rTPsNSBnZtoFy5ILS+ou84yQ5InAp6MNccskPBj8xZl/Ju2
	 NXk/Qb3btmUrQHLbl8yKJdWPHiki/sxNdLoX0S4UzhYHxcVUSaBAbaYVGVVLzu/pvdkB/
	 AYq5q9rhDD/USDBadE5MgS8/4G1eEwvV/Gm9jCBpj71y1ZmKkZUK4ALqxAu9jMGTpTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDC606A326;
	Fri,  6 Nov 2026 04:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87DDC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0598812-0.00155644-0.938562;FP=15444775315422463250|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jy28JmO_1793941000;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jy28JmO_1793941000 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 12:56:41 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v33 net-next 6/8] net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops
Date: Fri,  6 Nov 2026 12:56:23 +0800
Message-ID: <20261106045631.2224-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106045631.2224-1-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-1-illusion.wang@nebula-matrix.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add mailbox RPC requests and responses for five dispatch operations:
cfg_msix_map, destroy_msix_map, set_mailbox_irq, get_vsi_id and
get_eth_id. Each op is resolved by capability level: a function with
has_ctrl calls the resource op locally, a function with has_net forwards
it to the management PF over the channel, and a function with neither
leaves the op pointer NULL, so the caller must not invoke it.

A request builds the payload, sends it synchronously and checks the ACK
length before parsing; a short ACK returns -EBADMSG. A responder rejects
VFs and out-of-range source PF ids with -EPERM, checks the payload
length before parsing, and forwards the resource layer's errno verbatim
so the requester can tell a protocol error from a failed operation. If
the resource op is not installed the responder answers -EOPNOTSUPP. A
peer PF is treated as trusted: hardware and firmware forbid PF
passthrough to guests, so every peer runs this host driver, and the
resource layer bounds the requested vector counts by the global pool.

The cfg_msix_map, destroy_msix_map and set_mailbox_irq requests carry a
caller precondition: disable the mailbox IRQ_RDY flag and use the
polling send path, because the responder changes mailbox MSI-X routing
and an interrupt-driven ACK wakeup cannot be relied on while routing is
in flux.

No dispatch-layer lock is taken around these ops. The resource layer
serializes concurrent callers itself (intr_mgt->lock) and the dispatch
layer has no mutable state of its own to protect; the read-only
get_vsi_id/get_eth_id paths only touch static init metadata.

The five responders are registered with the channel layer and owned by
it, so they are removed when the channel is torn down and need no
explicit unregistration: nbl_disp_remove() stays empty here. The
teardown order that makes that safe is documented with the code that
performs it, in the next patch in this series.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 534 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_channel.h         |  40 ++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  37 +-
 3 files changed, 607 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 966fee2d..cb68544e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -6,6 +6,174 @@
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
@@ -25,6 +193,353 @@ static int nbl_disp_init_module(struct nbl_dispatch_mgt *disp_mgt)
 	return -EOPNOTSUPP;
 }
 
+static int nbl_disp_cfg_msix_map(struct nbl_dispatch_mgt *disp_mgt,
+				 u16 num_net_msix, u16 num_others_msix,
+				 bool net_msix_mask_en)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	if (!res_ops->cfg_msix_map)
+		return -EOPNOTSUPP;
+	/*
+	 * No core-layer lock is taken here: the resource layer serializes
+	 * concurrent callers itself (intr_mgt->lock), and the dispatch
+	 * layer has no mutable state of its own for this op to protect.
+	 */
+	return res_ops->cfg_msix_map(p, common->mgt_pf, num_net_msix,
+				     num_others_msix, net_msix_mask_en);
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
+		/*
+		 * The vector counts come from the peer PF.  A peer is
+		 * trusted: hardware and firmware forbid PF passthrough to
+		 * guests (see nbl_get_func_param()), so every peer runs this
+		 * same host driver, and the resource layer bounds the counts
+		 * by the global vector pool.  A peer asking for the whole
+		 * pool can starve the others with -EAGAIN, but it cannot
+		 * corrupt state.
+		 */
+		ret = res_ops->cfg_msix_map(p, src_id,
+					    le16_to_cpu(param.num_net_msix),
+					    le16_to_cpu(param.num_others_msix),
+					    !!le16_to_cpu(param.msix_mask_en));
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
+		ret = res_ops->destroy_msix_map(p, src_id);
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
+		ret = res_ops->set_mailbox_irq(p, src_id, vector_id, en_msix);
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
+
+	if (!res_ops->destroy_msix_map)
+		return -EOPNOTSUPP;
+	return res_ops->destroy_msix_map(p, common->mgt_pf);
+}
+
+static int nbl_disp_set_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
+				    u16 vector_id, bool en_msix)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	if (!res_ops->set_mailbox_irq)
+		return -EOPNOTSUPP;
+	return res_ops->set_mailbox_irq(p, common->mgt_pf, vector_id, en_msix);
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
@@ -34,9 +549,22 @@ static void nbl_disp_refresh_ctrl_ops(struct nbl_dispatch_mgt *disp_mgt)
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
 
@@ -104,9 +632,15 @@ int nbl_disp_init(struct nbl_adapter *adapter)
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index bf971121..5aa16d4c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -7,6 +7,7 @@
 #define _NBL_DEF_CHANNEL_H_
 
 #include <linux/types.h>
+#include <linux/build_bug.h>
 
 struct nbl_channel_mgt;
 struct nbl_adapter;
@@ -30,6 +31,11 @@ typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
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
@@ -39,6 +45,32 @@ enum nbl_chan_state {
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
@@ -46,6 +78,14 @@ struct nbl_board_port_info {
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
index b5a69516..7da9e242 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -12,6 +12,7 @@ struct nbl_dispatch_mgt;
 struct nbl_adapter;
 enum {
 	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_NET,
 	NBL_DISP_CTRL_LVL_MAX,
 };
 
@@ -32,16 +33,44 @@ enum {
  *               mailbox DMA before calling it, see nbl_dev_remove().
  *               Returns void.  Control-PF exclusive, same NULL rule as
  *               @init_module.
+ * @cfg_msix_map: configure function msix mapping table
+ * @destroy_msix_map: tear down msix mapping resource
+ * @set_mailbox_irq: bind mailbox interrupt to specified msix vector
+ * @get_vsi_id: resolve VSI ID by type
+ * @get_eth_id: resolve eth port info from VSI ID
  *
  * These callbacks are not dispatch-layer setup/teardown: the dispatch
- * structures are devm-allocated in nbl_disp_init(), and nbl_disp_remove()
- * only documents why no explicit teardown is needed. They forward
- * chip/firmware control down to the layers below instead: a control-PF
- * function calls the resource ops directly.
+ * structures are devm-allocated in nbl_disp_init(), so nbl_disp_remove()
+ * has nothing to undo. The five responders registered by
+ * nbl_disp_setup_msg() are owned by the channel layer and go away with
+ * it, so they need no explicit unregistration either; the teardown order
+ * that makes that safe is documented with the code that performs it, in
+ * the next patch in this series. They forward chip/firmware control down
+ * to the layers below instead: a control-PF function calls the resource
+ * ops directly, a non-control function sends a mailbox request over the
+ * channel layer.
+ *
+ * Warning: init_module/deinit_module are control-PF exclusive. The five
+ * resource ops (cfg_msix_map, destroy_msix_map, set_mailbox_irq,
+ * get_vsi_id, get_eth_id) are PF-only and resolve to either a local
+ * resource call (control PF) or a mailbox RPC (non-control PF with
+ * has_net). A function with neither has_ctrl nor has_net leaves these
+ * pointers NULL; callers must not invoke them on such functions. VFs are
+ * rejected by the responders with -EPERM.
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
2.51.0.windows.1

