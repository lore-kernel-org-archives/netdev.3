Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7F3C1D4B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999853; cv=none; b=rvOm0ke0ct5tErXcGavuJoqmannpuGrxodnCVE+Rnee9d6PD8Q5NJQYMnMDSbQwyubvl9iyAQXpc9eJ/Xawjn9jKAt58WatiQ7VCfjOkYtmY9l5CQAOjEOaCtBh2Zy9QpTCvwHm8UGXR3e3CfSIFXtFt42D5xUB/RdR/7tOdi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999853; c=relaxed/simple;
	bh=l3uZSvinsKgCCJLylZ7ayzanFFvNBhkzZHGDZiWqO+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrSkAA5ElIrJ/HFER7g/bFy3k2QmXjpyO4106n8//3LfMtYB+hZwp0WBfIiAIztu26ZPn0VIofQqVJkvbXCnDsPuI0vJCXuOGCUIQJnhDiWn+pmhr9O9QuBVPwKsGeRkBhEtD4bv+0EdQmFVrx+7JCs9lFpyIegJdlibPKBgsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pnvct3Pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pnvct3Pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59931F000E9;
	Mon, 17 Aug 2026 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999849;
	bh=7tnNg7RnLQQHJOOsDmIUNL3BOwFvIu2KqN4IU1Ml3YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pnvct3PpkJPYwFSsTXFdBRkKhw3eOGeZ/Tc5/97CBLzkX1BDoxcvInGn7YLyEZN+N
	 jtiuzw7s+oW+R1KLJ4tKIEglO6af27TBq6e4WU9NUzVg7Y8kwr/WHYf5utAWZjYwF+
	 cA7jlfjSvmJbaM6LGqBmbFbEsXWoEa9umJrA8ClFnA1710VaCzLO/xGb94PAsD1Opg
	 D6AVNTKb9DaKa50RdSDK4tRexGEEeDnCXYBNHSIsrFru0iyZMAlg9DIpLOx0RGrWe/
	 dje8rSjEKy87IbHzcinyFHPE+F0LcFpwBUzKPXmfMqoQlv1vNp/iDoxkEG6CZB7QTc
	 CDicC0FAes8MA==
From: Jakub Kicinski <kuba@kernel.org>
To: przemyslaw.kitszel@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	rafal.romanowski@intel.com,
	aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	marcin.szycik@linux.intel.com,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] ice: fix stats array overflow via proper realloc
Date: Mon, 17 Aug 2026 13:50:47 -0700
Message-ID: <20260817205047.3612990-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
References: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
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
    ice: fix stats array overflow via proper realloc

This patch removes ice_vsi_alloc_stat_arrays() and makes
ice_vsi_realloc_stat_arrays() handle the initial (no vsi_stat) case, tracking
the array sizes in the new tx_ring_stats_len / rx_ring_stats_len fields.  The
single remaining call site is in ice_vsi_cfg_def(), and the call in
ice_vsi_rebuild() is dropped.

Closes: https://redhat.atlassian.net/browse/RHEL-164321

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index e48ee5940f17..420e72df7f5e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -2379,7 +2353,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
>  		return ret;
>  
>  	/* allocate memory for Tx/Rx ring stat pointers */
> -	ret = ice_vsi_alloc_stat_arrays(vsi);
> +	ret = ice_vsi_realloc_stat_arrays(vsi);
>  	if (ret)
>  		goto unroll_vsi_alloc;
>  
> @@ -3097,10 +3071,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  
>  	mutex_lock(&vsi->xdp_state_lock);
>  
> -	ret = ice_vsi_realloc_stat_arrays(vsi);
> -	if (ret)
> -		goto unlock;
> -
>  	ice_vsi_decfg(vsi);
>  	ret = ice_vsi_cfg_def(vsi);
>  	if (ret)

[Severity: Low]
Does moving the ice_vsi_realloc_stat_arrays() call change what happens when
the stat array allocation fails during a rebuild?

Before this patch, ice_vsi_rebuild() did the realloc before
ice_vsi_decfg(), so a krealloc_array() failure returned -ENOMEM with the VSI
still fully configured:

	ret = ice_vsi_realloc_stat_arrays(vsi);
	if (ret)
		goto unlock;

	ice_vsi_decfg(vsi);

Now the only call site is inside ice_vsi_cfg_def(), which runs after
ice_vsi_decfg(), so an -ENOMEM there unwinds via unroll_vsi_alloc and is
propagated out of ice_vsi_rebuild() with the queues, vectors and rings
already released.

For the ethtool -L path that leaves ice_vsi_recfg_qs() in ice_main.c with
only this recovery:

	rebuild_err:
		dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n",
			err);

The same outcome was already reachable pre-patch through the other
allocations in ice_vsi_cfg_def() (ice_vsi_alloc_def(),
ice_vsi_alloc_q_vectors(), ice_vsi_alloc_rings(),
ice_vsi_alloc_ring_stats()), so this adds one more allocation to an
already-destructive region rather than a new failure mode.

The commit message describes the move only as:

    Also drop one callsite to avoid some duplication.

Could it also mention that the previously non-destructive failure path for
this allocation is gone?
-- 
pw-bot: cr
