Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943E46C4BC
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519461; cv=none; b=EO9gRJrJwsTdYlAuXXym+EAxiPDHSVDPkGC2uLPU2ZT6ep/RDqcJ/FM//YjWRQ7nMvOgny03FFLADsn685cB1aMVeC5sWeAltgfmmcLDi6mZSDFwkw2W//BrXMZHIrZi4aCBkjj44rc6BYn0lE1/dRl7i4OdXoc0H4ylyg5aPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519461; c=relaxed/simple;
	bh=dc66qoPDDlG9SBHKVFiQEpj40htkA/nJHS2GngQyEB4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHHmdXF6jAbOevbevZMAYtnrlJyG3QKynhfB8G1mesS/yFrPqvmvub/ZCj9T+HeRBWVP1z0mb3hUvbvAMoFMIAE3fr8DTRWIUU28S/YhqTRVLCpsI46ctf/blEgGa9OqdMjhHAmSwBQE4IzzpSPy8xMa0yvzgeTGihD5eJv4KV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwiS61Lk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwiS61Lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2511F00A3D;
	Fri,  4 Sep 2026 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519460;
	bh=T2qunBAVwN1Yvyan1y08s4fbnUhUJU8deYbGGkPF3Yg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bwiS61LkgY+LCJdrEStdGc0TNTu1DFg/6vNAZp+rHARUVQwQNxitH9VgyfRGteVxB
	 YK7mNVavPw/BjcgVWQaeREApwxjASS2Igh0cckmYwFxjhdIvC56q09KuOpQhau8U9y
	 UOA8DJmeO75aNiCS/ttPma+2LSqbNhjQXHFGvqk6iRRGoazdmqU7vpvp9eXUAiLCdq
	 9iZN0fHeuFP5N0UmM3VqAi5OYOj96I1S2neYDgvTvbeuTtMSfuWYeK0nE1WKIyrOO4
	 we3n1D4zmDg/usm2a9P0jmxBS5mv8LeWMD21njs6+euRqMg7MwgBCSQnaIWRfIm93w
	 16lZGRxtV3tgg==
Subject: Re: [PATCH net v5 2/4] net: ipv6: Fix UDP length overflow with PMTU
 discover and big MTU
From: netdev-bot+sashiko@kernel.org
To: alice.kernel@fastmail.im
Cc: willemdebruijn.kernel@gmail.com, dsahern@kernel.org, idosch@nvidia.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, shuah@kernel.org, hannes@stressinduktion.org,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org, alice@isovalent.com,
 willemb@google.com
Date: Fri, 04 Sep 2026 10:57:39 +0000
Message-ID: <178851945904.4131868.3334753415934417691@kernel.org>
In-Reply-To: <20260901195714.673548-3-alice.kernel@fastmail.im>
References: <20260901195714.673548-3-alice.kernel@fastmail.im>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Claim that the commit message's "Steps to reproduce (included in
  the new selftest)" references a selftest that does not exist in this…

--

net: ipv6: Fix UDP length overflow with PMTU discover and big MTU

The change clamps cork->base.fragsize to IP6_MAX_MTU in ip6_setup_cork() for
UDP sockets, so a device MTU larger than IP6_MAX_MTU combined with
IPV6_PMTUDISC_DO or IPV6_PMTUDISC_PROBE can no longer produce a 16-bit UDP
length overflow. Raw IPv6 sockets are left alone so jumbograms keep working.

Link: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8fc4766c8da90..5509650589915 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1432,6 +1432,8 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>  	if (frag_size && frag_size < mtu)
>  		mtu = frag_size;
>  
> +	if (sk_is_udp(sk))
> +		mtu = min(mtu, IP6_MAX_MTU);
>  	cork->base.fragsize = mtu;
>  	cork->base.gso_size = ipc6->gso_size;
>  	cork->base.tx_flags = 0;

One note on the changelog rather than the code:

> Steps to reproduce (included in the new selftest):

[Severity: Low]
This turned out to be accurate, so no change is needed here; noting it only
because the reference is forward-looking within the series.

This commit only touches net/ipv6/ip6_output.c, so "the new selftest" is not
present in this commit itself.  The test is added by the later patch in the
same series, "selftests: net: Test UDP length overflow with PMTU discover and
big MTU", which creates tools/testing/selftests/net/cork_fragsize.py and adds
it to TEST_PROGS in tools/testing/selftests/net/Makefile:

  +	cork_fragsize.py \

The ipv6 variant of test_udp() there does set up a dummy netdev with an MTU
above IP6_MAX_MTU, sets IPV6_MTU_DISCOVER to IPV6_PMTUDISC_DO, sends 65528
bytes and expects EMSGSIZE, and test_ipv6_jumbo() covers the raw socket
jumbogram case mentioned in the last paragraph of the changelog.

Would it be worth saying "included in a selftest added later in this series"
so that anyone reading or backporting this commit alone knows where to look?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901195714.673548-1-alice.kernel%40fastmail.im
