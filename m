Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792989794;
	b=pCZUP5/obnEVQZni38C/AqV5sjqXNrCJE3LoHQtaTI0vIFGES7E9vIfQZV+eYebdZXMX
	 1doJOd1Q0sRdWpYDXzXvwCYEZ3TR89c/v0vhZg1Fa3/xR1t3lUPMrX3znpl5h/Em78YSM
	 IObWqPDVLcgBBvD2NYW7ulKYg4QvveQICeVdtCJaCRsR1sBgW8aDEY7Uw6+m8ZOqrf40e
	 jYnO2QFmTVd9evqPTyxKzR//Qs6ICqw8DPIuKq0DZTmtB620oKWMjjc6cUlShU1z6KtkJ
	 H/HzeCLoO6L4tUvx25yh/YlOwc2pMTz6zaDyiyDzn1/alez/qe5VZQJ/IjGyYgSNveA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792989794;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=C3wmcsq5M8ZYfUOpWBYK3fngZJLQioceUB0ZD5J5oxY=;
	b=BPFdYk+WCxKeSusI+bKVYoeGrRk74e3PHDEjbP2w9DtcQSQNFazbpyRTi/msmPrFrqNh
	 etNSzKetbniRzRtmy/AS2uVwcqpDi6uJLL+SykYg1/vJCMdQH00mMW8o/YD8mzcq/jeOK
	 Mc1oCgLZVXCjq/ZshW6G9TRIWVtqCqVAXO29WCoaeewAItr+4fJdFkizcT0oBrdzdpJ5D
	 kxWmQCK9Fd88h7HJUcbogZLZSflZ3ZmKOM+8MUcujXt0dyfnd96/4Gcuca7XIPbVT8yWw
	 V3CdU3rD5FRmFPtXRzJIjTfnXr6Pjrd3jr7JSAqnAvVpZJl8JXIB7iZcCREAzLIS27A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UL62WYR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4CE606A31D;
	Mon, 26 Oct 2026 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UL62WYR9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223621F01828;
	Mon, 26 Oct 2026 04:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792989793;
	bh=C3wmcsq5M8ZYfUOpWBYK3fngZJLQioceUB0ZD5J5oxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UL62WYR9wHfUyvGclkHE1jqewvO1f/PQouXboKg+eXXL851glUWbZLagl/vmJ06Xn
	 m2BX4428qvRssyYYY56MLZPtasqi4TXS+eTuJegDjDD1cielm8KjwXUblSvayj4nKY
	 UWE5AgWBLN8mIgt1YWuxbQbZdzJQ0QQpRcGbxHfRT+1hXLaP6cJGXE9hkZ4uFcF4Db
	 E7ty4j15M6qNI3yUBEZZy6qh31vyNFf6uIa/VnCB0TPkC+EPXG8bCsatgRe20ld2oo
	 H7CbkwVZSUAkTm9xumMMmvbynUDpe24HlIhn49bhfh7l2mp1MbSnnj+I53jNhxHGLG
	 KTMcpLO3Gq9Nw==
Subject: Re: [PATCH net] Subject: [PATCH] octeontx2-af: fix TX scheduler queue
 index mask for 2K schedulers
From: netdev-bot+sashiko@kernel.org
To: kmahammadraf@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sgoutham@marvell.com,
 rkannoth@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, skoteshwar@marvell.com
Date: Mon, 26 Oct 2026 04:43:12 +0000
Message-ID: <179298979262.3134.248662363515081325@kernel.org>
In-Reply-To: <20261022042653.2640537-1-kmahammadraf@marvell.com>
References: <20261022042653.2640537-1-kmahammadraf@marvell.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the patch widens only the child scheduler index,
  which comes from the register address (TXSCHQ_IDX_MASK becomes 11 bits…
- [Low] The patch is a 'fix' for a user-visible bug on hardware the tree
  already supports, but it has no Fixes: tag.
- [Low] Submission/tag problems in the commit message: (1) The subject
  literally reads 'Subject: [PATCH] octeontx2-af: fix TX scheduler queue…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  rvu_mbox_handler_nix_txschq_cfg() validates the hierarchy on the raw…

--

Subject: [PATCH] octeontx2-af: fix TX scheduler queue index mask for 2K schedulers

CN20K raised the number of TX schedulers per layer from 1K to 2K. To
match, this patch widens TXSCHQ_IDX_MASK from 10 to 11 bits and extends
NIX_TX_SCHQ_MASK to cover bit 26.

> Subject: [PATCH] octeontx2-af: fix TX scheduler queue index mask for 2K schedulers

[ ... ]

> Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>

[Severity: Low]
This isn't a bug, but the mail header ended up in the commit subject:

  Subject: [PATCH] octeontx2-af: fix TX scheduler queue index mask ...

Since this is a fix, should it also be sent as [PATCH net]?

The first Signed-off-by uses kmahammadraf, which isn't a real name as
submitting-patches.rst asks for. It also doesn't match the author.

If kmahammadraf wrote the patch, should the From: say so? If both people
contributed, is a Co-developed-by: tag missing?

[Severity: Low]
Should this have a Fixes: tag?

CN20K NIX support is already in the tree. nix_setup_txschq() sizes
schq.max from the NIX_AF_*_CONST registers, so CN20K can already hand out
scheduler queues >= 1024. With the old 10-bit TXSCHQ_IDX_MASK and a
NIX_TX_SCHQ_MASK that leaves out bit 26, the AF would either reject a
queue the function really owns or program schq - 1024.

Could this get a Fixes: tag pointing at the commit that enabled CN20K TX
scheduler handling, and target the net tree, so the stable tooling picks
it up?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index cece197d1074..1b62f9d7f00a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1164,7 +1164,7 @@ struct nix_txschq_config {
>  	u8 lvl;	/* SMQ/MDQ/TL4/TL3/TL2/TL1 */
>  	u8 read;
>  #define TXSCHQ_IDX_SHIFT	16
> -#define TXSCHQ_IDX_MASK		(BIT_ULL(10) - 1)
> +#define TXSCHQ_IDX_MASK		(BIT_ULL(11) - 1)
>  #define TXSCHQ_IDX(reg, shift)	(((reg) >> (shift)) & TXSCHQ_IDX_MASK)

[Severity: High]
The child index is now 11 bits, but does the parent index need the same
change? is_txschq_hierarchy_valid() still cuts the parent read from the
PARENT register value down to 9 bits:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:is_txschq_hierarchy_valid() {
    ...
	schq = TXSCHQ_IDX(reg, TXSCHQ_IDX_SHIFT);
    ...
	parent = (regval >> 16) & 0x1FF;
	/* Validate MDQ's TL4 parent */
	if (regbase == NIX_AF_MDQX_PARENT(0) &&
	    !is_valid_txschq(rvu, blkaddr, NIX_TXSCH_LVL_TL4, pcifunc, parent))
		return false;
    ...
}

After that, rvu_mbox_handler_nix_txschq_cfg() writes the full, unmasked
regval with rvu_write64().

nix_setup_txschq() takes schq.max from the NIX_AF_*_CONST registers, so on
CN20K, TL4/TL3/TL2 indices of 512 and above can be allocated. On the PF/VF
side, otx2_txschq_config() encodes the full parent as parent << 16.

Say a PF or VF uses TL4 600 as an MDQ parent. The AF checks who owns TL4
88 instead. Would that reject a valid config with NIX_AF_INVAL_TXSCHQ_CFG?
Or would it pass only because TL4 88 happens to belong to the same
function?

The reverse case also looks possible. A VF that owns parent X < 512 could
send X + 512 * k. The AF checks X, but hardware gets a parent that may
belong to another function. Does that break the cross-function isolation
that is_valid_txschq() is meant to enforce?

The SMQ flush walk uses the same 9-bit decode:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:nix_smq_flush_fill_ctx() {
    ...
		if (parent_off) {
			regval = rvu_read64(rvu, blkaddr, parent_off);
			schq = (regval >> 16) & 0x1FF;
		}
    ...
}

With parents >= 512, the saved and restored CIR/PIR offsets would point at
other schedulers. nix_smq_flush_enadis_xoff() would also skip the wrong
TL2, so the real TL2 of the SMQ being flushed could get XOFF'd. Could the
flush time out, and could other functions' rate limits be zeroed and then
restored?

The NIX_AF_MDQ/TL4/TL3/TL2_PARENT_MASK definitions in rvu_reg.h (9, 8, 8
and 5 bits wide) look too narrow for 2K schedulers per layer as well.

The tree doesn't document the CN20K PARENT field width. Still, with 2K
TL4s per layer, the MDQ PARENT field has to hold TL4 indices up to 2047,
so a 9-bit decode doesn't fit the premise of this patch.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 95f782d47927..a1d68afd7c9e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -2850,9 +2850,9 @@ static void nix_tl1_default_cfg(struct rvu *rvu, struct nix_hw *nix_hw,
>  }
>  
>  /* Register offset - [15:0]
> - * Scheduler Queue number - [25:16]
> + * Scheduler Queue number - [26:16]
>   */
> -#define NIX_TX_SCHQ_MASK	GENMASK_ULL(25, 0)
> +#define NIX_TX_SCHQ_MASK	GENMASK_ULL(26, 0)

[Severity: High]
This is a pre-existing issue, not one this patch introduced.
rvu_mbox_handler_nix_txschq_cfg() runs the hierarchy check on the raw
request regval, and only then merges in the caller-controlled
regval_mask:

		if (!is_txschq_hierarchy_valid(rvu, pcifunc, blkaddr,
					       txsch->lvl, reg, regval))
			return NIX_AF_INVAL_TXSCHQ_CFG;
		...
		val = rvu_read64(rvu, blkaddr, reg);
		regval = (val & val_mask) | (regval & ~val_mask);
		...
		rvu_write64(rvu, blkaddr, reg, regval);

For a PARENT register, can the parent that gets written differ from the
one that was checked?

For example, say the child's current parent is 1 (bit 16 set) and the
caller owns parents 1 and 2. The caller sends regval = 2 << 16 with
regval_mask = 1 << 16. is_txschq_hierarchy_valid() approves parent 2.
The merge then keeps bit 16 from hardware and bit 17 from the request, so
parent 3 is written and its owner is never checked.

MDQ, TL4 and TL3 sit below nix_tx_aggr_lvl, so a VF can reach this path.
Could a VF use it to attach its scheduler under another PF's or VF's
scheduler?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022042653.2640537-1-kmahammadraf%40marvell.com
