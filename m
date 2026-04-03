Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A721A447
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218236; cv=none; b=JmE71u1xau39diSG8TkNEiDU3REoZN5UK7TXcpIoSKK16qYgNrPCx4WsoBCZQ18UGstyBbTeGB0k9Xf6bGaxbciT/anTlFF5DpUtlsRfgzQXpXY4HnxLVecGAJHfohFfnlh4fYJZitwjB2cPTmxWvSVh7xEGkmTnCa8rsg+EgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218236; c=relaxed/simple;
	bh=u803PhasFkg/gwoHBQ6Hy62NZJQNqytt7qoNfLAq0DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlaWkjcKg9ho7AirTEK4lipoJnFXLyE8eL0fCiknM9z1eYFGIgaB37DZuA88V39PLJl/BpP08WiPR0wCz39hRAbqstwLPgQVrzYzYlyr3WTHrrDq4HSGByVXqilAkSj9FdBA/1CBqvuu564GhdxKcKNxQTk9CvbB7YtyP8IFxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0KJZjEU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0KJZjEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296CEC4CEF7;
	Fri,  3 Apr 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775218236;
	bh=u803PhasFkg/gwoHBQ6Hy62NZJQNqytt7qoNfLAq0DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0KJZjEU5yVWGTvfhDCi7BJ/v/xPMmTWKFTbnb6YyZkDOx3mDjp8fQxrhJMExwQ9L
	 k2YQk4vnKJpvIqsi0jhhFuNoKTTH24ucKAYxKK3dW5haMCTUCIhrDFDWBdD3CDl6nP
	 iEFy54ma0JwiqJ7eUqbs68CGzKL8XEt6pmvpX91Yyqb4fS3BY3S79hJ06f4sB/E/NK
	 IjiOInmDqwj8VIRwI/4W9z3D0XF1EVMLN2/qE4DO7n20/rF9HCL0Fmr8oApFkGHuMu
	 0MAvlgzoG3XZ4MD6xcD3aTe7cOEejGb4aCwHBOAH9AhHBnktz3Vl6G8cByvf0nB4fg
	 +/Rdt4bVp1rkw==
Date: Fri, 3 Apr 2026 13:10:32 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [PATCH iwl-next] ice: fix AQ error code comparison in
 ice_set_pauseparam()
Message-ID: <20260403121032.GA70436@horms.kernel.org>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
 <20260327072236.129802-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072236.129802-4-aleksandr.loktionov@intel.com>

On Fri, Mar 27, 2026 at 08:22:35AM +0100, Aleksandr Loktionov wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Fix unreachable code: the conditionals in ice_set_pauseparam() used
> the bitwise-AND operator suggesting aq_failures is a bitmap, but it
> is actually an enum, making the third condition logically unreachable.
> 
> Replace the if-else ladder with a switch statement.  Also move the
> aq_failures initialization to the variable declaration and remove the
> redundant zeroing from ice_set_fc().

I think that this second part feels more like a clean-up
than part of the fix. But I don't feel strongly about it.

> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> 
>  drivers/net/ethernet/intel/ice/ice_common.c  |  1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 12 ++++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index f1a6601..6dad7d4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -3883,7 +3883,6 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
>  	if (!pi || !aq_failures)
>  		return -EINVAL;

FWIIW, I think the defensive code above could also be removed at some point.

>  
> -	*aq_failures = 0;
>  	hw = pi->hw;
>  
>  	pcaps = kzalloc_obj(*pcaps);

...
