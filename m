Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4834165B;
	Sat,  5 Sep 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633170; cv=none; b=EkUHVA66BLdG9SEWMHoMAl1GpHrBqPFj0BsMMsEJFK5cpRSisRopUKyNElAzRdd2Ic+pA+qmTvSS3rG9Dm2eNWwlxNkfxAh/Arj+zwA/VG3lSUYawSqPajmZfnBmYbarDIKAmW+PYjDCfb+TpTrA0opWxyJQf68YPuF2lOuUEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633170; c=relaxed/simple;
	bh=WB42MQlfLM4+RA0myoDDVI5Kw7lVVLcYSh/l7GcuYnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5Yx05M6W2KSH36Vp4KONFUmtT+x3Pv/S18wN6Qm3Xt1oKUNp67+9IJlJRDZT3cBW0xEvIHmyl8XxxDn9gfnJ4OoAQIOVyPnKm/qlAcgOz2RnqZ6qLGEptvbJPXrOXvap5zFb7h9SMdrrf7Xs2eh97+kSXDkV3UEWS6a1a0aTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml/3Fl19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml/3Fl19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D6B1F00A3A;
	Sat,  5 Sep 2026 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633169;
	bh=CRbRvK6UjtwLjpKRLYyhoyHibVjGq4RyyAA88+58iEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ml/3Fl19d0QsBNvy/AL8dMr3K9xF5JAUNzOBLWScXa4qlLIWoigw8ieHz6cP8Mf3a
	 eM7YVxzy0qP1CUHWm+Xv1reHtCv/EjAdDTEv8V2j7TJL+vWQqlhApO1+0dUvkhFnGO
	 j5mz2BxuhH7IZYJAcNxtjblbpmm2/TxhsDBaOucSG+pk08z0nbT9Bp0GFT+Tl47cuT
	 pmlflB5Dd0p6u9NTwVzAx3b/2eMPtvi+swCr4KhNJNMTWldnNXX5GtGZhfbw2M4wrV
	 BVZmDfcInLYQi/MR43+MACzy7tt1xKdmOqG0SKGEgVv2vTmbSEW8LDzJZKwF7evFQd
	 Dr76A/hi6FSCw==
Date: Sat, 5 Sep 2026 19:32:45 +0100
From: Simon Horman <horms@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Message-ID: <20260905183245.GD40544@horms.kernel.org>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903132037.81346-3-ynorov@nvidia.com>

On Thu, Sep 03, 2026 at 09:20:36AM -0400, Yury Norov wrote:
> The function has 3 callers, all except one explicitly require
> pf != NULL. Add the corresponding check to the remaining caller,
> and remove it from the ice_pf_state_is_nominal(). It makse the
> fun function a one-liner.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 73996e3022ef..6d5b8acc4764 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)
>  {
> -	if (!pf)
> -		return false;
> -
>  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..168d85f9477f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
>  
>  	pf = pci_get_drvdata(pdev);
>  
> -	if (!ice_pf_state_is_nominal(pf)) {
> +	if (!pf || !ice_pf_state_is_nominal(pf)) {
>  		dev_err(dev, "Device is not ready, no need to suspend it\n");
>  		return -EBUSY;
>  	}

Is the new condition necessary in ice_suspend?
