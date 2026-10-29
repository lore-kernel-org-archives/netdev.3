Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235218;
	b=CcDXD0CQNXRdDiA8CGEWKmmW0yKyRpzF7nUzjCvGnruzllvZ0/D6iXahC2Gp08Jn3HTE
	 Dr1qyW9znrAJrswVYQBo30iTpY0jG1K5a6Q4FYcJCTdfClY2A+8u7KcYrZWcu7K21Tuoy
	 pd1heu7DnZB5q+VKBeqWx4BykaN2d0+Ra9LNoa2yVkL/L0EoDyLpbXn8Rc7kerOTgCk51
	 Xe0T7Pc0aNGADf500r+ZRsx+wLpDz7I4If+3dD1eDkLAJLlMjvZZKJwWTsrEHzdbGqzdS
	 S12MWIAwgHkMEZxioYbiRLesBndCeXeGuQmA2v4EWf++cUm4iq7lraOG29i4RkV1nzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235218;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yvQgXBgwJOJW7neUTXl1bf0MSUF7feo6G5l+jEQFnKg=;
	b=YSr4/wou4nW6In7l7A3V3JsJRmNWZgNx5P3idXIQZ5lseh5ZSd2PdESveR2iXtgBDeOA
	 /YA23C2NPkv60V/7CHFjgKj7fAbIQfFuZUIGY9D/Y2v2WXz7vmOY8NwG81jmNaY9RA7Bu
	 mm/ERIaI/2cC9m/xCPlD5nKabDajoU9stYk1/O74GdoaWt4IOeluf7g9XcblrrG5gmS7r
	 KeFW8X3uPX4SJb+yYLrJ9/u6Cmn1+oP+BnFYvERX6kxVw5FU9O7zlRjpHNnmPqNqg2Jxc
	 D7FGKv/6GmbYfmoVd/c+bJa6tln6RvEe6NQG6rlEV1OdEj2F/SNCpaTNCOPNeUviZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+k5En1+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DB606A321
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+k5En1+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D851F01828;
	Thu, 29 Oct 2026 00:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235218;
	bh=yvQgXBgwJOJW7neUTXl1bf0MSUF7feo6G5l+jEQFnKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y+k5En1+wzxMFCrERvbk43GhytaXyTVeZx8s7WtE8zi1SaDjXoW27tuJLz0smjdzu
	 9EomvPKmyPnBORAK7e43mlxvL1gHg1emfjiCf0+LxqA9hZelqK/8peN5Zsn4paN/sw
	 hQ2LXrvFCRXKZu0jh6DXB/d8vgIsKBoPDAZKmD28qjFkX5JIfOkWE2zBT5sO86UU45
	 PY2Aa/VXjkZc6mx0AoKjVx+qngqedJY8r3DgVz+0flhDe0NQ8VQWlp2VekLRcbajoi
	 O8R1anxOLAb7B8gS79BNEo9UL/Bx6ij+Di11jWcf0Y2Yh+1nV8vOwhnMnQRfNNSZJO
	 xGdJb7KmsuB8A==
Subject:
 Re: [PATCH net 5/6] ice: E825: clear PHY_TSTAMP memory prior to soft reset
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Thu, 29 Oct 2026 00:53:36 +0000
Message-ID: <179323521668.3134.16925528364722533214@kernel.org>
In-Reply-To: <20261027-reduction-v1-5-81237c67a361@intel.com>
References: <20261027-reduction-v1-5-81237c67a361@intel.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ice_ptp_phy_soft_reset_eth56g()
  (drivers/net/ethernet/intel/ice/ice_ptp_hw.c), the patch adds an…
- [Low] The new kdoc for ice_ptp_clear_tx_memory_status_eth56g() in
  drivers/net/ethernet/intel/ice/ice_ptp_hw.c has a typo in the sentence…

--

ice: E825: clear PHY_TSTAMP memory prior to soft reset

This patch drops the E825 path that cleared Tx timestamp memory by writing
PHY_REG_TX_MEMORY_STATUS. Instead, ice_ptp_phy_soft_reset_eth56g() now
first reads every PHY_TSTAMP index for the port, then runs the soft reset,
so stale valid bits are cleared and the internal counter is reset. The
kdoc for ice_ptp_reset_ts_memory() and ice_ptp_phy_soft_reset_eth56g() is
updated to match.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 07b55fbb88dde..5c63f88bbf48a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -1177,19 +1147,43 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>  }
>  
>  /**
> - * ice_ptp_reset_ts_memory_eth56g - Clear all timestamps from the port block
> + * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx timestamp memory
>   * @hw: pointer to the HW struct

[ ... ]

> + * Due to interactions with an internal HW counter for the number of
> + * outstanding Tx timestamps, this *must* not be called outside if the
> + * ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal counter
> + * may become out of sync and prevent new timestamp interrupts.

[Severity: Low]
This isn't a bug, but there's a typo in this kdoc: "outside if the"
should be "outside of the".

[ ... ]

> @@ -2303,6 +2298,20 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)

[ ... ]

> + * In the event that the driver fails to access the PHY during the completion
> + * of the soft reset, (e.g. due to sideband queue message failures), the
> + * device may be left in an inconsistent state. Such failures are expected to
> + * be rare. Callers are responsible for checking the return of this function
> + * and treating errors as indicating that the timestamping block of the PHY is
> + * non-functional. Recovery may be possible by issuing another soft reset
> + * after any transient access errors have abated.
> + *
>   * Return: 0 on success, or a negative error code on failure when
>   *         reading or writing the PHY register.
>   */
> @@ -2311,6 +2320,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>  	u32 global_val;
>  	int err;
>  
> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> +
>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>  	if (err) {
>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",

[Severity: Medium]
Suppose the sweep finishes, and then the ice_read_ptp_reg_eth56g() of
PHY_REG_GLOBAL fails, or one of the three ice_write_ptp_reg_eth56g() calls
to PHY_REG_GLOBAL fails. The function returns early and the soft reset bit
is never toggled.

The commit message says each read of a valid entry, including cold boot
garbage, decrements the internal counter. Only the soft reset puts the
counter back to zero.

Can this leave the counter underflowed, with no Tx timestamp interrupts?
That is the condition this patch tries to prevent. Before this patch, a
failed soft reset did no PHY_TSTAMP reads.

The commit message says recovery happens on a link reset:

  "Upon a link reset, the driver will re-sweep the timestamp indexes and
  perform a fresh soft reset, clearing any inconsistency from the left
  over failed state."

The new kdoc also says another soft reset may recover.

Is there a code path that does this? The only caller of
ice_ptp_phy_soft_reset_eth56g() is ice_ptp_init_phc_e825c(). That is
reached only from ice_ptp_init_owner() and ice_ptp_rebuild_owner(), through
ice_ptp_init_phc().

On a link change, ice_ptp_link_change()->ice_ptp_port_phy_restart() does
this for E825:

	case ICE_MAC_GENERIC_3K_E825:
		...
		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

		err = ice_start_phy_timer_eth56g(hw, port);

This does not sweep and does not soft reset. Also, ice_ptp_link_change()
returns early when pf->ptp.state != ICE_PTP_READY. That is the case after
a failed init or rebuild.

After a failed rebuild the state is ICE_PTP_ERROR, and later calls to
ice_ptp_rebuild() exit here:

	} else if (ptp->state != ICE_PTP_RESETTING) {
		err = -EINVAL;
		dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
		goto err;
	}

So ice_ptp_rebuild_owner() is never retried. It looks like only a driver
reload would run the sweep and soft reset again.

Separately, ice_ptp_init_phc_e825c() returns on the first port that fails:

	for (int port = 0; port < hw->ptp.num_lports; port++) {
		err = ice_ptp_phy_soft_reset_eth56g(hw, port);
		if (err) {
			...
			return err;
		}
	}

The ports after it are neither swept nor reset in that pass.

Should the commit message and kdoc say a driver reload is needed? Or
should a real retry be added, for example by checking PHY_REG_GLOBAL access
before the sweep, or by retrying the reset when a failure happens after the
sweep?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-reduction-v1-0-81237c67a361%40intel.com
