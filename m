Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66941C2E4
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663213; cv=none; b=PYdzJusOtZ0VHCYQMFEV6pYz91IlLquVNqshRdT7I/M/BeCN1lfusMv2ve04f93aKxEWAWGoCxYYN6LyC+DU4QMd3BIr0PYt1v8lqFCnZ5K8GqG6hnkovdt3xXkM05yF8DDNO/8IaU8a+V8sJnoC+sV/qHxuocf2tcA3+35LEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663213; c=relaxed/simple;
	bh=5vdcJ4Kz5OSIYX4ifesf+yRJlY0M5qAjjaJANAMGgek=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQ+J1mIiZoeW0s58GcYbyFJZU+zGZmugvX0BKtwXFYSXCx9X3X+vPgbGvSMonM4rsADCgBqfqkxNirwEk/Sw9VU5OvsHsFiDbMKbEPbPt1CDtX4Q7yhGiKp44gKVLzWHwQBLvxxGOygk15CZIGWHiiiE8AZgMl7BxiglerL39xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmJCHmpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmJCHmpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF351F000FF;
	Tue, 29 Sep 2026 06:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663212;
	bh=fhpo7lhZP7QU3k0EPR6wCU4jDVocmLG2PGUF50xcGr8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AmJCHmpvCkgKifxKxbmQgGqkLjCfcLckSfgZML9DlJlPtwagVxsKpPBHlYoN4I6dG
	 brm0CNypqDHhbBaE4QMq4svCUve8AztoZsCwZhWjpLfThFmESrVg7fVoFF4+aTjTER
	 BBCGBMHo6RuYxB93vkLczkthDOXnlJ+fytFbemjhqqlmHzLYBhnj7GZ/YXi7J6jgnD
	 XU7YwlBLkEIU3q84K6LMDp/3fJOOuf+E6/TgmWCASYyjB83u5HUQzViZtzh5SUtaDi
	 svWgZpa7vYZan0NZCxTic12Zxyn4IrjCQv7rMcDRmXZxYY8Cju4wOkOrIQpmi16dHm
	 W4dewIlKx0r2A==
Subject: Re: [PATCH v1 net-next 1/5] net: Remove net->is_dying.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Tue, 29 Sep 2026 06:26:51 +0000
Message-ID: <179066321100.434549.2778096770217672912@kernel.org>
In-Reply-To: <20260927202429.2452589-2-kuniyu@google.com>
References: <20260927202429.2452589-2-kuniyu@google.com>
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

- [Low] The commit message for "net: Remove net->is_dying." says
  net->is_dying "is an alias of !check_net(net)".

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a valid NSID
  of INT_MAX makes the signed cursor in unhash_nsid() overflow, which…
- [Low] This problem wasn't introduced by this patch, but the block
  comment in cleanup_net() right after the loop this patch edits says…

--

net: Remove net->is_dying.

This patch removes the is_dying flag from struct net. cleanup_net() used
to set that flag on the nets in its current kill batch. In unhash_nsid()
the flag check is replaced with check_net(peer), on the grounds that
is_dying is an alias of !check_net(net).

> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index da5f881fbd3b9..0e13de0cd36b6 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -644,7 +644,7 @@ static void unhash_nsid(struct net *last)
>  			int curr_id = id;
>
>  			id++;

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. What
happens here when a netns_ids IDR has an entry at INT_MAX?

rtnl_net_newid() accepts any s32 NETNSA_NSID. alloc_netid() then does:

	min = reqid;
	max = reqid + 1;

For reqid == INT_MAX, max wraps to INT_MIN. idr_alloc() treats end <= 0
as unbounded, so ID INT_MAX gets allocated.

When unhash_nsid() later reaches that entry, id++ wraps to INT_MIN,
whether or not the entry is removed. On the next iteration idr_get_next()
turns the cursor into an unsigned long above INT_MAX. idr_get_next_ul()
finds no slot and leaves the value unchanged, so this fires:

lib/idr.c:idr_get_next() {
	unsigned long id = *nextid;
	void *entry = idr_get_next_ul(idr, &id);

	if (WARN_ON_ONCE(id > INT_MAX))
		return NULL;
	...
}

An unprivileged user can reach this with unshare(CLONE_NEWUSER |
CLONE_NEWNET) followed by RTM_NEWNSID with NETNSA_NSID set to INT_MAX.
The next netns teardown anywhere on the system then hits the WARN. With
panic_on_warn=1 that becomes a panic. No entries get skipped, because
INT_MAX is the last possible ID.

Would it make sense to use an unsigned long cursor with idr_get_next_ul(),
or to break out of the loop after processing INT_MAX?

> -			if (!peer->is_dying)
> +			if (check_net(peer))
>  				continue;

[Severity: Low]
The commit message says:

    It is an alias of !check_net(net), and having two ways to represent
    the same state is confusing.

Is that equivalence exact? is_dying was only set on the nets that
cleanup_net() took from cleanup_list with llist_del_all(). check_net()
is false for every net whose refcount has reached zero.

That set also includes nets queued after this cleanup_net() pass took its
snapshot:

put_net()
  ns_ref_put() reaches 0
  __put_net()
    llist_add(&net->cleanup_list, &cleanup_list)

It also includes nets whose refcount has hit zero but which have not yet
reached llist_add(). Those nets are still on net_namespace_list and still
sit in other nets' netns_ids IDRs.

Before this patch, unhash_nsid() skipped them because is_dying was false,
and their own later cleanup pass handled them. With check_net(peer), the
current pass now calls idr_remove() on them and sends RTM_DELNSID
straight away. That means userspace can see the notification one pass
earlier.

The wider condition does look safe. peernet2id_alloc() goes through
maybe_get_net(peer), and rtnl_net_newid() gets its peer from
get_net_ns_by_pid() or get_net_ns_by_fd(). So a zero-refcount peer can
never be added back to an IDR, and the later pass finds nothing left to
remove.

Could the commit message say that the new check covers more nets than the
old flag did, and explain why that is fine?

Later patches in the series ("net: Track state in ops_undo_list()." and
"ipv4: Batch rt_flush_dev() for dying netns.") describe a dying netns
queued for the next cleanup_net() batch as having !check_net() without
being in the current batch. That also contradicts the "alias" wording.

[ ... ]

> @@ -681,7 +681,6 @@ static void cleanup_net(struct work_struct *work)
>  	llist_for_each_entry(net, net_kill_list, cleanup_list) {
>  		ns_tree_remove(net);
>  		list_del_rcu(&net->list);
> -		net->is_dying = true;
>  	}
>  	/* Cache last net. After we unlock rtnl, no one new net
>  	 * added to net_namespace_list can assign nsid pointer

[Severity: Low]
This isn't a bug introduced by this patch, but the comment says "After we
unlock rtnl". This section of cleanup_net() never takes rtnl. It uses
net_rwsem instead:

	down_write(&net_rwsem);
	llist_for_each_entry(net, net_kill_list, cleanup_list) {
	...
	last = list_last_entry(&net_namespace_list, struct net, list);
	up_write(&net_rwsem);

Should the comment say net_rwsem? The guarantee it describes actually
comes from the maybe_get_net() check in peernet2id_alloc().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927202429.2452589-1-kuniyu%40google.com
