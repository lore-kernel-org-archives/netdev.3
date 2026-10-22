Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648800;
	b=JXtYlePdc6yKjdIKf9HXvbv25gc0a8zGLilhsWeuvImrEAsB0BFT9k3Q9JGvsaL3aFS9
	 IPL8ubMUeCIlPQJhwmnMt2zBhl7tBFSeL76QN0jBklQaONXj+5mfTa5esxiYZTrXiBj1T
	 UOydPDu2dCWYyTa7gh/bl8/VUBQ6BHk5YeC2bpQDfbWFdn64sGCagKgJmW8WOygouMrgT
	 KOIrqmE8h4jARLzBCGM+dO8VmMbhNbGnwBdUprVfmZvV8Xy7a7TODBG5ULKV9yksGySUh
	 sRnoLi82ElPjZS5TVYOVLDcvZXYOVfZVyvzZiymVyMixOszKYMueteA7afagmQIFI5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648800;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fIYrm7yyO053Wq4oC47ELZ+0yKxy2k7LASYVZFoQqEo=;
	b=Qm6dOKTsTvUL+D9YS4JxvIOuY/OtwM4n9ZvJLq9mUWzam+t/Sch2GAnkDxmvooHPgtDf
	 Z5nGnhyNxFkHC+CV7uP93v81Sw3eYDNq7MKAvgMIfLrXC0EZqacgFMLtNtT8q/lKKoNCU
	 sGLY0EDCCFIumOLGaV3i4kZXAXK+8AyFYD+HnCy03oU2AsE1ZddvP7UHSZlYOZEl/bf/9
	 oNfDNX1UD3TAybfyJL/co/JbhPT+TuQzhnGO+059MqxIqaq1TSLmnnwTVZQ8qyYPPeEV4
	 QRIP/eRk3DkFiRyCoRfLruxuEpN21KRN0UZWldTBu+BTr0JNTJcqmr06EZkLW0W8zuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pp2rajOZ;
	arc=none smtp.remote-ip=91.218.175.63
Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF7606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CAF7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pp2rajOZ
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3/3qEHo3NcT3tbB1SW5QCfRuQZuQpW8oQBAxm/9MJKw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792648797; v=1; x=1793253597;
 b=Pp2rajOZCLeruQH4lUdhCj8/VrhDvtVawgDKltYN/WfBNIYr2BRyhN7ORtui83q2AGdnYwTY
 JCCKB5ZOGdboP36eOF06L2VtatmcywZN9Hh9R36mccgkjXqlxqvcx/pnmDHIubKy3OIffp5BeY7
 1GOF90mfM7AJqZv56n8AQFfA=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 422a1f02f778a91c;
	Thu, 22 Oct 2026 05:59:57 +0000
X-Mizu-Trace-ID: 422a1f02f778a91c
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 13:59:50 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Tianyi Chen <hi@tychen.cc>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: igmp: report interface group allocation
 failure on join
Message-ID: <atmmVvSN1SEvsjzf@fedora>
References: <179260356668.911829.6576504063198285556@tychen.cc>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179260356668.911829.6576504063198285556@tychen.cc>

Hi Tianyi,
On Thu, Oct 22, 2026 at 02:23:59AM +0900, Tianyi Chen wrote:
> setsockopt(IP_ADD_MEMBERSHIP) can return 0 while the group was never
> joined on the interface.  __ip_mc_join_group() publishes the socket-side
> ip_mc_socklist in inet->mc_list before calling ____ip_mc_inc_group().
> That helper returns void, so when its kzalloc_obj() fails it returns
> without creating the interface-side ip_mc_list and the syscall still
> reports success.  The socket then passes IP_MSFILTER but cannot receive
> the group's traffic: no IGMP report is generated, the group is absent
> from /proc/net/igmp, and the receive path drops the datagrams.  Closing
> the socket also decrements the interface group for every published
> ip_mc_socklist, so it can remove a group that another socket joined.
> 
> Make the helper return -ENOBUFS on allocation failure, call it before
> publishing iml, and free iml on failure.  The object is charged with
> sock_kmalloc(), so sock_kfree_s() with the same size keeps
> sk_omem_alloc balanced; it was never published and has no source list
> yet, so no RCU free is needed.  Successful joins still publish the fully
> initialized socket-side record after the interface group exists.  RTNL
> serializes the writers, not the RCU readers; this ordering prevents a
> published socket membership without a device group.
> 
> The legacy void wrapper keeps its best-effort behaviour: interface-up,
> init, bridge and tunnel callers cannot report an allocation failure.  A
> query does not recreate a missing group; only a later successful
> inc_group call can.  The silent failure predates the 2019 helper split
> (9fb20801dab4); there is no recent regression to tag with Fixes.

I think the fix could be Linux-2.6.12-rc2.

> 
> Reproduced with fail-nth on v6.19 and v7.3-rc2.  N=2 fails the helper's

Is there any details about the reproducer?

> kzalloc_obj(): the original returns 0 with no interface group and 0/4
> multicast datagrams delivered; this change returns -ENOBUFS, leaves no
> socket or interface state, and a later join delivers 2/2.  On the
> original, closing the half-joined socket also removes a second socket's
> group; the patched kernel keeps it.  Normal joins, the existing-group
> users++ path and source-specific joins (allowed 2/2, filtered 0/2) are
> unchanged.
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
>  net/ipv4/igmp.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index d56355aca797..81a100330630 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1566,9 +1566,15 @@ static void inet_ifmcaddr_notify(struct net_device *dev,
>  
>  /*
>   *	A socket has joined a multicast group on device dev.
> + *
> + *	Returns 0 if the interface now has a reference to the group, or
> + *	-ENOBUFS if the new group could not be allocated.  Callers that can
> + *	report an error to userspace must check it: a socket that reports a
> + *	successful join while the interface has no group cannot receive the
> + *	group's traffic.
>   */
> -static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
> -				unsigned int mode, gfp_t gfp)
> +static int ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
> +			       unsigned int mode, gfp_t gfp)
>  {
>  	struct ip_mc_list __rcu **mc_hash;
>  	struct ip_mc_list *im;
> @@ -1595,12 +1601,12 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
>  	if  (im) {
>  		WRITE_ONCE(im->users, im->users + 1);
>  		ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
> -		goto out;
> +		return 0;
>  	}
>  
>  	im = kzalloc_obj(*im, gfp);
>  	if (!im)
> -		goto out;
> +		return -ENOBUFS;
>  
>  	WRITE_ONCE(im->users, 1);
>  	im->interface = in_dev;
> @@ -1630,13 +1636,18 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
>  	inet_ifmcaddr_notify(in_dev->dev, im, RTM_NEWMULTICAST);
>  	if (!in_dev->dead)
>  		ip_rt_multicast_event(in_dev);
> -out:
> -	return;
> +	return 0;
>  }
>  
>  void __ip_mc_inc_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
>  {
> -	____ip_mc_inc_group(in_dev, addr, MCAST_EXCLUDE, gfp);
> +	/*
> +	 * Legacy void interface: interface-up, init, bridge and tunnel
> +	 * callers cannot report an allocation failure.  Keep the best-effort
> +	 * behaviour.  A query does not recreate a missing group; only a later
> +	 * successful inc_group call can.
> +	 */
> +	(void)____ip_mc_inc_group(in_dev, addr, MCAST_EXCLUDE, gfp);
>  }
>  EXPORT_SYMBOL(__ip_mc_inc_group);
>  
> @@ -2386,11 +2397,19 @@ static int __ip_mc_join_group(struct sock *sk, struct ip_mreqn *imr,
>  		goto done;
>  
>  	memcpy(&iml->multi, imr, sizeof(*imr));
> -	iml->next_rcu = inet->mc_list;
>  	iml->sflist = NULL;
>  	iml->sfmode = mode;
> +	/*
> +	 * Make the interface group exist before publishing the socket's
> +	 * membership: success must mean the group can actually receive.
> +	 */
> +	err = ____ip_mc_inc_group(in_dev, addr, mode, GFP_KERNEL);
> +	if (err) {
> +		sock_kfree_s(sk, iml, sizeof(*iml));
> +		goto done;
> +	}
> +	iml->next_rcu = inet->mc_list;
>  	rcu_assign_pointer(inet->mc_list, iml);
> -	____ip_mc_inc_group(in_dev, addr, mode, GFP_KERNEL);
>  	err = 0;
>  done:
>  	return err;
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157
> -- 
> 2.56.0
> 

BTW, I feel there are too many comments generated by the LLM.
I wonder if others share the same feeling.

Thanks
Hangbin
