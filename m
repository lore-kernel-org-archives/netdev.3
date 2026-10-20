Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528384;
	b=TiAQqkGzTZkz0UxIC5vwQk0RhJ4Zon4IzJjgW215vDKSmU0eZBDB5s3HWnUPg24Yg1gE
	 DDzTNbhOCF7h1ovca5V8Pn0mPKrXgMWdUvxukc/n/u9oa5d7BEFGVqiCa9bDAwGGtzwVw
	 FVNawJCEBo1WooKBKXxbt1iRgxG03O1tNGpQXf/fxPzBK07yoV2QZZ5RUcl+cwwJc+iW+
	 n5ZX6qy/k+Feug43RKqEqcYQZJTvOa8FXOolBrjnvUJFeg1DPvsCiMNJn2a2I/CnL8iUR
	 HpcYribFK3H8bTRYVPpq6zYglX9roqmL5EurRy6e8PzDrp9JanPdX01NJG/IVwoYHmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528384;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HokUeG8K61PqpdYWUVTP/w5f2xfNpsSk7jsIIuyA5pA=;
	b=LZqjhF18QyzpCMnCRaVk9KUqaBLMUDwb6+2qbmAwt2m2w3hKpGJMRuzfSjuTY9LkEx/P
	 1pCeOoge/qef4FTUk0pxtNQMWwrGAZIUXowR5kMlRls0LZmyTIzlrz6IcXcmdDaJWKMEL
	 Z60XHDB/PfznJXJV/XFUv1Vt2bthGnv5VUtj7zi5KHJj/MxCg4MZd6bmchmPwi+RpnrXw
	 4eeJQG7HtP8ZinYOqe8CHEo9dfZlucu12khpDI03++j3W9CRNLbZmXl0gwiy5L1BMfUV7
	 yI+AHATOBnMpCoMvsKYsjU8Bl+5oXf4VyOJHCCo+RHOcWdksT3kyKn+Hz2hgAcTOQOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6m3j63p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61011606A321
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6m3j63p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A086B1F000CA;
	Tue, 20 Oct 2026 20:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528384;
	bh=HokUeG8K61PqpdYWUVTP/w5f2xfNpsSk7jsIIuyA5pA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T6m3j63poNq10qY8QWwhrf+ACKb/kLHteqgU8jHz90x+M/DIq+2SsU1fETzIKgLil
	 Ntvkw74FrmppLTvy8K5tZmKcpzu8wqYTZZfWOOZRkr+LAU5qQkrpKTCD/BCNqtG34V
	 2yZMVhEKQyfDJNKvl1fVfy9dB0u3kzDXiudaLLM8L3+trWy/gjkW1fnzZUrOzzY/QT
	 b4OxvN/1G62866S5WiB6Q3kSVWlLUIAcOSRFJZbtM+lonyf4saEDect3umI3F3xMCo
	 zOdxgBoRaFPi1Nyd//9tC2NqkyHoDr/ORUl8WI1aJd57ZSLHUecAKQOEcAGJcpIsPw
	 tdrVwipwW+USA==
Message-ID: <f2bcccb4-0790-48bd-a292-fecba10e85ec@kernel.org>
Date: Tue, 20 Oct 2026 14:33:03 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: netdevsim: Add FIB notification tests
 for nexthop objects
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 petrm@nvidia.com
References: <20261019140337.2886875-1-idosch@nvidia.com>
 <20261019140337.2886875-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261019140337.2886875-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 8:03 AM, Ido Schimmel wrote:
> Add IPv4 and IPv6 test cases that program a route that uses a nexthop
> object and check that two notifications are emitted for it, with the
> second one carrying the RTM_F_TRAP flag.
> 
> The new route_nexthop_check() helper follows the same pattern as the
> existing route_{addition,deletion,replacement}_check() helpers.
> 
> Without "ipv6: Hold RCU when emitting route hardware flags
> notification", the IPv6 test case passes, but triggers suspicious RCU
> usage splats. The IPv4 test case is added for completeness.
> 
> Assisted-by: LLM
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  .../net/netdevsim/fib_notifications.sh        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>

