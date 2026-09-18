Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BB3822AB
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763262; cv=none; b=OqXHkEUAaefFTdEqhzc3P7INYrYvsmvkC+BRB8qU92qD5CHtM3f+YXzPVYOeSH06dMNUxTmR5PKyAk0/Zd9Ih9LfdvnEEPYa35ojbq8JbmCbF5+F45RUgx4ZEkDmpOrfCKaynzT4NJrH8F1Q0bEzcGFUu278R+exxQQLs41ZOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763262; c=relaxed/simple;
	bh=9ZP4qUtGrA5wcV12vFN3xrWPZ/+jBofHH+reMFstS90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH+B0gxebKwGau9iHxFJfK9jA0sSYqX5WorWVWugbpLhdSXZGjpLZUHNTcIEkQv0MSTLewIM/Esr54yCifNfdtPpDP4LoffNldJYxc7DGBG7ZrYuCkaa7JMXwTdpwiW235Mic2d8R5eMcxuM8GWdXn38nYZXvkhSh/sLJJjS0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=DE9Le/WK; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="DE9Le/WK"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hmkgz70fJz5wgx;
	Fri, 18 Sep 2026 22:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1789763248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xNpb/4mA+bU2vUcIwGkf37qoxfPsYMbcbPE9au6TeM=;
	b=DE9Le/WKQKO7TfdzWKg25/y7aFarbsk6f2qx+Fp6wo4j0PdrM7w0fZ6nK0xTH87FcsT2hT
	i+dwFgp+pjwwPAINzViO+OSWhELeVZ9Db7wOUxtkbAftBn9m4bz+/AJ31Dig3Y6+cLJIEJ
	NGecuOH5W0W2v+MP0d0Ei1oNH5eDbOKOLRp77MYNB0ebDADyrdzwF7cBHDsHk7Axkgr73j
	4CrK2NE9RKXKEucGc1Oi3mIzRHUzd+EYuVlA93TZqN51fzJEVbYzWQc8O0ads/raO67Eg3
	sDOw0ycFQXFlreKtrVObB1d8jpR29poGlVMruVnAQyBJqFtrmHCwqaoMG5IXOw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB changes
Date: Fri, 18 Sep 2026 22:27:18 +0200
Message-ID: <20260918202718.36933-1-ralf@mandelbit.com>
In-Reply-To: <b6a3076f-7459-4c24-a7f2-fe5c6c88b9d1@kernel.org>
References: <b6a3076f-7459-4c24-a7f2-fe5c6c88b9d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hmkgz70fJz5wgx

On Fri, 18 Sep 2026 12:42:40 -0600, David Ahern <dsahern@kernel.org> wrote:
> On 9/18/26 12:51 AM, Ralf Lici wrote:
> > On Thu, 17 Sep 2026 13:09:10 -0600, David Ahern <dsahern@kernel.org> wrote:
> >> On 9/17/26 4:09 AM, Ralf Lici wrote:
> >>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> >>> index 7f69e8890b5b..a28974cc36e8 100644
> >>> --- a/drivers/net/ovpn/udp.c
> >>> +++ b/drivers/net/ovpn/udp.c
> >>> @@ -250,7 +252,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
> >>>  		dst_cache_reset(cache);
> >>>  	}
> >>>  
> >>> -	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
> >>> +	gen0 = rt_genid_ipv6(net);
> >>
> >> this detail about routes should not be buried here. rt_genid_ipv6 really
> >> should be local to net/ipv6/route.c
> >>
> >>
> > 
> > I agree. Keeping this detail inside the IPv6 routing code is exactly why
> > I sent the RFC linked from the cover letter, and I would appreciate your
> > thoughts on the proposed approach:
> > 
> > https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/
> > 
> > The pattern of obtaining a dst and only later sampling its validation
> > cookie when publishing it into a persistent cache is widespread in both
> > drivers and the networking core. It is racy for IPv6 routes with
> > rt6_info::sernum == 0, because rt6_get_cookie then reads the current
> > fib6_node::fn_sernum, not necessarily the value corresponding to the
> > lookup which returned that dst.
> > 
>
> the patch is focused on detecting a genid change at the time the dst is
> cached. Why? It can just as easily change immediately after the double
> genid check, so you are not really solving the problem.
>
> Staleness is irrelevant until it is used again (ie, genid can change
> many times between dst_cache_set and next use). That is the proper time
> to recheck the genid and refresh the dst as needed.
>

The double generation check is not intended to guarantee that the dst
cannot become stale after the final read. Its purpose is to ensure that
a pre-change dst is not cached with a post-change cookie. And that is
enough because dst_cache_get_ip6, on the next run, misses the cache if
it's no longer valid.

For example, suppose the lookup returns D0 under cookie C0. If a
relevant FIB change to C1 happens after the final generation read (even
if it happens before dst_cache_set_ip6_cookie) the cache stores (D0, C0).
On the next use, dst_cache_get_ip6 invokes the ipv6 dst check, which
compares the cached C0 with the node's current C1 and rejects the entry.

The problematic sequence is instead:

lookup returns D0 under C0
FIB changes to C1
dst_cache_set_ip6 samples C1 from D0's fib6 node
cache stores (D0, C1)

The reuse-time check then compares the cached C1 with the current C1 and
accepts D0, potentially until another relevant FIB change. The patch
ensures that the saved cookie is either coherent with the lookup or
conservatively old, so the existing check at reuse remains meaningful.

-- 
Ralf Lici
Mandelbit Srl
