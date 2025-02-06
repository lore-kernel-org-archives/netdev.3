Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA12417CC
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883076; cv=none; b=PQt67yTkgu4SCwFhtoGVMsYTPJVwwj9L9oD8j5H/mfZLT+5TNESKr4kxR9lcRYtwzZWw+t9qE+3D/QANvKMDffrm4JY3xsxckWYqnJnGNzbl3NYswJsYy8WmeWe9PtU2SrTEHepDczeSdRi8ZNjFkY0nG/CxItOlA10q1nouK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883076; c=relaxed/simple;
	bh=VVBYoficA7Oy1lmhKk3FPmvCLSkCEvDrsPNjGhI1TPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUqxdan1YOPIFJgrWV2U81tdbc/oAHa2viYTOq2Y11dOLlpbQEymkuPPe43u7j2bHBZ9MDM0HAytldmBaFrBXkchnprPwt+OzAf4EREPC9tW9Z6DBjjauEH4zkg3+FQZOtk6AzIKLHGDruC3BzakDh6kia4RIRBWXbmxIMf6ndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJSa1FyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJSa1FyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E86C4CEDD;
	Thu,  6 Feb 2025 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738883075;
	bh=VVBYoficA7Oy1lmhKk3FPmvCLSkCEvDrsPNjGhI1TPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NJSa1FyPQiLXq8M+o2ub6Po6Xt5VVeHAYBLxhD3w6bEvl0CgVZjE761qrhnDAiCLT
	 KUCrlFEFUf7/J941sUTOjt19fGKFjVVPj1o26bC2YeQryrI+mEpO1+fK6cX6/GQuMb
	 GQiIj379giuRWNVyM/TbkQ5rQ+3FEaxgKyx0tF1z2i2Q3N3W7s7v/8zmJii820XST7
	 7ipWC72WUPssirbBelumtwkbFJivBn2n3e0Cs4hWpI5pYk/lTsXMg6cIHTAh9uwi+S
	 KsyyOCcGJ7wJAqm9gVryImKItzx6RscR8SPs+O7fy6ZF5uuWw7EShg3KbSg0zjy0oX
	 SgTuoA3BX2NNg==
Date: Thu, 6 Feb 2025 15:04:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
Message-ID: <20250206150434.4aff906b@kernel.org>
In-Reply-To: <76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
References: <20250205031213.358973-1-kuba@kernel.org>
	<20250205031213.358973-2-kuba@kernel.org>
	<76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 21:44:38 +0200 Tariq Toukan wrote:
> > -	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
> > +	pp.flags = PP_FLAG_DMA_MAP;
> > +	pp.pool_size = MLX4_EN_MAX_RX_SIZE;  
> 
> Pool size is not accurate.
>  From one side, MLX4_EN_MAX_RX_SIZE might be too big compared to the 
> actual size.
> 
> However, more importantly, it can be too small when working with large 
> MTU. This is mutually exclusive with XDP in mlx4.
> 
> Rx ring entries consist of 'frags', each entry needs between 1 to 4 
> (MLX4_EN_MAX_RX_FRAGS) frags. In default MTU, each page shared between 
> two entries.

The pool_size is just the size of the cache, how many unallocated
DMA mapped pages we can keep around before freeing them to system
memory. It has no implications for correctness.
