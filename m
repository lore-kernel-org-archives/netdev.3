Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64B46E017;
	Fri, 21 Aug 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307580; cv=none; b=maiTHoqAs7zpPvj4qDTJJlvSF2FnoE3l8GEH1tq0S4Pe05hKMdR5ZMMujuZIU1WLjYNxRisvi4+Hcx/OCuvNH2XEk3FOwcXYZZ7l9NZLfIXDoPhAm015tgjDyQBnUVMFRENqoVXjuH5tqXoVDTLGP3gpQsUWssYaMfvzpo/EB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307580; c=relaxed/simple;
	bh=F8eoFQxaYH4WINVV79oUmFimGWP2Em4x0CNvOGYnGPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6q9QfpZ2L/XoLWycHZJxYrkOuOLxYunn+Su2jjwwfx2KXzPrgqCzg17ah/Kxouvr2b/bgE7w3NqKibaEw0bTJm2J0cCq5cHojY+GNECqjMpr6cjKqXA67rY5Xy0/fyl7U8dqkMbnG+6jqHnwhqZXW7CASx9slzHJEAKUAdLIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doeFO+Eh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doeFO+Eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6AC1F000E9;
	Fri, 21 Aug 2026 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787307569;
	bh=azMgpylWErGqAkhLH/qP8Q6Kk3jMJaYFp6C2rr6vm3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=doeFO+EhNv00zSJMI2fLCEb+luHnhvZUXbIckTZLKHg4WZqIFK4tGmWbeZbSGAH65
	 WMkS1TT3Dyq6+rJglJzM7iQLqHjQpo87N7IqtZ0HBKypKY/TmZHAJmMWuAAtWANmn7
	 HkTPg6B5LhqVtl2fKhiO9jd208HYDOF6THh5fbN96rwlxyRr624po7+tdhq08aSCyW
	 RjtOJ1hFhe90RFMcY3hxcpZJ67LZhdUQeU7/bv3NiiJEw98Wj3yjZE2pUO1ffp3bCU
	 bf5gAvBYnB4qiEaz1qLst/YvBN+ExGaidgdmMbQuBjw+OoWlNJV+RbDc2vAWDdX1yO
	 Swwm9ADS7L0Iw==
Date: Fri, 21 Aug 2026 11:19:25 +0100
From: Simon Horman <horms@kernel.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_subashab@quicinc.com, quic_stranche@quicinc.com, doruk@0sec.ai,
	kuba@kernel.org
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: require CAP_NET_ADMIN in
 the real device netns for changelink
Message-ID: <20260821101925.GG265046@horms.kernel.org>
References: <20260813174727.14857-1-suruurism@gmail.com>
 <20260819083553.1134-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819083553.1134-1-suruurism@gmail.com>

On Wed, Aug 19, 2026 at 11:35:53AM +0300, Abdifatah Suruur wrote:
> A changelink() on an rmnet device mutates the rmnet port state attached
> to the real device (endpoint mux table, port->data_format and, via
> rmnet_vnd_update_dev_mtu(), the real device MTU).

There is an AI-generated review of this patch available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819083553.1134-1-suruurism%40gmail.com

It asks if the statement above is strictly accurate:

  Is the "the real device MTU" part accurate?  rmnet_vnd_update_dev_mtu()
  only reads real_dev->mtu:

  drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c:rmnet_vnd_update_dev_mtu() {
	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
		if (ep->egress_dev->mtu <= (real_dev->mtu - headroom))
			continue;
		if (rmnet_vnd_change_mtu(ep->egress_dev,
					 real_dev->mtu - headroom))
			return -1;
	}
  }

  The only MTU store is WRITE_ONCE(rmnet_dev->mtu, new_mtu) inside
  rmnet_vnd_change_mtu(), i.e. on the rmnet endpoint devices, not on
  real_dev.  Would it be more precise to say that changelink can shrink the
  MTU of the rmnet endpoint netdevs plus rewrite the shared
  port->data_format and mux table?

> The real device may
> live in a different netns than the rmnet device (rmnet_newlink()
> resolves it in link_net), but the rtnl path only checks CAP_NET_ADMIN
> against dev_net(dev).  A caller privileged only in the rmnet device's
> netns can therefore rewrite the shared cellular data-path state owned by
> another netns.
> 
> Gate rmnet_changelink() with rtnl_dev_link_net_capable(), matching the
> "require CAP_NET_ADMIN in the device netns for changelink" series
> (vxlan/geneve, CVE-2026-68432).

The AI-generated review at the link above also asks if
this patch is complete:

  This isn't a bug introduced by this patch, but do the bridge ops need the
  same gate?  rmnet_add_bridge() and rmnet_del_bridge() mutate the very same
  real_dev-owned struct rmnet_port and have no capability check:

  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c:rmnet_add_bridge() {
	port = rmnet_get_port_rtnl(real_dev);
	...
	slave_port->rmnet_mode = RMNET_EPMODE_BRIDGE;
	slave_port->bridge_ep = real_dev;
	slave_port->rmnet_dev = rmnet_dev;
	port->rmnet_mode = RMNET_EPMODE_BRIDGE;
	port->bridge_ep = slave_dev;
  }

  and on teardown, rmnet_del_bridge() -> rmnet_unregister_bridge() clears
  real_port->bridge_ep and real_port->rmnet_mode.

  Both are live rtnetlink entry points via rmnet_vnd_ops in rmnet_vnd.c:

	.ndo_add_slave  = rmnet_add_bridge,
	.ndo_del_slave  = rmnet_del_bridge,

  and do_set_master() in net/core/rtnetlink.c only resolves and authorizes
  within dev_net(dev):

	upper_dev = __dev_get_by_index(dev_net(dev), ifindex);
	...
	err = ops->ndo_add_slave(upper_dev, dev, extack);

  So with the same preconditions the commit message describes (rmnet device
  in netns A, real_dev in netns B, CAP_NET_ADMIN in A only), can a caller
  still run "ip link set <slave> master rmnetX" to set the foreign real
  device's port into RMNET_EPMODE_BRIDGE with port->bridge_ep pointing at a
  device it owns?  rmnet_rx_handler() would then call
  rmnet_bridge_handler(skb, port->bridge_ep) and forward frames received on
  the real device into the caller's netns.

  The runtime gates in rmnet_add_bridge() (port->nr_rmnet_devs <= 1,
  port->rmnet_mode == RMNET_EPMODE_VND) look like the normal
  single-rmnet-device state rather than a restriction.

  Would it make sense to apply rtnl_dev_link_net_capable() to those two ops
  as well, so the driver enforces one consistent rule about who may
  reconfigure the port?

There are also other issues raised on the same AI-generated review.
But in my opinion they they do not seem relevant to the progress of this patch.

> 
> Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> 
> ---
> v2:
> - drop Reported-by: (implied for the author), per Jakub Kicinski

When you post a new revision of a patch, please do so in a new email thread,
rather than as a response to the previous version.

Thanks!

...
