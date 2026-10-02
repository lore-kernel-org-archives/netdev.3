Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30C4825A9;
	Fri,  2 Oct 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937141; cv=none; b=MuqGP+waiMUWUHrVp7Oy9ApUDSmYq2nPC3UWts3VuNgSZ6QP3TmBADLbbZ/PeTCeYmXrCPMu+jjkQNzgBcSvUN7MU3nBG9V96f9+9RmgZbq+hHdpeYdXu7BgLMiDGp/rNesRbpcVGOtjMIHWJZYsy/dIxihfV516sbTTMMkQ0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937141; c=relaxed/simple;
	bh=TGdeOoyTyhUp19unOddZ7CrZD+IxviqYHCvt3g2rOGQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lxsUcUW9asNYLeHQ7T49KPISEJtWE7RKk/HDKQiY3m9FNwNN/HQV9zzzTU4AuovWoYu4XDedyXZCwca3lUsuvr22+T2Cjpg2CXJ9rjJHlCnPk6fJRuEnWqZ/XgvNnmS+gPIFyAn7nlaAi+fVhIOXSG1HsjM2zoYNpzZcpg1zgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4Ff/i+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4Ff/i+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CB61F00898;
	Fri,  2 Oct 2026 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937139;
	bh=o4kULma5WucJj4PzheQSf+wOS8uW/XjLbDhXUjeBCDs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g4Ff/i+VY4/RfrmXjz+qTbGcm/j3gedGK9c8YdiiV0w+j67EoNLZD99CVq5/wDG0k
	 zHR6fxJcGVdmQ2YfXXRFES62HzanmP4p6LVpC3CQDx9PCtVWT5CLmfBAkpk0Mtw4E1
	 PUf0aGcNSHf+76gmxEGcoNP/Iwxm6OhDnBJTJRhcr5JJQ51/9sGsGEqCr5R7fpnxMG
	 HeOneSxMQ6++9vuYN0oXzEOB3m/wlOC9fRMOn1WV9XGyddVKC2iiz6mwxkzAfkipJZ
	 9BMTKVsjbTLBKXHpnkKQM968kmV9TTMNvN5NOOsSUEWZVeTdgwpv9/yj5XbN4VzDGK
	 3zW7I5OIjtfKg==
Subject: Re: [PATCH 03/16 net-next v2] net: inet: relocate ip_generic_getfrag
 and guard IPv4 socket logic
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:18 +0000
Message-ID: <179093713877.434549.5877101930421918126@kernel.org>
In-Reply-To: <20260928193046.6698-4-fmancera@suse.de>
References: <20260928193046.6698-4-fmancera@suse.de>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Remote NULL-pointer dereference when IPv4 is disabled.
- [Medium] The IPv4 offload ops table is left half-disabled when IPv4 is
  off.
- [Medium] With IPv4 disabled, inet_ioctl() returns -EOPNOTSUPP for every
  command before its switch (net/ipv4/af_inet.c:997-998).
- [Low] The commit message is incomplete and has a typo.
- [Low] (Baseline decision: false — fixed later in the series.) The
  commit message says the same guard rejects IPv4-mapped IPv6, but the…

--

net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic

This patch moves ip_generic_getfrag() from ip_output.c to af_inet.c so it
is available without IPv4. It adds CONFIG_IPV4 guards in af_inet.c around
the ioctl, bind, protocol registration, GSO and init paths. It also
rejects IPv4 and v4-mapped addresses in the IPv6 bind and datagram
connect paths.

> This patch moves the generic ip_generec_getfrag() from ip_output.c to
> af_inet.c. It also introduces CONFIG_IPV4 guards around af_inet.c to
> reject IPv4-specific ioctls, protocol registrations and bind requests.

[Severity: Low]
This isn't a bug, but there's a typo: ip_generec_getfrag() should be
ip_generic_getfrag().

The description also leaves out some behavioural changes in the diff:

  - inet_init() now calls init_inet_pernet_ops() before ip_mr_init().
    This changes the pernet init order even with CONFIG_IPV4=y.
  - inet_gso_segment() is disabled when CONFIG_IPV4 is off. That is a
    packet path change, not socket logic.
  - inet_release() skips ip_mc_drop_socket().
  - inet_sk_reselect_saddr() returns early.

Could the commit message mention these as well?

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index d9421ac38d78c..cf00386933d67 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c

[ ... ]

> @@ -968,6 +994,9 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  	struct ifreq ifr;
>  	struct rtentry rt;
>
> +	if (!IS_ENABLED(CONFIG_IPV4))
> +		return -EOPNOTSUPP;
> +
>  	switch (cmd) {
>  	case SIOCADDRT:
>  	case SIOCDELRT:

[Severity: Medium]
Does this break SIOCSIFFLAGS on AF_PACKET sockets when CONFIG_IPV4 is
disabled?

Under CONFIG_INET, packet_ioctl() still forwards SIOCSIFFLAGS and the
IPv4 address ioctls to inet_dgram_ops.ioctl:

net/packet/af_packet.c:packet_ioctl() {
    ...
	case SIOCSIFFLAGS:
		return inet_dgram_ops.ioctl(sock, cmd, arg);
#endif
    ...
}

sock_do_ioctl() only falls back to dev_ioctl() when ops->ioctl returns
-ENOIOCTLCMD:

net/socket.c:sock_do_ioctl() {
    ...
	err = ops->ioctl(sock, cmd, arg);
    ...
	if (err != -ENOIOCTLCMD)
		return err;
    ...
}

With IPV4=n, sock_do_ioctl()->packet_ioctl()->inet_ioctl() returns
-EOPNOTSUPP. As a result, the call never reaches the
dev_ioctl()->dev_ifsioc() path. That path handles SIOCSIFFLAGS through
dev_change_flags() and does nothing IPv4-specific. With IPV4=y the same
ioctl worked through devinet_ioctl()->dev_change_flags().

Would returning -ENOIOCTLCMD here, at least for commands that aren't
IPv4-specific, keep the generic fallback? This code is unchanged at the
end of the series.

[ ... ]

> @@ -1371,6 +1408,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>  	int ihl;
>  	int id;
>
> +	if (!IS_ENABLED(CONFIG_IPV4))
> +		return ERR_PTR(-EPROTONOSUPPORT);
> +
>  	skb_reset_network_header(skb);
>  	nhoff = skb_network_header(skb) - skb_mac_header(skb);
>  	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))

[Severity: Medium]
Does this leave the IPv4 offload half disabled?

ipv4_offload_init() has no guard. It still registers the TCPv4, UDPv4
and IPIP offloads, and it registers the IPv4 packet offload with the GRO
callbacks:

	net_hotdata.ip_packet_offload = (struct packet_offload) {
		.type = cpu_to_be16(ETH_P_IP),
		.callbacks = {
			.gso_segment = inet_gso_segment,
			.gro_receive = inet_gro_receive,
			.gro_complete = inet_gro_complete,
		},
	};

Consider an IPV4=n kernel that forwards IPv4 frames at L2 (bridge, OVS,
tc redirect). GRO can still merge IPv4 TCP segments into SKB_GSO_TCPV4
packets.

If the egress device lacks TSO, the chain is:

validate_xmit_skb()
  skb_gso_segment()
    inet_gso_segment()
      return ERR_PTR(-EPROTONOSUPPORT)

The whole aggregate is then freed through out_kfree_skb.
ip4ip6_gso_segment() in net/ipv6/ip6_offload.c also calls
inet_gso_segment() and would fail the same way.

The guard appears to be needed only because inet_gso_segment() calls
ip_send_check(), which is in the IPv4-only ip_output.c.

Could ip_send_check() move to generic code, the same way this patch moves
ip_generic_getfrag()? Or could the IPv4 GRO callbacks stay unregistered
when IPv4 is disabled? This code is unchanged at the end of the series.

[ ... ]

> @@ -1870,20 +1912,25 @@ static int __init ipv4_offload_init(void)

[ ... ]

>  static int __init inet_init(void)
>  {
> +#if IS_ENABLED(CONFIG_IPV4)
>  	struct inet_protosw *q;
>  	struct list_head *r;
>  	int rc;
> +#endif
>
>  	sock_skb_cb_check_size(sizeof(struct inet_skb_parm));
>
> +#if IS_ENABLED(CONFIG_IPV4)
>  	raw_hashinfo_init(&raw_v4_hashinfo);
>
>  	rc = proto_register(&tcp_prot, 1);
> @@ -1958,7 +2005,7 @@ static int __init inet_init(void)
>  	 */
>
>  	ip_init();
> -
> +#endif /* CONFIG_IPV4 */

[Severity: Critical]
Does this leave peer_cachep NULL on IPV4=n kernels?

ip_init() is the only caller of inet_initpeers(), and inet_initpeers()
is the only place that sets peer_cachep:

net/ipv4/inetpeer.c:inet_initpeers() {
    ...
	peer_cachep = KMEM_CACHE(inet_peer, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
}

inetpeer.o is still built for every INET kernel. IPv6 still uses it
through inet_getpeer_v6(), called from icmpv6_xrlim_allow(),
ndisc_send_redirect() and ip6_forward().

On a lookup miss, inet_getpeer() does:

	p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);

kmem_cache_alloc_noprof() then dereferences s->object_size on the NULL
cache.

A remote host could trigger this on an IPv6-only kernel by sending a
UDPv6 datagram to a closed port:

__udp6_lib_rcv()
  icmpv6_send(ICMPV6_DEST_UNREACH)
    icmp6_send()
      icmpv6_xrlim_allow()
        inet_getpeer_v6(net->ipv6.peers, &fl6->daddr)
          inet_getpeer()
            kmem_cache_alloc(NULL, GFP_ATOMIC)

DEST_UNREACH is in the default icmpv6_ratemask, so any non-loopback
destination goes through the peer lookup.

At this commit CONFIG_IPV4 is still a hidden def_bool y, so the problem
is latent. However, ip_init() is still inside inet4_init() at the end of
the series, and 'ipv4: make CONFIG_IPV4 boolean' makes IPV4=n
selectable.

Should inet_initpeers() be called outside the IPv4-only block?

[ ... ]

> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index f0efdc13baf4e..f220eaab085b1 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -302,6 +302,11 @@ int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
>  		struct net_device *dev = NULL;
>  		int chk_addr_ret;
>
> +		if (!IS_ENABLED(CONFIG_IPV4)) {
> +			err = -EADDRNOTAVAIL;
> +			goto out;
> +		}
> +

[Severity: Low]
The commit message says "The same guard is added to reject IPv4-mapped
IPv6". However, the guard is only added to __inet6_bind() and
__ip6_datagram_connect().

At this commit, tcp_v6_connect(), udpv6_sendmsg() and SOL_IP setsockopt
on IPv6 sockets still dispatch to IPv4 code.

There is no intermediate regression, because CONFIG_IPV4 is still a
hidden def_bool y here. Later patches in the series add the missing
guards:

  - tcp_v6_connect(): 'tcp: move protocol agnostic TCP functions out of
    tcp_ipv4.c'
  - udpv6_sendmsg(): 'ipv4: udp: split IPv4 specific logic into
    udp_ipv4.c'
  - ip_setsockopt() and ip_getsockopt(): -EAFNOSUPPORT stubs in
    include/net/ip.h

Could the commit message say more precisely which paths this patch
covers?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
