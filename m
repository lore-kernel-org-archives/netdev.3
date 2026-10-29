Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265188;
	b=Ch2ILLQouzFg1gPbmGv/gaR2wvOXvCeLDZQ7y4X+DjJ/0nuLXfoUAeaEcnqW6XA6GdaW
	 /cf0IKe1x9bzMTHf/Eu+ijLoBx2bNN+pDJVEEYueu5FTN6Lsd4/qH7Wh6u+T87noHZAra
	 qv+0bDr3M1gDIubbacL1oMVPdSpC1+CiyKdJI8vDH8PYl22/Iz1LMB4kfH2vhGiyiZyCp
	 xWUmkt7vHcKQANGQZ/kqCD4ypYCqeVrIYtU//7JKriMWxHdGZpbiWGJ+8w++0OvbhvBHA
	 LAhyRMpO/JpAZmK/mLRq5RxMnSQtD/3qyqfADBsGSYbhk9lFhdRvAtwAM03YTGzznIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265188;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oRWZtpS99MTTHtzoW8VUxUtYuwvdUmP6KxYecfdsdzk=;
	b=fbi4TcTsYz3cw6MnKgIwIT6VMV5N/wa46aguB7s9rVf+cBHVwU3Tm9Y91LPkmwx7l4Gq
	 Sd4ZzX2Aepi2MdCLKMJy2xiLZLw/lcTZZZDi5ul0TE2ZQJHhqQNI2nWRadmYb/OLGGToE
	 XWkl7ZsGl1crSn7hyv2MGV24Du5jSOw6eRXjZnx4atzz8M8npXYVlMcEQiTqmvuXW0ArP
	 My0UPlgn4P8jwGCP6HcyFccjFSWhKsAegJndklCuEs/uIGKNHbj3uRcwhafucvKsIeBub
	 AoE7kuXgTOkfKbi65xCoZvXtSeeYcKz9B889ksZAerHbN+TFkC8zShPYroZ4g/ABP3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="o0y+s/Qd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639D606A31A;
	Thu, 29 Oct 2026 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0y+s/Qd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDED1F01828;
	Thu, 29 Oct 2026 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265187;
	bh=oRWZtpS99MTTHtzoW8VUxUtYuwvdUmP6KxYecfdsdzk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o0y+s/QdbEDfuedDekZTMJCWvcZO20oL69jBLYTJlVI2yC5zcxUM9+7oqnIVRWuQK
	 oHTHGQjAa2NdeNd+jvlppYSQTFYYkNN1bTtnJdiMnXeTPA4/vLSBYpLacCJuUplJiO
	 +ktuLX+ZezAsWZ6xIlCnYC6mavPStQmwCGNaw/6rTs2ivOS7D7atgY04vxaEvHBKjY
	 7Yu10/0/5ifDRmTTWkoXz3WnDXJ5qAQjMdPoYL85YeGS671Gq3PieEQURQ8wlCBM/M
	 f+zbP8ANahg4jpROC62M2qUEbGNmjTN7ODzvczcHLxgX4Vg6WRKSYST4lZW+XVaaog
	 OchmKawKUc4JQ==
Subject: Re: [PATCH net] octeontx2-af: skip CPT ctx flush command when no CPT
 LFs are attached
From: netdev-bot+sashiko@kernel.org
To: kmahammadraf@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sgoutham@marvell.com,
 rkannoth@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, schalla@marvell.com
Date: Thu, 29 Oct 2026 09:13:06 +0000
Message-ID: <179326518645.3134.9563547199607113486@kernel.org>
In-Reply-To: <20261026091001.3421476-1-kmahammadraf@marvell.com>
References: <20261026091001.3421476-1-kmahammadraf@marvell.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new guard in cpt_inline_inb_lf_cmd_send()
  (drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c:1157-1162) builds…
- [Medium] rvu->cpt_pf_num comes from get_cpt_pf_num()
  (rvu_cpt.c:387-406).
- [Low] The patch fixes a user-visible defect but has no `Fixes:` tag,
  and the commit message only says the mbox 'can lead to avoidable…
- [Low] Sign-off chain and authorship are inconsistent.
- [Low] The new guard reads rvu->pf[cpt_pf].cptlfs / cpt1_lfs through
  rvu_get_rsrc_mapcount() without holding rvu->rsrc_lock.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  cpt_inline_inb_lf_cmd_send() the DMA result buffer `res` is mapped and…

--

octeontx2-af: skip CPT ctx flush command when no CPT LFs are attached

This commit adds a guard to cpt_inline_inb_lf_cmd_send(). The guard
counts the CPT LFs mapped to the CPT PF and returns early when there are
none, so the uplink mailbox message is not sent in that case.

> CPT inline inbound LF command submission was attempted even when no CPT
> LFs were mapped to the CPT PF. In that case, sending the uplink mailbox
> message is unnecessary and can lead to avoidable failures/timeouts during
> CPT context flush flow.

[Severity: Low]
Should this have a Fixes: tag?

When the CPT PF has no LFs, handle_msg_cpt_inst_lmtst() in
drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c skips the submission
but still replies with success:

	if (cptpf->lfs.lfs_num)
		lfs->ops->send_cmd((union otx2_cpt_inst_s *)req->inst, 1,
				   &lfs->lf[0]);

*res then stays 0xFFFF. The AF busy-waits 3000 x mdelay(1) in
cpt_inline_inb_lf_cmd_send() and logs "Poll for result hits hard loop
counter". This happens on every NIX LF teardown with an IPsec SA base and
on every cpt_ctx_cache_sync mbox.

The unconditional submission came from commit 149f3b73cb66
("octeontx2-af: Add support to flush full CPT CTX cache"), which looks
like the right Fixes: target.

Could the commit message also describe the roughly 3 second busy-wait
and the warning, rather than just "failures/timeouts"?

> Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
> Signed-off-by: Srujana Challa <schalla@marvell.com>

[Severity: Low]
The commit author is Srujana Challa, but the first Signed-off-by is
"kmahammadraf <kmahammadraf@marvell.com>" and there is no
Co-developed-by: tag.

Documentation/process/submitting-patches.rst asks for a real name. It
also asks that a co-author's Signed-off-by come right after a
Co-developed-by: tag. Could the trailers be fixed up to match?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> index f404117bf6c8c..751643176c6d1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> @@ -1144,15 +1144,23 @@ int rvu_cpt_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int lf, int s
>  static int cpt_inline_inb_lf_cmd_send(struct rvu *rvu, int blkaddr,
>  				      int nix_blkaddr)
>  {
> -	int cpt_pf_num = rvu->cpt_pf_num;
> +	int cpt_pf_num = rvu->cpt_pf_num, num_lfs;

[ ... ]

> +	pcifunc = (cpt_pf_num & RVU_OTX2_PFVF_PF_MASK) <<
> +	      RVU_OTX2_PFVF_PF_SHIFT;

[Severity: High]
On CN20K, does this pcifunc still point at the CPT PF?

This always encodes with the OTX2 layout (shift 10, mask 0x3F). But
rvu_get_pfvf() decodes with rvu_get_pf(), which picks the layout based
on the silicon:

drivers/net/ethernet/marvell/octeontx2/af/rvu.h:rvu_get_pf() {
	if (is_cn20k(pdev))
		return (pcifunc >> RVU_CN20K_PFVF_PF_SHIFT) &
			RVU_CN20K_PFVF_PF_MASK;
	...
}

RVU_CN20K_PFVF_PF_SHIFT is 9, so this decodes to 2 * cpt_pf_num. The
guard then reads cptlfs or cpt1_lfs from a different PF's rvu->pf[]
entry.

rvu_cpt_ctx_flush() only returns early for is_rvu_otx2(), so CN20K does
reach this helper. If that other PF has no CPT LFs, the early return
skips the CPT_INST_S drain barrier. rvu_cpt_ctx_flush() then goes on to
cpt_rxc_teardown() and the CTX flush without waiting for in-flight
inline inbound packets to drain.

rvu->pf[] is also allocated with only hw->total_pfs entries. Can
2 * cpt_pf_num index past the end of it?

rvu_make_pcifunc(rvu->pdev, cpt_pf_num, 0) already handles both layouts.
Would it be the right encoder here?

[Severity: Medium]
What happens here if rvu->cpt_pf_num is -1?

get_cpt_pf_num() starts with cpt_pf_num = -1. It returns that value
when no PCI_DEVID_OTX2_CPT_PF or PCI_DEVID_OTX2_CPT10K_PF device is
found, and rvu_cpt_init() stores it without checking.

(-1 & 0x3F) << 10 gives 0xFC00. rvu_get_pfvf() would then index
rvu->pf[63], or rvu->pf[126] with the CN20K decode, and
rvu_get_rsrc_mapcount() would dereference that entry. rvu->pf[] is sized
to hw->total_pfs, and rvu_get_pfvf() has no bounds check.

If the out-of-bounds count happens to be non-zero, execution continues
into otx2_mbox_alloc_msg_rsp() and otx2_mbox_msg_send() with devid -1.

It isn't clear whether a supported non-OTX2 platform can end up with no
CPT PF here. Even so, should the guard check cpt_pf_num < 0 before it
builds pcifunc?

> +	num_lfs = rvu_get_rsrc_mapcount(rvu_get_pfvf(rvu, pcifunc),
> +					blkaddr);

[Severity: Low]
Is it safe to read the CPT PF's cptlfs or cpt1_lfs here without holding
rvu->rsrc_lock?

These counters are updated in rvu_update_rsrc_map() under rsrc_lock. The
callers are the attach handler and rvu_detach_rsrcs(), and the FLR
worker __rvu_flr_handler() also reaches rvu_detach_rsrcs().

The caller, rvu_cpt_ctx_flush(), does its own mapcount check under the
lock a few lines later:

	mutex_lock(&rvu->rsrc_lock);

	num_lfs = rvu_get_rsrc_mapcount(rvu_get_pfvf(rvu, pcifunc),
					blkaddr);

Suppose the CPT PF detaches its last LF after this check has seen a
non-zero count. The mbox is still sent, the CPT PF handler finds no
LFs, and the AF waits out the full poll timeout this patch is meant to
avoid.

In the other direction, a concurrent attach could be missed and the
barrier skipped.

> +	if (num_lfs == 0)
> +		return 0;
> +
>  	res = kzalloc(CPT_RES_LEN, GFP_KERNEL);
>  	if (!res)
>  		return -ENOMEM;

[Severity: Medium]
This isn't a bug introduced by this patch, but further down in
cpt_inline_inb_lf_cmd_send() the result buffer is unmapped and freed
even when the mbox response failed or the poll timed out:

drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c:cpt_inline_inb_lf_cmd_send() {
    ...
	rc = otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, cpt_pf_num);
	if (rc)
		dev_warn(rvu->dev, "notification to pf %d failed\n",
			 cpt_pf_num);
    ...
	if (timeout == 0)
		dev_warn(rvu->dev, "Poll for result hits hard loop counter\n");

res_daddr_unmap:
	dma_unmap_single(rvu->dev, res_daddr, CPT_RES_LEN, DMA_BIDIRECTIONAL);
res_free:
	kfree(res);
    ...
}

res_daddr is passed to the hardware in inst[1] of the CPT_INST_S. If
the CPT PF submits the instruction late, or CPT completes it after the
3 second poll, could the hardware write the result into res after it
has been freed?

Without an IOMMU, or in passthrough mode, that memory may already have
been reused.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026091001.3421476-1-kmahammadraf%40marvell.com
