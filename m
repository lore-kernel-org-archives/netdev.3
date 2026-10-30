Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396439;
	b=RCksUwaGfjXtzYmhZwtlLotr/xjFpdEEupNwKXoQm0CM24ExpuN24TtEWRl+y5blxuDj
	 J89ZVX43DCLrkzkEbhwPfpZKa0pZeQClhZSYBx+AckQ1d4sCYP3EZDMAiMt26Vme+z6sw
	 d52ewLlS2d/JDA23Vu3uomapQbyd601XLOfoBLNeovjAD7tAaylwsuJlQ4w/Pptwy2ip/
	 xYj6r0nqMLe6SaTNdQuMZ7FrRQLRV0XTQXU+/nYGmHCZ0OJViMCNAqlPZiDO5eWcOfsvn
	 M9S+Z8rzrWUelZwh+UxIuf+66FiylVO6iTbTyKHNDpGcWWgGemnqFOwt3llMeWOkioA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396439;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jf0LdFOp58CZ+IrsYdkd2eOgZeDDUjqTLwV6uzu6m2c=;
	b=yC8U2d9zRzsvaVEI0EEy89P1AAqhr7amIROP040ZY75r364oZE1i78AnrZ/NHfHMMtLK
	 sUkVMO7h87aDRW1Lw1lMZIama+LfF14gEcgUjeQWbBkk2JkcDg2Pxv951WIC5ks9w8zFy
	 dODeZ4xIuM1lhvwhqcGWGOzcuMEu7wRjil8xjbGCj5COH2aY1bCOVcd6v+g0dbZNxk3Wx
	 yPetbUVQXkuRSrzlbJ6am526V2k/xGpuSny9M2X1ksYSCYpnasNKmJxy75KWLMzYM5NdF
	 p78HoaAzFvkPAbGVsjwXmudfCUe46H65+hI7bnok2Rykaj6s8DYOZ/3mFtUo36bZX4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bU8E6+jB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12843606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bU8E6+jB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68561F000C1;
	Fri, 30 Oct 2026 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793396438;
	bh=jf0LdFOp58CZ+IrsYdkd2eOgZeDDUjqTLwV6uzu6m2c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bU8E6+jB+TjfjlowmwIWh7a+Cvmvnq+vrvGDBR3Pa/LmWpt3FQD+a+O41ZP6GsZAQ
	 o8K9bHe2JVY0XXKtsvdL5gROaVvooglQ6tDGt248wrpJrQJMRBR+BtGWs1ZF5BEh84
	 fWziRHjEeX8tJQl4UHpVrqP8T8u63SC9wsLkWG141893WiRRFD5xH+O3iADz7TFx7S
	 9tInjXiC+H6oYne9FxinPD/r7C+D8n4teRWWJBU/zYfzUIi5czhWFa9X2WY0s/kZ33
	 lj2mUoUosh+SsPqBIezRnhMt0b+tZw/TQpeg5xlk8xSawZC9+C58kOKQvzmUlYRpDN
	 gqvik8+f0UglQ==
Subject:
 Re: [PATCH net 2/3] ice: E825: clear PHY_TSTAMP memory prior to soft reset
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Fri, 30 Oct 2026 21:40:37 +0000
Message-ID: <179339643733.3131.11053424586570802270@kernel.org>
In-Reply-To:
 <20261029-jk-e825c-critical-timestamping-fixes-v1-2-72128d1dd928@intel.com>
References:
 <20261029-jk-e825c-critical-timestamping-fixes-v1-2-72128d1dd928@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The loop in ice_ptp_clear_tx_memory_status_eth56g() (`for (idx =
  0; idx < INDEX_PER_PORT; idx++)`, INDEX_PER_PORT = 64) only counts…

--

ice: E825: clear PHY_TSTAMP memory prior to soft reset

This commit replaces the E825 timestamp memory reset with a sweep. The old
code wrote zeros to PHY_REG_TX_MEMORY_STATUS. The new code reads every
PHY_TSTAMP index on the port, and the sweep only runs from within
ice_ptp_phy_soft_reset_eth56g(), so the soft reset puts the internal counter
and ready bitmap back in a consistent state. Read failures during the sweep
are counted and reported with a warning but are not treated as fatal.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 07b55fbb88dde..ef59b34ba52dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> +static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
> +{
> +	int err, failed = 0;
> +	u8 idx;
> +
> +	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
> +		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
> +		if (err)
> +			failed++;
>  	}
> +
> +	if (failed)
> +		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY timestamp registers for port %u\n",
> +			 failed, port);
>  }

[ ... ]

> @@ -2311,6 +2320,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>  	u32 global_val;
>  	int err;
>  
> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> +
>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>  	if (err) {

[Severity: Low]
What happens here if the sideband queue fails persistently instead of
transiently?

The loop in ice_ptp_clear_tx_memory_status_eth56g() runs for all 64
INDEX_PER_PORT entries. It counts failures and never stops early. It also
runs before the PHY_REG_GLOBAL read, and that read is the first access in
ice_ptp_phy_soft_reset_eth56g() that would catch an unreachable PHY.

Each index takes this path:

ice_clear_ptp_tstamp_eth56g()
  ice_read_ptp_tstamp_eth56g()
    ice_read_port_mem_eth56g()
      ice_read_phy_eth56g()
        ice_sbq_rw_reg()
          ice_sq_send_cmd()
            ice_sq_done()

ice_sq_done() polls with ICE_CTL_Q_SQ_CMD_TIMEOUT, which is USEC_PER_SEC.

If the sideband queue head stops advancing, each low read waits the full
1 second and then returns an error. A failed low read skips the high read,
so this costs one timeout per index. Fast -ENOSPC failures only start once
the 64 entry ring (ICE_SBQ_LEN) fills up.

That could mean about a minute of stall in the sweep before the
PHY_REG_GLOBAL read fails and the error is returned. Before this patch, the
same condition was caught after a single timeout on PHY_REG_GLOBAL.

ice_ptp_init_phc_e825c() calls ice_ptp_phy_soft_reset_eth56g(). That makes
this reachable from both ice_ptp_init_owner() during probe and
ice_ptp_rebuild_owner() during reset rebuild.

After the later commit in this series, "ice: E825: perform a soft reset
when starting the PHY timer", it is also reachable from
ice_start_phy_timer_eth56g() via ice_ptp_port_phy_restart(), which holds
ptp_port->ps_lock.

Because the sweep runs before PHY_REG_GLOBAL is checked, its read side
effects can also land on a port whose soft reset then fails. The new kdoc
does tell callers to treat a soft reset failure as a non-functional
timestamp block.

Would it make sense to stop the sweep after consecutive failures, or on a
timeout class error? Another option is to read PHY_REG_GLOBAL before
starting the sweep.

>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-jk-e825c-critical-timestamping-fixes-v1-0-72128d1dd928%40intel.com
