Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C634A791;
	Fri, 18 Sep 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709420; cv=none; b=KHOAzZcRu8MdXrof+uq69z4EAXZ7Do+X0WYaKJdf2LNAUiXil+l1huJS44b6YgcawUqwK/AqzTlRDFYgQYhwa+NNhyeTOOGLKGm+f3hEqb9fIKUekbDRWyB1cHpfkw1WmERBBz6sDz2CWQXC5NqSyyYqoqQDe435Tw9AGGQ6rNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709420; c=relaxed/simple;
	bh=2u7WM2Az5WGCuznKRHgG9ZW2G9Ztm22RFNuUE6ET7AY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E5vgAcQZrFfFkn+2gYgf1TbCVjs60PN3phyIi8/8vIaHPPT/mSJfg6xXD/yIGi284eCK9qnRo63V+cv8cpTDOV58wx6PNpx71eytEAyc8K3cJ0QvzyDB4uKk/zzm2rUyHWSOAZFR1iOKTArdKnO0rBFayKc9I7LNGxbAHDfZIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH+ui5d8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH+ui5d8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED591F000FF;
	Fri, 18 Sep 2026 05:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789709419;
	bh=uSG8JD6ADXrSi2jR52ykjUubPWou8qkTfr5gP9P4nBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PH+ui5d8oROePnxc0oMc5opx4ZOgeaQc0alo1cCjONbyFapoUx07dbZY2jnrDrFtk
	 qt9IsaC0BG5vP9ta954xSDRlbF0vm9l43t4tbgWXiORcI5uEEG13oHl3JEzakJpH4B
	 mw5jtwGkqQcegHRY56a3TmiGuPnI8nlrRx2OT/Vy9fcEdgiTk/VodSxIDbqqovH/Y+
	 1k9xDTA07Utv3FaJHQIJfk1B4UaywzLoqhAIzr7tv8vYubXGWxJUaoGAHDyOEUXO6c
	 MTgnvfpnfK/v2NzbCnmevNstRyWRef8PlyooYWvx60xc3p90Lg40AO+cKFxWqDhoso
	 ZMFudDJ+/NRAw==
Subject: Re: [PATCH net] octeontx2-af: guard is_pf_cgxmapped() when PF to CGX
 map is absent
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, gakula@marvell.com, lcherian@marvell.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saikrishnag@marvell.com
Date: Fri, 18 Sep 2026 05:30:17 +0000
Message-ID: <178970941782.22033.17901214089531533321@kernel.org>
In-Reply-To: <20260915022952.886639-1-rkannoth@marvell.com>
References: <20260915022952.886639-1-rkannoth@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] The added `if (!rvu->pf2cgxlmac_map) return false;` in
  `is_pf_cgxmapped()`…

Pre-existing issues:
- [Medium] Asymmetry between the NIX backpressure enable and disable
  mailbox handlers for SDP interfaces.

--

octeontx2-af: guard is_pf_cgxmapped() when PF to CGX map is absent

This adds a NULL check for rvu->pf2cgxlmac_map at the top of
is_pf_cgxmapped(), so the helper returns false when the PF to CGX LMAC map
was never allocated. The stated goal is to avoid dereferencing the map in
RPM-less configurations where the bootloader supplies no RPM/firmware data.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 094227404ef9f..1e0a5aeb3f577 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -970,6 +970,9 @@ static inline int rvu_get_pf(struct pci_dev *pdev, u16 pcifunc)
>  /* CGX APIs */
>  static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
>  {
> +	if (!rvu->pf2cgxlmac_map)
> +		return false;
> +

[Severity: Medium]
Can this new branch ever be taken?

struct rvu is zero allocated in rvu_probe():

	rvu = devm_kzalloc(dev, sizeof(*rvu), GFP_KERNEL);

so cgx_mapped_pfs starts at 0.  rvu_map_cgx_lmac_pf() in rvu_cgx.c is the
only writer of cgx_mapped_pfs, and both the reset and the increment happen
only after pf2cgxlmac_map and cgxlmac2pf_map have been allocated
successfully:

	rvu->pf2cgxlmac_map = devm_kmalloc(rvu->dev, size, GFP_KERNEL);
	if (!rvu->pf2cgxlmac_map)
		return -ENOMEM;
	...
	rvu->cgx_mapped_pfs = 0;
	...
			rvu->cgx_mapped_pfs++;

In exactly the configuration the commit message describes, rvu_cgx_init()
returns early:

	rvu->cgx_cnt_max = cgx_get_cgxcnt_max();
	if (!rvu->cgx_cnt_max) {
		dev_info(rvu->dev, "No CGX devices found!\n");
		return 0;
	}

which leaves pf2cgxlmac_map NULL and cgx_mapped_pfs at 0.  In that state the
pre-existing range test:

	return (pf >= PF_CGXMAP_BASE && pf <= rvu->cgx_mapped_pfs) &&

is already false for every u8 pf, since PF_CGXMAP_BASE is 1 and
cgx_mapped_pfs is 0, and the && short circuits before is_sdp_pf() runs.  If
the allocation itself fails, rvu_map_cgx_lmac_pf() returns -ENOMEM and
rvu_probe() aborts:

	err = rvu_cgx_init(rvu);
	if (err) {
		dev_err(rvu->dev, "%s: Failed to initialize cgx\n", __func__);
		goto cgx_err;
	}

so the state "pf2cgxlmac_map == NULL with cgx_mapped_pfs != 0" does not seem
to exist, and no is_pf_cgxmapped() guarded caller (rvu_cgx.c, rvu_nix.c,
rvu_npc.c, rvu_debugfs.c) can reach the map with a NULL pointer.

Given that, is the Fixes: 3a4fa841b039 tag appropriate here, and can the
commit message wording "Several call paths use is_pf_cgxmapped() before
indexing pf2cgxlmac_map[], but the helper did not verify that the map
exists" be reworded to describe this as hardening rather than a NULL
dereference fix?

If a crash was actually observed, was it on one of the unguarded
dereferences instead?  nix_lf_free() indexes the map directly, gated only by
pfvf->hw_rx_tstamp_en:

	rvu->pf2cgxlmac_map[pf]

That site is not covered by this change and would still be reachable.

>  	return (pf >= PF_CGXMAP_BASE && pf <= rvu->cgx_mapped_pfs) &&
>  		!is_sdp_pf(rvu, rvu_make_pcifunc(rvu->pdev, pf, 0));
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
while looking at the callers of this helper: is the SDP handling in
nix_bp_disable() and nix_bp_enable() in rvu_nix.c intentionally asymmetric?

is_pf_cgxmapped() deliberately returns false for SDP PFs because of the
!is_sdp_pf() term above.  nix_bp_enable() classifies SDP before its gate and
admits it explicitly:

	type = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
	if (is_sdp_pfvf(rvu, pcifunc))
		type = NIX_INTF_TYPE_SDP;

	/* Enable backpressure only for CGX mapped PFs and LBK/SDP interface */
	if (!is_pf_cgxmapped(rvu, pf) && type != NIX_INTF_TYPE_LBK &&
	    type != NIX_INTF_TYPE_SDP)
		return 0;

nix_bp_disable() applies the gate first, while type is still
NIX_INTF_TYPE_CGX:

	type = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
	if (!is_pf_cgxmapped(rvu, pf) && type != NIX_INTF_TYPE_LBK)
		return 0;

	if (is_sdp_pfvf(rvu, pcifunc))
		type = NIX_INTF_TYPE_SDP;

For an SDP requester the early return fires, which makes the following
is_sdp_pfvf() assignment unreachable.  Does this leave BIT(16) of
NIX_AF_RX_CHANX_CFG set on the SDP RX channels after NIX_BP_DISABLE returns
success, so backpressure stays armed once the interface is torn down?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915022952.886639-1-rkannoth%40marvell.com
