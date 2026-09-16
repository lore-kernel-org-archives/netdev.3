Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3D4D9F79
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602943; cv=none; b=QJdjqidmAwc8L+7V6uhReA1DpP0oC3nsGF53Exr5CcxxqJuPowXlNP5zLJIm6Q+5Ff/fo6ftzqIIxklv5lrCTVH9Oy99RU0aH71V39gMHTax0NtEOtfzkWE4I1fcZZhS406g9Y/68T0roGW9253jLWiWmBV7+nFUqyfSPLFIP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602943; c=relaxed/simple;
	bh=ilmL7E7xkmV+bOFEx31249Yv0hClg9S3BRI9uLj5OlA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6Qn4AUAUxNdesZg1QE2K+MTbg38kjmGWV66IhuYkDExu9YQwaPjgfMit0+1RztBW1lwUBZ1bULHVTx4oaBvterSzAtUPk77TsQWXFk/XCSzRks88RlGMGgs/kt8Qq5bnn+V3hMGxQzEYgCWb+5ebklDL9aueJ7Uo3XNzwp7FcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzyWwar4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzyWwar4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A861F00898;
	Wed, 16 Sep 2026 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602942;
	bh=1IrJFrz3O3MmYQ5GZga8UhWsetbofyYNObC0BruXdNQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SzyWwar4ITi4k1Wa/h6gcY2IxxAwytCC4Bfjxh6yLSIjQdxkHs5rHOHBqFAJGQ50o
	 rNL8DjB3ZNeG6YT2VOsGJsMPTMS0DyIF5qhaGPejy6TOzn/Ta0RPSRKYo610bmEKMg
	 PoLY8aEel5vLij8EfhPrMm9Kamvwfz0d5kjUoNxcOQDy/tUds7XX/z0Y6Yp3hfONA6
	 nh9nBeYcx/+EHdpLz3QAW1btuFUntjh574qWFlxhYSUCMTG8L4ki9RSEEau8g7Sbmt
	 56x+5akn595GX8rd4Q+DkS9PB5lF593j/E81z2UiPOYgd+NBAv44SHp4v2UCnHCBQG
	 3PHQFoDlLc9Jw==
Subject: Re: [PATCH v4 net-next 3/8] vxlan: vnifilter: signal interrupted
 RTM_GETTUNNEL dumps
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 kuniyu@google.com
Date: Wed, 16 Sep 2026 23:55:41 +0000
Message-ID: <178960294113.22033.1537285071354326342@kernel.org>
In-Reply-To: <20260915175501.391567-4-edumazet@google.com>
References: <20260915175501.391567-4-edumazet@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The generation counter added by this patch is not bumped on a
  mutating error path, so an RTM_GETTUNNEL dump that straddles the…

--

vxlan: vnifilter: signal interrupted RTM_GETTUNNEL dumps

This adds a per-netns generation counter to struct vxlan_net, bumped when
the set of vxlan devices in the netns changes or when a vni_list is
modified, and feeds it to nl_dump_check_consistent() from
vxlan_vnifilter_dump_dev() so user space sees NLM_F_DUMP_INTR on an
interrupted RTM_GETTUNNEL dump.

No Link: tags in the commit header.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 4404b912a7427..ce986a00a05c9 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -691,13 +707,16 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
>  	if (ret)
>  		return ret;
>  
> -	if (*changed)
> +	if (*changed) {
> +		vxlan_vnifilter_seq_inc(dev_net(vxlan->dev));
>  		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
> +	}
>  
>  	return 0;
>  }

[Severity: Medium]

Should the counter also be bumped when vxlan_vni_update_group() fails
after it has already overwritten vninode->remote_ip?

In vxlan_vni_update_group() the new group is stored into the dump-visible
list node before the fallible multicast steps:

	if (group)
		memcpy(&vninode->remote_ip, group, sizeof(vninode->remote_ip));

	if (vxlan->dev->flags & IFF_UP) {
		if (vxlan_addr_multicast(&old_remote_ip) &&
		    !vxlan_group_used(vn, vxlan, vninode->vni, ...)) {
			ret = vxlan_igmp_leave(vxlan, &old_remote_ip, 0);
			if (ret)
				goto out;
		}

		if (vxlan_addr_multicast(&vninode->remote_ip)) {
			ret = vxlan_igmp_join(vxlan, &vninode->remote_ip, 0);
			if (ret == -EADDRINUSE)
				ret = 0;
			if (ret)
				goto out;
		}
	}

	*changed = true;

	return 0;
out:
	return ret;

The memcpy is not undone on either goto out, and *changed stays false, so
vxlan_vni_update() takes the "if (ret) return ret;" path above and never
reaches the new vxlan_vnifilter_seq_inc() call even though the entry's
dumped content has already changed.

Is that failure reachable in practice?  vxlan_igmp_join() ends in
ip_mc_join_group():

net/ipv4/igmp.c:__ip_mc_join_group() {
	...
	if (count >= READ_ONCE(net->ipv4.sysctl_igmp_max_memberships))
		goto done; /* err = -ENOBUFS */
	...
}

which returns -ENOBUFS once the default net.ipv4.igmp_max_memberships
limit of 20 is exceeded on the vxlan socket.

The dump reads v->remote_ip both for the VXLAN_VNIFILTER_ENTRY_GROUP and
GROUP6 attributes and for the range coalescing decision in
vxlan_vnifilter_dump_dev():

		if (!dump_stats && vnirange(vend, v) == 1 &&
		    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {

If such a failed update lands between two dump skbs, does
vxlan_vnifilter_base_seq() return the same value, so
nl_dump_check_consistent() leaves NLM_F_DUMP_INTR clear and user space
assembles a dump mixing pre- and post-mutation group content with no
indication the snapshot was interrupted?

The entry ordinals still add up in this case (idx += vnirange(vbegin,
vend) + 1 over a coalesced run equals its node count), so this does not
duplicate or skip entries, only skews the reported group addresses.  The
same error path also skips the RTM_NEWTUNNEL notification, so no listener
learns of the change that was applied.

Would it make sense to bump the counter right where remote_ip is
committed, or to restore the old remote_ip on the goto out paths?

The condition is still present at the end of the series, in
vxlan_vni_update_group() and vxlan_vni_update().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915175501.391567-1-edumazet%40google.com
