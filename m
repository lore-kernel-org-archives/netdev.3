Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1741A510;
	Thu, 17 Sep 2026 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684507; cv=none; b=aY6ofrLaqxY/k0sloVTfryGRDjVZCSaGUWYqYnLQmiZi+CRXgboCCgYUDa260cByyIEr6Wr+OHiV5Mtt3twjo9VDa1Ku2VoMxD+cAJjoyDXBPoo3L1POAcUXgazUavdokOtMPlcUlb5yzrFEj3J3mTzQdQ6WAPO9Nxj1aSfHCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684507; c=relaxed/simple;
	bh=vehJn0Pp7Ti7F/IElivQRtLN40ggjKoFsOGitbaM8ic=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UMwknAGPJsXe9F5JKCA+H8ttfzP9P9aVt7+4+YBB1qT0b288Y/9DjRzvkf53xIhIojIWcEJY9TijPmayFQh/7WzkzZPjaBm9E1dLkC/MlYWUpZYVQPXxUmVfhXORS+ryiHrGYnsv7JmYEYsQ/WfPamKszm5iAGGKXpTZKcilr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl+9ADnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl+9ADnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1661F00893;
	Thu, 17 Sep 2026 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684504;
	bh=SiTPsjnjHLa2pmSfZ88k/q9a7BTNwXm7EW67cIgOE0I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cl+9ADnlMbWMMoGsJ1qWAIE9F1/ul/z7Jv//i5Lh+WhGDreGyiamCUsQA/7P5KPi6
	 wiGCCMg4Eiaq0cEH4OaUnhUB0zFIMeFgwxEwDRmDskcePqk8KYklC1Zb1GETzjOn4N
	 6Tyna39TkiV1HE6JEna0GkIfim0X9mgGqXY7E9MCPO6O/JnodWO4CM1KF0Jmpd5dZA
	 KXxRHkHXnu2xKxRFpajaUT0NbJAZ3u1iGFhXjSeeIfB4Pa5FFWr8mXJG3tJwa+K/pq
	 PsaNzUoi7qL5/BGHg5vCAP+18O4vPEpDUh12Sl/dORDPGcwGJlnEQYmKono4xuzTW8
	 96wWnXpnt8XOQ==
Subject: Re: [PATCH v28 net-next 04/10] net/nebula-matrix: add common resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:03 +0000
Message-ID: <178968450348.22033.3494276717606346180@kernel.org>
In-Reply-To: <20260914123429.56596-5-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-5-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Misleading comment and (at this commit) write-only shared state
  in nbl_res_ctrl_dev_sriov_info_init(): the comment asserts that…
- [Low] Dead state in struct nbl_eth_info:
  nbl_res_ctrl_dev_setup_eth_info() (drivers/net/ethernet/nebula-…

--

net/nebula-matrix: add common resource implementation

This patch adds the chip-independent resource layer for the nbl driver,
including PF-count validation from the firmware k_pf_mask, per-PF BDF and
VSI base-id tables, eth port discovery, and the VSI/func/eth/PF conversion
helpers.  All of the table setup runs only on the control PF during probe.

Two small observations below, both about state that has no reader at this
point in the series.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> new file mode 100644
> index 0000000000000..46180522295a3
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> @@ -0,0 +1,335 @@

[ ... ]

> +	/*
> +	 * Any subset of valid bitmap bits is accepted (e.g. 0/1, 0/2,
> +	 * 1/3, etc.).  Firmware only needs to report the correct count
> +	 * of active ports; no hard-coded fixed bit positions required.
> +	 */
> +	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
> +		if ((1 << i) & eth_bitmap) {
> +			set_bit(i, eth_info->eth_bitmap);
> +			eth_info->eth_id[eth_num] = i;
> +			eth_info->logic_eth_id[i] = eth_num;
> +			eth_num++;
> +		}
> +	}
> +
> +	for (i = 0; i < res_mgt->common->max_pf; i++) {
> +		eth_id = eth_info->eth_id[i];
> +		eth_info->pf_bitmap[eth_id] |= BIT(i);
> +	}

[Severity: Low]
This isn't a bug, but are eth_info->eth_bitmap, eth_info->logic_eth_id[]
and eth_info->pf_bitmap[] ever read?

Grepping the driver with the whole series applied, the only appearances of
these three members are the writes above plus the declaration in struct
nbl_eth_info.  eth_info->eth_id[] is the only member of the three tables
that gets consumed, via nbl_res_get_eth_id().

The commit message describes this as building "the per-PF eth_id /
logic_eth_id lookup tables", but nbl_res_get_eth_id() recomputes the
logical id instead of reading the table it just built:

	*eth_num = eth_info->eth_num;
	*eth_id = eth_info->eth_id[rel_pf_id];
	*logic_eth_id = rel_pf_id;

The two derivations agree for every layout the code accepts, because
max_pf == eth_num is enforced earlier, so the values are identical today.
Would it be clearer to either return eth_info->logic_eth_id[*eth_id] here,
or drop the unused members and the loops that fill them until a consumer
shows up?

> +static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
> +{

[ ... ]

> +	res_mgt->resource_info->sriov_info = sriov_info;
> +	/*
> +	 * common->hw_bus supplies bus number for channel mailbox QINFO mapping.
> +	 * Execution order guarantee: this assignment runs before
> +	 * cfg_chan_qinfo_map_table(), only executed
> +	 * on control PF path.
> +	 */
> +	common->hw_bus = hw_bus;

[Severity: Low]
Can this comment be verified at this point in the series?

At this commit nothing reads common->hw_bus outside of the loop just below,
and cfg_chan_qinfo_map_table() has no caller yet, so the ordering contract
the comment documents cannot be checked against the tree here.  The readers
do arrive in the later patches of the series (nbl_res_intr_cfg_msix_map()
passes common->hw_bus to cfg_msix_map(), and nbl_dev_setup_chan_qinfo()
passes it to cfg_chan_qinfo_map_table()), and nbl_core_init() does call
nbl_res_init_leonis() before nbl_disp_init() and nbl_dev_init(), so the
ordering claim holds once the series is complete.

Would it make sense to move this comment to the patch that adds the
cfg_chan_qinfo_map_table() call, so the referenced consumer exists in the
same commit?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> new file mode 100644
> index 0000000000000..a3bc7b3aecdea
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> @@ -0,0 +1,72 @@

[ ... ]

> +struct nbl_eth_info {
> +	DECLARE_BITMAP(eth_bitmap, NBL_MAX_ETHERNET);
> +	u8 pf_bitmap[NBL_MAX_ETHERNET];
> +	u8 eth_num;
> +	u8 resv[3];
> +	u8 eth_id[NBL_MAX_ETHERNET];
> +	u8 logic_eth_id[NBL_MAX_ETHERNET];
> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
