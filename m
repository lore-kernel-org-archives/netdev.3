Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604F3A8741;
	Sat, 19 Sep 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856798; cv=none; b=NzkNCWWh8D3q29DGfRyE6YevL7KuwS1IpRweQ4JitdrnTTgSHZUPRTjae4oqe940WuzWGadi8+xqKs15Q90v0bc8y5fsAX95Bpq8HSbTX7cOUToa8xepu2mqcNoyPOiFAjxWfPBhLkwzzZvkoVe4eVLktrWB5klGhZYnhwUNmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856798; c=relaxed/simple;
	bh=+GPO63A3onnnYrOcegYYpkMhju3s0u48VTJyeTzWP5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbvFe0Q+bse2wgr2nLNtJBj4UbvoS0phwxhBR3eq4lj6q5rkBu6FUXz61TwBCvVdM9CKh/7rMEJvNrqQa1MZRLvtvZMdxpY0Dvv2+a8AFDWC065+kqpWs81ZEVZVFWe57OAsLGk77s45+c7nAh+QkQTadtdG/qnN7ZEfuY87Qbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT4lyqvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT4lyqvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0621F000FF;
	Sat, 19 Sep 2026 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789856796;
	bh=RxueHll6hSlSIZub0q1QVej70GIoMYKy+seKlGtUaZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RT4lyqvIMVH1mApWP2hhwBtjk1KAcQe5sHJspEDtWzA9bKIzGxBu94PtTunJbRWzw
	 3tSxSakV6J/+Gx4M4RpNW8OdzaUfXXOCD78CV9WDBWEK0EkNsrgMovTr0oyuzVddII
	 eUMprI01E/5HPpYpfPF5zvfizha+HI4T8fhcWEy3mym/rhfV0X2JM/8mo9HOOwLGrV
	 lzsF+UTUrLjT9EyDBSPdjf2279yw49QMZN/PbUrrNOQHSI33Aa056R/eIKlkHAKjJm
	 emgcXJvu2VXCyxx+8ZGWvT++/IqDpNMrUi/IiDcx7CIqrz7/0JW6nm7eSdIrn4J4zN
	 DknyUihDfdvsg==
Date: Sat, 19 Sep 2026 15:26:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmr: validate IPv4 header length in reg_vif_xmit() and
 zero iphdr in ipmr_get_route()
Message-ID: <20260919152635.77563149@kernel.org>
In-Reply-To: <20260919221737.3708462-1-benquike@gmail.com>
References: <20260919221737.3708462-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 22:17:37 +0000 Hui Peng wrote:
> Fix two bugs in IPv4 multicast routing:
> 
> 1. In reg_vif_xmit() (net/ipv4/ipmr.c), verify that the skb contains a
>    full IPv4 header with ihl >= 5 before reading ip_hdr(skb) and passing
>    the encapsulated PIM register packet to ipmr_cache_report().
> 2. In ipmr_get_route() and inet_rtm_getroute() (net/ipv4/route.c), zero-
>    initialize the synthetic IPv4 header pushed onto the RTM_GETROUTE
>    probe skb so uninitialized slab bytes in iph->ihl / iph->tos /
>    iph->frag_off do not corrupt fib_multipath_hash() or
>    ipmr_cache_alloc().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Stop sending patches right now..

Please wait for feedback on patches you already sent before posting
_anything_ else.

You are allowed to send _revisions_ (new versions) of patches you
already submitted, but since you violated community guidelines by
dumping 40 patches at once you must not post any new networking
patch for the next two months.

Please *think* before you do things :/
-- 
pv-ban: 2mo
