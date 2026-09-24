Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930E18DB1A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208717; cv=none; b=ezRdNfM+4bFsqFpW1O7GG+sY0dwjG4elSJx5dlXpds3U8Px7v/sPNXdr1XHnLutWx0qDVTdLstS4kI1fKxw6XEM+f3NG74GJx/9tagXAAIi3dxYMzLxWUdssbQDrzYvAuJJpqbFiIB+uWTi1Z5jplqFbrsyohbTSR8vPiR63J9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208717; c=relaxed/simple;
	bh=ET2MX0m/aZ6WTlxqr1OlSwni59bvhbimryIv25dzI5A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=os2+DXyPzK1w7oAEkC3kplvFs8DYM6VEHl1FUq+2293s+WEf34hTbfmi6D8Yy3M7WLuxnu3koGymaQFVYJgOA5xSv1GdS5/CYCyvYwan2WqPTw8EkayE94g2BHPr43Xgfc+Y87yUgvEjDpw/F+dHUoOOHAsG9hDBKt2ROIBVrEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NETwHMvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NETwHMvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476161F000FF;
	Thu, 24 Sep 2026 00:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208715;
	bh=FV7yM14gspAYdvVwvRtQ8+uL+/JkGjKC3B/b7hcH1X4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NETwHMvrrRU7oopDtzsyvjafPuPiCbhgwKp5fG0689B3Iykg4bXchyOZKiDWeteBb
	 19f0vyqeivV9yAIUTrk+tT28LgkfIt5G2Y9aTIS9HB6JwbAnUKquk2QPd82FmzAfVk
	 10iqItswLnSb/p1xvXk1RLJ7VL/JHMB3DpsB+f93dZm4dwMRGqVka+c1/hqeq/WERY
	 OVnT2EBFaCRJLlWGvyXRC9iYOFteZPCZnDT07vcLon8GntihSXyTa/EIaT2frVWpIN
	 gjX/b6kFKkWwCcggjNunDeMSVr4oSjQbNptdpZr73YtUF3EtLJTPD51DYuvcnDO8UE
	 mhVDBmJedwNOw==
Subject: Re: [PATCH v6 net-next 1/8] vxlan: update default fdb entries when
 the lower device changes
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 24 Sep 2026 00:11:54 +0000
Message-ID: <179020871481.2160803.2932183003834296918@kernel.org>
In-Reply-To: <20260922181102.3989489-2-edumazet@google.com>
References: <20260922181102.3989489-2-edumazet@google.com>
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
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 3 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Regression in vxlan_vni_update_group()
  (drivers/net/vxlan/vxlan_vnifilter.c).
- [Medium] Retrying a failed per-VNI group change now reports success
  without joining the multicast group.
- [Medium] vxlan: FDB state corruption due to extack API misuse

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the per-VNI
  IGMP leave paths drop a membership that other VNIs on the same device,…
- [High] This problem wasn't introduced by this patch, but a per-VNI IPv6
  multicast group can cause a NULL pointer dereference when the device…
- [Medium] This problem wasn't introduced by this patch, but the unwind
  in vxlan_multicast_join_vnigrp() can remove multicast memberships…

--

vxlan: update default fdb entries when the lower device changes

With this patch, vxlan_changelink() refreshes the default fdb entries,
including the per-VNI ones on VNIFILTER devices, when only the lower
device changes. It does this by passing the old and new ifindex down to
vxlan_update_default_fdb_entry(). It also sets oldrip in
vxlan_vni_update_group() whenever an existing VNI is updated, and moves
per-VNI multicast memberships during changelink for VNIFILTER devices.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 347245cc1de4e..a2cede8b082ab 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -4534,9 +4548,14 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  		dst->remote_dev = lowerdev;
>  	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
>  
> -	if (!err && change_igmp &&
> -	    vxlan_addr_multicast(&dst->remote_ip))
> -		err = vxlan_multicast_join(vxlan);
> +	if (change_igmp &&
> +	    (vxlan_addr_multicast(&dst->remote_ip) ||
> +	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER))) {
> +		int join_err = vxlan_multicast_join(vxlan);

[Severity: Medium]
This isn't a bug introduced by this patch, but this change makes
vxlan_multicast_join() reachable from vxlan_changelink() for VNIFILTER
devices whose default remote is not multicast. Can the unwind in
vxlan_multicast_join_vnigrp() drop memberships that belong to other
devices sharing the same socket?

drivers/net/vxlan/vxlan_multicast.c:vxlan_multicast_join_vnigrp() {
    ...
		ret = vxlan_igmp_join(vxlan, &v->remote_ip, 0);
		if (ret == -EADDRINUSE)
			ret = 0;
		if (ret)
			goto out;
		vgood = v;
	}
out:
	if (ret) {
		list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
			...
			vxlan_igmp_leave(vxlan, &v->remote_ip, 0);
			if (v == vgood)
				break;
    ...
}

A VNI whose join returned -EADDRINUSE got nothing new, because another
device already holds that membership on the shared socket. It is still
recorded as vgood, though.

If a later join fails (for example -ENOBUFS once igmp_max_memberships is
reached), the unwind leaves those groups without checking
vxlan_group_used(). If vgood is still NULL, it leaves every group.
Another device on the same socket would then stop receiving that group.

vxlan_open()->vxlan_multicast_join() already reaches this unwind, so
the problem predates this patch.

> +
> +		if (join_err)
> +			err = join_err;
> +	}
>  
>  	return err;
>  }

[Severity: Medium]
With this change a NULL extack alters what
vxlan_update_default_fdb_entry() does. When vxlan_fdb_update() fails
to add the new rdst, the error is no longer returned right away.
Instead the code falls through to __vxlan_fdb_delete() and removes the
old rdst anyway.

The rollback needs exactly that behavior. The unwind in
vxlan_vnilist_update_group() and in vxlan_changelink() has to remove
the new rdst even if re-adding the old one fails. Elsewhere in netlink
code, though, extack is optional, and NL_SET_ERR_MSG() and friends
accept NULL. A forward update that reaches this helper without an
extack would silently get rollback semantics.

For example, suppose the forward loop in vxlan_vnilist_update_group()
ran with a NULL extack and vxlan_fdb_update() failed with -ENOMEM for
one VNI. That VNI's old all-zeros rdst would be deleted and nothing
would replace it. The err_unwind loop starts at the entry after hpos
in list order, so it never revisits the VNI that failed. That VNI
would be left with no default fdb entry, and the fdb state would no
longer match default_dst or the VNI configuration.

Today vxlan_changelink() and vxlan_vni_add() only reach this helper
from rtnetlink with a non-NULL extack, so the forward case is not
reachable yet. Would it be cleaner to pass the rollback intent as a
separate bool argument? Then the add-failure handling would not depend
on whether the caller has an error message buffer.

[ ... ]

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e08865..336e8128be480 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -532,11 +537,12 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  			newrip = &dst->remote_ip;
>  	}
>  
> -	/* if old rip exists, and no newrip,
> -	 * explicitly delete old rip
> -	 */
> -	if (!newrip && !vxlan_addr_any(&old_remote_ip))
> -		oldrip = &old_remote_ip;
> +	if (!create) {
> +		if (!vxlan_addr_any(&old_remote_ip))
> +			oldrip = &old_remote_ip;
> +		else if (!vxlan_addr_any(&dst->remote_ip))
> +			oldrip = &dst->remote_ip;
> +	}

[Severity: Medium]
Since oldrip is now set whenever !create, can the existing equality
check just below return early and drop the requested change?

	if (!create && oldrip && newrip && vxlan_addr_equal(oldrip, newrip))
		return 0;

This return runs before the group is stored in vninode->remote_ip and
before *changed is set, so no RTM_NEWTUNNEL notification is sent. Before
this patch, oldrip was only set when newrip was NULL, so this return could
not be reached.

Here are two cases where it seems to matter.

VNI 10 inherits the device group D (vninode->remote_ip is zero), and
"bridge vni add dev vxlan0 vni 10 group D" is run. newrip is group (D)
and oldrip is &dst->remote_ip (D). The function returns 0 and the VNI is
never pinned to D.

VNI 10 has an explicit group G equal to D and is re-added without a group
to clear it. vxlan_process_vni_filter() passes a zeroed, non-NULL group,
so newrip is &dst->remote_ip (D) and oldrip is &old_remote_ip (G). The
explicit group is never cleared.

In both cases success is returned, but the stored state does not match
the request.

vxlan_vnilist_update_group() in this patch uses
vxlan_addr_any(&vent->remote_ip) to decide whether a VNI follows a device
group change. So a later "ip link set vxlan0 type vxlan group D2" would
move the VNI in the first case, and fail to move it in the second, against
its configuration. "bridge vni show" would also report the wrong group
through vxlan_fill_vni_filter_entry().

Should the early return also check whether vninode->remote_ip itself is
changing?

[Severity: Medium]
A related question about the same early return: can retrying a failed
group change now succeed without joining the multicast group?

When an existing VNI moves from group A to B, vxlan_vni_update_group()
stores B before it joins:

	if (group)
		memcpy(&vninode->remote_ip, group, sizeof(vninode->remote_ip));
	...
		if (vxlan_addr_multicast(&vninode->remote_ip)) {
			ret = vxlan_igmp_join(vxlan, &vninode->remote_ip, 0);
			...
			if (ret)
				goto out;

If vxlan_igmp_join() fails, for example with -ENOBUFS once
net.ipv4.igmp_max_memberships is reached, the error goes back to user
space but B stays stored.

Suppose the limit is then raised and "bridge vni add ... group B" is run
again. oldrip is &old_remote_ip (B) and newrip is group (B), so the
equality check returns 0 before the leave/join block runs. The VNI stays
configured for B with no membership, and the command reports success.

Before this patch, oldrip was NULL here, so the retry still reached the
IGMP block.

>  
>  	if (!newrip && !oldrip)
>  		return 0;

[ ... ]

> @@ -560,6 +568,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  				      vxlan->default_dst.remote_ifindex)) {
>  			ret = vxlan_igmp_leave(vxlan, &old_remote_ip,
>  					       0);
> +			if (ret == -EADDRNOTAVAIL)
> +				ret = 0;
>  			if (ret)
>  				goto out;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but can this leave drop a
membership that another VNI on the same device, or the device default
group, still needs?

vxlan_group_used() returns false immediately when the socket refcnt is 1.
Otherwise it skips the device itself:

drivers/net/vxlan/vxlan_multicast.c:vxlan_group_used() {
    ...
	if (family == AF_INET && sock4 && refcount_read(&sock4->refcnt) == 1)
		return false;
    ...
	list_for_each_entry(vxlan, &vn->vxlan_list, next) {
		if (!netif_running(vxlan->dev) || vxlan == dev)
			continue;
    ...
}

Its vni argument is never used, so sibling VNIs and default_dst on the
same device are never counted.

For example, take an UP VNIFILTER device where VNI 10 and VNI 20 both use
239.1.1.1. vxlan_multicast_join_vnigrp() joins once and treats the second
-EADDRINUSE as success. "bridge vni del dev vxlan0 vni 10" then goes
through vxlan_vni_del()->vxlan_vni_delete_group()->vxlan_igmp_leave() and
removes the socket's only membership. VNI 20 then stops receiving BUM
traffic for that group.

In the same way, moving a VNI whose explicit group equals
default_dst.remote_ip to another group makes this block leave the default
group that vxlan_multicast_join() joined for the device.

The patch adds a default group skip and -EADDRNOTAVAIL tolerance to
vxlan_multicast_leave_vnigrp() for shared groups. The single-VNI update and
delete paths still behave as before. Should they follow the same rules?

[Severity: High]
This is a pre-existing issue, but can the per-VNI join and leave calls
here dereference a NULL vn6_sock?

vxlan_sock_add() tolerates -EAFNOSUPPORT when it creates the IPv6 socket:

		ret = __vxlan_sock_add(vxlan, true);
		if (ret < 0 && ret != -EAFNOSUPPORT)
			ipv4 = false;

With CONFIG_IPV6=y and ipv6.disable=1, a collect metadata VNIFILTER
device can therefore be up with vn6_sock == NULL.

vxlan_process_vni_filter() accepts VXLAN_VNIFILTER_ENTRY_GROUP6 without
checking for an IPv6 socket. vxlan_igmp_join() then does:

		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);

		sk = sock6->sk;

The call chain is RTM_NEWTUNNEL -> vxlan_vnifilter_process() ->
vxlan_process_vni_filter() -> vxlan_vni_add() -> vxlan_vni_update_group()
-> vxlan_igmp_join(). For example, "bridge vni add dev vxlan0 vni 10 group
ff05::1" on an UP device.

vxlan_open() reaches the same helper through vxlan_multicast_join_vnigrp().
With this patch, vxlan_changelink() also reaches it for VNIFILTER devices.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922181102.3989489-1-edumazet%40google.com
