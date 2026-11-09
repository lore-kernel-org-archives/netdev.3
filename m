Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256852;
	b=OA8Ei+l4rnf2noTHbY7YvL/c0yEi/A2+rT6Q4fwx9zFgykvx/XGqEn5TVjFhhLNMTgdN
	 BeRe1rEK9L32o4qI3zyHX3tk3VMBgIC4v40vnoNYpAo/EvZm89e0VSIuqgezw1bFCDnuN
	 Ckayqi3whzwXprjH7I0COyT0MmcGLYo/Ej+V2LS4tGnwZDQdP+OBSuw7Ly+AjMiDrMorI
	 IY1gCrNpW9d0o1AJ/+ko22tXnWnuJAghlMEboS5UBuL/0qLJ2mEZ9KSLuXDQcXTTynC3K
	 LacMEqPpSqODaYup7cbpUqq7tmfON6CrFaUtAlKRzfBYAdKz9KpIweIHvIue+NPhahg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256852;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6KWUyW97nN+yuQMBM4S682oubTxb5wH7fUzP/oN1bII=;
	b=UY1G6pAVYzepMP3NJok5JJTkhkviDI9lVRNrQam2XTH6rDGGp0FU9ywBJZjoiQ9+3kJB
	 oNx4MFDtU5sO0sUepzzXXywQRVgRSPvf/j51iQBGmK0ipQHaKXndZC5H3mzX4X7Z4eTDU
	 fMMEewveL8OnTgbjDlYk4iH9V/zXeoiKv225bV8fP2p/RMnoTJKwv+kEUkijBUaPmajrJ
	 uYTR8k8Elp20UHAKboxoz9Glj1u7JfDsqlMtPAXS9/pV85/xw1Upk2pW6OkrTOkxR7VN7
	 RUsnWNApaTYku2QAp8PEvyCwzFZE1wBY0jFL1PxTBrXQhoRlL4ChhuqZoBzbhF/Z8EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBJvUs7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0788606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBJvUs7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0157A1F0089F;
	Mon,  9 Nov 2026 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256851;
	bh=6KWUyW97nN+yuQMBM4S682oubTxb5wH7fUzP/oN1bII=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gBJvUs7jdnH4xSr8uorsw4Ed8MY3IWoQ1T19rMn4VWbZidWLxLwRMVCj5zAZ3mYc/
	 hn4AuXfLiTHiUv/kmupbnj9m26Ddim7PzdozNNikGw0rdUt702pTid+Vc5uI3iNzDf
	 HoNtJ2tR3In2GNr/jy3lw0kAPB7MLJwizODlTqSCNjhS7w67b8YXr+UuT8RbYcoCd6
	 xjl8KHEgiTyVsgzDeBdAc1PhbMFyru/b82JERyfDGSaR4WLNkQJ+X7ah+ID8c6rr0+
	 Wugj3010EftGNCZBnOzEu0DFV3TqiFZhgmZeS9zwkne5JI5h+ohFeZxfZ4fMENI3mT
	 BmWwzKcvQwgyA==
Subject:
 Re: [PATCH net-next] net sysfs: remove deprecated empty wireless directory
From: netdev-bot+sashiko@kernel.org
To: hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, horms@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Date: Mon, 09 Nov 2026 20:40:50 +0000
Message-ID: <179425685052.994134.18203088192324473037@kernel.org>
In-Reply-To: <2af5fc30-4520-4768-bcdb-7b1058b39212@gmail.com>
References: <2af5fc30-4520-4768-bcdb-7b1058b39212@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch removes the empty /sys/class/net/<iface>/wireless
  directory, which userspace can see.
- [Medium] The removed wireless_group_needed() matched WEXT-only netdevs,
  i.e. those with `ndev->wireless_handlers` set and no cfg80211…
- [Low] The kernel-doc for struct net_device::sysfs_groups in
  include/linux/netdevice.h still says "Space for optional device,…

--

net sysfs: remove deprecated empty wireless directory

This patch removes the empty "wireless" attribute group that
netdev_register_kobject() created for cfg80211 and wireless extensions
netdevs. It also shrinks net_device::sysfs_groups from 5 entries to 4.

Link: https://github.com/fedora-sysv/initscripts/commit/4e96fcecee7ab70295a5f2c52748cd57cbab60bb

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 435be7880d7e5..ac943798abca6 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2484,7 +2484,7 @@ struct net_device {
>  	struct dm_hw_stat_delta __rcu *dm_private;
>  #endif
>  	struct device		dev;
> -	const struct attribute_group *sysfs_groups[5];
> +	const struct attribute_group *sysfs_groups[4];

[Severity: Low]
This isn't a bug, but should the kernel-doc for this field be updated as
well? It still says:

 *	@sysfs_groups:	Space for optional device, statistics and wireless
 *			sysfs groups

After this patch, netdev_register_kobject() stores only the optional
driver group, netstat_group, netdev_phys_group and the NULL terminator.
The comment still lists a wireless slot that nothing fills, and it does
not mention the phys group.

>  	const struct attribute_group *sysfs_rx_queue_group;
>  
>  	const struct rtnl_link_ops *rtnl_link_ops;
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 5c0402389c6d1..cb8c82d1a4da8 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -910,28 +910,6 @@ static const struct attribute_group netstat_group = {
>  	.attrs  = netstat_attrs,
>  };
>  
> -static struct attribute *wireless_attrs[] = {
> -	NULL
> -};
> -
> -static const struct attribute_group wireless_group = {
> -	.name = "wireless",
> -	.attrs = wireless_attrs,
> -};

[Severity: Medium]
Could this cause a userspace regression? The group has no attributes,
so the existence of /sys/class/net/<iface>/wireless is the whole
interface. A script that tests for it with something like
"[ -d /sys/class/net/$IF/wireless ]" would quietly stop finding wireless
interfaces, without any error.

This removal has been done and reverted once before. Commit 35b2a113cb02
removed the directory. Commit 38c1a01cf10c, which the commit message
cites, added it back because the removal "broke (at least) Fedora's
networking scripts", and that fix was tagged for stable 3.6.

The commit message says:

  Last known user of this deprecated feature was Fedora, until 2012.

The 2012 commit said "at least", so it did not claim Fedora was the only
user. I can't confirm from the tree whether any current tools or local
scripts still do this check. raspi-config's list_wlan_interfaces is one
example worth checking.

There also seems to be no deprecation period and no Documentation/ABI
entry for this directory. Would it make sense for the commit message to
mention the earlier regression and revert? It could also point users to
the replacements: the phy80211 symlink and DEVTYPE=wlan set in
net/wireless/core.c, or nl80211.

> -
> -static bool wireless_group_needed(struct net_device *ndev)
> -{
> -#if IS_ENABLED(CONFIG_CFG80211)
> -	if (ndev->ieee80211_ptr)
> -		return true;
> -#endif
> -#if IS_ENABLED(CONFIG_WIRELESS_EXT)
> -	if (ndev->wireless_handlers)
> -		return true;
> -#endif

[Severity: Medium]
What about netdevs that use only wireless extensions? For these, the
wireless directory appears to be the only sign in sysfs that the device
is wireless.

One example is ps3_gelic_wireless:

drivers/net/ethernet/toshiba/ps3_gelic_wireless.c:gelic_wl_setup_netdev_ops() {
    ...
	netdev->wireless_handlers = &gelic_wl_wext_handler_def;
    ...
}

This driver never sets ieee80211_ptr. net/wireless/core.c adds the
phy80211 symlink and SET_NETDEV_DEVTYPE(dev, &wiphy_type) only for
cfg80211 wdevs, so this device gets neither.

After this patch, sysfs and uevents seem to give no way to tell that
such a device is wireless. Only /proc/net/wireless or wext ioctls like
SIOCGIWNAME would remain.

The ipw2x00 drivers also set wireless_handlers, but they get
ieee80211_ptr through libipw, so they keep phy80211.

Commit 38c1a01cf10c covered this case on purpose: "Also do it for both
drivers based on the old wireless extensions and cfg80211". Should the
commit message discuss the wext-only case, since these devices have no
sysfs replacement?

> -	return false;
> -}
> -

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2af5fc30-4520-4768-bcdb-7b1058b39212%40gmail.com
