Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC784AF17B;
	Thu, 17 Sep 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684514; cv=none; b=ijAR/G8KJCcpz9JcwTSskqMgbPnw/U6flly8dkikXTjhDStXbSkt25lYtsUeeNV4PGSPypkBC70aD5ffhYiCA2FgPNUxqWvQ3POPbWqcTSTQ2UYC007z1qa8zqRhsSYmd011HU4zF2/KwfcckC8fhcREqKMsBAdFMyM9KhODPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684514; c=relaxed/simple;
	bh=rG3E32V/+pWPmqc2dH99Op45V6sLo8VgLDZkyz3c9QA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pF6c1MphzQ9GBeM4OAYkrJg6C7PGLnED1GeXPrrvzspC9IdKugMY/eL9lFfhQUcwGmJL1g60EDSvSzxlZlEFHwlCiDxxDRpI3SEzKbbY3LbnnsyQ4uhU4+1m5lCqlp8qCISgeBM8I5CDErvGaD8lleQKogcln/+7QAOL3eAmcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyBNxYDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyBNxYDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B1E1F00898;
	Thu, 17 Sep 2026 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684511;
	bh=jkxDlFfxEhdJ63HXqqZnaj64ZTVHrIpWh0bTKzEFhao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MyBNxYDz/xtb3pB3YiwcVmm920md42Eb5CM+rk3T+/vaLsHbdsNhyYnCn1ohZVcyA
	 JnY+SYm6QJmGI/eIysNAZPVbkvP9AN0kK5GbSvZ4aqoQW0nZG+C9ec3UR8Oermu01Z
	 RCfJipu59wBC4Sp4QpyhI1Sw1t9/7GrlqQGTGpZ1MuDr94aSceTkDSdnPsXycoXTdI
	 L1XafDTN2nSB6OpzYn9DcAdnCOs/fUDoYAPt5+D7hj/MJQWHlNKXubSGMlu2WbzyTc
	 zEYOCV/GPWATSuLu1K/9/CWFVcDz6w3ClIIcMnERB/wh30UWnvjGpkYqIHqVWs++no
	 JR2D3KBlScBLg==
Subject: Re: [PATCH v28 net-next 08/10] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:09 +0000
Message-ID: <178968450992.22033.17621055123292475841@kernel.org>
In-Reply-To: <20260914123429.56596-9-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-9-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] The five new mailbox responders in nbl_dispatch.c perform no
  authorization of the requesting function, contradicting the commit…
- [Medium] The five new request helpers switch on chan_ops->send_msg()'s
  return value as if it were a positive NBL_CHAN_RESP_* wire status, but…
- [Low] Claim: nbl_disp_setup_msg() registers five mailbox responders
  with no matching unregistration, and nbl_disp_remove() is empty, so in…
- [Low] Claim: the NBL_CHAN_MSG_MAILBOX_SET_IRQ RPC reprograms the
  requesting function's own mailbox MSI-X routing on the responder side…

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

This adds bidirectional mailbox RPC to the dispatch layer for five
operations (configure_msix_map, destroy_msix_map, set_mailbox_irq,
get_vsi_id, get_eth_id), resolving the dispatch ops at probe time
depending on whether the PF is the control PF or a net-only PF.  It also
introduces disp_mgt->ops_mutex_lock to serialize the mutable hardware
ops and extends the wire protocol with new message types and
NBL_CHAN_RESP_PERM_DENY.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index b7f404b319fac..7254ed10d478f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -3,9 +3,192 @@
>   * Copyright (c) 2026 Nebula Matrix Limited.
>   */
>  #include <linux/device.h>
> +#include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include "nbl_dispatch.h"
>  
> +static int nbl_disp_chan_get_vsi_id_req(struct nbl_dispatch_mgt *disp_mgt,
> +					u16 type, u16 *vsi_id)
> +{
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_common_info *common = disp_mgt->common;
> +	struct nbl_chan_param_get_vsi_id result = { 0 };
> +	struct nbl_chan_param_get_vsi_id param = { 0 };
> +	struct nbl_chan_send_info chan_send = {0};
> +	int ret;
> +
> +	param.type = cpu_to_le16(type);
> +
> +	nbl_chan_fill_send_info(&chan_send, common->mgt_pf,
> +				NBL_CHAN_MSG_GET_VSI_ID,
> +				&param, sizeof(param), &result,
> +				sizeof(result), 1);
> +	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
> +	if (ret < 0)
> +		return ret;
> +	switch (ret) {
> +	case NBL_CHAN_RESP_OK:
> +		break;
> +	case NBL_CHAN_RESP_UNIMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case NBL_CHAN_RESP_ERR:
> +		return -EREMOTEIO;
> +	case NBL_CHAN_RESP_PERM_DENY:
> +		return -EPERM;
> +	default:
> +		return -EREMOTEIO;
> +	}

[Severity: Medium]
Can this switch ever observe a value other than 0?

nbl_chan_send_msg() returns READ_ONCE(wait_head->ack_err), and
nbl_chan_recv_ack_msg() clamps every positive wire status before storing
it:

nbl_channel.c:nbl_chan_recv_ack_msg() {
	raw_err = (s32)le32_to_cpu(*(__le32 *)&payload[NBL_CHAN_ACK_RET_POS]);
	if (raw_err > 0 || raw_err < -MAX_ERRNO)
		raw_err = -EREMOTEIO;

	WRITE_ONCE(wait_head->ack_err, raw_err);
}

The responders put the raw positive status on the wire unchanged
(nbl_chan_send_ack() does tmp[NBL_CHAN_ACK_RET_POS] =
cpu_to_le32(chan_ack->err)), so NBL_CHAN_RESP_ERR(1),
NBL_CHAN_RESP_UNIMPLEMENTED(2) and NBL_CHAN_RESP_PERM_DENY(3) all arrive
as -EREMOTEIO and are consumed by the preceding "if (ret < 0) return
ret;".

That would make the UNIMPLEMENTED / ERR / PERM_DENY arms here (and the
identical arms in nbl_disp_chan_get_eth_id_req(),
nbl_disp_chan_cfg_msix_map_req(), nbl_disp_chan_destroy_msix_map_req()
and nbl_disp_chan_set_mailbox_irq_req()) unreachable.

The commit message states:

  "Request-side helpers translate channel wire status codes to standard
   Linux errnos: OK->0, UNIMPLEMENTED->-EOPNOTSUPP, ERR->-EREMOTEIO,
   PERM_DENY->-EPERM."

Does that translation actually happen, given the clamp above?  A remote
UNIMPLEMENTED (returned whenever a res_ops pointer is NULL) would surface
as -EREMOTEIO rather than -EOPNOTSUPP.

> +	if (chan_send.ack_len != sizeof(result)) {
> +		dev_err(disp_mgt->common->dev,
> +			"get_vsi_id: short ACK, ack_len=%u expected %zu\n",
> +			chan_send.ack_len, sizeof(result));
> +		return -EREMOTEIO;
> +	}
> +	*vsi_id = le16_to_cpu(result.vsi_id);
> +	return 0;
> +}
> +
> +static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
> +					  void *data, u32 data_len)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +	struct device *dev = disp_mgt->common->dev;
> +	struct nbl_chan_param_get_vsi_id result = { 0 };
> +	struct nbl_chan_param_get_vsi_id param = { 0 };
> +	struct nbl_chan_ack_info chan_ack;
> +	int err = NBL_CHAN_RESP_OK;
> +	u16 vsi_id = 0;
> +	u32 rel_pf_id;
> +	int ret;
> +
> +	ret = nbl_common_func_id_to_rel_pf_id(disp_mgt->common, src_id,
> +					      &rel_pf_id);
> +	if (ret) {
> +		err = NBL_CHAN_RESP_PERM_DENY;
> +		goto ack_out;
> +	}

[Severity: High]
Can this gate ever reject anything?  The commit message says:

  "Every responder validates:
   - src_id against common->max_pf at runtime; rejects VF and
     out-of-range function IDs with PERM_DENY;"

but the helper only does a lower-bound test and then throws the result
away:

nbl_common.c:nbl_common_func_id_to_rel_pf_id() {
	if (!rel_pf_id)
		return -EINVAL;

	if (pf_id < common->mgt_pf)
		return -EINVAL;
	*rel_pf_id = pf_id - common->mgt_pf;
	return 0;
}

With common->mgt_pf = 0 (nbl_core_init() in nbl_main.c hard-codes it),
"pf_id < common->mgt_pf" is never true for the unsigned src_id, so the
helper always returns 0.  rel_pf_id is then unused, and there is no
comparison against common->max_pf in any of the five responders.

Should these responders carry the same rejection that the other caller of
this helper, nbl_res_func_id_to_bdf() in nbl_resource.c, performs?

	if (rel_pf_id >= common->max_pf) {
		dev_err(common->dev,
			"func_id=%u rel_pf_id=%u exceeds max_pf=%u, VF BDF unsupported\n",
			pfid, rel_pf_id, common->max_pf);
		return -EOPNOTSUPP;
	}

As written, can NBL_CHAN_RESP_PERM_DENY be produced by any responder in
this patch?

> +	if (data_len < sizeof(param)) {
> +		err = NBL_CHAN_RESP_ERR;
> +		goto ack_out;
> +	}
> +	memcpy(&param, data, sizeof(param));

[ ... ]

> +static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
> +						u16 msg_id, void *data,
> +						u32 data_len)
> +{

[ ... ]

> +	ret = nbl_common_func_id_to_rel_pf_id(disp_mgt->common, src_id,
> +					      &rel_pf_id);
> +	if (ret) {
> +		err = NBL_CHAN_RESP_PERM_DENY;
> +		goto ack_out;
> +	}
> +	if (res_ops->destroy_msix_map) {
> +		mutex_lock(&disp_mgt->ops_mutex_lock);
> +		ret = res_ops->destroy_msix_map(p, src_id);
> +		mutex_unlock(&disp_mgt->ops_mutex_lock);

[Severity: High]
Following on from the missing max_pf rejection above, src_id is forwarded
here as func_id with no PF/VF distinction.  The downstream ops do not add
one either:

nbl_res_intr_destroy_msix_map() only rejects func_id >= NBL_MAX_FUNC
(520), and __nbl_res_intr_set_mailbox_irq() in the en_msix == false case
writes mailbox routing for any func_id below that:

nbl_interrupt.c:__nbl_res_intr_set_mailbox_irq() {
	if (!en_msix) {
		hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv,
					func_id, false, 0);
		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
		return 0;
	}

Should a VF function id (8..519) be able to reach destroy_msix_map and
set_mailbox_irq on the control PF?

There is also a cost per message here: __nbl_res_intr_destroy_msix_map()
sleeps unconditionally, even when the function had nothing configured:

nbl_interrupt.c:__nbl_res_intr_destroy_msix_map() {
	ret = __nbl_res_intr_prepare_destroy_msix_map(res_mgt, func_id);
	if (ret)
		return ret;
	mutex_unlock(&intr_mgt->lock);
	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
	mutex_lock(&intr_mgt->lock);

Since this runs from the mailbox RX work item with
disp_mgt->ops_mutex_lock held, does each unauthorized
NBL_CHAN_MSG_DESTROY_MSIX_MAP message hold up the cross-PF control path
for a millisecond?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> index 58a9fa97fbf39..6f8fc14a51f0e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -18,6 +18,7 @@ enum {
>  	NBL_CHAN_RESP_OK = 0,
>  	NBL_CHAN_RESP_ERR = 1,
>  	NBL_CHAN_RESP_UNIMPLEMENTED = 2,
> +	NBL_CHAN_RESP_PERM_DENY = 3,
>  };

[Severity: Medium]
Given the clamp in nbl_chan_recv_ack_msg() and the always-succeeding
authorization helper, is this new enumerator reachable in either
direction - can a responder set it, and can a requester ever see it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
