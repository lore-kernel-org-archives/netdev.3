Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5B5226AD;
	Tue, 13 Oct 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912045; cv=none; b=HvkdGEh3FDh7ijHOm18YzTRQ3SCDoxQsWOcIFlp1/KJ7G5iXjcqKuv35KQb2k8lnSG9yrmjO9g8X1RMf+jLawNb63hq2u2RVBD9BRYnf1B4ca2t4+pEnIAbUcJmR8jD4NEmmTx1sWvtgIrqMIbR2mo7kHY7k3CE37vrg9vLPWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912045; c=relaxed/simple;
	bh=56KZuexrur2wf1KKukC2zaOvizAamSePIvQM5l/hWzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kT9Cv3AFHgamj/WuroWa6+CQD6GmxcWyKHl13kw6tW3Ypand2XCT5Z1u/48b0lKTAEydG5XEcMfb/KFZjRp+Di+oPjZJnHHEO1ZqdQ53wSVexviNepZBqyCoB6JjR/62GV1msg6Fh0JdnWRzpoDQJ0l2rB2L/ykQvB/Qx2JbZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdJN36cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdJN36cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B941F000FF;
	Tue, 13 Oct 2026 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912043;
	bh=/NLp/3Gui+rX7wckVkCCuev5Q9irjB0DJFH6N9SJGVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XdJN36cmOrF1asbMAAoaZuq12LEG8hEqVIMCiryMTCA3ArocCf94ltB0YdrB1zpNU
	 c2MIUDSa8JptFQOeiRhLDWOjSRGSuQS4skBLk+t95KqFfeOmbIfHTD1OVNyuDF5Jqb
	 RsMNcNDuLon394DyoOUxNTQaJiJ+G2KKXyFQSXtwRjbby29Lw19btfx3PwvPB2JpjC
	 3sv1f6HPDMw2pUGcA2B2Wqtpkbqav3B5oCgxZoH5WYQloUfxU2oqOrv5erg4cX8YwS
	 sJ8TFHH3u53KB2s89iKbKoG1ywNUGsjAz8y/J1rPSGp9AbIcRnzLzcMfg+gRrqHSUP
	 R4nJsLbWvYVKw==
Subject: Re: [PATCH net-next v2 1/2] netconsole: avoid printing partially
 updated target attributes
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 17:20:42 +0000
Message-ID: <179191204261.434549.8984165771561140450@kernel.org>
In-Reply-To: <20261012-netcons-fixes-next-v2-1-ac8ec4c62edb@gmail.com>
References: <20261012-netcons-fixes-next-v2-1-ac8ec4c62edb@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In drivers/net/netconsole.c, local_mac_show() still takes no
  lock.
- [High] dev_name_show() still races with netconsole_netdev_event()
  writing np.dev_name, even though the commit message says this race is…
- [Low] The commit fixes a user-visible race: configfs *_show() callbacks
  can return torn values while a store or the netdev notifier updates…

--

netconsole: avoid printing partially updated target attributes

This patch makes the netconsole configfs *_show() callbacks take
dynamic_netconsole_mutex, so they no longer return values that a
concurrent store has only partly updated. dev_name_show() also takes
target_list_lock to serialize against the NETDEV_CHANGENAME update in
netconsole_netdev_event().

> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

[Severity: Low]
Should this have a Fixes: tag?

The unlocked readers in dev_name_show(), remote_mac_show() and
local_mac_show() date back to commit 0bcc1816188e ("[NET] netconsole:
Support dynamic reconfiguration using configfs").

The family/address tearing in local_ip_show() and remote_ip_show() comes
from the more recent inet_addr/family rework (commits 46b3f9e7e761,
56ddc8d48e75 and f6e96d72f64a).

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 267254f046de9..953a1da071862 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -859,7 +859,20 @@ static ssize_t release_show(struct config_item *item, char *buf)
>  
>  static ssize_t dev_name_show(struct config_item *item, char *buf)
>  {
> -	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> +	struct netconsole_target *nt = to_target(item);
> +	unsigned long flags;
> +	int ret;
> +
> +	dynamic_netconsole_mutex_lock();
> +	/* Hold target_list_lock to prevent racing against
> +	 * netconsole_netdev_event() changing np.dev_name.
> +	 */
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
> +	spin_unlock_irqrestore(&target_list_lock, flags);

[Severity: High]
Does target_list_lock cover every place where netconsole_netdev_event()
changes np.dev_name?

It covers the NETDEV_CHANGENAME strscpy(). For NETDEV_UNREGISTER,
NETDEV_RELEASE and NETDEV_JOIN, though, the notifier drops
target_list_lock before it cleans up the target:

netconsole_netdev_event()
    spin_unlock_irqrestore(&target_list_lock, flags);
    mutex_unlock(&target_cleanup_list_lock);
    ...
    netconsole_process_cleanups_core()
        mutex_lock(&target_cleanup_list_lock);
        netcons_release_dev(nt)
            do_netpoll_cleanup(&nt->np);
            if (bound_by_mac(nt))
                memset(&nt->np.dev_name, 0, IFNAMSIZ);
        spin_lock_irqsave(&target_list_lock, flags);
        list_move(&nt->list, &target_list);

The memset in netcons_release_dev() runs with only RTNL and
target_cleanup_list_lock held. Neither dynamic_netconsole_mutex nor
target_list_lock is held, so the new dev_name_show() has no lock in
common with this writer.

MAC-bound targets do show up in configfs. A netconsole= cmdline target
bound by MAC is exposed through populate_configfs_item(), and
netpoll_setup() fills np.dev_name from ndev->name.

For such a target, can the sysfs_emit() here still copy a partly zeroed
name?

Two options that look possible: take target_cleanup_list_lock in
dev_name_show(), following the dynamic_netconsole_mutex ->
target_cleanup_list_lock -> target_list_lock order that
drop_netconsole_target() already uses. Or do the memset in
netcons_release_dev() under target_list_lock.

> +	dynamic_netconsole_mutex_unlock();
> +
> +	return ret;
>  }
>  

[ ... ]

> @@ -906,7 +933,14 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
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
This patch leaves local_mac_show(), just above this hunk, without any
locking:

static ssize_t local_mac_show(struct config_item *item, char *buf)
{
	struct net_device *dev = to_target(item)->np.dev;
	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };

	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
}

It loads np.dev with no lock, no RCU read section and no netdev
reference, then dereferences dev->dev_addr.

enabled_store() sets and clears np.dev through netcons_netpoll_setup()
and netconsole_process_cleanups(). process_resume_target() sets and
clears it too. Both run under dynamic_netconsole_mutex.

The notifier also clears np.dev, without that mutex:

netconsole_netdev_event()
    netconsole_process_cleanups_core()
        netcons_release_dev()
            do_netpoll_cleanup()
                netdev_put(np->dev, &np->dev_tracker);
                np->dev = NULL;

If netconsole holds the last reference on a device that is being
unregistered, netdev_run_todo() can free the net_device after this put.

Can a reader that already loaded dev then read dev->dev_addr from freed
memory?

The unlocked read dates back to the original configfs support in commit
0bcc1816188e. This patch is meant to make the *_show() callbacks safe
against concurrent writers, though. Should local_mac_show() be handled
here as well?

Taking dynamic_netconsole_mutex alone would cover enabled_store() and
process_resume_target(), but not the notifier path. Would the device
need to be pinned some other way? RTNL, RCU, or a netdev reference
taken under a lock the notifier also holds are possible options.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-next-v2-0-ac8ec4c62edb%40gmail.com
