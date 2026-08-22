Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581827B340;
	Sat, 22 Aug 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427352; cv=none; b=qudKCzS4W1wZ2vN1auewX3F7SecHlDLj5de1N0ClLPTd41cmGtkDkmZVRv19dTLhSW3Oz/mNIEAFPTJpe62Td3pdg29i/fZayHdFyTtfK5vIQf2EdZ2tPYG74AOto5+ERbYF+PSwaB0laeYHe6oKjDwQxt927uvXXp4njEobOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427352; c=relaxed/simple;
	bh=OtgHdVG8ld/lcINr50Kj15Pb4LiX9qlDstTZMFVm0KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xnmx+cCldHE1SCj/JnZsGhDRwradwXOjwlHbFHjclpFfpu4IonL4IgOdKlu3SFEBPOKeAFpfzNqdQA5ojkGVp6Lu//2i1OdDi8WxdHADloZ0kBtoBWnj4xclTqf3gvr9gYGCgxfv8v09jZdovkOi6Z/Em49OYBRsCZey/UTLKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN5FunM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN5FunM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC511F000E9;
	Sat, 22 Aug 2026 19:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787427348;
	bh=Ku7ffhT60RXRIVw0b1S05xoma+1gOXUkz31ePUfqpsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZN5FunM11kgJJ8SD+sewzYNVyYFXJx+B7ZviSfNSByFL4aaZs7oRgS/I/cKBRkxQj
	 JKnQOYBpU0QWWpDuCIdE1iJGkEyie5k2csd35lY838xdxgHlfUOyD3eWw7L9pN+B4c
	 sc+cdCeJ0R/zqA6LDhVrgcKN6fi6psXmLBdR6sIa/RBcJYQ4qnG2fmu8nOJWnuirAz
	 gQb7VsPHnGiF6yVOSS9qk3HDAF44FGFug4EZs4UC/8WqjCbhM24iE4CvnU0a2BrgLV
	 ukziMAvjW8v3quvABmJYGW1MioVaErpNpGxVjajDKa19OBsVb/M00g+qgnHYzMMxa4
	 bK38Yl+2vW+ow==
From: Jakub Kicinski <kuba@kernel.org>
To: nshettyj@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	tduszynski@marvell.com
Subject: Re: [PATCH net] octeontx2-af: Fix limiting SRIOV VF count logic
Date: Sat, 22 Aug 2026 12:35:47 -0700
Message-ID: <20260822193547.2183906-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821064512.2754110-1-nshettyj@marvell.com>
References: <20260821064512.2754110-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-af: Fix limiting SRIOV VF count logic

This restricts the LBK channel based clamping of the AF VF count in
rvu_enable_sriov() so that it only applies when the SR-IOV VF device ID
matches the LBK RVU AFVF device.  The clamp is moved inside a new
conditional block and the absolute 62 VF limit is replaced with a limit
derived from the reported channel count.

A few questions about the new logic below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index ffba56ee8a60c..67a7766f000b2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -3463,6 +3463,8 @@ int rvu_get_num_lbk_chans(void)
>  	return ret;
>  }
>  
> +#define PCI_DEVID_OCTEONTX2_RVU_AFVF	0xA0F8
> +

[Severity: Low]
This isn't a bug, but does this duplicate a constant that already exists
in a header this file includes?  af/rvu.h already has:

	#define	RVU_LBK_VF_DEVID	0xA0F8
	static inline bool is_lbk_vf(struct rvu *rvu, u16 pcifunc)
	{
		return (!(pcifunc & ~RVU_PFVF_FUNC_MASK) &&
			(rvu->vf_devid == RVU_LBK_VF_DEVID));
	}

and the same macro name with the same value also exists in the companion
driver in nic/otx2_common.h.  With this hunk there are three copies of
0xA0F8 to keep in sync.  Would rvu->vf_devid == RVU_LBK_VF_DEVID work
here instead?

>  static int rvu_enable_sriov(struct rvu *rvu)
>  {
>  	struct pci_dev *pdev = rvu->pdev;
> @@ -3481,24 +3483,25 @@ static int rvu_enable_sriov(struct rvu *rvu)
>  		return 0;
>  	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &rvu->vf_devid);
>  
> -	chans = rvu_get_num_lbk_chans();
> -	if (chans < 0)
> -		return chans;
> -
>  	vfs = pci_sriov_get_totalvfs(pdev);
> -
> -	/* Limit VFs in case we have more VFs than LBK channels available. */
> -	if (vfs > chans)
> -		vfs = chans;
> -
>  	if (!vfs)
>  		return 0;
>  
> -	/* LBK channel number 63 is used for switching packets between
> -	 * CGX mapped VFs. Hence limit LBK pairs till 62 only.
> -	 */
> -	if (vfs > 62)
> -		vfs = 62;
> +	if (rvu->vf_devid == PCI_DEVID_OCTEONTX2_RVU_AFVF) {
> +		chans = rvu_get_num_lbk_chans();
> +		if (chans < 0)
> +			return chans;
> +
> +		/* Limit VFs in case VFs are more than LBK channels available */
> +		if (vfs > chans)
> +			vfs = chans;

[Severity: Medium]
The "if (!vfs) return 0;" test now runs before the clamp instead of after
it, and the clamp below has no lower bound.  Can vfs end up zero or
negative here?

rvu_get_num_lbk_chans() returns a plain 16-bit register field:

	ret = (readq(base + 0x10) >> 32) & 0xffff;

so it can never be negative and the "chans < 0" test cannot catch a
report of 0, 1 or 2 channels.  In that case vfs becomes 0, -1 or -2 and
nothing revalidates it before:

	rvu->vfs = vfs;

	err = rvu_mbox_init(rvu, &rvu->afvf_wq_info, TYPE_AFVF, vfs,
			    rvu_afvf_mbox_handler, rvu_afvf_mbox_up_handler);

For vfs == 0, rvu_mbox_init() passes all of its allocation checks because
bitmap_zalloc(0) and kcalloc(0, ...) return ZERO_SIZE_PTR rather than
NULL, otx2_mbox_setup() accepts ndevs == 0, and otx2_mbox_regions_init()
in af/mbox.c then does:

	mbox->hwbase = hwbase[0];

on that ZERO_SIZE_PTR array.

For vfs < 0 the num argument promotes to a huge unsigned value in
BITS_TO_LONGS(), the bitmap allocation fails with -ENOMEM, and
rvu_probe() treats that as fatal:

	err = rvu_enable_sriov(rvu);
	if (err) {
		dev_err(dev, "%s: Failed to enable sriov\n", __func__);
		goto err_dl;
	}

Also, rvu->vfs is used to build INTR_MASK(vfs) masks in
rvu_enable_afvf_intr() / rvu_disable_afvf_intr(), where a negative shift
count is undefined.

Before this change the order was clamp first, then "if (!vfs) return 0;",
so a zero channel count simply skipped SR-IOV enablement and vfs could
never go negative.  Would keeping the zero test after the clamp, or
bounding the clamp at zero, preserve that?

> +
> +		/* LBK channel number 63 is used for switching packets between
> +		 * CGX mapped VFs. Hence limit LBK pairs.
> +		 */
> +		if (vfs > (chans - 2))
> +			vfs = chans - 2;
> +	}

[Severity: Medium]
The commit message only describes gating the LBK clamp on the VF device
ID, but this hunk also replaces the absolute cap

	if (vfs > 62)
		vfs = 62;

with a count-relative one.  Is that change intentional, and could it be
mentioned in the changelog?

The two forms only agree when LBK reports exactly 64 channels.  For a
smaller count the new code creates up to two fewer AF VFs than before
(chans == 32 gives min(totalvfs, 30) where it used to give
min(totalvfs, 32)), and the preceding

	if (vfs > chans)
		vfs = chans;

becomes dead because the following clamp is strictly tighter.

For a larger count the cap no longer protects channel 63, which is still
a hardcoded absolute index in this tree:

	af/rvu.h:	#define RVU_SWITCH_LBK_CHAN	63
	af/rvu_switch.c: req.index = (lbkid << 8) | RVU_SWITCH_LBK_CHAN;
	af/rvu_nix.c:	 cfg = enable ? (BIT_ULL(12) | RVU_SWITCH_LBK_CHAN) : 0;

while nix_interface_init() maps an LBK VF index one-to-one onto a channel:

	pfvf->rx_chan_base = rvu_nix_chan_lbk(rvu, lbkid, vf);

so VF number 64 would own the channel the switch and representor paths
also program.

The retained comment still justifies the limit with the absolute channel
number 63 while the arithmetic is now relative to the reported count, so
the comment and the code no longer say the same thing.

>  
>  	/* Save VFs number for reference in VF interrupts handlers.
>  	 * Since interrupts might start arriving during SRIOV enablement

[Severity: Medium]
This is a pre-existing issue and not something introduced by this patch,
but it sits in the rvu_mbox_init() call that follows this hunk in
rvu_enable_sriov().  Does rvu->ng_rvu get leaked here?

rvu_mbox_init() allocates unconditionally on every call:

	ng_rvu_mbox = kzalloc_obj(*ng_rvu_mbox);
	if (!ng_rvu_mbox) {
		err = -ENOMEM;
		goto free_bitmap;
	}
	...
	rvu->ng_rvu = ng_rvu_mbox;

and it is called twice per probe: once as TYPE_AFPF from rvu_probe() and
once as TYPE_AFVF from rvu_enable_sriov().  The second call overwrites
the pointer stored by the first.

On cn20k the orphaned struct also owns the AFPF mailbox qmem
(cn20k/mbox_init.c stores rvu->ng_rvu->pf_mbox_addr = mbox_addr), and
rvu_remove() only frees the surviving pointer:

	if (is_cn20k(rvu->pdev))
		cn20k_free_mbox_memory(rvu);
	kfree(rvu->ng_rvu);

so that DMA allocation is never released either.
