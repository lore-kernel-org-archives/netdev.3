Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5A364057
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246612; cv=none; b=PjQZqHryFFxSM3P5JIxd6i/K6iXTvBuAp0zVgTaMmK4clyzqZ8OnAwNMkvk0bhX8J+pr0cVYgd0YoEANGAifRl+uixvN+B3AscKo7K3LMWEK24S99873s43eifgq5fn9PJ1lTbXgDFVQqsQWfxL+hbruwmYNCBLy4o64i42wcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246612; c=relaxed/simple;
	bh=neZf3rmVMCyL11uVZy0dICIV7dj2H+spS0zTQvfR3fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHjNNPfrLb4TO/o/pud1uEXuxODdZKVLYAsU1QiGiev2extr7tdCrIjQEscGr7YBQSpaoGGnT44RQXjnjtzXT81yBJOC3prHDByNyQ9hExhXWHDB5S7IJv6irvXnr02hrnRNOnXLqPNjTNv2KTThO+aOKJGitZsUJlW2ThfNFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTTbqQpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTTbqQpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160991F000FF;
	Sat, 12 Sep 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246611;
	bh=kCWhpUsiPFqRlgahWtUJqCFId4r+fMO+0EYZhkKzZvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oTTbqQpvsHOjj0t7UZ6qJT3g55FX6AAUWEFZ9U1BJhdLCvCu54vZlSh6JNQsYpkCq
	 8QhwByPh82qeM+yiW3HrAyGPRu8pM2W4TxSVHUsL8gQjxEBTEPED5kKn/7RXkVFMzQ
	 uNQ9ZWwrRf1wTGk60xWLAEh+7u8xgkpeX46jNjgajbygqqq29cjjHPGL1GE8RsJlSB
	 kyssN0xdKsMMLlDo+kssWp3nFwtjqg5eEqIgeXkqkHPAcQJhjzjQALigk9bGffgquZ
	 +6bBFQD52syeo6kPtw9Rw+lvbQ7+fdatuDz1OEvNvnF4M/JSI6u1kjwsjuSbaWyF0c
	 tEDxPizezXAqw==
Message-ID: <cd7e9145-20f4-43f7-9c18-c323b9d13a9e@kernel.org>
Date: Sat, 12 Sep 2026 14:56:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iprule: warn about host bits in IPv4 rule
 prefixes
Content-Language: en-US
To: Zhixing Chen <running910@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20260904033138.10620-1-running910@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260904033138.10620-1-running910@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/ip/iprule.c b/ip/iprule.c
> index b56b1b18..d358cfdf 100644
> --- a/ip/iprule.c
> +++ b/ip/iprule.c
> @@ -276,6 +276,18 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
>  	return true;
>  }
>  
> +static bool inet_prefix_host_bits_set(const inet_prefix *p)
> +{
> +	__u32 mask;
> +
> +	if (p->family != AF_INET || p->bitlen < 0 || p->bitlen >= 32)
> +		return false;
> +
> +	mask = p->bitlen ? htonl(0xffffffff << (32 - p->bitlen)) : 0;
> +
> +	return p->data[0] & ~mask;

detects more than just host entries in the mask, no? 10.1.0.0/8 would
also throw a warning mesage, but that is not a host address
