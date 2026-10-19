Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440853;
	b=W/AGSvDggGgKg43zMW4DHEFuLpzMdSGf/W4ze/ZjKxNg1tAAwFm7tyFEh473VdpL7LlN
	 RRdnCSEnFEmQPrIwhlVEZpTbUYuM71aidb3ZP1jmrxSm0Q6I3WJQ5wmF+vdWUr1wKh4Yt
	 NeIlpeak4rJtnF1R2oR6BUR6oyV/fAFA6eGjuVvMzZ8h+fx8fs+DnETOdj5gN9IQUTp4D
	 DPRkijA4Cucl7mOjQzteeyt4KR9fd/G1Aq9D2bszx4qJD7bYCpgnc3+W/vhLIjSNuw19r
	 ecnEfkG2v1ZZPIrQ6TawEyRiwpejExRThO/rCqBKbJTd7EQR7c2owY/VkQbcmjrjuHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440853;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ekmpdg82+9MfQueR1NWhEXLcPmxlAvluZqQXb/y7mS8=;
	b=IqT5LSDUmFAcF43owUVNSrmM7Cbojz2KO/VKpFBrWzUr7u8v7gU51yylXmUbAXiM5x9x
	 ORvPVs7GW+XDh+RbbKdP9YbXWWQIlsNB+NV8t7nI/gnJEJpAXgkq0Q3f6jXBjt/cVhvmM
	 TVzVHnSkh0MIgyMhhWQcpRcSSKd9vcD5kXiYjrZbX0ND92x8J4b+LMII/59tTMUt9+DVg
	 tasc1qR1jvveQ5/Ej8KLqBQSytNmPog2S7fTKRcnDFJcfE2rj7YYwkR2UXIu0eRhJUHDR
	 Ama9Ix3EoqPABrMdMOnGjL+N7xdaGmSM9GaCt2YIJUcyb3K3CxzLQHYbojbTQipcUQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6c0QaH7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F7606A33B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6c0QaH7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0691F000C7;
	Mon, 19 Oct 2026 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440853;
	bh=ekmpdg82+9MfQueR1NWhEXLcPmxlAvluZqQXb/y7mS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b6c0QaH7Fz3QpVl1sRsI4F43BoytMVt8XMyILh2Qp20LifpGgQZQTvxyQHNPnkIWP
	 oCDgf0B9FWTpAtmxxsAjA8DTJd11qxDUarxTmC1HamycxtrWDxS1ffLWzWejLWeA2T
	 WHAxwUE1tNwcNL+SRgV2q2twLn9o7WaZ3kttEuTmZ9doN6FJFqCb1MVH93vBp94smH
	 ClGtJgLFYYAJAFt3jtU73O3OxgxqHP8zc94X5FEf9U8fpaayy12bKRXItgsAGefONE
	 d88mX59M6eI09hU9t6KnSA34CzTd6v5NeM4kC5FBBclHqJNg27HmitALBvCQ1FWzyt
	 hbmcf/bjnQpwQ==
Subject: Re: [PATCH net v3 09/14] ice: E825: clear PHY_TSTAMP memory prior to
 soft reset
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:11 +0000
Message-ID: <179244085178.3135.3380160340565302392@kernel.org>
In-Reply-To: <20261015191102.1174111-10-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-10-anthony.l.nguyen@intel.com>
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

- [Low] In ice_ptp_phy_soft_reset_eth56g()
  (drivers/net/ethernet/intel/ice/ice_ptp_hw.c), the patch puts the read…
- [Low] The concern is that the kernel-doc of ice_ptp_reset_ts_memory()
  ('Reset timestamp memory for all blocks') no longer matches the code,…

--

ice: E825: clear PHY_TSTAMP memory prior to soft reset

This patch replaces the E825 timestamp memory reset, which wrote
PHY_REG_TX_MEMORY_STATUS and had no effect, with a sweep that reads every
PHY_TSTAMP index on the port. The sweep now runs at the start of
ice_ptp_phy_soft_reset_eth56g(), so the soft reset that follows resets the
internal counter. ice_ptp_reset_ts_memory() no longer does anything for
E825.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 07b55fbb88dde..38d0ded1d0cc0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -2311,6 +2312,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>  	u32 global_val;
>  	int err;
>  
> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> +
>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>  	if (err) {
>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",

[Severity: Low]
The sweep runs before any of the PHY_REG_GLOBAL accesses that can fail.
What happens to the internal counter if one of those later steps fails?

ice_ptp_clear_tx_memory_status_eth56g() returns void and always reads
every index. After it runs, ice_ptp_phy_soft_reset_eth56g() can still
return early. That can happen at the PHY_REG_GLOBAL read or at any of the
three PHY_REG_GLOBAL writes:

	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
	if (err) {
		...
		return err;
	}
	...
	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
	if (err) {
		...
		return err;
	}

The commit message says reading a garbage entry after a cold power-on can
underflow the counter, and only the soft reset sets it back to zero. If
the reset pulse is never issued, or only partly issued, is the port then
left in the state that the new kernel-doc of
ice_ptp_clear_tx_memory_status_eth56g() warns about?

    this *must* only be called as part of the
    ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal
    counter may become out of sync and prevent new timestamp interrupts.

ice_ptp_init_phc_e825c() then stops at the first port that fails:

	for (int port = 0; port < hw->ptp.num_lports; port++) {
		err = ice_ptp_phy_soft_reset_eth56g(hw, port);
		if (err) {
			...
			return err;
		}
	}

That port stays swept but not reset, and ice_ptp_init_owner() and
ice_ptp_rebuild_owner() only return the error. Before this patch, a failed
soft reset could not cause this desync, because nothing destructive ran
before it.

Later in the series, ice_start_phy_timer_eth56g() also calls
ice_ptp_phy_soft_reset_eth56g() every time the PHY timer starts, so this
path runs more often.

Could the PHY_REG_GLOBAL read be done before the sweep? Alternatively,
could the reset be completed or retried once the sweep has run?

[ ... ]

> @@ -5802,8 +5805,9 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw)
>  		ice_ptp_reset_ts_memory_e82x(hw);
>  		break;
>  	case ICE_MAC_GENERIC_3K_E825:
> -		ice_ptp_reset_ts_memory_eth56g(hw);
> -		break;
> +		/* E825 hardware must only reset timestamp memory as part of
> +		 * the soft reset procedure.
> +		 */
>  	case ICE_MAC_E810:
>  	default:
>  		return;

[Severity: Low]
This isn't a bug, but the kernel-doc for ice_ptp_reset_ts_memory() still
reads:

 * ice_ptp_reset_ts_memory - Reset timestamp memory for all blocks

E825 is now a no-op here, like the E810 and default (E830) branches. The
only explanation is the inline comment.

Could the kernel-doc list which MAC types are skipped? It could also say
that E825 clears its memory through ice_ptp_phy_soft_reset_eth56g()
instead.

This doesn't change how ice_ptp_cfg_phy_interrupt() behaves. Both
ice_ptp_init_owner() and ice_ptp_rebuild_owner() call ice_ptp_init_phc()
before it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
