Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F243BDA1;
	Sun, 11 Oct 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715887; cv=none; b=RqCBd1BCXJa4O8DDV8AoqYQNEvlD+Lm3FHi44l+qoXOEkCPYkxOyW/dcsoHi57Fym+x69dx1ZLStp7M5HLbCO5M/cVkimgzSnIldvwvXJixrbZvYnS/RRRNo2BAGuxJ3YN1+fjTxdJ9U5tPWQsLmLqNh25v//QquEoSGF9NOK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715887; c=relaxed/simple;
	bh=MO/H7ruvxIGYPNft97AL19EkY49+T+cdEWvY+N6oYUU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBofLvQtEoOV2SfvUCSfLJ4HV4Bfl3a3bgr9F2noz8Ejk6PBiy/J+cC2ytiy4PXRb381qVQKsnQ4eSh1s6qmOEsIMFRn6xHzGDDBVs7eMcj2xY1szOcWovlJSCVWE5QN3kF/GCg/2bNhd8Pa9ASKH2ZnS8CSVVz4Wkn2a13XoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDYfw1OG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDYfw1OG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C701F0089C;
	Sun, 11 Oct 2026 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715885;
	bh=yZgeAhm9LGSfMtOz0lbxT94lDIkdtge4k9OSRkRaMqU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QDYfw1OGyOAARs9wJiuGIabYjIVDEAr3xWSGZfJoiqWu2vxFJArUls2C/yTNOi6xD
	 OcX4w90YrTrxWmOJT0gUndmwZylVmeMT9yFi/F7uKc1wKrx7TCpHsPD5ZWqwSfE47k
	 Gik6p6vYcWujF2I3nWqcpJ0XQC+K0PkxFU73xUROffD07S86KRfiGVGW9/dtrVLYQ8
	 2sVfduIRCyP0MpOWLCY2mfbBAg2jAPgzSA5EL+B8bKwJC1NbR4UX7DsVXUB7d18aSn
	 XelgfvYP536TpxOFAijvAvQOP/cgZwQPHy8Sc9htpFngoxDDGeZyfQCGKEiOYJ4XPX
	 +eIyhVwqAgIfw==
Subject: Re: [PATCH v31 net-next 5/8] net/nebula-matrix: dispatch: add
 control-level routing core infrastructure
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:24 +0000
Message-ID: <179171588478.434549.10226203216843725603@kernel.org>
In-Reply-To: <20261010095939.2230-6-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-6-illusion.wang@nebula-matrix.com>
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

- [Low] The commit message says this patch will "Add wire ABI structures
  with static_assert for upcoming mailbox RPC", but the patch adds…
- [Low] At this commit, the kernel-doc on struct nbl_dispatch_ops in
  nbl_def_dispatch.h (lines 18-43) describes things that are not in the…

--

net/nebula-matrix: dispatch: add control-level routing core infrastructure

This commit allocates the dispatch management state and ops table, adds a
ctrl_lvl bitmap to track control privileges, and wires init_module and
deinit_module wrappers to the resource ops. The MGT level is enabled only
on the control PF.

> MGT level is only enabled for Control PF. Add kerneldoc for caller
> permission constraints. Add wire ABI structures with static_assert for
> upcoming mailbox RPC.

[Severity: Low]
This patch doesn't seem to add any wire ABI structures or static_assert
checks. The diff only touches the Makefile, nbl_core.h, nbl_dispatch.c,
nbl_dispatch.h, nbl_def_dispatch.h and nbl_main.c. None of those files adds
a mailbox wire structure or a static_assert.

At this commit, enum nbl_chan_msg_type in nbl_def_channel.h still contains
only:

enum nbl_chan_msg_type {
	NBL_CHAN_MSG_ACK = 0,
	/* mailbox msg end */
	NBL_CHAN_MSG_MAILBOX_MAX,
};

The only static_assert under drivers/net/ethernet/nebula-matrix/ is the
existing one on struct nbl_board_port_info, which an earlier patch added.

The param structures and their asserts (nbl_chan_param_cfg_msix_map,
nbl_chan_param_set_mailbox_irq, nbl_chan_param_get_vsi_id and
nbl_chan_param_get_eth_id) first appear in the next patch, "dispatch:
implement channel RPC framework and serialize hardware ops".

Could this sentence be removed from this commit message, or moved to the
patch that actually adds the structures?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> new file mode 100644
> index 0000000000000..08fef0f679268
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> @@ -0,0 +1,56 @@

[ ... ]

> +enum {
> +	NBL_DISP_CTRL_LVL_MGT,
> +	NBL_DISP_CTRL_LVL_MAX,
> +};
> +
> +/**
> + * struct nbl_dispatch_ops - dispatch control plane operation callbacks

[ ... ]

> + * @deinit_module: chip-wide teardown, forwarded the same way; on leonis
> + *               it clears driver_status, which starts an asynchronous
> + *               firmware per-PF cleanup pass with no completion status
> + *               bit, waited for best-effort only.  The caller must have
> + *               stopped the mailbox channel and drained all in-flight
> + *               mailbox DMA before calling it, see nbl_dev_remove().
> + *               Returns void.  Control-PF exclusive, same NULL rule as
> + *               @init_module.
> + *
> + * Warning: init_module/deinit_module are control-PF exclusive. The five
> + * resource ops (cfg_msix_map, destroy_msix_map, set_mailbox_irq,
> + * get_vsi_id, get_eth_id) are PF-only and resolve to either a local
> + * resource call (control PF) or a mailbox RPC (non-control PF with
> + * has_net). A function with neither has_ctrl nor has_net leaves these
> + * pointers NULL; callers must not invoke them on such functions. VFs are
> + * rejected by the responders with -EPERM.
> + */
> +struct nbl_dispatch_ops {
> +	int (*init_module)(struct nbl_dispatch_mgt *disp_mgt);
> +	void (*deinit_module)(struct nbl_dispatch_mgt *disp_mgt);
> +};

[Severity: Low]
This isn't a bug, but at this commit the kernel-doc for struct
nbl_dispatch_ops describes code that isn't in the tree yet.

It refers callers to nbl_dev_remove(). That function doesn't exist yet,
because nbl_dev.c hasn't been added at this point.

It also describes five PF-only ops (cfg_msix_map, destroy_msix_map,
set_mailbox_irq, get_vsi_id, get_eth_id), has_net routing over mailbox
RPC, and -EPERM responders. The struct itself has only init_module and
deinit_module, and the enum has only NBL_DISP_CTRL_LVL_MGT and
NBL_DISP_CTRL_LVL_MAX. nbl_disp_refresh_ctrl_ops() also installs only the
two module ops, and only under the MGT level.

Later patches in the series fill this in. The next patch, "dispatch:
implement channel RPC framework and serialize hardware ops", adds
NBL_DISP_CTRL_LVL_NET, the five ops and the responders. The patch after
that, "add common/ctrl dev init/remove operation", adds nbl_dev_remove()
in nbl_dev.c. At the end of the series the comment matches the code; it
only runs ahead of the code at the intermediate commits.

Would it make sense to split this comment so each part lands with the
code it documents?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
