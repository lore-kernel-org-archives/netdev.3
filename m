Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721646;
	b=rwx45l9EhxvYO5lBTyBIdkpsdPbgzuylqf+o+GARJvtxhkVRwH+s+UH2w29CEHpYiwAi
	 +oqvK/y8dhme7ufRZTqaGUdYjYNpOQcaDexSG5/OUjke7hwLAdYzcQw/wCi1PAPGc/KPQ
	 OBtmIrxEit6CC+0qDBObtJK8Nb9DUkumKj38JnFs2jwh1cjz0bUsCrkWN+CNCj9cSm341
	 /wksHcFAjXvbvQIan1/JjJm3hbA+y9rHhvdVgOaUuM/+LZi2QekZiu8JvDKhMrTNQMA4B
	 SVBBaCix98hcVQ0eAvvz7EpGnsqh/31F2E+KQz0ipLZdd8Uzu/4eGMz8VdQQVDTFoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721646;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BhSeX2N+Xu/W9zktj2aVyKr/nJVps0mfmF8O3/ib7pM=;
	b=Yly5QIlesMdNyZJBqXSz1ePveBBATN3vJZDIEBWPosZc0b44sFpCl32kWi8F+VIktO1u
	 zgDdrfH6OgvN3wV3WcDnR832pQT/XqC686OdmJ+a8kOKFCLnB8ZFurYIULk3VRGx3XZ0+
	 Qtx8DRs9JYvmW8DUOmQZW8nris2kfagMh2bgHy8uwVJnkeJqXZDQriMRuXKo4QLP2Vkch
	 lxmyYjs2BgrgqhEsctVuFdsUOiBN0s346w7SUtIbU1+g/AyAcKIeAiRoN+bqbrKEJVVmp
	 ixGC8UPtxhQxVybZ6e+iGmmHEBgYfTmj4Khyo4FHBkXtZY4GreRNN1djxxs2CKH4zMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7+jUXfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A8606D81C;
	Tue,  3 Nov 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7+jUXfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D64F1F00919;
	Tue,  3 Nov 2026 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721645;
	bh=BhSeX2N+Xu/W9zktj2aVyKr/nJVps0mfmF8O3/ib7pM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q7+jUXfBjZe0G0YJmlXlua/RguY8MqC2TRv1k0Rtisr+jXrCXX7e22+HbH0hWgYNu
	 aRyqGV1lLtjPBcYh7pqGGTbU0G1navVcltU/HzH05CDN6FALag9S8AxGz4Xpe7QYj8
	 p4M51l6tYemN4VDXS3bOiP0zePLHKpWK2d0rX5iAgUDHqffJzylFSpI8udcZ4Gchq2
	 H4flPXar8RmPrVdyJsQynkPFK3tbU1oK5anFrzHNzy2cBl/imagQRCZ10Yf0DAzV05
	 frAYPg1ZRIKz+2NFoIqvMnVgS3wiJ0QLTBEaWuCfMyNMYUsYkqZ9W1upJhCFDf5Ua4
	 KXNB79hb1El7A==
Subject: Re: [PATCH net v4 2/2] netlink: Check a group again if it was
 released while joining it
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 fw@strlen.de, martineau@kernel.org, v3rdant.xiang@gmail.com,
 aliceryhl@google.com, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 16:00:44 +0000
Message-ID: <179372164415.488856.15554879847164426558@kernel.org>
In-Reply-To: <20261102155819.4100930-3-anilkaushikwireless@gmail.com>
References: <20261102155819.4100930-3-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] netlink_add_usersock_entry() (net/netlink/af_netlink.c:2962) sets
  up nl_table[NETLINK_USERSOCK]: groups=32, listeners, module,…
- [Low] The kernel-doc of netlink_change_ngroups() says the group count
  can be reduced: 'it does not implicitly clear listeners from groups…
- [Low] netlink_setsockopt() (lines 1753-1760) and netlink_bind() (lines
  1079-1091) decide whether to call ->netlink_unbind() by comparing…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  deadlock in the code being changed.

--

netlink: Check a group again if it was released while joining it

This patch adds a per-group generation counter (mc_gen) to the netlink
table. __netlink_clear_multicast_users() bumps it when genetlink releases
the group IDs of a family. netlink_bind() and netlink_setsockopt() read
the counter around ->netlink_bind() and again under netlink_table_grab(),
and redo the bind check if the group was released in between.

Link: https://lore.kernel.org/netdev/179340003139.3131.11274717768928642724@kernel.org/

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 1281c42a3456a..75efc0cfb8052 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c

[ ... ]

> @@ -1036,6 +1046,10 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
>  			netlink_undo_bind(group, groups, sk);
>  			return err;
>  		}
> +
> +		netlink_lock_table();
> +		memcpy(bound_gen, tbl->mc_gen, sizeof(bound_gen));
> +		netlink_unlock_table();
>  	}
>  
>  	/* No need for barriers here as we return to user-space without

[Severity: High]
This isn't a bug introduced by this patch, but can the port ID failure
path right after this comment deadlock against genetlink family
registration or unregistration?

net/netlink/af_netlink.c:netlink_bind() {
    ...
	netlink_lock_table();
	if (!bound) {
		err = nladdr->nl_pid ?
			netlink_insert(sk, nladdr->nl_pid) :
			netlink_autobind(sock);
		if (err) {
			netlink_undo_bind(BITS_PER_TYPE(u32), groups, sk);
			goto unlock;
		}
	}
    ...
}

netlink_undo_bind() runs while this thread still holds an nl_table_users
reference. For NETLINK_GENERIC, nlk->netlink_unbind is genl_unbind(),
which always does down_read(&cb_lock).

genl_register_family() and genl_unregister_family() take cb_lock for
writing through genl_lock_all(). They then call netlink_table_grab() from
genl_validate_assign_mc_groups() or genl_unregister_mc_groups(), and it
sleeps in TASK_UNINTERRUPTIBLE until nl_table_users reaches 0:

CPU1: genl_unregister_family()
  genl_lock_all()                  /* down_write(&cb_lock) */
CPU2: netlink_bind()
  netlink_lock_table()             /* nl_table_users = 1 */
CPU1: genl_unregister_mc_groups()
  netlink_table_grab()             /* waits for nl_table_users == 0 */
CPU2: netlink_insert() fails with -EADDRINUSE
  netlink_undo_bind()
    genl_unbind()
      down_read(&cb_lock)          /* blocks behind CPU1 */

Neither side can make progress. cb_lock stays write-held, which also
blocks genl_rcv().

An unprivileged user can get to the bind() side. It is enough to bind a
NETLINK_GENERIC socket to a group that has no GENL_MCAST_CAP_* flags,
such as the nlctrl notify group, with an nl_pid that is already in use.

The writer side can be a module unload. It can also be a family
registration triggered through request_module() from CTRL_CMD_GETFAMILY.

The comment in netlink_release() warns about the same lock ordering:

	/* must not acquire netlink_table_lock in any way again before unbind
	 * and notifying genetlink is done as otherwise it might deadlock
	 */

The new retry paths in this patch call netlink_table_ungrab() before
calling the unbind callbacks. Could this error path also call
netlink_undo_bind() only after netlink_unlock_table()?

[ ... ]

> @@ -1695,12 +1731,34 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
>  			return err;
>  		if (!val || val - 1 >= nlk->ngroups)
>  			return -EINVAL;
> +retry:
>  		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
> +			netlink_lock_table();
> +			gen = tbl->mc_gen[val - 1];
> +			netlink_unlock_table();
>  			err = nlk->netlink_bind(sock_net(sk), val);
>  			if (err)
>  				return err;
> +			netlink_lock_table();
> +			bound_gen = tbl->mc_gen[val - 1];
> +			netlink_unlock_table();
>  		}
>  		netlink_table_grab();

[ ... ]

> +		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind &&
> +		    gen != tbl->mc_gen[val - 1]) {
> +			bool unbind = bound_gen == tbl->mc_gen[val - 1];
> +
> +			netlink_table_ungrab();
> +			if (unbind && nlk->netlink_unbind)
> +				nlk->netlink_unbind(sock_net(sk), val);
> +			goto retry;
> +		}

[Severity: Low]
Can this call ->netlink_unbind() on a family whose ->netlink_bind() never
ran for this socket?

bound_gen is read after genl_bind() has dropped cb_lock. Consider this
order of events, all before the bound_gen read:

- family A is bound
- A is unregistered, and
  genl_unregister_mc_groups()->__netlink_clear_multicast_users() bumps
  mc_gen
- family B registers and gets the same group ID

In that case gen differs from the current value, but bound_gen matches
it.

genl_unbind() looks up the current owner of the group, so B->unbind() is
called. The retry then calls B->bind(). A later NETLINK_DROP_MEMBERSHIP or
close calls B->unbind() again, so B sees two unbinds for one bind.

netlink_bind() behaves the same way. The group is not set in gone, so it
gets unbound through:

	netlink_undo_bind(BITS_PER_TYPE(u32), groups & ~gone, sk);

A family that refcounts in its bind/unbind callbacks would see its count
go below zero.

The commit message documents this limitation: "if a family is
unregistered and another one registers just after ->netlink_bind()
returned, and before the second read, the new family gets an unbind
without a bind". In-tree, only thermal has these callbacks, and it is
never unregistered at runtime.

Is this acceptable for out-of-tree or future families with refcounting
bind/unbind callbacks?

[ ... ]

> @@ -2079,6 +2140,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
>  		nl_table[unit].registered = 1;
>  	} else {
>  		kfree(listeners);
> +		kfree(mc_gen);
>  		nl_table[unit].registered++;
>  	}

[Severity: Low]
Does nl_table[NETLINK_USERSOCK] end up with a NULL mc_gen?

netlink_add_usersock_entry() sets groups, listeners, module, flags and
registered = 1 for NETLINK_USERSOCK, but it doesn't allocate mc_gen.

A later kernel socket on NETLINK_USERSOCK takes this else branch, because
registered is already set. It frees its own mc_gen without installing it.

__netlink_change_ngroups() and __netlink_clear_multicast_users() then
dereference tbl->mc_gen without a check:

	memcpy(mc_gen, tbl->mc_gen, tbl->groups * sizeof(*mc_gen));

	tbl->mc_gen[group - 1]++;

In-tree, both helpers are only called from genetlink with
net->genl_sock. USERSOCK has no ->bind, so the new mc_gen reads in
netlink_bind() and netlink_setsockopt() are not reached for it either.

Should netlink_add_usersock_entry() also allocate mc_gen, so that every
registered table has one?

[ ... ]

> @@ -2113,6 +2176,17 @@ int __netlink_change_ngroups(struct sock *sk, unsigned int groups)
>  	if (groups < 32)
>  		groups = 32;
>  
> +	if (tbl->groups < groups) {
> +		unsigned int *mc_gen;
> +
> +		mc_gen = kcalloc(groups, sizeof(*mc_gen), GFP_ATOMIC);
> +		if (!mc_gen)
> +			return -ENOMEM;
> +		memcpy(mc_gen, tbl->mc_gen, tbl->groups * sizeof(*mc_gen));
> +		kfree(tbl->mc_gen);
> +		tbl->mc_gen = mc_gen;
> +	}

[Severity: Low]
Does this still work if the number of groups is reduced? The kernel-doc
of netlink_change_ngroups() says:

 * change the number of groups to below 32. Also note that it does
 * not implicitly clear listeners from groups that are removed when
 * the number of groups is reduced.

A shrink lowers tbl->groups and keeps the existing mc_gen. Existing
sockets keep their larger nlk->ngroups, because netlink_realloc_groups()
only grows.

For example, take a table with 64 groups and a socket with
ngroups = 64. If the table shrinks to 32 and then grows to 48, mc_gen
is a 48-entry array and entries 32..47 are reset to 0.

netlink_setsockopt() bounds val only by nlk->ngroups:

	if (!val || val - 1 >= nlk->ngroups)
		return -EINVAL;
	...
	gen = tbl->mc_gen[val - 1];

So NETLINK_ADD_MEMBERSHIP with val = 60 would read past the end of
tbl->mc_gen[]. The reset entries could also make a released group look
unchanged, which would skip the new check.

In-tree, genl_validate_assign_mc_groups() is the only caller, and it only
grows the count, so this can't be reached today.

Should mc_gen be sized from the largest group count ever used? The other
option would be to remove the mention of shrinking from the kernel-doc.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102155819.4100930-1-anilkaushikwireless%40gmail.com
