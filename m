Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61C3F12CB;
	Thu,  3 Sep 2026 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427715; cv=none; b=DEShtJfx3cne8lGYw7Lv8UE+gpcbHmfxGQLZx8ew8AOLci/kGki4j8kwCI5AhObL2Cblmd2nTsm99sbreXv2VE5zA6S1NeWKKYLbTYlMEukU7Uu9gbZ4FxzfvwiPT9qhLnPa2DSaoVNgHWUfaw7JwDAiXg62tKdsz2qv6bB/APc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427715; c=relaxed/simple;
	bh=KdPikbKZw77wIUP3Hg5quQtLmCk+AUgIpmynOP8YgfE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llJXYiwkyFVzLUmdsdj27jLrxsSdgzLs0I2mjc51oyWsALu4hnz87WE53ec3CoHpngDcTjHFxvMwYEyRW8BVxs+7mOIDBvTtjHe8WE+ey8iSAWGLVKZRNt2uUpsPTncAAvm7Kh5R/DOKS7u9Pre48TBqHwJnJlnE9COalDG4380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2omrUpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2omrUpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBE51F00A3D;
	Thu,  3 Sep 2026 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427713;
	bh=10aZmp2MkCX2sFuHtp4WBkWRLNU7moxfiQfncP8llic=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z2omrUpZhcGHeo58eknO+iACr7cwWwLqwnaeCiO4LWQL2BaYssBWkKAMxP1rIdl1R
	 SXQhIJHvSuvP09OaZ/+0ag17S8gm/rhwfAGMomyNldUKVthWm09kjPM2IXTQxYsOQb
	 fYD4xYxOcW7MgoAZMwvOldpEXJDgQpJE2clQH111G6ZN5Z86aBfehk01Wfp6/dI8rY
	 vlNLlctmPa70hvfzhibKDtumz0k5LOEglqVdzYq9LhchYVUBE3o/52vuRZkHdDT8xA
	 00hnQYGAxgnKXNk4I8ecJjcH7JujQauu2DuhMfXD+x/ZGyOjsr917rqbbgGghQ8Vy0
	 tYYESJsFk3/Rw==
Subject:
 Re: [net-next,v2] octeontx2-pf: Add NIXLF error and poison interrupt handlers
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, naveenm@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 03 Sep 2026 09:28:31 +0000
Message-ID: <178842771187.3394541.7325489363068011329@kernel.org>
In-Reply-To: <20260831062600.839203-1-nshettyj@marvell.com>
References: <20260831062600.839203-1-nshettyj@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The patch bundles undisclosed VF-side changes that the commit
  message (subject "octeontx2-pf: Add NIXLF error and poison interrupt…
- [Low] The rewritten comment in otx2_realloc_msix_vectors()
  (otx2_pf.c:3086-3090) claims the code "Skip[s] NPA vectors", but the…

--

octeontx2-pf: Add NIXLF error and poison interrupt handlers

This registers handlers for the NIX LF error (NIX_LF_ERR_INT) and poison/RAS
(NIX_LF_RAS) MSI-X vectors in otx2_open(), frees them in otx2_stop(), and
widens the MSI-X reservation in otx2_realloc_msix_vectors() and
otx2vf_realloc_msix_vectors() to cover the new vectors.

A couple of questions about the changes below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index c995f29008590..1f8cb78c19195 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -3006,11 +3084,15 @@ int otx2_realloc_msix_vectors(struct otx2_nic *pf)
>  	struct otx2_hw *hw = &pf->hw;
>  	int num_vec, err;
>  
> -	/* NPA interrupts are inot registered, so alloc only
> -	 * upto NIX vector offset.
> +	/* Skip NPA vectors. Representors only use CINT vectors, so limit
> +	 * the budget to that range. For PF/VF, allocate the full NIX LF
> +	 * interrupt range (QINT, CINT, GINT, ERR and POISON vectors).
>  	 */

[Severity: Low]
Does the new comment in otx2_realloc_msix_vectors() describe what the code
does?  The count starts at hw->nix_msixoff and the allocation is:

	num_vec = hw->nix_msixoff;
	...
	err = pci_alloc_irq_vectors(hw->pdev, num_vec, num_vec, PCI_IRQ_MSIX);

pci_alloc_irq_vectors() enables the contiguous range starting at vector 0,
which includes everything below hw->nix_msixoff, and that is where the NPA
LF's vectors live.  rvu_mbox_handler_attach_resources() attaches BLKTYPE_NPA
before BLKTYPE_NIX, and rvu_set_msix_offset() hands out each LF's vectors
with rvu_alloc_rsrc_contig() from the function's MSI-X bitmap, so
npa_msixoff < nix_msixoff.

The NPA vectors are therefore still allocated, just left without handlers,
which is what the replaced comment said ("NPA interrupts are [not]
registered, so alloc only upto NIX vector offset").  Would it be clearer to
keep the original wording rather than saying the vectors are skipped?

>  	num_vec = hw->nix_msixoff;
> -	num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
> +	if (pf->flags & OTX2_FLAG_REP_MODE_ENABLED)
> +		num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
> +	else
> +		num_vec += NIX_LF_POISON_VEC + 1;
>  
>  	otx2_disable_mbox_intr(pf);
>  	pci_free_irq_vectors(hw->pdev);

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index fcdf891f90b58..3b06da52d37e5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -554,7 +554,7 @@ static int otx2vf_realloc_msix_vectors(struct otx2_nic *vf)
>  	int num_vec, err;
>  
>  	num_vec = hw->nix_msixoff;
> -	num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
> +	num_vec += NIX_LF_POISON_VEC + 1;
>  
>  	otx2vf_disable_mbox_intr(vf);
>  	pci_free_irq_vectors(hw->pdev);
> @@ -597,7 +597,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	pci_set_master(pdev);
>  
> -	qcount = num_online_cpus();
> +	qcount = min_t(int, num_online_cpus(), OTX2_MAX_CQ_CNT);

[Severity: Medium]
Should this queue count clamp in otx2vf_probe() be a separate patch, or at
least be described in the commit message?

The subject and body only talk about registering the two new NIX LF handlers,
but this line changes the VF datapath configuration: on a system with more
than 64 online CPUs every octeontx2 VF drops from num_online_cpus() rx/tx
queues to 64, since hw->rx_queues, hw->tx_queues, hw->max_queues,
hw->non_qos_queues and the alloc_etherdev_mqs() queue counts are all derived
from qcount.

It also looks like a fix for a pre-existing asymmetry rather than a
requirement of the new handlers.  otx2_probe() already had the same clamp:

	qcount = min_t(int, num_online_cpus(), OTX2_MAX_CQ_CNT);

while the VF did not, so with more than 64 CPUs the VF's cint_cnt (max3 of
rx_queues, tx_queues and tc_tx_queues) exceeded the 64 CINT slots available
between NIX_LF_CINT_VEC_START (0x40) and NIX_LF_GINT_VEC (0x80) in
otx2_common.h, and the CINT vector indices ran into GINT/ERR/POISON or past
the LF's vector count.

Would a standalone patch carrying

	Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")

be more appropriate for the clamp?  The "Changes in v2:" note that mentions
it sits below the --- separator and is dropped when the patch is applied, so
the recorded history contains no trace of this change.

The same applies to the otx2vf_realloc_msix_vectors() hunk above: the VF
reservation moves from the queue-count-scaled NIX_LF_CINT_VEC_START +
hw->max_queues to the fixed NIX_LF_POISON_VEC + 1, and VFs pick up the new
handlers only because otx2vf_open()/otx2vf_stop() call into the shared
otx2_open()/otx2_stop().  Should the commit message mention that this touches
VFs too, given the "octeontx2-pf:" subject prefix?

>  	qos_txqs = min_t(int, qcount, OTX2_QOS_MAX_LEAF_NODES);
>  	netdev = alloc_etherdev_mqs(sizeof(*vf), qcount + qos_txqs, qcount);
>  	if (!netdev)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831062600.839203-1-nshettyj%40marvell.com
