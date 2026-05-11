Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D41402435
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514778; cv=none; b=XX9uKOrRnDfpxdN000KkagO/TAxllfTwBVG7ZwWhDSnhzdn9xMkRjUOCrAfy2HlqmnVcegXXjLMQk4FwsJy9ZAiL1cxVwqTgwNWzxm12b1r5RqX5vhcuBAEToT/j+mBu+sQIWR6CkIDy+VNOdGie6xk+slnqinI+vcr4qEqVqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514778; c=relaxed/simple;
	bh=GhFo6kYdkj/hhSAzd8kvExucZWLwHP9doK3My8Cloeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwEK1ZCvlbwgHDvc/EQLBLBdxVJ50ZMGH/v3o8+UI2ceWUOFnYlNYn/bvyz7SA7hw5whm9V78wd0EhfMwb2Ej0ZVLj0vKm99TtvYnQrEu7PE18J+vreswn9OaD4cS2oWR2XSMW60U/nxUEWW2vUtg3pATOZUbv/1XkAinhk6HfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmvjtsWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmvjtsWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564B6C2BCB0;
	Mon, 11 May 2026 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514778;
	bh=GhFo6kYdkj/hhSAzd8kvExucZWLwHP9doK3My8Cloeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmvjtsWUnA/+Wv1/hk8OxOLxwwdOF9RUmJsi2iGmmWAaPI9Nd5LmcSisiKE9SPoeI
	 pna86ZZKsllzgTpH+h5lJm5oJKUpk8q/kEUBioWdEbJf900S40jBi0iZ2mdi/hcMIC
	 iyAuYCmiCWgXff1nPEpJ8u/3Cb1mjESKOGMJTY9TDQk3m9PPa5tAfYnGEzrXy2OOGJ
	 NdSe8WbxlEuQrPy+JFd0i2q/+uAyN2p0g/JDI9CXPeeqxOVGqESkBD1NA7kVszyWdL
	 hh81CwIJpt/HZ4l8nYj67L1QQQTBPJCOxa/1i12K13gPlk++zp8CsYFgag81B3civp
	 EPAwtG83CYxyA==
Date: Mon, 11 May 2026 16:52:54 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 8/8] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS
 constant
Message-ID: <20260511155254.GE27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-9-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-9-aleksandr.loktionov@intel.com>

On Fri, May 08, 2026 at 05:12:26AM +0200, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
> with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
> This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.
> 
> Add IXGBE_ITR_ADAPTIVE_MASK_USECS = IXGBE_ITR_ADAPTIVE_LATENCY - 1 =
> 0x7F to name this mask explicitly and replace the open-coded AND-NOT
> operation with the cleaner AND form.  The two expressions are
> arithmetically identical; the change improves readability.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index ba7b013..be40655 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2959,7 +2959,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
>  	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);

FTR: The AI-generated review of this patch points out that
     the correct comparison above should mask the above values
     first. I did not look carefully, but given my recollection
     of this function that does make sense. And perhaps it is something
     that could be considered as a follow-up. (I am not suggesting
     expanding the scope of this patch or patch-set.)

>  
>  	/* Clear latency flag if set, shift into correct position */
> -	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
> +	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
>  	new_itr <<= 2;
>  
>  	if (new_itr != q_vector->itr) {
> -- 
> 2.52.0
> 
