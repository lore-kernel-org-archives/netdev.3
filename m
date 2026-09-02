Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEB3876BB
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379608; cv=none; b=aAB+4lfoNLXxEB/Ew2M8eIZhl/6dkU66FWHCstZnirzFvA9mv3s6GgZx3l0FEveC4dcW2Ev+jWqYjSb61kPRF2iwF0sKVmUKhwtwGi32/xBzlUiAs7tciU0s7VLT4QgfXSXsfOSUqbN5V9RJVBviuvQjrHNpYYd8B9fn+cuaLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379608; c=relaxed/simple;
	bh=tORk9YRaKq8coxtAkv9z3oKm3x3VzIOvr1YIJQcM84I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2Pen9+/xU9KDS6Iapn6Ch79NVTW2TM+lgABrCRGLoOlhOjO7HBM1cKSBezKS2wkd2nJnWbGbbCQok3yPyp0kvgRC4HljlCFWcTDEctF9puQQe46B1pZsDB5Ns4Y3oq6nHQg757HQRrkggosp9DsV6HUz6fwaTiooCLpVVhM6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT1fp9c1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT1fp9c1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59D01F000E9;
	Wed,  2 Sep 2026 20:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379605;
	bh=e+6avOhkX2a5nm3hAX8xbb0ClyrPNQV7k96dYGXW578=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MT1fp9c1W5XNqKhcX6GOQVpcnlXVDNwkhIVniTGA+zNRQ3yPLru78Xy8nQ3cBE/eS
	 Zf1D4k2O+IxNHjtwzL8iuhViYfmzDmPppDR9djQxbjgMFEnNprG4t4qr1Snagl5YhB
	 4O0k6x7O3jhjYzDxlEh8mif/Cg/paq6qh/kk8BRYEwNGf4LXEEBQCyWQr74+7bSYfj
	 iAs1fVkHKiEH0qbOhPVH8bHTDo9gP/4r5T0h7ipYmP/CGN9y3FYPiCY2RFjxyuEliT
	 AdezDb7OAhDR40XTaEQ63/KUS28wp0wf6asCknNsPH8l7GR3ngafJVwH2Hf8Tf5UFR
	 f/1KQ9/Fd8ohA==
Subject: Re: [net-next] net: sysfs: use ops lock for speed and duplex
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com
Date: Wed, 02 Sep 2026 20:06:44 +0000
Message-ID: <178837960413.3394541.4377119381016247697@kernel.org>
In-Reply-To: <20260831080623.1064001-1-wang.zhan@smartx.com>
References: <20260831080623.1064001-1-wang.zhan@smartx.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] In the new non-RTNL fast path of sysfs_get_link_ksettings()
  (net/core/net-sysfs.c:141-149), a read of…

--

net: sysfs: use ops lock for speed and duplex

This moves the speed and duplex sysfs reads off rtnl_lock() for ops-locked
devices whose get_link_ksettings callback does not set
ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS, taking the netdev instance lock
instead.  The new helper sysfs_get_link_ksettings() keeps sysfs_rtnl_lock()
for legacy devices and for callbacks that opt into RTNL.

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 352173df75785..3e01e7f3cac79 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -118,6 +118,55 @@ static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
>  	return ret;
>  }
>  
> +/*
> + * Use the per-device ops lock without RTNL when the device supports it.
> + * Legacy devices and callbacks which explicitly require RTNL retain the
> + * existing locking.
> + */
> +static int sysfs_get_link_ksettings(struct device *dev,
> +				    struct device_attribute *attr,
> +				    struct ethtool_link_ksettings *cmd)
> +{
> +	struct net_device *netdev = to_net_dev(dev);
> +	int ret = -EINVAL;
> +	bool need_rtnl;
> +
> +	/*
> +	 * The check is also done in netif_get_link_ksettings(); this helps
> +	 * returning early without hitting the locking section below.
> +	 */
> +	if (!netdev->ethtool_ops->get_link_ksettings)
> +		return ret;
> +
> +	need_rtnl = !netdev_need_ops_lock(netdev) ||
> +		    (netdev->ethtool_ops->op_needs_rtnl &
> +		     ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS);
> +	if (need_rtnl) {
> +		ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +		if (ret)
> +			return ret;
> +	}
> +	netdev_lock_ops(netdev);

[Severity: Medium]
When need_rtnl is false, sysfs_get_link_ksettings() skips sysfs_rtnl_lock()
and therefore also skips the dev_hold() and
sysfs_break_active_protection() that it performs, then sleeps in
netdev_lock_ops() -> mutex_lock(&dev->lock) while the kernfs active
reference on the speed/duplex attribute is still held.

Can that delay the unregistration path?  unregister_netdevice_many_notify()
runs with rtnl_lock held (ASSERT_RTNL at its entry) and reaches:

net/core/dev.c:unregister_netdevice_many_notify() {
	...
		/* Remove entries from kobject tree */
		netdev_unregister_kobject(dev);
	...
}

device_del() -> kernfs_drain() on the speed node then waits for the sysfs
reader to return, so RTNL stays held for as long as some other thread holds
the instance lock, for example an mlx5 channel or ring reconfiguration.
That is the same multi-hundred-millisecond work the commit message wants to
keep out of RTNL.  Before this patch the reader had already broken active
protection before blocking, so it could not hold up the drain.

The second half is the interruptibility change.  sysfs_rtnl_lock() waits
like this:

net/core/net-sysfs.c:sysfs_rtnl_lock() {
	...
	if (rtnl_lock_interruptible()) {
		ret = -ERESTARTSYS;
		goto unbreak;
	}
	...
}

mutex_lock(&dev->lock) in netdev_lock_ops() has no interruptible variant
here, so a world-readable poller of /sys/class/net/<dev>/speed can end up
uninterruptible in D state for the duration of a driver reconfiguration.
Would it make sense to keep sysfs_break_active_protection() and dev_hold()
around the instance-lock acquisition, or to use netdev_trylock() with a
retry that drops the active reference first, so sysfs readers still cannot
stall the rtnl-holding teardown?

For context, netdev_lock_store() already takes netdev_lock() from a sysfs
handler without breaking active protection, so the pattern itself is not
new; the difference here is that it now applies to a world-readable
attribute that monitoring agents poll continuously rather than to a rare
CAP_NET_ADMIN write.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831080623.1064001-1-wang.zhan%40smartx.com
