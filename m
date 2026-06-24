Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878C31AF14;
	Wed, 24 Jun 2026 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301281; cv=none; b=pWT5Pm18/3zEj+Y4CczECv5ySmgANfYsF/gWoY2smRHiG+PNCZ5WqPS7W1cLLNuCZkDSvFm/mv96189bD5rfV0b2hNXmtGhGLmLc3sTRw8TQjqTaYvjHB2DV3DFpQCoy7+WqM5xDnJGbVcNnBzil5IJwOhhdYU8ry1RsQO3Glco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301281; c=relaxed/simple;
	bh=EbppwMMx6kcSCLHNbvURyZoQ8qsMQf5wBt3iwmIWxi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNdOT61vi5gqPpYPweJXI3WckTJ77W+ehSMRmGCiw7YvHEbeyyN6W4kMp+2UXhFQobv9mzTkBZeYKQ0BILUg61Qktq2yNa2JB/S8crCKGxxDPaFPjUJYAi2jT8A5I1VD57CE2RTlefazr9fzXMjmpGydhlHGSQT3FY9Bqp/hGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NPYrFECx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NPYrFECx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VxN0qk85a4KaEZ4beGoJZYkJZYlvHUzEO8KiTN9KR7Q=; b=NPYrFECxK0qN509i16ARJvCtmS
	S8ljuzBwE9teLj/LhZoCcPqRdPcNHrJ4WmINhE0+fbrv5rc3dkAnkuYzXXC8APPLfDqhQL9e9b3eQ
	yg9gv4xH/5fDACRk4PwHFcrGNwEPNEw8ESstT+rS078QtedBscv6EXPRde+upDy0yUp4yQU9hAwtm
	roS0SDqPsDQNPUT98W0klduyzv/s8ma9ATz2IeroS/BpFwcfMN8BCNdnQyO8KlJ5RWkI02S9w1+sG
	9w7dv4xePzcNvQPuEWxHH5LdOK/p9X3vdUMHDPctTWP/eSivYXsjO9oleHogAAe5TDGnsYsc+CHN4
	BxXLheMg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcLyZ-002Okr-1f;
	Wed, 24 Jun 2026 11:41:03 +0000
Date: Wed, 24 Jun 2026 04:40:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: madalin.bucur@nxp.com, sean.anderson@linux.dev, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	florinel.iordache@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net v2] fsl/fman: Free init resources on KeyGen failure
 in fman_init()
Message-ID: <ajvBQie3IacYTxCT@gmail.com>
References: <20260624055119.2776641-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624055119.2776641-1-haoxiang_li2024@163.com>
X-Debian-User: leitao

On Wed, Jun 24, 2026 at 01:51:19PM +0800, Haoxiang Li wrote:
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 013273a2de32..3a2a57207e55 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -1995,12 +1995,12 @@ static int fman_init(struct fman *fman)
>  
>  	/* Init KeyGen */
>  	fman->keygen = keygen_init(fman->kg_regs);
> -	if (!fman->keygen)
> +	if (!fman->keygen) {
> +		free_init_resources(fman);

That makes sense, fman_init() is doing the same earlier when "MURAM
alloc for BMI FIFO failed".

For this patch only, please feel free to add Reviewed-by: Breno Leitao <leitao@debian.org>

>  		return -EINVAL;
> +	}
>  
> -	err = enable(fman, cfg);
> -	if (err != 0)
> -		return err;
> +	enable(fman, cfg);

I understand the "while at it", but this should be a separate patch,
and it isn't a fix for 7472f4f281d0 ("fsl/fman: enable FMan Keygen")

Separate this in a different patch, targeting net-next. Also, enable()
might return "void" instead of "int", given it only returns 0.
