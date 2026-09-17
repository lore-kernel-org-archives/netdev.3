Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9E4F55B8;
	Thu, 17 Sep 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661492; cv=none; b=asAFC6x2ESgre6kuEsw6m5gKAFhCZ6erk4hOnbys+4n8IYEPnx3sft1nOtb5jKkPSM6hs/KCXdwbVpKgV9HIqwP2joIC+SSauUMktST6kd9xKpMBM1CrVVfoAWD20bxRBl6WF3I+s+j4Ft0rDSVspsBLRQ6X7RhjhozdYkyaWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661492; c=relaxed/simple;
	bh=wvHhtTjuoEXTunup/rsGyb0DtAP1u5UjHlZi2bSE59E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PyMenewgHGgUkrCaHHWXr49I70RblOqIOcA4fzIbrX0DVDzQV/CPEDPeQHrrb8ZfkfAgtImxcdjHQq7RFPxYItTEt9kBVhBwk217OgjtlDfe1Dwtg6XLSREzLm+N4BqjZ07C2HyStJ0lMOzQHVTGJbBqhSJ8MWkP83UT4axCxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcY5iPM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcY5iPM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CA51F000FF;
	Thu, 17 Sep 2026 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661489;
	bh=KrCZqwy9pFTCU44gJbcrSQTmGwofKQjYbevZEsYNTVA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HcY5iPM0eYcPikDynIglWTvD2YUO+ZKxIGiWjFQy9ZbRmTqwU8sAE8tMR0g6BL9zR
	 I4cL9/zhOX9wzgTiyRazcOdg3PRcvEuTEFysfvFNsg5D/NDofm3c/lK9sm0RnAzzu+
	 TwLwc5qfhleESNY9v5VKAvSTeL0Y6gt1kF2Va3ipCsvdYM7J8tVGvRcMXKAbYp4eq4
	 SfgXEkzDnJvqBQjbvd1VG/D0S1PfwspltMFXnZzNiyglTstrXvqtD+lFriJX8ajn1b
	 qSBvYb6v/HcZ+ODeEvzrTVH20YbPiUG4maE28qt1wvn+/A+A4orcHtje5zmasXWe5c
	 v4s9+AR45b2cQ==
Subject: Re: [PATCH net-next v16 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Thu, 17 Sep 2026 16:11:28 +0000
Message-ID: <178966148840.22033.17320023611707849421@kernel.org>
In-Reply-To: =?utf-8?q?=3Cead86a76820125b51db12ea8de45b7e844bb173b=2E1789477?=
 =?utf-8?q?568=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cead86a76820125b51db12ea8de45b7e844bb173b=2E17894775?=
 =?utf-8?q?68=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 4

- [High] mxl862xx_devlink_flash_update() relies on the devlink instance
  lock to serialize against .remove(), but dsa_unregister_switch()…
- [Medium] Asymmetric blocked-command gating: during the whole flash
  window (priv->block_host == true, priv->skip_teardown == false)…
- [Medium] mxl862xx_devlink_flash_update() latches priv->skip_teardown =
  true unconditionally and only afterwards calls…
- [Low] The commit message states 'Scheduling the re-probe can only fail
  on memory allocation'.
- [Low] The kernel-doc for struct mxl862xx_priv describes @block_host as
  'reject firmware API commands (except FW_UPDATE) during a firmware…
- [Low] mxl862xx_sb_pdi_reset() writes MXL862XX_SB_PDI_CTRL_RST - a CTRL
  *mode* encoding - as the data value for the ADDR and DATA registers.
- [Low] In mxl862xx_flash_firmware() the SB PDI register reset
  (CTRL/ADDR/DATA := 0) is issued immediately after SYS_MISC_FW_UPDATE,…

--

net: dsa: mxl862xx: add devlink flash_update and info_get

This adds devlink dev flash and devlink dev info support to the mxl862xx
DSA driver, transferring a validated image over the SB PDI protocol after
rebooting the switch into its MCUboot loader.  Firmware API commands are
short-circuited for the duration and a deferred re-probe reinitialises the
driver afterwards.

A few questions on the new code below.

The commit message states:

    Scheduling the re-probe can only fail on memory allocation, and only
    after the switch has already been flashed.

[Severity: Low]
Is that the only failure mode?  device_schedule_reprobe() also rejects the
request with -EINVAL:

drivers/base/dd.c:device_schedule_reprobe() {
	if (!drv || !dev->bus || dev->bus->need_parent_lock || !dev->p ||
	    dev->p->dead || !device_is_registered(dev))
		return -EINVAL;

mdio_device_remove() -> device_del() runs kill_device() (which sets
dev->p->dead) before bus_remove_device() -> mxl862xx_remove() ->
dsa_unregister_switch(), and dsa_unregister_switch() is where removal
blocks on the devlink instance lock the flash holds.

So an MDIO device unregistration racing a flash would reach
device_schedule_reprobe() with dev->p->dead already set, and
mxl862xx_devlink_flash_update() would return -EINVAL to userspace for a
flash whose transfer and mxl862xx_wait_ready() both succeeded.  Would it
be worth reflecting that in the commit message?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> new file mode 100644
> index 0000000000000..139c14adf2d98
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> +static int mxl862xx_sb_pdi_reset(struct mxl862xx_priv *priv)
> +{
> +	int ret;
> +
> +	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
> +				   MXL862XX_SB_PDI_CTRL_RST);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
> +				   MXL862XX_SB_PDI_CTRL_RST);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
> +				    MXL862XX_SB_PDI_CTRL_RST);
> +}

[Severity: Low]
This isn't a bug today, but mxl862xx_sb_pdi_reset() uses
MXL862XX_SB_PDI_CTRL_RST, a CTRL mode encoding, as the data value written
to the ADDR and DATA registers.  That only works because the constant
happens to be 0x00.  Would a plain 0 (or a separate constant) express the
intent better here?  If the CTRL mode encoding ever changed, the ADDR
latch would silently be left non-zero and slices would be programmed at
the wrong flash offset, which is the failure class the half-bank address
write checking was added to catch.

[ ... ]

> +static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
> +				   const struct firmware *fw,
> +				   u32 payload_size, struct devlink *dl)
> +{

[ ... ]

> +	/* Step 1: reboot the firmware into MCUboot rescue mode */
> +	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
> +				false, false);
> +	if (ret) {
> +		dev_err(&priv->mdiodev->dev,
> +			"flash: FW_UPDATE command failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	/* Step 2: wait for bootloader ready */
> +	mxl862xx_flash_notify(dl, "Waiting for bootloader", 0, 0);
> +	ret = mxl862xx_sb_pdi_reset(priv);
> +	if (ret < 0)
> +		goto write_err;
> +
> +	/* Failures from here on end up at no_end, which returns the error
> +	 * without signalling END -- see there.
> +	 */
> +	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
> +					MXL862XX_FW_READY_TIMEOUT_MS);

[Severity: Low]
Is the 3 s MXL862XX_FW_READY_TIMEOUT_MS budget enough here?  The deadline
starts right after SYS_MISC_FW_UPDATE and has to cover a full chip reset
plus MCUboot initialisation, which makes it the tightest timeout in this
file (the others are 5 s, 60 s and 300 s).  A switch that is slower to
reach the console loop would abort the flash with the sticky rescue bit
already set.

For reference, mxl862xx_wait_ready() unconditionally sleeps 2000 ms
because "it always takes at least 2 seconds" for the WSP firmware, which
is a strictly later milestone than the loader.

[ ... ]

> +int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
> +				  struct devlink_flash_update_params *params,
> +				  struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	/* Close ports while the firmware is still alive so the DSA core's
> +	 * MDB/FDB tracking is drained, and detach user ports so userspace
> +	 * cannot reopen them during the flash. The conduit is only closed,
> +	 * not detached: it belongs to the MAC driver. This driver binds a
> +	 * single switch with a direct host link and no cascade ports, so the
> +	 * conduit serves only this switch, and flashing it reboots the switch,
> +	 * which takes the tree down regardless.
> +	 */
> +	rtnl_lock();
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->user) {
> +			dev_close(dp->user);
> +			netif_device_detach(dp->user);
> +		}
> +	}

[Severity: High]
Can this dereference a freed net_device when an unbind races the flash?

The commit message says the instance lock covers .remove():

    The devlink core holds the instance lock across the whole flash and
    devlink_unregister() takes the same lock, so .remove() already waits

But dsa_unregister_switch() frees the user netdevs before it reaches that
lock:

net/dsa/dsa.c:dsa_tree_teardown() {
	dsa_tree_teardown_ports(dst);

	dsa_tree_teardown_switches(dst);
	...
}

dsa_tree_teardown_ports() -> dsa_port_teardown() does:

net/dsa/dsa.c:dsa_port_teardown() {
	case DSA_PORT_TYPE_USER:
		if (dp->user) {
			dsa_user_destroy(dp->user);
			dp->user = NULL;
		}
	...
	dsa_port_devlink_teardown(dp);
}

and dsa_user_destroy() drops rtnl before freeing:

net/dsa/user.c:dsa_user_destroy() {
	rtnl_lock();
	netdev_upper_dev_unlink(conduit, user_dev);
	unregister_netdevice(user_dev);
	phylink_disconnect_phy(dp->pl);
	rtnl_unlock();

	dsa_port_phylink_destroy(dp);
	gro_cells_destroy(&p->gcells);
	free_netdev(user_dev);
}

The devlink instance lock is only taken later, in
dsa_tree_teardown_switches() -> dsa_switch_devlink_unregister() ->
devlink_unregister().

So the flash path reads dp->user under {instance lock, rtnl} while the DSA
core frees the netdev and clears dp->user under dsa2_mutex only.  If the
flash loop acquires rtnl after free_netdev() and before dp->user = NULL,
netif_device_detach() would do test_and_clear_bit(__LINK_STATE_PRESENT,
&dev->state) on freed memory.

The patch adds an explicit instance-lock barrier plus a flag for
->shutdown() in mxl862xx_flash_shutdown(); would an equivalent barrier be
needed for the .remove()/unbind path?

[ ... ]

> +	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	priv->flash_owner = NULL;
> +	priv->block_host = false;
> +	priv->skip_teardown = true;
> +	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
> +
> +	/* Reinitialise through a deferred re-probe: remove() runs with
> +	 * skip_teardown set, then a fresh probe() starts against whatever
> +	 * the switch now runs. The core skips the re-probe if the device
> +	 * is unbound or shut down before it fires.
> +	 */
> +	err = device_schedule_reprobe(ds->dev, MXL862XX_FW_REPROBE_DELAY_MS);
> +
> +	return ret ? ret : err;
> +}

[Severity: Medium]
priv->skip_teardown is latched to true before it is known whether a
re-probe was actually scheduled.  device_schedule_reprobe() allocates its
own work item:

drivers/base/dd.c:device_schedule_reprobe() {
	rp = kzalloc_obj(*rp);
	if (!rp)
		return -ENOMEM;

If the transfer and mxl862xx_wait_ready() both succeeded but the
allocation fails, what state is the driver left in?  A grep over the
driver shows skip_teardown is only ever set to true, and there is no
netif_device_attach(), no enable_delayed_work() and no
clear_bit(MXL862XX_FLAG_WORK_STOPPED) outside probe, so nothing undoes any
of it without a fresh probe.

>From then on mxl862xx_api_wrap() takes the short-circuit for every
command:

	if (priv->skip_teardown) {
		ret = read ? -ENODEV : 0;
		goto out;
	}

so bridge, VLAN and STP writes are reported to userspace as applied while
the live switch keeps its power-on forwarding configuration, all user
netdevs stay netif_device_detach()ed, the stats poll stays disabled, and
every further devlink dev flash is refused with an extack that is no
longer true:

	if (priv->skip_teardown) {
		NL_SET_ERR_MSG_MOD(extack,
				   "a previous flash awaits its reprobe");
		return -EBUSY;
	}

The commit message accepts the -ENOMEM outcome as a system-wide condition,
but userspace is also told the flash failed via "return ret ? ret : err"
although the new firmware is running, and nothing is logged to tell the
administrator that an unbind/rebind is now required.  Would setting
skip_teardown only once the re-probe is queued be an option?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index 11759fa6069b1..4b3956a518cfe 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c

[ ... ]

> @@ -340,6 +342,24 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  
>  	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
>  
> +	if (priv->skip_teardown) {
> +		ret = read ? -ENODEV : 0;
> +		goto out;
> +	}
> +
> +	/* During the post-flash readiness poll block_host stays set, but the
> +	 * flash path's own firmware version reads must reach the new image;
> +	 * host writes stay blocked so stale resource IDs cannot corrupt it.
> +	 * A blocked write reports success: the reprobe discards the switch
> +	 * configuration anyway, and a bridge tearing down over a flash must
> +	 * not see port_vlan_del() fail, which leaks its VLAN group.
> +	 */
> +	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE &&
> +	    !(read && priv->flash_owner == current)) {
> +		ret = read ? -EBUSY : 0;
> +		goto out;
> +	}

[Severity: Medium]
This gate fakes success for writes but returns -EBUSY for reads.  Does
that leave the delete paths that start with a read uncovered?

During the transfer block_host is true, skip_teardown is still false and
flash_owner is NULL, so a concurrent MDB deletion takes the -EBUSY branch
on its very first firmware access:

mxl862xx_port_mdb_del()
	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);

The compensation added below only recognises -ENODEV under skip_teardown,
so -EBUSY is returned to the DSA core as a failed deletion:

net/dsa/switch.c:dsa_port_do_mdb_del() {
	err = ds->ops->port_mdb_del(ds, port, mdb, db);
	if (err) {
		refcount_set(&a->refcount, 1);
		goto out;
	}

and the host variant stops processing the remaining ports entirely:

net/dsa/switch.c:dsa_switch_host_mdb_del() {
	dsa_switch_for_each_port(dp, ds) {
		if (dsa_port_host_address_match(dp, info->dp)) {
			err = dsa_port_do_mdb_del(dp, info->mdb, info->db);
			if (err)
				break;
		}
	}

mxl862xx_devlink_flash_update() drops rtnl before setting block_host, so
any bridge teardown during the roughly one minute transfer (ip link set
lanX nomaster, ip link del br0, bridge mdb del) can hit this.  Since v16
deliberately made blocked writes report success so that port_vlan_del()
does not fail during a bridge teardown, should the read-first delete paths
get the same treatment?  mxl862xx_port_mdb_add() has the same leading read
and handles neither error code.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index cfa7e3e269a28..5668aac9ef7a1 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

> @@ -1572,6 +1623,12 @@ static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
>  	ether_addr_copy(qparam.mac, mdb->addr);
>  
>  	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
> +	/* Post-flash teardown: the firmware and its MAC table are gone, so
> +	 * there is nothing left to delete. Outside it, -ENODEV is a bus error
> +	 * and must be reported.
> +	 */
> +	if (ret == -ENODEV && priv->skip_teardown)
> +		return 0;
>  	if (ret)
>  		return ret;

This is the translation referenced above; it covers the teardown window
but not the -EBUSY the same read returns while block_host is set.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
> index 432a5f3f2e08e..2d38885ecfdab 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.h

[ ... ]

> @@ -319,6 +323,15 @@ struct mxl862xx_fw_version {
>   * @evlan_ingress_size: per-port ingress Extended VLAN block size
>   * @evlan_egress_size:  per-port egress Extended VLAN block size
>   * @vf_block_size:      per-port VLAN Filter block size
> + * @block_host:         reject firmware API commands (except FW_UPDATE)
> + *                      during a firmware flash
> + * @flash_owner:        task running the post-flash readiness poll; only its
> + *                      own firmware reads pass block_host
> + * @skip_teardown:      discard firmware API commands during the teardown
> + *                      triggered by the post-flash reprobe

[Severity: Low]
Do these two descriptions match mxl862xx_api_wrap()?  Writes are not
rejected or discarded at all there, they return 0 and report success to
the caller, while only reads see -EBUSY (block_host) or -ENODEV
(skip_teardown).  The "except FW_UPDATE" exception list is also incomplete,
since the flash task's own reads pass too, as the @flash_owner entry just
below notes.

Given the faked write success is deliberate, could the wording be adjusted
so a later reader does not add error handling based on the documented
semantics?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789477568.git.daniel%40makrotopia.org
