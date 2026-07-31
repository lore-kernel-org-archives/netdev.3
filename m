Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA827FD76;
	Fri, 31 Jul 2026 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461437; cv=none; b=ib1ji60CAp77wQW1bSpZ+jUGC0wDyj3T+qX17YBuRfKHyM1SItE8DWOYNGYRdlHQjz9JGddJU5HATt934xHZgza8TiC1nkGkagXGYJgHurI9jnCtTamW7m3rwlW9O3CyFxzKl6KZ3qwJimDGZbm/6uzLwl/fCtrz4Qkbdl2jZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461437; c=relaxed/simple;
	bh=Sa0BJCzf3ubd5TRLcUcTuHkdqep5uI3oK474E7bTYtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew+O7Co5o0coVmUH8qvsFmsDOmx86KZewdog9/ZaADfONwD3nylEEtSQC0dU+58BbVR0HEqpSm46jdv/j+wmLFKv6kqOZJdsdfQ1BppYA2iEkpxuccphBsSov/Fgexf5L6OBfmGFCPD8usSb5dBdut6ZJfBJGtFKuxiZ+A3kDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbhHSAYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbhHSAYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932761F00A3D;
	Fri, 31 Jul 2026 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461435;
	bh=qdjPkg/SoqQZO9+3CeYQJ72QbSWE0/dC0WwCzLbrFNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HbhHSAYLC41vlRsNz/3VvLPI000yPYIt1PVWnhtF+pgIH9dABERXx7RyAsFE1/wlJ
	 ja8ihTuxvhYRGJE/DLzMwmq9Adp4k/bwnDscC012XUKaVfN1B/x8BZKq0Kr6P3b3pj
	 s5PhOxH1uroTZOSgNSaaRLFnAfQaTACuS68wCrVf+MqPrplpNOlemR5QOj1vJFEQYN
	 BqqFGU+Ibw+v5cy0spJ5S1ydyXlhL+BOUx5/raRc54vPcL5cTETm7hJvPErKUJLX/0
	 kgd0I7ozvWHaxaf4JiKwDclCmW6PRi78rfgpJ9qIgFw19ks9i8GxjdydZPJboLLHXT
	 QaLB+rGJnBsuA==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v22 net-next 09/12] net/nebula-matrix: dispatch: add cross-version channel message framework
Date: Thu, 30 Jul 2026 18:30:33 -0700
Message-ID: <20260731013033.745204-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-10-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-10-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [9]: [PATCH v22 net-next 09/12] net/nebula-matrix: dispatch: add cross-version channel message framework ---
commit d32035d9a9bd3114eb253cf0283172847c233d7d
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: dispatch: add cross-version channel message framework
    
Implement bidirectional channel request/response RPC handlers for 5 dispatch
resource operations: get_vsi_id, get_eth_id, configure_msix_map,
destroy_msix_map, set_mailbox_irq.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 8116643859c79..c82c336f50e5e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
[ ... ]
> +static int nbl_disp_configure_msix_map(struct nbl_dispatch_mgt *disp_mgt,
> +				       u16 num_net_msix, u16 num_others_msix,
> +				       bool net_msix_mask_en)
> +{
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +	struct nbl_common_info *common = disp_mgt->common;
> +
> +	return NBL_OPS_CALL_RET(res_ops->configure_msix_map, (p,
> +				common->mgt_pf, num_net_msix,
> +				num_others_msix, net_msix_mask_en));
> +}

[Severity: High]
Does nbl_disp_configure_msix_map() need to take a mutex lock before invoking
res_ops->configure_msix_map()?

Calling this resource operation without synchronization might lead to data races
and hardware state corruption if multiple requests arrive simultaneously.

[ ... ]
> +static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
> +						  u16 msg_id, void *data,
> +						  u32 data_len)
> +{
[ ... ]
> +	if (!res_ops->configure_msix_map) {
> +		err = NBL_CHAN_RESP_UNIMPLEMENTED;
> +	} else {
> +		ret = NBL_OPS_CALL_RET(res_ops->configure_msix_map,
> +				       (p, src_id,
> +					le16_to_cpu(param.num_net_msix),
> +					le16_to_cpu(param.num_others_msix),
> +					le16_to_cpu(param.msix_mask_en)));
> +		if (ret)
> +			err = NBL_CHAN_RESP_ERR;
> +		}

[Severity: High]
Should nbl_disp_chan_configure_msix_map_resp() also use locking when invoking
res_ops->configure_msix_map()?

Since this response handler can run from a workqueue context concurrently with
other operations, this might also lead to hardware state corruption.

[ ... ]
> +static void nbl_disp_chan_set_mailbox_irq_resp(void *priv, u16 src_id,
> +					       u16 msg_id, void *data,
> +					       u32 data_len)
> +{
[ ... ]
> +	if (!res_ops->set_mailbox_irq) {
> +		err = NBL_CHAN_RESP_UNIMPLEMENTED;
> +	} else {
> +		ret = NBL_OPS_CALL_RET(res_ops->set_mailbox_irq,
> +				       (p, src_id, vector_id, enable_msix));
> +		if (ret)

[Severity: High]
Similarly, should nbl_disp_chan_set_mailbox_irq_resp() be protected by a lock
when modifying the mailbox IRQ hardware state?

[ ... ]
> @@ -126,6 +562,10 @@ int nbl_disp_init(struct nbl_adapter *adapter)
>  	adapter->core.disp_mgt = disp_mgt;
>  	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
>  
> +	ret = nbl_disp_setup_msg(disp_mgt);
> +	if (ret)
> +		return ret;
> +
>  	if (common->has_ctrl)
>  		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
>  

[Severity: High]
Does the dispatch operations table remain uninitialized for non-control PFs
here?

Since nbl_disp_setup_ctrl_lvl() is responsible for populating the disp_ops
table (including setting up the remote message request handlers as fallbacks
when testing control levels), skipping this step when common->has_ctrl is false
might leave the function pointers as NULL.

Could this lead to a NULL pointer dereference when a regular non-control PF
subsequently attempts to invoke a dispatch operation like get_vsi_id or
get_eth_id?
