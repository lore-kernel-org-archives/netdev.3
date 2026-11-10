Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322513;
	b=PKMgBpV39RTl447F36n8bteAHIMF0gK07U6glEJsrDstf66a9INuDTndOdWGfWAhVMJs
	 an0+fz+8vb6WdYs2QkBBXGMw2gsdfgNqOOyg9glhtaW4proDrqOu4c+A6sFdueCY+7ThO
	 irMJ8CWId/hSSlAFWTwaTlGsyO4pDZuYpTypATto0buLSixyWhRISPKOMjKz23AHHItx0
	 uxcXHgS4zGpS9VXWiG7uMgDf8G3j0WPYSkDUA/WHAnc1d9V0oLH0MqmeVFD74BivoHBJg
	 5zzF2hriARPJj8K8ll61zuMKmqK8zKh+QBS1dvdkbKcPmwmrnri333yP8+7HdFY3xSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322513;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dw1TUmCD2wrM5AvQNqzzB+FJxWS0OBx0q64Za5TvUwU=;
	b=af5SBk0QFBWounurVtPqNRORut83O5qSZHVv9npUHR/xLQVT3gYcJnn0TbyX8hC5It98
	 7UlsxLHwGzvfNQhdzlyFWbijohvDttoYKeztxleL9+VKAKzqPkq0VAdEq9jueLi7bcl9n
	 uaf7FHiy5uvE2w+3Z8RSsTp1+Q55uoocpRpD0msCvH2L1mcKX2GJFhDjxpsRqUbNHBd2y
	 QEg3RYwr2IYBWUtd+CwSiAPtR6JJoPI9FUdMQF1HE5c3YMbREXNzqEsA+DykmAJnJvX+2
	 gGQ8XH2OvNBvJfNKk+3EDI0p3LoufDeG24HolmXt42GiTZDfkh2VFU6tkDbvI4CgV5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPLHVBY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76703606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPLHVBY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7721F0089F;
	Tue, 10 Nov 2026 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322513;
	bh=dw1TUmCD2wrM5AvQNqzzB+FJxWS0OBx0q64Za5TvUwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iPLHVBY+AdB3QaqOp52jrQyIilTHa19bsUujv2MoV2hXIMUkF5xocLolBaUSr7fmE
	 i4L93X2/RN8ZZKht3VdJGdqS76CJMme3HMVh6/kFp6OYOA6CLASzxeCQkvgUDOluZ1
	 ffB0+pdxzOUXqN7XBEeiZ5WVJnvegvuzPajA5WNabOCOWrGeirJXOblfc2embaMFBs
	 +dYt3o8igvs3VNzWVHcExlTSpE4rvDUQ3ma2quYzc+/OBtJpOyEig6mBqO79tBbZh8
	 J5a9/y7BC9VjmSfcQuyglGCMWRyjN1nye45orT4iU4zGZAFLrXv4wJcaVmEKW++GzA
	 Kb86pwZs3hGcw==
Subject:
 Re: [PATCH net] vxlan: reset the remote's dst cache when snooping moves a MAC
From: netdev-bot+sashiko@kernel.org
To: ilskdw@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Tue, 10 Nov 2026 14:55:12 +0000
Message-ID: <179432251224.994134.6565482770882182020@kernel.org>
In-Reply-To: <20261106144406.66035-1-ilskdw@gmail.com>
References: <20261106144406.66035-1-ilskdw@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In vxlan_snoop() (drivers/net/vxlan/vxlan_core.c), the patch
  adds only the dst_cache_reset() from vxlan_fdb_replace(), even though…
- [Low] The new dst_cache_reset() in vxlan_snoop()
  (drivers/net/vxlan/vxlan_core.c:1485) runs in RX softirq context with…

--

vxlan: reset the remote's dst cache when snooping moves a MAC

This patch makes vxlan_snoop() reset the remote's dst_cache when a known
MAC shows up from a different remote and the remote IP is rewritten in
place. vxlan_fdb_replace() already does this on the netlink path. The
goal is to stop traffic to the moved MAC from using a dst cached for the
previous remote.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index d11028b374721..6ee071cd2d280 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1482,6 +1482,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
>  				    "%pM migrated from %pIS to %pIS\n",
>  				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
>  
> +		dst_cache_reset(&rdst->dst_cache);
>  		rdst->remote_ip = *src_ip;
>  		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);

[Severity: High]
Should this branch also update rdst->remote_ifindex and clear
rdst->offloaded, as vxlan_fdb_replace() does?

The commit message names vxlan_fdb_replace() as the reference. That
function does more than reset the cache:

drivers/net/vxlan/vxlan_core.c:vxlan_fdb_replace() {
    ...
	dst_cache_reset(&rd->dst_cache);
	rd->remote_ip = *ip;
	rd->remote_port = port;
	rd->remote_vni = vni;
	rd->remote_ifindex = ifindex;
	rd->offloaded = false;
    ...
}

The early return in vxlan_snoop() checks both the address and the
ifindex:

	if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
		   rdst->remote_ifindex == ifindex))
		return SKB_NOT_DROPPED_YET;

ifindex is src_ifindex for IPv6 link-local sources and 0 for everything
else. In these cases remote_ifindex still holds the old remote's value
after this branch runs:

- a MAC moves from a global address to an fe80:: address
- a MAC moves from an fe80:: address to a global address
- the same fe80:: address arrives on a different lower device
- a dynamic entry was created over netlink with an explicit via ifindex

On TX, vxlan_xmit_one() passes that stale value to the route lookup as
the oif:

	ifindex = rdst->remote_ifindex;

After the reset, could the cache be refilled with a route computed for
the previous remote's interface? If so, traffic to the moved MAC would
still go the wrong way, which is the problem this patch is meant to fix.

Also, remote_ifindex never matches again after this, so every later
packet from that peer re-enters this migration branch. With this patch
each of those packets now calls dst_cache_reset(), so every TX that
follows an RX does a full route lookup. Each one also sends an
RTM_NEWNEIGH notification and calls the switchdev notifiers. Neither is
ratelimited.

A stale offloaded bit would also make vxlan_fdb_info() report
NTF_OFFLOADED for a remote IP that no switchdev driver has acknowledged.

The missing remote_ifindex update goes back to commit 87613de95041
("vxlan: fix snooping for link-local IPv6 addresses"). The per-packet
dst_cache_reset() is new in this patch, though.

Would adding these here cover it?

	rdst->remote_ifindex = ifindex;
	rdst->offloaded = false;

[Severity: Low]
Can a concurrent transmitter still cache a route to the previous remote
after this reset?

The reset and the remote_ip store run in RX softirq context. No lock is
shared with the TX path. vxlan_xmit_one() copies remote_ip into the flow
key before it looks up rdst->dst_cache:

	key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;

dst_cache_per_cpu_get() treats an entry as stale only in this case:

	if (unlikely(!time_after(idst->refresh_ts,
				 READ_ONCE(dst_cache->reset_ts)) || ...

Consider this interleaving:

CPU0 (TX, vxlan_xmit_one)          CPU1 (RX, vxlan_snoop)
reads old remote_ip into key
                                   dst_cache_reset()   /* reset_ts = J1 */
                                   rdst->remote_ip = *src_ip;
<jiffies ticks>
dst_cache_get_ip4() misses,
  refresh_ts = J2 > J1
route lookup to the old address
dst_cache_set_ip4()

Later packets on CPU0 put the new remote in the key, but they hit the
cached dst for the old next hop. vxlan_snoop() now sees matching
addresses, so nothing resets the cache again until the route is flushed
or the dst becomes obsolete.

Swapping the store and the reset would not close this, because TX reads
remote_ip without serialization. With IPv6, TX could also read a torn
value from the plain struct store to remote_ip and cache a route for it
the same way.

The window is narrow. vxlan_fdb_replace() and other dst_cache users that
reset after changing tunnel parameters have the same limitation, so this
may come from the lockless dst_cache invalidation design. Since the fix
depends on this reset, is that window acceptable here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106144406.66035-1-ilskdw%40gmail.com
