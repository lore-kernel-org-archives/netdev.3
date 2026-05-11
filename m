Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463D406271
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514467; cv=none; b=VReULoS1dnJChkxVXzP2K/19tHS6QMe7daoQ8ZqTyC3pxlvxvVY/POoNSGaUsoKR7cJlpK51O5HJZ9L7yujz6LtGBo+AGoFnPsO7e0ViHO9azHkfs6uJGumbCNMo/xAIv0svLda13oPU9gm3Y/rdbb+VdB8CmxNI0QBYUpxmb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514467; c=relaxed/simple;
	bh=wg3sj4YnE54AHzo71NUx2gXbPJJaa+jjk+3YhaTtn2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHfKfXZtgPfhi+8SDmOrgDrgkUKWVvz7y+ssLCnkVHofQZP/2rTbiO4RfxRUHq8TCrdWPAyTKMZlBMLoe9NY6FSY0y30b7OujJquFR6+13Ajisc0YcMlQIq9NVQuustwRv21nYevruxCk7n/64aBsZQMubxyXd6NqKtUdiDNAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvNpoFXI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvNpoFXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF42C2BCB0;
	Mon, 11 May 2026 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514467;
	bh=wg3sj4YnE54AHzo71NUx2gXbPJJaa+jjk+3YhaTtn2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvNpoFXI3fi7jwGkY+pWzGB1wYn05cTBMtf2Kpj7RTyHJq6h1pPue8F7RwO173Ngr
	 6m+0uZ3W3Jhh6O9cOYnEzxy16U8y0930otjA13SJtsp2NtE0ypnPQG/FoQn8jWsPtR
	 KpaMT5d1UWpJbbz86jxDsUPw+jiEmn/icj+xqoNKm1LVpvBr7lVZ3gP0aYQr13Qxjo
	 XiY8SaGpgfLwCDroE0/qJJWHdmPl4SxZYcRJK5APgHS7fNNJbf2+HAzi+s4aFRUcyU
	 GQTiCzqc48IPD0rhu89keicVmyV6tExe2QBPCdpAAeHvs30A98+RE1gP4qya7zfhnr
	 99uBaZ7+MwEbw==
Date: Mon, 11 May 2026 16:47:43 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 7/8] ixgbe: limit ITR decrease in latency mode
 to prevent ACK overdrive
Message-ID: <20260511154743.GD27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-8-aleksandr.loktionov@intel.com>

On Fri, May 08, 2026 at 05:12:25AM +0200, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> When operating in latency mode and the computed ITR is lower than the
> current setting, the algorithm can reduce the interrupt rate too
> aggressively in a single step.  For a TCP workload this means the ACK
> stream (a latency-sensitive, low-packet-rate workload) can drive the
> moderation down to very high interrupt rates, starving CPU time from
> the sender side.
> 
> After the speed-based ITR calculation is complete, check whether the
> result is in latency mode and would decrease below the current setting.
> If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us)
> per update.  This ensures the number of interrupts grows by no more
> than 2x per adjustment step for latency-class workloads, dialling in
> smoothly rather than overshooting.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index aea76b3..ba7b013 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2888,6 +2888,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
>  		break;
>  	}
>  
> +	/* In the case of a latency specific workload only allow us to
> +	 * reduce the ITR by at most 2us. By doing this we should dial
> +	 * in so that our number of interrupts is no more than 2x the number
> +	 * of packets for the least busy workload. So for example in the case
> +	 * of a TCP workload the ACK packets being received would set the
> +	 * interrupt rate as they are a latency specific workload.
> +	 */
> +	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
> +		itr = max_t(unsigned int, itr,
> +			    ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC);

nit: I expect this could be min(). And if it could, it should.

> +
>  clear_counts:
>  	/* write back value */
>  	ring_container->itr = itr;
> -- 
> 2.52.0
> 
