Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313837B007;
	Fri,  9 Oct 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529247; cv=none; b=Cp0d39CBCQsoilInqQaFcrbpK8dSFTZqm9Uv2SkIZyGPi5ZCa9Lxm0K4obvXhpqfjI+wWn8REww8ZbqbwFlsDnvCO76InaI6vcvpx3RtFZ1RRhudgE2uil1csP6deaCQnTnV8lylbwHY64hoifNgizzj/V6KhI/e5ILmhpmGOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529247; c=relaxed/simple;
	bh=ckElBkS9+tdVDyCxVoJQJkM2G6wUaP7exjVN4bYTrRo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YV6gORD01XhpSdxoSg+h8qyvv46WWRCPNX7ePagaa1ynfOzE/f8/jMSSXI3I51uhwkY0OWQACASke+ftRYV+vTNUL+7lzwCR1iPhLFfGGiemUd13QplOxEJnWHMtvMu6bJOXsesVOzrabZ3tcpQbcIqXgpUzR0/TJlcRVcYf6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmRXmJWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmRXmJWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB00E1F000FF;
	Fri,  9 Oct 2026 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791529246;
	bh=RqaQU6I3O2hufZGcfggLPAPI1ZitTMaj6ScsV/2uPIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EmRXmJWnH84iRkAnnEz6m/3/wAErDsQ8SIq6Ebk/nuZAhlC0ioN8WdbwqUcnVPOTB
	 mmjL/wqlSP6uFHE51ZXYnBsS9z3CT9zdWMEiOfa6WS7DtlpM6SbjBU7FUOO8LsYc1h
	 Fmdw6dDt+PI9M9Niqddg9azY/lhafSAIdpx9o/RYAZBclzaBv13tYZpak/zmOHA6VU
	 vgjxxXRveck/Ntyot/tbWOg6DUt0CALw1LpZ7C34rqLVuBzB4HW2iPH0/2M+3uhjSK
	 yAPF9vy71gS/T7lsXL39vNicNHstH/1L9HskUdXbiSbL9HyyGUJDJcnawSOsMqY2lw
	 FlL7z+0fhAraQ==
Subject: Re: [PATCH net-next 1/2] netconsole: avoid printing partially updated
 target attributes
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 07:00:45 +0000
Message-ID: <179152924550.434549.6528431556113648959@kernel.org>
In-Reply-To: <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com>
References: <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is meant to stop *_show() callbacks from racing with
  writers, but local_mac_show() in drivers/net/netconsole.c is still…
- [Low] The commit fixes a user-visible race: reading local_ip,
  remote_ip, dev_name, remote_mac or userdatum value while it is being…

--

netconsole: avoid printing partially updated target attributes

This commit takes dynamic_netconsole_mutex in several configfs *_show()
callbacks so that reads are serialized against the store callbacks. It
also takes RTNL in dev_name_show() so the read cannot race with
netconsole_netdev_event() updating np.dev_name on NETDEV_CHANGENAME.

> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

[Severity: Low]
This fixes a race that users can see, but the trailers have no Fixes: tag.
Should one be added so stable and backport tooling can tell which trees
need the fix?

The family-dependent formatting in local_ip_show() and remote_ip_show()
(the AF_UNSPEC and AF_INET6 branches) came from these commits:

46b3f9e7e761 ("netconsole: use the address family instead of the ipv6 flag")
56ddc8d48e75 ("netconsole: show empty string for an unset IP address")

The first Closes: link points at that netcons_ipv6 series.

The lockless reads in dev_name_show() and remote_mac_show() go back to:

0bcc1816188e ("[NET] netconsole: Support dynamic reconfiguration using configfs")

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 267254f046de9..188beacb308d7 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -859,7 +859,19 @@ static ssize_t release_show(struct config_item *item, char *buf)
>  
>  static ssize_t dev_name_show(struct config_item *item, char *buf)
>  {
> -	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> +	struct netconsole_target *nt = to_target(item);
> +	int ret;
> +
> +	dynamic_netconsole_mutex_lock();
> +	/* Hold RTNL to prevent racing against netconsole_netdev_event()
> +	 * changing np.dev_name.
> +	 */
> +	rtnl_lock();
> +	ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
> +	rtnl_unlock();
> +	dynamic_netconsole_mutex_unlock();
> +
> +	return ret;
>  }

[ ... ]

> @@ -906,7 +932,14 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
>  
>  static ssize_t remote_mac_show(struct config_item *item, char *buf)
>  {
> -	return sysfs_emit(buf, "%pM\n", to_target(item)->remote_mac);
> +	struct netconsole_target *nt = to_target(item);
> +	int ret;
> +
> +	dynamic_netconsole_mutex_lock();
> +	ret = sysfs_emit(buf, "%pM\n", nt->remote_mac);
> +	dynamic_netconsole_mutex_unlock();
> +
> +	return ret;
>  }

[Severity: High]
local_mac_show(), just above this hunk, still has no locking. Is it still
open to the same race the commit message describes?

drivers/net/netconsole.c:local_mac_show() {
	struct net_device *dev = to_target(item)->np.dev;
	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };

	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
}

It loads np.dev and dereferences dev->dev_addr without holding
dynamic_netconsole_mutex, without RTNL, and without a netdev reference.

The netdev notifier can clear np.dev and drop its reference while holding
only RTNL:

netconsole_netdev_event(NETDEV_UNREGISTER)
  netconsole_process_cleanups_core()   /* ASSERT_RTNL() */
    netcons_release_dev()
      do_netpoll_cleanup()
        netdev_put(np->dev, &np->dev_tracker);
        np->dev = NULL;

enabled_store() also reaches this cleanup, under the mutex.

Suppose a reader of local_mac (world-readable through CONFIGFS_ATTR_RO)
loads a non-NULL dev and is then preempted while the device is
unregistered and freed. Could sysfs_emit() then read dev->dev_addr from a
freed net_device?

Even without unregistration, dev->dev_addr is rewritten under RTNL when
the MAC address changes. A lockless read could then print a mix of old
and new bytes.

dev_name_show() already takes RTNL because of the notifier-side writer.
Would taking dynamic_netconsole_mutex and then rtnl_lock() around both the
np.dev load and the sysfs_emit() call in local_mac_show() cover both
cases?

The later commit in this series, "netconsole: remove unnecessary target
refcounting from the netdev notifier", does not touch local_mac_show(). So
the problem still seems to be there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-netcons-fixes-next-v1-0-231cd26f8c51%40gmail.com
