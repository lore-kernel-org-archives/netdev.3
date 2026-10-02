Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7347206F;
	Fri,  2 Oct 2026 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937140; cv=none; b=YZxA06Bpm9LxjH0CFhhF6CV2FlLu33MLUrqAca0ixkG7hu9TiTj76ckLRQ1+kk5Ci/0RwEAbO9IUNzYDlKFdcTwDOI47mDndSogqgNE0Py4bHZOCWgetqd7GQWgazCmqEYhgk2hNHLFfEhiU/uu0+xk7WvqUWG5+Tnlzo9/FwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937140; c=relaxed/simple;
	bh=B01yb3T3s4QQl996Nbf/eY50BIc3JNcKBkKbqffDv7o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkdPZwDgLnv2Mei31nI8xRHgZ2p6ha9YLz8mNEgknMJvJj/7/MogDcT/MP19JC24BtvPCT3ZYNgBJEaLNv/CNlQgvAQbiTo95t71V19kyxAYl/4R9XOVZndj5xIFOUQdFGixWj3QYffDJNtu+2Fen+UcXzTFjEromvdMzgTVfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGOBWUFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGOBWUFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1661F000FF;
	Fri,  2 Oct 2026 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937138;
	bh=ucQdkOCI3R6RsaDyTypSg2BRgfeM/iWAeiVPgUQroN8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UGOBWUFJh3fwufX73U/HHOHuMtJrIrJKPbn5DqFbB8Cjt3TFLa/8OJb9geMSAHQeh
	 AUIUnvQp4lJF7qTj1ZwgPEy1WGBQRxZp8y1uCn+Qdz4VPqadGeRlRCPDDKOedQZUrZ
	 DQp/OTDLf0o3Htt7Sr8VYntTUI6dfT7wKQzbEFuaV7R7TxQW4eNOj7O3GViJGTwJIk
	 fYEGQj3skF8AX72oxzXxEJFsayQkB+r1M6MXSXt7GW/ozWrKCEIA2LXLkPKg6TG31L
	 w+f+YaJCpLoXhsH+TpfccFTJXE1OReb2BLTPdH6T4Jm7GR6828FoLJx1rhA6vTg8rI
	 Fba4jECnDTzfQ==
Subject: Re: [PATCH 02/16 net-next v2] net: core: add IPv4 fallback stubs and
 guards for CONFIG_IPV4=n
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:17 +0000
Message-ID: <179093713750.434549.8931208428723634291@kernel.org>
In-Reply-To: <20260928193046.6698-3-fmancera@suse.de>
References: <20260928193046.6698-3-fmancera@suse.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] dev_ifconf() in net/core/dev_ioctl.c now starts with `if
  (!IS_ENABLED(CONFIG_IPV4)) return -EAFNOSUPPORT;`.
- [Low] The CONFIG_IPV4=n stub of ip_finish_skb() in include/net/ip.h
  returns ERR_PTR(-EAFNOSUPPORT).
- [Low] The concern was that this patch moves declarations of
  ip_send_skb, ip_push_pending_frames, ip_generic_getfrag and…
- [Low] The concern was that __inet_check_established() gets a
  CONFIG_IPV4 guard to avoid referencing tcp_twsk_unique() (then in…
- [Low] The new CONFIG_IPV4=n stub of ip_route_output_flow() in
  include/net/route.h is a function definition whose first parameter has…
- [Low] INDIRECT_CALL_INET_1() in include/linux/indirect_call_wrapper.h
  is now gated on CONFIG_IPV4 instead of CONFIG_INET, but none of its…
- [Low] include/net/arp.h still picks the real
  __ipv4_neigh_lookup_noref() body under `#ifdef CONFIG_INET`, not…

--

net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n

This patch adds static inline stubs to include/net/ip.h and
include/net/route.h that return an error when IPv4 is disabled. It also
switches several CONFIG_INET guards in generic networking code to
CONFIG_IPV4, to avoid undefined references when linking without IPv4.

> diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
> index 0e4340ecd857..583efbc03446 100644
> --- a/include/linux/indirect_call_wrapper.h
> +++ b/include/linux/indirect_call_wrapper.h
> @@ -57,16 +57,18 @@

[ ... ]

> -#if IS_ENABLED(CONFIG_INET)
> +#if IS_ENABLED(CONFIG_IPV4)
>  #define INDIRECT_CALL_INET_1(f, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
>  #else
>  #define INDIRECT_CALL_INET_1(f, f1, ...) f(__VA_ARGS__)

[Severity: Low]
Is CONFIG_IPV4 the right gate for INDIRECT_CALL_INET_1()? Its four users
all name TCP helpers that tcp_prot and tcpv6_prot share:

    tcp_stream_memory_free in __sk_stream_memory_free()
    tcp_leave_memory_pressure in net/core/sock.c
    tcp_release_cb in release_sock()
    tcp_bpf_bypass_getsockopt in include/linux/bpf-cgroup.h

These live in net/ipv4/tcp.c and net/ipv4/tcp_output.c. Both are obj-y
and are built whenever CONFIG_INET=y.

On an INET=y, IPV4=n kernel, callbacks such as release_sock()->release_cb
would lose the direct call and go through a retpoline. Would keeping
CONFIG_INET here avoid that?

> diff --git a/include/net/ip.h b/include/net/ip.h
> index 6f602df72ee6..194a464c443a 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h

[ ... ]

> @@ -225,27 +235,58 @@ int ip_append_data(struct sock *sk, struct flowi4 *fl4,

[ ... ]

> +static inline struct sk_buff *ip_finish_skb(struct sock *sk, struct flowi4 *fl4)
> +{
> +	return ERR_PTR(-EAFNOSUPPORT);
> +}

[Severity: Low]
Should this stub return NULL instead of an ERR_PTR?

The real ip_finish_skb() wraps __ip_make_skb(), which returns either NULL
or a valid skb. Callers such as udp_push_pending_frames() only check for
NULL:

    skb = ip_finish_skb(sk, fl4);
    if (!skb)
        goto out;

A future caller that reached this stub would go on to dereference the
ERR_PTR in udp_send_skb() or ip_send_skb().

No current caller can reach it. At this patch the #else branch is only
compiled for INET=n. By the end of the series the callers are all in
obj-$(CONFIG_IPV4) files, and udp_v6_push_pending_frames() guards its call
with IS_ENABLED(CONFIG_IPV4).

> +
> +static inline void ip_flush_pending_frames(struct sock *sk)
> +{
> +}
> +#endif
> +
> +int ip_generic_getfrag(void *from, char *to, int offset, int len, int odd,
> +		       struct sk_buff *skb);
> +int ip_send_skb(struct net *net, struct sk_buff *skb);
> +int ip_push_pending_frames(struct sock *sk, struct flowi4 *fl4);
> +int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl);

[Severity: Low]
Are these meant to be left outside the CONFIG_IPV4 block without stubs?
The __cookie_v4_* references in net/core/filter.c are also left
unguarded. On their own, these would stop an IPV4=n kernel from linking.

Later patches in the series seem to handle all of them:

  - "net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic"
    moves ip_generic_getfrag() into net/ipv4/af_inet.c.

  - The raw/udp/icmp/ping split patches move the ip_send_skb() and
    ip_push_pending_frames() callers into obj-$(CONFIG_IPV4) *_ipv4.c
    files.

  - ip_queue_xmit is only referenced through INDIRECT_CALL_INET, which
    drops f1 when IPV4=n. The ipv6_mapped use in tcp_ipv6.c is only
    reachable from IS_ENABLED(CONFIG_IPV4) code.

  - The __cookie_v4_* calls sit under CONFIG_SYN_COOKIES, which depends
    on IPV4.

So only the intermediate state of the series is affected, not the end
state.

[ ... ]

> diff --git a/include/net/route.h b/include/net/route.h
> index 6b55de2e4df8..8c21881eb5f4 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -169,8 +169,16 @@ static inline struct rtable *__ip_route_output_key(struct net *net,
>  	return ip_route_output_key_hash(net, flp, NULL);
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV4)
>  struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
>  				    const struct sock *sk);
> +#else
> +static inline struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
> +						  const struct sock *sk)
> +{
> +	return ERR_PTR(-EAFNOSUPPORT);
> +}
> +#endif

[Severity: Low]
The first parameter of this definition has no name. Before C23, parameter
names may only be omitted in prototypes. Under -std=gnu11, GCC 8 through
10 reject this with "parameter name omitted", and scripts/min-tool-version.sh
lists 8.1 as the minimum GCC.

CONFIG_IPV4 is undefined on existing CONFIG_NET=y, CONFIG_INET=n kernels.
That means this #else branch is compiled today wherever route.h is
included, including the always-built net/core/rtnetlink.c.

Does this break those builds with older GCC? Naming the parameter
(struct net *net) would avoid that.

> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 164643140a52..a10921aa3e23 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -44,6 +44,9 @@ int dev_ifconf(struct net *net, struct ifconf __user *uifc)
>  	size_t size;
>  	int len, total = 0, done;
>  
> +	if (!IS_ENABLED(CONFIG_IPV4))
> +		return -EAFNOSUPPORT;
> +

[Severity: Medium]
Does this change how SIOCGIFCONF behaves on existing CONFIG_INET=n
kernels? CONFIG_IPV4 is only defined inside "if INET" in net/Kconfig, so
IS_ENABLED(CONFIG_IPV4) is 0 whenever INET=n.

sock_ioctl() passes SIOCGIFCONF to dev_ifconf() for sockets of every
family:

    case SIOCGIFCONF:
        err = dev_ifconf(net, argp);

Before this patch, the !CONFIG_INET inet_gifconf() stub in
include/linux/inetdevice.h returned 0, so the ioctl succeeded with
ifc_len set to 0. It now fails with EAFNOSUPPORT. That also applies to
AF_UNIX, AF_PACKET and other non-INET sockets, from unprivileged
userspace.

The inline stub already existed, so there was no link error to avoid.
Would changing the inet_gifconf() stub's guard from CONFIG_INET to
CONFIG_IPV4 keep the empty-list result for the IPV4=n case as well?

The commit message also doesn't mention this user-visible change.

[ ... ]

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 6ed8eb075146..63c2a1b86118 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3241,6 +3241,10 @@ int neigh_xmit(int index, struct net_device *dev,
>  		if (index == NEIGH_ARP_TABLE) {
>  			u32 key = *((u32 *)addr);
>  
> +			if (!IS_ENABLED(CONFIG_IPV4)) {
> +				rcu_read_unlock();
> +				goto out_kfree_skb;
> +			}
>  			neigh = __ipv4_neigh_lookup_noref(dev, key);

[Severity: Low]
Is this guard needed? When ARP isn't registered, tbl is NULL and the
earlier "if (!tbl)" check in neigh_xmit() already bails out.

The underlying inconsistency seems to be in include/net/arp.h. The real
__ipv4_neigh_lookup_noref() is still selected by CONFIG_INET:

    #ifdef CONFIG_INET
    static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_device *dev, u32 key)
    {
        struct neigh_table *tbl = arp_table(dev_net(dev));

With INET=y and IPV4=n, arp_table() returns the NULL
neigh_tables[NEIGH_ARP_TABLE], and the lookup would dereference it.

This isn't reachable today. By the end of the series, every INET-common
caller (filter.c, neigh_xmit(), nexthop_is_good_nh()) is guarded, and
the vrf and rocker drivers depend on IPV4.

Should the arp.h gate be CONFIG_IPV4, so that callers don't each need
their own guard?

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 5abcb0debb27..ae9f45368571 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -596,6 +596,9 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
>  	struct sock *sk2;
>  	spinlock_t *lock;
>  
> +	if (!IS_ENABLED(CONFIG_IPV4))
> +		return -EAFNOSUPPORT;
> +

[Severity: Low]
This guard removes the tcp_twsk_unique() reference from
__inet_check_established(). The IPv6 version, __inet6_check_established()
in net/ipv6/inet6_hashtables.c, keeps the same call:

    if (tcp_twsk_unique(sk, sk2, twp))

At this point tcp_twsk_unique() lives in tcp_ipv4.c, which is
obj-$(CONFIG_IPV4). Wouldn't an IPV6=y, IPV4=n build still fail to link?

Later in the series, "tcp: move protocol agnostic TCP functions out of
tcp_ipv4.c" moves tcp_twsk_unique() into net/ipv4/tcp.c, so this is fixed
by the end of the series.

Also, this isn't a bug, but the "net: core:" subject prefix doesn't cover
this change to net/ipv4/inet_hashtables.c.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
