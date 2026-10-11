Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F83AA9D4;
	Sun, 11 Oct 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715890; cv=none; b=U5tkJeZj1CxgngRxqmcmdvfRqbyXVlCx0wzm4xDEQj3BIwXH8DTFlpAUXW4jm8WgSIJhM1iwfSFDa50Ii3Vx0tRV5Rjp2dC9OYnFmj3nfyTp+VJhYzHdmu4QpnOUkHQy9Gn8t/040Uhn7Y+QF/kvbxEjX82urCCW9nAehITmmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715890; c=relaxed/simple;
	bh=wND2Qak6gZ9aayFjtb9rOlIHupLuyXbfUMT09KMoyOw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPQ4wWt1YzS1UeboMhHvmzwD+hgijYSelDZfLmLl6veUE1jk4Ft7gPBi33P9ih/8RmoDttQPDQLBj5eClkBXVT/4Nl90eZiguUDftqTXGYtaX8TO3ysdmUsm+hii+/JA8MTAs95G5VJ8M4mdcS2FNnvKgzCB1oaC+6BBFJXJW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCuPdFR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCuPdFR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698911F0089C;
	Sun, 11 Oct 2026 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715888;
	bh=c0+f13DiiztngV6ayuEFXPfJMUEDNCDll5WvBLLbjmA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZCuPdFR9lsQNNA1xRwoaJCoah4C5P1+DXPtXV02LJhVwxphCmBsz2UuKddPn1AHIE
	 rzUb+AnyapbLBgGa+kkkYNSjyKYQJB0FEnTB8SJFh0fBP7aaky+f5zUp8bPNC2fN10
	 AertxXrep/lUWdW1mkgSfGLDUokRoCGIUxbsM+XoGHQlmggILH/TmZIg3RbLwbmikn
	 G9TK6TbWkpSYxqAYz1SwmgxLfaXPzE27PYlmsEWXI83Clbjuv2+wrDMtIUAaWpXGtX
	 L+UqOXPqnwWpoKtxr9hbcvS1rQddYXLirX8ShESVS3bv20z87iNPp04nDQajFPaK/3
	 XBkO0nFcilQyQ==
Subject: Re: [PATCH v31 net-next 8/8] net/nebula-matrix: add common dev
 start/stop operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:28 +0000
Message-ID: <179171588801.434549.12954777191481893263@kernel.org>
In-Reply-To: <20261010095939.2230-9-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-9-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbl_probe() now calls nbl_core_start() -> nbl_dev_start() for
  every adapter that nbl_core_init() returns.
- [Low] In nbl_dev_disable_mailbox_irq() (drivers/net/ethernet/nebula-
  matrix/nbl/nbl_core/nbl_dev.c), the comment says the helper runs in…
- [Low] The err_free_irq comment in nbl_dev_start() (nbl_dev.c) explains
  skipping set_mailbox_irq(false) by saying it 'would only add one more…

--

net/nebula-matrix: add common dev start/stop operation

This patch adds nbl_dev_start() and nbl_dev_stop(). They are called from
nbl_probe() and nbl_remove() through nbl_core_start() and nbl_core_stop().
Start configures the MSI-X map, fetches the VSI/ETH ids, allocates the
MSI-X vectors and arms the mailbox interrupt; stop does the matching
best-effort teardown.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 390bc2b177e21..41754fd06ea36 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -18,6 +29,230 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)

[ ... ]

> +static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{

[ ... ]

> +	 * This helper is invoked in two paths:
> +	 * 1. Error unwind path of nbl_dev_start(): not reached with
> +	 * IRQ_RDY set (nbl_dev_enable_mailbox_irq() sets it only after
> +	 * its RPC succeeded), so only the hardware mask still applies,
> +	 * followed by nbl_dev_free_mailbox_irq() and full channel
> +	 * teardown.

[Severity: Low]
Is the description of the first path accurate? nbl_dev_start() never
calls nbl_dev_disable_mailbox_irq(). Its err_free_irq label calls only
nbl_dev_free_mailbox_irq() and then falls through to err_destroy_map:

err_free_irq:
	nbl_dev_free_mailbox_irq(dev_mgt);
err_destroy_map:
	cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);
	...
	nbl_dev_clear_interrupt_scheme(dev_mgt);

	cancel_work_sync(&common_dev->clean_mbx_task);

This patch also adds the err_free_irq comment, which says
set_mailbox_irq(false) is not sent from that path on purpose. That
contradicts this comment.

nbl_dev_start() does no channel teardown either. That only happens
later, when nbl_probe() calls nbl_core_remove().

nbl_dev_stop() seems to be the only caller of this helper. The rollback
path depends on the routing disable in
__nbl_res_intr_prepare_destroy_msix_map(), not on this helper.

Could the comment list only nbl_dev_stop()?

> +	 * 2. Normal device stop path nbl_dev_stop(): free_irq() blocks until

[ ... ]

> +static int nbl_dev_cfg_msix_map(struct nbl_dev_mgt *dev_mgt)
> +{

[ ... ]

> +	err = disp_ops->cfg_msix_map(dev_mgt->disp_ops_tbl->priv,
> +				     msix_net_num, msix_not_net_num,
> +				     mask_en);

[Severity: Medium]
Can disp_ops->cfg_msix_map be NULL here?

nbl_probe() now calls nbl_core_start()->nbl_dev_start() for every
adapter that nbl_core_init() returns. nbl_dev_start() then calls
cfg_msix_map, get_vsi_id and get_eth_id without checking capabilities or
NULL. On the unwind path it also calls destroy_msix_map.

nbl_disp_refresh_ctrl_ops() memsets the dispatch ops table. It fills the
table only when NBL_DISP_CTRL_LVL_MGT (has_ctrl) or NBL_DISP_CTRL_LVL_NET
(has_net) is set.

The struct nbl_dispatch_ops kerneldoc in nbl_def_dispatch.h says:

  A function with neither has_ctrl nor has_net leaves these pointers
  NULL; callers must not invoke them on such functions.

That state looks reachable. Suppose root binds a VF, or a function other
than func 0, whose ID is not in nbl_id_table, by writing
driver_override=nbl. pci_match_device() then passes the dummy ID:

drivers/pci/pci-driver.c:pci_match_device() {
	...
	/* driver_override will always match, send a dummy id */
	if (ret > 0)
		return &pci_device_id_any;
	...
}

The dummy ID has driver_data 0. nbl_get_func_param() therefore sets
has_net to 0, and has_ctrl stays 0:

	param->caps.has_net = !!(driver_data & BIT(NBL_CAP_HAS_NET_BIT));

new_id cannot produce this state, because new_id_store() rejects a
driver_data value that matches no table entry.

Now assume func 0 of the same slot is bound to nbl, which
nbl_probe_chip_deps() requires, and the init steps succeed. Wouldn't
probe then call a NULL function pointer?

nbl_probe()
  nbl_core_start()
    nbl_dev_start()
      nbl_dev_cfg_msix_map()
        disp_ops->cfg_msix_map()   <- NULL

Before this patch, nbl_dev_init() used disp_ops only under has_ctrl, so
this path is new. Would it make sense to reject !has_ctrl && !has_net
early in nbl_probe()?

[ ... ]

> @@ -274,3 +517,151 @@ void nbl_dev_remove(struct nbl_adapter *adapter)

[ ... ]

> +	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto err_free_irq;
> +
> +	return 0;
> +
> +err_free_irq:
> +	/*
> +	 * nbl_dev_enable_mailbox_irq() only fails before it sets
> +	 * NBL_CHAN_IRQ_RDY - the flag is set after its RPC returns - so
> +	 * there is no interrupt-mode sender to release and no software
> +	 * state to revoke.  The peer-side mailbox routing, if the failed
> +	 * RPC did land, is switched off by the destroy_msix_map() below,
> +	 * whose prepare phase disables mailbox IRQ routing first.  Sending
> +	 * set_mailbox_irq(false) from here would only add one more full
> +	 * polling-mode ACK timeout against a peer that just proved
> +	 * unresponsive.
> +	 */
> +	nbl_dev_free_mailbox_irq(dev_mgt);

[Severity: Low]
This isn't a bug, but does the last sentence of this comment hold for
every failure? It assumes nbl_dev_enable_mailbox_irq() can only fail
through an ACK timeout against an unresponsive peer.

On the control PF, disp_ops->set_mailbox_irq is nbl_disp_set_mailbox_irq().
That is a direct local call: no mailbox, no ACK and no timeout.

	if (!res_ops->set_mailbox_irq)
		return -EOPNOTSUPP;
	return res_ops->set_mailbox_irq(p, common->mgt_pf, vector_id, en_msix);

The resource layer, __nbl_res_intr_set_mailbox_irq(), can fail without
touching hardware:

  -ESHUTDOWN if intr_mgt->stopping is set
  -ENODEV if the function is not NBL_INTR_FUNC_CONFIGURED
  -EINVAL if vector_id is out of range

The responder passes these errors to non-control PFs unchanged.

Skipping set_mailbox_irq(false) still looks correct, because the routing
disable in __nbl_res_intr_prepare_destroy_msix_map() covers a CONFIGURED
function. Could the comment give that as the reason instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
