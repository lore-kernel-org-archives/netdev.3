Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE130569F;
	Thu, 13 Aug 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625338; cv=none; b=iFuPp2strOrahcTSXoGQXi+IdA+mpK32YE6STlpZqe0GEGjYkggd4bqSh8lSeBzR72wIb3+hRW8Zt1Z44XHO2XUFTVBbpJN86Aa6VKWfx72CKEXThdhphBGEUKcDqQ2zIt9WhZuslx0X+8LhHs67Z3QHpS+sNmh63TFgemLVw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625338; c=relaxed/simple;
	bh=1/bPw3W0cpITOAMWwJsZ/TTY/cOu/aksY5Eu79SxH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFyU1v1pyb4BGmOTjc5jjUuEAlj/0JATLSvL+C86Qae+/9Jl8tQnonL3J8zBaqsMSycCTkfKfUh8J7rLhA0cvOgCtecH0fCly7mjBwZqCcOpnKHbzwCSMtS7cnpq5JwSZYDcOvR4UuOk73A+nZhpptbwuiQmoNfXRYMxVFtB03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxYAsBQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxYAsBQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471931F000E9;
	Thu, 13 Aug 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786625336;
	bh=XyfRPEPlqeXNRCr9zPbmFcASiinf6awaGaFpaTojyyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SxYAsBQi8YFfTMjareRgIQmm5u7JA3S4q4/HpP19hbiK08fiX1TMOD7fo4JGuBBzn
	 4WW868kvhqkFDiFz3D3T2Zoiut7BF2oMYBqzNTdsg7WqyoyEJaTAM03fEMhEabjgwZ
	 cy//esWaQQtHMnDffrhJCGvSlxLz870wq0WN4VTFJEFETM4tCdB05VvfBVRXEK8BP0
	 VOiBGZc8OvRfNONIvNWIUUm/fmAMkkfk/MMVxkVK4WjeKSrUEv6sjrrAbbCYKjFCP8
	 46U5KxJBwqw7KLeCOZzD3mvL4B1PePLhelWb7N1o71LSmjpl7xa7h/Ne4cfgUopl22
	 FNb8ZpkHmcZkg==
Date: Thu, 13 Aug 2026 13:48:50 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Teng Peisen <tengpeisen@huawei.com>, Wu Di <wudi234@huawei.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Chen Anwen <chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>,
	Zhang Min <zhangmin548@huawei.com>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>,
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>
Subject: Re: [PATCH net v04] hinic3: Fix skb linearization mismatch and drop
 skb when skb_checksum_help() failed
Message-ID: <20260813124850.GD196815@horms.kernel.org>
References: <78d8c61cab588240948eaddcb437d59add9f77ae.1786448013.git.tengpeisen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d8c61cab588240948eaddcb437d59add9f77ae.1786448013.git.tengpeisen@huawei.com>

On Tue, Aug 11, 2026 at 07:43:59PM +0800, Fan Gong wrote:
> Previously, hinic3_send_one_skb() cached the skb fragment count before
> calling hinic3_tx_offload(). If hinic3_tx_csum() falls back to
> skb_checksum_help() for unsupported tunnel packets, the skb may be
> linearized. Continuing to build the TX descriptor with the stale
> fragment count leads to a descriptor mismatch, which can trigger
> out-of-bounds DMA reads or IOMMU faults.
> 
> Furthermore, the old code ignored the return value of skb_checksum_help(),
> transmitting corrupted packets with incomplete checksums upon failure.
> 
> Fix this by:
> 1. Moving the hinic3_tx_offload() call before calculating 'num_sge' to
>    ensure the correct fragment count is used if the SKB is linearized.
> 2. Propagating skb_checksum_help() errors and returning
>    HINIC3_TX_OFFLOAD_INVALID to properly drop the skb.
> 
> Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

Thanks,

I do think this change is fine as it addresses the issue described.

Reviewed-by: Simon Horman <horms@kernel.org>

But you may want to consider some follow-up based on the AI-generated
review of v1 that was forwarded by Jakub:

https://lore.kernel.org/netdev/20260806162138.2749871-1-kuba@kernel.org/

...
