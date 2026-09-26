Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2462F26B742;
	Sat, 26 Sep 2026 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442350; cv=none; b=Qf3bGE7ZA0ihdIftOirv4git1YhrAbkLsecdSqLMdIz6rTARYr8Oa0ygxZg3MMIOjompK5w644sZR+4ZkWhRhJEu+Hy+bAjN2qzy/dhtUFsMzPDvQZEXRwXDKfztNb7GB/3zBBBi6S4ugjpL3OTegitT2sAiTTXF2zb89VMXFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442350; c=relaxed/simple;
	bh=o8+8uIXbPtYao3Wgy638oAGG6SB7ifNTupoNQ/dOELw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bawoZjWWdkY2ApdrxWx7768xS8kqGWRCpe/mFoK1qvjkmKcnXQm95E7Zz6HWKwntohZ9/NnALQzCe3aksYw+y7CjEkK1IINUhpMjZxKSDGokQ8ZVC8iyPdva2W6xprRFS1WIo2Sgh+HYCkaninjirYr87MMQ1XtC6Th7kI3cK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVRdVYlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVRdVYlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F284C1F000FF;
	Sat, 26 Sep 2026 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790442348;
	bh=fFbDQ/pAVTasBkqneTF+ptvM2577UUi5vrtaUdplXRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BVRdVYlD4uBJU6KfOfgmSvlMq1D+hUmGeTK5GH/5K/NInQ1zYwx/Gj2/ogL6AZgxX
	 elFpUrfNvJHJVajxCm1UyhergmnUS5ge/KbMFRTxLHHpSOmq9DO630Yq/X19xn61kq
	 qhnZ47QTiuGZ3L5f1Kv0svOsVLthetP3x4IdeadIv/Ozl4ZZzzO5N2nN1YAiGFbRAV
	 wj9HPGGeDbhV3ZD2c4YjRQwNwiSBUNNBlQzMbDOqw13QRBkdkNUIDEcDXNNbi342jG
	 EbX4RO+zjWlRpdiQT7SfQhvESadlCaog+ZcnU5hLIN7Qg/DXjP7lY25OZta3kgXnyU
	 gvU+/So1Q4gKA==
Date: Sat, 26 Sep 2026 18:05:43 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, arkadiusz.kubalewski@intel.com,
	davem@davemloft.net, edumazet@google.com,
	Maciek Machnikowski <maciej.machnikowski@intel.com>,
	Marc Neustadter <marc.neustadter@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start
 with PTP lock and incval
Message-ID: <20260926170543.GA13925@horms.kernel.org>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925222824.270640-2-grzegorz.nitka@intel.com>

On Sat, Sep 26, 2026 at 12:28:23AM +0200, Grzegorz Nitka wrote:
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
> 
> ice_start_phy_timer_eth56g() programmed the PHY increment value and
> performed the PHY-to-PHC phase synchronization in two separate PTP
> semaphore critical sections, and touched the shared source command
> register (GLTSYN_CMD via ice_ptp_src_cmd()) and read the source incval
> before acquiring the semaphore at all.
> 
> Because GLTSYN_CMD is a single global register latched for the source
> timer and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime (small
> offset, <= S32_MAX) or adjfine could clobber the source command between
> the incval-init and the phase-sync steps. In the worst case the source
> timer command written by ice_ptp_adj_clock() (ICE_PTP_ADJ_TIME) was
> overwritten by the unlocked ICE_PTP_NOP from ice_start_phy_timer_eth56g(),
> so the adjustment was applied to the PHY ports but not to the PHC. This
> left the E825 PHY clock permanently offset from the PHC, showing up as an
> intermittent clock drift.
> 
> Hold the PTP semaphore across the entire start sequence: acquire it
> before the first shared-register access (ice_ptp_src_cmd()), keep it held
> through the incval read, PHY incval init, and the phase synchronization,
> then release it once. Since the hardware semaphore is not recursive, split
> the phase-sync helper into ice_sync_phy_timer_eth56g_unlocked(), which
> assumes the caller already holds the lock, and call it directly from
> ice_start_phy_timer_eth56g(). The locking wrapper is removed as it no
> longer has any callers.
> 
> Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with PTP lock")
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 20bd1813650f..d3e4aeb7e496 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2045,7 +2045,7 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
>  }
>  
>  /**
> - * ice_sync_phy_timer_eth56g - Synchronize the PHY timer with PHC timer
> + * ice_sync_phy_timer_eth56g_unlocked - Synchronize the PHY timer with PHC timer

nit: I'm not entirely sure renaming the function is warranted.
     But it's your call.

>   * @hw: pointer to the HW struct
>   * @port: the PHY port to synchronize
>   *

...
