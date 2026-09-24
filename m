Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4C1C5499
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208720; cv=none; b=UQbZ0e1uVKvcnq7vvGnGn3QIu0mPupPjfKUfE7bqLat3SVbmhkl2nWPrGWIXJuH9LKoRUdgkAkDkqA7sbTT0+Y28xCdayLaQwH5IAsCPBf2u1dFNALCylLeGSHX4814wHqUd+y70swlnOKXzbYMpbPivgEsPLu7UYXS44O8xuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208720; c=relaxed/simple;
	bh=s3JVdLqUKgu/Pske6lSZXPkvW+LlDIb7HnpHSBGUL3k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W342VXSIGoGSed9YiTmcal+Gapxv7iOuvP9uU7uBmWNyy+kFwf6G/qbzFxDxfOcUOHzKb5KSH9YcpjR1JYNpsSJA1TVJbZKGZEyXbk07tDwjFY2tKFyPcbaSdC/AUw18x0zIxGupEgrh/i/kJSbb++vXmJJifUFGUSshTj28o1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGSYMvRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGSYMvRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB781F00898;
	Thu, 24 Sep 2026 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208717;
	bh=q9lyZd6lehHMeke69GNy2l+UGnUU1ogjjw6viODVoBs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FGSYMvRlXM8MmDZLLJafmA1tjq0JQfYrWe3xPfkCNGR3eSthu9jePKE2ATsEcdHhS
	 W3Xjc1GluFlu8qClLDLbiMGlzfmr4vJSSgAponUM2rUUverbO7nc+czQqulWH9iCjM
	 sUJQz46qe3RLAck7C4bSXG2dJbkRkzXwCMKeD7nCLoyOUGpeCw772u6OpR3lMnunrg
	 +Ybw7vG4jSpC8ufGxs4UtXHu8MI/JfusVRjsEjMfsg3LJbzwFpTggAHFYBvuQT9XU1
	 nfVrs2glwgcnONDmGtfZz3J3egXFFWQt/KYXKvNJyiYKcL7W+Un9P8IB//fnlPg6QU
	 ruezgyaLYaBSg==
Subject: Re: [PATCH v6 net-next 3/8] vxlan: vnifilter: signal interrupted
 RTM_GETTUNNEL dumps
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 24 Sep 2026 00:11:56 +0000
Message-ID: <179020871691.2160803.13091357899213699769@kernel.org>
In-Reply-To: <20260922181102.3989489-4-edumazet@google.com>
References: <20260922181102.3989489-4-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Changelog/code mismatch: the commit message claims that "an in-
  place group update in vxlan_vni_update() (which splits or merges…

--

vxlan: vnifilter: signal interrupted RTM_GETTUNNEL dumps

This adds a per-netns generation counter that is bumped when the set of
vxlan devices in a netns changes, when a vni_list entry is added or
removed, and when a vni group is updated in place.  The counter is fed to
nl_dump_check_consistent() in vxlan_vnifilter_dump_dev() so user space
receives NLM_F_DUMP_INTR and can retry the RTM_GETTUNNEL dump.

Quoting the changelog:

>     A concurrent __vxlan_vni_add_list(), which inserts sorted by VNI,
>     __vxlan_vni_del_list(), or an in-place group update in
>     vxlan_vni_update() (which splits or merges coalesced VNI ranges) shifts
>     the second cursor, duplicating or skipping entries.

[Severity: Low]
Is the part about vxlan_vni_update() accurate?  The two other mechanisms
named there (list insert/delete moving cb->args[1], device
register/unregister moving cb->args[0]) do look real, but the claim that a
group update shifts the second cursor does not seem to match
vxlan_vnifilter_dump_dev().

cb->args[1] is a plain ordinal into vg->vni_list, advanced either one node
at a time for skipped nodes:

	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
		if (idx < s_idx) {
			idx++;
			continue;
		}

or in whole-node units when a coalesced range is flushed:

			idx += vnirange(vbegin, vend) + 1;
			vbegin = v;

Coalescing only folds strictly consecutive VNIs:

		if (!dump_stats && vnirange(vend, v) == 1 &&
		    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {

so vnirange(vbegin, vend) + 1 is exactly the number of vni_list nodes
merged into the emitted message, whether or not the ranges are split
differently on the next pass.

A group update only rewrites vninode->remote_ip; it adds no node, removes
no node, and cannot change a node's VNI, so no node's ordinal moves.
Doesn't a resumed dump therefore skip exactly the nodes it already
emitted, with nothing duplicated and nothing lost?

What a concurrent group update can do is make the whole dump internally
stale, for example an earlier skb reporting VNI X inside range [A-B] with
the old group while a later skb reports the new one.  That is a content
consistency argument rather than a cursor shift argument.  Could the
changelog be reworded to describe that instead for this bump site?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 0a04e8875f7dc..181a7614be5cd 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -571,8 +587,11 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  	if (ret)
>  		goto out;
>  
> -	if (group)
> +	if (group) {
>  		memcpy(&vninode->remote_ip, group, sizeof(vninode->remote_ip));
> +		if (!create)
> +			vxlan_vnifilter_seq_inc(dev_net(vxlan->dev));
> +	}
>  
>  	if (vxlan->dev->flags & IFF_UP) {
>  		if (vxlan_addr_multicast(&old_remote_ip) &&

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922181102.3989489-1-edumazet%40google.com
