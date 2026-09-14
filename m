Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60733DA7D4;
	Mon, 14 Sep 2026 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393036; cv=none; b=bE8LDjUzCMDmTG5sZyrgu9q1QKnhNYqEBQvnkVChMN2OASs75S1PsWqyvZUwgN6EDhp2W4V2aNAaMZfb7DXjmNGnuEGbfIz9VWKggGezbqaGlDqQp7M30E43XAwi5aRYD5YQJxPDLkfzFhJcLSOEDYlLweM/gG4uTkeU7GZHFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393036; c=relaxed/simple;
	bh=Rrqk5haBY4tWRAomo0OZxzkC1GZJtdylA/WhZozTuaM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pjNwapB0JPQ/OMaxahQkqzP1wT36q1kVPnJSuceYsDCnYdTzZ+K+tCTTWbYGDuSaNgy/UwPLF2B/tNQq/oK1Pv07NMDb7AZK3jUBpmIRTp/pHQ34lg6tLyYU9MvSyYUV4gQsscyxg0RLmlLegVVCepizRrVtKVVAHTbFj2bpAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyM6KLqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyM6KLqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79561F000FF;
	Mon, 14 Sep 2026 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393034;
	bh=h6WkNjbtd4spIdcWaRB3Goha7mgelfWeHhKPKmKGcS0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OyM6KLqAcYypQJODs0sQBC2Fwyixw9dLO1DScwgSy0OCA1T/MSU9s3Jm0G8HDWYZF
	 +pfHO4svw6gZCbWy7IiBW6+QyBxAZ+D4mhLyItgKeS/Cj/wdaCwWFH5Cgk/jMSrdy5
	 wm5r+j6KlL1olt+GFZVd4aC62yoQw2aT/FiqANGBz7SYUgXpk1IzJqa1HaFiDPk0if
	 OcLO1Bb+dkmZpEjoZJjeXiXNtVb5GHQN4fJKgMnc9v7+L+oBL1otIDhtbELZvrHThm
	 27Xhu+E7hR0UdwwDs9Z0Ggcg/s2EHJJp6R9iH4F7Qn07/5Iao6T3R+kSCfUbelVMW3
	 ptyMz9iBhzptw==
Subject:
 Re: [PATCH net] octeontx2-af: validate MCS blocks before initialization
From: netdev-bot+sashiko@kernel.org
To: bolin.liu@seu.edu.cn
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 13:37:13 +0000
Message-ID: <178939303324.22033.8880641797671106965@kernel.org>
In-Reply-To: <20260913125206.109985-1-bolin.liu@seu.edu.cn>
References: <20260913125206.109985-1-bolin.liu@seu.edu.cn>
X-sashiko-severity: High
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

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

- [High] The new `return -ENODEV` in rvu_mcs_init()
  (mcs_rvu_if.c:892-896) aborts before mcs->rvu, mcs->pf, mcs->vf are…
- [High] The patch introduces a Time-Of-Check to Time-Of-Use (TOCTOU)
  race by locklessly pre-checking mcs devices before a subsequent…

Pre-existing issues:
- [High] mcs_remove() (mcs.c:1609-1620) never unlinks the block from the
  global list: it calls mcs_set_external_bypass(), free_irq(),…

--

octeontx2-af: validate MCS blocks before initialization

This adds a pre-pass in rvu_mcs_init() that walks every MCS block id in
[0, rvu->mcs_blk_cnt) and returns -ENODEV if mcs_get_pdata() returns NULL
for any of them, before the loop that programs the blocks.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> index fce22e314cac0..0ee2d0d698e5c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> @@ -889,6 +889,11 @@ int rvu_mcs_init(struct rvu *rvu)
>  		rvu_mcs_set_lmac_bmap(rvu);
>  	}
>  
> +	for (mcs_id = 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
> +		if (!mcs_get_pdata(mcs_id))
> +			return -ENODEV;
> +	}

[Severity: High]
The check and the use are two independent walks of the same
unsynchronized list, so what does the pre-pass actually buy us?

mcs_get_pdata() in mcs.c walks the file-global mcs_list with a plain
list_for_each_entry() and no lock or RCU, and mcs_probe() links onto
that list with a bare list_add(). Nothing in rvu_mcs_init() pins the
blocks between the new validation loop and the programming loop below
it, which re-fetches the pointer:

	mcs = mcs_get_pdata(mcs_id);
	mcs_install_flowid_bypass_entry(mcs);

So the new loop only establishes that every id in [0, mcs_blk_cnt) was
resolvable at the moment it ran. If an MCS PCI function goes away in
the window - "echo <mcs-bdf> > /sys/bus/pci/drivers/mcs/unbind" while
AF probe is in progress - the second mcs_get_pdata() for that id can
still hand back NULL and mcs_install_flowid_bypass_entry(mcs) will
dereference it immediately, which is exactly the crash the commit
message says it prevents. The rest of the loop body (mcs->hw->lmac_cnt,
mcs->rvu, mcs->dev in the devm_kcalloc() calls) has the same problem.

Folding the NULL test into the existing programming loop, so the
pointer that is checked is the pointer that is used, would at least
remove the second lookup and is a strictly smaller change. That still
leaves the underlying question of how mcs_list is meant to be
serialized against driver unbind - is there an intended lock or
refcount here, or is the assumption that rvu_mcs_init() cannot run
concurrently with mcs_remove() at all? If it is the latter, please
spell that assumption out, because the pre-pass reads as if it were
defending against exactly that race.

While you are in here: rvu_mcs_set_lmac_bmap() above the new loop
already does mcs_get_pdata(0) and dereferences mcs->hw->lmac_cnt with
no check, so on the CN10K-B (mcs_blk_cnt == 1) path a missing block
faults before the new validation is ever reached. Should the check
move ahead of that call instead?

[Severity: High]
Does this early return leave the already-probed MCS blocks with live
interrupts pointing at uninitialized AF state?

The new return happens before the second loop assigns mcs->rvu, mcs->pf
and mcs->vf, and before INIT_LIST_HEAD(&rvu->mcs_intrq_head), INIT_WORK()
and alloc_workqueue("mcs_intr_wq") run.

Meanwhile every block that did probe already armed its interrupts in its
own probe, mcs_probe() -> mcs_register_interrupts(), which does
request_irq(..., mcs_ip_intr_handler, 0, "MCS_IP", mcs) and writes
MCSX_IP_INT_ENA_W1S / MCSX_CPM_RX_SLAVE_RX_INT_ENB, and only then does
list_add(&mcs->mcs_list, &mcs_list).

So after the -ENODEV, an MCS CPM interrupt would run:

mcs_ip_intr_handler()
  mcs_rx_misc_intr_handler()
    mcs_add_intr_wq_entry()

and mcs_add_intr_wq_entry() has no NULL guard:

	struct rvu *rvu = mcs->rvu;
	...
		pfvf = &mcs->pf[rvu_get_pf(rvu->pdev, pcifunc)];
	...
	list_add_tail(&qentry->node, &rvu->mcs_intrq_head);
	queue_work(rvu->mcs_intr_wq, &rvu->mcs_intr_work);

mcs->rvu is still NULL here since struct mcs is devm_kzalloc()'ed and
mcs->rvu is only set in the loop below the new check.

On the AF side, rvu_setup_hw_resources() does:

	err = rvu_mcs_init(rvu);
	if (err) {
		dev_err(rvu->dev, "%s: Failed to initialize mcs\n", __func__);
		goto nix_err;
	}

The nix_err path never calls rvu_mcs_exit(), and mcs_driver stays bound to
the MCS PCI functions, so nothing disables the interrupt enables that were
just programmed. Links and RX were already enabled by cgx_start_linkup()
earlier in rvu_setup_hw_resources(), and the surviving blocks are not in
external bypass, so received traffic carrying a SecTAG can still raise
MCS_CPM_RX_INT_SECTAG_V_EQ1.

The commit message says "so a failed lower-ID probe cannot cause a NULL
dereference". In that exact configuration, does the dereference just move
from probe time to interrupt time rather than going away? Would it make
sense to also guard mcs_add_intr_wq_entry() on !mcs->rvu / !mcs->pf, or to
disarm the probed blocks before returning?

[Severity: High]
This isn't a bug introduced by this patch, but is a non-NULL result from
mcs_get_pdata() actually proof that the block is live?

mcs_remove() does not unlink the block from the global list:

	static void mcs_remove(struct pci_dev *pdev)
	{
		struct mcs *mcs = pci_get_drvdata(pdev);

		/* Set MCS to external bypass */
		mcs_set_external_bypass(mcs, true);
		free_irq(pci_irq_vector(pdev, mcs->hw->ip_vec), mcs);
		pci_free_irq_vectors(pdev);
		pci_release_regions(pdev);
		pci_disable_device(pdev);
		pci_set_drvdata(pdev, NULL);
	}

There is no list_del(&mcs->mcs_list) matching the list_add(&mcs->mcs_list,
&mcs_list) in mcs_probe(). Both mcs and mcs->hw are devm_kzalloc()'ed on
the MCS PCI device, so devres frees them right after mcs_remove() returns
and a freed node stays linked in mcs_list. cgx_remove() does the
list_del(&cgx->cgx_list) that mcs_remove() omits.

mcs_get_pdata() then hands out that dangling pointer:

	list_for_each_entry(mcs_dev, &mcs_list, mcs_list) {
		if (mcs_dev->mcs_id == mcs_id)
			return mcs_dev;
	}
	return NULL;

So after "echo <mcs-bdf> > /sys/bus/pci/drivers/mcs/unbind", does the new
check distinguish "never probed" from "probed then freed"? The following
programming loop would then touch mcs->hw->lmac_cnt and mcs->dev on freed
memory, and the mailbox handlers that only validate
req->mcs_id < rvu->mcs_blk_cnt before touching mcs->hw, mcs->mcs_ops,
mcs->tx_sa_active and mutex_lock(&mcs->stats_lock) would do the same, with
MMIO going through a released pcim_iomap() mapping.

>  	/* Install default tcam bypass entry and set port to operational mode */
>  	for (mcs_id = 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
>  		mcs = mcs_get_pdata(mcs_id);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913125206.109985-1-bolin.liu%40seu.edu.cn
