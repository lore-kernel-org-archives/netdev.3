Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E103E317B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846930; cv=none; b=TnUaCvwSkVOz3/96w9VNRx7gmsa67rZx8h+iPOO8lyJj9OE1ZeHlUIboLQXQYoW5exfJGNqNeMpUFL/3+srC7KToNXy5Lh/PKPJm7SIb4O/u1KbY+YgJHsd6aygH7jgaRX+P0EcY/Np8vMgyBFU/deHaL7xHKBhwkD+9IGrW5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846930; c=relaxed/simple;
	bh=XIEu33sccGQX13eIE5K9ho/2YWQ0EiJLq9H0mLlY5Qs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urg7s6wHXWPWRCg7iCCiwGHKytWbJoN+vEBqVri8h+VM2hWTQBPcDaaNFL4Dxz/WqOtOPfy6YuUj55baUa3NwFB6DnwwANJ4HOmmHCxTLF6T0kQf1YjjBWNoF1RnkDK9tYkOyQKC+y1d1I+qOwcjCOCPS57LWr4FkALcFvOqlis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiLDeltS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiLDeltS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911DB1F008A1;
	Mon, 12 Oct 2026 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846928;
	bh=/WGK7ibJNQu9xJEkoH+T11S2yiy/7orjdkha0NAQrdU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OiLDeltSIpL/V9Q8X+WGxlU/jZCmom+5sAU6jpnqyWuBkQMSQSIdQ66N7UmqPixg4
	 0JK2oN+3v0VdjTW20TXuQG+aR649o66Gq9r5M9oZUaZoNV3UrtSfP/ybs5uIzBu8cy
	 cUB3f+qZVrAje3bLJyT+1CUpqe3u0PCSUiAtBiXTG7rtOVwrxlwUJuxQdH7zWunu87
	 wyqpFuluTR7+lKaWFietyWrDmgL581CB1DRw4B6N0fJtNSUqc6oKr09btjfeVkfZFQ
	 CMWzCu++Q/uwzdwbXZc74hoN0m7dJIlZ2I4xO/9UIWeAuEd5ItAmlLcgMR+jfbsjnN
	 HPzCkzJ5M7+xA==
Subject: Re: [PATCH net v2 09/15] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 maciej.machnikowski@intel.com, jacob.e.keller@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 poros@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pmenzel@molgen.mpg.de, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Mon, 12 Oct 2026 23:15:27 +0000
Message-ID: <179184692717.434549.6585696302155195497@kernel.org>
In-Reply-To: <20261008215614.1987250-10-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-10-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kernel-doc for ice_clear_ptp_tstamp_eth56g() in
  drivers/net/ethernet/intel/ice/ice_ptp_hw.c no longer matches the code.
- [Low] The new kernel-doc for ice_ptp_phy_soft_reset_eth56g()
  (ice_ptp_hw.c:2301-2305) says 'The PHY_REG_TX_MEMORY_STATUS reads…

--

ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset

This commit removes ice_ptp_reset_ts_memory_eth56g(), which wrote zeros to
PHY_REG_TX_MEMORY_STATUS. It also drops the write from
ice_clear_ptp_tstamp_eth56g(). In its place, every timestamp index of a port
is now read just before the PHY soft reset in
ice_ptp_phy_soft_reset_eth56g().

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 07b55fbb88dde..e83ad2bb8d420 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -1134,16 +1116,12 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>   * @port: the quad to read from
>   * @idx: the timestamp index to reset
>   *
> - * Read and then forcibly clear the timestamp index to ensure the valid bit is
> - * cleared and the timestamp status bit is reset in the PHY port memory of
> - * internal PHYs of the 56G devices.
> - *
> - * To directly clear the contents of the timestamp block entirely, discarding
> - * all timestamp data at once, software should instead use
> - * ice_ptp_reset_ts_memory_quad_eth56g().
> + * Read the timestamp index to ensure that the valid bit is cleared and the
> + * timestamp status bit is reset in the PHY port memory.
>   *
> - * This function should only be called on an idx whose bit is set according to
> - * ice_get_phy_tx_tstamp_ready().
> + * This function should only be called on an index whose bit is set according
> + * to ice_get_phy_tx_tstamp_ready(), or as part of a full sweep when paired
> + * with a PHY soft reset via ice_ptp_phy_soft_reset_eth56g().
>   *
>   * Return:
>   * * %0     - success

[Severity: Low]
This isn't a bug, but the kernel-doc for ice_clear_ptp_tstamp_eth56g()
now looks a bit out of date. The Return section just below this hunk still
says:

 * * %other - failed to write to PHY

After this patch the function does not write anything. The only error it
returns comes from ice_read_ptp_tstamp_eth56g(). That is either a sideband
read failure or -EINVAL from the port range check in
ice_read_port_eth56g().

Since this block is being rewritten anyway, could the summary line and the
@port line be updated too? They still read:

 * ice_clear_ptp_tstamp_eth56g - Clear a timestamp from the quad block
 * @port: the quad to read from

On ETH56G the timestamp memory is per port. The new sibling helper uses
"Reset one port's Tx timestamp memory" and "@port: port number to clear".

> @@ -1152,24 +1130,16 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
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

[ ... ]

> @@ -2303,6 +2298,12 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
>   * to settle. This provides a controlled way to reinitialize the PHY
>   * without requiring a full device reset.
>   *
> + * To ensure that the internal counter matches the contents of the
> + * PHY_REG_TX_MEMORY_STATUS, read every timestamp index prior to performing
> + * the soft reset. The PHY_REG_TX_MEMORY_STATUS reads ensure that the region
> + * is cleared, while the soft reset procedure ensures that the timestamp
> + * counter is reset to zero.

[Severity: Low]
Does this comment name the wrong register? The sweep never reads
PHY_REG_TX_MEMORY_STATUS. The reads go through this path:

ice_ptp_clear_tx_memory_status_eth56g()
  ice_clear_ptp_tstamp_eth56g()
    ice_read_ptp_tstamp_eth56g()

ice_read_ptp_tstamp_eth56g() reads the per-index timestamp memory words via
the ETH56G_PHY_MEM_PTP resource:

	lo_addr = (u16)PHY_TSTAMP_L(idx);
	hi_addr = (u16)PHY_TSTAMP_U(idx);

	err = ice_read_port_mem_eth56g(hw, port, lo_addr, &lo);

PHY_REG_TX_MEMORY_STATUS_L/U is the ready bitmap in ETH56G_PHY_REG_PTP. It
is only read by ice_get_phy_tx_tstamp_ready_eth56g(), and reading it does
not clear anything.

The commit message has the same wording:

    We must read the PHY_REG_TX_MEMORY_STATUS in order to clear stale
    timestamps.

and:

    The reads to PHY_REG_TX_MEMORY_STATUS will reset the region valid
    bits ensuring that no stale data is left behind.

Could the comment and commit message say the timestamp memory entries
(PHY_TSTAMP_L/U) are being read? Otherwise a later change might "fix" the
sweep by reading the status bitmap, which would not clear any entries.

> + *
>   * Return: 0 on success, or a negative error code on failure when
>   *         reading or writing the PHY register.
>   */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
