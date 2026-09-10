Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED239B975
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789012658; cv=none; b=oh6R3h567Y5MoVjUH5/fdT1vuHKl1+role6frC862X4KQdEkvMznasXYVfMl9bcSZ+Ueb+ZSrPsMgWCpIoMYKgjjmG8mhaBjp4RzbjGnQNZIE4XQJ1ZUa9asgQoJA91Dz3ry3uqEt63hQhlPeBAv+4wJQXfoFNZP14X1ye2YxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789012658; c=relaxed/simple;
	bh=wSdSR2Mg7hW00MwGgdnLx3InVb9tXDrvCl0KL35fLxo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YArLlRDkMuTAMKB+Fad+oMZrLzE5/W6NuSc4FdMS5OFnEHNl1g1+yOd8gKyD10ZJulI+cSBcxz+NkDM7pCiRuYcn0+C6uCP5YO7PsNKHEc2VUn41teDJyyFXP4tPDyGoa2w4s+gdrk5Jg1V6eTfkm3uc3roFkTftw7I6Cf4jYFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxJmhC3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxJmhC3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3978D1F000FF;
	Thu, 10 Sep 2026 03:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789012655;
	bh=xG97mLzTySvCAI+VwF54aWlHY7AVvjlfoQWCdTSHB+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SxJmhC3otgSwNYKwH3iRa3t0aeolJRQZW7jaWWGJTDSIgOj4om7KUjvu+P1PWnzl8
	 iGKSebQ0LSbjIHzBOJnUNOcHnXmng0/J6c0dylfQKq2Kt4gvVcLHP8Tq9FrOeAEF2S
	 sJV/bDJQfeQG6e6BKJHNF+jiuDRcy2PO2P+Gi654wLC5clL6PGsQOXXUT3e7Q7gz/u
	 Mtqaa4drz/uio33w9FO9iAKcnqJZptY+mgrGWWOPmTHSC2IZ/EaPJC4jM3TD/kwQSa
	 p6p1QRdqLeUFqmh7dJtS+jUYE+FOW8RIbIJwEaVFUkOfPc72npEs/IuOEiZoSjKG1A
	 207ijbobbdRCQ==
Subject:
 Re: [PATCH net-next v2] selftests: net: add IPv4 and IPv6 address order check
From: netdev-bot+sashiko@kernel.org
To: martin.jaburek@suse.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, fmancera@suse.de
Date: Thu, 10 Sep 2026 03:57:34 +0000
Message-ID: <178901265476.219967.5757059303283570394@kernel.org>
In-Reply-To: <20260907125722.9473-1-martin.jaburek@suse.com>
References: <20260907125722.9473-1-martin.jaburek@suse.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] `ipv6_verify_inter_scope_addr_order()`
  (tools/testing/selftests/net/rtnetlink.py:407) provides zero coverage…
- [Medium] In `ipv4_verify_inter_scope_addr_order()`
  (tools/testing/selftests/net/rtnetlink.py:348) the inline comment '#…
- [Low] The new helpers `_insert_and_get_addrs_ipv4()`
  (tools/testing/selftests/net/rtnetlink.py:317, socket created at line…

--

selftests: net: add IPv4 and IPv6 address order check

Adds four new cases to tools/testing/selftests/net/rtnetlink.py that insert
a set of IPv4 and IPv6 addresses into a fresh netns and compare the dumped
order against the insertion order. The intent is to lock down the existing
(and deliberately different) per-protocol ordering behaviour, including the
inter-scope case, so future unification attempts do not silently regress
user space.

Link: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
Link: https://lore.kernel.org/netdev/20260529112357.5079-1-fmancera@suse.de/
Link: https://lore.kernel.org/netdev/20260721090114.GA2510713@shredder/

> diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
> index 5cc3ebdcf08de..5605be411f1a8 100755
> --- a/tools/testing/selftests/net/rtnetlink.py
> +++ b/tools/testing/selftests/net/rtnetlink.py
> @@ -314,11 +314,124 @@ def ipv6_route_del_reason_absent() -> None:
>                          "user deletion must not carry del-reason")
>  
>  
> +def _insert_and_get_addrs_ipv4(test_addrs: list[str], scopes: list[str]) -> list[str]:
> +    with NetNS() as ns, NetNSEnter(str(ns)):
> +        dev_name = "dummy_dev"
> +
> +        ip(f"link add name {dev_name} type dummy", ns=str(ns))
> +        for test_addr, scope in zip(test_addrs, scopes):
> +            ip(f"address add {test_addr}/24 dev {dev_name} scope {scope}", ns=str(ns))
> +        ip(f"link set dev {dev_name} up", ns=str(ns))
> +
> +        rtnl = RtnlAddrFamily()
> +        addrs = rtnl.getaddr({"ifa-family": socket.AF_INET}, dump=True)
> +        return [addr["address"] for addr in addrs]

[Severity: Low]
This isn't a bug, but is the netlink socket created here (and the identical
one in _insert_and_get_addrs_ipv6()) ever closed?  There is no
with RtnlAddrFamily() as rtnl: and no defer(rtnl.close), unlike the
existing pattern in this same file:

tools/testing/selftests/net/rtnetlink.py:_rtnl_route_subscribe() {
    ...
    rtnl = RtnlFamily()
    defer(rtnl.close)
    ...
}

YnlFamily offers close() plus __enter__/__exit__ but no __del__, and its
__init__ installs functools.partial bound methods on self, creating a
reference cycle:

tools/net/ynl/pyynl/lib/ynl.py:YnlFamily.__init__() {
    ...
    bound_f = functools.partial(self._op, op_name)
    setattr(self, op.ident_name, bound_f)
    ...
}

so plain refcounting cannot reclaim it when the helper returns.  Does that
leave the fd bound to a namespace that NetNSEnter.__exit__() and
NetNS.__exit__() (ip netns del) have already torn down, until the cyclic
collector runs?  Would mirroring the defer(rtnl.close) used by
_rtnl_route_subscribe() be preferable here?

[ ... ]

> +def ipv4_verify_inter_scope_addr_order() -> None:
> +    """
> +    Checks the ordering of inter-scope addresses. This has also
> +    been attempted to be patched, bringing in a new risk of a user-space
> +    regression, similar to the same scope equivalent. This will further
> +    consolidate the implementation differences of both protocols.
> +    """
> +
> +    test_addresses = [
> +        "192.0.2.1", "203.0.113.1",
> +        "192.0.2.2", "203.0.113.2", "192.0.2.3"
> +    ]
> +    # IPv4 puts link local addresses before global ones.
> +    scopes = [
> +        "link", "global",
> +        "link", "global", "link"
> +    ]
> +
> +    address_list = _insert_and_get_addrs_ipv4(test_addresses, scopes)
> +    ksft_eq(test_addresses, address_list, "Unexpected IPv4 address order across scopes")

[Severity: Medium]
Does the comment "IPv4 puts link local addresses before global ones." match
the list this test actually asserts?  The expected order is
192.0.2.1(link), 203.0.113.1(global), 192.0.2.2(link), 203.0.113.2(global),
192.0.2.3(link), which places link-scope addresses after a global one.

That happens because only primary addresses take part in the scope sort:

net/ipv4/devinet.c:__inet_insert_ifa() {
    ...
        if (!(ifa1->ifa_flags & IFA_F_SECONDARY) &&
            ifa->ifa_scope <= ifa1->ifa_scope)
            last_primary = &ifa1->ifa_next;
    ...
    if (!(ifa->ifa_flags & IFA_F_SECONDARY))
        ifap = last_primary;
    ...
}

192.0.2.2, 192.0.2.3 and 203.0.113.2 share a prefix with an earlier address,
so they get IFA_F_SECONDARY and are appended at the tail regardless of
scope.

Also, since the only link-scope primary (192.0.2.1) is the first address
inserted, doesn't the assertion reduce to "output == insertion order", i.e.
the same invariant ipv4_verify_same_scope_addr_order() already checks?  A
kernel that dropped the ifa_scope sort and simply appended all primaries
would still pass.  Would inserting a global primary first and a link-scope
primary of a different subnet afterwards, then expecting the link-scope one
to appear ahead of the global one, pin down the documented property?

[ ... ]

> +def _insert_and_get_addrs_ipv6(test_addrs: list[str], scopes: list[str]) -> list[str]:
> +    with NetNS() as ns, NetNSEnter(str(ns)):
> +        dev_name = "dummy_dev"
> +
> +        ip(f"link add name {dev_name} type dummy", ns=str(ns))
> +        for test_addr, scope in zip(test_addrs, scopes):
> +            ip(f"address add {test_addr}/64 dev {dev_name} scope {scope}", ns=str(ns))

[Severity: High]
Does the scope argument have any effect on the IPv6 path?
inet6_rtm_newaddr()/inet6_addr_add() never read ifm->ifa_scope, and the
scope is recomputed from the address itself:

net/ipv6/addrconf.c:inet6_addr_add() {
    ...
    cfg->scope = ipv6_addr_scope(cfg->pfx);
    ...
}

A nonzero ifa_scope is only rejected for dump/get requests, so
"ip address add ... scope link" succeeds silently while the requested scope
is discarded.  Does that make the scopes parameter of this helper dead
input?

[ ... ]

> +def ipv6_verify_inter_scope_addr_order() -> None:
> +    """
> +    To prevent potential user-space regressions with IPv6
> +    addresses, the inter-scope insertion order is also being tested.
> +
> +    This again differs from IPv4, here global scope addresses have priority
> +    against link local ones - the behaviours are opposite.
> +    """
> +    test_addresses = [
> +        "2001:db8:a::1", "2001:db8:b::1",
> +        "2001:db8:a::2", "2001:db8:b::2", "2001:db8:a::3"
> +    ]
> +    scopes = [
> +        "global", "link",
> +        "global", "link", "global"
> +    ]
> +
> +    address_list = _insert_and_get_addrs_ipv6(test_addresses, scopes)
> +    ksft_eq(test_addresses[::-1], address_list[:5], "Unexpected IPv6 address order across scopes")

[Severity: High]
Following on from the helper above, does this test exercise any inter-scope
ordering at all?  All five addresses are 2001:db8::/32, i.e. inside
2000::/3, so each of them maps to IPV6_ADDR_SCOPE_GLOBAL, and the ordering
is decided from the address bits rather than from ifa->scope:

net/ipv6/addrconf.c:ipv6_link_dev_addr() {
    int ifp_scope = ipv6_addr_src_scope(&ifp->addr);
    ...
        if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
            break;
    ...
}

With all scopes equal the loop breaks on the first entry and every new
address is inserted at the head, giving pure reverse insertion order.  The
inputs and the expected value here are then identical to
ipv6_verify_same_scope_addr_order() - same test_addresses, same
test_addresses[::-1] compared against address_list[:5].

If the scope comparison in ipv6_link_dev_addr() were removed, or inverted to
IPv4's link-before-global ordering, would this test still pass?  The
position of a real fe80::/10 address relative to the globals is never
asserted, since the default link-local is sliced off by [:5].

Would using actual link-local addresses (fe80::...) for the "link" entries
and expecting globals in reverse insertion order followed by link-locals in
reverse insertion order - a different list than test_addresses[::-1] - cover
the behaviour the docstring describes?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907125722.9473-1-martin.jaburek%40suse.com
