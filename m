Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4B4EBAEF;
	Sat,  5 Sep 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633117; cv=none; b=IZ5tItqMIUm3cZCsb6IjkzHaSlKIccFJdM0rcWWDgFqyCo8/RjMWStbexxd8ZYn3QtVP7v5Mwnc1NnOOODd2Nqp6lzBfG6E8KzrAVCnHOzdLO7Qc9C/lP+6lu8ZThlEkNTM0klhOuw0qyspJ9TAPpTTXrg0oDRCtCzGlqR0A8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633117; c=relaxed/simple;
	bh=NGqQvHeOqIzb3Oeb4USWRt47/sjo0ztvRC1rLkM2XHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHWTvW2Ck/FJhpAGh3cHV8wdAHYVWeNeiOxrDYRx8Oc6t9YzrnGce0hp/+obqmI76yyQYmZ/YPJDdlCkAvISA1kssMoU9bfhNXbUEaN/xZA3yWZtX4SdekAI5HTGbhRzAVRfs3LZtmFXEovs7/fDwlWxUGWjT8Nh+UWVvlsijTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YopoFfQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YopoFfQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF441F00A3D;
	Sat,  5 Sep 2026 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633116;
	bh=p2DvN4334apFD/6/MWBRYC8GzHwMGwZWsOlmewSgMk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YopoFfQwDQgqHkfbpL2iSR6ekgyO2G8KzPY2X6o4MnVAoh2ajWG+ka2PjUDp6+gMn
	 YLQeq4q4YPvRFFin3IViemdhmPnaFBshd1wcgcnEaSTL8eatAbPGFUnX166oZ3miUz
	 tmhISV5W0PiqSPI06uP7HHNBH//X4zm1CphufnCPXOtS01HtEOUwO710g3oyh9/2oD
	 Mr024Mfg4LYFeyrKPWc3rQI6qfgML0R0AXUV4qbQXVeNo+vin7NPDvdl3783k6+41g
	 e/hLQ/0sW1nQmcWZsT99Z1ysl24AWtlOBpGr0RBCn41baqweHBpuTfLOh3AeJy6Ju2
	 Z36ls4tbbXAAQ==
Date: Sat, 5 Sep 2026 19:31:52 +0100
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
Subject: Re: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Message-ID: <20260905183152.GC40544@horms.kernel.org>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-2-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903132037.81346-2-ynorov@nvidia.com>

On Thu, Sep 03, 2026 at 09:20:35AM -0400, Yury Norov wrote:
> The function creates a temporary mask on stack just to check that
> first ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using
> the ice_pf_state_is_nominal().

maybe s/the ice_pf_state_is_nominal/bitmap_empty/

> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

The above nit not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d..73996e3022ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,16 +1705,10 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)
>  {
> -	DECLARE_BITMAP(check_bits, ICE_STATE_NBITS) = { 0 };
> -
>  	if (!pf)
>  		return false;
>  
> -	bitmap_set(check_bits, 0, ICE_STATE_NOMINAL_CHECK_BITS);
> -	if (bitmap_intersects(pf->state, check_bits, ICE_STATE_NBITS))
> -		return false;
> -
> -	return true;
> +	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
>  }
>  
>  #define ICE_FW_MODE_REC_M BIT(1)
> -- 
> 2.53.0
> 
