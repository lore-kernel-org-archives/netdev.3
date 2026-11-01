Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515121;
	b=VnD1Dr78t99axv7NN7Ckho409eMs1FoXI/kTjdc7PQ36VEk74pmtFZY76U0koDGbAAIq
	 Bj9gTYk/Ket0C7Q1hGP/KgmeZZ3cMVp0bLmyWf4qCEfRXG9n+O11Dx9QlIl3i1tdrQWmB
	 053n30ZQE4GvzCiyCcwNmSbxfQzzj2OjxI4p/cyoeEW8NuO2CXsX8eSzxRVsyEkAax33M
	 BOhgx3fAv+vQsq82VH6kp+5FuykSay5wP+KJoVAt/oSmHu1+ogf+u+RdtTm9eUN6YV/lh
	 +zViVwJnlInmq6HU+WSLkItM7q3evyhV+gA3CGzHgMfuwp8nFqWVI98CMM9hE34owrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515121;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xEx6KXXFbzXrnbcv06awCSsc3zA2sdbZa+JhwWXPQ8w=;
	b=GRUHhYHQm75PPULPt2tmAfq13CLd1+okQJ1hm+dsXr81fjoWgtR8Nn/Y3X8Aq4OQvUwh
	 fT346803pTKEMX+25Q0k58ejcHOaD+ipUSrt1JSadmn4X/XojU8I0QlKrMgQnZmiWvAr7
	 p3GXz6ZmfQViHEAU0oUdMu2fgRZl8aMshRIC3n+bovgAj1nAH9j9l3v4Ka7auTDSznLWs
	 iKUX0xFxH1KzRPZVBlE2wr3PGx0ztewIUeomPXsSI+GvbOUK0QZX1oWk7gg5f6tm4276/
	 TN2NlbgHq+2J5yIijhRYck8qi6/R9gRn1/Zp2/mkTQcDkaeSeCRU9TKoSFsov3mpPaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/EXKWd6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D22606A32F;
	Sun,  1 Nov 2026 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/EXKWd6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120091F00919;
	Sun,  1 Nov 2026 06:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793515120;
	bh=xEx6KXXFbzXrnbcv06awCSsc3zA2sdbZa+JhwWXPQ8w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J/EXKWd6LxmBXpCwuG2UAP7bB7vKj5NIbuHBZ79tZ0/6L6ENlO34m6HJzSTvIPrXX
	 L179zvJkdHjcI0zKSuEYBvz0IztlIsQuUgVgQ3UE7EA2TuuhIb9ovB88C36xruSayh
	 /uglpYeOYOsSJ44b/ZpoYNbR6g5KAbV/muXCm0GlrSCDb0aOZ2xV0bUi1N9Iu6eaFY
	 2zuP/M0QYFH2Mz1LQGnVG+9ODMpKcOw8+VvDrqubP1Ucva/oAR8BWnIx/71gKVeg97
	 aBXq9/43Mq9NN0ok6ya8RnL9SMXU356Zrxb+1U1GelyObbkyhUKLOIOddKeDOwV59f
	 C95biWUaWYVAw==
Subject: Re: [PATCH net v2 2/2] genetlink: Clear stale members when assigning
 multicast group IDs
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 v3rdant.xiang@gmail.com, aliceryhl@google.com, linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 06:38:39 +0000
Message-ID: <179351511962.3131.986738338881011560@kernel.org>
In-Reply-To: <20261031054632.3697295-3-anilkaushikwireless@gmail.com>
References: <20261031054632.3697295-3-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the check-then-set race the commit
  message describes can still be reached.
- [High] The patch puts the expensive multicast-clear walk on every
  family registration after boot, and unprivileged users can trigger…
- [Medium] The new registration-time genl_clear_mc_users() assumes nobody
  can legitimately be a member of the IDs being assigned.
- [Low] The Fixes: tag points at e03781879a0d ("drop_monitor: Require
  'CAP_SYS_ADMIN' when joining "events" group", Dec 2023), but the race…

--

genetlink: Clear stale members when assigning multicast group IDs

This patch moves the multicast member clearing loop out of
genl_unregister_mc_groups() into a new genl_clear_mc_users() helper. It
also calls the helper from genl_validate_assign_mc_groups() once a family
has been given its group IDs. The goal is to drop sockets that became
members of a group ID while no family owned it, so a later owner's
GENL_MCAST_CAP_* flags can't be bypassed.

Link: https://lore.kernel.org/netdev/179340003139.3131.11274717768928642724@kernel.org/

> Fixes: e03781879a0d ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group")

[Severity: Low]
Is e03781879a0d the right commit for this tag?

git blame of genl_bind() attributes the function, the idr walk under
cb_lock and the ns_capable(CAP_NET_ADMIN) check to 4d54cc32112d ("mptcp:
avoid lock_fast usage in accept path"), from v5.12. That commit added
genl_bind() as the genl socket's .bind callback. It already had the same
structure: check under the lock, set the bit later.

e03781879a0d only added the second check, for CAP_SYS_ADMIN:

	if ((grp->flags & GENL_MCAST_CAP_SYS_ADMIN) &&
	    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
		ret = -EPERM;

The race in the commit message applies just as much to CAP_NET_ADMIN
groups, such as the MPTCP PM events group.

With the current tag, could stable trees that have 4d54cc32112d but not
e03781879a0d (or its backport) miss this fix? That depends on stable
backport history, which wasn't checked here.

> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index f038f04ef4ead..0ddebd8285853 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -452,6 +452,22 @@ static int genl_allocate_reserve_groups(int n_groups, int *first_id)
>  
>  static struct genl_family genl_ctrl;
>  
> +static void genl_clear_mc_users(const struct genl_family *family)
> +{
> +	struct net *net;
> +	int i;
> +
> +	netlink_table_grab();
> +	rcu_read_lock();
> +	for_each_net_rcu(net) {
> +		for (i = 0; i < family->n_mcgrps; i++)
> +			__netlink_clear_multicast_users(net->genl_sock,
> +							family->mcgrp_offset + i);
> +	}

[Severity: High]
With this patch, can an unprivileged user drive this walk while IRQs are
disabled?

netlink_table_grab() is write_lock_irq(&nl_table_lock).
__netlink_clear_multicast_users() only uses ksk->sk_protocol, so each
call walks the global list, which holds sockets from every namespace:

net/netlink/af_netlink.c:__netlink_clear_multicast_users() {
	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
	...
	sk_for_each_bound_safe(sk, tmp, &tbl->mc_list) {
		...
		netlink_update_socket_mc(nlk_sk(sk), group, 0);
	}
}

So the for_each_net_rcu() loop repeats the same full mc_list walk once
per netns.

netlink_update_socket_mc() is called even when the bit isn't set. It
always calls netlink_update_listeners(), which walks mc_list again:

net/netlink/af_netlink.c:netlink_update_listeners() {
	for (i = 0; i < NLGRPLONGS(tbl->groups); i++) {
		mask = 0;
		sk_for_each_bound(sk, &tbl->mc_list) {
	...
}

That makes each call roughly O(netns * n_mcgrps * sockets^2), with IRQs
off and cb_lock held for writing.

Before this patch, the walk only ran when a family was unregistered
(module unload). The new call in genl_validate_assign_mc_groups() runs it
on every registration after boot, and an unprivileged user can trigger a
registration:

ctrl_getfamily()
  request_module("net-pf-%d-proto-%d-family-%s", ...)
    genl_register_family()
      genl_validate_assign_mc_groups()
        genl_clear_mc_users()

The same user can put many NETLINK_GENERIC sockets on mc_list by joining
the nlctrl "notify" group. They can also create many namespaces through
user namespaces.

Could one autoloaded registration then hold nl_table_lock with IRQs off
long enough to fire hardlockup or RCU stall warnings and stall netlink
across the whole system?

> +	rcu_read_unlock();
> +	netlink_table_ungrab();
> +}
> +
>  static int genl_validate_assign_mc_groups(struct genl_family *family)
>  {
>  	int first_id;
> @@ -527,23 +543,18 @@ static int genl_validate_assign_mc_groups(struct genl_family *family)
>  			clear_bit(family->mcgrp_offset + i, mc_groups);
>  	}
>  
> +	/* drop sockets that joined the IDs while no family owned them */
> +	if (!err)
> +		genl_clear_mc_users(family);

[Severity: High]
Does this fully close the race described in the commit message?

genl_bind() checks the GENL_MCAST_CAP_* flags of whichever family owns the
group ID at that moment, then drops cb_lock and returns. The bit is set
later, in a separate critical section, and nothing checks the owner
again:

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

netlink_bind() has a wider window. It also goes through netlink_insert()
(lock_sock) and a netlink_table_grab() that can sleep before it writes
nlk->groups[0].

The new clear runs once, at registration, and can only drop bits that are
already set. Is this sequence still possible?

CPU1 (unprivileged)              CPU2
netlink_setsockopt()
  genl_bind(X)
    family A owns X, no caps
    up_read(&cb_lock)
                                 genl_unregister_family(A)
                                   genl_clear_mc_users()
                                     /* CPU1 not a member yet */
                                   clear_bit(X, mc_groups)
                                 genl_register_family(B)
                                   /* B gets X, CAP_NET_ADMIN group */
                                   genl_clear_mc_users()
                                     /* nothing to drop */
  netlink_table_grab()
  netlink_update_socket_mc(nlk, X, 1)

CPU1 is then a member of B's capability-protected group, and B's flags
were never checked. do_one_broadcast() delivers B's multicasts to it.

The unprivileged user can trigger B's registration through
ctrl_getfamily()->request_module(). Families with such groups include
gtp, mptcp_pm, psample, ioam6 and the smb client.

This also has a side effect. B->bind() never ran for this socket, but
genl_unbind() will call B->unbind() on NETLINK_DROP_MEMBERSHIP or from
netlink_release(). Could that unbalance families that count listeners in
bind/unbind, such as drivers/thermal/thermal_netlink.c?

The commit message says:

    No socket can be a valid member at that point: cb_lock is held for
    writing, so genl_bind() cannot see the new family yet.

That covers sockets that haven't called genl_bind() yet. It doesn't cover
a socket that already passed the check and released cb_lock.

The window is smaller now, because both the unregister and the
re-register have to land inside it. It still doesn't look closed.

Would it work better to make the check and the bit set atomic with
respect to group reassignment? Some options:

- set the bit before calling ->netlink_bind() and roll back on error
- check the owner again under netlink_table_grab()
- record a generation counter in genl_bind() and check it again before
  setting the bit

[Severity: Medium]
When pmcraid is reloaded, can this call unsubscribe the legitimate
listeners of another family that is still registered?

The fixed-ID branch for pmcraid doesn't check or reserve mc_groups:

	} else if (family->id == GENL_ID_PMCRAID) {
		first_id = GENL_ID_PMCRAID;
		BUG_ON(n_groups != 1);

mc_group_start reserves BIT(GENL_ID_PMCRAID) statically, but
genl_unregister_mc_groups() frees the ID on unload:

		if (grp_id != 1)
			clear_bit(grp_id, mc_groups);

So this sequence looks possible:

rmmod pmcraid
  pmcraid_exit()->pmcraid_netlink_release()->genl_unregister_family()
    clear_bit(GENL_ID_PMCRAID, mc_groups)
another family with mcgrps registers
  genl_allocate_reserve_groups() hands out GENL_ID_PMCRAID
  users join that group through genl_bind()
modprobe pmcraid
  genl_register_family() forces family->id = GENL_ID_PMCRAID
  genl_validate_assign_mc_groups()
    first_id = GENL_ID_PMCRAID, no ownership check
    genl_clear_mc_users()
      clears every member of the other family's group

The ID overlap itself predates this patch, but registration never touched
other sockets' membership before. With this call, the other family's
listeners would silently stop getting its notifications.

> +
>  	return err;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031054632.3697295-1-anilkaushikwireless%40gmail.com
