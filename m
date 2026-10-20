Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463128;
	b=jydfwPkrQMUdgfar0DkWzbwhxs6R14qgPPoiEcOXyI40WyCz/zX7TKLHnrFAuNpb5ZEF
	 lBgtBnddJ3qOrQYS7I9E+cSNDH+dJ52bjpdL8IJF/4rUxp2yNFwUmLwfWAQNkj+1mpx3m
	 dw+vjmb5ZTfVOT4850C1vjUC0DTvGlQaa7kNWVkfq9gWjzNQZGTuW1wehI1w6sIK8vtvA
	 goeMkUHEKLQfkhijOYVS9/fbRZEg++rfcoVhiBEoPtJo5eHToWJuMN2AmMpGhl9dIC8CD
	 JqkwElitseaGMqkXeCqevrgioW3lySbeE/OZOIiDG09Wz9x73yQ01+j/79zTVgHU0Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463128;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZMl9cMpXzSR9zQQ8SdtmT5kSnxs//KSEsh15kGzC4os=;
	b=Mtrv5K6wRAdUFslwemIENntcKl3rB53/L+0ULK6Eh472y71m9LMOzNUgG3W5gyuoZrh3
	 U3oKGIOwde20J811knHgnT+a80yKdJHON3/X6OY3CiV6hGAOpoPlQVTmsHcxEViyWgUrJ
	 ajpnUsgbsYh93nwyH790BoguxtKz2MGSWI+LJDWSTnRlKfB8CfMw1h90HPC37VSWvfKVR
	 CFCJ0y6Okc9HWyzvNLIIlzyXxyq7076Uy7d5QHLsKllHC6fUswNbWcv3TIZUewhJZ79MQ
	 S7fnthM4Cv1zyD7a8NUIcUPBxf2cEQ81bmbQoIUIspn8gp8r4uYY8LsesEZLjh+9dQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijXRI3VP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889C606A31B;
	Tue, 20 Oct 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijXRI3VP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC461F000C5;
	Tue, 20 Oct 2026 02:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792463128;
	bh=ZMl9cMpXzSR9zQQ8SdtmT5kSnxs//KSEsh15kGzC4os=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ijXRI3VPglqQ2eVLwZrLlX4QCnFieQkVKofC1euR4YCBwseXzIGHPDJOIcIwH/P4K
	 hxUuw0ISdfF/W4B0L0yPs26gyVwIa+EVUowUPaW7aake4aZJhkcb8SxEURp5iPGful
	 PQuEvOstjUo48xvUXbEUJUbL7vGBExJBOoBP4l55KBWf48nQju6Gq9mNJSRVEIWzrC
	 7+6sTlE3aCA8oWOihXPlgtrwFNGVsZw8xKlh5mQ8OuAO01EonhT99qqpyoOM7csJqw
	 igZOWDVqf3xyPWZC/7JhgJATq8oxuJn4IjwaBCohMBNeNS7X/PewcEmgsZS6RoK/r2
	 uuJFyt+A2k4QQ==
Subject: Re: [PATCH net v2] net/ncsi: fix use-after-free of ncsi_package in
 ncsi_remove_package()
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gwshan@linux.vnet.ibm.com, joel@jms.id.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 02:25:26 +0000
Message-ID: <179246312683.3135.9781363315996989576@kernel.org>
In-Reply-To: <20261019013640.449965-1-18983559317@163.com>
References: <20261019013640.449965-1-18983559317@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On its own, this patch does not close the ncsi_package use-
  after-free its commit message describes.
- [High] ncsi_unregister_dev() (net/ncsi/ncsi-manage.c:1956-1974) frees
  every package via ncsi_remove_package() at line 1965, and only…
- [High] ncsi_remove_package() now defers only the package free.

--

net/ncsi: fix use-after-free of ncsi_package in ncsi_remove_package()

This patch makes ncsi_remove_package() free the package with kfree_rcu()
instead of kfree(), and adds an rcu_head to struct ncsi_package. The
commit message calls this the free side of the fix. The read side and
the deferral of the parent object are left to two companion series.

[ ... ]

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..237e0416e6d93 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -326,7 +326,8 @@ void ncsi_remove_package(struct ncsi_package *np)
>  	ndp->package_num--;
>  	spin_unlock_irqrestore(&ndp->lock, flags);
>  
> -	kfree(np);
> +	/* Netlink walkers may still hold the package */
> +	kfree_rcu(np, rcu);

[Severity: High]

Does kfree_rcu() protect anything here if this patch is applied by
itself? It only waits for RCU read-side critical sections that already
exist. At this revision, none of the NCSI genl handlers enters one. The
only rcu_read_lock() in net/ncsi/ is the vlan_vids walk in
ncsi-manage.c.

For example, ncsi_pkg_info_nl() resolves ndp, sleeps in an allocation,
and then walks the list without rcu_read_lock():

net/ncsi/ncsi-netlink.c:ncsi_pkg_info_nl() {
    ...
	ndp = ndp_from_ifindex(genl_info_net(info), ...);
    ...
	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
    ...
	rc = ncsi_write_package_info(skb, ndp, package_id);
    ...
}

ncsi_write_package_info() then does:

	NCSI_FOR_EACH_PACKAGE(ndp, np) {
		if (np->id != id)
			continue;

The dumpit handler ncsi_pkg_info_all_nl() keeps package after an
unprotected walk and later passes package->id to
ncsi_write_package_info().

ncsi_set_interface_nl() also keeps package. It then takes package->lock
and writes multi_channel, channel_whitelist and preferred_channel through
that pointer.

Under CONFIG_PREEMPT_RCU, a reader that is preempted or blocked outside
an RCU section does not hold up the grace period. So the kfree_rcu()
callback can run before the reader touches np. That matches the splat in
the commit message, which came from a PREEMPT kernel. NCSI_CMD_PKG_INFO
has no GENL_ADMIN_PERM, so unprivileged users can reach these readers.

ncsi_unregister_dev() also still frees ndp itself with a plain kfree().

The commit message says:

  "The race is closed by the three series together; each one keeps its
  own Fixes: tag so they can be backported independently."

If this patch is backported alone, the ncsi_package use-after-free is
still reachable. Should the dependency on the read-side series be stated
explicitly, or should the series be merged and backported as one unit?

Also, the read side can't just wrap ncsi_pkg_info_nl() in one
rcu_read_lock(). ndp is resolved before the GFP_KERNEL genlmsg_new()
call, and that call can sleep.

[Severity: High]

Is there also a reader of the package outside netlink that RCU deferral
can't cover? ncsi_unregister_dev() frees every package before it
disables the work item:

net/ncsi/ncsi-manage.c:ncsi_unregister_dev() {
	dev_remove_pack(&ndp->ptype);

	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);
    ...
	disable_work_sync(&ndp->work);

	kfree(ndp);
}

A request timer can still expire after dev_remove_pack(). The timeout
path then queues the work again:

ncsi_request_timeout()
  ncsi_free_request()
	if (driven && cmd && --ndp->pending_req_num == 0)
		schedule_work(&ndp->work);

ncsi_dev_work() then runs ncsi_configure_channel(), which caches the
active package and channel outside any RCU section:

	struct ncsi_package *np = ndp->active_package;
	struct ncsi_channel *nc = ndp->active_channel;
	...
		nca.package = np->id;

ncsi_probe_channel() reads ndp->active_package->id in the same way.

ncsi_remove_package() never clears ndp->active_package or active_channel.
The active_package pointer also lives across separate work runs, so no
single RCU section could cover it.

Channels are still freed right away, and later config states write
channel state under nc->lock.

Would it work to disable ndp->work and stop the request timers before
the package loop in ncsi_unregister_dev()?

[Severity: High]

Only the package free is deferred here. Earlier in ncsi_remove_package(),
the child channels are still freed synchronously:

	list_for_each_entry_safe(nc, tmp, &np->channels, node)
		ncsi_remove_channel(nc);

ncsi_remove_channel() frees the filter arrays while the channel is still
linked on np->channels. It then frees the channel right after
list_del_rcu():

net/ncsi/ncsi-manage.c:ncsi_remove_channel() {
    ...
	/* Release filters */
	kfree(nc->mac_filter.addrs);
	kfree(nc->vlan_filter.vids);
    ...
	list_del_rcu(&nc->node);
	np->channel_num--;
	spin_unlock_irqrestore(&np->lock, flags);

	kfree(nc);
}

Even if the package survives, can ncsi_write_package_info() still walk
into freed channels?

ncsi_write_package_info()
  NCSI_FOR_EACH_CHANNEL(np, nc)
    ncsi_write_channel_info()
      reads nc->version.fw_name and ncf->vids[i]

If so, freed heap contents would be copied into a netlink reply sent to
an unprivileged caller.

The commit message leaves the channel to the companion series. But the
filter arrays are freed before the channel is unlinked, so deferring nc
alone would not be enough. The filter frees would also need to move after
list_del_rcu() and be deferred.

Does the companion series handle that ordering?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019013640.449965-1-18983559317%40163.com
