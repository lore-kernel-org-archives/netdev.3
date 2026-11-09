Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224469;
	b=R2lK4ARGOcPGRwo4tP9xWLQU42aSHV5huTDAPiGzV6DOaoYMw57JkwA9HmhpoSaQbqyV
	 I2axe9bJNdp3D0EBI+LiiXSYcwp1D1ECNpR+bRZK+me+D/04DQkeQ8E/3XV5yGcvEtVw8
	 YZqUzu9W4ozhS8r1NscLSfGrTOuFV7py0ydu+oG7wepAPH4JElPwdY4u2MGtt4I3B+RD0
	 lu6qm4cRa55IB85TPIU2LE0HL8J+Yei/POpXCGarJtLVdlSxEMGsCWbnVdPFBT1zB73an
	 9ui3W/3b9lE89F/8QbcBRtt6Xsl278IaSd8h5dW6yEvBSSBsp4i4cxOmvwMl3TSIW9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224469;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BgN8f4X1rFQQNpw4mms3ar1LtMgOkGdHPy4uMQFUrdQ=;
	b=bfwLh+oD+QZ6Rvv1xuz2/nfOIlUUUEiVNpATOW0UG3ymBZuypvBmQ4qQmqN+XHe575L3
	 2aiAmzN4yV+h7kbhpR1Misi4pD/Lpdut0bUKpa4uL8DNSIjMpXXswTbz87BLOwKLr/VKR
	 fvuJnqPUkOuzb6yeaORdIxnQARGJBB6O4Oy8s9zu0siYfFEIjyK1jgO3AypMoqHtXF3ka
	 g7yeBPYVJ/yuwFxZPtvScrWEI+YWecY2nXv+UnP1ZvvBDnBv0bQVrGq39N/lFpwluftBs
	 +w0yYJoLKDGwt+cIPbIhtUow5L9ti/mmaxH4Ebeq8REkPQDREBnPOZCqoanbGqWTDEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr1HlMXk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D871606A330;
	Mon,  9 Nov 2026 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr1HlMXk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012E91F0089F;
	Mon,  9 Nov 2026 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224469;
	bh=BgN8f4X1rFQQNpw4mms3ar1LtMgOkGdHPy4uMQFUrdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xr1HlMXkvGQnr8zkwhZZCTYvLVet7H499ZZhB+GIXrYCWot7NXR3oxvy4P6oOyn6v
	 D+Q/Um349p1UoldFfEanXP9gpM2XUbnj1oq/tCnHuKflgx03YT4AVENDzURG7eiBPr
	 AGPMIzeG+/9GcznJ4bG62GzxOax7y2YUUOMb7IadidrwpSyNqKHztOLIaJJAdegFxx
	 3b5HuwbkOr1XPnOEDpJ7wl1a3TPG847aa6hmoOSOy85zARM5LZHOj2xx5Tzp0N8ffQ
	 CjD41y5AYVWrU47RN5oZjSA33CV7f4u4x10I8J5CzOOQL8moRpWlKVxjvTDC86Vkdv
	 zEZu0Bc6c46Bg==
Subject: Re: [PATCH net-next] net: dsa: motorcomm: Add LAG FDB callbacks
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 11:41:08 +0000
Message-ID: <179422446851.994134.17711680552032129131@kernel.org>
In-Reply-To: <20261108105012.1326929-1-mmyangfl@gmail.com>
References: <20261108105012.1326929-1-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new yt921x_dsa_lag_fdb_add() and yt921x_dsa_lag_fdb_del() in
  drivers/net/dsa/motorcomm/chip.c write a one-time snapshot of the…
- [Medium] net: dsa: motorcomm: race on dp->lag in
  yt921x_dsa_lag_fdb_add() and del()

--

net: dsa: motorcomm: Add LAG FDB callbacks

This commit adds lag_fdb_add and lag_fdb_del callbacks to the yt921x
driver. Each one builds a bitmap of the current LAG member ports with
dsa_lag_foreach_port() and passes it to yt921x_fdb_join() or
yt921x_fdb_leave().

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 33e5fc127244d..f73eed06437b9 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -883,6 +883,52 @@ yt921x_dsa_port_fdb_add(struct dsa_switch *ds, int port,
>  	return res;
>  }
>  
> +static int
> +yt921x_dsa_lag_fdb_del(struct dsa_switch *ds, struct dsa_lag lag,
> +		       const unsigned char *addr, u16 vid, struct dsa_db db)
> +{

[ ... ]

> +	ports_mask = 0;
> +	dsa_lag_foreach_port(dp, ds->dst, &lag)
> +		ports_mask |= BIT(dp->index);
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_fdb_leave(priv, addr, vid, ports_mask);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static int
> +yt921x_dsa_lag_fdb_add(struct dsa_switch *ds, struct dsa_lag lag,
> +		       const unsigned char *addr, u16 vid, struct dsa_db db)
> +{

[Severity: Medium]
Is it safe to walk the LAG membership here without rtnl_lock?

lag_fdb_add and lag_fdb_del are reached from
dsa_user_switchdev_event_work(). That runs on dsa_owq and does not hold
rtnl_lock. On that path, dsa_switch_do_lag_fdb_add() and
dsa_switch_do_lag_fdb_del() only take lag->fdb_lock before calling into
the driver. In both new callbacks the loop also runs before
priv->reg_lock is taken, so nothing in the driver serializes it either.

dsa_lag_foreach_port() does not only visit the members of this LAG. It
walks every port in ds->dst->ports and calls dsa_port_offloads_lag()
on each one, which goes through dsa_port_lag_dev_get():

	return dp->lag ? dp->lag->dev : NULL;

At the same time, under rtnl_lock, dsa_port_lag_join() sets dp->lag
via dsa_port_lag_create() before DSA_NOTIFIER_LAG_JOIN is sent.
yt921x_dsa_port_lag_join() can then reject the port, for example when
there are more members than YT921X_LAG_PORT_NUM or the hash mode does
not match. In that case the err_lag_join rollback calls
dsa_port_lag_destroy(). That clears dp->lag and kfree()s the dsa_lag
once its refcount reaches zero. dsa_port_lag_leave() also calls
dsa_port_lag_destroy() before DSA_NOTIFIER_LAG_LEAVE.

So an FDB work item for one LAG can see another port's dp->lag as
non-NULL and then read ->dev after that dsa_lag has been freed, for
example when that port tried to create a new LAG and was refused. Even
when nothing is freed, the loop can include a port that the driver has
just refused, or a port that is halfway through leaving. That port then
ends up in YT921X_FDB_IO2_EGR_PORTS of a static entry.

Only CAP_NET_ADMIN can trigger the join and leave, so this is not a
security boundary. It can still crash the machine or misprogram the
FDB while a bridged bond is being reconfigured.

Could the driver keep its own record of LAG membership instead? It
would be updated in yt921x_dsa_port_lag_join() and
yt921x_dsa_port_lag_leave() under priv->reg_lock, and ports_mask would
be computed from it after reg_lock is taken here. That would also give
a natural place to reprogram existing LAG FDB entries when membership
changes. Or is there some DSA core serialization against dp->lag
changes on this path that I am missing?

[ ... ]

> +	ports_mask = 0;
> +	dsa_lag_foreach_port(dp, ds->dst, &lag)
> +		ports_mask |= BIT(dp->index);
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_fdb_join(priv, addr, vid, ports_mask);
> +	mutex_unlock(&priv->reg_lock);

[Severity: High]
What happens to this FDB entry if the LAG's membership changes after it
is installed?

The FDB destination is a plain physical port bitmap
(YT921X_FDB_IO2_EGR_PORTS_M is GENMASK(28, 18)). So ports_mask records
which ports were members when the call was made, and nothing updates it
afterwards.

DSA core refcounts LAG FDB entries per LAG. It only calls the driver on
the first add and on the last delete:

net/dsa/switch.c:dsa_switch_do_lag_fdb_add() {
    ...
	a = dsa_mac_addr_find(&lag->fdbs, addr, vid, db);
	if (a) {
		refcount_inc(&a->refcount);
		...
		goto out;
	}
    ...
}

net/dsa/switch.c:dsa_switch_do_lag_fdb_del() {
    ...
	if (!refcount_dec_and_test(&a->refcount)) {
		...
		goto out;
	}

	err = ds->ops->lag_fdb_del(ds, *lag, addr, vid, db);
    ...
}

yt921x_dsa_port_lag_join() and yt921x_dsa_port_lag_leave() only
reprogram the LAG group through yt921x_lag_set(). They don't touch FDB
entries.

Take bond0 = {swp1}, bridged, with "bridge fdb add X dev bond0 master
static". The hardware entry gets EGR_PORTS = {swp1}.

When swp2 joins bond0, the replayed add only bumps the refcount. The
entry stays {swp1}.

When swp1 leaves bond0, dsa_port_pre_lag_leave()->
dsa_port_pre_bridge_leave() replays the delete, and that only drops the
refcount. The entry still points at swp1. swp1 is now standalone and
yt921x_bridge_leave() has isolated it. Unicast to X is blackholed or
misdirected, and swp2 never gets this traffic.

On the final delete, yt921x_dsa_lag_fdb_del() rebuilds the mask from the
current members ({swp2}). Then yt921x_fdb_leave() does this:

	ctrl2 = val2 & ~YT921X_FDB_IO2_EGR_PORTS(ports_mask);
	if (ctrl2 == val2)
		return 0;
	if (!(ctrl2 & YT921X_FDB_IO2_EGR_PORTS_M)) {
		ctrl = YT921X_FDB_OP_OP_DEL | YT921X_FDB_OP_START;
		...
	}
	...
	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);

It either returns 0 without deleting anything, or rewrites the entry as
STATIC with the leftover bits. Doesn't that leave a STATIC hardware FDB
entry that DSA no longer tracks?

port_fast_age wouldn't remove it either, because
yt921x_fdb_flush_port(priv, port, false) leaves static entries alone. So
the entry would use an FDB slot and misforward X/vid until the chip is
reset.

Before this patch, lag_fdb_add and lag_fdb_del were NULL, so
dsa_user_fdb_event() returned -EOPNOTSUPP and this state could not
happen.

ocelot, the other lag_fdb_add implementer, keeps track of LAG FDBs and
reprograms them when membership changes, in ocelot_migrate_lag_fdbs().
Does this driver need something similar, called from
yt921x_dsa_port_lag_join() and yt921x_dsa_port_lag_leave()?

There is also a hardware question that can't be answered from the code.
When a unicast FDB lookup hits an entry with several egress ports, does
the ASIC pick one using the LAG hash, or does it send the frame to every
listed port? If it does the latter, every frame to X would be duplicated
across the LAG members even with no membership changes.

> +
> +	return res;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108105012.1326929-1-mmyangfl%40gmail.com
