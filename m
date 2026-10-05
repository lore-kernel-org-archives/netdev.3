Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BCF4DA9A0;
	Mon,  5 Oct 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225604; cv=none; b=FcgvNNX5GjQ5rcyaF8sGp+FV+UFmWohy/whaoYQbn2ePp93ag2B+EGXOU50uQwBhc5rXKAYwqHfKnW0Wcv5+GkTRPX8QJANFIT2kbbH6MvtgVYlyvujgilMrjQhOx+5VJ32dEIueTVcehosx0hVhe772pA1KACWebdsQfPrsMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225604; c=relaxed/simple;
	bh=kYrojStYa9f2rkzVS/+86vqhqOx0RVVx0KJzaPqITa8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUYoVqPSJrJa1nh/4dWwx3RcYTdTH3gTchPnmVPgEQ7oMSkHNrZxbrpVggfMo0PDKy6DHBZe8QX1Y6Aw/5TfG8u2mVuBeg/HAHP/MoALhEfk+PPguA0Z3qAqO+G1bk2k2cE3c+YWhKz7oKod2gpk61G8+MtsofnZjwe/Vrdo1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4adeSDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4adeSDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACAF1F000FF;
	Mon,  5 Oct 2026 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791225600;
	bh=EyJBhpnt+a00Z6n4RfwT1Ttm6wadK+l2MLfsyB5eVlE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V4adeSDiis4Tu3mLwOrA4li1WNPNYoKuTp3nBZss3a1FwwsUcAo1AGl3Z0XwuWZfz
	 CIIfcTL7MdxfXWSSzMnMZu29toQ/vvwEjSDdoUq/+C4Swgy82eeDwC7xdWiMh6lg7r
	 DDYx+90xv18geUveeDvYvS6+v73i6xEIjosU+RCVhTxT0aqrBHF3mZfinRrKEqigOo
	 bJLgpWmf2MR+rMRnbttWCLEkE9587+eoefTF3SqyPA5UIBmC29lLgPXXViHyyPKkLd
	 HUs6CIpz0Ng6gkxzejpV66YgyIuEpsHyNapA6yRVVKLIbkyLpf0q0xOUaCRvRFiqr7
	 ZMsu/MGMKepNQ==
Subject: Re: [PATCH net v2 1/2] ipv6: serialize address publication with
 device teardown
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 18:39:59 +0000
Message-ID: <179122559913.434549.12720841717630168470@kernel.org>
In-Reply-To: <20261004183639.3773498-2-4ncienth@gmail.com>
References: <20261004183639.3773498-2-4ncienth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch leaves a teardown race open that leaks a reference and
  has the same symptom it sets out to fix.

--

ipv6: serialize address publication with device teardown

This patch takes idev->lock around the write of idev->dead in
addrconf_ifdown(). In ipv6_add_addr() it holds idev->lock across both the
hash and the device-list publication, and rechecks dead and disable_ipv6
before publishing. The goal is to stop an address being published on a
dead idev, which leaks references and makes device deletion hang.

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c90ee6dd7446c..426739abb0744 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1168,14 +1168,20 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  
>  	rcu_read_lock();
>  
> -	err = ipv6_add_addr_hash(idev->dev, ifa);
> +	write_lock_bh(&idev->lock);
> +
> +	if (idev->dead)
> +		err = -ENODEV;
> +	else if (READ_ONCE(idev->cnf.disable_ipv6))
> +		err = -EACCES;
> +	else
> +		err = ipv6_add_addr_hash(idev->dev, ifa);
>  	if (err < 0) {
> +		write_unlock_bh(&idev->lock);
>  		rcu_read_unlock();
>  		goto out;
>  	}
>  
> -	write_lock_bh(&idev->lock);
> -
>  	/* Add to inet6_dev unicast addr list. */
>  	ipv6_link_dev_addr(idev, ifa);
>  

[Severity: High]
Can the same kind of leak still happen for temporary addresses after this
change?

The new critical section ends in ipv6_add_addr() once the address is on the
hash, addr_list and tempaddr_list:

net/ipv6/addrconf.c:ipv6_add_addr() {
    ...
	in6_ifa_hold(ifa);
	write_unlock_bh(&idev->lock);

	rcu_read_unlock();

	inet6addr_notifier_call_chain(NETDEV_UP, ifa);
    ...
}

The ifp reference held by ipv6_create_tempaddr() is handed to the new
address only after ipv6_add_addr() returns:

net/ipv6/addrconf.c:ipv6_create_tempaddr() {
    ...
	ift = ipv6_add_addr(idev, &cfg, block, NULL);
    ...
	spin_lock_bh(&ift->lock);
	ift->ifpub = ifp;
	ift->cstamp = now;
    ...
	addrconf_dad_start(ift);
	in6_ifa_put(ift);
    ...
}

On the RA path, ipv6_create_tempaddr() runs in softirq without RTNL:

ndisc_router_discovery()
  addrconf_prefix_rcv()
    addrconf_prefix_rcv_add_addr()
      manage_tempaddrs()
        ipv6_create_tempaddr(ifp, false)

Meanwhile, addrconf_notify() handles NETDEV_CHANGEMTU with
dev->mtu < IPV6_MIN_MTU by calling addrconf_ifdown(dev, true). The device
is still up and keeps receiving RAs. This is the same trigger the commit
message cites.

Suppose addrconf_ifdown() takes idev->lock right after ipv6_add_addr()
drops it. It sets dead, and the new recheck can't help because the address
is already published. Step 3 then sees ift on tempaddr_list with ifpub
still NULL, so it has nothing to drop:

net/ipv6/addrconf.c:addrconf_ifdown() {
    ...
		if (ifa->ifpub) {
			in6_ifa_put(ifa->ifpub);
			ifa->ifpub = NULL;
		}
    ...
}

The rest of the loop marks ift DEAD, unlinks it and puts it. Then
ipv6_create_tempaddr() stores ifp in ift->ifpub. addrconf_dad_start() does
nothing because ift is DEAD, and in6_ifa_put(ift) drops the last reference.

inet6_ifa_finish_destroy() never releases ifpub. Only ipv6_del_addr() and
Step 3 of addrconf_ifdown() do, and only while the address is still on
tempaddr_list.

If so, the public ifp stays pinned. That pins its idev, and the idev pins
the net_device through dev_tracker. Later device deletion would then wait
forever in netdev_wait_allrefs_any(), which is the symptom described in the
commit message.

Would it make sense to set ifpub inside the idev->lock publication section,
for example by passing it into ipv6_add_addr()? Another option would be a
teardown or destroy path that releases an ifpub attached this late.

> @@ -3897,7 +3903,9 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
>  	 *	   Do not dev_put!
>  	 */
>  	if (unregister) {
> +		write_lock_bh(&idev->lock);
>  		WRITE_ONCE(idev->dead, 1);
> +		write_unlock_bh(&idev->lock);
>  
>  		/* protected by rtnl_lock */
>  		RCU_INIT_POINTER(dev->ip6_ptr, NULL);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004183639.3773498-1-4ncienth%40gmail.com
