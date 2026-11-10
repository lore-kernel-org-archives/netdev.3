Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353371;
	b=X6dP113IyhTsEOwWmrlZJwAAr13J2gWuKdQhoRjBmQc2e6ez9A51F0xnsGQcfrLjCVkV
	 HDC2qFMyJEdp/x1DFlW7UzPNOXOxflZWvA1V0nyxfIHYvhz7z5wjPUq15vwBItOCe5Iuo
	 ARICEKi9886s1g1VMffN3UJkNZB4O5A5A9NwhAaBXa6ktYWW9gwa+wFiq64owUJeS2SP7
	 HgBIdRv9OhK7fBbMCpvFO1iWBGZ15SRjnGHYSsvKX70DtzbqlwqXFuD9R4OcfSVuwW8SS
	 zbMgL3jBny3qgJO732Goo3oTxJUKP9r7JccVQ7J7JERGHMPnnMGyPtdgZBoreoYjJZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353371;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3plFqBhv7mqK/bTMlJqYc1WrC5orRwSPyfBz9QvARiY=;
	b=F2UwKgUG6tcyfldJNirQY94E5tZftTwDHzyFGj5osjM2cuymzUXHyGcp840Fp+xVD4GE
	 Q7GsgBOsN227QqRiqZfqwbSThNQaQEP1p3a3WhJOX6d4DVo8eZl55sz9JseNEp37YUiJl
	 0czaRb8Eyuja9praJBGWwkhDMSLNy/DjWSPMozgggAcC+nF6Zj5pT28g6BcBuB9tQDnlj
	 9Uh2oe9UzTt1Wmu3Ba+LBOvKh6JAczQ5MnoburxPU4p8KykV+rfrdtrhfhyjXPG3SuJpK
	 c2fAF5k39z0jK/p7Xx5ej4kLQrw88M4lJP9ADbcGlBow67JUOogfrQujsO6SzJOL3aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DU+VLoOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34C606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DU+VLoOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F851F0093C;
	Tue, 10 Nov 2026 23:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353370;
	bh=3plFqBhv7mqK/bTMlJqYc1WrC5orRwSPyfBz9QvARiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DU+VLoOF5HwgT7Z7/Jd8EWWGbxwibXwiZYew1ey5TGi9mBPgCAOMFLLk7IZlipWoe
	 tFwja6ZMYnFqdPtwvFNDYyidFdTyTKcnTkxjGU/3zMxXOi3Ptel0aZkYPDAJoRONEG
	 5ssOZcxv9OfYoDM2bIQtaB83//2vndUXQXYHHn+L7VjU/QMsCQ19rRmwAbmroKacET
	 kBywPRMWrw5zYYCKkdFcvp5f6nueBAvsxYxSh96yTbBO3vD1V2m0BGKNKQJVCCssgE
	 ZbPDRtL4SuxbHokYl6zz9Ew/k0SILQp6o7ZHoEaCAqTiY/1enztfXhaBmDNvYyjtkK
	 SBxuMz8o8peJQ==
Date: Tue, 10 Nov 2026 15:29:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Florian Westphal <fw@strlen.de>,
 Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 2/3] ipv6: add ip6_dst_lookup_flow_cookie
Message-ID: <20261110152928.4ef1bf6b@kernel.org>
In-Reply-To: <e40f48e925a0950eac99a3f084e485e82cabe88f.1793806941.git.ralf@mandelbit.com>
References: <cover.1793806941.git.ralf@mandelbit.com>
	<e40f48e925a0950eac99a3f084e485e82cabe88f.1793806941.git.ralf@mandelbit.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 16:53:30 +0100 Ralf Lici wrote:
> +/**
> + *	ip6_dst_lookup_flow_cookie - perform route lookup on flow with ipsec
> + *				     and return the matching dst cookie
> + *	@net: Network namespace to perform lookup in
> + *	@sk: socket which provides route info
> + *	@fl6: flow to lookup
> + *	@final_dst: final destination address for ipsec lookup
> + *	@cookie: where to store the cookie for the returned dst
> + *
> + *	Same as ip6_dst_lookup_flow(), but also returns the cookie describing
> + *	the routing state the dst was obtained from. A caller caching the dst
> + *	should use this cookie when validating it with dst_check(). If the
> + *	IPv6 FIB changed during the lookup, a route dst no longer validates
> + *	with it. An xfrm bundle is validated by xfrm and ignores the cookie.
> + *
> + *	It returns a valid dst pointer on success, or a pointer encoded
> + *	error code.

Warning: net/ipv6/ip6_output.c:1325 No description found for return value of 'ip6_dst_lookup_flow_cookie'

You need to use the appropriate keyword (Return: or Returns:)
-- 
pw-bot: cr
