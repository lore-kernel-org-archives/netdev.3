Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460875;
	b=a3SgrMokSOHRh+CTEYRwMrg82XfD2kPXEIuloKo1EfguE9o46jHED/U75t8yyEJXlPFw
	 lAYrhSh2aaGM2i4uMDLZXsYmNQGNEDlAhKgZa0TTvvJuoS1ccZZ4UAdUYd6id3YnAUA/U
	 ravbqRUfmvPcW/vo5Eg13JJ6GoWSvqkIPKwmtf8QTjWZPmoJFgTz9djY3u9jj+FOA0Zng
	 oA+stOwhYPpJREtj23EOAzsmcvFEXKxHqxOFsEmSvftAhf7Mcr3fBNCWK1DJa/R41H1/H
	 QnaAM8TeSZU639u4S/hLnwNETTz+yAU9GApdzHYAX2nb6BbZ+2ayXufy5+jW3Ps6pUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460875;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ct55o+7AyJFGdYXUxsDZQvXbXKYcBhSdFZdOPwa9J3M=;
	b=5QRx+biP5iUT2K1gRLfiZmhHMJbb+tlw+0HkgHjuss/CUBMTVyjhg8wAOZT0/lBl4MHq
	 dh2k15/acX4G3zCtXVPB1s7jf+d2v482zNvNMWK6ExQHLtlLC0Y5sGeZZ+7ndqWnFOgTK
	 3DgAYmDTG/GUwqaXckuLzdNjNQJjh1y+objdqGrSJQMiD+CR6c4fWE7iwghQPXpG9WtQe
	 T2Q8DgMkEZOIK3gY+q/pyiS+wWlhirAjMH00xiGzCipKkeQxb8lyfRdkHKeGfhyrFSiSt
	 /qGwI5xHs/gdi531quu1T/MwmkHYkhhcxnsFd7KTlkqL2KcUoSZ5BG9/nHdsG4UEm5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSDvzb9V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51A606A337;
	Tue, 20 Oct 2026 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSDvzb9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7E31F000C7;
	Tue, 20 Oct 2026 01:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460874;
	bh=Ct55o+7AyJFGdYXUxsDZQvXbXKYcBhSdFZdOPwa9J3M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OSDvzb9Vm2FCG92iTvruLhzOHDcw1M9z/yZzVfgAgOmQevA3yXpM3EeV7TBmGr/MB
	 CHUGjtW8c4kbsFw2hacSLQ5LIRVymdkCDSvRhj12kQnQVi87F5VljP41WhmB68f0tZ
	 jp230lCvbgpFuowJy4UK1eeNCluoRp+GyCa5wgX8hRqmylR17FiU0DT0WMiGiJBa6q
	 sd8J7FXPtECrPkW3kHgYNx/tnFjt3hZSPbuiP0h//ZO2A+CLlSHGLRymAboQYCwb/l
	 YvdKVVi4oHMt21uXMLhxeLr+WpIINh+bwbUg3dUvGoPZM8VyA/wzWU24Ct3MEvII5h
	 SsG4nPBAiJJgg==
Subject: Re: [PATCH net v3] net/ncsi: fix use-after-free of ncsi_channel in
 ncsi_remove_channel()
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gwshan@linux.vnet.ibm.com, joel@jms.id.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 01:47:53 +0000
Message-ID: <179246087348.3135.4121305504418184256@kernel.org>
In-Reply-To: <20261019013757.450036-1-18983559317@163.com>
References: <20261019013757.450036-1-18983559317@163.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (3) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In this tree, only the channel is freed after an RCU grace
  period.
- [High] ncsi_send_cmd_nl() (net/ncsi/ncsi-netlink.c) saves `dev =
  ndp->ndev.dev` inside the new rcu_read_lock() section.
- [Medium] ncsi_remove_channel() only unlinks the channel from
  np->channels (list_del_rcu(&nc->node)) before call_rcu(&nc->rcu,…
- [Low] The new comment in ncsi_pkg_info_nl() (net/ncsi/ncsi-netlink.c)
  has two problems.

Pre-existing issues:
- [High] ncsi_vlan_rx_kill_vid() (net/ncsi/ncsi-manage.c:1743-1748) has
  the same pattern the commit's Coccinelle rule looks for:…
- [High] ncsi_register_dev() sets up a timer for each of the 256
  ndp->requests[i] entries embedded in ndp (timer_setup(...,…
- [High] The patch protects channel reclamation with list_del_rcu() plus
  call_rcu(), which only protects readers inside rcu_read_lock().

--

net/ncsi: fix use-after-free of ncsi_channel in ncsi_remove_channel()

This patch moves the free of struct ncsi_channel and its filter arrays
into an RCU callback. It also wraps the device lookup and list walks of
the seven NCSI generic netlink handlers in rcu_read_lock(), and drops the
unbalanced get_net() calls. The commit message says the race is only
fully closed together with two companion series for ncsi_remove_package()
and ncsi_unregister_dev().

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..2b117cfd0d6ab 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c

[ ... ]

> @@ -263,7 +267,11 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
>  	np->channel_num--;
>  	spin_unlock_irqrestore(&np->lock, flags);
>  
> -	kfree(nc);
> +	/* Netlink walkers may still hold the channel or its filter
> +	 * arrays; the arrays are only reachable through @nc and share
> +	 * its grace period.
> +	 */
> +	call_rcu(&nc->rcu, ncsi_channel_release);

[Severity: Medium]
Is np->channels the only place where this channel is still published when
call_rcu() is queued?

ncsi_remove_channel() only does list_del_rcu(&nc->node). It does not
take nc->link off ndp->channel_queue, which is added to with
list_add_tail_rcu() and read with list_first_or_null_rcu(). It also does
not clear ndp->active_channel or np->preferred_channel when they point
at nc.

If the channel is queued for multi-channel configuration, it stays on
channel_queue after the grace period ends. Later walkers would then touch
the freed channel, for example:

ncsi_reset_dev()
    list_for_each_entry_safe(nc, tmp, &ndp->channel_queue, link)
        list_del_init(&nc->link);

That walk is reached from the SET_INTERFACE, CLEAR_INTERFACE,
SET_PACKAGE_MASK and SET_CHANNEL_MASK handlers.
ncsi_process_next_channel() also reads the queue.

There is also a window where a genl handler finds nc during its RCU walk
of np->channels in ncsi_reset_dev()->ncsi_choose_active_channel(), just
before the concurrent list_del_rcu(). ncsi_remove_channel() has already
set nc->state = NCSI_CHANNEL_INACTIVE, so the channel passes the filter
and can be queued again:

ncsi_choose_active_channel()
    list_add_tail_rcu(&nc->link, &ndp->channel_queue);

After that, ncsi_process_next_channel() may store it in
ndp->active_channel. The channel is then still reachable after the
reader's rcu_read_unlock(), and it gets freed while still linked.

Should ncsi_remove_channel() also unlink nc->link and clear these
pointers before queueing the callback?

[Severity: High]
This isn't a bug introduced by this patch, but call_rcu() only waits for
readers inside rcu_read_lock(). Several process-context walkers of
np->channels use NCSI_FOR_EACH_CHANNEL() without taking it. One example
is ncsi_stop_dev(), which is reached from ndo_stop under RTNL:

ncsi_stop_dev()
    NCSI_FOR_EACH_PACKAGE(ndp, np) {
        NCSI_FOR_EACH_CHANNEL(np, nc) {
            ncsi_stop_channel_monitor(nc);

These walkers have the same problem:

  - the ncsi_start_dev()->ncsi_reset_dev() walk;
  - ncsi_kick_channels() and ncsi_choose_active_channel() when they are
    called outside the genl handlers.

ftgmac100_remove() calls ncsi_unregister_dev() without RTNL and before
unregister_netdev(), so the netdev can still be brought up or down at
the same time. With PREEMPT_RCU, holding RTNL does not make the task an
RCU reader:

CPU0                              CPU1
ip link set ethX down             rmmod ftgmac100
ftgmac100_stop()                  ftgmac100_remove()
  ncsi_stop_dev()                   ncsi_unregister_dev()
    walking np->channels              ncsi_remove_package()
                                        ncsi_remove_channel()
                                          list_del_rcu()
                                          call_rcu()
                                    grace period ends, nc freed
    ncsi_stop_channel_monitor(nc)

Can CPU0 then read nc->node.next, nc->lock and nc->monitor.timer from the
freed channel?

[Severity: High]
This is a pre-existing issue, but the Coccinelle rule described in the
commit message (kfree() right after list_del_rcu()) would also match
ncsi_vlan_rx_kill_vid():

net/ncsi/ncsi-manage.c:ncsi_vlan_rx_kill_vid() {
    ...
	list_for_each_entry_safe(vlan, tmp, &ndp->vlan_vids, list)
		if (vlan->vid == vid) {
			netdev_dbg(dev, "NCSI: vid %u found, removing\n", vid);
			list_del_rcu(&vlan->list);
			found = true;
			kfree(vlan);
		}
    ...
}

set_one_vid() walks ndp->vlan_vids with list_for_each_entry_rcu() under
rcu_read_lock(). It runs from ncsi_configure_channel(), driven by the
NCSI worker and the response path, not under RTNL. The writer runs from
ndo_vlan_rx_kill_vid under RTNL and shares no lock with the reader.

Can set_one_vid() read vlan->vid and vlan->list.next from a freed
struct vlan_vid here? Neither this patch nor the companion series named
in the commit message seems to cover this site.

[Severity: High]
This is also a pre-existing issue, but on the same rmmod path: what
happens to the request timers embedded in ndp?

ncsi_register_dev() sets up a timer for each of the 256 ndp->requests[]
entries:

	timer_setup(&ndp->requests[i].timer, ncsi_request_timeout, 0);

ncsi_xmit_cmd() arms one for every command, including NCSI_CMD_SEND_CMD
and the periodic channel monitor commands:

	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

The only timer_delete_sync() on these timers is in ncsi_free_request().
ncsi_unregister_dev() stops response processing and then frees ndp
without cancelling them:

ncsi_unregister_dev()
    dev_remove_pack(&ndp->ptype);
    ...
    disable_work_sync(&ndp->work);
    kfree(ndp);

If a request is still outstanding at teardown, could
ncsi_request_timeout() fire up to a second later on the freed ndp? It
would take ndp->lock, write nr->enabled = false and call
ncsi_free_request(). The outstanding nr->cmd and nr->rsp skbs also look
like they would be leaked.

>  }

[ ... ]

> diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
> index 8cc538358f6a3..7e4c77eef2d8f 100644
> --- a/net/ncsi/ncsi-netlink.c
> +++ b/net/ncsi/ncsi-netlink.c

[ ... ]

> @@ -192,7 +187,24 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
>  		kfree_skb(skb);
>  		return -EMSGSIZE;
>  	}
> +
> +	/* Resolve the device and walk its lists inside an RCU read-side
> +	 * critical section.  The channel and its filter arrays are freed
> +	 * from an RCU callback in this series; the packages and the
> +	 * device itself get their grace periods from the companion fixes
> +	 * for ncsi_remove_package() and ncsi_unregister_dev().
> +	 */

[Severity: Low]
This isn't a bug, but this comment refers to "this series" and to
"companion fixes". Neither will mean anything once the patch is merged.

The comment also doesn't match the code at this revision.
ncsi_remove_package() still calls kfree(np) right after list_del_rcu().
ncsi_unregister_dev() calls kfree(ndp) right after list_del_rcu() and
disable_work_sync().

Could the comment describe the lifetime rules that actually apply in
the tree?

> +	rcu_read_lock();
> +	ndp = ndp_from_ifindex(genl_info_net(info),
> +			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
> +	if (!ndp) {
> +		rcu_read_unlock();
> +		kfree_skb(skb);
> +		return -ENODEV;
> +	}
> +
>  	rc = ncsi_write_package_info(skb, ndp, package_id);
> +	rcu_read_unlock();

[Severity: High]
Does this rcu_read_lock() protect anything other than the channel at
this revision?

ncsi_remove_package() and ncsi_unregister_dev() still free the package
and the device without a grace period:

ncsi_remove_package()
	list_del_rcu(&np->node);
	ndp->package_num--;
	spin_unlock_irqrestore(&ndp->lock, flags);

	kfree(np);

ncsi_unregister_dev()
	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);

	spin_lock_irqsave(&ncsi_dev_lock, flags);
	list_del_rcu(&ndp->node);
	spin_unlock_irqrestore(&ncsi_dev_lock, flags);

	disable_work_sync(&ndp->work);

	kfree(ndp);

All packages are removed while ndp is still on ncsi_dev_list. Also,
ftgmac100_remove() calls ncsi_unregister_dev() before
unregister_netdev(). So ndp_from_ifindex() can still find ndp for the
whole teardown.

An unprivileged NCSI_CMD_PKG_INFO request racing rmmod could then read
these fields from freed memory in ncsi_write_package_info():

  - ndp->package_num, ndp->package_whitelist and ndp->packages;
  - np->id and np->channels.

ncsi_write_channel_info() also uses a channel that RCU keeps alive to
reach its parent package, which may already be freed:

	if (nc == nc->package->preferred_channel)

The same applies to ncsi_pkg_info_all_nl().

The commit message says the race is closed by the three series
together. Neither companion change is in this tree, though. The only
call_rcu() in net/ncsi/ is the new one in ncsi_remove_channel(). With
the Fixes: tags, this patch could be backported or bisected on its own.

Would it make sense to send it together with, or after, the package and
device lifetime changes?

[ ... ]

> @@ -427,17 +457,21 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
>  		goto out;
>  	}
>  
> -	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
> +	rcu_read_lock();
> +	ndp = ndp_from_ifindex(sock_net(msg->sk),
>  			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
>  	if (!ndp) {
> +		rcu_read_unlock();
>  		ret = -ENODEV;
>  		goto out;
>  	}
> +	dev = ndp->ndev.dev;
>  
>  	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
>  	channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
>  
>  	if (package_id >= NCSI_MAX_PACKAGE || channel_id >= NCSI_MAX_CHANNEL) {
> +		rcu_read_unlock();
>  		ret = -ERANGE;
>  		goto out_netlink;
>  	}

[ ... ]

> @@ -462,18 +497,25 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
>  	nca.info = info;
>  	nca.payload = ntohs(hdr->length);
>  	if (nca.payload > len - sizeof(*hdr)) {
> +		rcu_read_unlock();
>  		ret = -EINVAL;
>  		goto out_netlink;
>  	}
>  	nca.data = data + sizeof(*hdr);
>  
> +	/* ncsi_xmit_cmd() is safe to run under the RCU read-side
> +	 * critical section: it only uses GFP_ATOMIC command skbs,
> +	 * spinlocks and dev_queue_xmit().
> +	 */
>  	ret = ncsi_xmit_cmd(&nca);
> +	rcu_read_unlock();
> +
>  out_netlink:
>  	if (ret != 0) {
> -		netdev_err(ndp->ndev.dev,
> +		netdev_err(dev,
>  			   "NCSI: Error %d sending command\n",
>  			   ret);
> -		ncsi_send_netlink_err(ndp->ndev.dev,
> +		ncsi_send_netlink_err(dev,
>  				      info->snd_seq,
>  				      info->snd_portid,
>  				      info->nlhdr,

[Severity: High]
dev is saved inside the RCU section, but every path that reaches
out_netlink calls rcu_read_unlock() first. That includes the -ERANGE and
-EINVAL branches above and a failing ncsi_xmit_cmd().

Is anything keeping the net_device alive at this point?
ndp_from_ifindex() drops its reference before it returns:

	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;

The handler does not take its own dev_hold() or netdev_hold() either.
After rcu_read_unlock() the task is neither an RCU reader nor a
reference holder. On PREEMPT it could be preempted while
ftgmac100_remove() finishes three steps:

  - ncsi_unregister_dev();
  - unregister_netdev();
  - the devres free of the devm_alloc_etherdev() netdev.

netdev_err(dev, ...) and ncsi_send_netlink_err(dev, ...) would then
read the freed net_device. ncsi_send_netlink_err() also uses
dev_net(dev) to find net->genl_sock for nlmsg_unicast().

The commit message describes the deferred error notification as safe
because it uses the net_device saved under the RCU lock. That pointer is
only valid until rcu_read_unlock(), though.

Should the handler hold a reference on dev, or send the error before
dropping the RCU lock?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019013757.450036-1-18983559317%40163.com
