Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3C40A93C;
	Mon, 20 Jul 2026 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563877; cv=none; b=L4md4PixRudhDZVbC+84jA1l11Jh8o453AcWM4XQYFPYVwMR6NdkEJbtm1OBdMvRp7XMnbRgsJQGSAH29lpgJR4wrlv6fy9Zxr11SRVMQHxU1x97ZdiwD4bDah2z22PMeC5s0prVhmwUmfvvze+n0BkBQFinIMviIlirgCG7by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563877; c=relaxed/simple;
	bh=mfU9wv/T6giVVcbVW70mClkTvDkn6X25CqnCpdiODlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5dzvqMdGKyMgxbttojKwKG1upFyrb61qXhRM2Xvf7yQ70NUsz9V6/nrwt5hBw2P+KkLW4VuWuLo2T/obP/K352jcggCgU8Jo/ZAqlsDGzo9f3rNffo1Mhi6K6ZkcbfWNpmN5bnfpD61sF1gR55cp6ad0kdi2GnccjxyzxZEVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqlUzH3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqlUzH3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2AF1F000E9;
	Mon, 20 Jul 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784563867;
	bh=XzRZY70S0kdL3ZTmVrPbdK9Vgk/8FrLiRssGAnmAFHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IqlUzH3jsufhcW+qq4bel8vZfOyoRjKrdU5sbrUofedFKwNhKX5dNmDAcbHrqlop9
	 aJpKMaovNq2AZGEHgIzPD676cMOxxl1/DII4FHC+Z/VQjz/q4evNiKkpuYzusQp9jS
	 KcnMVDjXvInmyyRmo7dXaKMdxIvK7n7JFxApGlceCtFKgHhderA7H7m7hP0EfuJqUc
	 rn/MVMJ59EsLT2mpzrFohNCdplgwNqmg1Fqt8kZc+0dk7bhOz46MenSq7PyGvg5apZ
	 HwXgLoSvrHFoYo0zqBE+mjnWL1i8ocSwavYMMZI3yUOwNWKFauqY2EtWtIX4jRhrGB
	 5p05ii8Zv24VQ==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	gakula@marvell.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkelam@marvell.com
Subject: Re: [PATCH v3 net] octeontx2-af: Block VFs from clobbering special CGX PKIND state
Date: Mon, 20 Jul 2026 17:09:51 +0100
Message-ID: <20260720160951.236838-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713121902.3938875-1-rkannoth@marvell.com>
References: <20260713121902.3938875-1-rkannoth@marvell.com>
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
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260713121902.3938875-1-rkannoth@marvell.com?part=1
---
octeontx2-af: Block VFs from clobbering special CGX PKIND state

This commit prevents CGX-mapped VFs from resetting the shared LMAC RX
PKIND and default TX parse configuration when the LMAC is running with
HiGig2 or EDSA parsing enabled. It adds cgx_get_pkind() and
rvu_cgx_is_pkind_config_permitted() to gate the affected register
writes.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 4ff3935ed3fe..2be1da3476ac 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -1355,3 +1355,35 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
>  	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
>  		dev_err(rvu->dev, "Failed to reset MAC\n");
>  }
> +
> +/* Do not allow CGX-mapped VFs to overwrite PKIND when special parse kinds
> + * (HiGig, EDSA, etc.) are in use on the shared LMAC.
> + */
> +bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc)
> +{
> +	int pf, err, rxpkind;
> +	u8 cgx_id, lmac_id;
> +	void *cgxd;
> +
> +	pf = rvu_get_pf(rvu->pdev, pcifunc);
> +
> +	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
> +		return true;
> +
> +	if (!is_pf_cgxmapped(rvu, pf))
> +		return true;
> +
> +	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
> +	cgxd = rvu_cgx_pdata(cgx_id, rvu);
> +	err = cgx_get_pkind(cgxd, lmac_id, &rxpkind);
> +	if (err)
> +		return false;
> +
> +	switch (rxpkind) {
> +	case NPC_RX_HIGIG_PKIND:
> +	case NPC_RX_EDSA_PKIND:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}

[Medium]
The three call sites of rvu_cgx_is_pkind_config_permitted() interpret a
false return in two different ways.  In nix_interface_init() and
rvu_mbox_handler_nix_lf_alloc() a false result silently skips the write,
but the TX branch of rvu_npc_set_parse_mode() converts it into an
-EINVAL to the caller.

Pre-patch, rvu_mbox_handler_npc_set_pkind() (via rvu_npc_set_parse_mode)
always wrote NIX_AF_LFX_TX_PARSE_CFG.  Post-patch, a VF whose parent
PF's LMAC is programmed with NPC_RX_HIGIG_PKIND or NPC_RX_EDSA_PKIND
now receives a hard error where the call previously succeeded.

The same path is also reached from rvu_nix_lf_teardown() ->
rvu_npc_set_parse_mode(), where the -EINVAL is ignored but the intended
reset write to NIX_AF_LFX_TX_PARSE_CFG is skipped.

Is this mbox-level behavior change intended?  The commit message uses
the word "skip", which reads like a silent no-op, but this call site
aborts with -EINVAL rather than skipping.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 6a0ce2665031..040eb4c9b8d1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -1685,8 +1693,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RX_CFG(nixlf), req->rx_cfg);
>  
>  	/* Configure pkind for TX parse config */
> -	cfg = NPC_TX_DEF_PKIND;
> -	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
> +	if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
> +		cfg = NPC_TX_DEF_PKIND;
> +		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
> +	}

[Medium]
This check-then-write pair reads the CGX RX pkind register (via
cgx_get_pkind() inside rvu_cgx_is_pkind_config_permitted()) without
holding cgxd->lock, but the corresponding cgx_set_pkind() writers were
just wrapped in cgxd->lock in this same patch.

Consider the following interleaving:

    CPU0 (VF nix_lf_alloc)                CPU1 (PF set_parse_mode)
    -----------------------------------   ---------------------------
    rvu_cgx_is_pkind_config_permitted()
       cgx_get_pkind() -> normal pkind
       returns true
                                          mutex_lock(&cgxd->lock);
                                          cgx_set_pkind(..., HIGIG);
                                          mutex_unlock(&cgxd->lock);
    rvu_write64(NIX_AF_LFX_TX_PARSE_CFG,
                NPC_TX_DEF_PKIND);

Can a concurrent PF that transitions the LMAC to NPC_RX_HIGIG_PKIND or
NPC_RX_EDSA_PKIND between the check and the write flip the state the
check depends on?

The nix_interface_init() call site holds cgxd->lock across both the
check and the writes; should the same pattern be applied here (and in
the TX branch of rvu_npc_set_parse_mode()) for consistency?

[Medium]
NIX_AF_LFX_TX_PARSE_CFG(nixlf) is indexed by NIX LF, not by LMAC.
Skipping the write when the LMAC is in HiGig/EDSA mode means the
register is left at whatever value it currently holds — either the
hardware reset value on a fresh LF, or stale contents from a previous
owner when an LF is reused across configurations.

If a HiGig VF needs NIX_AF_LFX_TX_PARSE_CFG programmed (for example to
NPC_TX_HIGIG_PKIND) to emit correctly formatted frames, where is that
value installed?  This hunk unconditionally elides the write when the
LMAC is HiGig/EDSA, and the teardown path via rvu_nix_lf_teardown() ->
rvu_npc_set_parse_mode() is likewise blocked from restoring the
default, so a subsequent non-HiGig owner reusing the same LF would
observe the previous owner's TX parse configuration.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index c7bc0b3a29b9..1297c6681a01 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -4241,6 +4245,9 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
>  		if (rc)
>  			return rc;
>  
> +		if (!rvu_cgx_is_pkind_config_permitted(rvu, pcifunc))
> +			return -EINVAL;
> +
>  		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf),
>  			    txpkind);
>  	}
