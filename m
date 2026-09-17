Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0714E06FC
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647809; cv=none; b=Tl2Z5Nh0Wlpec2Gu88UysVAXsSVmVEJ/vDlCc6Bgrp5++Zy3XZf9aOQf+scNsgb4t7DjjtjKFRtOzOxAw7bbNa9WJ7t2R53C29lxkAUw+iiKuXx5GDe6C9UAZJQrqqGDao9ii8y93n6a1qVjy2K5HEAfBVX0c6MVnfJ45An3Ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647809; c=relaxed/simple;
	bh=CzYnD4/L1RVfuLXqN6ozw+eyclzW9L+3QfDsFbnkW30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTKDjXMnz+peh2nW4+bJC+4soER6zjSGXNSwzFCMXgYU9E5bB//ICEEucP4BC3SCJWNwDqVgHzQz1SaTOROEMjAxGK0HRHh6n1GnSEa9fLHKVF5Xhq7UwHilXPRnPcm5L73+3o1YxU/R8VWtpPbGpX32EqbQ2OuavRLnr+9uv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZzZT2Fv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZzZT2Fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15C01F000FF;
	Thu, 17 Sep 2026 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789647799;
	bh=tYAB0NGQjW32ae/3DZyqCt9+zmzMtT8SfyJZ2GXFSJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZzZT2FvP6lR75VK8w9vCpdnfp/cDnlgt2Ze9rGTHcUHyIXMzxZCQRkkyOPHOZ6nq
	 2xioorB1NSCV9590sEXCbkgeVqG+gseVkRWklFOqRwLIw814oKgCnP/0s4lIvZbvVk
	 aXj+4+aJjNno2N2qizWG5QTzUfppl+Tyo9OE8gV3VdchmQgodHu+ptNXe2pPdmdFSH
	 heKJq5Ujxup8JhB/mT+CAqJFYFahiO6Xpzs8VwrrkC73F0xj1+ujjAzFm/UrY89h4s
	 T/Oj6aum8EqcfvCVBVaQLeG2VMlzM7VlthsBPom7P+hfL5U6UdOPk3iMKGmpwQcyE0
	 Y/jXpj7dTNGRg==
Date: Thu, 17 Sep 2026 13:23:13 +0100
From: Simon Horman <horms@kernel.org>
To: alucerop@amd.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, ecree.xilinx@gmail.com,
	Andy Moreton <andy.moreton@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH net-next] sfc: add X4D PF support
Message-ID: <20260917122313.GC51261@horms.kernel.org>
References: <20260916125641.12238-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916125641.12238-1-alucerop@amd.com>

On Wed, Sep 16, 2026 at 01:56:41PM +0100, alucerop@amd.com wrote:
> From: Andy Moreton <andy.moreton@amd.com>
> 
> X4D is an X4 controller instance as an IP block in an SoC.
> It has the same feature set as X4.
> 
> Signed-off-by: Andy Moreton <andy.moreton@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>

