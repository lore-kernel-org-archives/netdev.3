Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE841D11D;
	Tue,  4 Aug 2026 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877802; cv=none; b=tB4PSZq68BIUNy63Rq3hh/hTmavgW9qNVSH2oHlOemrwxPwU5FyzP6wA5F7lvNmcvt/nU89Tiq0zdKALlmK0iyNARZU84CeiHPMqShQxb9VYFiSonqrZGtlxNpeGKk0R58+/igXrMaTLCRLUqXEGSPEjJD6Yd3Yy5QmRhG1uhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877802; c=relaxed/simple;
	bh=6xJuS7d+Bq7at5WjvJDNZE+NnxBBbs6FgLj52stjyE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+1gdMJdE/qW98lclqGfdQ/PhFb3WFBwlmOcHwA8Yi+HSpb1yPRPlVrl1LEzeXECHxJ+o7XX68FKWEevs8sMLisv8r+MHNURmgn9lSIkDrwtfHDLV3URLs3DfscJasB0PsqrPF0AbKe7/jtY2tU3dbKZk+nxU0kN+jn2342UX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpdRfyA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpdRfyA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7911C1F00A3A;
	Tue,  4 Aug 2026 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785877799;
	bh=DzacPbjzy8EiMC8VtVTjzjaOu/KR0fpQHwwLSzCAHhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gpdRfyA5WsG2+LKwaOboEZ0R74vDpQ1DZkCoO09y/RyjR7rWxJsnnQpPvYyT125qO
	 1hY2p4FIaKBdgWyV/lDIqlxIT/p303KNZkJJrIUCt78ANNTMCXe+Bk3nXsm5kkbWMb
	 dN+U7FGSqP/kumN1UCrfPS+ySvlr9atYku2QIWTXeXlNauDq70CXGParaOqzgWb1x7
	 A3ZABnzFF15m9w1LZQ18U9SFviAat/HBkohPoknWqflXrLY0KM30h6UFR8MHSk0Dfu
	 GVT17YgaICt2shhX1D9Q3vY8tta0q1hxu5PCE36A1y3cfu8Skc/BWUzEvFnAuQDI/b
	 AxBfOk5UIU7hQ==
Date: Tue, 4 Aug 2026 14:09:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jacob Keller
 <jacob.e.keller@intel.com>, <shshitrit@nvidia.com>, <tariqt@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: Defer netdev KOBJ_ADD uevent until the device
 is published
Message-ID: <20260804140958.3144eabb@kernel.org>
In-Reply-To: <20260804155103.742898-1-dtatulea@nvidia.com>
References: <20260804155103.742898-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 18:51:01 +0300 Dragos Tatulea wrote:
> netdev_register_kobject() calls device_add(), which emits KOBJ_ADD and
> wakes udev, but register_netdevice() only makes the device findable by
> name later, in list_netdevice().  A udev worker that reacts to the uevent
> can therefore run against a device that no lookup can find yet.
> 
> This used to be harmless because the ethtool ioctl took the rtnl_lock
> when looking the device up, and register_netdevice() runs under rtnl, so
> the worker simply blocked until registration finished. The commit in the
> fixes tag moved the lookup out from under rtnl for ops-locked drivers.
> Now there is a short window in register_netdevice() between
> netdev_register_kobject() until list_netdevice() when the device is not
> findable by name.
> 
> This was reproduced with the mlx5 driver on a kernel with KASAN enabled
> during devlink reload: systemd-udevd's net_driver builtin gets -ENODEV
> from ETHTOOL_GDRVINFO, which was preventing interface renaming.
> 
> Suppress the uevent in netdev_register_kobject() and emit it from
> register_netdevice() next to rtmsg_ifinfo(). This is the last point in
> register_netdevice() where no error can happen, so only fully registered
> devices are announced: the registration error paths never reach it, and
> the device_del() that unwinds them stays silent as well, leaving
> userspace with neither an add nor a remove.
> 
> Fixes: f994752b1127 ("net: ethtool: optionally skip rtnl_lock on IOCTL path")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

LGTM, one nit..

>  net/core/dev.c       |  1 +
>  net/core/net-sysfs.c | 16 ++++++++++++++++
>  net/core/net-sysfs.h |  1 +
>  3 files changed, 18 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c1c1be1a6962..32cc092d5d11 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11499,6 +11499,7 @@ int register_netdevice(struct net_device *dev)
>  	 *	Prevent userspace races by waiting until the network
>  	 *	device is fully setup before sending notifications.
>  	 */
> +	netdev_uevent_add(dev);
>  	if (!(dev->rtnl_link_ops && dev->rtnl_link_initializing))
>  		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
>  
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 0e71c9ed41e8..9a403259a3d0 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -2334,6 +2334,11 @@ int netdev_register_kobject(struct net_device *ndev)
>  		*groups++ = &wireless_group;
>  #endif /* CONFIG_SYSFS */
>  
> +	/* Hold back the KOBJ_ADD uevent until the device is discoverable
> +	 * by name.

nit: maybe just say "until the device is listed" ?
Or there's some less than obvious relevance of the name lookup 
vs ifindex lookup?

> +	 */
> +	dev_set_uevent_suppress(dev, 1);
> +
>  	error = device_add(dev);
>  	if (error)
>  		return error;
> @@ -2349,6 +2354,17 @@ int netdev_register_kobject(struct net_device *ndev)
>  	return error;
>  }
>  
> +/* Announce a fully registered device to userspace. This pairs with the uevent
> + * suppression from netdev_register_kobject();

nit: s/;/./ ?

> + */
> +void netdev_uevent_add(struct net_device *ndev)
> +{
> +	struct device *dev = &ndev->dev;
> +
> +	dev_set_uevent_suppress(dev, 0);
> +	kobject_uevent(&dev->kobj, KOBJ_ADD);
> +}

Please wait for Clashiko to cross-review before posting v2.
-- 
pw-bot: cr
