Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606365;
	b=IEah7wcOXYhDWHkAGBQiRKbV83FVK7FvoDpHMLuZqgvKBLqEAum+LzHjDMkA79PVm5RZ
	 SCRN8YHsQ33CRogWnmB/GkKIvMeeQOaeed+VP0J7NZ5wD99iCglOG54KMn4hg1+JpJTIJ
	 UOXuIoYjy/4Ah/QJUuTmOzBBNf+1DA87mWEdEk5bgsYKWEFhhKX+SFJ5Lv5bP0BSlkvGo
	 PVixx0boL+rxpNidfxz7dF8Zw8HkQVvKicWx6OymIu0JQ38r0Ek7REoU3k2y8rph7EDL1
	 cOtSgGzooQbU2tTyXzkYH9iFlcNhk/QG6DKbvy5v9F4lO/Swc3fGVGQwij51ECm6v8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606365;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4itan0z6idVXJaSwpdgK+pOjvqnAwI1VzxVuhnwVsgQ=;
	b=HDXfVaWNhDSpvT7ugIYe/rDwClwaXQC/MuN0qmiWgxOccNPm+/4Z6ZFAnAmreLOlff5g
	 cCRo34vL+z1nxTpcE3IdwZIpdBA0R3dn3gFEtD0WOfGE/gk8e0RNzqEDLTa9gMx70Veuy
	 MFNtebzjPv5hnx0ZB1XWc5t817RaE22A7dfM2weQydMxmgvOn9N8GbaNJAhmSqJWJArOE
	 olXz/8OJ17x4NO4RgcYirsLO88cLkmiEIIU6QKuA6KkzeVo4YmF6tgweJ9US4WZSMvYku
	 MEzWS49MSePACj1q9G2qKqbrdMdV09mkSRkn8ECPWUjrnDqAAGudrHuqCTYkpSWhBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxrixWPh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D987606A324;
	Mon,  2 Nov 2026 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxrixWPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C66F1F000C1;
	Mon,  2 Nov 2026 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606364;
	bh=4itan0z6idVXJaSwpdgK+pOjvqnAwI1VzxVuhnwVsgQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jxrixWPh+oWgZe4KYUtQitxUv0q6binfdzYmyLnRhCk+MhMgPu5bBL5s0L1BfZbiA
	 MefA8HkynGpG7fgoCRg858/9bR4YvS5XNICcI9Yn2xwbBBH0BT8h01hd4dkMfWF4q7
	 DGwglDJrEWqSoLdzww4gL5O3TJcK61w6bB8dIeJIhbaLgx2MjVdmJhhnZwSgX9uH92
	 pcLXMoImI9FYvzfxlgDGAJBSTelCPD+uKHA2cec7ShY66A3PwkdlVvMHlr0rT8RPDr
	 uXSVqxdILMlGkpZ/aOQQ/3F9yaCtTUhV6eiiyt2brm57Of6MOyKUSn4LkdeALaYhSm
	 gOG3K4lFaGoJA==
Subject:
 Re: [PATCH] octeontx2-af: fix TX hang after link mode change under traffic
From: netdev-bot+sashiko@kernel.org
To: vmukunda@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sgoutham@marvell.com,
 rkannoth@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, naveenm@marvell.com
Date: Mon, 02 Nov 2026 07:59:23 +0000
Message-ID: <179360636359.3131.7702148387934087179@kernel.org>
In-Reply-To: <20261029074635.4139111-1-vmukunda@marvell.com>
References: <20261029074635.4139111-1-vmukunda@marvell.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] TL1 SW_XOFF is set one way and cleared another, so on some
  silicon it is never cleared.
- [Medium] The Fixes: tag points at commit 62945033ea22 ("octeontx2-af:
  poll for tx link credits before link mode change"), which is not in…
- [Medium] The credit-return poll in
  rvu_nix_tl1_xoff_wait_for_link_credits() has a fixed budget: count =…
- [Medium] Nothing serializes the new TL1 SW_XOFF set -> credit poll ->
  cgx_set_link_mode() -> clear sequence against FLR teardown.
- [Low] The commit message says a credit poll timeout 'is only reported
  with a warning', but rvu_nix_tl1_xoff_wait_for_link_credits() logs it…
- [Low] The timeout message in rvu_nix_tl1_xoff_wait_for_link_credits()
  prints two u64 values (tx_credits and ((regval >> 12) & 0xFFFFF)) with…

--

octeontx2-af: fix TX hang after link mode change under traffic

The patch sets TL1 SW_XOFF and polls for the TX link credits to return
before a CGX/RPM link mode change. It clears TL1 SW_XOFF afterwards,
including when the change fails. The aim is to stop the link credits from
going negative and hanging TX.

> Fixes: 62945033ea22 ("octeontx2-af: poll for tx link credits before link mode change")

[Severity: Medium]
Is this the right commit for the Fixes: tag? 62945033ea22 does not seem
to exist in the tree, and git show reports an unknown revision. The
quoted subject also describes what this patch itself does.

git blame on rvu_mbox_handler_cgx_set_link_mode() shows that the handler
and its cgx_set_link_mode() call come from 56b6d539861358. Later changes
came from 25d51ebf0f54f9, 5f21226b79fd8f and 4a3dba48188208.

Could the tag name the upstream commit that introduced this path, or be
dropped? Stable tooling can't resolve the current SHA.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 41f157ea27f4b..fbcc1038af4b2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -1235,8 +1235,13 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
>  	else
>  		linkmodes = &rvu->fwdata->cgx_fw_data[cgx_idx][lmac];
>
> +	rvu_nix_tl1_xoff_wait_for_link_credits(rvu, req->hdr.pcifunc);
> +
>  	rsp->status = cgx_set_link_mode(cgxd, req->args, linkmodes,
>  					cgx_idx, lmac);
> +
> +	rvu_nix_tl1_xoff_clear(rvu, req->hdr.pcifunc);
> +
>  	return 0;
>  }

[Severity: Medium]
What serializes this set, poll, mode change and clear sequence against
FLR teardown? The mbox handler holds neither rvu->rsrc_lock nor
rvu->flr_lock. Meanwhile a VF FLR runs on rvu->flr_wq:

__rvu_flr_handler()
  rvu_blklf_teardown()
    rvu_nix_lf_teardown()
      nix_txschq_free()
        nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
                          nix_get_tx_link(rvu, pcifunc));

nix_get_tx_link() maps a VF to its parent PF's link. That makes it the
same TL1 SW_XOFF register that is held here across cgx_set_link_mode(),
which can take up to CGX_CMD_TIMEOUT (5000 ms).

If the VF FLR lands during the firmware mode change, TL1 XOFF is cleared
and PF traffic resumes partway through the change. Could that bring the
credit loss back?

If the XOFF set here happens after nix_txschq_free() has cleared the
XOFFs ahead of its SMQ flush, could the flush hit a stopped TL1 and time
out?

If a PF FLR detaches the NIX LF between the set and the clear,
rvu_nix_tl1_xoff_clear() repeats the lookup:

	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
	if (blkaddr < 0)
		return NIX_AF_ERR_AF_LF_INVALID;

Would that return without clearing, and leave the shared TL1 stopped for
the VFs?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 29559db689290..b5122b8647ae2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> +int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc)
> +{
> +	int link, blkaddr, count = 1000;
> +	u64 tx_credits, regval;
> +	struct nix_hw *nix_hw;

[ ... ]

> +	/* set TL1 sw_xoff */
> +	link = nix_get_tx_link(rvu, pcifunc);
> +	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(link), 1);
> +
> +	/* wait for link credits to return */
> +	tx_credits = nix_hw->tx_credits[link];
> +	while (1) {
> +		regval = rvu_read64(rvu, blkaddr,
> +				    NIX_AF_TX_LINKX_NORM_CREDIT(link));
> +		if (((regval >> 12) & 0xFFFFF) == tx_credits)
> +			break;
> +		count--;
> +		if (!count) {
> +			dev_info(rvu->dev, "TX link(%d) credit poll timeout, expected=%lld credits=%lld\n",
> +				 link, tx_credits, ((regval >> 12) & 0xFFFFF));

[Severity: Low]
The commit message says "A timeout in the credit poll is only reported
with a warning", but this uses dev_info(). Should this be dev_warn(), or
should the commit message be changed?

[Severity: Low]
This isn't a bug, but tx_credits and the masked regval are both u64.
Should these use %llu, or %#llx like the other register dumps?

> +			return -ETIMEDOUT;
> +		}
> +		cpu_relax();
> +		udelay(1);
> +	}

[Severity: Medium]
Is 1000 iterations of an MMIO read plus udelay(1), about 1-2 ms, enough
for the credits to come back? The expected value is set in
nix_link_config():

	tx_credits = (lmac_fifo_len - lmac_max_frs) / 16;

So the outstanding credits are bytes still in the LMAC TX FIFO, and those
only drain at line rate. A full FIFO of tens of KB takes about 5 ms at
100M and about 50 ms at 10M. If the peer is sending PAUSE/PFC, there is
no upper bound.

On timeout, rvu_mbox_handler_cgx_set_link_mode() ignores the -ETIMEDOUT
and starts the firmware mode change with credits still outstanding.
NIX_AF_TX_LINKX_NORM_CREDIT is only programmed at init by
nix_link_config(). Can the TX hang this patch targets still happen on
slow or backpressured links?

nix_smq_flush() handles a similar drain differently. It enables LMAC TX,
disables RX backpressure and uses a jiffies-based timeout. Would a
similar approach work here?

> +	return 0;
> +}
> +
> +int rvu_nix_tl1_xoff_clear(struct rvu *rvu, u16 pcifunc)
> +{
> +	int blkaddr;
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
> +	if (blkaddr < 0)
> +		return NIX_AF_ERR_AF_LF_INVALID;
> +
> +	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
> +			  nix_get_tx_link(rvu, pcifunc));

[Severity: High]
Does this clear TL1 SW_XOFF on all silicon?
rvu_nix_tl1_xoff_wait_for_link_credits() always sets it:

	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(link), 1);

However, nix_clear_tx_xoff() returns before writing anything when
shaping is not supported:

	/* Skip this if shaping is not supported */
	if (!hw->cap.nix_shaping)
		return;

rvu_setup_hw_capabilities() sets hw->cap.nix_shaping = false whenever
is_rvu_pre_96xx_C0() is true. That covers 96XX A0/B0 and 95XX A0/A1/B0.

On those parts, would every CGX_SET_LINK_MODE request from a CGX-mapped
PF leave the link's TL1 in XOFF? That would stop TX for the PF and all
of its VFs.

No other path seems to clear it on those parts either.
handle_txschq_shaper_update() only runs when nix_shaper_toggle_wait is
set, and that is false on pre-96xx-C0. nix_txschq_free() also goes
through nix_clear_tx_xoff().

This also seems to contradict the commit message, which says SW_XOFF is
cleared "so that a failed request does not leave the link stopped".

Could the set and the clear be gated the same way? One option is to
write 0 directly here. Another is to skip the set when
!hw->cap.nix_shaping.

> +	return 0;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029074635.4139111-1-vmukunda%40marvell.com
