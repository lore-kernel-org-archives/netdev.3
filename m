Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122119;
	b=uPl0lQ3stGvqVdYYsnd3IPyTthaayMCuCQPQDZtF9AxmawoL02JjSQRPTUeG3GL7EDD+
	 npFIXfe19LQxjeiUV6WEGB33qGBBJjqbvM7+lBfi78nVrNFo3x8jEPMAG8jidtfrMillR
	 w86zZeaNEkrgyrlleS7wZ1VIaAPXqqyTA9v2qGWtBC2f8ruT1clfsIbmytFizssGuH8xs
	 b1NTb7+F3QobjRZzCtEHqv4OS91wFcKoqkhVshs/jktoqXz4G4Zw4xuiKK0E86evb0Scl
	 J4fZ3w991dGJ6OjFIcErUYrWlgFVfu3K/ZwjbHRswbgNC/qbKF+CS0IEdrYaCCqvAIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122119;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5cxGZedX/NjJ4QTNJLPpwF04lBluCSG8LxM8JDapM/0=;
	b=j92wd+UHtzcPIlYhzTfYo+8AS+LVZL/zvz41MlEjDC1CnURFB0jF8lUAJsqkCynDBqN7
	 TDyIxaU/4Hm8QP9PnR9uwc8BD7iR8Aq4/UvBdUrvSEFTQTVEpMu1Ct9oU252q/mqXMTem
	 Y3jn21FBhgUC8p950bJp8u4chLCtJNUlT6c96+j7PkvcjVDD6NmOgrv70dUqcEIAWtq4B
	 jxPquix4ELPiuCKvdruid2iutrX/vkIzJGnp0QOGPLmhG6bWHHtMkNkzJCp6gvwMwgkUZ
	 NZfphEo2fHhIrKddHfe6cwSlFSD9cCG1wKIL3fSKc/Xyk8kHCVUzzptoTj4zAt4z9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rskmnxn/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0284D606A31C;
	Sun,  8 Nov 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rskmnxn/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F121F0089F;
	Sun,  8 Nov 2026 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122118;
	bh=5cxGZedX/NjJ4QTNJLPpwF04lBluCSG8LxM8JDapM/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rskmnxn/5T4CuFiXDZmW6CZHHvU6cGPawZZP9BTdzw2toEdjOEzk8LmqB2tZ3pdQf
	 8Ws6rqEU8rjL8oRGsmqrRtp31GFT0LlrFw1cQIq3Z8i3W2SVmuN7Gijrf2x3+fitaG
	 vGOWaFl+cjCzuydvKuOZo1aFhlcY/0dW3Q8PHXhW9vHKQaIO02dpot3Hhqsl3YFB1U
	 5cDbMhIjngjo0525sUfFQGLnS5aimpCsNLO+Q1w3sZ3J+1bRRYhuhMRpHoPXuU5rF9
	 vbI2sOqI89KQk3eQ/sb3/Vsi8GYTyO8XhGqV8S/YEFJJtNZ//Uc8msFFP2ORFX3yUr
	 8p9REx11Xvf5Q==
Subject:
 Re: [PATCH net] net: phy: micrel: Fix potential shared PHC use-after-free
From: netdev-bot+sashiko@kernel.org
To: liguangshuo@mail.sdu.edu.cn
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 07:15:17 +0000
Message-ID: <179412211753.994134.17784194438511923338@kernel.org>
In-Reply-To: <20261107-0d0c29e10a-net-micrel-lan8814-1@mail.sdu.edu.cn>
References: <20261107-0d0c29e10a-net-micrel-lan8814-1@mail.sdu.edu.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] lan8814_ts_info() now calls mutex_lock(&shared->shared_lock),
  which can sleep, but the ethtool core always calls this callback…
- [Medium] After a member leaves, the shared PHC stays registered as a
  device-model child of the first PHY's mdio.dev.
- [Medium] lan8814_ptp_leave() uses shared->clock_stopping as a gate for
  a code region.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same
  driver's LAN8841 PHC has exactly the use-after-free this commit…

--

net: phy: micrel: Fix potential shared PHC use-after-free

The patch moves the LAN8814/LAN8842 shared PHC pin array out of devm and
into package scope, and tracks which package members are bound. When a
member leaves, register access moves to a remaining PHY. The clock is
unregistered when the last member leaves, and shared_lock now also guards
ts_info and the GPIO interrupt path.

> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index d0b1ad21667b6..8c48d00b0ccf6 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c

[ ... ]

> @@ -3257,7 +3261,13 @@ static int lan8814_ts_info(struct mii_timestamper *mii_ts, struct kernel_ethtool
>  				SOF_TIMESTAMPING_RX_HARDWARE |
>  				SOF_TIMESTAMPING_RAW_HARDWARE;
>  
> +	mutex_lock(&shared->shared_lock);
> +	if (!shared->ptp_clock || shared->clock_stopping) {
> +		mutex_unlock(&shared->shared_lock);
> +		return -ENODEV;
> +	}
>  	info->phc_index = ptp_clock_index(shared->ptp_clock);
> +	mutex_unlock(&shared->shared_lock);

[Severity: High]
Can this mutex_lock() sleep inside an RCU read-side critical section? The
ethtool core calls the ts_info callback with rcu_read_lock() held:

net/ethtool/common.c:__ethtool_get_ts_info() {
	rcu_read_lock();
	hwprov = rcu_dereference(dev->hwprov);
	...
		if (phy_is_default_hwtstamp(phydev) &&
		    phy_has_tsinfo(phydev)) {
			err = phy_ts_info(phydev, info);
	...
	err = ethtool_get_ts_info_by_phc(dev, info, &hwprov->desc);
	rcu_read_unlock();
	return err;
}

phy_ts_info() calls phydev->mii_ts->ts_info() directly. For LAN8814 and
LAN8842 that callback is lan8814_ts_info().

shared_lock is also held across slow MDIO accesses by gettime64, adjfine,
adjtime and the GPIO interrupt thread. While ptp4l or phc2sys is running,
this path can block for real.

Any user can reach it with ethtool -T, ETHTOOL_MSG_TSINFO_GET, the
ETHTOOL_GET_TS_INFO ioctl, or SO_TIMESTAMPING with
SOF_TIMESTAMPING_BIND_PHC. With CONFIG_DEBUG_ATOMIC_SLEEP or PROVE_RCU,
won't each call print a "sleeping function called from invalid context"
splat? On non-preemptible RCU kernels, won't it hit "scheduling while
atomic"?

[ ... ]

> @@ -4636,12 +4649,90 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
>  	return 0;
>  }
>  
> -static int lan8814_ptp_probe_once(struct phy_device *phydev)
> +static void lan8814_ptp_leave(void *data)
> +{
> +	struct phy_device *phydev = data;
> +	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
> +	struct phy_device *next = NULL;
> +	unsigned int i;
> +
> +	phy_package_lock(phydev);
> +	mutex_lock(&shared->shared_lock);
> +	shared->members[phydev->mdio.addr] = NULL;
> +	for (i = 0; i < ARRAY_SIZE(shared->members); i++) {
> +		if (shared->members[i]) {
> +			next = shared->members[i];
> +			break;
> +		}
> +	}
> +	if (next) {
> +		shared->phydev = next;
> +		mutex_unlock(&shared->shared_lock);
> +		phy_package_unlock(phydev);
> +		return;
> +	}

[Severity: Medium]
This handoff only switches shared->phydev. The PHC device is still a child
of the PHY that registered it, because lan8814_ptp_register() does:

	shared->ptp_clock = ptp_clock_register(&shared->ptp_clock_info,
					       &phydev->mdio.dev);

and ptp_clock_register() sets ptp->dev.parent once, at registration time.

mdiobus_unregister() removes PHYs in ascending address order. For the
registering PHY, phy_device_remove()->device_del(&phydev->mdio.dev) first
runs lan8814_ptp_leave() and takes this handoff path. It then deletes the
device and its sysfs subtree, including the ptpN directory with its pins
and n_vclocks attributes, while /dev/ptpN is still live.

The last member then calls ptp_clock_unregister()->device_del() on a child
whose parent has already been deleted.

Is this parent-before-child removal order intended? After a sysfs unbind
of the first PHY, the PHC also stays parented under a PHY with no driver
bound, so the ptpN to device link userspace sees is wrong.

I don't see a crash from this. sysfs_remove_group() only pr_debug()s, and
the child still holds a reference on the parent kobject. But isn't the
PHC's device-model lifetime still tied to the first member, even though
the commit is meant to fix PHC lifetime across package members?

> +
> +	shared->clock_stopping = true;
> +	mutex_unlock(&shared->shared_lock);
> +	/* Unregister calls enable() to disable events, using the last PHY. */
> +	ptp_clock_unregister(shared->ptp_clock);
> +	mutex_lock(&shared->shared_lock);
> +	shared->ptp_clock = NULL;
> +	shared->phydev = NULL;
> +	kfree(shared->pin_config);
> +	shared->pin_config = NULL;
> +	shared->clock_stopping = false;
> +	mutex_unlock(&shared->shared_lock);
> +	phy_package_unlock(phydev);
> +}

[Severity: Medium]
Is shared->clock_stopping acting as an ad-hoc lock here? It is set before
the unlocked ptp_clock_unregister() call and cleared after it.
lan8814_ts_info() and lan8814_handle_gpio_interrupt() check it to avoid
shared->ptp_clock during that window. Lockdep can't see this gate.

The flag seems to exist because shared_lock can't be held across
ptp_clock_unregister(): ptp_disable_all_events() calls info->enable() ->
lan8814_ptp_extts(), which takes shared_lock.

One side effect: an EXTTS capture interrupt can arrive in this window,
before ptp_disable_all_events() clears PTP_COMMON_INT_ENA_GPIO_CAP_EN.
lan8814_handle_gpio_interrupt() then skips the capture:

	if (shared->ptp_clock && !shared->clock_stopping)
		ret = lan8814_gpio_process_cap(shared);
	else
		ret = -ENODEV;

PTP_GPIO_CAP_STS is never read, and lan8814_handle_interrupt() and
lan8842_handle_interrupt() treat the -ENODEV as not handled.
lan8814_ts_info() also returns -ENODEV during the window.

Could this teardown use a real lock or RCU instead of a flag?

[ ... ]

> @@ -7006,6 +7106,7 @@ static struct phy_driver ksphy_driver[] = {
>  	.flags		= PHY_POLL_CABLE_TEST,
>  	.driver_data	= &lan8814_type,
>  	.probe		= lan8842_probe,
> +	.remove		= lan8814_remove,
>  	.config_init	= lan8842_config_init,
>  	.config_intr	= lan8842_config_intr,
>  	.inband_caps	= lan8842_inband_caps,

[Severity: High]
This isn't a bug introduced by this patch, but the LAN8841 PHC in the same
driver seems to have the same use-after-free this commit describes, and it
is left unfixed.

lan8841_probe() allocates ptp_priv->pin_config with
devm_kcalloc(&phydev->mdio.dev, ...). ptp_priv->ptp_clock_info is embedded
in the devm-allocated kszphy_priv. The clock is registered with:

	ptp_priv->ptp_clock = ptp_clock_register(&ptp_priv->ptp_clock_info,
						 &phydev->mdio.dev);

The LAN8841 phy_driver entry has no .remove, and no devm action is added.
After this patch, the only ptp_clock_unregister() in micrel.c is the one
in lan8814_ptp_leave().

When a LAN8841 PHY is unbound (sysfs unbind, or MAC/MDIO bus removal),
devres frees priv and pin_config. /dev/ptpN stays registered with
ptp->info pointing into the freed memory.

Wouldn't a later PTP_CLOCK_GETCAPS, a clock_gettime() through
info->gettime64, or a pin sysfs access then use freed memory? A ptp4l that
still holds the fd open would hit this.

Should LAN8841 get the same treatment, either in this patch or in a
follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-0d0c29e10a-net-micrel-lan8814-1%40mail.sdu.edu.cn
