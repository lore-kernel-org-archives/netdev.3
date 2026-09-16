Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3D54DAD6;
	Wed, 16 Sep 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576218; cv=none; b=DQl9Bj4Pi4eOfTQbuJMaoLv9qcDCURb6y8GE5diFpQ8PTW63dYPWz0nppgdVMDWZDTzPkSIz1PFSXUYYXt11rZGzooAJXGN/Tfc0ejkErd1/EsT59JyAKscU4RP9HrQDRDXWt+3XI/SjkIDabsvaOQRFZ4vkCh7aykHktdfhY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576218; c=relaxed/simple;
	bh=qVY0qBBXxnnSVCbzuYwdXxvG1ut5NcOsK6JR13j4gy0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3DhYcrgMzee2CeeXafjGuK5Gem7YVpjew44nRwef5rN3cTrzOX+TB7onCgSMNWwNQ1qyRZwWeU6+yrKMgVRJF7XQibkCpFoznBQyMHgkRQ77SSAasFUvFc3aEKl9BTRJvli6yD8oo69N3Ts0dd30YPW6L63BdPbSt0e7iZ2m8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCsXqHcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCsXqHcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABB01F00893;
	Wed, 16 Sep 2026 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576214;
	bh=7RoTWgpEzUvsKG6lmfOTLIgUXAyUhrjSOcXpViUYzgo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QCsXqHcEYSb/nb0bh9PhEf7m3yfgMN2Io3+o/ZyDS+0y71iToOjhEJ+ASrkuzxj6z
	 lYAUbcpvqij4qe77EQvKQpe31XNRD1G+gBDiOajbsuvdvWAuiNsFhXlZJ7Mo6TS65y
	 LRlFGr0/vOj47LAyyKwv5jqUYz5rhExR5PDavvsT/iuYzh0T54cP04cJFgYabie7Px
	 +r1dtJo0YAkoGZAHiExS0I15bhzst0bgrYMAsXVF5+1ZClR9GaX5E70+lgDram6pjo
	 ghvVSq3CmmB9ShGo24eVsGftSeTNHUhwTgIAnu+dkkhZoFJSXJEIRhVBr6Y549mLhK
	 QQP0Zg/osjjUw==
Subject: Re: [PATCH net-next v7 3/6] net: dsa: motorcomm: move mib start from
 probe() to dsa_setup()
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 16 Sep 2026 16:30:13 +0000
Message-ID: <178957621342.22033.10069033956889592086@kernel.org>
In-Reply-To: <20260914103009.3007019-4-kyle.switch@motor-comm.com>
References: <20260914103009.3007019-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] Commit message does not describe the change: "Move MIB polling
  start from probe() to dsa_setup().so that it can be enabled based on…
- [Medium] Init/teardown asymmetry introduced by this patch: the only
  INIT_DELAYED_WORK(&pp->mib_read, ...) now runs in the DSA .setup…
- [Medium] Moving INIT_DELAYED_WORK(&pp->mib_read, ...) into
  yt921x_dsa_setup() places it on a path DSA can execute more than once…

--

net: dsa: motorcomm: move mib start from probe() to dsa_setup()

This moves the per-port loop that sets pp->index and calls
INIT_DELAYED_WORK() for the MIB polling work out of yt921x_mdio_probe()
and into the DSA .setup callback yt921x_dsa_setup().

> Move MIB polling start from probe() to dsa_setup().so that it can
> be enabled based on the actual switch family support.

[Severity: Medium]
Does the changelog match what the patch does?

The hunk only relocates the delayed work initialization, and the new
comment even says so:

	/* mib polling init */
	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
		...
		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
	}

The place where polling actually starts is untouched in
yt921x_phylink_mac_link_up():

	schedule_delayed_work(&priv->ports[port].mib_read, 0);

and the self re-arm in yt921x_poll_mib() is untouched as well:

	schedule_delayed_work(&pp->mib_read, delay);

There is also no new priv->series or priv->info test added anywhere by
this patch, so nothing is "enabled based on the actual switch family
support" yet.

Could the changelog instead describe the actual delta, namely that the
lifetime of the delayed work initialization changes from once per probe()
to once per DSA .setup()?

Also, "dsa_setup().so that" is missing a space after the period.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 4479bb1c3c2b1..49729db9993b7 100644
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

[Severity: Medium]
Can INIT_DELAYED_WORK() run here on a work item that is still armed?

DSA can call ds->ops->setup() more than once for the same priv.
dsa_switch_setup() returns early on ds->setup, but dsa_switch_teardown()
clears it:

net/dsa/dsa.c:dsa_switch_teardown() {
	...
	ds->setup = false;
}

So on a multi-switch tree, unbinding and re-binding a peer member tears
down and re-sets up the surviving switch.

In this patch yt921x_dsa_teardown() has no counterpart cancel:

static void yt921x_dsa_teardown(struct dsa_switch *ds)
{
	struct yt921x_priv *priv = to_yt921x_priv(ds);

#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
	yt921x_leds_remove(priv);
#endif
}

and the only per-port stop is non-synchronous in
yt921x_phylink_mac_link_down():

	/* No need to sync; port control block is hold until device remove */
	cancel_delayed_work(&priv->ports[port].mib_read);

while yt921x_poll_mib() unconditionally re-arms itself. Re-running
INIT_DELAYED_WORK() (and thus timer_setup()) on a timer still linked in a
timer base, and resetting work->data/work->entry, would give a
debugobjects "init active timer" report, a lost cancellation, and a
polling chain touching registers of a switch that yt921x_chip_reset()
just reset a few lines below.

The following patch in the series, "net: dsa: motorcomm: move mib stop
from remove() to teardown()", adds the disable_delayed_work_sync() loop to
yt921x_dsa_teardown(), which closes this window at the end of the series.
Would swapping the order of the two patches avoid the intermediate state?

Also, does the comment in yt921x_phylink_mac_link_down() saying the port
control block is "hold until device remove" still hold once the work is
initialized per .setup() rather than per probe()?

>  	mutex_lock(&priv->reg_lock);
>  	res = yt921x_chip_reset(priv);
>  	mutex_unlock(&priv->reg_lock);
> @@ -4803,13 +4811,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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
With the initialization gone from probe(), can yt921x_mdio_remove() call
disable_delayed_work_sync() on a work item that was never initialized?

yt921x_mdio_remove() still does this unconditionally:

	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
		struct yt921x_port *pp = &priv->ports[i];

		disable_delayed_work_sync(&pp->mib_read);
	}

priv comes from devm_kzalloc(), so if ds->ops->setup() never ran, mib_read
is all zeroes, including work->func and the timer.

dsa_register_switch() can return 0 without ever calling ds->ops->setup():

net/dsa/dsa.c:dsa_tree_setup() {
	...
	complete = dsa_tree_setup_routing_table(dst);
	if (!complete)
		return 0;
	...
}

That is the multi-switch dsa,member case where the peer has not probed
yet. Unbinding that switch then reaches:

	disable_delayed_work_sync() -> __cancel_work_sync() -> __flush_work()

kernel/workqueue.c:__flush_work() {
	if (WARN_ON(!work->func))
		return false;
	...
}

so a WARN splat on unbind, fatal under panic_on_warn, preceded by
__cancel_work()/work_grab_pending() operating on a timer that was never
passed to timer_setup().

The next patch in the series moves this loop into yt921x_dsa_teardown(),
where dsa_switch_teardown() returns early on !ds->setup, so the final
state of the series is fine. Would reordering the two patches keep each
one bisectable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914103009.3007019-1-kyle.switch%40motor-comm.com
