Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED41359A87;
	Fri, 27 Mar 2026 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618242; cv=none; b=F0+popTG8jx3aaLI/vvo5hAGsCqK4PuHAtChHsBQyVG5qQQ0doBHcDH6RI5aphXYHKMXTJD8iVVsLJPJ7x/vfhXFKKbLaTTpT9e1UfR7H9hzqAf6F61Gxtlg3uQnWyq6P8Wh80pk8jhVn7XHBiCaLIOQICPLv3CkjigpnWwM27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618242; c=relaxed/simple;
	bh=/fbIKQ2oLGLR49tKqB6Cs4YItShzlhvXJmfOqd4yPjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV8G2z6zev9SiJWb4OE1VDuBbzLRL0EcsbeDH59pl6sUKioeGRJc+13t6zhNjKoW6J3hVLh+UR6Xm8HRqkI+G2R4BpJ8EPkF3cYK5dPOk4v2IZ1aZa9RkB3HCZnGlYZy89c0oD5TSBmuhntQY55wqBd1XuYiowkkR8dtqEyDtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5ABGA6p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5ABGA6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE5EC2BC9E;
	Fri, 27 Mar 2026 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774618241;
	bh=/fbIKQ2oLGLR49tKqB6Cs4YItShzlhvXJmfOqd4yPjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5ABGA6pcjq7NImlKHC2f8GTRNLsDhRFsXnkw4rOHm7SG+A5Q0+YsJm8hcYqimxVV
	 Pz1rhAKSH3A70W4/7BHyQAPThVOD4utxWErzblJhIe2tVMeKqbTQOrtdWNKZkmRb+4
	 3JF8i1DK5NPKw0av819fxGgsZ9LFjGQ8HnoCy+K10dmBFbQsivvqbDWALtaGAM8uHV
	 8mTJUtDJwbYdkdIziZzg9TQ1TV/wkS4yHzmYk3XE3EJqO+HoCH5El0dLiAruNcbddb
	 v7sHfffxa7yvmQaIFoHIPMe+1jd3xPl7gnwkioqZ1PSRwsEsKHE5QEaIob7yOkzDhv
	 3d3u0IxqB8Ysw==
Date: Fri, 27 Mar 2026 13:30:36 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com, dtatulea@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH v8 net-next 6/6] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <20260327133036.GE567789@horms.kernel.org>
References: <20260325072159.1126964-1-rkannoth@marvell.com>
 <20260325072159.1126964-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325072159.1126964-7-rkannoth@marvell.com>

On Wed, Mar 25, 2026 at 12:51:59PM +0530, Ratheesh Kannoth wrote:

...

Thanks for the updates, much appreciated.

I have a few more minor questions.

> +void npc_load_kpu_profile(struct rvu *rvu)
> +{
> +	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
> +	const char *kpu_profile = rvu->kpu_pfl_name;
> +
> +	profile->from_fs = false;
> +
> +	/* If user not specified profile customization */
> +	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))  {
> +		npc_prepare_default_kpu(rvu, profile);
> +		return;
> +	}
> +
> +	/* Order of preceedence for load loading NPC profile (high to low)
> +	 * Firmware binary in filesystem.
> +	 * Firmware database method.
> +	 * Default KPU profile.
> +	 */
> +
> +	/* No support for filesystem KPU loading for cn20k */
> +npc_prepare_default_kpu	if (!is_cn20k(rvu->pdev)) {
> +		if (!npc_load_kpu_profile_from_fs(rvu))

AI review flags that:

npc_load_kpu_profile_from_fs() calls npc_apply_custom_kpu(),
which returns early if the following condition is met.

	if (fw->kpus > profile->kpus)

Does npc_prepare_default_kpu() need to be called before
npc_load_kpu_profile_from_fs() to initialise profile->kpus,
which is 0 by default due to profile being allocated using devm_kzalloc()?

> +			return;
> +	}
> +
> +	/* First prepare default KPU, then we'll customize top entries. */
> +	npc_prepare_default_kpu(rvu, profile);
> +	if (!npc_load_kpu_profile_from_fw(rvu))
> +		return;
>  
> -revert_to_default:
>  	npc_prepare_default_kpu(rvu, profile);

Is this call to npc_prepare_default_kpu() still needed?

>  }
>  
>  static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
>  {
> +	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	int num_pkinds, num_kpus, idx;
>  

...
