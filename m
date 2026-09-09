Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BC472538;
	Wed,  9 Sep 2026 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954156; cv=none; b=iraBlEP4qCp063mYY6E7i0+wjjvl+MJ2X7tD/7h09zspXSN0+Bin9IAblgyYPw9V9a1Ml8Bq860IEgC7AVlptXVlHT6MjOJ0+lKcPQEaZiviEkMk8tZDj/y85Z55fPGWPQcvzqn99klUMN5QK8Dn76dE5jsrcj07/Of3wlc8klc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954156; c=relaxed/simple;
	bh=2snWrRJ4uKorGtLI1mnuq+G1C5icOs1zvH0gbkFqGfU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZdHXJ32aRjyTVmc93t+2GrFJRSC0NKnjfdWD5VpDSQSFiYye6LoMK6+4q7VgTxFCv20uogALc9TzZPJjo4h5Udb8s+VEGsVNZeMvo4PW/aQ+96FF1YZSltS1yVQOGwltYBlJPUpHBwE9ADYLvQxRIHg6VzCz7hpOz6Shetv7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA2rFaUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA2rFaUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F81F00A3D;
	Wed,  9 Sep 2026 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954152;
	bh=Yfjjb++jzXj/lmKBwq5OTsLKZrasvS3tMpARBFSXekY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EA2rFaUhwdewAgNFzbdKgUmvqPwUKatu19woT9xnBtKOVNkgvhySJUy9/vOBSpeA3
	 s15JgWu/ODPSqlLtVw22V6NhCrdcSMEtJbIBO2u0dshPpIDcCi5DiUccEcAUCp/z9G
	 FCJeFNjDkWhdNQ57+CHDgtifwyNV5P+JF7G96PTNCTOrPmoVsRwSnhPDMo1IFtVIaA
	 dFn4UoNJ2lQcwcUO9wld/lTbKcJgJR10MiFPQfWal/Dc6+J7KTCXOCUSakwTVkkk10
	 2FdqKguW073bVtaf3iA0MCUDifXS1IIA4zSV8NcOLN/qDV47dEhCPtgUOS3ffVma2L
	 PSyGxvgAqLefA==
Subject:
 Re: [PATCH net] net: dsa: mxl862xx: disable the stats poll on teardown
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 11:42:31 +0000
Message-ID: <178895415193.219967.5342143627576620914@kernel.org>
In-Reply-To: =?utf-8?q?=3C8b861014c836377afab0fdfb66a83fa017e5cd84=2E1788779?=
 =?utf-8?q?062=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C8b861014c836377afab0fdfb66a83fa017e5cd84=2E17887790?=
 =?utf-8?q?62=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1 (1)

- [High] Stats poll can walk a freed dsa_port list on the DSA
  registration-failure path: mxl862xx_setup() arms priv->stats_work…
- [Low] The commit message overstates the failure mechanism: it blames
  both mxl862xx_get_stats64() and "the stats poll's own re-arm" for…

Pre-existing issues:
- [Medium] Two of the driver's three work items keep the weaker cancel-
  only teardown contract in the very functions this patch touches, and…
- [Low] The comment above the re-arm in mxl862xx_get_stats64()
  (drivers/net/dsa/mxl862xx/mxl862xx.c:2050-2052) claims the…

--

net: dsa: mxl862xx: disable the stats poll on teardown

This switches the three teardown sites in the mxl862xx driver from
cancel_delayed_work_sync() to disable_delayed_work_sync() so that a
re-arm racing with the WORK_STOPPED flag cannot bring the stats poll
back after the drain. The WORK_STOPPED flag is still set before the
drain in all three places.

A couple of questions about the changelog and about the paths the
change is meant to cover.

> The WORK_STOPPED flag test in mxl862xx_get_stats64() and in the stats
> poll's own re-arm is not atomic with the cancel in remove(), shutdown()
> and the probe error path. A re-arm that read the flag before it was set
> queues the work after cancel_delayed_work_sync() has returned

[Severity: Low]
Is the "stats poll's own re-arm" half of this accurate?

cancel_delayed_work_sync() goes through __cancel_work_sync(), which raises
the disable count before it flushes and only drops it afterwards:

kernel/workqueue.c:__cancel_work_sync() {
	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
	...
	if (wq_online)
		__flush_work(work, true);

	if (!(cflags & WORK_CANCEL_DISABLE))
		enable_work(work);
}

So the schedule_delayed_work() at the tail of mxl862xx_stats_work_fn() runs
while the work is disabled and is either stolen by work_grab_pending() or
dropped by clear_pending_if_disabled(). cancel_work_sync()'s kerneldoc says
as much ("can be used even if the work re-queues itself ... as long as there
aren't racing enqueues").

That leaves the re-arm in mxl862xx_get_stats64() as the one enqueue that can
actually land after the cancel returned. Would it be worth narrowing the
changelog to that path, since the patch itself is still needed for it?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index cfa7e3e269a28..a31ebbe451e00 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -2131,7 +2131,7 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
>  	err = dsa_register_switch(ds);
>  	if (err) {
>  		set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
> -		cancel_delayed_work_sync(&priv->stats_work);
> +		disable_delayed_work_sync(&priv->stats_work);

[Severity: High]
Can this error path still let the poll walk a freed dsa_port list?

mxl862xx_setup() arms the poll while still inside dsa_register_switch():

drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_setup() {
	...
	schedule_delayed_work(&priv->stats_work,
			      MXL862XX_STATS_POLL_INTERVAL);

	return mxl862xx_setup_mdio(ds);
}

If mxl862xx_setup_mdio() or any later dsa_tree_setup() step fails, DSA frees
the ports before returning to the driver:

net/dsa/dsa.c:dsa_switch_probe() {
	err = dsa_tree_setup(dst);
	if (err) {
		dsa_switch_release_ports(ds);
		dsa_tree_put(dst);
	}
}

net/dsa/dsa.c:dsa_switch_release_ports() {
		...
		list_del(&dp->list);
		kfree(dp);
}

Meanwhile the worker iterates that same list with no lock:

drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_stats_work_fn() {
	dsa_switch_for_each_available_port(dp, ds)
		mxl862xx_stats_poll(ds, dp->index);
	...
}

and mxl862xx_stats_poll() then does spin_lock_bh(&priv->ports[port].stats_lock)
plus 64-bit accumulate writes using that dp->index. Since the disable here
only runs after dsa_register_switch() has already completed its unwind, does
this change cover that window at all? mxl862xx_switch_ops has .port_teardown
but no .teardown, so DSA's own unwind gives the driver no place to stop the
poll before the ports go away. Would disabling the work from a .teardown op,
or from mxl862xx_setup()'s own error handling, close it?

>  		mxl862xx_host_shutdown(priv);
>  		for (i = 0; i < MXL862XX_MAX_PORTS; i++)
>  			cancel_work_sync(&priv->ports[i].host_flood_work);

[Severity: Medium]
This isn't a bug introduced by this patch, but the other two work items in
the driver keep the weaker cancel-only contract in the very functions being
touched here, and for crc_err_work it looks defeatable.

mxl862xx_host_shutdown() only cancels:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_host_shutdown() {
	cancel_work_sync(&priv->crc_err_work);
}

and none of the queue sites for that work consult MXL862XX_FLAG_WORK_STOPPED,
only MXL862XX_FLAG_CRC_ERR:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_send_cmd() {
		if ((ret == MXL862XX_FW_CRC6_ERR ||
		     ret == MXL862XX_FW_CRC16_ERR) &&
		    !test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
			schedule_work(&priv->crc_err_work);
}

The same pattern is in mxl862xx_issue_cmd() and mxl862xx_api_wrap().

Here crc_err_work is cancelled before the host_flood_work drain, and
mxl862xx_host_flood_work_fn() issues firmware commands via
mxl862xx_bridge_config_fwd() holding only rtnl_lock(). If a CRC-6/CRC-16
mismatch happens on one of those commands after mxl862xx_host_shutdown()
returned, crc_err_work is queued again. On this path priv is devres-freed as
soon as probe returns err, so mxl862xx_crc_err_work_fn() would then
dereference freed memory:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_crc_err_work_fn() {
	struct mxl862xx_priv *priv = container_of(work, struct mxl862xx_priv,
						  crc_err_work);
}

Would moving mxl862xx_host_shutdown() after the host_flood_work drain, or
disabling crc_err_work and host_flood_work rather than cancelling them, put
all three work items on one contract?

[ ... ]

> @@ -2181,7 +2181,7 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
>  	dsa_switch_shutdown(ds);
>  
>  	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
> -	cancel_delayed_work_sync(&priv->stats_work);
> +	disable_delayed_work_sync(&priv->stats_work);
>  
>  	mxl862xx_host_shutdown(priv);
>  

The same crc_err_work ordering applies on this path. dsa_switch_shutdown()
does not call .port_teardown, so p->setup_done is still true when the flood
worker runs and it proceeds to issue firmware commands after crc_err_work has
already been cancelled. The re-queue looks harmless during system shutdown,
but the ordering is the same as in the probe error path above.

One more observation about a comment that this patch does not touch but which
the change makes partly stale.

[Severity: Low]
This is a pre-existing issue, but the comment above the re-arm in
mxl862xx_get_stats64() reads:

drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_get_stats64() {
	/* Trigger a fresh poll so the next read sees up-to-date counters.
	 * No-op if the work is already pending, running, or teardown started.
	 */
	if (!test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
		schedule_delayed_work(&priv->stats_work, 0);
}

Is it a no-op while the work is running? queue_delayed_work_on() only bails
on WORK_STRUCT_PENDING or a non-zero disable count:

kernel/workqueue.c:queue_delayed_work_on() {
	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
	    !clear_pending_if_disabled(work)) {
		__queue_delayed_work(cpu, wq, dwork, delay);
		ret = true;
	}
}

process_one_work() clears PENDING before invoking the callback, so a queue
attempt during execution is accepted and the MDIO-heavy poll runs again right
after the current one. Repeated readers, e.g. "ip -s link" in a loop, can
chain polls back to back.

After this patch the "teardown started" clause is also satisfied by the new
disable count rather than by the flag test the comment sits on. Could the
comment be updated to match?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/8b861014c836377afab0fdfb66a83fa017e5cd84.1788779062.git.daniel%40makrotopia.org
