Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952B4C9001
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890640; cv=none; b=r1eUWchcvmwfjckSjRVtcMv5pD/MHP2bK87Z+pI5rk3M97/T5wknPknXZ85TR/DDNCgukzR+NmZY0vj83FLg5Vu2JE5LQGoNw3WUvlAWvvZNr3bOLfsw9HnG5SzbOTPRJdbOAwMQoAC5Q+Vyw4ln4T15aGw+ToBo3fPO34m3Juk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890640; c=relaxed/simple;
	bh=6In5PZXb29i7IorCxuVtwse5MF+kf1xU/oSWUkWSXF8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohKhdXCgU6TOdnWByGOjUMREGbTY9/bj36sdptNLKum4etyUQ6AMV5XfFdH+OSIpGMS0d0zXN3WADwla4ryumvGgzRWLR602SSB7zaVZsBzpoAK99f2AsYxmlc8bIUl41oLA7tvPH+SmzsllG7solFZSW+rP6ZlGAjdp2+wx/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1C13/tW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1C13/tW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366571F00A3A;
	Tue,  8 Sep 2026 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890638;
	bh=q88lUOrJdjx/QKL6vyKrQbGe/bv6DQYG2uRR80wm/E0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f1C13/tW3ceRcgAG1gSHFXFdLvZy5rVFbWE+rkJ9JTawhqszt3ZSj++pkhky7Asm6
	 DjUyzV4pyf99hvnLR9U0960OG1DzQKiLg4+VaSPqY4JlE/1aBMQqWW9rWHEsMtCZhu
	 FgIZfllZhwpi6OVsQAfJ1d3L4QxEBnPIUrwNtqvSG+l7vSRpJUDlBx9uPOURq+gnMk
	 pxm7a9aoIxSf02FLsi4FpsY0QSoZeENaCqvHL6l+KRC1m4Q4Jw/Bv4Hn3+DpF1qhfs
	 qAThJh6CPZ/eN8Tm/Z6SeVpQZ/yZyrlh1lVwaK1zihk2AGR0RtPgTRy1YBtH6ffiP2
	 tG0u544zvI53A==
Subject: Re: [PATCH v2 net-next 8/8] vxlan: no longer rely on RTNL in
 vxlan_fill_info()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 18:03:57 +0000
Message-ID: <178889063777.219967.12487536474478798149@kernel.org>
In-Reply-To: <20260906180111.1973188-9-edumazet@google.com>
References: <20260906180111.1973188-9-edumazet@google.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] vxlan_fill_info() (drivers/net/vxlan/vxlan_core.c:4719-4721)
  newly returns -ENODEV when rcu_dereference(vxlan->cfg) is NULL, but…

--

vxlan: no longer rely on RTNL in vxlan_fill_info()

This converts vxlan_fill_info() from rtnl_dereference() to
rcu_dereference() so link info dumping no longer needs RTNL, adding a
NULL check on vxlan->cfg that returns -ENODEV.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 2b7da90ae2da3..fd993a95501b0 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -4712,8 +4712,14 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	const struct vxlan_dev *vxlan = netdev_priv(dev);
>  	struct ifla_vxlan_port_range ports;
>  	const struct vxlan_config *cfg;
> +	int err = 0;
>  
> -	cfg = rtnl_dereference(vxlan->cfg);
> +	rcu_read_lock();
> +	cfg = rcu_dereference(vxlan->cfg);
> +	if (!cfg) {
> +		err = -ENODEV;
> +		goto out;
> +	}

[Severity: Low]

Can the rtnetlink core actually observe this -ENODEV?  The value returned
by rtnl_link_ops->fill_info() is propagated up through
rtnl_link_info_fill() -> rtnl_link_fill() into rtnl_fill_ifinfo(), which
only tests for failure:

net/core/rtnetlink.c:rtnl_fill_ifinfo() {
	...
	if (rtnl_link_fill(skb, dev) < 0)
		goto nla_put_failure;
	...
nla_put_failure:
	nlmsg_cancel(skb, nlh);
	return -EMSGSIZE;
}

so the -ENODEV is rewritten to -EMSGSIZE.  The callers treat -EMSGSIZE as
an internal kernel bug rather than as "device is going away":

net/core/rtnetlink.c:rtnl_getlink() {
	...
		if (err == -EMSGSIZE) {
			if (!need_rtnl) {
				/* Some altnames were added, retry with RTNL. */
				need_rtnl = true;
				goto retry;
			}
			/* -EMSGSIZE implies BUG in if_nlmsg_size */
			WARN_ON_ONCE(1);
		}
	...
}

net/core/rtnetlink.c:rtmsg_ifinfo_build_skb() {
	...
		/* -EMSGSIZE implies BUG in if_nlmsg_size() */
		WARN_ON(err == -EMSGSIZE);
	...
}

and in rtnl_dump_ifinfo() a negative return aborts the whole RTM_GETLINK
dump with "if (err < 0) break;" instead of skipping just this device.

Separately, is this branch reachable at all?  vxlan_config_apply()
publishes a non-NULL cfg before register_netdevice(), and the only writer
storing NULL is vxlan_free_dev():

drivers/net/vxlan/vxlan_core.c:vxlan_free_dev() {
	...
	RCU_INIT_POINTER(vxlan->cfg, NULL);
	kfree(cfg);
	...
}

which runs as dev->priv_destructor (after the device is unregistered and
no longer dumpable) or on the register_netdevice() failure path in
vxlan_dev_create(), where the device was never visible to rtnetlink.

If it is indeed unreachable, would dropping the check be clearer?  If it
is considered reachable, would returning 0 (emitting no vxlan attributes)
be preferable, so a device teardown race does not produce a WARN splat and
does not truncate "ip link show" output for unrelated devices?

Also, the sibling lockless reader of the same pointer has no NULL check:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vnifilter_dump_dev() {
	...
	cfg = rcu_dereference(vxlan->cfg);
	if (!(cfg->flags & VXLAN_F_VNIFILTER)) {
	...
}

Should the two agree on whether a NULL cfg is possible?

Would it be worth mentioning this new -ENODEV path in the changelog, since
the commit message only describes the rtnl_dereference() to
rcu_dereference() conversion?

>  
>  	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
>  		goto nla_put_failure;

[ ... ]

> @@ -4812,9 +4818,12 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  		    &cfg->reserved_bits))
>  		goto nla_put_failure;
>  
> -	return 0;
> +out:
> +	rcu_read_unlock();
> +	return err;
>  
>  nla_put_failure:
> +	rcu_read_unlock();
>  	return -EMSGSIZE;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906180111.1973188-1-edumazet%40google.com
