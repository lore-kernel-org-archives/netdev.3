Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333303;
	b=SOF8Ji9TKvoLhhmapXKpNGr+AJufGYT6uOXBHR9xB1nvHBa1CYsCNM1s6GldhMvLC9C0
	 hN1ejmbxH/qcjDe/EYnBv+Q+vZm7q53N/huVAHqpLGCnTCYvOxhgbNmKTIGNoa1tgAgpS
	 jVe/eqw0TIgx+0T4ntbYEL7F2lMqM2SkQlP0Adji++/1rQuOObCoKN3eb4ZGZyFAoAQag
	 9biVMi/O065sTZ201UgShxNEobnWOBL2p1RQ3C4XsWAxpTwMCCFmQZqJ1r8fDKcAEV0/l
	 yzem0/KX5at7TBjEyFo3RpT2IhNP4PKBBuFsmTnuy9KITGhdQ8FbHjVRdLLCAWPNBMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333303;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ewxuNeKaO6r4oMsh/j7jPcWeeo2xBo5mZhFZfUt75lk=;
	b=uLP4nEcpngrObDVM/wE0RBA8CxxQG0ReAQ0J6bYUJXO3x3XFyzA5PvCfNb6pND/djZ+R
	 HrcfLbyr1mKyi8V8QKxc2eIxR1hSD6Jo6ZEPQVqVvKgNKmMzgT+9FNyEuTPD3WoKx5N1F
	 aJgzWcPA4BcBpV9m2dm3S3mIvG/epUmlcKIq2dr6gYgJkV0ok6Xs0vFqw52D4PYrforAf
	 gLf/ru5AgdIh6prIA4a3xDoeMsgymjBFkdo9+6DCetFfzbeGy8oiQMvCWj52mZI9+84Il
	 ITOkL1aZIv1ufXhS5K0cPmSlwqEsT9EgQYDVP1Z3o9L+mpF7nBmEkh2kdfB+aLhlOfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7RH49Il;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69631606A31C;
	Fri, 30 Oct 2026 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7RH49Il
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6804E1F000C1;
	Fri, 30 Oct 2026 04:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793333303;
	bh=ewxuNeKaO6r4oMsh/j7jPcWeeo2xBo5mZhFZfUt75lk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i7RH49Il/Nwy0naD1/7S5vwKWnUXuwqlbItGWVc3RZALHnkfCJv2EYUKp/Axu6CEA
	 a3MpZrUzd4bNyBH0q94kn3JmomWXUrplysI5sNUfxbgghfiDHtEJ1aYXJ7kQ4i7EGU
	 dbinjij74u2gY3ZJD0T5yY5Nv9c0VGZuuHe8vjDwmXlN0JXH+3oYlZDMOiCqf5sWO5
	 kY0lP79BJEh9ZLVjmsDdyQSS4x5MGTEFOAzdZNft0IaeP1QQptMIrTgDCfu5S8FRpc
	 lljt2Zzp8i3rsY2H7IMtdj3thxM5JfrmEgkfiojd+PYBbrE0oY70Mks3UdT2mFvGeL
	 7/c66zQT8w8QA==
Subject:
 Re: [PATCH 1/1] octeontx2-af: Fix npc_delete_flow counter read for cn20k
From: netdev-bot+sashiko@kernel.org
To: vmukunda@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgoutham@marvell.com,
 rkannoth@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Date: Fri, 30 Oct 2026 04:08:21 +0000
Message-ID: <179333330197.3134.6687682225633311967@kernel.org>
In-Reply-To: <20261026035140.666684-1-vmukunda@marvell.com>
References: <20261026035140.666684-1-vmukunda@marvell.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The Fixes tag `Fixes: 5f83b4729440 ("octeontx2-af: Do not access
  match stats for cn20k")` does not resolve.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it sits on
  the line the patch edits.
- [Medium] This problem wasn't introduced by this patch, but the patched
  assignment `rsp->cntr_val = rvu_read64(...)` in…
- [Low] In rvu_mbox_handler_npc_delete_flow() (rvu_npc_fs.c:1961-1962),
  the result of rvu_get_blkaddr() is checked for truthiness (`if…

--

octeontx2-af: Fix npc_delete_flow counter read for cn20k

This commit makes rvu_mbox_handler_npc_delete_flow() skip the
NPC_AF_MATCH_STATX read on cn20k silicon. On cn20k the MCAM match counter
cannot be read from that register, and counter support for cn20k is left
for later.

> Fixes: 5f83b4729440 ("octeontx2-af: Do not access match stats for cn20k")

[Severity: Low]
Is this Fixes: tag correct? 5f83b4729440 doesn't resolve to any commit in
the tree.

The unguarded read in rvu_mbox_handler_npc_delete_flow() came from
ec87f05402f5 ("octeontx2-af: Install TC filter rules in hardware based on
priority"). The is_cn20k() guards on the other NPC_AF_MATCH_STATX users
blame to 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for
CN20K silicon").

Could this be a hash from an internal tree? If so, should the tag point to
one of the upstream commits above?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index ec004ea5154cb..948a30c8fe008 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1959,7 +1959,7 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
>  			/* single rule */
>  			} else if (req->entry == iter->entry) {
>  				blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> -				if (blkaddr)
> +				if (blkaddr && !is_cn20k(rvu->pdev))

[Severity: High]
Is this fix complete for cn20k? rvu_dbg_npc_rx_miss_stats_display() still
reads NPC_AF_MATCH_STATX without an is_cn20k() check:

drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:rvu_dbg_npc_rx_miss_stats_display() {
    ...
	seq_printf(filp, "\t\tStat %d: \t%lld\n", mcam->rx_miss_act_cntr,
		   rvu_read64(rvu, blkaddr,
			      NPC_AF_MATCH_STATX(mcam->rx_miss_act_cntr)));
    ...
}

rvu_dbg_npc_init() creates the rx_miss_act_stats file on every silicon,
cn20k included.

On cn20k, rvu_npc_setup_interfaces() takes the cn20k branch and never
reserves a counter, so mcam->rx_miss_act_cntr stays 0. The RX loop also
hits "if (is_cn20k(rvu->pdev)) continue;" before it writes
NPC_AF_INTFX_MISS_STAT_ACT.

So reading this file on cn20k accesses STATX(0). The commit message says
that register cannot be read on cn20k, and the value printed is not an RX
miss count.

After this patch, this debugfs reader seems to be the only
NPC_AF_MATCH_STATX user in af/ that cn20k can still reach. Should it get
the same guard, or should the file not be created on cn20k?

[Severity: Low]
This isn't a bug introduced by this patch, but it is on the line being
changed. rvu_get_blkaddr() returns -ENODEV on failure, never 0, so
"if (blkaddr && ...)" lets a negative value through. Other callers in
these files check "blkaddr < 0".

I don't think it can trigger here. Rules only get onto mcam->mcam_rules
through rvu_mbox_handler_npc_install_flow() and
npc_install_mcam_drop_rule(), and both return early when blkaddr < 0.

Would it still be clearer to use blkaddr < 0 here, to match the other
callers?

>  					rsp->cntr_val = rvu_read64(rvu, blkaddr,
>  								   NPC_AF_MATCH_STATX(iter->cntr));

[Severity: Medium]
This is a pre-existing issue, but should this read also check
iter->has_cntr?

__rvu_mcam_remove_counter_from_rule() frees the counter and clears
has_cntr, but rule->cntr keeps the old index:

drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:__rvu_mcam_remove_counter_from_rule() {
    ...
	free_req.cntr = rule->cntr;

	__npc_mcam_free_counter(rvu, &free_req, &free_rsp);
	rule->has_cntr = false;
}

That happens when a PF/VF installs a rule with set_cntr=1 and then
re-installs it with set_cntr=0, which reaches this in npc_install_flow():

	if (!req->set_cntr && rule->has_cntr)
		rvu_mcam_remove_counter_from_rule(rvu, owner, rule);

Another PF/VF can then get the freed index through the
npc_mcam_alloc_counter mailbox. When the first function deletes its rule,
rsp->cntr_val gets the other function's live match count.

A rule that never had a counter has cntr == 0, so it reads counter 0 the
same way.

rvu_dbg_npc_mcam_show_rules() already does "if (!iter->has_cntr)
continue;" before the same register read.

[Severity: Medium]
This isn't a bug introduced by this patch, but does this assignment
truncate the hardware counter? The value goes into a u16:

drivers/net/ethernet/marvell/octeontx2/af/mbox.h:
struct npc_delete_flow_rsp {
	struct mbox_msghdr hdr;
	u16 cntr_val;
};

rvu_mbox_handler_npc_mcam_counter_stats() treats the same register as
48 bits wide:

	rsp->stat = rvu_read64(rvu, blkaddr, NPC_AF_MATCH_STATX(req->cntr));
	rsp->stat &= BIT_ULL(48) - 1;

The PF TC code passes this value from otx2_del_mcam_flow_entry() back
through npc_install_flow_req's "u16 cntr_val; /* old counter value */".
npc_install_flow() then writes it into NPC_AF_MATCH_STATX(rule->cntr).

So any TC flower rule with more than 65535 hits loses the upper bits of
its count each time its entry is shifted or re-installed. Fixing this
would need a change to the mailbox message layout.

>  				list_move_tail(&iter->list, &del_list);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026035140.666684-1-vmukunda%40marvell.com
