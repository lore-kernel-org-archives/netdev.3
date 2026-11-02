Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793590161;
	b=eBWzLYfbS5DMfhI84VnSS+5q8Kh9b6f4tdTOSLV8hQHuU4y3vsVzHQeRAxjIKjfxFDTr
	 qEOTTPhJdB3N3vHBU60dMwdPzwDdU7Ya3g+ajE5qTokmBasWJR+qwEXHots9OOFxWUe59
	 kOYOtf8s6RjeLEZTwZow6OiLKYBslb8dQgI8iAI66icdeJgZ0Qmmt8R7dQ3DwRFmJJ5QD
	 +XZ2M5GM/5xRCzj9Dbf2mwoQbjXQZJa2p4LU93rHBx1mP5RywlDHIBwLY+HlmtHFQkZCe
	 Tcyo7SpRL0VGEGmL/VttgFLTN1T6jzZ6BERyOH9+k8IPSKYVSBqphmABf56M5fLuQSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793590161;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CxVfMchF5dsGBfGJzosZhBQYD88YqP9n06Re6kC/c6E=;
	b=lyT9LF/JP5cOpq6BhKlxZS5zYwiDZZg8QF2WK24A9aAEreSYDK8l3w9gRN64vaUcYtJ8
	 to3Ay7sMBM1MEUUBfoUmAfVfVrCPe8ZFEpyRjA7289hRrml9MH+eNuixGZ9DqJGqKmKpC
	 ZjTEw597CeYB1pko5646hWpSia0ammaCgZnEYiiNwKMir0Y8s9iWKKE3/AsZ4WfI8Wdwo
	 OhOpysAMqFscW7xyFuY+y+Ykx8Pq3lkeRXo79zJK6F7Cco4KBPv3p6aw802txCxqGagql
	 TMgL8GTZqidIasfnrSZhI+PWIB2UQsyJFEeL/nGeaIpCtmkP3XxBovB0NamiX85DRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGjKclDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FA606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGjKclDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E2B1F000C1;
	Mon,  2 Nov 2026 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793590161;
	bh=CxVfMchF5dsGBfGJzosZhBQYD88YqP9n06Re6kC/c6E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KGjKclDunLmyO7iL8O4lyI/Fsbc8N9QhhBWaDSJ61perp8DgmhUJn+EacCn8PPeMU
	 6bNRBMErYwlPOCc+hebW4v2+F5Is8n2lzTQiYwvseLxKWvLLNxCaUvKUt4lgAgh6cd
	 N4YtSsbe87gzTwzO+6cinvKSXfy2ApY6KIBwXtWW5OYtj99na/vtvQ6U3rMIUZaDaT
	 291fybWrzt4W9TJwS52K+QUk3ghURRrgP9jEHRsNjoPbqLYjtg493EKPUe/2or1zTe
	 o/JlxtsT25aQ3d/8rKA1P9212v7fXziSRw7eAY3cjz0H5gY1Xzdz0KqUdtm0Cfz2ax
	 02wBdgcQC195A==
Subject:
 Re: [PATCH ipsec] xfrm: protect offload statistics device access with RCU
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, baijiaju1990@gmail.com,
 jjzuming@gmail.com, kuba@kernel.org
Date: Mon, 02 Nov 2026 03:29:20 +0000
Message-ID: <179359016018.3131.9644618161410466770@kernel.org>
In-Reply-To:
 <pm-xfrm-core-objects-candidate-0050-v3-dbfb7194ffb750193d02@gmail.com>
References:
 <pm-xfrm-core-objects-candidate-0050-v3-dbfb7194ffb750193d02@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On real offload hardware, the new RCU section does not close the
  GETSA/dump vs. device-teardown use-after-free that the commit says it…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  xfrm_do_migrate_state() (net/xfrm/xfrm_user.c:3462-3463) has the same…
- [Low] This problem wasn't introduced by this patch, but the guard `if
  (x->xso.dev)` in copy_to_user_state() (net/xfrm/xfrm_user.c:1184) is a…

--

xfrm: protect offload statistics device access with RCU

This patch wraps the xfrm_dev_state_update_stats() call in
copy_to_user_state() in an RCU read-side critical section. The goal is to
keep the offload net_device alive while GETSA or a dump reads its
xfrmdev_ops. The commit message relies on synchronize_net() during netdevice
unregistration to order the device free after any reader that sampled the
old xso.dev binding.

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index a5fbe38839c49..e9dd98c387da9 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1179,8 +1179,11 @@ static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
>  	memcpy(&p->id, &x->id, sizeof(p->id));
>  	memcpy(&p->sel, &x->sel, sizeof(p->sel));
>  	memcpy(&p->lft, &x->lft, sizeof(p->lft));
> +	/* Pairs with synchronize_net() in netdevice unregistration. */
> +	rcu_read_lock();
>  	if (x->xso.dev)

[Severity: Low]
This isn't a bug introduced by this patch, but this guard is still a plain
load of x->xso.dev. The writer in xfrm_dev_state_free() uses
WRITE_ONCE(xso->dev, NULL). The other readers in this file,
copy_to_user_state_extra() and xfrm_sa_len(), use READ_ONCE(x->xso.dev).

This line is now inside the new RCU section anyway. Could it use READ_ONCE()
too, so KCSAN doesn't report it as a data race? At runtime it is harmless,
because xfrm_dev_state_update_stats() reloads the pointer with READ_ONCE()
and checks it for NULL.

>  		xfrm_dev_state_update_stats(x);
> +	rcu_read_unlock();

[Severity: High]
Does this RCU section close the GETSA vs. device teardown race on real
offload hardware?

rcu_read_lock() here only delays the final free of the struct net_device.
The driver callback reached through xfrm_dev_state_update_stats() also uses
the driver's per-SA state, and that state is freed without a grace period.

In xfrm_dev_state_free(), the driver state is torn down before the binding
is cleared:

net/xfrm/xfrm_state.c:xfrm_dev_state_free() {
    ...
		if (dev->xfrmdev_ops->xdo_dev_state_free)
			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
		WRITE_ONCE(xso->dev, NULL);
		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
		netdev_put(dev, &xso->dev_tracker);
    ...
}

For mlx5, xdo_dev_state_free is mlx5e_xfrm_free_state(). It removes the
flow counters and frees sa_entry right away:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:mlx5e_xfrm_free_state() {
    ...
	mlx5e_accel_ipsec_fs_del_rule(sa_entry);
	mlx5_ipsec_free_sa_ctx(sa_entry);
    ...
sa_entry_free:
	kfree(sa_entry);
}

A GETSA or SA dump may already have passed the READ_ONCE(xdo->dev) check in
xfrm_dev_state_update_stats(). In that case it goes on to run
mlx5e_xfrm_update_stats():

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:mlx5e_xfrm_update_stats() {
	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
	struct mlx5e_ipsec_rule *ipsec_rule = &sa_entry->ipsec_rule;
	struct net *net = dev_net(x->xso.dev);
    ...
}

Can this read the freed sa_entry through the stale x->xso.offload_handle?
Can it also reach the destroyed flow counters through
mlx5_fc_query_cached()?

dev_net(x->xso.dev) is also a new plain load. If WRITE_ONCE(xso->dev, NULL)
lands between the helper's check and this load, would it dereference NULL?

On the teardown side the call chain is:

NETDEV_DOWN/NETDEV_UNREGISTER notifier
  xfrm_dev_down() / xfrm_dev_unregister()
    xfrm_dev_state_flush()
      xfrm_state_delete(x)
      xfrm_dev_state_free(x)

xfrm_dev_state_flush() drops xfrm_state_lock before these calls.
xfrm_state_delete() releases x->lock before it returns, and xfrm_cfg_mutex
is not held. The reader holds only xfrm_cfg_mutex in xfrm_get_sa(), or
xfrm_state_lock in the dump walk. Nothing seems to order the two sides.

This is the link-down plus link-delete case described in the commit
message. Does the free side need to clear the binding and wait for a grace
period before calling xdo_dev_state_free()? Alternatively, could the reader
and the free path share a lock such as x->lock?

>  	memcpy(&p->curlft, &x->curlft, sizeof(p->curlft));
>  	put_unaligned(x->stats.replay_window, &p->stats.replay_window);
>  	put_unaligned(x->stats.replay, &p->stats.replay);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch.
xfrm_do_migrate_state() in net/xfrm/xfrm_user.c has a similar unprotected
xso.dev access:

net/xfrm/xfrm_user.c:xfrm_do_migrate_state() {
    ...
		if (inherit_offload && x->xso.dev) {
			xso_to_xuo(&x->xso, &xuo);
			m.xuo = &xuo;
		}
    ...
}

net/xfrm/xfrm_user.c:xso_to_xuo() {
	xso_to_xuo_ifindex(xso, xso->dev->ifindex, xuo);
}

This path runs for XFRM_MSG_MIGRATE_STATE on an offloaded SA when neither
XFRMA_OFFLOAD_DEV nor XFRM_MIGRATE_STATE_CLEAR_OFFLOAD is given. It holds
only xfrm_cfg_mutex. There is no device reference, no RCU read lock, no
x->lock and no READ_ONCE() snapshot.

xfrm_dev_state_flush() can run from the netdev notifier and clear xso->dev
between the check and the xso->dev->ifindex load. Can that dereference
NULL? If unregister then completes, could the ifindex read hit a freed
net_device?

The state dump path avoids the device pointer by using the cached ifindex:

net/xfrm/xfrm_user.c:copy_user_state_offload() {
	return copy_user_offload_ifindex(xso, READ_ONCE(xso->ifindex), skb);
}

Could the migrate path use READ_ONCE(xso->ifindex) as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-xfrm-core-objects-candidate-0050-v3-dbfb7194ffb750193d02%40gmail.com
