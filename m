Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D143CE73;
	Sun, 11 Oct 2026 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715890; cv=none; b=cSysEKFkybEnF5rvxTz8k9E08o82p4hu64bxLy7WZ8baFzIZmDUVRrpu+A5389Q4dKaggnZAL7UK7gSAgqjz+JBnZSGUhW4bIcAJrlRg4f2eteBBxLJ4RHIIhxV7UdxbJMM22bwg6QJzdVu9fN4mL8unLbUd2AaZllHje+vh1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715890; c=relaxed/simple;
	bh=xK+yHyKTh94pvxjqg6oiFbjBwGp4b1724p9Ste8+6uI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVRBNJV6Q0xGKiuGlDVlXH7smfVoqVF6spJBDPB7TKJ/PA3ABL96e24GN4jCDX6UjgPBqTyNfi0cwSZdGYIXHF4aoWn9n60IziWYY1PVpn/7m6YFuc6O4pIz/B5iKJoa4XcqFREoBSt3w5DhyO0mxxNuhAplqUtIF3ph2BToEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPJmeiwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPJmeiwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB8F1F0089D;
	Sun, 11 Oct 2026 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715886;
	bh=i4wXItLBI+jPlNVAS/OPUIcpk3cL799kkvfJhP4EeTE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kPJmeiwGAupB0zk5hbxzdrmb0UV4qbjq461b6dMY9IfuoLskQ/qfsZals2xG4DfvZ
	 PHCjxrHRdUOewyJ1CRQt91kaHRWADkf9xlVOeZzvcRkGx6LSom3zUtsTQpc8pAQyWS
	 UzC1v5G4VLuWMkK7yb9V0a7yho799jGOTCJ7aGh3OUtMjRsqFYQP0s4vd5+/Q/k0/6
	 Kb2YfM8Xa0pjKeq6DPWk/5KmBuug18wWoixX/Ey32AapwyKfslV3FpB67hFmn/jz3F
	 OAZBh0VTM2S3IFHroFyFTnw8HORBJC3J4hCiiLgb/G2F5vQ7g2oZKGya1Es5bVOfA/
	 z1aoCECY2qNfw==
Subject: Re: [PATCH v31 net-next 6/8] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:25 +0000
Message-ID: <179171588597.434549.1106532144631559450@kernel.org>
In-Reply-To: <20261010095939.2230-7-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-7-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Baseline decision is false: in the final state of the series this
  is not a bug.
- [Low] The kernel-doc this patch adds for struct nbl_dispatch_ops in
  nbl_def_dispatch.h says the new callbacks 'forward chip/firmware…

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

This patch adds mailbox RPC requests and responders for five dispatch ops:
cfg_msix_map, destroy_msix_map, set_mailbox_irq, get_vsi_id and get_eth_id.
Each op is chosen by capability level. A has_ctrl function calls the
resource layer locally, and a has_net function forwards the request to the
management PF over the channel. nbl_disp_remove() gains a comment that
explains why the registered responders are never unregistered.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 966fee2dec8b0..e2d98b7c391b4 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c

[ ... ]

>  void nbl_disp_remove(struct nbl_adapter *adapter)
>  {
> -	/* Dispatch structures are allocated via devm */
> +	/*
> +	 * Dispatch structures are devm-allocated and freed at detach.
> +	 *
> +	 * The five responders registered by nbl_disp_setup_msg() are
> +	 * owned by the channel layer (xarray of handlers) and are never
> +	 * unregistered here. This is safe because the teardown order
> +	 * guarantees no responder can run after this point:
> +	 *
> +	 *   mailbox teardown
> +	 *     -> cancel_work_sync(clean_mbx_task)   // drain RX work
> +	 *     -> nbl_chan_teardown_queue()          // stop HW queue,
> +	 *                                                 // join clean task,
> +	 *                                                 // active=false
> +	 *     -> nbl_chan_remove_common()
> +	 *          -> destroy_wq()                       // no new work
> +	 *          -> nbl_chan_remove_msg_handler()      // free handler nodes

[Severity: Low]
This isn't a bug, but does this comment describe code that exists at this
commit?

clean_mbx_task doesn't appear anywhere in the tree yet. Nothing calls
chan_ops->setup_queue at this point either, so the mailbox RX path that
this sequence quiesces is never active.

The ordering the comment relies on is nbl_dev_remove() doing the mailbox
teardown before nbl_disp_remove(), nbl_res_remove_leonis() and
nbl_chan_remove_common(). That ordering only arrives with the later
"net/nebula-matrix: add common/ctrl dev init/remove operation" patch.

Also, destroy_wq() looks like shorthand for nbl_common_destroy_wq().

Could this comment move to the patch that introduces that teardown
ordering, and use the real function names?

> +	 *
> +	 * By the time devres frees disp_mgt, the mailbox queue is stopped
> +	 * and the handler xarray is empty, so no responder can touch
> +	 * res_mgt->intr_mgt after nbl_intr_mgt_stop() has cleared it.
> +	 */
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> index 08fef0f679268..bcd74b9df8275 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h

[ ... ]

> @@ -32,6 +33,16 @@ enum {
>   *               mailbox DMA before calling it, see nbl_dev_remove().
>   *               Returns void.  Control-PF exclusive, same NULL rule as
>   *               @init_module.
> + * @cfg_msix_map: configure function msix mapping table
> + * @destroy_msix_map: tear down msix mapping resource
> + * @set_mailbox_irq: bind mailbox interrupt to specified msix vector
> + * @get_vsi_id: resolve VSI ID by type
> + * @get_eth_id: resolve eth port info from VSI ID
> + *
> + * These callbacks are not dispatch-layer setup/teardown: the dispatch
> + * structures are devm-allocated in nbl_disp_init(), and nbl_disp_remove()
> + * only documents why no explicit teardown is needed.  They forward
> + * chip/firmware control to the upper layers instead.

[Severity: Low]
Is "upper layers" the right direction here? The new callbacks forward
downward, for example:

nbl_disp_cfg_msix_map()
    return res_ops->cfg_msix_map(p, common->mgt_pf, num_net_msix,
                                 num_others_msix, net_msix_mask_en);

The nbl_disp_chan_*_req() variants call chan_ops->send_msg() instead.

The resource and channel layers both sit below dispatch, and nbl_dev is
the caller. Later patches in the series don't change this text, so the
wording stays as it is.

>   *
>   * Warning: init_module/deinit_module are control-PF exclusive. The five
>   * resource ops (cfg_msix_map, destroy_msix_map, set_mailbox_irq,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
