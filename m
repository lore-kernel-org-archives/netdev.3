Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502911;
	b=Z3oHYHyYQbHOaYqmeNBBLkqhdKsyfVGQx3u6hRC1P9EfHOgutEDRQhDoxhcfsKF1GPht
	 wPApUniOlgJFUsn6AtEONi32nSg90v1z2Cy6GRronrX3QxY2bx8lB+F0gTlovxFgzueuV
	 ZJhH6p+0gn2Cm3vnZGSVEFiuolfZ9AcXIytOGox6azmcGMECbaXRqlghvWyLcttbBJF5V
	 t4LZVXaEYP9HOiVudZksFSH7b7sTnFvDvRbx0QwyCqeMlnBS1whUzYtFDrjj16Kpc/bZM
	 5Vf4I0egSRWfkrwgPCh7HyP2vgEtMJufVjB31UJtMhiNaJgiVIw57jFkJNOFdZHZE8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502911;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=yD4NZqQkZcgC/qMOJAMjYqm5tfju7uAvh2VL+0fWkls=;
	b=cKxwyPTi05jL4dV3Ets5Bn9D8zwKLjMzMSMKBKLShL5m5k7QEbzSIwxHmFFdsOrlQ5ES
	 f+9Lb3mheC3EyjFOg5eU0ckTC5Jz6iUbVnwDCIYKXdh5bmlMtrTl5VmBI/K/CU3GltD9x
	 u3TSMZ3bBlGZBEnQyQ/5CXpaIdgmSsAjCD96YvIu9ztJ1ol4uZLvspMw6601dNt9bZy+s
	 TnsDOyOV46GPwuUR0+7Z6+XjiwHTWJix9Fg+HfPhE8gux67dISAvlAxB4xqtAekO2B66f
	 Uycr7EG7SKQPf621r7UhLICA9pj7ezFM8Y5VrTTRph6e8QSSlbsIyUVggDyIsSAhUfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=JAT7ObAu;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA88606A336
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBA88606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=JAT7ObAu
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4j8Csc4W49zFqsZ;
	Tue, 20 Oct 2026 15:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792502900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD4NZqQkZcgC/qMOJAMjYqm5tfju7uAvh2VL+0fWkls=;
	b=JAT7ObAuUyVUwa3K2SINWVbPN611hvT+mZ/n3RNOipzn8xkG4RB59xwVKqP9slDHKRTYod
	Tx7JQeJs2aZCycG7oSVz6htY4RmkBvYS879MSNbSwhZ9m+7CiEXC3XtE7ytuLn/2mHgrzo
	S1PLG/aW7nJGkdWX1jxwYqSFJRvT+5uA0JLhLw/cWiaBRv/qsZKDInfbC/KfN1go/PlVqp
	C4ss924jy4d1OoswsdJyXQ6OorMmYSSLIzvvWHcoZjmXYSfz6yVL1j2NbSmCEya+HGeske
	adS70A+tXqAGJd5Br7pBfZflFwNgIiSXrGTO4gh8WqeUxZ8kbVLjcyqSfaQt/Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: David Ahern <dsahern@kernel.org>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB changes
Date: Tue, 20 Oct 2026 15:27:51 +0200
Message-ID: <20261020132817.468329-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <76f16ff2-3102-44e9-b4e0-5818044bbc75@kernel.org>
References: <76f16ff2-3102-44e9-b4e0-5818044bbc75@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j8Csc4W49zFqsZ

Hi David,

On Tue, 13 Oct 2026 07:52:29 -0600, David Ahern <dsahern@kernel.org> wrote:
> On 10/8/26 6:33 PM, Antonio Quartulli wrote:
> > You're right that a cached dst can go stale later and that reuse-time
> > validation handles that. This case is different, because it breaks
> > reuse-time validation.
> > 
> > dst_cache_set_ip6() samples the cookie itself:
> > 
> >         dst_cache_per_cpu_dst_set(idst, dst,
> >                                   rt6_get_cookie(dst_rt6_info(dst)));
> > 
> > rt6_get_cookie() only returns a route-tied value when rt->sernum is
> > non-zero, which happens in ip6_rt_pcpu_alloc() and only for nexthop
> > routes. Everything else reads the current node generation:
> > 
> >         *cookie = READ_ONCE(fn->fn_sernum);
>
> Have you tried setting sernum for all dst_entry when they are created?
>

We have considered that, but the existing field cannot simply be
populated for every dst. A nonzero rt6_info->sernum currently selects
global validation: ip6_dst_check and rt6_get_pcpu_route compare it with
rt_genid_ipv6. It is populated only for external nexthop objects, while
ordinary routes leave it zero and validate through their
fib6_node->fn_sernum, as commit 8f34e53b60b3 ("ipv6: Use global sernum
for dst validation with nexthop objects") explains.

If by setting it for every dst you mean assigning the global
rt_genid_ipv6 value, that would fix the race, but it would turn ordinary
IPv6 dst validation from per-node invalidation into namespace-wide
invalidation, similarly to IPv4.

> This deferred reading of fn_sernum seems to be the problem. fib entries
> have sernum set. dst_entries are created from the fib entries and should
> carry the sernum from the fib entry at that moment.
>

Yes, that is precisely the core issue. The candidate node's fn_sernum
must be sampled as part of route selection and preserved together with
the selected dst, rather than recovered from the dst's fib6_node later.

So there seems to be two possible solutions:

1. add a separate lookup-time cookie to rt6_info, while retaining the
   existing sernum as the external nexthop / global validation marker;
2. have cache-producing lookup APIs return the explicit (dst, cookie)
   pair proposed in the RFC.

The former keeps existing cache users unchanged, but the stored cookie
would have to remain immutable, and reusable per-CPU or exception dsts
would need to be replaced when their node serial changes. The latter
keeps provenance per lookup but requires propagating the pair through
cache-producing callers. What would you prefer?

Thanks!

-- 
Ralf Lici
Mandelbit Srl
