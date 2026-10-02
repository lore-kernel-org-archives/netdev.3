Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613A489FD7;
	Fri,  2 Oct 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937148; cv=none; b=nTu9XLsqS7Zg2CiH1FqA4t+gl66UQyvQP+hYR2tTCwskGdJk2d0g4SWXgBUuJuq4kB5Ji9rAnh2m7ByRVbMVc8L/FZvxmViuEfvb/+5aXWz8oJ2sdYpN/uCrPEEDWYj/uamZes8m6qn+ydbkgqeDIMpBZqT6hjR2yxZYmotwz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937148; c=relaxed/simple;
	bh=A7hOawg/2HJXbgX6MJzbI4YKLUZrQ0Ss1LuVcFAF4EM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzo+ChnzaIdTBpSBW72QJcQf94ox9Yg3gkykZZmSzsdlVInt9w4f3S5URc0JZAJUR09q2/+m8PN5zgym9r5yNJDg434w9YPkB8Ap5jRrvm1vabVEDmzm1PZfJ0R+swGTHoxb6EUStTZk5RQjQgz7Uzvdb6ndStFn02C7Pbr8iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsbVQF3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsbVQF3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D741F000FF;
	Fri,  2 Oct 2026 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937146;
	bh=NRtGcKywOUP/ClAYebMNQ0Aa90j/QQ8anjJUo2lxwF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AsbVQF3s3TkJ8wmUnIUSiy7KTMFc07N6DgmNwaKYcos2CMcP+rEXdEwjbEP2saHea
	 lInxmZ94ymCOFT0jsyItK1fwxfYI6ot9sBUFozosGqnMb9jFPp3BJKCbLcQfhDF01X
	 6/P0XCbLZhDEcmEaw4TxN8K01trF3QjKJEL9/CDLbL72SF/zXhgpi/mgkKw9/V827l
	 Lga8mntQ6Uo6kB1jtMfXo2eeP3QD6CX+ZA8yMPcCLDzfXFiG3ho1qrf9EPMo6/c1DV
	 TzjIH5GLiZXmzu1GlXJNW43okXL7eRzf99ij1DvbCtmQfhqX0t+BSgLDRLHCnJt06c
	 DgmV9melSjhHg==
Subject: Re: [PATCH 09/16 net-next v2] ipv4: fib: split common nexthop logic
 to fib_core.c
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:25 +0000
Message-ID: <179093714514.434549.3500569222267029581@kernel.org>
In-Reply-To: <20260928193046.6698-10-fmancera@suse.de>
References: <20260928193046.6698-10-fmancera@suse.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message undersells the patch.
- [Low] In include/net/ip_fib.h the patch changes the section comment "/*
  Exported by fib_frontend.c */" to "/* Exported by net/core/fib_core.c…
- [Low] fib_core.o is added to the unconditional obj-y list in
  net/core/Makefile (line 15).
- [Low] The patch adds !CONFIG_IPV4 stubs for fib_nh_init(),
  fib_nh_release(), fib_flush(), fib_info_notify_update() and…

--

ipv4: fib: split common nexthop logic to fib_core.c

This patch creates net/core/fib_core.c. It moves shared FIB and nexthop
helpers there from net/ipv4/fib_semantics.c and net/ipv4/fib_frontend.c, so
IPv6 can still use them when the IPv4 routing stack is not built. It also
adds !CONFIG_IPV4 stubs and guards in ip_fib.h, route.h, nexthop.c and
sysctl_net_ipv4.c.

> This patch creates fib_core.c and move all the functions for common
> nexthop initialization and release from fib_semantics.c to fib_core.c.
> Note that fib_core.c is under net/core.

[Severity: Low]
This isn't a bug, but the description covers only part of what the patch
does. Besides the init and release helpers, the patch also:

- moves rtm_ipv4_policy[] and the exported ip_valid_fib_dump_req() out of
  net/ipv4/fib_frontend.c
- moves fib_nexthop_info() and fib_add_nexthop(), which are netlink
  encoders and not init or release code
- adds !CONFIG_IPV4 stubs: fib_nh_init() returns -EAFNOSUPPORT, and
  fib_nh_release(), fib_flush(), fib_info_notify_update() and
  rt_cache_flush() become no-ops
- makes nexthop_is_good_nh() return false for AF_INET, and makes
  nh_netdev_event() skip nexthop_sync_mtu(), when CONFIG_IPV4 is disabled
- makes the net.ipv4.fib_sync_mem sysctl depend on CONFIG_IPV4, although
  a later patch in the series ("ipv4: disable IPv4-only sysctls when
  CONFIG_IPV4=n") exists for exactly that purpose

Once "ipv4: make CONFIG_IPV4 boolean" later in the series makes IPv4
selectable, users will see these changes. Creating an AF_INET nexthop
fails with -EAFNOSUPPORT, IPv4 nexthop MTU sync is skipped, and
/proc/sys/net/ipv4/fib_sync_mem goes away.

Could the commit message describe these extra changes, or could some of
them move into their own patches?

> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 0a35355fb0f33..6058e53fa3dec 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h

[ ... ]

> @@ -442,7 +448,7 @@ static inline bool fib_dscp_masked_match(dscp_t dscp, const struct flowi4 *fl4)
>  	return dscp == (fl4->flowi4_dscp & INET_DSCP_LEGACY_TOS_MASK);
>  }
>  
> -/* Exported by fib_frontend.c */
> +/* Exported by net/core/fib_core.c */
>  extern const struct nla_policy rtm_ipv4_policy[];
>  void ip_fib_init(void);
>  int fib_gw_from_via(struct fib_config *cfg, struct nlattr *nla,

[Severity: Low]
Is this comment accurate? Of the declarations under it, only
rtm_ipv4_policy moved to fib_core.c. The rest are still defined in
net/ipv4/fib_frontend.c, which is only built with CONFIG_IPV4:

    void ip_fib_init(void);
    int fib_gw_from_via(struct fib_config *cfg, struct nlattr *nla, ...);
    __be32 fib_compute_spec_dst(struct sk_buff *skb);
    bool fib_info_nh_uses_dev(struct fib_info *fi, ...);
    int fib_validate_source(struct sk_buff *skb, __be32 src, ...);

fib_unmerge() is in the same position.

The mismatch also goes the other way. fib_nh_common_init() and
fib_nh_common_release() are now defined only in net/core/fib_core.c, but
their declarations are still under the "Exported by fib_semantics.c"
section. The declarations of ip_valid_fib_dump_req(), fib_nexthop_info()
and fib_add_nexthop(), which also moved, have no attribution at all.

This series separates IPv4-only symbols from always-built ones. Could the
new comment suggest that fib_validate_source() or fib_gw_from_via() can be
called from code built with CONFIG_IPV4=n? Such a call would fail to link.

No later patch in the series touches include/net/ip_fib.h, so the comment
is still wrong at the end of the series.

[ ... ]

> @@ -578,10 +584,23 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  void fib_select_path(struct net *net, struct fib_result *res,
>  		     struct flowi4 *fl4, const struct sk_buff *skb);
>  
> +#if IS_ENABLED(CONFIG_IPV4)
>  int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
>  		struct fib_config *cfg, int nh_weight,
>  		struct netlink_ext_ack *extack);
>  void fib_nh_release(struct net *net, struct fib_nh *fib_nh);
> +#else
> +static inline int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
> +			      struct fib_config *cfg, int nh_weight,
> +			      struct netlink_ext_ack *extack)
> +{
> +	return -EAFNOSUPPORT;
> +}
> +
> +static inline void fib_nh_release(struct net *net, struct fib_nh *fib_nh)
> +{
> +}
> +#endif

[Severity: Low]
In net/ipv4/Makefile, nexthop.o is obj-y and fib_semantics.o is
obj-$(CONFIG_IPV4). nexthop.c also calls three other fib_semantics.c
functions that get no stub here: fib_check_nh(),
fib_info_update_nhc_saddr() and fib_nhc_update_mtu().

For nh_create_ipv4(), does a CONFIG_IPV4=n build only link because the
compiler inlines this stub, folds the constant -EAFNOSUPPORT, and drops
the later calls?

net/ipv4/nexthop.c:nh_create_ipv4() {
    ...
	err = fib_nh_init(net, fib_nh, &fib_cfg, 1, extack);
	if (err) {
		fib_nh_release(net, fib_nh);
		goto out;
	}
    ...
	err = fib_check_nh(net, fib_nh, tb_id, 0, extack);
	if (!err) {
		nh->nh_flags = fib_nh->fib_nh_flags;
		fib_info_update_nhc_saddr(net, &fib_nh->nh_common,
    ...
}

The fib_nhc_update_mtu() call in nexthop_sync_mtu() is covered by the
explicit IS_ENABLED(CONFIG_IPV4) check in nh_netdev_event().
fib_check_nh() and fib_info_update_nhc_saddr() have no such guard.

If err here ever stops being a constant, for example because some work is
added before the stubbed call, wouldn't the link fail with undefined
references to these two functions?

There is also a user-facing gap. With IPv4 disabled, an AF_INET nexthop
request passes netlink parsing and then fails inside nh_create_ipv4()
with a bare -EAFNOSUPPORT and no extack message. Could this be rejected
earlier, with an extack message?

No later patch in the series changes nexthop.c or ip_fib.h.

[ ... ]

> diff --git a/net/core/Makefile b/net/core/Makefile
> index c20e520358b8e..315e437a49d8c 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
>  obj-y		     += dev.o dev_api.o dev_addr_lists.o dst.o netevent.o \
>  			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
>  			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
> -			fib_notifier.o xdp.o flow_offload.o gro.o \
> +			fib_notifier.o fib_core.o xdp.o flow_offload.o gro.o \
>  			netdev-genl.o netdev-genl-gen.o netdev_work.o gso.o

[Severity: Low]
net/Makefile builds core/ for every CONFIG_NET kernel, and enters ipv4/
only when CONFIG_INET is set. With fib_core.o in the unconditional obj-y
list, won't CONFIG_NET=y, CONFIG_INET=n kernels now include this code even
though nothing in them calls it? That covers the rtable/fnhe freeing
helpers, fib_nh_common_init() and fib_nh_common_release(),
fib_nexthop_info() and fib_add_nexthop(), the rtm_ipv4_policy table, and
the EXPORT_SYMBOL_GPL'd ip_valid_fib_dump_req().

All users need INET: nexthop.o, net/ipv6/route.c, ipmr/ip6mr and MPLS.

Could fib_core.o go in obj-y in net/ipv4/Makefile instead? Alternatively,
it could be gated on CONFIG_INET here, as this Makefile already does for
bpf_ksock.o with "ifdef CONFIG_INET".

The commit message only says "Note that fib_core.c is under net/core."
and doesn't explain the placement. No later patch in the series changes
net/core/Makefile.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
