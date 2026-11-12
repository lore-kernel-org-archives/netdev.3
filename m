Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523930;
	b=f3x9OaC7BBW6HERZok8Yc1cjQD1heUtGL4n8L6uxHOh7sfbyHp3REQpdpxcHdz8pnRXq
	 A/lBtifm8P7tI9bhy5loPxInGJ6poo5OFn0od+GtPT5Kpo+2aGRRNLhsJR1fZzWZTDGnv
	 uHJenXVzg57eVqSU47WZMcg4hW/jkBhQeUnyRXKyvV6Pdn9dnS0IV7V6gHafkmfd0zyFJ
	 T7eE8xYqewYt4ZDJmekokkvWOrie/rGmjx49OzIWKPIG42UD2YE08qln4tGwYLgYQvubJ
	 e9LKokzS1GJw/z+oOB9CM71JCkeW3C0/isoCw7cc0via3wMTEP1khvJ4Wu89LGqHXMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523930;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HnFbRd2cUO/ogYhoab3tVa+ZjsPjiekhdbMq6gcnrhc=;
	b=Tuprn6H9ihx0b9Dn8i0iPwV0nylfyUTrvYQ4+DHAyrLyoVIfSXU/WrnhkJi+u5ZYReTU
	 1EEyFiLBZOHwVWj9aZhhiGrxzLaRux387HelyrazaHMoAFlEf/Bj3l0vqV41ElYUC/iFu
	 2rGps5TyczhH93gAXh47zG8VOEBmbiRz40cWmmkAa17WO7YTSD3w90eFJmTx/jQ2FeVCb
	 wWTT2F7eKrkHiT4/Mc+38NGfjA3Iu7jGoJ4Lj0X0bnJMLHWliR+7otOs/pkBA3BL+f85a
	 nEgnEmnFiDrhGa89HPKZ7KPJxn1Jgaw5Ahm5ocoZ027HKQ3AfcyPxI8wDk7r47jRt7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyqW2l4i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16409606A31C;
	Thu, 12 Nov 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyqW2l4i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADA11F000C4;
	Thu, 12 Nov 2026 22:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794523929;
	bh=HnFbRd2cUO/ogYhoab3tVa+ZjsPjiekhdbMq6gcnrhc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lyqW2l4iaa67g+0HwmN2Un9DQV8xTfYC5uFM8H/wCiCRuJF5mmzuk3Fb/eY9CAJ+S
	 u/NKBauFdVPRcJ/TEd8jVyF5VB37guMqFWqHiNqt1tIvK1ERYT7hIuqHqs0CoY+JW/
	 xzoqMLE4i+cvyhdTFXIFi9rtMC+Ezj0d0FZFcG6j0k1vg7fzFRh8wtJZuUNqW9jGlG
	 TU7K0qFkNhz0tWH7/zi7K+mCZKNQ48oTOJdfGSPz5qo0vJglUuD8FVNq0jrfBmxcML
	 PtbACUSVHhtYsz+CZMRec7a9+VkXTRS6F2IaLrAU3FjzqXJcVsJCnUqlPDEctTyipP
	 IMEDqDRG5HZrA==
Subject: Re: [PATCH net] octeontx2-af: Fix keep PF_FUNC match for AF TX rules
 in rep mode
From: netdev-bot+sashiko@kernel.org
To: kmahammadraf@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sgoutham@marvell.com,
 rkannoth@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, athapliyal@marvell.com
Date: Thu, 12 Nov 2026 22:52:08 +0000
Message-ID: <179452392874.2199510.9170447818850423839@kernel.org>
In-Reply-To: <20261109105043.1986921-1-kmahammadraf@marvell.com>
References: <20261109105043.1986921-1-kmahammadraf@marvell.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The commit message gets the scope of the bug wrong.
- [Low] The Signed-off-by chain is malformed.
- [Low] The comment above the changed condition in npc_update_tx_entry()
  (drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c) still reads…

--

octeontx2-af: Fix keep PF_FUNC match for AF TX rules in rep mode

When rep_mode is enabled, npc_update_tx_entry() no longer clears the
PF_FUNC mask for TX MCAM rules that the AF installs. Those rules now
match on the target PF_FUNC instead of wildcarding it.

> Currently, npc_update_tx_entry() clears PF_FUNC mask for AF-requested
> rules. In rep_mode, that wildcard can make a TX rule match traffic for
> other representors on the same TX interface, which can steer egress
> traffic through the wrong rule.

[Severity: Low]
Is this the full impact of the old behaviour?

For rte == true, rvu_rep_install_tx_rule() only sets req.vf. It never
sets req.features:

	if (rte) {
		req.vf = pcifunc;
	} else {

npc_update_flow() returns early when features is 0, so PF_FUNC was the
only key field for these entries. With mask = 0 the key was empty. Each
of these entries then matched all egress on the NIX TX interface from any
PF/VF, not just representor traffic.

In practice, the lowest-indexed TX entry would take all TX traffic and
loop it to LBK with the first representee's tag.

All representors also share one PF_FUNC (rvu->rep_pcifunc), so PF_FUNC
was never what told "other representors" apart.

Since this patch carries a Fixes: tag, could the commit message describe
the actual impact?

> Fixes: 683645a2317e ("octeontx2-af: Add packet path between representor and VF")
>
> Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
> Signed-off-by: Aditya Thapliyal <athapliyal@marvell.com>

[Severity: Low]
This isn't a bug, but the Signed-off-by chain looks off. The author is
Aditya Thapliyal, but the first Signed-off-by is from kmahammadraf and
there is no Co-developed-by tag.

Per Documentation/process/submitting-patches.rst, should there be a
Co-developed-by: line right before that Signed-off-by? Or should From:
name that person instead? The DCO also asks for a real name, and
kmahammadraf looks like a username.

There is also a blank line between the Fixes: tag and the Signed-off-by
block.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index ec004ea5154cb..4afd4a10cd649 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1396,7 +1396,7 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
>  	/* If AF is installing then do not care about
>  	 * PF_FUNC in Send Descriptor
>  	 */
> -	if (is_pffunc_af(req->hdr.pcifunc))
> +	if (is_pffunc_af(req->hdr.pcifunc) && !rvu->rep_mode)

[Severity: Low]
This isn't a bug, but the comment above this condition still says the AF
does not care about PF_FUNC. With this change, AF-installed TX rules in
rep_mode match PF_FUNC exactly. Should the comment mention the rep_mode
exception?

>  		mask = 0;
>  
>  	npc_update_entry(rvu, NPC_PF_FUNC, mdata, (__force u16)htons(target),

[Severity: High]
Does this stop representor egress from going through the wrong TX rule
when there is more than one representee?

For rte == false, rvu_rep_install_tx_rule() uses the same target for
every representee. It relies on sq_id to tell them apart:

	} else {
		req.vf = rvu->rep_pcifunc;
		req.packet.sq_id = vlan_tci;
		req.mask.sq_id = 0xffff;
	}

req.features is never set, and npc_update_flow() returns right away when
there are no features:

	if (!features)
		return;

As far as I can tell, nothing in the AF uses sq_id. It is declared in
struct flow_msg in mbox.h and written in rvu_rep.c, and that is all.
There is no NPC key field for it either.

With this patch, PF_FUNC == htons(rep_pcifunc) is the only key field in
every rte == false entry, so all of these entries have the same key.
rvu_rep_install_mcam_rules() installs them at increasing indices, and
the lowest-indexed matching entry wins.

On the NIC side, rvu_rep_xmit() sends traffic for every representor from
the same representor PF. It picks only the SQ, based on rep_id:

	sq = &pf->qset.sq[rep->rep_id];

Wouldn't all of that traffic hit the first rte == false entry? It would
then get that entry's vtag0_def (the first representee's rep_id), and the
RX rule that matches on vlan_tci would deliver it to the first
representee.

The unused sq_id match dates back to 683645a2317e. Still, the commit
message says this patch stops a TX rule from matching traffic for other
representors and steering it through the wrong rule. That still looks
possible in the representor to representee direction.

Does the SQ id need to be added to the MCAM key to fix this, rather than
only changing the PF_FUNC mask?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109105043.1986921-1-kmahammadraf%40marvell.com
