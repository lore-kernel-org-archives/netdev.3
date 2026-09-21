Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822ED33A9E8;
	Mon, 21 Sep 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983331; cv=none; b=HtPfirjGA8bFmdVo6FyJ/7TNElf/ASDeMdFZr8oHBNP/YKTI60G7pda3rRKaLrIUt6Qrhpltkx2bXVbHFLnEwvjf0haPmp5Gdt/LWtcyPfD286iKmVguUhdQpegv3EQBrajA//ojGzNO56gLoe/RTMDNC83/4NHiuY2nr7TV2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983331; c=relaxed/simple;
	bh=t00lcsfRf3awC+LwaoXAD+X4mJyzwyy3q7zlZrUbvv0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/tNzaMb9i4rX0Wl6+s7AvlKehOspWTBIjD/kYsG/g/lVlqt27FFJp83t2RmsU1U0hihnCJarxRjTA2PpXt21+Z1i2MZSG/yXPFJwW0HRjP11Yq/rXX7OCS5Cm2UfskHwXsgtZ3VhTUpQ93AcjnaLmF0Kx8rGP6peDNYGMMDIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6vQN1UX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6vQN1UX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315E21F000FF;
	Mon, 21 Sep 2026 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983329;
	bh=Pb/VAm068FplAX0X0vs/5ZAdIHasRPqFVhcI747Unek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H6vQN1UXzfYwmFEryPQbYvDrpexRYJ7RcaYMQq5J2LNGQiffWd4S2WGGBgnXUJVNn
	 ZkY0EyvC5XFEkFpGf5t7uCl6o1D26z9v8KMSnJu7POkdql+nQTfxMdeD1UkoFTk2OB
	 GtbaRZUDQnycMOByvLze6YndmS4QzfeKQzIottyX6eJAmwP4qMsw5iUmU653BkarMl
	 AOkTBXaPeKMLdapCyCbdmuUogsM6FxmIcWokaQr4DesauTrK1Vw7mTPwhfQux6zRou
	 AndpvZ1Q4CZXXJnc6ea6GS1tWTic9FPblO/FE5sd3gg2VlrB4LZNHBjU1lc3VSvzjI
	 J9ODFZrto7xrw==
Subject: Re: [PATCH net-next v8 3/6] net: dsa: motorcomm: move mib start from
 probe() to dsa_setup()
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 21 Sep 2026 09:35:27 +0000
Message-ID: <178998332774.2160803.17644567305115314588@kernel.org>
In-Reply-To: <20260917082236.3427168-4-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-4-kyle.switch@motor-comm.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] yt921x_dsa_setup() now runs INIT_DELAYED_WORK(&pp->mib_read,
  yt921x_poll_mib) for every port on every DSA .setup() invocation…
- [Medium] After this patch the per-port delayed works are initialized
  only inside yt921x_dsa_setup() (chip.c:4556-4562), while…

Pre-existing issues:
- [Medium] If dsa_register_switch() fails after yt921x_dsa_setup()
  already ran and a port's mib_read work has been scheduled…
- [Medium] The self-re-arming per-port MIB poller (yt921x_poll_mib() ->
  yt921x_read_mib(), chip.c:609-626) is never stopped by…
- [Medium] The per-port init block moved into yt921x_dsa_setup()
  (chip.c:4556-4562) sets pp->index and initializes pp->mib_read but…

--

net: dsa: motorcomm: move mib start from probe() to dsa_setup()

This moves the per-port MIB delayed_work initialization out of
yt921x_mdio_probe() and into the DSA .setup() callback, so the works are
now initialized once per .setup() instead of once per probe().

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 2156230a78aad..167b208357710 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4553,6 +4553,14 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  	struct device_node *child;
>  	int res;
>  
> +	/* mib polling init */
> +	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		pp->index = i;
> +		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
> +	}
> +

[Severity: High]
Can this re-initialize a delayed_work that is still armed or queued?

.setup() can run a second time for the same struct yt921x_priv without a
new probe().  dsa_switch_teardown() clears ds->setup, so when a peer
switch of a multi-switch tree is unbound and re-bound, the whole tree is
torn down and set up again and ds->ops->setup() is invoked once more.

The counterpart yt921x_dsa_teardown() does not touch the works at all:

	static void yt921x_dsa_teardown(struct dsa_switch *ds)
	{
		struct yt921x_priv *priv = to_yt921x_priv(ds);

	#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
		yt921x_leds_remove(priv);
	#endif
	}

The only per-port cancellation before device removal is the
non-synchronous cancel in yt921x_phylink_mac_link_down():

	/* No need to sync; port control block is hold until device remove */
	cancel_delayed_work(&priv->ports[port].mib_read);

and the worker re-arms itself unconditionally:

	yt921x_poll_mib()
		...
		schedule_delayed_work(&pp->mib_read, delay);

So if yt921x_poll_mib() is executing when the port goes down, the cancel
is a no-op and the work is armed again.  A subsequent .setup() then runs
INIT_DELAYED_WORK() on that live work, overwriting work->data,
work->entry and dwork->timer while they are linked into the timer base or
a pool worklist.  Does that risk list corruption, lost work, and
debug-objects/lockdep splats?

The comment quoted above ("port control block is hold until device
remove") also seems to no longer hold once the init lifetime becomes
per-.setup(); should it be updated together with this change?

Note the follow-up patch in this series, "net: dsa: motorcomm: move mib
stop from remove() to teardown()", adds the disable_delayed_work_sync()
loop to yt921x_dsa_teardown(), and with that in place the works are
drained before any re-initialization.  Would it make sense to fold the
two changes together so this intermediate state does not exist for
bisect?

[Severity: Medium]
This is a pre-existing issue, but the new placement of the init loop
makes it worth asking about: can the poller read the MIB block while it
is reset?

The init block now sits immediately before:

	mutex_lock(&priv->reg_lock);
	res = yt921x_chip_reset(priv);
	mutex_unlock(&priv->reg_lock);

Since yt921x_dsa_teardown() does not stop the poller and
yt921x_phylink_mac_link_down() only uses cancel_delayed_work() against a
worker that re-arms itself, a poll can still run during a second
.setup(), in the window between yt921x_chip_reset() and
yt921x_chip_setup() re-enabling YT921X_FUNC_MIB plus writing
YT921X_MIB_CTRL_CLEAN.  priv->reg_lock serializes individual register
accesses but does not keep the poller out of that window.

yt921x_read_mib() treats any decrease of the low 32 bits as a wrap:

		val = (old_val & ~(u64)U32_MAX) | val0;
		if (val < old_val)
			val += 1ull << 32;

so one read of a reset or disabled MIB block permanently shifts the
shadow counter by 2^32 rather than producing a single bad sample.  The
follow-up patch adding disable_delayed_work_sync() to
yt921x_dsa_teardown() closes this window.

[Severity: Medium]
This is a pre-existing divergence, but this hunk moves the per-port init
onto exactly the path that clears the hardware counters: should the
software MIB shadow be reset here too?

The block sets pp->index and initializes pp->mib_read, but leaves
pp->mib, pp->rx_frames and pp->tx_frames untouched, while the same
.setup() path clears the hardware counters in yt921x_chip_setup():

	/* Clear MIB */
	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);

yt921x_read_mib() documents the precondition:

	/* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */

pp->mib is only ever zeroed by the devm_kzalloc() in yt921x_mdio_probe().
On a second .setup() for the same priv the hardware counters restart at
zero while the shadow keeps its old values, so the wrap heuristic adds
2^32 to every 32-bit counter and ethtool -S / rtnl statistics jump by
roughly 4.29e9 per counter.  This one is still present at the end of the
series.

>  	mutex_lock(&priv->reg_lock);
>  	res = yt921x_chip_reset(priv);
>  	mutex_unlock(&priv->reg_lock);
> @@ -4805,13 +4813,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  	priv->reg_ops = &yt921x_reg_ops_mdio;
>  	priv->reg_ctx = mdio;
>  
> -	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
> -		struct yt921x_port *pp = &priv->ports[i];
> -
> -		pp->index = i;
> -		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
> -	}
> -

[Severity: Medium]
With the init now conditional on .setup() having run, can
yt921x_mdio_remove() operate on never-initialized works?

yt921x_mdio_remove() still disables all of them unconditionally:

	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
		struct yt921x_port *pp = &priv->ports[i];

		disable_delayed_work_sync(&pp->mib_read);
	}

dsa_register_switch() can return 0 without ever calling ds->ops->setup():

	net/dsa/dsa.c:dsa_tree_setup() {
		...
		complete = dsa_tree_setup_routing_table(dst);
		if (!complete)
			return 0;
		...
	}

That happens when a DT-declared dsa-link peer switch has not probed yet,
or never probes.  priv is devm_kzalloc()'d and drvdata is set before
dsa_register_switch(), so a later unbind or module unload reaches
yt921x_mdio_remove() with zero-filled delayed_work objects.

disable_delayed_work_sync() -> __cancel_work_sync() then calls
timer_delete() on an uninitialized timer, which trips the debug-objects
assert under CONFIG_DEBUG_OBJECTS_TIMERS, and unconditionally calls
__flush_work(work, true):

	kernel/workqueue.c:__flush_work() {
		if (WARN_ON(!work->func))
			return false;
		...
	}

so one warning per port.  The follow-up patch moves this loop into
yt921x_dsa_teardown(), which DSA only invokes when setup actually ran
(dsa_switch_teardown() returns early on !ds->setup), so this only exists
at this bisect point.

[Severity: Medium]
This isn't a bug introduced by this patch, but the probe error path looks
unprotected: does it leave a scheduled work pointing at freed memory?

yt921x_mdio_probe() ends with:

	mdiodev_set_drvdata(mdiodev, priv);

	return dsa_register_switch(ds);

If dsa_register_switch() fails after yt921x_dsa_setup() already ran and a
port's work has been armed by
yt921x_phylink_mac_link_up() -> schedule_delayed_work(&priv->ports[port].mib_read, 0),
probe returns the error, the mdio core does not call yt921x_mdio_remove(),
and devm releases the priv that embeds the delayed_work.  Port teardown
on the unwind path only calls cancel_delayed_work(), and
yt921x_poll_mib() re-arms itself, so the work is not guaranteed to be
drained and can run against freed priv/pp memory.

Placing disable_delayed_work_sync() in yt921x_dsa_teardown(), as the
follow-up patch does, also covers this, since DSA calls .teardown() on
the tree-setup error paths via dsa_tree_teardown_switches().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917082236.3427168-1-kyle.switch%40motor-comm.com
