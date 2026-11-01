Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503823;
	b=fbYs932siKg/2u/gJXWtn/fARfuXeoaS1SUpSIAf+2HMzAlQDmvhbV3kDf0kr/6Jyn4h
	 rSvRe8TFXlYB4ZOV6B5HVAuxO8UrkbV6+4uGLoIO3G3QFe0cBmCoHAsaau53gQXzSHt7h
	 gSKxL8jhkCsKEF4uzOWvNyFa8/QgGt3bXuzjYQvVDT7HMXRQovt5zYJjL9/f+2yjOKYLe
	 UdR14nr6CeOEzWTnfB9zn33dN2MmQxVc/MyRtSHuoXLuru14BfOx1W3qc6MVnjQl1cD+1
	 FRaEZOSuE5MscdCaIcZHLv0GtrfQusbzUOfbKOic3tt+mfFL/1cOUpHKyzSqwFZMBTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503823;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wCdPkflhEU9sU5axLHNNuojDifxFhwUNXqSS9UrOVak=;
	b=3EXvzaQS1zpvIz+qx/pS9xxQFcmoKihEfH6t5nfZjEShpYiqqmOPJNXvCuWGc2NdREV6
	 nRrH0rdMoZ4A6AJQydxy8bmyDBSIRglPZro5SGHDUx0qO60kxL7e+OVMqCeJs9KXnlW4L
	 T5NDrt1PzQqtKzKwmAEk+fHA1IcA7HMLsPnrZckovC669vaM2W1dGKkO1yv8X7rRBU9MP
	 zdhI4HAyFK0Wf8L4+TmHDqXGYajKxWBMef6hHuk6J2iZF8A76GnUVVd22MpVskIF6U4f5
	 HaDqmKMWfjomkXUjpO8qbHeQ/ECnaM6ccw6SQz3ZNrY67gt57jyKFA228oFbHh4mGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtFH3sjy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166B606A32C;
	Sun,  1 Nov 2026 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtFH3sjy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C671F00919;
	Sun,  1 Nov 2026 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793503823;
	bh=wCdPkflhEU9sU5axLHNNuojDifxFhwUNXqSS9UrOVak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MtFH3sjy5D4lJRXjSBgjnRHLxfP2gtKRi2ArhCw2uN01+oIIVbPpHUxOPKrGUELYx
	 x6m5r1i7xrupxcwm3Xpk65hcd6UkMzKewuxfKVsEgUnCEu1/uCrw0wIcN7ensCz3aZ
	 6akUrO39ahv8LmIk14gAylCcBjJv4UL25XFcvtk01w4JhyqPLbQ+En2IescfwZw1Ou
	 SWzVDTz2ok1K15ZU9ntdFj6YN8uhGMav9YMlDk8VzomG7bNTeR65WVFXX+Wtd9RgGa
	 2SzdeibSWinWb2hr4RP9EC7oMqyuI8x7FvK987Mm+fDvW46ENWy+B53GG0o3Acxvjl
	 UljOkmsXtg8Sw==
Subject: Re: [PATCH ipsec v2 1/2] xfrm: protect offload statistics updates
 from device teardown
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 antony.antony@secunet.com, baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Sun, 01 Nov 2026 03:30:21 +0000
Message-ID: <179350382176.3131.14655147419075234781@kernel.org>
In-Reply-To:
 <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-1@gmail.com>
References:
 <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-1@gmail.com>
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

- [High] The fix depends on the claim that 'Every path that frees the
  offload state of a reachable SA marks the SA dead under x->lock first'…
- [High] xfrm_add_sa() can overwrite XFRM_STATE_DEAD with VALID without
  holding a lock, which defeats the new DEAD check in the NEWSA…
- [Medium] The new `x->km.state != XFRM_STATE_DEAD` check in
  copy_to_user_state() (net/xfrm/xfrm_user.c:1186) also skips the last…
- [Low] The Assisted-by tag is not part of the commit message, so the AI-
  assistance disclosure will be lost.

--

xfrm: protect offload statistics updates from device teardown

This patch skips the driver offload statistics refresh in
copy_to_user_state() for SAs in XFRM_STATE_DEAD. It also takes x->lock
around the copy in xfrm_state_netlink() and xfrm_notify_sa(). The expiry
timer now checks for a dead state before refreshing the statistics.

> Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> Assisted-by: LLM

[Severity: Low]
This isn't a bug, but the Assisted-by: tag is below the --- separator.
git am will drop it, and the applied commit ends at Signed-off-by: with
no Assisted-by: line.

Could it move into the trailer block next to Fixes: and Signed-off-by:?
That is where Documentation/process/submitting-patches.rst and
Documentation/process/coding-assistants.rst ask for it.

[ ... ]

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index a5fbe38839c49..781d4ec565aae 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1179,7 +1179,11 @@ static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
>  	memcpy(&p->id, &x->id, sizeof(p->id));
>  	memcpy(&p->sel, &x->sel, sizeof(p->sel));
>  	memcpy(&p->lft, &x->lft, sizeof(p->lft));
> -	if (x->xso.dev)
> +	/* Device teardown marks the state dead under x->lock before it frees
> +	 * the offload state. Callers hold x->lock, or xfrm_state_lock while
> +	 * the state is still linked.
> +	 */

[Severity: High]
The commit message says:

  Every path that frees the offload state of a reachable SA marks the SA
  dead under x->lock first.

and:

  Dumps run under xfrm_state_lock while the SA is still linked, and
  deletion needs that lock before the offload state can be freed.

Does bonding failover follow this rule? bond_change_active_slave() calls
bond_ipsec_del_sa_all(). That function walks the linked, non-dead SAs on
bond->ipsec_list and does:

drivers/net/bonding/bond_main.c:bond_ipsec_del_sa_all() {
    ...
		spin_lock_bh(&ipsec->xs->lock);
		ipsec->xs->xso.real_dev = NULL;
		/* Don't double delete states killed by the user. */
		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
								    ipsec->xs);
		spin_unlock_bh(&ipsec->xs->lock);

		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
								  ipsec->xs);
    ...
}

On this path the SA is never marked dead and xfrm_state_lock is never
taken. The slave's xdo_dev_state_free() runs with no lock held. For mlx5
that is mlx5e_xfrm_free_state(), which destroys the rules and counters and
frees sa_entry.

At the same time, a dump holds only xfrm_state_lock:

xfrm_dump_sa()
  xfrm_state_walk()              /* xfrm_state_lock held */
    dump_one_state()
      copy_to_user_state()       /* xso.dev is the bond, state VALID */
        bond_xfrm_update_stats()
          bond_ipsec_dev()       /* plain read of xso.real_dev, RCU only */
          mlx5e_xfrm_update_stats()

Suppose bond_ipsec_dev() reads real_dev before it is cleared. Can
mlx5e_xfrm_update_stats() then dereference sa_entry and ipsec_rule->fc
while bond_ipsec_del_sa_all() frees them?

xfrm_state_update_stats() also calls the driver refresh with only
xfrm_state_lock held. It serves /proc/net/xfrm_stat (mode 0444) and has no
dead check at all.

This window existed before the patch. However, the commit message and the
new comment say the bug class is closed for dumps. Should the dump paths
be covered too, or should the comment and commit message claim less?

> +	if (x->xso.dev && x->km.state != XFRM_STATE_DEAD)
>  		xfrm_dev_state_update_stats(x);

[Severity: Medium]
Does this also drop the last hardware counter read when an SA is deleted
normally, with no race?

xfrm_del_sa()
  xfrm_state_delete()
    __xfrm_state_delete()        /* sets XFRM_STATE_DEAD */
      xfrm_dev_state_delete()
  km_state_notify()
    xfrm_notify_sa()
      copy_to_user_state_extra()
        copy_to_user_state()     /* now skips the refresh */

For mlx5, xdo_dev_state_delete is mlx5e_xfrm_del_state(), which only
removes the sadb entry with xa_erase_bh(). The flow rules and counters
stay allocated until mlx5e_xfrm_free_state() runs from
xfrm_dev_state_free(). xfrm_del_sa() still holds its lookup reference
during the notify. So the read before this patch looks safe.

With packet offload, curlft is only updated by this driver callback.
After this change, the XFRM_MSG_DELSA notification reports
curlft.packets, curlft.bytes, stats.replay and stats.integrity_failed
from the last refresh. So do hard expire notifications for XFRM_MSG_EXPIRE
requests from userspace.

That last refresh may be old, because the timer only runs for time-based
lifetimes. The LINUX_MIB_XFRMIN* increments since then are also lost.
Nothing reads the counters again before xdo_dev_state_free() destroys
them.

The commit message says "A dead SA keeps the counters from its last
refresh." Would it work to read the counters once under x->lock in
__xfrm_state_delete()? That would be before the SA is marked dead and
before xfrm_dev_state_delete(), while the offload state is known to be
alive.

>  	memcpy(&p->curlft, &x->curlft, sizeof(p->curlft));
>  	put_unaligned(x->stats.replay_window, &p->stats.replay_window);

[ ... ]

> @@ -4167,7 +4173,9 @@ static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
>  
>  		p = nla_data(attr);
>  	}
> +	spin_lock_bh(&x->lock);
>  	err = copy_to_user_state_extra(x, p, skb);
> +	spin_unlock_bh(&x->lock);

[Severity: High]
Can xfrm_add_sa() overwrite a concurrent dead transition before this
notification runs?

xfrm_state_construct() uses __xfrm_init_state(). So the new SA is still
XFRM_STATE_VOID when xfrm_state_add() links it into state_bydst. If
XFRMA_OFFLOAD_DEV was given, xso.dev is already set at that point.

xfrm_add_sa() then does this without x->lock:

net/xfrm/xfrm_user.c:xfrm_add_sa() {
    ...
	if (x->km.state == XFRM_STATE_VOID)
		x->km.state = XFRM_STATE_VALID;
    ...
	km_state_notify(x, &c);
    ...
}

A possible sequence:

CPU A (XFRM_MSG_NEWSA)           CPU B (NETDEV_DOWN/UNREGISTER)
reads km.state == VOID
                                 xfrm_dev_state_flush()
                                   xfrm_state_delete(x)   /* DEAD */
                                   xfrm_dev_state_free(x)
                                     xdo_dev_state_free()
km.state = XFRM_STATE_VALID
km_state_notify()
  xfrm_notify_sa()
    spin_lock_bh(&x->lock)
    copy_to_user_state()
      xfrm_dev_state_update_stats()

xfrm_dev_state_free() calls xdo_dev_state_free() without x->lock, and
before WRITE_ONCE(xso->dev, NULL). So copy_to_user_state() can see
xso.dev set on a state that is no longer dead. For mlx5, that would run
mlx5e_xfrm_update_stats() on an sa_entry that mlx5e_xfrm_free_state() is
freeing.

The unlocked store existed before this patch. Still, the guarantee that
"a refresh either completes before the teardown or sees the dead state"
depends on it. Should xfrm_add_sa() change VOID to VALID under x->lock,
and leave the state alone if it is already dead?

>  	if (err)
>  		goto out_free_skb;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0%40gmail.com
