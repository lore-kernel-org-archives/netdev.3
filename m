Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8B1E1A17;
	Wed, 30 Sep 2026 03:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740134; cv=none; b=jIgr9EjMHbNRPfoOu41Sct5KaDK06aoAg7O5FUxPL242l8GzzKKLtL8Vm9npfpX9wuz2GRHErEY4ziq9dwv73UTivigwmDloHHcvWkYIOEz5FJi4qaxuGYtL/zZxa1ecyqYB/S/CSJDdGp5BAry/J4OnVWEjzHwdeHMbqJzZ7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740134; c=relaxed/simple;
	bh=8JZwbjv91jqlsS9qpQnJRE2DV4rrThjzxoeKEE6SjwA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUL+uwMLQKTYKS8uMhxA7HCSjXg2AJjFTpnclGMBvPVl2rmLV3jbjIrUJq+tvzdoFm4vz0FPSsVJ/s77YUmJuZU97dYZB9xmaSxaq3XJZkaq/MD0Fn+Eyc7qxcErTL4es0Todyjy+XLS/K4gziB5HMrX0lWIlNPK+aXlNSt1O8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsscoRXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsscoRXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F5A1F00893;
	Wed, 30 Sep 2026 03:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740132;
	bh=Ng7i4XylB6J7RJhrKqfoNFJDNRJ0Q11yxaqr5w+NnJM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SsscoRXGz1txH0PhRSZp2L1wso7jiyEPCWVAy6zjwCC1drGGto/zB28PXBMdy93P3
	 CQLz5ZzKBMrCnupyo+nOcyZqa6cvnI57wxud9UJ1LRVnhW8QWQ5EUnZReDTMwKNdJM
	 mv2VhqqGuzY5tZTMqXpTs7kIROYrl6GP/hfrj88A06w9vQPv0EmDNBZQaxNpxNQo7D
	 FpDUAB2u7jd5QROGgZJftIr+BMHDPlbPomeQN/RMm9D8PpQHkrkmRvIipjqQeAfJgT
	 YKW+KSoTkVJ87xXj+k4w3LglnwglHGxc6ObLbPzV+leIVvM0664nKcLkL0Fa7FqmRF
	 /8ptu1WJyWbKA==
Subject: Re: [PATCH net-next v18 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Wed, 30 Sep 2026 03:48:50 +0000
Message-ID: <179074013097.434549.1744229509250899109@kernel.org>
In-Reply-To: =?utf-8?q?=3Cb65b7f33ed757e57ed99bdf4ebeac841f2abdeb7=2E1790426?=
 =?utf-8?q?599=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cb65b7f33ed757e57ed99bdf4ebeac841f2abdeb7=2E17904265?=
 =?utf-8?q?99=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mxl862xx_devlink_flash_update() can run while
  dsa_register_switch() is still creating the user ports, and then touch…
- [Low] mxl862xx_port_mdb_add() and mxl862xx_port_mdb_del() test
  '(priv->block_host || priv->skip_teardown)' with plain loads after…
- [Low] The comment in mxl862xx_devlink_flash_update() says 'The core
  skips the re-probe if the device is unbound or shut down before it…
- [Low] Every devlink flash ends in a full driver re-probe:
  mxl862xx_remove(), then dsa_unregister_switch(), then a fresh probe.

--

net: dsa: mxl862xx: add devlink flash_update and info_get

This adds "devlink dev flash" and "devlink dev info" support to the
mxl862xx DSA driver. A flash validates the image and reboots the switch
into its MCUboot loader. It then streams the image over the SB PDI SMDIO
interface and reinitialises the driver through a deferred re-probe;
.remove() and ->shutdown() take the devlink instance lock first so they
wait for a flash that is already running.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> new file mode 100644
> index 0000000000000..9a3db7d43c733
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> @@ -0,0 +1,689 @@

[ ... ]

> +int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
> +				  struct devlink_flash_update_params *params,
> +				  struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	rtnl_lock();
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->user) {
> +			dev_close(dp->user);
> +			netif_device_detach(dp->user);
> +		}
> +	}

[Severity: High]
Can this loop run while dsa_register_switch() is still creating the user
ports?

dsa_switch_setup() calls dsa_switch_devlink_register() before
dsa_tree_setup() reaches dsa_tree_setup_ports() and
dsa_tree_setup_conduit(). DEVLINK_CMD_FLASH_UPDATE can therefore reach
this function at probe time. dsa_devlink_flash_update() does not check
ds->setup or dst->setup.

dsa_port_setup() only takes devl_lock inside dsa_port_devlink_setup(). A
port that has already passed that call can be in dsa_user_create() at
the same time as this function, and dsa_user_create() sets and clears
port->user without holding rtnl:

net/dsa/user.c:dsa_user_create() {
    ...
	port->user = user_dev;
    ...
	ret = dsa_user_phy_setup(user_dev);
    ...
out_free:
	free_netdev(user_dev);
	port->user = NULL;
}

This loop holds only rtnl. Could it detach a netdev that is not
registered yet? register_netdevice() would then set __LINK_STATE_PRESENT
again, and the port could be reopened during the flash.

Could it also call dev_close() or netif_device_detach() on a user_dev
that the error path above is freeing? The flash itself can drive that
error path: with block_host set, the PHY reads in dsa_user_phy_setup()
return -EBUSY.

The commit message says .remove() and ->shutdown() take the devlink
instance lock first because dsa_unregister_switch() frees the user
netdevs before devlink_unregister(). The dsa_register_switch() failure
unwind in mxl862xx_probe() frees them in the same order, but it has no
such guard:

	err = dsa_register_switch(ds);
	if (err) {
		set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
		...

Every flash ends in a re-probe, so this probe-time window opens again
after each flash. This looks unchanged at the end of the series.

> +	dsa_switch_for_each_cpu_port(dp, ds)
> +		dev_close(dp->conduit);

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

[Severity: Low]
Is the comment accurate when an unbind is followed by a rebind?

device_reprobe_work_fn() only checks:

	if (!dev->p->dead && dev->driver == rp->drv &&
	    !strcmp(dev->driver->name, rp->drv_name)) {

The device_schedule_reprobe() kernel-doc also says that an unbind
followed by a rebind of the same driver within the delay still gets
the re-probe.

Suppose mxl862xx_remove() is blocked on devl_lock() in
mxl862xx_flash_shutdown() while a flash runs. dev->driver is still set
and shutting_down has not been set yet, so device_schedule_reprobe()
succeeds here.

Now suppose the device is rebound to mxl862xx before the work takes the
device lock, for example by a scripted sysfs unbind/bind. Would the
stale work then detach and re-probe the newly bound instance?

That costs one extra teardown and reset of a healthy switch rather than
corruption, but the comment promises more than the core provides.

> +	if (err)
> +		dev_err(ds->dev,
> +			"flash: re-probe could not be scheduled (%pe); unbind and rebind to reinitialise\n",
> +			ERR_PTR(err));

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index e05ad52cd297e..8f8bd519de987 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

> @@ -1547,6 +1598,15 @@ static int mxl862xx_port_mdb_add(struct dsa_switch *ds, int port,
>  	qparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
>  
>  	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
> +	/* A flash blocks the API (-EBUSY) and its teardown drops the MAC
> +	 * table (-ENODEV); there is then nothing to program, and the reprobe
> +	 * rebuilds the configuration. The flash moves from block_host to
> +	 * skip_teardown outside this call, so either errno counts under
> +	 * either flag. See mxl862xx_port_mdb_del().
> +	 */

[Severity: Low]
The comment says "the reprobe rebuilds the configuration". Does it?

The re-probe runs mxl862xx_remove() -> dsa_unregister_switch() and then
a fresh probe, which destroys and recreates every user netdev. Anything
userspace configured on those netdevs is lost: bridge membership, VLANs,
addresses and MDB/FDB entries. The new probe only programs defaults for
new, unconfigured ports.

A flash that fails at step 1 goes through the same full teardown. That
is the case where SYS_MISC_FW_UPDATE returns an error and the old
firmware is still running.

The documentation at the end of the series only says the ports "come
back registered but down, so userspace brings them up again". Could the
comment and the documentation say that per-port configuration is lost?

> +	if ((ret == -EBUSY || ret == -ENODEV) &&
> +	    (priv->block_host || priv->skip_teardown))
> +		return 0;

[Severity: Low]
These flag loads run after mxl862xx_api_wrap() has released mdio_lock.
The flash path writes the flags as separate stores:

	priv->flash_owner = NULL;
	priv->block_host = false;
	priv->skip_teardown = true;

The mutex orders those stores only for readers that take the lock.

On a weakly ordered CPU such as arm64, a reader that got -EBUSY from the
block_host gate might see the new block_host == false together with the
old skip_teardown == false. Would it then return -EBUSY to switchdev
anyway?

That is the transition this check is meant to cover.
mxl862xx_port_mdb_del() has the same test. On error,
dsa_port_do_mdb_del() keeps the tracked entry.

These are also plain unannotated racy reads that KCSAN would report. The
next patch in the series uses READ_ONCE() for rescue_mode in the same
expression. This also looks unchanged at the end of the series.

>  	if (ret)
>  		return ret;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790426599.git.daniel%40makrotopia.org
