Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C338838B;
	Mon, 14 Sep 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410900; cv=none; b=Hdhjfx1lcE+EQTRXYvmwf0Srzl11LrbTi2PqoVwCFpRh2Q5+U1qSsrLGwSV8gE18SCXyQenbIchFUOgAabTjXhqn895Qv3K/66Wl5WEPVLYBstFm7sYakBJJYFHHg93pzAo6sKiiL2jU3iV/ciwss4OUIocYfASdhbMjJ9Q0qjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410900; c=relaxed/simple;
	bh=zg2erTNsC6o9DHEtoYcqfu30vxBh5tez9HM84aQE3N4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+vS4TcKJXbOgVdsu0uxM+OzluZ+/7yVI3VBezMgUgnKYwQBzZLFbCXJ3gmDgmdQTh9lyZ++ROFzP0i7LpWqbo4JwJNSJ30ymfsqaOC2M6QjBq/eNTlqnJAIeaqU9pjKNCwj+gpyVXZXY5L3RH96rhYjKokOFAtk0+zi1+CZtHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/MSDne8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/MSDne8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE11F00898;
	Mon, 14 Sep 2026 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410896;
	bh=IndS3m/ZBMWO5kigMQ1UJ2/+wByPnZUmX+G6fs5VcD4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P/MSDne8FvVVtjFWFwPTDD8KYW2vU8nKSO0JofzGUTl0KfhmeBJpASEc45IYiQdsd
	 fkw8azGvYGR2R2NRNUtYGZ/yoPd3OTM9hXXPT4Rs3twCSfr2Hd5Bx8JQUSNn7VrWZs
	 ZMWz8ZDYQzUpwsxgI9jZwrM/1GL9XNCF0SAB+KL75LO+kyVa2HXiMNR8uwQv4ehPYI
	 w1jsu8Cqi8RZkAzt/83PDMPVEgO+2xAqWi/k77hIJ1ESSHQnkxsygLUfYEU0nx0K/i
	 JfxlXCf8biR/LQTsRjR+aZg37kUjN70RqGY0cb0+LRx4JkrCLRg/tZbaczbcBuzXHC
	 5oaqG1N+z8vvA==
Subject: Re: [PATCH net-next v15 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Mon, 14 Sep 2026 18:34:55 +0000
Message-ID: <178941089525.22033.5761455207730360931@kernel.org>
In-Reply-To: =?utf-8?q?=3C377a73c5ff437600212eb2323f13cea450cedc81=2E1789175?=
 =?utf-8?q?618=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C377a73c5ff437600212eb2323f13cea450cedc81=2E17891756?=
 =?utf-8?q?18=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] AB-BA deadlock between the devlink instance lock and the driver-
  core device lock.
- [Low] drivers/net/dsa/mxl862xx/Kconfig does not `select CRC32` although
  the new mxl862xx-fw.c calls crc32_le() twice in…

--

net: dsa: mxl862xx: add devlink flash_update and info_get

This adds devlink dev info version reporting (asic.id, asic.rev and the
running/stored firmware version) and devlink dev flash support for the
MxL862xx switch, transferring a validated image over the SB PDI protocol
after rebooting the switch into its MCUboot loader and then scheduling a
deferred re-probe.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> new file mode 100644
> index 0000000000000..119792eb7bd58
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> @@ -0,0 +1,648 @@

[ ... ]

> +#include <linux/crc32.h>

[ ... ]

> +	if (size1) {
> +		crc = ~crc32_le(~0U, payload, size1);
> +		if (crc != le32_to_cpu(hdr->image_checksum_1)) {
> +			dev_err(&priv->mdiodev->dev,
> +				"flash: image 1 CRC mismatch (got %08x, expected %08x)\n",
> +				crc, le32_to_cpu(hdr->image_checksum_1));
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (size2) {
> +		crc = ~crc32_le(~0U, payload + size1, size2);

[Severity: Low]

Should drivers/net/dsa/mxl862xx/Kconfig also select CRC32 for these two
new crc32_le() users in mxl862xx_flash_validate()?

The driver's Kconfig currently has:

config NET_DSA_MXL862
	tristate "MaxLinear MxL862xx"
	depends on NET_DSA
	select CRC16
	select NET_DSA_TAG_MXL_862XX

CRC16 is selected for the crc16() user in mxl862xx-host.c, but nothing
selects CRC32. In lib/crc/Kconfig, CRC32 is a bare tristate with no prompt
and no default:

config CRC32
	tristate
	select BITREVERSE
	help
	  The CRC32 library functions.  Select this if your module uses any of
	  the functions from <linux/crc32.h> or <linux/crc32c.h>.

and lib/crc/Makefile builds crc32.o under obj-$(CONFIG_CRC32), so with
CONFIG_CRC32=n (or CRC32=m while NET_DSA_MXL862=y) does this fail to link
with an undefined crc32_le? The select is still missing at the end of the
series.

[ ... ]

> +int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
> +				  struct devlink_flash_update_params *params,
> +				  struct netlink_ext_ack *extack)
> +{

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

[Severity: High]

Can this call deadlock against a concurrent unbind of the same mdio
device?

.devlink_flash_update runs with the devlink instance lock held by the
netlink core:

devlink_nl_pre_doit()
  __devlink_nl_pre_doit()
    devlink_get_from_attrs_lock()
      devl_dev_lock(devlink, false)   /* devl_lock() only */

and device_schedule_reprobe() then takes device_lock() synchronously in
that context:

drivers/base/dd.c:device_schedule_reprobe() {
	...
	device_lock(dev);
	parent = dev->parent;
	if (!dev->bus || !dev->p || dev->p->dead ||
	    !device_is_registered(dev) || !dev->driver) {
	...
}

So this path is devl_lock -> device_lock.

The opposite order exists in the unbind path, where the driver core holds
device_lock across ->remove():

device_release_driver_internal()   /* holds device_lock(&mdiodev->dev) */
  mxl862xx_remove()
    dsa_unregister_switch()
      dsa_switch_teardown()
        dsa_switch_devlink_unregister()
          devlink_unregister()
            devl_lock()

devlink itself documents the same order in net/devlink/devl_internal.h:

static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
{
	if (dev_lock && devlink->dev)
		device_lock(devlink->dev);
	devl_lock(devlink);
}

For DSA, devlink->dev is ds->dev, i.e. &mdiodev->dev, so both locks in
the cycle are the same two objects. If a sysfs unbind or rmmod runs while
devlink dev flash is in progress, does one thread end up holding
device_lock and waiting on devl_lock while the flash thread holds
devl_lock for the whole transfer and then waits on device_lock?

Both are plain mutexes with no trylock or timeout here, and
device_initialize() marks dev->mutex with lockdep_set_novalidate_class(),
so would lockdep report this cycle at all?

Would scheduling the re-probe from a context that does not hold the
devlink instance lock, or a variant of the helper that does not take
device_lock in the caller's context, avoid the inversion?

> +
> +	return ret ? ret : err;
> +}

Please double check this analysis, and thanks for your time reviewing it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789175618.git.daniel%40makrotopia.org
