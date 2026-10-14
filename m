Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828E52F288
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985001; cv=none; b=tVlAmOFVtPJNoo6pDo5vSTo/mATPAlFKjax2VRH/7lhI/YXczCEr2ml/NW+1PdVufLdPj+2N5qZmJfCD7WcOGtbrTCfMSTKO8SYuZLiIid4HydLuxbyNr+nGjTZT8TqTlwakPgeJfSxu9Mh076TzXeUm8/wSBCUsETGNVWsUB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985001; c=relaxed/simple;
	bh=H3nrvFKjeCvjT+yeX1CIIGlTcALlc0qk89/K4F/6VLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jluguXtO7U3XCCi3mhn6jS0RcUXwZ5FQjh2tGcKbtg392yR7ZE1GGiVaSUJi6f5a6Nl/9JW5eSiE/OnuK51bn3YaUdr2sgQPOG4gvWCgeBZt1I5Of8CusY5kes1wRhdP36SzksJmvbs7DXGkQyoupHrdc0GT3Qvru7bgpTcem30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8euOEfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8euOEfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7601F00893;
	Wed, 14 Oct 2026 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984996;
	bh=pWNA1SXChIvlao7F+7bMmKCCs/ij598G0kF7FwTYryE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z8euOEfIUUoNSdJpCRSxp0L0NXljQFrmAWWtDFIeRUz7/JH88akapfSLYmkq4ZdT5
	 9ReZw3K5q8DtLAM4y9u8JZH6rXA2yjPZXfPIF40qa+4MLaEZRva1eXyEnwkrNoot4f
	 tU5ACvF6qIe55JrY7DMsPwzqYRx1trvTRVI0HvcCQmNplNswf8rITSHgEewJGPtSi+
	 wrSe83YDKtCm48wUp0OPHK4i09qNmoiBBUS720qTNr2+shz5Ls+vqtBB3eOGyy6HWk
	 X3yKS4ac4qlldAspNbNAxWYm4pw1p9/QD4la7aLb9seAdpJwecyTSAd+zw9ZhNg9Z8
	 hWUh5gUa14Wsg==
Message-ID: <cd9e9a7e-c4aa-49ec-915b-ce472e7d7dfb@kernel.org>
Date: Wed, 14 Oct 2026 07:36:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ipv4: Store netns in FIB table
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, horms@kernel.org
References: <20261014082612.1280756-1-idosch@nvidia.com>
 <20261014082612.1280756-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261014082612.1280756-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 2:26 AM, Ido Schimmel wrote:
> The next patch will stop passing the network namespace to
> fib_table_lookup() and instead pass the namespace from the FIB table to
> the fib_table_lookup tracepoint. As a preparation, store the namespace
> in the FIB table when the table is created.
> 
> The FIB table structure grows from 48 bytes to 56 bytes and still fits
> in a single cache line.
> 
> No functional changes intended.
> 
> Assisted-by: LLM
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/ip_fib.h    | 4 +++-
>  net/ipv4/fib_frontend.c | 6 +++---
>  net/ipv4/fib_trie.c     | 6 ++++--
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


