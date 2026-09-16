Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1383B9956
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535264; cv=none; b=qx7HMK/KpNq7P8z5eStbPcgmp4l8VnP3MTgIqW2nNCBC+CX8xHIvEdbnV/Gwo4eO6gwyPy1MI6cLrUNC8r7YGSCiTCCxAonkI02x7hR97JNAnjGFSAt+BcugTxx1SH7i8AAs0Rzi403rkDQQJT13+5BBGVSeCdA2acVKyaefT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535264; c=relaxed/simple;
	bh=poXf8b/EZKEJ+wam5kWmYqcw7E5qpknfD3ZooWuAUBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIq62G/YCXhgwxXOFDWNU4JaRN4nFI1yBLPmTrXjMCJ3DAf5szWf+YU+5wA5fQ9eagKJh6iqzZWmqxN7RXMIKna/ueZSqSQTWS4HTwHAbpvHuRGKdwKd87R7cCjCxwf/Un62mjI8idQm1hmIqDGShVi0tnAEYrgm+twQ+IfqoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B/5qpQ1r; arc=none smtp.client-ip=91.218.175.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B/5qpQ1r"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=poXf8b/EZKEJ+wam5kWmYqcw7E5qpknfD3ZooWuAUBk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789535260; v=1; x=1790140060;
 b=B/5qpQ1rxngliTZEAcjaLdBU8sYJmZhnWS7J8r+aAuvSki+oSktUnReazhNKFyRcVrLFKoDz
 yJwYvJ5Tcn67gxhbRqevPE3cgwiUPTmUCHDWPC7FUoRY8uAK0RS7tr1lJ9Pz3qPUixWHRVnLtHg
 dpqAl9vfeY52mqGG9/4tZzUk=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id be70240e79be7685;
	Wed, 16 Sep 2026 05:07:40 +0000
X-Mizu-Trace-ID: be70240e79be7685
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 13:07:27 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>, jv@jvosburgh.net, razor@blackwall.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, daniel@iogearbox.net, joamaki@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	liuhangbin@kylinos.cn
Subject: Re: [PATCH net v4] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <aqokD2avF7B7Towi@fedora>
References: <20260914-bond_slave_cnt-v4-1-d14864a39e60@kylinos.cn>
 <20260916012721.1653880-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916012721.1653880-2-kuba@kernel.org>

Hi Jakub, 

Thanks for the notify.

Jay, Nikolay, please correct me if you disagree with my comments.

On Tue, Sep 15, 2026 at 06:27:22PM -0700, Jakub Kicinski wrote:
> Clashiko classified the broader issues as independent but I'm not sure.
> If there are more problems with pre-publishing the count we need
> a different fix? Or am I not reading closely enough?
> 
> AI review:
> ---
> bonding: fix slave_cnt leak on XDP error paths
> 
> The three XDP failure exits in bond_enslave() used to jump straight to
> err_sysfs_del, which skipped the slave_cnt decrement and let the counter
> drift upward on every failed enslave. A new err_slave_cnt label is added
> ahead of err_sysfs_del to undo the increment.
> 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index a9bff7663eeca..577d85c838040 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2305,7 +2305,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >  			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
> >  				     "Slave does not support XDP");
> >  			res = -EOPNOTSUPP;
> > -			goto err_sysfs_del;
> > +			goto err_slave_cnt;
> >  		}
> >  	} else if (bond->xdp_prog) {
> >  		struct netdev_bpf xdp = {
> 
> [Severity: High]
> 
> This is a pre-existing ordering issue that dates back to 9e2ee5c7e7c3 and
> is not introduced by this patch, but since the new err_slave_cnt stage sits
> right here it seems worth asking about.
> 
> By the time bond_enslave() reaches this ndo_bpf / ndo_xdp_xmit test, the
> slave has already been published to the lockless transmit path:
> 
> 	res = bond_master_upper_dev_link(bond, new_slave, extack);
> 	...
> 	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> 	...
> 	if (bond_uses_primary(bond)) {
> 		block_netpoll_tx();
> 		bond_select_active_slave(bond);
> 		unblock_netpoll_tx();
> 	}
> 
> 	if (!slave_dev->netdev_ops->ndo_bpf ||
> 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
> 
> For the trunk modes the switch default arm already ran
> bond_set_active_slave(new_slave) with new_slave->link == BOND_LINK_UP, so
> bond_slave_can_tx() is true for it.

Not since the bond_uses_primary() if checking, the new_slave could be set to
active even more early during enslave. e.g. in bond_main.c:2174

  switch (BOND_MODE(bond)) {
  ...
  case BOND_MODE_TLB:
  case BOND_MODE_ALB:
      bond_set_active_slave(new_slave);
  default:
      bond_set_active_slave(new_slave);

I think the bond assume the new slave is in trunk modes in this situation,
which could pass any traffic.

> 
> Can a concurrent bond_xdp_xmit(), which only takes rcu_read_lock() and does
> not hold RTNL, pick that not-yet-validated slave in this window?
> 
> bond_xdp_xmit()
>   bond_xdp_xmit_roundrobin_slave_get()
>     slave_cnt = READ_ONCE(bond->slave_cnt);
>     if (likely(slave_cnt)) {
>         slave_id = bond_rr_gen_slave_id(bond) % slave_cnt;
>         return bond_get_slave_by_id(bond, slave_id);

bond_get_slave_by_id() loop each slaves, even the slave_cnt not updated, the
new slave still could be chosen.

> 
> bond_get_slave_by_id() only checks bond_slave_can_tx(), never XDP
> capability, and bond_xdp_xmit() then does:
> 
> 	err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);
> 
> with no NULL test, so would this be an indirect call through a NULL
> ndo_xdp_xmit for a slave that lacks it?
> 
> The devmap gate does not appear to help here either: __xdp_enqueue() and
> is_valid_dst() only look at the bond device's xdp_features, which still
> advertise NETDEV_XDP_ACT_NDO_XMIT during this window because
> bond_xdp_set_features() only runs after the XDP block. The same exposure
> looks reachable through bond_xmit_activebackup_slave_get() for
> bond_uses_primary() modes, where bond_select_active_slave() may publish the
> new slave as curr_active_slave before the capability check.
> 
> Would it make sense to move the ndo_bpf / ndo_xdp_xmit validation earlier,
> before the slave is linked and counted?

I saw Nikolay has done a similar fix e9acda52fd2e ("bonding: fix use-after-free
due to enslave fail after slave array update"). But the risk is till there.
So how up we should move the xdp ops?

Maybe add a checking as a workaround before we do a safe re-order for
bond_enslave?

  if (likely(slave_dev->netdev_ops->ndo_xdp_xmit))
      err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);

Nikolay, what do you think?

> 
> [ ... ]
> 
> > @@ -2348,6 +2348,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >  	return 0;
> >  
> >  /* Undo stages on error */
> > +err_slave_cnt:
> > +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
> > +
> >  err_sysfs_del:
> >  	bond_sysfs_slave_del(new_slave);
> >  
> 
> [Severity: Medium]
> 
> These leaks are pre-existing, the three XDP exits already fell into this
> same unwind chain before this patch, so they are not introduced here. Since
> this patch adds the stage where the symmetric undo would belong, is it worth
> handling the rest of the state applied just above the XDP block?
> 
> Reaching the XDP checks means this group has already run, with no
> intervening label:
> 
> 	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> 	netdev_compute_master_upper_features(bond->dev, true);
> 	bond_set_carrier(bond);
> 
> 	bond_slave_ns_maddrs_add(bond, new_slave);
> 
> err_slave_cnt reverses only the counter and falls through to err_sysfs_del,
> so does the bond keep a feature mask recomputed from a device that never
> became a slave, and for a first slave with an up link keep reporting
> LOWER_UP with zero slaves, since nothing on the unwind path re-runs
> netdev_compute_master_upper_features() or bond_set_carrier()?

Yes, I think we could do it, in a separate patch.

> 
> Does bond_slave_ns_maddrs_add() also leak solicited-node multicast
> addresses on the rejected netdev? bond_options.c takes real references:
> 
> 	void bond_slave_ns_maddrs_add(struct bonding *bond, struct slave *slave)
> 	{
> 		if (!bond->params.arp_validate)
> 			return;
> 		slave_set_ns_maddrs(bond, slave, true);
> 	}
> 
> and no label between err_slave_cnt and err_undo_flags calls
> bond_slave_ns_maddrs_del(). err_detach only re-runs
> bond_change_active_slave() / bond_select_active_slave() when the new slave
> had become curr_active_slave, so with mode=active-backup plus arp_validate
> plus ns_ip6_target and the new slave staying backup, would these accumulate
> on each retried enslave?

Yes, we could.

> 
> For round-robin and 802.3ad, which are both XDP-capable and not
> bond_uses_primary(), the block above also ran:
> 
> 	if (bond_dev->flags & IFF_PROMISC) {
> 		res = dev_set_promiscuity(slave_dev, 1);
> 	...
> 	if (bond_dev->flags & IFF_ALLMULTI) {
> 		res = dev_set_allmulti(slave_dev, 1);
> 	...
> 		dev_mc_sync_multiple(slave_dev, bond_dev);
> 		dev_uc_sync_multiple(slave_dev, bond_dev);
> 		if (BOND_MODE(bond) == BOND_MODE_8023AD)
> 			dev_mc_add(slave_dev, lacpdu_mcast_addr);
> 
> Does the released device stay in promiscuous and allmulti mode with the
> multicast and unicast sync entries still programmed after the XDP failure?

Yes

> 
> __bond_release_one() performs exactly the mirror operations, which suggests
> these are the required undo steps:
> 
> 	bond_slave_ns_maddrs_del(bond, slave);
> 	...
> 	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
> 	...
> 	netdev_compute_master_upper_features(bond->dev, true);
> 	...
> 		if (old_flags & IFF_PROMISC)
> 			dev_set_promiscuity(slave_dev, -1);
> 	...
> 		if (old_flags & IFF_ALLMULTI)
> 			dev_set_allmulti(slave_dev, -1);
> 	...
> 		if (old_flags & IFF_UP)
> 			bond_hw_addr_flush(bond_dev, slave_dev);
> 
> and that path is not reachable here because the enslave failed.

Yes, I think we can do it in another patch.

Thanks
Hangbin
