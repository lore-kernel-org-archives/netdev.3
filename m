Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952338F64D;
	Tue,  6 Oct 2026 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312251; cv=none; b=NIIzY+VmKcgErczOH9vMefLydc0zQZ4KCYP2p71gqerKeUtJHahIAoxBEuHZm+Pl5R8xy0r5PLV2o7zIFrWFP5svl2eIoULi39wEJfC7VwfCf0uCfQrDihrhwCgqTvHOFrWHRtXIYWRPXOx6Cu24GbmPWmG9LsEG+ohf4VEzXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312251; c=relaxed/simple;
	bh=Y6L9Y9ixPDbM6y/vr6p3U+LsSpKfSYPAaWI46E9JIkc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9m25a9rvxsUQeziY1wi6ZXWjzIL6luWwLzGnGPB2zsM4zRtOVma6X1DM7Lk6azdcZG6Bv1aeAJKiityf1QgyB9z+DmVf+beEhJ3M0qPL2OlOxM4pa6c4gDo77NSSG/M/7GrDThIEm2/udXHC7kL+jv5wTvEOpz8hZDv2jR2Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIDFRztX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIDFRztX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33BA1F0089B;
	Tue,  6 Oct 2026 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312248;
	bh=TtyeIp+HpRp4mP+HQW5CeT1e5+71S9zvILV3RP4sF40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WIDFRztXeztc2/jh3zOpNAmkYeiqDwWY6b18wjIvcaddyyD6tbcHeqbh9pnuoeTM7
	 gBCiQhrW5DfsiWHP2TXpHf9dZBTS40QB2vG1Fr6MuaFNHPK2VJHApzR910lCKQUihM
	 boI1ct4s8fxMf90eHELzy7hgtSRyg0zLqq+y7t7+TTx4vGTuLd1Qg9GvmwFCTU0Alb
	 XX0A+kKeNy9fcvDD4Lfunf73oVC7zhMYVZa9F1ryTQMQZUT9PUViafcdM9WGDFr/Tp
	 wBMToPP1frC8rQAtWFSw1Lom6RqyNEGwSrnsWEiWQGuLBuMwb+J2pCVExZZ21XtpbY
	 LcJ23GyYXrvFw==
Subject: Re: [PATCH net-next v11 4/7] net: dsa: motorcomm: move mib start from
 probe() to dsa_setup()
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Tue, 06 Oct 2026 18:44:07 +0000
Message-ID: <179131224741.434549.13271700601873587215@kernel.org>
In-Reply-To: <20261002173706.1225502-5-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-5-kyle.switch@motor-comm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In this commit, mib_read is re-initialized on every
  yt921x_dsa_setup(), but yt921x_dsa_teardown() only removes LEDs and…
- [Medium] In this commit, the only call to
  INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib) is inside…
- [Medium] In this commit, yt921x_mdio_remove() runs its
  disable_delayed_work_sync() loop before dsa_unregister_switch() and…
- [Low] The subject 'move mib start from probe() to dsa_setup()' does not
  match the code.

--

net: dsa: motorcomm: move mib start from probe() to dsa_setup()

This commit moves the per-port pp->index assignment and the
INIT_DELAYED_WORK() of the MIB polling work from yt921x_mdio_probe()
into yt921x_dsa_setup(). The works are now initialized once per DSA
.setup() instead of once per probe().

> net: dsa: motorcomm: move mib start from probe() to dsa_setup()

[Severity: Low]
This isn't a bug, but the subject says "mib start". Only the
INIT_DELAYED_WORK() moves. Polling actually starts in
yt921x_phylink_mac_link_up(), and this patch does not change that code:

	schedule_delayed_work(&priv->ports[port].mib_read, 0);

> Move the delayed work initialization of the per-port MIB polling
> from yt921x_mdio_probe() into the DSA .setup() callback, changing
> its lifetime from once per probe() to once per DSA .setup().

The body does not say why the move is needed. It also leaves out that
pp->index moves as well.

pp->index is not specific to MIB polling. yt921x_port_to_priv() depends
on it, and so do the PCS and LED code. Should the commit message mention
this? Should the assignment sit under a comment other than
"mib polling init"?

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 13fc286d4194b..c7cfaf2442749 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4251,6 +4251,14 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  	int port;
>  	int res;
>  
> +	/* mib polling init */
> +	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		pp->index = i;
> +		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);

[Severity: High]
Can this re-initialize a delayed work that is still armed?

INIT_DELAYED_WORK() now runs on every tree setup. In this commit,
yt921x_dsa_teardown() only removes the LEDs:

static void yt921x_dsa_teardown(struct dsa_switch *ds)
{
#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
	struct yt921x_priv *priv = to_yt921x_priv(ds);

	yt921x_leds_remove(priv);
#endif
}

In a multi-switch tree, unbinding a peer switch tears down the whole
tree. That includes this switch, which stays bound:

dsa_unregister_switch() (peer)
  dsa_switch_remove()
    dsa_tree_teardown(dst)

When the peer rebinds, yt921x_dsa_setup() runs again on the same priv.

On the teardown path, the only thing that stops the work is the non-sync
cancel in yt921x_phylink_mac_link_down():

	/* No need to sync; port control block is hold until device remove */
	cancel_delayed_work(&priv->ports[port].mib_read);

yt921x_poll_mib() also always re-arms itself:

	schedule_delayed_work(&pp->mib_read, delay);

A poll can be running when that cancel happens, for example while it
waits on reg_lock, which link_down takes right after the cancel. The poll
then re-arms and the work is still pending after teardown.

The next INIT_DELAYED_WORK() would then reset a timer that is still
enqueued, and possibly a work that is still queued. Could that corrupt
the timer wheel or worklist linkage? Debugobjects would also report
"init active object".

Before this patch the init ran only once in probe, so a later setup
never touched a live work.

The next patch in the series, "net: dsa: motorcomm: move mib stop from
remove() to teardown()", adds disable_delayed_work_sync() for every port
to yt921x_dsa_teardown(). That fixes this in the final state of the
series. Could the two changes be merged so every commit bisects cleanly?

Separately, in that later patch priv looks like it is declared only under
CONFIG_NET_DSA_YT921X_LEDS in yt921x_dsa_teardown(). Does
yt921x_dsa_teardown() still build when the LED option is disabled?

[Severity: Medium]
Can this INIT_DELAYED_WORK() undo the disable that yt921x_mdio_remove()
just did?

In this commit, yt921x_mdio_remove() disables the works before calling
dsa_unregister_switch(), and it does so without holding dsa2_mutex:

	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
		struct yt921x_port *pp = &priv->ports[i];

		disable_delayed_work_sync(&pp->mib_read);
	}

	dsa_unregister_switch(&priv->ds);

Another member of the same tree may re-register at the same time, after
an earlier unbind tore the tree down. If that completes the tree,
dsa_tree_setup() calls yt921x_dsa_setup() for this switch.

INIT_DELAYED_WORK() resets work->data, which clears the disable count
that remove() just set. yt921x_phylink_mac_link_up() can then arm the
works again.

The non-sync cancel in yt921x_phylink_mac_link_down() can also race with
a running yt921x_poll_mib(). Together, could a re-armed work survive
teardown (which has no cancel in this commit) and run after devm has
freed priv?

This needs two timing windows and root. Before this patch, though,
.setup() never touched the work state, so nothing could undo the disable
in remove().

The later patch "net: dsa: motorcomm: move mib stop from remove() to
teardown()" moves the disable into yt921x_dsa_teardown(). That runs
under dsa2_mutex, as dsa_tree_setup() does, so the race goes away by the
end of the series.

> +	}
> +
>  	mutex_lock(&priv->reg_lock);
>  	res = yt921x_chip_reset(priv);
>  	mutex_unlock(&priv->reg_lock);
> @@ -4525,13 +4533,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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
After this removal, does yt921x_mdio_remove() call
disable_delayed_work_sync() on works that were never initialized?

The only INIT_DELAYED_WORK() for mib_read is now in yt921x_dsa_setup().
yt921x_mdio_probe() returns the result of dsa_register_switch(ds).

For an incomplete tree, dsa_tree_setup() returns success without calling
.setup(). An example is a multi-switch tree whose peer has not registered
yet:

net/dsa/dsa.c:dsa_tree_setup() {
    ...
	complete = dsa_tree_setup_routing_table(dst);
	if (!complete)
		return 0;
    ...
}

If the device is unbound in that state, yt921x_mdio_remove() still loops
over every port and calls this on a delayed_work that devm_kzalloc() left
zeroed:

		disable_delayed_work_sync(&pp->mib_read);

The call goes through __cancel_work_sync()->__flush_work(), which hits
WARN_ON(!work->func) once per port. Debugobjects may also report the
timer_delete() on the uninitialized timer.

The next patch, "net: dsa: motorcomm: move mib stop from remove() to
teardown()", takes this loop out of remove() and puts it in
yt921x_dsa_teardown(). dsa_switch_teardown() only calls that when
ds->setup is set, so the problem is limited to the window between the
two patches. Could the init stay in probe until the stop side moves too?

>  	ds = &priv->ds;
>  	ds->dev = dev;
>  	ds->priv = priv;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002173706.1225502-1-kyle.switch%40motor-comm.com
