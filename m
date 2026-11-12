Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524866;
	b=BxB90l0D0PVIOE0g61dlzp5fcSOOx9mqWN8ThgX4Rqb6W5OgMW4B4NhVDD3BoJUynl4E
	 GIiN8izahBkabrzLYqzeN6W5qFEiqP+yyRvvWX7MZ7OosTwQPUGePMDgbziwXQeYuaImS
	 JvTv7Jfkdr2TYwm5dkomr5bx7sklJCH+zYfu9C/24n2ejhsV1134PGHS6w99SxDnJVoca
	 JQybhjTf1NRPxa3vRBgIGM6v5qKNYOEqKtFJ4Uf3gsN2LBbnqerinsJV8EUfI/9WNFUBp
	 0doPlWndI1pAhnRGoI3L6qcwOag+PKdo1Bi2IY7ye7g03lHkQx924clRLca2DLWfeCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524866;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kwvhBROgGLYXX5110m8gVaskdMzIOQh6wfk3vJkebvY=;
	b=H6KFTaLSuUt3aETC017z9J+exb/vFg4WPvClyFbPf3ZSQapYmx7VHH/BT1BnrFv6so4M
	 xSbTdug1MlBwNsraI8fBW5V9yMLeXwwHOdgA2AY22WSRmrk87pkZBC6jorp7URkmYhb2k
	 9BhwEWiqF/nC2NRCKD8OAmZ3KVO7N1DKtCB/9QU/poG8m08wbi8W7N9W5AdMuy8NJvmQA
	 JLvAHTrFsnDkwVEf7+aITQ0eTfHg5YctGB5PhXxLCtMbQmt4afk0im0f3zkr9MUYB8smT
	 pXH7pgGOow2icqPpnqrDA0kUpJkrrgqHdxqDw8YxCiO3u3kJt5BCspg3BLpuWerHovA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnn9v53q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA51606A33D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnn9v53q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5F41F000C4;
	Thu, 12 Nov 2026 23:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524866;
	bh=kwvhBROgGLYXX5110m8gVaskdMzIOQh6wfk3vJkebvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nnn9v53qOEjykiakgOJuz3+mN/hmhzDcj/AjXzN3E+eVHiYsd7ze4X6Lxhf11YzpO
	 S8gylG1snjLL75ENmH464HIcoh+T9TCUyGomkw1hLMcQr7Y1aoBQ7j/ZbSlMpxSPwv
	 BtQKCrVNpJ4XM16Ohrx3smfIaDoz/iGfZ6g2rilXuDFOvOy18OkZdOdCnQUAhp/qdm
	 gTlKWBHGkaRQK+AboOUm6og0keP9RJqqINpUoguXJVNlBugLwBO5Z2pDQUb69CYK4c
	 idc9bXhNKaj5Lh4hBigwDAUPHwcDJe7HTDVzhiXaNmmsFmndrpZOpwHP0Zvi3LY/U3
	 rlOtvz6OAQLgQ==
Subject: Re: [PATCH net-next v5 14/15] devlink: add devlink_alloc_drv()
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com, edumazet@kernel.org,
 horms@kernel.org, pabeni@redhat.com, davem@davemloft.net, jiri@resnulli.us,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
 anzaki@gmail.com, brett.creeley@amd.com, ohartoov@nvidia.com,
 poros@redhat.com
Date: Thu, 12 Nov 2026 23:07:44 +0000
Message-ID: <179452486422.2199510.5670274694417683707@kernel.org>
In-Reply-To: <20261110141534.95614-15-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-15-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new kernel-doc for devlink_alloc_drv()
  (net/devlink/core.c:534-549) says it is for 'a device bound to another…
- [Low] devlink_alloc_drv() separates the owning driver from
  devlink->dev, but the core's device-lock invariant is not adjusted.

--

devlink: add devlink_alloc_drv()

This patch adds devlink_alloc_drv(), a variant of devlink_alloc() that
takes the owning driver explicitly instead of using the driver bound to
@dev. The intended first user is ice, which creates a devlink instance
for each of its VFs. The devlink-info documentation is updated to say
that such an instance reports the creating driver's name.

> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index 9b844e0c1bd2d..e2a7169287ec7 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c
> @@ -531,6 +531,30 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  }
>  EXPORT_SYMBOL_GPL(devlink_alloc_ns);
>  
> +/**
> + * devlink_alloc_drv - Allocate new devlink instance resources for given driver
> + * @ops: ops
> + * @priv_size: size of user private data
> + * @dev: parent device
> + * @drv: driver that owns the instance
> + *
> + * Variant of devlink_alloc() for a driver that creates an instance for
> + * a device bound to another (or no) driver, e.g. a PF driver for its VFs.

[Severity: Low]
Should this kernel-doc also say that the driver bound to @dev must not
register its own devlink instance on the same device?

When @dev is bound to another driver, one struct device can end up with
two devlink instances: one from the bound driver via devlink_alloc(dev),
and one from the creating driver via devlink_alloc_drv(). Nothing in the
core keeps bus/dev handles unique. devl_register() only sets the
DEVLINK_REGISTERED mark.

Handle lookup in devlink_get_from_attrs_lock() returns the first
registered match:

net/devlink/netlink.c:devlink_get_from_attrs_lock() {
    ...
	devlinks_xa_for_each_registered_get(net, index, devlink) {
		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
		    strcmp(devlink_dev_name(devlink), devname) == 0)
			goto found;
		devlink_put(devlink);
	}
    ...
}

If both instances are registered, would pci/<BDF> commands only ever
reach the instance allocated first, leaving the other reachable only by
DEVLINK_ATTR_INDEX?

No in-tree pair seems to hit this today. iavf and vfio-pci, the drivers
that can bind an E800 VF, do not register devlink. The new API does
document this use case without stating the constraint, though.

> + *
> + * @drv must not be NULL and must outlive the instance, only a pointer to it
> + * is kept. Operations that take the device lock, like reload, lock @dev,
> + * not a device bound to @drv.

[Severity: Low]
This note describes the lock difference, but should the core comments
that still state the old invariant be updated as well?

devlink_reload() still says the device lock closes races with
probe/remove:

net/devlink/dev.c:devlink_reload() {
    ...
	/* Make sure the reload operations are invoked with the device lock
	 * held to allow drivers to trigger functionality that expects it
	 * (e.g., PCI reset) and to close possible races between these
	 * operations and probe/remove.
	 */
	if (devlink->dev)
		device_lock_assert(devlink->dev);
    ...
}

The ASSERT_DEVLINK_REGISTERED comment in devl_internal.h says the
pre-register phase is done "by implicitly holding device_lock". For the
ice user that is not the case: ice_init_vf_devlink() runs from the PF's
sriov_configure path under table_lock, not under the VF device lock.

For a devlink_alloc_drv() instance, devl_dev_lock() takes the VF's
device lock, not the lock of the device the owning driver is bound to:

net/devlink/devl_internal.h:devl_dev_lock() {
	if (dev_lock && devlink->dev)
		device_lock(devlink->dev);
	devl_lock(devlink);
}

This path is used by the DEVLINK_CMD_RELOAD pre_doit and by
devlink_pernet_pre_exit(). If a future devlink_alloc_drv() user provides
reload ops, would reload_down/up run without serialization against that
driver's own probe/remove/sriov_configure?

There is also a possible ordering issue there. The VF device_lock ->
VF devl_lock ordering could be inverted by PF SR-IOV teardown, since
pci_disable_sriov() takes the VF device lock.

With the current ice user this cannot happen. It uses empty devlink_ops,
the instance is fixed to init_net, and pci_disable_sriov() is called
before table_lock is taken. Would it help to add ordering guidance, or
to reject reload ops for instances created this way?

> + *
> + * Return: new devlink instance, NULL on failure.
> + */
> +struct devlink *devlink_alloc_drv(const struct devlink_ops *ops,
> +				  size_t priv_size, struct device *dev,
> +				  const struct device_driver *drv)
> +{
> +	return __devlink_alloc(ops, priv_size, &init_net, dev, drv);
> +}
> +EXPORT_SYMBOL_GPL(devlink_alloc_drv);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
