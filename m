Received: from mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAB403AF9
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127116; cv=none; b=qb4CN1l6Y90w2KaeIUgselvvd2isTkDGzwWrNSAvbhuylXSdWL9gsBawduFzXIrqtTLhnxOU71ftv86t4LzM5d685N1d5pLpbH1lUbjKB0ovKukPiI4U10FJb3H4BVJpiCqP2ARy9mFepkDuYfkIruA1y4aRvovinZ9G7Sa3wxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127116; c=relaxed/simple;
	bh=268KSFyhqEwxO0NO1jh/LO+nREm1ybXpbGeuZdoEOFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbvTqA/c7soDuAkIrVE5q1b+y+0l+wh2+cLF86YIbLCr32Uw1I/+9PIlsqR9zQpmGegqamVCOL95MUScuAiLOBI+AMCescw3TqSt/Bf78O872LhFvC8obx8lwpBnacEV58fMdyJHligcXnkKDr+CjBEod5+wo30FutHWqO+1rPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TS8lZ2sW; arc=none smtp.client-ip=95.215.58.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TS8lZ2sW"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=268KSFyhqEwxO0NO1jh/LO+nREm1ybXpbGeuZdoEOFc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787127102; v=1; x=1787731902;
 b=TS8lZ2sWrRF0xUgCIeoCuvm6qUpNjFBzmz9DmyxI7NviDxU66c5+SbM7edd48Sau3/hE1Hvb
 MrhVXneTp3djruz8wQaRVEnKE2c1TOUC2HklAeyFn9gjuwHdvXDEnN6Nh5vodVk0gi1oGbe0OG/
 syyj3XltpVRNh678NEjWtS/w=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (216.236.36.151)
	by smtp.migadu.com with ESMTPS id 3bf05dd37cbb843b;
	Wed, 19 Aug 2026 08:11:42 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 16:11:31 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH] tools: ynl: handle calloc failure in ynl_ntf_parse
Message-ID: <aoVlM1Zr1xsb2TkY@fedora>
References: <20260818132739.469624-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818132739.469624-1-triet.hoang.dev@gmail.com>

Hi Triet,

I think your target tree is net-next, but it's close now. You can repost
the patch with the net-next tag after it's reopened.

https://netdev.bots.linux.dev/net-next.html

Thanks
Hangbin
On Tue, Aug 18, 2026 at 01:27:39PM +0000, Triet Hoang wrote:
> Check the return value of calloc() before dereferencing the allocated
> response structure in ynl_ntf_parse().
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index 2bcd781111d7..af101544c31a 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
> @@ -889,6 +889,9 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
>  		return YNL_PARSE_CB_ERROR;
>  
>  	rsp = calloc(1, info->alloc_sz);
> +	if (!rsp)
> +		return YNL_PARSE_CB_ERROR;
> +
>  	rsp->free = info->free;
>  	yarg.data = rsp->data;
>  	yarg.rsp_policy = info->policy;
> -- 
> 2.53.0
> 
