Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6B1917FB
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781394503; cv=none; b=qUZvQ9tI8PK33lGfmV9sFPwdtkerq3DRYDm6yVC8oKqABMOewKvl7M9f/MhKGrUCXLcwSKTBvH+qmBHizhIF+j1PW+pRKjXcu+9tDxtyv/cgenSE1GvKLw+0gq9QgayyWQH1xsHL88MJDGYzSf+adOuJsmquuswK1gjOd+AL7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781394503; c=relaxed/simple;
	bh=Oi56VmWhC7PoTC+233Fedx2dmPJcN1ZeBOwypeKtA/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/ryh8BqcKj7wV2HCw/GBYg3suRjRWAhzmR/qNMZNuOUJgKxul3fzTVs5LUR3NFwfNb6/BR+8lBXOgwrhCrVQUMi+gRPozYNe3tMjEvSPRy97R4zpKVxTE77kLqkchpsQRZQvJWopHh/sfOYNF/s6wGrG873aQBW8eoNRyCa+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHUMTJp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHUMTJp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB61F000E9;
	Sat, 13 Jun 2026 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781394501;
	bh=oA+5Fp0zS7dd7lJyhRmLUPe3Ae1RmQaiJfK3BW8Xdoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FHUMTJp3a5oHvl47Hr2pvjFGWBOugF78BUfab+qZOqz+QXVWKmKMIsu64ZGLAPVo7
	 FNha7jaM2vioxKb0p4+RzMSeSlNZw7iJpzbL1fu6kX6wADFDjPcn+LbqmWGWZ2Z7LK
	 pJeA7vtUb1QMLU5Se9Nflhf18BvrVca75PDNEGxRYqbNPCnQQrmkyxxk4tu/SaZ5ZG
	 3vg15SoFBVz60JRm/Uh64Kn/xyOHO/2db8MAE1d6eZsk5u+wRP+EcWrWfaHvhhE569
	 LVEk90Ijdtrj0EKD7wG4mH8Agus/iGp1Q4tq/0xgYg/5hnUqmzS6SoL8NZVsA4vqNZ
	 pb4ZGnXSrIWHg==
Date: Sat, 13 Jun 2026 16:48:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bestswngs@gmail.com
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in
 PSAMPLE_ATTR_DATA
Message-ID: <20260613164820.491226a7@kernel.org>
In-Reply-To: <ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
References: <20260607031640.2743713-1-xmei5@asu.edu>
	<20260609183018.1764046d@kernel.org>
	<ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 16:33:44 -0700 Xiang Mei wrote:
> That looks better. I just found that nla_reserve can memset for us:
> 
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 7763662036fb..c112e1f0ccac 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -476,12 +476,11 @@ void psample_sample_packet(struct psample_group *group,
>  		goto error;
> 
>  	if (data_len) {
> -		int nla_len = nla_total_size(data_len);
>  		struct nlattr *nla;
> 
> -		nla = skb_put(nl_skb, nla_len);
> -		nla->nla_type = PSAMPLE_ATTR_DATA;
> -		nla->nla_len = nla_attr_size(data_len);
> +		nla = nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_len);
> +		if (!nla)
> +			goto error;
> 
>  		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
>  			goto error;
> 
> Let me know if the new patch makes sense.

I assumed the author intentionally was avoiding the memset for 
the memory we will override with data. Otherwise the whole dance 
could be avoided and nla_put() would have been the answer.
