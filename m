Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399427;
	b=yTVgDT8tPC+5CBTrXttUDccMAHho9lhXvR532M3ixXPxIJueaiz9/8pL4n2BNMdTzEOR
	 zc5kLvVFXUJEOXeX8q2R3rSw+1k81NfmbIvcRHu1uRtYZB+qOoyc2DgzM818aeA1m2EGl
	 QzJsB9LPZ0P7Y3b3PPub+s2ecQiQWkBQHrbuZVLXsO5woGbRACBwheD6+Y7OySmR3TQ0o
	 o0hgyRQXGH2FfLgtBX8aariRlLCi3r7xnE69JsQEllORhlXUKLKRb6W90BdIOn4WDdVBT
	 EcxiB17NbfEu7zYDLRXRf2s4MJ1scWpdPBJpxu8hpoQ8dkhoQWdtJ+u3kf2xlwIJQ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399427;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0OUhnsXuNnApLOqX+snDYVrViIC+Bne8/zuEptDdEfE=;
	b=S4al/RPo91zoZpYLuxBWuUR+LB3uM7flma8fUBkUXYKmTS2Zh/g8CyOLJB/1jWgt+z0E
	 HeCjD7cXzPd6F0vba0l/pP4DV5wTMDRnQ/UlyTzK7oNez99C1PQ1c3qw56mPUW/LLuA3X
	 tbraQZ4fvtKmcaVV+MIDkywTeJDB/3twjwknumonfmm39pbMRRu7U05TR94hzPIowUS2a
	 7mYXR1TEy0fOZkAEX2kIBBPcUj3hlfybyPG7qGdQUi+oQSPFfFBsg/JzLgOSrQXnMEvIN
	 Z4dxLQQDINH9VTqnldHxiCtRXHA9YXBkLW+jncIPf1QQ6LFJyW2On9GWAzjXTwl1DhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSv64gGd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C084606A33F;
	Wed, 11 Nov 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSv64gGd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB0B1F00A05;
	Wed, 11 Nov 2026 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399427;
	bh=0OUhnsXuNnApLOqX+snDYVrViIC+Bne8/zuEptDdEfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bSv64gGdermjnKSMSrKhHyFIefH8xJhXzmx9VO5aKPyoAF8YTKbPV/4ghkJKnQH0L
	 kNJfortLIxiO+rjv3FW8y/9H8rpqLw/774RK8BroqC3DB+fuX2Gt/2Mx9upaiby2bC
	 VNULkksFqdl6NWpgccXAPJZYYWdCVaa1+N6Gpu0XOF/0dyYolNSJi+qEIJwi1t9+WJ
	 Q2JgiDFsbDj1QA2zdsN1AGh/k/jWzI5J4p6RUbERoDG5hlOjGmkcQHGtBv5Q5mcHEZ
	 3fQ+gkWeKBs/xgswJx/DC3nl+bH4QggqiGtCRx0vU+TObADWrU4zTMavtSw7yFEuvT
	 uXth4zYG+CqnQ==
Subject:
 Re: [PATCH net] net/sched: release old template when replacing a chain
From: netdev-bot+sashiko@kernel.org
To: shawnq1@163.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 12:17:05 +0000
Message-ID: <179439942593.2199510.2721267685779477046@kernel.org>
In-Reply-To: <20261109121448.2589374-1-shawnq1@163.com>
References: <20261109121448.2589374-1-shawnq1@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a use-after-free race on chain->tmplt_priv.
- [Medium] The patch treats a symptom.
- [Medium] tc_chain_tmplt_add() creates and offloads the new template
  (fl_tmplt_create() -> fl_hw_create_tmplt() sends…
- [Low] The commit message reads like a bug-report email rather than a
  kernel changelog.

--

net/sched: release old template when replacing a chain

With this patch, tc_chain_tmplt_add() destroys any template already on
the chain once the new template has been created. It targets a chain that
a goto-chain action keeps alive after RTM_DELCHAIN and that RTM_NEWCHAIN
then recreates. In that case the old template and its module reference
used to leak.

> Hello,

[ ... ]

> HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
> Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
> Source version: Linux 7.3.0
> Compiler:       gcc 11.4.0, GNU ld 2.38
>
> The console output, kernel config, reproducer, namespace launcher, and
> patched-kernel validation logs are available here:

[ ... ]

[Severity: Low]
This isn't a bug, but the changelog reads like a bug report email. It has
the "Hello," greeting, reproducer instructions, the gist URLs, QEMU test
logistics, the reporter's tree SHAs and compiler versions. It also has the
note that the positive PoC reports a failed threshold on the patched
kernel.

Could this material go below the --- line or into a cover letter, so that
the changelog only covers the problem, its impact and the fix?

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index bd0d635fe3fed..59f96e899c214 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3143,6 +3143,8 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
>  		module_put(ops->owner);
>  		return PTR_ERR(tmplt_priv);
>  	}
> +	/* An action-held chain can retain a template after RTM_DELCHAIN. */

[Severity: Medium]
Should the template survive RTM_DELCHAIN at all? Right now
__tcf_chain_put() only releases it when the chain is finally freed:

net/sched/cls_api.c:__tcf_chain_put() {
    ...
	if (refcnt == 0) {
		tc_chain_tmplt_del(tmplt_ops, tmplt_priv);
		tcf_chain_destroy(chain, free_block);
	}
}

While action_refcnt is non-zero, the delete notification is still sent
through tc_chain_notify_delete(). The chain is then hidden from dumps,
RTM_GETCHAIN and RTM_DELCHAIN, but its template stays active.

This has a few side effects that the patch doesn't address.

After chain N is deleted, tc_new_tfilter() still gets the same chain
through tcf_chain_get(block, N, true). It rejects other filter kinds with
"Chain template is set to a different filter kind":

	if (chain->tmplt_ops && chain->tmplt_ops != tp->ops) {

An RTM_NEWCHAIN without TCA_KIND on that chain takes this early return in
tc_chain_tmplt_add(), so the recreated chain silently inherits the old
template:

	/* If kind is not set, user did not specify template. */
	if (!tca[TCA_KIND])
		return 0;

The old template's hardware offload also stays installed after the
delete.

The new comment describes this retention as expected behaviour. Would it
be better to release the template when the chain becomes action-only,
with suitable synchronization against readers? That would fix the leak
and these cases, and this hunk would not be needed.

> +	tc_chain_tmplt_del(chain->tmplt_ops, chain->tmplt_priv);

[Severity: High]
Can this free the old struct fl_flow_tmplt while an unlocked filter add
is still reading it?

tc_ctl_chain() drops block->lock before it calls tc_chain_tmplt_add(),
so only rtnl is held at this point. RTM_NEWTFILTER is
RTNL_FLAG_DOIT_UNLOCKED. For flower on ingress/clsact or on a shared
block, tc_new_tfilter() skips rtnl_lock() altogether. fl_change() then
reads tp->chain->tmplt_priv without any lock.

CPU0 (RTM_NEWCHAIN, holds only rtnl)
tc_ctl_chain()
    chain->explicitly_created = true;
    mutex_unlock(&block->lock);

CPU1 (flower RTM_NEWTFILTER on chain N, no rtnl)
tc_new_tfilter()
    tcf_chain_get(block, N, true);
    passes the chain->tmplt_ops check
    fl_change()
        loads tp->chain->tmplt_priv (the old template)

CPU0
tc_chain_tmplt_add()
    ops->tmplt_create()
    tc_chain_tmplt_del()
        fl_tmplt_destroy()
            fl_hw_destroy_tmplt(tmplt->chain, tmplt);
            kfree(tmplt);

CPU1
fl_mask_fits_tmplt(tp->chain->tmplt_priv, mask)
    reads tmplt->mask from the freed object

The free also happens before the new pointers are stored. A reader that
loads chain->tmplt_priv between the kfree() and this store gets a pointer
that is already dangling:

	chain->tmplt_priv = tmplt_priv;

Before this patch, the only template free was in __tcf_chain_put() at
refcnt == 0, when nothing else could hold the chain. The commit message
notes that a user namespace is enough for CAP_NET_ADMIN, and running
DELCHAIN/NEWCHAIN cycles next to concurrent flower filter adds would
reach this window.

[Severity: Medium]
With this order, fl_hw_create_tmplt() sends FLOW_CLS_TMPLT_CREATE for the
new template before fl_hw_destroy_tmplt() sends FLOW_CLS_TMPLT_DESTROY for
the old one. Both use the same chain_index. Can that leave offload drivers
in the wrong state?

The in-tree drivers seem to assume one template per chain index, and they
match DESTROY by chain_index only. In sparx5, create records the current
port keyset as orig:

drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c:sparx5_tc_flower_template_create() {
    ...
	sparx5_vcap_set_port_keyset(ndev, admin, fco->common.chain_index,
				    state.l3_proto,
				    ftp->keyset,
				    &kslist);

	if (kslist.cnt > 0)
		ftp->orig = kslist.keysets[0];
    ...
}

Here orig is the old template's keyset. Destroy then restores orig from
the first entry with a matching cid, which is the old template's entry:

drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c:sparx5_tc_flower_template_destroy() {
    ...
	list_for_each_entry_safe(ftp, tmp, &port->tc_templates, list) {
		if (ftp->cid != fco->common.chain_index)
			continue;

		sparx5_vcap_set_port_keyset(ndev, admin,
					    fco->common.chain_index,
					    ftp->l3_proto, ftp->orig,
					    NULL);
    ...
}

So the port runs the keyset from before any template while the new
template is active. Once the new template is destroyed, the port goes
back to the old template's keyset.

In mlxsw, mlxsw_sp_flower_tmplt_create() reuses the existing ruleset for
the chain index through mlxsw_sp_acl_ruleset_get(), so the new template's
elusage is ignored. In prestera, prestera_acl_ruleset_keymask_set()
overwrites ruleset->keymask with kmemdup() without freeing the previous
one, so each cycle leaks one keymask.

The mlxsw and prestera behaviour already existed before this patch, but
create-first keeps it, while destroy-then-create would let the ruleset be
released and rebuilt.

The commit message says create-first keeps the old template intact if
creation fails. Would destroying the old template first give drivers a
consistent sequence?

>  	chain->tmplt_ops = ops;
>  	chain->tmplt_priv = tmplt_priv;
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109121448.2589374-1-shawnq1%40163.com
