Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB746AA6B;
	Mon, 14 Sep 2026 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393599; cv=none; b=P7nI3Zkm4qVuLb+dkWDLN/FyDXZGXsh9g3qqqWLL6xyqX0nEeKpDbk6yBEUt2m1NL7lK96q6pU0nV9j7lHTGAGsmozhosby52o1zI+wvnSxTmdE8lINBATr4B+/xVfNCvBSM7kKbbwaqo/GatRBMdGdkOswjr7to+xLT5UAyUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393599; c=relaxed/simple;
	bh=PbdDulgkkeutLNW3WmWamZnrYOF/90WHsagdDvZnF3Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K7k7JHMOZt23VbgxA5Py+iJz6m5WabuwKcTa1cdDcgLwBtpNPAp5XfLZxL5ygRKltx3pDyB4cZ1kz/Gb5q2VBHxbU+LW0YVgeE2YkRaOI+e7kXqTLMtRbLW7j8Vik+JMF8XlrgMRbH4cOj6r+TdXhpPoPvfyynI+vIsh+/OGKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXWK0kaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXWK0kaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE53C1F000FF;
	Mon, 14 Sep 2026 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393597;
	bh=5VMNtDtZgp/c9lPoLttNZ4KFHnQQw5DPKP4g5shhlks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HXWK0kaQ179L1QHF2sJctda8b/ay2inGLa+JI8qoHc5/Kn2A12QbFahX8SSShERZJ
	 NFcMatHQpSC1J5G9pSAKV515Yh3nlFlrMc5GTZe8N5318oEBKc1+CwbMDjKFMH80J9
	 Ed4IKwqckU63125ONoipVg9pIZuQDNBuCcx/MHMULPlSzgGg/uh38jGXwzEiOf/1qa
	 U1qxIQ3ZGTHrrZNWlR9drj8VSlvtL4WJUip+cWzjAt6cm/FZrGG/GecDzLQ+tiLwvU
	 xcXye20IFMDnAPLzRwI47kJynTKBwYVT8D2FiaJHDX97Fp6Pm8kGINX+QlJgzne6eP
	 Q0cUNR+prRVgw==
Subject:
 Re: [PATCH net] octeontx2-af: skip absent MCS blocks in PTP configuration
From: netdev-bot+sashiko@kernel.org
To: bolin.liu@seu.edu.cn
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 13:46:36 +0000
Message-ID: <178939359634.22033.5655691023198601345@kernel.org>
In-Reply-To: <20260913125212.110005-1-bolin.liu@seu.edu.cn>
References: <20260913125212.110005-1-bolin.liu@seu.edu.cn>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

- [Medium] The CNF10K-B branch of rvu_mcs_ptp_cfg() uses the CGX/RPM
  index directly as the MCS block id: rvu_cgx_ptp_rx_cfg() obtains…

Pre-existing issues:
- [High] mcs_get_pdata() walks the file-global mcs_list with no lock, no
  RCU and no reference counting, while mcs_probe() inserts entries with…

--

octeontx2-af: skip absent MCS blocks in PTP configuration

The patch adds a NULL check on the result of mcs_get_pdata(rpm_id) in the
CNF10K-B branch of rvu_mcs_ptp_cfg(), returning early instead of
dereferencing the pointer when no MCS block matches the RPM id.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> index fce22e314cac0..5e24d43d5fc79 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> @@ -50,6 +50,8 @@ void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena)
>  	/* CNF10K-B */
>  	if (rvu->mcs_blk_cnt > 1) {
>  		mcs = mcs_get_pdata(rpm_id);
> +		if (!mcs)
> +			return;

[Severity: Medium]
Is a failed lookup here really an "absent MCS block", or is it an id
namespace mismatch?  The value passed in as rpm_id is a CGX/RPM index,
taken from rvu_cgx_ptp_rx_cfg() in rvu_cgx.c:

	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
	...
	/* Inform MCS about 8B RX header */
	rvu_mcs_ptp_cfg(rvu, cgx_id, lmac_id, enable);

but mcs_get_pdata() matches that value against mcs->mcs_id with no
translation:

	list_for_each_entry(mcs_dev, &mcs_list, mcs_list) {
		if (mcs_dev->mcs_id == mcs_id)
			return mcs_dev;
	}
	return NULL;

and mcs_id comes from an unrelated namespace, the MCS PCI BAR, in
mcs_probe():

	mcs->mcs_id = (pci_resource_start(pdev, PCI_CFG_REG_BAR_NUM) >> 24)
			& MCS_ID_MASK;

The only in-tree description of this relationship is in
rvu_mcs_flr_handler() in the same file, and it says the mapping is not the
identity:

	/* CNF10K-B mcs0-6 are mapped to RPM2-8*/
	if (rvu->mcs_blk_cnt > 1) {
		for (mcs_id = 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {

If that comment is accurate, don't the low and mid rpm_ids resolve to the
wrong MCS instance and set or clear BIT_ULL(lmac_id) in another port's
MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION, changing the 8B parser skip for a port
owned by a different PF?  And don't the highest rpm_ids find no block at
all, so that the new early return silently skips the configuration that
65cdc2b637a5 was added to perform?

Either way, does this change lock in the assumption that a lookup miss is
legitimate rather than fixing the key used for the lookup?  If the comment
in rvu_mcs_flr_handler() is stale, could it be corrected in the same patch,
since the code and the comment can't both be right?

[Severity: High]
This isn't a bug introduced by this patch, but does the NULL test cover the
case that matters here?  mcs_get_pdata() walks the file-global mcs_list with
no lock, no RCU and no reference count, mcs_probe() inserts with a bare
list_add():

	list_add(&mcs->mcs_list, &mcs_list);
	mutex_init(&mcs->stats_lock);

and mcs_remove() never performs the matching list_del():

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

struct mcs and mcs->hw are devm_kzalloc()'d on the MCS pci_dev and
mcs->reg_base comes from pcim_iomap(), so after an unbind through
/sys/bus/pci/drivers/mcs/unbind or a PCI hot-remove the object is freed and
the BAR is unmapped while the node stays linked on mcs_list, and
rvu->mcs_blk_cnt stays stale.

Doesn't mcs_get_pdata() then return a dangling but non-NULL pointer that
passes the new check, leaving mcs_reg_read() and mcs_reg_write() to
dereference freed memory and issue readq()/writeq() against an unmapped
BAR?

The path is reachable from a PF mailbox message:

rvu_mbox_handler_cgx_ptp_rx_enable() -> rvu_cgx_ptp_rx_cfg() ->
rvu_mcs_ptp_cfg() -> mcs_get_pdata()

The same applies to the mcs_get_pdata(0) in the CN10KB branch below, to the
mcs mailbox handlers and to the debugfs stats files.  Would this be better
addressed with a list_del() in mcs_remove() plus a lock or RCU held across
the lookup and the register access, rather than a NULL test after an
unlocked lookup?  mcs_remove() also skips mutex_destroy(&mcs->stats_lock).

>  		cfg = mcs_reg_read(mcs, MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION);
>  		if (ena)
>  			cfg |= BIT_ULL(lmac_id);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913125212.110005-1-bolin.liu%40seu.edu.cn
