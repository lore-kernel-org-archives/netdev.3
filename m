Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120C37A486
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901309; cv=none; b=KFVOiRDbzEckFu73HgpxSOCwUD8uAfDsuoMlDFfPsBbU8r7G4y2PoqhMsKWX+SU9Wj7p6efWB6UvnMtWdu7b0gNWW8OR8/1P2PsYZ35Ve8jg2AuJcWcQEZz24KKKmxNUegSXuNIOd/t6eFDHH8AhONVBbJQwiY2ymmFRK3s9dxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901309; c=relaxed/simple;
	bh=YhSAavtf/ce8PHCEKR8csZaeLE8oIWWvplfKs56n96I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0cRSELscgdCXrvsrnFyIOEw5k5C4TYpvGgMQl+qOqGcYSVRRf7sWT7a+bYae17flpjbyGNE+G+yVK0ZOKV2LAiMEAAqrWABPDNauC9KWRCf0sSdFLfpiaomM0dWRtfPRx8AvDRcBEHjvAt2TVNtNSsFfWqF9bXbHcrxt8x+eRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy2O8K8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy2O8K8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA081F00893;
	Sun, 20 Sep 2026 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789901308;
	bh=cNdd5bkDTCehU+r0iJztnM4F6KvBb1O2bXR97RIofoQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Iy2O8K8SEE43Jot5UsfSRA8SXHUencopnFW868TXy48J7uhLeTVPELZ4pw/ekOqJI
	 vRai1o6z9B0bFTVguv6lZXMz2w0eB38YK+dDWnn8oT8DXVww5xBhDUeJ85MRbXWspL
	 zGKhzHMXXCToUWQ/CKO/0iVtHe1NoD7jrUh4zm2+ptTrvdbp0XgDoa3a6f9JnRi5cq
	 In4PpwPFdztkdosrT+4V/NV+qPqrFvZ4iPBD46RoCgeHADp/oQJzQEmOkK4QvlU56z
	 j5DZkhDc0WO8DIK1FOWwO3hoLc04CzoOqnItxYZgRv8EhzmXcpQIrMXHMySJJ5/8Y3
	 sxtPNynimJ/2Q==
Subject: Re: [PATCH net v2 2/5] ip_gre: validate netlink attributes before
 changing the tunnel
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Sun, 20 Sep 2026 10:48:27 +0000
Message-ID: <178990130736.2160803.12432231092797859786@kernel.org>
In-Reply-To: <20260916100155.1398403-3-edumazet@google.com>
References: <20260916100155.1398403-3-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the collect_md / dev->type mutation is still
  committed to the live device before the last fallible step of the…

Pre-existing issues:
- [Medium] The batched commit of the four ERSPAN configuration fields at
  the end of erspan_netlink_parms() (net/ipv4/ip_gre.c:1306-1309) uses…

--

ip_gre: validate netlink attributes before changing the tunnel

The patch moves the IFLA_GRE_COLLECT_METADATA handling after the
IFLA_GRE_IGNORE_DF validation in ipgre_netlink_parms(), and parses the
ERSPAN attributes into local variables in erspan_netlink_parms() so they
are only committed to the live tunnel once all of them validate.

A couple of questions below.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 82309efd417e0..dad3d054bd156 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1233,12 +1233,6 @@ static int ipgre_netlink_parms(struct net_device *dev,
>  		parms->iph.frag_off = htons(IP_DF);
>  	}
>  
> -	if (data[IFLA_GRE_COLLECT_METADATA]) {
> -		t->collect_md = true;
> -		if (dev->type == ARPHRD_IPGRE)
> -			dev->type = ARPHRD_NONE;
> -	}
> -
>  	if (data[IFLA_GRE_IGNORE_DF]) {
>  		if (nla_get_u8(data[IFLA_GRE_IGNORE_DF])
>  		  && (parms->iph.frag_off & htons(IP_DF)))
> @@ -1246,6 +1240,16 @@ static int ipgre_netlink_parms(struct net_device *dev,
>  		t->ignore_df = !!nla_get_u8(data[IFLA_GRE_IGNORE_DF]);
>  	}
>  
> +	/* All attributes parsed here have been validated, we can change @dev
> +	 * and @t. This only makes this parser all-or-nothing, the caller can
> +	 * still fail in ip_tunnel_changelink().
> +	 */
> +	if (data[IFLA_GRE_COLLECT_METADATA]) {
> +		t->collect_md = true;
> +		if (dev->type == ARPHRD_IPGRE)
> +			dev->type = ARPHRD_NONE;
> +	}
> +

[Severity: High]
Does this still leave the exact failure mode described in the changelog
reachable?  The changelog says:

    A request carrying IFLA_GRE_COLLECT_METADATA and an invalid
    IFLA_GRE_IGNORE_DF returns -EINVAL, but dev->type has already become
    ARPHRD_NONE, breaking the interface for good.

The collect_md / dev->type mutation is still committed inside the parser,
and ip_tunnel_changelink() runs after it with three reachable rejections:

net/ipv4/ip_tunnel.c:ip_tunnel_changelink() {
	if (dev == itn->fb_tunnel_dev)
		return -EINVAL;

	t = ip_tunnel_find(itn, p, dev->type);

	if (t) {
		if (t->dev != dev)
			return -EEXIST;
	} else {
		...
			if ((dev->flags ^ nflags) &
			    (IFF_POINTOPOINT | IFF_BROADCAST))
				return -EINVAL;
	...
}

ipgre_changelink() and erspan_changelink() both propagate that error
directly with no rollback:

net/ipv4/ip_gre.c:ipgre_changelink() {
	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
	if (err < 0)
		return err;

	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
	if (err < 0)
		return err;
	...
}

One deterministic trigger is:

    ip link set gre0 type gre external

The fallback device carries ipgre_link_ops, so the parser flips gre0 to
collect_md and ARPHRD_NONE, then ip_tunnel_changelink() returns -EINVAL on
the dev == itn->fb_tunnel_dev test.

A second trigger is a point-to-point gre tunnel plus a changelink carrying
only IFLA_GRE_COLLECT_METADATA: parms is memset in the parser, so
p->iph.daddr stays 0, nflags becomes 0 and the IFF_POINTOPOINT mismatch
returns -EINVAL after dev->type was already changed.

Since IFLA_GRE_COLLECT_METADATA is an NLA_FLAG and nothing in the tree ever
clears t->collect_md or restores ARPHRD_IPGRE, is the device left
permanently inconsistent while user space was told the request failed?
ipgre_fill_info() then also reports the rejected state back on a dump.

There is a further effect from the latched flag: a later deletion of that
device reaches

net/ipv4/ip_tunnel.c:ip_tunnel_del() {
	if (t->collect_md)
		rcu_assign_pointer(itn->collect_md_tun, NULL);
	...
}

even though this tunnel was never registered as the netns metadata tunnel,
so can this de-register the legitimate external GRE tunnel of the netns and
blackhole its ingress via ip_tunnel_lookup()?

Would it work to stage collect_md, ignore_df and dev->type (and the ERSPAN
fields below) and commit them only after ip_tunnel_changelink() succeeds,
the way net/ipv6/ip6_gre.c carries them through struct __ip6_tnl_parm?

>  	if (data[IFLA_GRE_FWMARK])
>  		*fwmark = nla_get_u32(data[IFLA_GRE_FWMARK]);
>  
> @@ -1259,40 +1263,51 @@ static int erspan_netlink_parms(struct net_device *dev,
>  				__u32 *fwmark)
>  {
>  	struct ip_tunnel *t = netdev_priv(dev);
> +	u8 erspan_ver = t->erspan_ver;
> +	u32 index = t->index;
> +	u16 hwid = t->hwid;
> +	u8 dir = t->dir;
>  	int err;

[ ... ]

> +	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
> +	if (err)
> +		return err;
> +
> +	/* All attributes parsed here have been validated, we can change @t. */
> +	t->erspan_ver = erspan_ver;
> +	t->index = index;
> +	t->hwid = hwid;
> +	t->dir = dir;
> +
>  	return 0;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but the publication of these
four fields is unsynchronized against the transmit path, and the version is
still stored first.

erspan_xmit() reads all four with plain loads from softirq context with no
lock, RCU or seqcount:

net/ipv4/ip_gre.c:erspan_xmit() {
	if (tunnel->erspan_ver == 0) {
		...
	} else if (tunnel->erspan_ver == 1) {
		erspan_build_header(skb, ntohl(tunnel->parms.o_key), tunnel->index, truncate, true);
	} else if (tunnel->erspan_ver == 2) {
		erspan_build_header_v2(skb, ntohl(tunnel->parms.o_key), tunnel->dir, tunnel->hwid, truncate, true);
	...
}

So if a transmit lands between the t->erspan_ver = erspan_ver store and the
hwid/dir stores, can it emit a version 2 header built from the stale dir and
hwid?  The missing WRITE_ONCE()/READ_ONCE() annotations also leave these
accesses as a KCSAN-reportable data race.

The same ordering existed before the patch, so this is only mentioned in
passing while the code is being touched.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916100155.1398403-1-edumazet%40google.com
