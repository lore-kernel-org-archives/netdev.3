Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE138DC43
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521143; cv=none; b=hzroKKk4arOmDNysU5p0geuDQANkI1pAsmlVbRtdKOWpkUkW1FAcPua2CilVSMTpQhhoThlpjntTM0aIC03WyKRQkD0PpfDE7Gd7HPiG63CRSDR+hFAS5an7+/CYStwbl40M14Em+/9QCmkGvye1UDP0GshHXaQkiqzkF/vwaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521143; c=relaxed/simple;
	bh=Xh6WOqJeIGGWxo44mISphOBCDDBnFqQgW9tGsQku7Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVcmS/gIBVcuEUqcVYH6pR3tVIcb4+ENUoCYV5fmnW0FbxQD7cjWmY9izMoQb3eyl06Gx6EzpmtVCVJLXRId/znY90OqgKOY3VR8oVdNbq6qEK0vdXOQCs2uE8k/ud6A7iDImBGozPLTn55n1LM3qV1RtofJfiboPM6NX/0Wp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQDgVOO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQDgVOO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437B21F000FF;
	Wed, 16 Sep 2026 01:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521141;
	bh=1BDJK/c3j6YbuH+8Mrvbsv8tIpgJkFKrzusRfY+39zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FQDgVOO+yrJP8zAVQOYROqhIkFvzyMWitxcxkvm6hx4vDfaa/jz/RaFabTO0Z0+Tp
	 DBM2DvL0lDrYITQG9PA7O07mawAWGjNUP4v3uHeYHCOocLizsrUJCmv0vVEouXBreB
	 fvnczATPeibgdEQRG8WYLscyi2DM0ge4x2WYvenCgGHUOn+toRR6A9jlSnCEBleqlr
	 9x+zGFTOLoD7tN9nR3MC3xLMrKWlWaEP1L07G9Z+47l+qqlqA3eU8anPeIj4aR2h6L
	 P/GVz08CNKzJhN64TVS+wnh82f+Ze495Pnm1g6kyIJBpgiwR1kf0xwDuTO23VJhOe4
	 9oKnLeCXGLnmQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	maciej.machnikowski@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 08/15] ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
Date: Tue, 15 Sep 2026 18:12:20 -0700
Message-ID: <20260916011220.1632615-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-9-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-9-anthony.l.nguyen@intel.com>
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
ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset

This replaces the register-write based ice_ptp_reset_ts_memory_eth56g()
with a read of every Tx timestamp memory entry for a port, and moves that
clearing into ice_ptp_phy_soft_reset_eth56g() so it always happens right
before the PHY soft reset. ice_ptp_reset_ts_memory() now does nothing for
E825.

Two questions below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index d48eb3c618231..a3a9f7ce04d2b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -1139,8 +1121,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>   * internal PHYs of the 56G devices.
>   *
>   * To directly clear the contents of the timestamp block entirely, discarding
> - * all timestamp data at once, software should instead use
> - * ice_ptp_reset_ts_memory_quad_eth56g().
> + * all timestamp data at once, software should instead perform a PHY soft
> + * reset via ice_ptp_phy_soft_reset_eth56g().
>   *
>   * This function should only be called on an idx whose bit is set according to
>   * ice_get_phy_tx_tstamp_ready().

[Severity: Low]

This isn't a bug, but should the rest of the kernel-doc for
ice_clear_ptp_tstamp_eth56g() be refreshed too?

The summary above still says "Read and then forcibly clear the timestamp
index", and the return list still says "%other - failed to write to PHY",
but the ice_write_port_mem_eth56g() call is removed below, so the body only
performs two PHY reads and no write can fail.

The retained line

  * This function should only be called on an idx whose bit is set according to
  * ice_get_phy_tx_tstamp_ready().

is also the contract repeated by the exported wrapper ice_clear_phy_tstamp(),
yet the new ice_ptp_clear_tx_memory_status_eth56g() calls this helper for
every index regardless of the ready bitmap. Since reading an index whose
valid bit is set is exactly what triggers the internal counter decrement
described in the commit message, is the precondition still meant to apply,
or should the doc say the unconditional sweep is allowed only when paired
with the soft reset?

> @@ -1152,24 +1134,16 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>  static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>  {
>  	u64 unused_tstamp;
> -	u16 lo_addr;
>  	int err;
>  
> -	/* Read the timestamp register to ensure the timestamp status bit is
> -	 * cleared.
> +	/* Per the PHY spec, reading the timestamp memory location is what
> +	 * clears the entry's valid bit and its corresponding (read-only)
> +	 * ts_memory_status bit.
>  	 */
>  	err = ice_read_ptp_tstamp_eth56g(hw, port, idx, &unused_tstamp);
>  	if (err) {
>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read the PHY timestamp register for port %u, idx %u, err %d\n",
>  			  port, idx, err);
> -	}
> -
> -	lo_addr = (u16)PHY_TSTAMP_L(idx);
> -
> -	err = ice_write_port_mem_eth56g(hw, port, lo_addr, 0);
> -	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for port %u, idx %u, err %d\n",
> -			  port, idx, err);
>  		return err;
>  	}
>  

[ ... ]

> @@ -1177,19 +1151,36 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>  }
>  
>  /**
> - * ice_ptp_reset_ts_memory_eth56g - Clear all timestamps from the port block
> + * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx timestamp memory
>   * @hw: pointer to the HW struct
> + * @port: port number to clear
> + *
> + * Fully reset a single PHY port's Tx timestamp memory. Per the PHY spec, the
> + * only way to clear a timestamp valid bit (and its read-only ts_memory_status
> + * bit) is to read the timestamp memory location, so read every entry for the
> + * port (two 32-bit reads each). This discards all timestamp data on the port,
> + * so it must only be used for a full reset; callers that must preserve
> + * in-flight timestamps clear individual indices via ice_clear_phy_tstamp().
> + *
> + * Due to interactions with an internal HW counter for the number of
> + * outstanding Tx timestamps, this *must* only be called as part of the
> + * ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal counter
> + * may become out of sync and prevent new timestamp interrupts.
> + *
> + * Return: 0 on success, negative error code on failure to read the PHY.
>   */
> -static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
> +static int ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
>  {
> -	unsigned int port;
> +	int err = 0;
> +	u8 idx;
>  
> -	for (port = 0; port < hw->ptp.num_lports; port++) {
> -		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_L,
> -					 0);
> -		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_U,
> -					 0);
> +	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
> +		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
> +		if (err)
> +			return err;
>  	}
> +
> +	return 0;
>  }

[Severity: Medium]

Can this fail-fast return leave the internal timestamp counter underflowed
for this port?

The reads are the side-effecting operation: each read of an entry whose
valid bit is set clears that bit and decrements the PHY's outstanding
timestamp counter. If ice_clear_ptp_tstamp_eth56g() fails at, say, idx 30,
the decrements for idx 0..29 have already been applied, and this function
returns before the soft reset that is the only thing which re-zeroes the
counter.

The read path goes through the sideband queue:

  ice_clear_ptp_tstamp_eth56g()
    ice_read_ptp_tstamp_eth56g()
      ice_read_port_mem_eth56g() -> ice_read_phy_eth56g() -> ice_sbq_rw_reg()

so a transient sideband failure is enough to hit this.

Would it be better to log the failing index but continue the sweep, and
still drive the soft reset before propagating the error?

> @@ -2306,6 +2304,13 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>  	u32 global_val;
>  	int err;
>  
> +	err = ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to clear PHY_REG_TX_MEMORY_STATUS for port %d, err %d\n",
> +			  port, err);
> +		return err;
> +	}
> +
>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>  	if (err) {
>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",

[Severity: Medium]

Same concern at this early return, and at the two error returns that follow
it. Once ice_ptp_clear_tx_memory_status_eth56g() has consumed entries, a
failed ice_read_ptp_reg_eth56g(PHY_REG_GLOBAL) or a failed first
PHY_REG_GLOBAL write also returns without ever asserting
PHY_REG_GLOBAL_SOFT_RESET_M, so the clear happens without its paired reset.

Isn't that the exact condition the new kernel-doc warns about?

  * Due to interactions with an internal HW counter for the number of
  * outstanding Tx timestamps, this *must* only be called as part of the
  * ice_ptp_phy_soft_reset_eth56g() procedure.

The error also propagates out of the per-port loop in
ice_ptp_init_phc_e825c():

  for (int port = 0; port < hw->ptp.num_lports; port++) {
          err = ice_ptp_phy_soft_reset_eth56g(hw, port);
          if (err) {
                  ...
                  return err;
          }
  }

so the remaining ports get neither the clear nor the reset. A later
successful soft reset would repair the state, but should the reset still be
driven for the port that already had its entries read?

This was checked at the end of the series and the fail-fast return and the
early return here are both still present, so no later patch in the series
changes this.
