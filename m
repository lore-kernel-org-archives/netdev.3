Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88652B1EC;
	Fri,  4 Sep 2026 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560685; cv=none; b=OXv8fBmMNK4gU3s8xTpuMMlceJt/7PhWV/dXkIMLIZufmGxb/fdv74TWLxI0eMnibmFc/6kZFsal6nEjVJEnZh710ml4UqQxTYwNUakByfKGQpPdr8r2wBRTSUnlOP832eW+W3wMSK9LcsE84l7f1jA117liJ6QycVdA5N2nBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560685; c=relaxed/simple;
	bh=cuotVeQizc7mKopPKuLr3bkYQMwWFlcqNgHHAafSG2w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXav4fqOJCW8ifCwE3cugZsA/ZN+CKXS6czqiA53HbRijB014ta+/+dmie+e5041/aFegtl14tuOtcDRHgjDx8kBQrDLFBVM3AsHRQBz2J3uA0zd7XneTj0sA/hmGweHn8vEb5qAwumrFzHRwvsEwmLucd7QCe0ETmcz0Wcc44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF2xIf4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF2xIf4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC851F00A3F;
	Fri,  4 Sep 2026 22:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560680;
	bh=NwsHrgnR2e6+9VnSSk2KeT/+t3tJWBzUO9TJLFGYEuc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OF2xIf4/PS2XM2knFwDbQYd/CUFuyszOeYi6fEeShthPzieIbWm67MV6wVVxun6d9
	 HAjmWqx25gVkoZe4X1wzc/7jDfmUFHHzsvTau0sDBmi6Jd5BMLAzD6FebWxnR6tCra
	 EozHUGrzoD9Wmi1Ck5ukzFRbDk9Rdjd0msksZIcAg/JsrjshxDY3rhBNeeZE3Btopk
	 ke00Z+n8wEpFM7qxX+oiGUJ2FOgvZd3LFyOfvDGbcEEgDFyaas6RpItGoG6A8oDQEq
	 i6kReCtmciCaKZE9FVFR5xpN+HXubWqCzyZhSdBycWzyD93NZjFXYTMuLOwZudda11
	 rmCKMNawSrIlA==
Subject: Re: [PATCH net v3] net: qualcomm: rmnet: require CAP_NET_ADMIN in the
 real device netns for config ops
From: netdev-bot+sashiko@kernel.org
To: suruurism@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 subash.a.kasiviswanathan@oss.qualcomm.com, sean.tranchetti@oss.qualcomm.com,
 horms@kernel.org, kuba@kernel.org
Date: Fri, 04 Sep 2026 22:24:39 +0000
Message-ID: <178856067967.219967.7550358106155720232@kernel.org>
In-Reply-To: <20260829170656.15548-1-suruurism@gmail.com>
References: <20260829170656.15548-1-suruurism@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Wrong reference netns in the new capability gate on the
  ndo_del_slave path.
- [Low] The two comments added above the new gates in rmnet_add_bridge()
  (lines 452-456) and rmnet_del_bridge() (lines 512-516) were copied…
- [Low] The new capability rejections return -EPERM silently.

--

net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops

This adds rtnl_dev_link_net_capable() gates to rmnet_changelink(),
rmnet_add_bridge() and rmnet_del_bridge() so that a caller privileged only
in the rmnet device's netns can no longer rewrite the rmnet port state
attached to a real device living in another netns.  rmnet_del_bridge() also
grows local priv/real_dev lookups for the new check.

A few questions below.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf2..6feafc55a7e9 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -312,6 +312,14 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!rmnet_is_real_dev_registered(real_dev))
>  		return -ENODEV;
>  
> +	/*
> +	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
> +		return -EPERM;
> +

[Severity: Low]
This isn't a bug, but should the new rejection report through extack?

Both rmnet_changelink() and rmnet_add_bridge() take a
struct netlink_ext_ack *extack, and every other error return in those two
functions fills it in:

	NL_SET_ERR_MSG_MOD(extack, "MUX ID already exists");
	NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
	NL_SET_ERR_MSG_MOD(extack, "more than one rmnet dev attached");
	NL_SET_ERR_MSG_MOD(extack, "more than one bridge dev attached");
	NL_SET_ERR_MSG_MOD(extack, "slave cannot be another rmnet dev");

The closest peer users of the same gate do report the reason, e.g. in
macvlan_changelink():

	    !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev))) {
		NL_SET_ERR_MSG(extack,
			       "Changing shared macvlan port settings requires CAP_NET_ADMIN in the lower device network namespace");
		return -EPERM;

Since the generic rtnetlink capability check also returns -EPERM for
RTM_NEWLINK/RTM_SETLINK, can user space tell the two denials apart as
written?

>  	port = rmnet_get_port_rtnl(real_dev);
>  
>  	if (data[IFLA_RMNET_MUX_ID]) {

[ ... ]

> @@ -441,6 +449,14 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>  
> +	/*
> +	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */

[Severity: Low]
This isn't a bug, but the comment appears to have been copied from the
rmnet_changelink() hunk without adjusting it.

rmnet_add_bridge() and rmnet_del_bridge() have no dev parameter or local:

	int rmnet_add_bridge(struct net_device *rmnet_dev,
			     struct net_device *slave_dev,
			     struct netlink_ext_ack *extack)

	int rmnet_del_bridge(struct net_device *rmnet_dev,
			     struct net_device *slave_dev)

The rtnl entry point for these two is RTM_SETLINK IFLA_MASTER via
do_set_master() and ndo_add_slave/ndo_del_slave, where the caller was
checked against dev_net(slave_dev) rather than a changelink on dev.  Could
both comments name slave_dev instead of the non-existent dev?

Also, the three added blocks use the form with '/*' alone on the first
line, while the surrounding comments in this file put text on the first
line, e.g. just below in the same function:

	/* If there is more than one rmnet dev attached, its probably being
	 * used for muxing. Skip the briding in that case
	 */

> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port = rmnet_get_port_rtnl(real_dev);
>  
>  	/* If there is more than one rmnet dev attached, its probably being

[ ... ]

> @@ -489,7 +505,19 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/*
> +	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but rmnet_unregister_bridge() below clears the bridge state of
> +	 * the real device's port, which may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;

[Severity: Medium]
Is rmnet_dev the right reference device for the gate on the del path?

rtnl_dev_link_net_capable() short-circuits when the two namespaces are
equal:

net/core/rtnetlink.c:rtnl_dev_link_net_capable() {
	return net_eq(link_net, dev_net(dev)) ||
	       ns_capable(link_net->user_ns, CAP_NET_ADMIN);
}

On ndo_del_slave the netns the rtnl layer actually verified CAP_NET_ADMIN
against is dev_net(slave_dev), and rmnet_dev is simply whatever master is
already linked:

net/core/rtnetlink.c:do_set_master() {
	struct net_device *upper_dev = netdev_master_upper_dev_get(dev);
	...
		if (ops->ndo_del_slave) {
			err = ops->ndo_del_slave(upper_dev, dev);
	...
}

There is no netns-equality requirement on that master link, and nothing
seems to forbid moving the rmnet vnd device out of the slave's netns:
rmnet_vnd_setup() does not set dev->netns_immutable,
__dev_change_net_namespace() only refuses netns_immutable devices, and
rmnet_config_notify_cb() reacts to NETDEV_UNREGISTER only when
rmnet_is_real_dev_registered(dev) is true, which is false for the vnd
device, so moving rmnet_dev does not tear the bridge down.

If rmnet_dev ends up in real_dev's netns A while slave_dev stays in netns
B, then net_eq(dev_net(real_dev), dev_net(rmnet_dev)) is true, ns_capable()
is never evaluated, and a caller holding CAP_NET_ADMIN only in B can run
"ip link set <slave> nomaster" and reach:

drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c:rmnet_unregister_bridge() {
		real_port = rmnet_get_port_rtnl(real_dev);
		real_port->bridge_ep = NULL;
		real_port->rmnet_mode = RMNET_EPMODE_VND;
}

which is the cross-netns port mutation the commit message describes.
Reaching that state does need a prior CAP_NET_ADMIN-in-A action to move
rmnet_dev, so the window is narrow.

Would using slave_dev as the reference device on both bridge paths close
this?  On the add path the two are equivalent, since do_set_master()
resolves the new master with __dev_get_by_index(dev_net(slave_dev),
ifindex), so passing slave_dev there too would make the invariant
explicit.

> +
> +	port = rmnet_get_port_rtnl(slave_dev);
>  
>  	rmnet_unregister_bridge(port);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829170656.15548-1-suruurism%40gmail.com
