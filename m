Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614459;
	b=zsYqnjmnpKqIFWNkuRLce/2Ok6cRe5waK+1apLvnhc4SPOD1lmjfwhh2ebRKTpuazmz7
	 X6JK87qv2rWacQYjt3JHjtqnWdfSSD3EE9lecwhkuVZAg26qMpxF4TyplN5k/1tLlhEgu
	 2nuCJGR7orHI+pHM1HNkySWHrRBzAA09a+ntO1+BHzmYnKMY78darh09AKXCoq3919674
	 ghWmh0375UohTy4a3xo4QR+XsUstH0EpU6OcbpybT+Rcz6YMVMI8W+KIsEkjysP2tPtie
	 0+k6zUwioZVIdhl0Ijv0jm8QTPgz4ka24ZPG29rx6K5R2fh38LYGWwDXRf1hjATqH3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614459;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6g3U2uJY8a/P+cNokfOBryzMcTZ+NO/RP2UYQ6Mk0Pg=;
	b=1cz/NE9ibwhqaGTgLTAdjSRZUy5ItJAgIDqkuEgU+bHnPqEW/XBWuM7bMrfHwXk7/OJw
	 xFA/U1tetFbOH+nQNgyNu1nYrblylrJFsbgQAhpko+hewQZmR/p8zJ10nf5VLwdBAeN5U
	 DTXc6qZFPvoePKD53QTx78W3pef2Ir+M2BBAGTeVUs/FWMA5kpzCn5GNorFrZFpKTWJmL
	 b3ntnwEP2WXn3FZi/vEoHx9OzLXn9MUBWV9GMSu9D5o3IrySSK50R0BTWG/Fg2R1YRQ6j
	 v9X3K+com6T1xZ0aaIa9B6lQVpl8qX0Y1cv8tzW0+NhLWxU8cnMBqavLYPxBtxmY7dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnNBxvMs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202C606A32C;
	Mon,  2 Nov 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnNBxvMs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4F41F000C1;
	Mon,  2 Nov 2026 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614458;
	bh=6g3U2uJY8a/P+cNokfOBryzMcTZ+NO/RP2UYQ6Mk0Pg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UnNBxvMsv05RshcKnNVtXFCK7gct3d3Pw85g9n97ixS0rwiTcq1rSj66NlV8amp7f
	 keG85sf9CScz/Qk7FGdFkCFufZTB06knGKmu5RRI7/OHKRWuC+IVba09n9s3FdA7fa
	 kcELw3KY0zq914dy2z4viy0dIK4nMVqQ1U0eDP2skJzgc089IE+VuDaM80GJqV2W7n
	 xqD1LlVlPe/3EgigfIrtpZkCLw95LmZWwnZGVp55EmUACo9Zi/rAWO1dR+LAA/KRJC
	 vxZheg1r7Cx3fkK3IKfoWfLs5OSJ5EqJPUCjUwGG0fcaKrbPU6F4n3v2BP5GzVC/Kb
	 j4127fBL/cH3Q==
Subject: Re: [PATCH net v3 2/2] netlink: Check a group again if it was
 released while joining it
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 fw@strlen.de, martineau@kernel.org, v3rdant.xiang@gmail.com,
 aliceryhl@google.com, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 10:14:16 +0000
Message-ID: <179361445689.3131.16967458421412747758@kernel.org>
In-Reply-To: <20261101101347.3910654-3-anilkaushikwireless@gmail.com>
References: <20261101101347.3910654-3-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new retry path assumes that if a group's generation
  changed, the earlier ->netlink_bind() call was checked against the old…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a high-
  severity deadlock in the function the patch changes.

--

netlink: Check a group again if it was released while joining it

This adds a per-group generation counter, mc_gen, to the netlink table.
__netlink_clear_multicast_users() bumps the counter. netlink_bind() and
netlink_setsockopt(NETLINK_ADD_MEMBERSHIP) read it before
->netlink_bind() and compare it again once the table is grabbed. If the
counter changed, the group is re-checked against its current owner
without calling ->netlink_unbind().

Link: https://lore.kernel.org/netdev/179340003139.3131.11274717768928642724@kernel.org/

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 1281c42a3456a..08f89503f4073 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c

[ ... ]

> @@ -1057,6 +1066,22 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
>  	netlink_unlock_table();
>  
>  	netlink_table_grab();
> +	if (nlk->netlink_bind && groups) {
> +		unsigned long released = 0;
> +		int group;
> +
> +		for_each_set_bit(group, &groups, BITS_PER_TYPE(u32))
> +			if (gen[group] != tbl->mc_gen[group])
> +				__set_bit(group, &released);
> +		/* see netlink_setsockopt(), undo the others and retry all */
> +		if (released) {
> +			netlink_table_ungrab();
> +			netlink_undo_bind(BITS_PER_TYPE(u32), groups & ~released,
> +					  sk);
> +			bound = true;
> +			goto retry;
> +		}
> +	}

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. The new
retry path calls netlink_table_ungrab() before netlink_undo_bind().
However, the older insert-failure path earlier in netlink_bind() still
calls netlink_undo_bind() while netlink_lock_table() is held:

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

On NETLINK_GENERIC sockets, netlink_undo_bind() ends up in genl_unbind().
genl_unbind() does down_read(&cb_lock) while nl_table_users is still
raised.

Can this deadlock against genl family unregistration?

CPU0 in netlink_bind():
  netlink_lock_table()                /* nl_table_users++ */
  netlink_insert() returns -EADDRINUSE
  netlink_undo_bind()
    genl_unbind()
      down_read(&cb_lock)             /* waits for CPU1 */

CPU1 in genl_unregister_family():
  genl_lock_all()                     /* down_write(&cb_lock) */
  genl_unregister_mc_groups()
    netlink_table_grab()              /* waits for nl_table_users == 0 */

genl_register_family() has the same shape. It calls netlink_table_grab()
from genl_validate_assign_mc_groups(), or goes through
netlink_change_ngroups(), while holding cb_lock for write.

genl_pernet_init() sets NL_CFG_F_NONROOT_RECV, so an unprivileged bind()
can reach CPU0's side. It needs nl_groups != 0 and an nl_pid that
another socket already owns. lockdep won't flag this, because
nl_table_users is a plain atomic counter.

The comment in netlink_release() already warns about this ordering:

    /* must not acquire netlink_table_lock in any way again before unbind
     * and notifying genetlink is done as otherwise it might deadlock
     */

[ ... ]

> @@ -1695,12 +1722,25 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
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
>  		}
>  		netlink_table_grab();
> +		/* The group was released after ->netlink_bind() checked it, and
> +		 * may have a new owner now. The old one is gone, so check the
> +		 * group again without ->netlink_unbind().
> +		 */
> +		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind &&
> +		    gen != tbl->mc_gen[val - 1]) {
> +			netlink_table_ungrab();
> +			goto retry;
> +		}

[Severity: Medium]
Is the assumption in this comment always true? gen is read and the table
lock is dropped before ->netlink_bind() runs. genl_bind() picks the
owning family only later, under down_read(&cb_lock).

Both of these can complete in that gap:

  genl_unregister_family(old)
    genl_unregister_mc_groups()
      __netlink_clear_multicast_users()   /* mc_gen[val - 1]++ */
      clear_bit(grp_id, mc_groups)
  genl_register_family(new)
    genl_allocate_reserve_groups()        /* hands out the same grp_id */

genl_bind() then finds the new family in genl_fam_idr and calls
family->bind(i) for it. Back under netlink_table_grab(),
gen != tbl->mc_gen[val - 1] is true. The code jumps to retry without
calling ->netlink_unbind(), and genl_bind() calls the new family's
->bind(i) a second time.

Only one membership bit gets set. A later NETLINK_DROP_MEMBERSHIP or
netlink_release() therefore calls genl_unbind() -> family->unbind(i)
only once. Doesn't that leave the new owner with two bind calls and one
unbind?

netlink_bind() does the same thing. It does memcpy(gen, tbl->mc_gen,
sizeof(gen)) before the bind loop. Groups in released are then left out
of netlink_undo_bind(..., groups & ~released, sk) and bound again on
retry.

A stateful .bind would stay unbalanced. For example, intel_hfi.c does:

    if (++hfi_clients_nr == 1)
        func = hfi_enable_instance;

and only disables the instance when the count drops back to 0.

In-tree, thermal_genl_family is the only genl family with a .bind
callback. It is registered from __init thermal_netlink_init() and never
unregistered, so this looks latent today. Still, "The old one is gone"
does not hold when the release finishes before genl_bind() takes
cb_lock.

Would it work to read the generation again right after ->netlink_bind()
returns? ->netlink_unbind() could then be called before retrying when
that post-bind value matches the current one.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101101347.3910654-1-anilkaushikwireless%40gmail.com
