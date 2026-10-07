Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FC4B0E4F
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384307; cv=none; b=bq2aQBGQjPZdardzm9bVqW92vg2dKFxW42yVz/LZReo+JlUZD9EcNXnpLMDjMp/dvksLzxraa7LM1bN/u4rrFL1Yr8iPkO6yKwG/jeeMmgmsYf7o09r3w1KHXcyOkTz49T72A7QgT1G6kE0KHmosyHPc2dFHUnyr+ZqCxG4zsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384307; c=relaxed/simple;
	bh=AQ/pDPclU9/jeIzOl4pRkIlWvPm1kWMJROtIWZYRWrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCw3ipohcAti7btBta+7XQkVxN8n3GelTnYJOP9r/PwhpaSxcj6yMZBaKz1QRDHfTTo9BpwAdQ5j02GghN+E8MU1U/wLSkEutUWsSpoohnhB12SNlwCSlCK2ZNt6YOkdp+7tMmRz0kXSAoneaNSfADZG91JL7wsd3Xibphb0uuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw8r21WO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw8r21WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B1C1F00893;
	Wed,  7 Oct 2026 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791384302;
	bh=91YXatkKJZSocTKz1DuLomd1UG0dUWVMqHWVRiw6QOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pw8r21WOzDI18dkmzp01IrOKemWC0w9pcjMsh0/yAhetpO3Tw1CnStmRx2FzwCLhc
	 bFLnpAcBZnVwLLgU7VzF3sinhNfRnrBgWoq4LsAS3+LIEHaLHXBuGNw+F0vYeBCq/s
	 GOr+COz7zCjY3oMSapQ03bv5r3/7xNNGc+vZ8T3iCgORFz2r5KFoe0e2/BCvDGZwNE
	 seFoJEIUw+FBx+v9fUZn3LhqfrRo4ADYT9/bS+7XyzdHL0TblIf5En/l/xtcSSI8GM
	 5gpfhqOtmzHlwenD2XDUep3+ChM/FQo6ij2iY3bn/DiPL+dcdkqTGbc2+OQYCWnft6
	 1k1p5l/AsUIiA==
Date: Wed, 7 Oct 2026 15:44:59 +0100
From: Simon Horman <horms@kernel.org>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	Alejandro Lucero <alejandro.lucero-palau@amd.com>,
	Changyul Lee <lcy8047@gmail.com>
Subject: Re: [PATCH net] sfc: handle rhashtable walk errors in mport lookup
Message-ID: <20261007144459.GS83879@horms.kernel.org>
References: <20261003.final089.e0910b3ffb849fe4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003.final089.e0910b3ffb849fe4@gmail.com>

On Fri, Oct 02, 2026 at 07:47:40PM +0000, Sang-Hoon Choi wrote:
> rhashtable_walk_next() can return ERR_PTR(-EAGAIN) when the table is
> resized. efx_mae_lookup_mport() currently dereferences that value as an
> mport descriptor.
> 
> Skip error values and continue the walk, as the other rhashtable walkers
> in this driver already do.
> 
> Fixes: 5227adff37af ("sfc: add mport lookup based on driver's mport data")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> ---
> Compile-tested the affected object with x86_64 allmodconfig
> and W=1 (GCC 13.3.0). Base: mainline 3b7cab693ba2bab63774bf5b988e8a61b2ef0f32.
> No hardware testing or runtime failure reproduction was performed.

Reviewed-by: Simon Horman <horms@kernel.org>

