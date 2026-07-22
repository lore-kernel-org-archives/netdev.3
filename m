Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A94339875;
	Wed, 22 Jul 2026 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726971; cv=none; b=UTRyhkBBAMEkWQeeB5CklN/viqh989EH6lJYsmai8sd8a72Tfk1ZgeiHObZ4Pcmcow6Or23jKJfNHY7IEw1B33jE24zAcwB55Ri1EC29+boJZHPMFCcx8Xy91TYrfN5v/IpO0b7rLsw2G5kEpeozxq5dpMuPzCd3y0LzsW1XTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726971; c=relaxed/simple;
	bh=FQOa1wKNlc7TB7R8zrU6JncSpGWQOAp6lsHwwxrEx2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKeyXhhZrx27CtADk62K2N9gqz9Ir1K1ObOV/B+vyasn8Dk0Y9CaOLu/2JYNWhq6ot1TvirxGar13zSMVl1UtTouVcpvu6VfDz+ZBcJQBNise5AJZvEf2GRkD87PQ1WLGa9xRXseZ88HCdA4AkmjXKhBYfYJidZuhugAk9n+7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZGVNERW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZGVNERW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E47B1F00A3A;
	Wed, 22 Jul 2026 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726969;
	bh=DQd3JnDdpbxpWk4XZ8NJSh9k+Wj3EkarbiDuERislfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZGVNERWgU5HX3MVYopUOeIj8P/erdFstSOuyF3jlwdoVy7E3/Dik8gC1GpwR0pF7
	 KvgBNHx2A8t2wTVBPektXFpq+UGV27Gl87r4oI1E/brLFNI7oAQV1Agl1pk/smbTT1
	 R72jyEh7/wg2ugTibFkzWPRfXaHjLaKc31EvYxELplyIUPJ2lHSOOouAjc0+/fbq6Q
	 Z9tJbcoO8LM1T5N8vIvEeIzVEtrkWvljiJENXkLGKtyPDiR1DaFKnrlJs8/J4tBTli
	 mj2thWtYmnohXV+TIRCA+AeJmYQ8kCc/ex//eZydmK9sCmPduTH2hH5mLt9uubgZ3B
	 Xk1VgJ25XYVaQ==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com,
	skoteshwar@marvell.com
Subject: Re: [PATCH v2 net-next] octeontx2-af: add new mbox to support sync cycle on rx path
Date: Wed, 22 Jul 2026 14:29:07 +0100
Message-ID: <20260722132906.489236-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715041239.2052888-1-rkannoth@marvell.com>
References: <20260715041239.2052888-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260715041239.2052888-1-rkannoth@marvell.com?part=1
---
octeontx2-af: add new mbox to support sync cycle on rx path

This adds a new NIX_RX_SW_SYNC mailbox (0x8022) so an LF can ask the AF
to drive NIX_AF_RX_SW_SYNC and flush in-flight RX packets to LLC/DRAM,
intended to assist RQ/SMQ/SQ teardown. nix_rx_sync() is also modified to
take rvu->rsrc_lock around the two SW_SYNC poll cycles.

Some questions inline.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index f87cdf1b971d..92175de036d5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -362,6 +362,7 @@ M(NIX_CPT_BP_ENABLE,    0x8020, nix_cpt_bp_enable, nix_bp_cfg_req,	    \
>  				nix_bp_cfg_rsp)				    \
>  M(NIX_CPT_BP_DISABLE,   0x8021, nix_cpt_bp_disable, nix_bp_cfg_req,	    \
>  				msg_rsp)				\
> +M(NIX_RX_SW_SYNC,	0x8022, nix_rx_sw_sync, msg_req, msg_rsp)		\

[Low]
Is there an in-tree LF-side sender for this new mbox?  A grep for
nix_rx_sw_sync / NIX_RX_SW_SYNC across drivers/net/ethernet/marvell/octeontx2/
only returns this mbox table entry and the AF handler below — no caller in
nicpf, nicvf, or the representor driver, yet the commit message states:

    To complete disabling RQs or disabling SMQ and its SQs, LF software
    send mbox to AF to complete RX_SW_SYNC.

Should the LF-side user be part of this series so the new AF↔LF ABI has a
documented user and the semantics (must the LF have already disabled the
RQ contexts before calling?  Is concurrent use from multiple LFs supported?
What does a 0 return mean when the sync silently failed?) can be pinned
down?

>  M(NIX_READ_INLINE_IPSEC_CFG, 0x8023, nix_read_inline_ipsec_cfg,		\
>  				msg_req, nix_inline_ipsec_cfg)		\
>  M(NIX_MCAST_GRP_CREATE,	0x802b, nix_mcast_grp_create, nix_mcast_grp_create_req,	\
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 78667a0977c0..47e1a4e3392b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -273,6 +273,8 @@ static void nix_rx_sync(struct rvu *rvu, int blkaddr)
>  {
>  	int err;
>  
> +	mutex_lock(&rvu->rsrc_lock);
> +
>  	/* Sync all in flight RX packets to LLC/DRAM */
>  	rvu_write64(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0));
>  	err = rvu_poll_reg(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0), true);

[Medium]
nix_rx_sync() is void and both rvu_poll_reg() timeouts only emit
dev_err() — the outcome is not propagated:

    rvu_write64(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0));
    err = rvu_poll_reg(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0), true);
    if (err)
        dev_err(rvu->dev, "SYNC1: NIX RX software sync failed\n");

The new mbox handler then unconditionally returns 0.

The commit message says LFs will use this to "complete disabling RQs or
disabling SMQ and its SQs" — i.e., the LF is expected to rely on the
sync guarantee before freeing RQ/SQ contexts and DMA buffers.

Under the HW errata this code itself describes ("an existing transaction
might end after SW_SYNC operation"), or under a HW stall, rvu_poll_reg()
can return -EBUSY.  Should nix_rx_sync() propagate that error and the mbox
handler surface it to the LF, so the caller doesn't tear down structures
while packets are still in flight — exactly the race this mbox is meant
to prevent?

> @@ -289,6 +291,8 @@ static void nix_rx_sync(struct rvu *rvu, int blkaddr)
>  	err = rvu_poll_reg(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0), true);
>  	if (err)
>  		dev_err(rvu->dev, "SYNC2: NIX RX software sync failed\n");
> +
> +	mutex_unlock(&rvu->rsrc_lock);
>  }

[High]
Is it safe to take rvu->rsrc_lock across the two rvu_poll_reg() calls
here?

rvu_poll_reg() uses a 20 ms timeout each, so a single nix_rx_sync() can
hold rvu->rsrc_lock for roughly 40 ms in the worst case:

int rvu_poll_reg(struct rvu *rvu, u64 block, u64 offset, u64 mask, bool zero)
{
    unsigned long timeout = jiffies + usecs_to_jiffies(20000);
    ...
}

rvu->rsrc_lock is the AF-wide "Serialize resource alloc/free" mutex and
is acquired by many resource paths across rvu_cgx.c, rvu_cn10k.c,
rvu_cpt.c, mcs_rvu_if.c, and throughout rvu_nix.c (attach/detach, TXSCH,
bandprof, MCS, etc.).

Prior to this patch nix_rx_sync() was only reached from AF-internal
teardown (rvu_nix_lf_teardown -> rvu_blklf_teardown -> __rvu_flr_handler).
This patch now makes it reachable from any PF/VF via the new mbox.

Can a hostile or buggy VF spamming NIX_RX_SW_SYNC keep the AF mbox worker
holding rsrc_lock for tens of milliseconds at a time and stall every other
tenant's control-plane operations?

Also, NIX_AF_RX_SW_SYNC is a block-global register that flushes in-flight
RX for the entire NIX block, not for the caller's LF, so one VF's request
perturbs the RX pipeline of every other LF sharing the block.  Should this
mbox be rate-limited or restricted (e.g. PF-only, or gated per LF), given
its cross-tenant side effects?

> @@ -6324,6 +6328,22 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(struct rvu *rvu, struct msg_req *re
>  	return 0;
>  }
>  
> +int rvu_mbox_handler_nix_rx_sw_sync(struct rvu *rvu, struct msg_req *req,
> +				    struct msg_rsp *rsp)
> +{
> +	int blkaddr;
> +
> +	/* NIX_AF_RX_SW_SYNC is global per NIX block; nix_rx_sync() serializes
> +	 * access under rvu->rsrc_lock across mbox and teardown paths.
> +	 */
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, req->hdr.pcifunc);
> +	if (blkaddr < 0)
> +		return NIX_AF_ERR_AF_LF_INVALID;
> +
> +	nix_rx_sync(rvu, blkaddr);
> +	return 0;
> +}

[Medium]
Should this handler also verify that the caller owns an allocated NIX LF?

rvu_get_blkaddr() for BLKTYPE_NIX only inspects RVU_PRIV_PFX_NIXX_CFG /
RVU_PRIV_HWVFX_NIXX_CFG to select a block:

    if (blktype == BLKTYPE_NIX) {
        reg = is_pf ? RVU_PRIV_PFX_NIXX_CFG(0) :
            RVU_PRIV_HWVFX_NIXX_CFG(0);
        cfg = rvu_read64(rvu, BLKADDR_RVUM, reg | (devnum << 16));
        if (cfg) {
            blkaddr = BLKADDR_NIX0;
            goto exit;
        }
        ...
    }

Those config bits can be set for a pcifunc that has not (yet) allocated a
NIXLF or whose NIXLF has been freed.

Every other NIX mbox handler in this file goes through nix_get_nixlf() or
nix_get_struct_ptrs(), which additionally require pfvf->nixlf and
rvu_get_lf() >= 0 before proceeding.  Given the commit message frames
this as an LF teardown assistance mechanism, should the handler gate on
the caller actually having a NIXLF, like the rest of the file?
