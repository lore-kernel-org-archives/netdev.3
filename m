Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B0194C96
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777074176; cv=none; b=syk82BBYVnPGk3heZ0U523Kyq/NbIUcYZiF3cFtz6B0Z9VeMy6hixDptNo0b7gna76ZsxVheOfLTn6biF6HOhGr8fLN2BdAEj+li7G/+2lJA3s4rMH1kBBAPOnaVyAJoHcxU+fiw6bJXS9ecfYWm7fW9+9Ia1HnK50hazejmuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777074176; c=relaxed/simple;
	bh=xshFMf2VMY7SoGs7/xFtNCry5wCfXIwmGTZ7cqC1L9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZdqNMOW9zQsk7fCivulpW7KtlSsaqCAX00Ze7BO9asK6wX1o780Go7RqU+bmKuJcht/szTXUDboNlUFvVRo2BIe/yd7j+xS+Z0FiOKQFTQobdcMBfgSFRiSvc5QdqC5c0x8rA58FyVeaUQcB4EKq7L0ZfdFZdvU3oSNjWh6GtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Q9/wSQCx; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Q9/wSQCx"
Received: from x1 (130.4.31.150.dy.iij4u.or.jp [150.31.4.130])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63ONg3iG088695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 25 Apr 2026 08:42:05 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=+FK47/YVSXCzd/k8sYv3lFTZMqjyAVmDEZ/iJ1TVHxk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777074127; v=1;
        b=Q9/wSQCxMei5CVr8QdHvKLXJdkEUKGKTV3t0F7DuavvKztDEAZBRyX74OJARZPTN
         eKDLcgXNzGZuDNc/3XnL3hXJodwxJB1f3Idp40f64ksQSe1owdVEtQ8kX4d4mxnD
         xlsZZOWbua2zqoqMcsbuQzB0TlJ9AUZ5SS1iA9Z97VcAtTxymkVHtYEhGalQRzcm
         vYVQgMqqJp8G+vxIdMxo87KziIyy5leyOOqsAvwuE9cGniDUXoDHcAOcScsyeYJI
         Kb7+msiI/HtRfxJdey7nTk9CIDp20k2B5qimIIEezZuq+emmpzi0M6XShYw63qph
         dWejcHyui2IrDZEJDHGT3g==
Date: Sat, 25 Apr 2026 08:42:03 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH v2] ice: wait for reset completion in ice_resume()
Message-ID: <aev_lixRClDKAvFg@x1>
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424030345.1140665-1-aaron.ma@canonical.com>

On 04/24 11:03, Aaron Ma wrote:
> ice_resume() schedules an asynchronous PF reset and returns
> immediately. The reset runs later in ice_service_task(). If
> userspace tries to bring up the net device before the reset
> finishes, ice_open() fails with -EBUSY:
> 
>   ice_resume()
>     ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>   ...
>   ice_open()
>     ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>   ...
>   ice_service_task()
>     ice_do_reset()
>       ice_rebuild()               # clears ICE_PFR_REQ, too late
> 
> Reproduced on E800 series NICs during suspend/resume with irdma
> enabled, where the aux device probe widens the race window.
> 
> Wait for the reset to complete before returning from ice_resume().
> 
> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v2: reword comment to clarify best-effort semantics (Kohei Enju)
> 
>  drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 5f92377d4dfc2..a81eb21ea87c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
>  	/* Restart the service task */
>  	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
>  
> +	/* Best-effort wait for the scheduled reset to finish so that the
> +	 * device is operational before returning. Without this, userspace
> +	 * (e.g. NetworkManager) may try to open the net device while the
> +	 * asynchronous reset is still in progress, hitting -EBUSY.
> +	 */

Thanks for the update!

Reviewed-by: Kohei Enju <kohei@enjuk.jp>

> +	ret = ice_wait_for_reset(pf, 10 * HZ);
> +	if (ret)
> +		dev_err(dev, "Wait for reset failed during resume: %d\n", ret);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 
