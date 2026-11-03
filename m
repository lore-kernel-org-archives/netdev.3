Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721644;
	b=t13gA122XIs4NtdE24uFwxmsFuar8FdJk93cruSZJGb7Nyq3pcaKTgSb1tIaViBKMuT6
	 UwNXo503RCrvAR1nr+y6JdVyPtZcxg1k0+m1Kz9uJAntJfsOGtjcdNhvhQO6hv8xNIFbP
	 joik2efv5Y+dDxHidtUaypJbpVfW2vZJAzI47H+0R8nTvbjV0vEdRk9zRS/giV6zBxGWx
	 uqD+pw8iYWWwGm42Qnj5CaaoBS9aXgB+4+0Ykgu1NHlaZZwn53+tgVwbm7qXNg/ASdIxi
	 Dttj0RzlyZAZCxF0ODgzr65Pk+EgJMyLHyHZimejEewlFUgDyErp94bnJoe71aSqEYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721644;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0E6UQY3gxEST2VW1P9Kpl30sQwqu8vQxC0pbeDxJdJ8=;
	b=qRVYlgwGEJWet1lC0gXBuGdva47gTGTYEFBA0WA/nmpa26sm/TBqXmNn118N7BvuS/4P
	 2O9+JFpdg9OiwK+v5Q4zWzmHOpV21dTyPM4gJArStHGYTtpi+KysCmh+djPmOYJzPcXZV
	 +nPm1zuBDpQr9J/6TAr/4WXHjYsz4F5s4LXz6tRizmtC4Dh8l5T6UB+EUtua82G8F7lMZ
	 wali2+oltGVU/EHWwdX1mGlS+9gi/UkBs4kbSjJt244uNnzOlUbbRy87Iqjn3pnr0C6cX
	 MJoodWQKvY12/ioGORi9ZGLiTBVr3Khlifu4+I+O+qYSfz2b9p3nPzqyENwIdyS9g5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A50gSM3b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972F606A32E;
	Tue,  3 Nov 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A50gSM3b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4821F00919;
	Tue,  3 Nov 2026 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721644;
	bh=0E6UQY3gxEST2VW1P9Kpl30sQwqu8vQxC0pbeDxJdJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A50gSM3bB4kkdUUkz2wfK6jKIG6fx3AnvKl3P22gHJiPRl94z0stwjwYDkfswMFYM
	 wWcSlCRJxEQF/REiGAD9EQT70qFqmsQAwhWSHof7ikDLj0kxrKR77b6SYx3xPMZ2QG
	 iSJqawNSWs2eAvEzn623en8k99wvNdMqbN7J4OSN86VbWUaWlS3mA+qVSyTOPBS/EV
	 2cocQy3tJH10CvXaPEJTORvOSnD64Xjtb2wD+7l8CsDwEcuA/zZqlTAuBb1aBXEve8
	 SBGVhl/dt1ctiaMSGYasNcpARa3ufYmh2vbElnRKzT0HV1DNxzoTXV0Hp6qAi39wk7
	 wDTR/R6xn13yA==
Subject: Re: [PATCH net v4 1/2] genetlink: Reject joining multicast groups no
 family owns
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 fw@strlen.de, martineau@kernel.org, v3rdant.xiang@gmail.com,
 aliceryhl@google.com, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 16:00:42 +0000
Message-ID: <179372164269.488856.17448970060747076034@kernel.org>
In-Reply-To: <20261102155819.4100930-2-anilkaushikwireless@gmail.com>
References: <20261102155819.4100930-2-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/netlink/af_netlink.c, netlink_bind() lets one failing
  group abort the whole bind().

Pre-existing issues:
- [Medium] Kept only because requires_validation=true.

--

genetlink: Reject joining multicast groups no family owns

genl_bind() now returns -ENOENT when no registered family owns the
requested multicast group ID. Before this change such joins succeeded.
The socket also stayed a member if a family with privileged-only groups
later got the same ID.

Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/

> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 5cc1037d4917e..f038f04ef4ead 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1825,7 +1825,7 @@ static int genl_bind(struct net *net, int group)
>  {
>  	const struct genl_family *family;
>  	unsigned int id;
> -	int ret = 0;
> +	int ret = -ENOENT;

[Severity: Medium]
Can a bind() with an nl_groups mask now fail as a whole when only one
bit in the mask has no owner?

netlink_bind() in net/netlink/af_netlink.c calls the bind hook once for
each set bit. On the first error it undoes the groups it already added
and returns:

net/netlink/af_netlink.c:netlink_bind() {
    ...
		for (group = 0; group < BITS_PER_TYPE(u32); group++) {
			if (!test_bit(group, &groups))
				continue;
			err = nlk->netlink_bind(net, group + 1);
			if (!err)
				continue;
			netlink_undo_bind(group, groups, sk);
			return err;
		}
    ...
}

Generic netlink group IDs are sparse. mc_group_start reserves only a few
bits:

static unsigned long mc_group_start = 0x3 | BIT(GENL_ID_CTRL) |
				      BIT(GENL_ID_VFS_DQUOT) |
				      BIT(GENL_ID_PMCRAID);

Other IDs are given out only when a family registers. So on a typical
system most IDs in 1..32 have no owner. genl's nlk->ngroups is at least
32, so the masking at the top of netlink_bind() does not remove these
bits.

Before this patch, a bind() on a NETLINK_GENERIC socket with a mask that
mixed owned and unowned IDs (for example nl_groups = ~0) returned 0 and
joined the owned groups.

With this patch, will that call return -ENOENT and join none of the
requested groups, including the valid owned ones?

The netlink core also still treats every ID below ngroups as valid in
netlink_setsockopt():

		if (!val || val - 1 >= nlk->ngroups)
			return -EINVAL;

genl_bind() now rejects many of those IDs, so the two layers disagree.

The commit message argues that joining an unowned group has no use, and
its test counts single-group joins. It does not mention the bind() mask
case.

The later commit "netlink: Check a group again if it was released while
joining it" keeps both the -ENOENT return and the all-or-nothing loop.
So this behaviour change is still there at the end of the series.

Should the bind() mask path skip unowned IDs instead of failing? If not,
should the commit message mention this uAPI change?

[ ... ]

> @@ -1841,6 +1841,7 @@ static int genl_bind(struct net *net, int group)
>  			continue;
>  
>  		grp = &family->mcgrps[i];
> +		ret = 0;
>  		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
>  		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
>  			ret = -EPERM;

[Severity: Medium]
This isn't a bug introduced by this patch, but is there still a window
where a socket can become a member of a group ID that was just freed?

genl_bind() checks ownership and the CAP flags under down_read(&cb_lock).
It drops cb_lock before returning. The caller adds the membership later,
under netlink_table_grab():

net/netlink/af_netlink.c:netlink_setsockopt() {
    ...
		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
			err = nlk->netlink_bind(sock_net(sk), val);
			if (err)
				return err;
		}
		netlink_table_grab();
		netlink_update_socket_mc(nlk, val,
					 optname == NETLINK_ADD_MEMBERSHIP);
    ...
}

netlink_bind() splits the check and the update in the same way for the
nl_groups mask.

Suppose genl_unregister_family() runs in that gap:

CPU1                                  CPU2
setsockopt(NETLINK_ADD_MEMBERSHIP)
  genl_bind() returns 0
  (cb_lock dropped)
                                      genl_unregister_family()
                                        genl_unregister_mc_groups()
                                          __netlink_clear_multicast_users()
                                          clear_bit(grp_id, mc_groups)
  netlink_table_grab()
  netlink_update_socket_mc()

__netlink_clear_multicast_users() clears only the sockets that are
members at that moment.

Would the socket on CPU1 then be added to the now-free ID?

A family registered later could get that ID, including one whose groups
have GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN. It would then
deliver to the socket through do_one_broadcast(), and nothing checks the
membership again.

The commit message says:

  "A family registered later can get that ID, and the socket stays a
  member: nothing checks it again."

This patch alone does not close that window. The window is narrow,
because a family has to be unregistered during it, for example by rmmod
or by a module init that fails after registration.

The next commit in the series, "netlink: Check a group again if it was
released while joining it", appears to fix this:

- It adds a per-group generation counter, nl_table[].mc_gen, which
  __netlink_clear_multicast_users() increments.
- netlink_setsockopt() and netlink_bind() compare the counter again
  under netlink_table_grab() and retry if the group was released.
- On retry, genl_bind() returns -ENOENT for the freed ID.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102155819.4100930-1-anilkaushikwireless%40gmail.com
