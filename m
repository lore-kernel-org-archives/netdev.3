Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FA3FFAD0;
	Fri, 25 Sep 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338124; cv=none; b=Zi01HFQJCjrX+rkcbG7K4CEPXtzQNSkijWTJk1uYBGqRlKtsMQC3SMeldGBkPWA8m7FcmwlyPANHwpXbcpvGp0GePxR1Zw4jgupE9iWI90cvR0hIk1o8060jOPvCoip6ulwYsOUCfJdw7bjswXMOgy+pxlRMFD9ysl8VgtrJjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338124; c=relaxed/simple;
	bh=AwxyG5WjFSPOA4DXGl6nSCXX/DAk43iGaZN9VXxQsX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H34jEiHiJaU3rQi2fd9MmAdfoWeLfobm67Z4m45ig8KbT/us5FxxbK5sYKbaEafkXeRSbQ2ramaHFGxB860nLya6sVucM99pCPruMJhI4lmvVnMDm3ajKRkGm13TjxlqkinxbtO2yZFTOJOhmKeXk28E4WYhC0ac12DIB2jpy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USfcKXXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USfcKXXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196461F000FF;
	Fri, 25 Sep 2026 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338123;
	bh=JJcQcWXKM91Wp9usBJAs1HzIdDkXwwZD6eVWcZetdn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=USfcKXXqZ8m1CP3pEiRO2fYhjFPCGY3yCbbk2bEPMav/bMcuq4WxBwu4p6VvGYGle
	 HwM+OhYt1JVICL/LrRlzDvhm0Zu9Fyoey8l4uTuGmNA1c3U5XqVLZjhIRbaBDTRv1d
	 pA1sq2Gr8v51lrb1D6uK87AOUxQFclDSfBn2UkSOsiwg/W+Mw5QQyySPSNfbekU4NP
	 VWPr6Xe4PQxpXsRhK8RBCo6JU7ykdNbqgMnQXJ5fvYRF0c4+2VNkUcQdHb5t2X8tBI
	 HzBJt+0BZw8XI2ST6KoNFbxYpOdvGoXJ1AEBiQ/lOHHBOoqjDHzC9+y45or7HvFvDD
	 BrMiQeeEgEN7g==
Date: Fri, 25 Sep 2026 13:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: nix: Log TX scheduler queue
 validation failures
Message-ID: <20260925120838.GI13925@horms.kernel.org>
References: <20260923033500.1752732-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923033500.1752732-1-rkannoth@marvell.com>

On Wed, Sep 23, 2026 at 09:05:00AM +0530, Ratheesh Kannoth wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Emit logs  when is_valid_txschq() rejects a scheduler queue
> mapping so misconfigured TX scheduler allocations are easier to
> diagnose.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v1 -> v2:
> 
>      - Switch dev_err() to dev_err_ratelimited() on PF/VF-driven paths
>      - Add schq and lvl to both rejection messages
>      - Clarify PF/link mismatch wording instead of "Invalid tx link"
>      - Stop logging another function's map_func pcifunc

Reviewed-by: Simon Horman <horms@kernel.org>

