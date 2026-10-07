Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21D3D9540
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398534; cv=pass; b=YcTUkDsAbBIRI8khZenB3vgDXzlN1cDRwSWjZR7c5OtyYFfMkZ30toH/8X/Q802q7ro6wAGDPOPw5nm2N7tToXMh4f7Wzau6A+mQDdrMB38gV328M0QBoa4YwUCVMdYRU0OduHGCHRNlA3Zgr6Asw7LNOhWYd239kclUa5ivWkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398534; c=relaxed/simple;
	bh=xoNPOXAYCmo9NEF9nKgtfLLIDyxsAiCZOxjU7IUScDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WulYeizJyKjrXYmJxTprIi7iq2B+QBsGu/lmSmGqXLEzWoQiswN/3p3Yu25GsgNoeP0LmlU0j+wNoKde7le88Q+q8lXXz1s8LkvY3/LVrVYd0f/bi705H4aq6Ejw/Yhxe/npq9hJt4pr41j7XswoQmpJB39STUplheWUhXDl+Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUdKtPGC; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUdKtPGC"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-86aecf49833so1418330b3a.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791398531; cv=none;
        d=google.com; s=arc-20260327;
        b=OMzOi+ZoPBcdUS1dPZz0iBgcx6PhuHWCIaem2KzJboXCaseQiWs8cGMPV09quKpO3N
         8t17LJ58Jac8s7yCAUWm/TDpScj8uFPiv4sbsM/Pe3+bc0qRnHSSOGmiDYLgENkLWvxQ
         MtYdgpqIkX6qei/uF1oBp/2e7PGzQHRoMCNuoFUqEAWWh1744kuJ+yx5DJ7eoM9cDSFQ
         PNjhOWfgL1qfve90FptIBAorTuqCuZwn9qPjP8Fok7+gDqbxnaR+ggb2bfD9cM1A0Opv
         HnIJBIB+T27EYDfUm6bDDEHVTOmeUzNty5iiAhiG5yAuPHjUVNtmKxTrsM/ZDS0RhzBd
         1mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVY/k/l22EduN0afxcG6neeIyEhDBFiNHHXvyZBQ71g=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=pUE1rzQgqnam2xRtzwTphDoRfAQEBh5nj/8TsKQt4HU8sFuHIHjdXFDw7T9z4Cb8C5
         qeoWWc8GWkbZkGxNywI/DIy0fyNVqWLxqQG8K0yQbAIeDRPHActXhx3ioCPdd2o6z4dS
         mtAF/8z86H1Jofyk4rk9sz/tNBTdmPotuReTzCk4OBJ6ojWjAjp7Upc4MFQp7oUJl3IU
         Sje4qExhyvEvwlBGiSGNewBOrSTqSmu9INyKn80U+6tDQlfks+rCjvXt4rHn8WvREKd+
         8FeLuah5Ge76uaviCem8CnYi7lCg0D5osQES8Roure7RaKogtbUHL4K4HqMmzofcHmVz
         KCng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791398531; x=1792003331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVY/k/l22EduN0afxcG6neeIyEhDBFiNHHXvyZBQ71g=;
        b=aUdKtPGCgAu0k8jFQHBmt6mK2Me6kweJphBtG988bTT18dpwRbfNEbg68WEvHeIIaW
         ZSk0UlRqVEwFZk6XDNkoqDbsA8u/CrX73AzP2E8IUS8fjxLLOWXW1vM5mimaDDLD7tDD
         lkR9UBoUFIidPdD2OKzcUWEtn6iH/Rk1CwfxzZMuPwc0Z/NrW43PXpDd5Xbw154XXxu4
         J31AMTBOmaftNG+B29PY0DYXtocXBC1QvYIU8leWS5xTpJI2fNw/KKPPR2PyuNq5j2I+
         jjvC4lm3P5LdNiqFngz4xaoWtFpFr+Quj9tpCZtGmJmv+A6rrzaCyNwzt0h3Bwm4m0vC
         RNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791398531; x=1792003331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVY/k/l22EduN0afxcG6neeIyEhDBFiNHHXvyZBQ71g=;
        b=qNeS64UDY/42ladrnX6jQKWzxJs2yWvlV5oW6Qg3U3QWPKtHSAhbc15C1jS+vAecDI
         fQBNiIOx6AgDPrJ/HFLHuiOpd2QdTGHHw8wRMeGhiVdw3JodmVK9GULGVm6X5BUED9Y2
         nCGokIV9Rkc5S19OBiWPYhAdvImdga/7oe5hYD829TYGhKnB0ll1Do1ZEZrCdaLguZMm
         am/y9XAxTog7Z8u7nkVx3AQrHN1lCsgwhTJafiK0d3mNko7UsoNzRZfcYbjVYyQYitDk
         djrN+9eH5uHVDyY2PxfMGKDPu+ydmsMfeDjODg6BmH34Kg7B3h/UIfVl93PlEor6+k6Z
         B3UA==
X-Gm-Message-State: AFuF++mBYt3N4VndmY4LuO6GaWWO4iyQeMtWnUZMcBS/5xaDsNpXYKZv
	Bq9bOVsHYDxVa+flSCT6BrAOADf+9LkHgwU8HqlmfNPmPM9p7xoCLi4ojn+URAUCTyFK1ZwwOrv
	iuySwo/Ek8yWTp7vm7EPKphD84F2NLjE=
X-Gm-Gg: AYBFou0GmWVZ3P0YRnIf3EY5qe+HbVtc5oUG3TvMLvZiqv0DC8mvdfgPs1UizJN/tn8
	Wckvq74HfRT2IukPfzIZP7asVk2isd3WkjxEc51kA0KG78PI7h/h4doHaDVmQsXZyCNnU728XGn
	B//08UKtL4+kTQeS/Tq2hlLVE2lkgRJFNyz5qcLWCjslLmojQDme61plr/twlJqQNx1YYXPOvpg
	haqTjxbnULAiow7QJo/KVXN9FPBFgjg4Gco9R/SBm8iSvsDb4UBtb+4ubySA1GyvHSI5FB8/rER
	4twsUJXQwrQAkBC3KOk2qkoDXL9GSzT5MAWW/rEu6qz4/yT3m7quB9B8ddG0T6hC/FpJ159ZSA3
	2OByIqCr8oQkEOOwU9uxYtUcKYFNOhYdzu2T64EkOfHnAgyCO50xwGyX2HrQmCaibRK9lD4Gci9
	ZkuEA2f/a9iiNl
X-Received: by 2002:a05:6a00:4c96:b0:883:7868:94d7 with SMTP id
 d2e1a72fcca58-89309b14625mr28772b3a.10.1791398531420; Wed, 07 Oct 2026
 11:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fff91f2c9ae1bdbbf76aa46c618b440c896d131f.1791227050.git.lucien.xin@gmail.com>
 <179133510313.434549.8082953410374436828@kernel.org>
In-Reply-To: <179133510313.434549.8082953410374436828@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 7 Oct 2026 14:41:59 -0400
X-Gm-Features: AclHuK_-WpbiNIs5rFoC0CPwAOXjrqmHL68V9DWecj4Pwatas5adXnnPR15tPLQ
Message-ID: <CADvbK_cPbqGt1MzrSUSOt6qqJghwBLz3obg+p-XC5wg+P3MaSg@mail.gmail.com>
Subject: Re: [PATCH net-next v16 04/15] quic: provide family ops for address
 and protocol
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	metze@samba.org, mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:05=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] An unprivileged sticky IPv6 routing header makes the route
>   lookup and the transmitted packet disagree, so packets go to the real=
=E2=80=A6
> - [Medium] IP_TTL and IPV6_UNICAST_HOPS are accepted but ignored on
>   transmit.
> - [Low] The commit message leaves out user-visible changes and describes
>   the code inaccurately.
> - [Low] IP_OPTIONS is accepted and stored but never sent.
>
> --
>
> quic: provide family ops for address and protocol
>
> This commit adds net/quic/family.{c,h} with IPv4/IPv6 helpers for route
> lookup, UDP tunnel transmit, address parsing and comparison, and UDP port
> config setup. It also connects quic_inet_getname() and the setsockopt()
> and getsockopt() levels other than SOL_QUIC to the inet and inet6 code.
>
> > Introduce QUIC address and protocol family operations to handle IPv4/IP=
v6
> > specifics consistently, similar to SCTP. The new quic_family.{c,h} prov=
ide
> > helpers for routing, skb transmit handling, address parsing and compari=
son
> > and UDP socket config initializing etc.
>
> [Severity: Low]
> This isn't a bug, but the patch creates net/quic/family.{c,h}, not
> quic_family.{c,h}.
>
> The wording "family operations ... similar to SCTP" looks left over from
> before v3. That version replaced the ops abstraction with if statements.
>
> Could the message also mention the changes userspace can see?
> quic_inet_getname() used to return -EOPNOTSUPP. It now returns real
> addresses through inet_getname() or inet6_getname().
>
> quic_setsockopt() and quic_getsockopt() now send every level other than
> SOL_QUIC to ip_setsockopt()/ipv6_setsockopt() and
> ip_getsockopt()/ipv6_getsockopt(). All SOL_IP and SOL_IPV6 options can
> now be set on QUIC sockets. An unknown level also returns -ENOPROTOOPT
> now, where it used to return -EOPNOTSUPP.
>
> > diff --git a/net/quic/family.c b/net/quic/family.c
> > new file mode 100644
> > index 0000000000000..f5d859b337b10
> > --- /dev/null
> > +++ b/net/quic/family.c
> > @@ -0,0 +1,449 @@
>
> [ ... ]
>
> > +static int quic_v6_flow_route(struct sock *sk, union quic_addr *da,
> > +                           union quic_addr *sa, struct flowi *fl)
> > +{
> > +     struct ipv6_pinfo *np =3D inet6_sk(sk);
>
> [ ... ]
>
> > +     security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
> > +
> > +     rcu_read_lock();
> > +     final_p =3D fl6_update_dst(fl6, rcu_dereference(np->opt), &final)=
;
> > +     rcu_read_unlock();
> > +
> > +     dst =3D ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
> > +     if (IS_ERR(dst))
> > +             return PTR_ERR(dst);
>
> [Severity: High]
> Can a sticky routing header make the route lookup disagree with the packe=
t
> that is actually sent?
>
> quic_common_setsockopt() now passes SOL_IPV6 to ipv6_setsockopt(). That
> lets an unprivileged user set IPV6_RTHDR, because ipv6_set_opt_hdr() only
> requires CAP_NET_RAW for the other option headers:
>
> net/ipv6/ipv6_sockglue.c:ipv6_set_opt_hdr() {
>     ...
>         /* hop-by-hop / destination options are privileged option */
>         if (optname !=3D IPV6_RTHDR && !sockopt_ns_capable(net->user_ns, =
CAP_NET_RAW))
>                 return -EPERM;
>     ...
> }
>
> Suppose np->opt holds a type-4 SRH or a type-2 routing header. Then
> fl6_update_dst() replaces fl6->daddr with a segment Y that the user picks=
.
> ip6_dst_lookup_flow() looks up a route for Y and then puts the real
> destination X back into fl6->daddr. ip6_dst_store() caches that dst.
>
> quic_v6_lower_xmit() then calls udp_tunnel6_xmit_skb(). That helper build=
s
> a plain IPv6 header addressed to X and never adds the np->opt extension
> headers:
>
> net/ipv6/ip6_udp_tunnel.c:udp_tunnel6_xmit_skb() {
>     ...
>         ip6h->nexthdr     =3D IPPROTO_UDP;
>         ip6h->hop_limit   =3D ttl;
>         ip6h->daddr       =3D *daddr;
>         ip6h->saddr       =3D *saddr;
>
>         ip6tunnel_xmit(sk, skb, dev, ip6cb_flags);
> }
>
> Doesn't this send packets to X using the device, gateway and MTU of the
> route for Y? Neighbour discovery for X would then run on Y's link. Local
> route policy for X, such as prohibit, blackhole, unreachable or policy
> routes, would also be bypassed.
>
> UDP and SCTP avoid this because they pass opt to
> ip6_append_data()/ip6_xmit(), which put the routing header on the wire.
>
> The transmit path is only connected in the next patchset. This code is
> the same at the end of this series.
>
> Should fl6_update_dst() be dropped here, since the tunnel transmit cannot
> send extension headers? Alternatively, should QUIC sockets reject sticky
> routing headers?
True.

udp_tunnel6_xmit_skb() does not support ipv6 opts yet.

will drop fl6_update_dst().

Thanks.

>
> [ ... ]
>
> > +static void quic_v4_lower_xmit(struct sock *sk, struct sk_buff *skb,
> > +                            struct flowi *fl)
> > +{
>
> [ ... ]
>
> > +     if (cb->ecn)
> > +             tos =3D (tos & ~INET_ECN_MASK) | cb->ecn;
> > +     ttl =3D (u8)ip4_dst_hoplimit(dst);
>
> [Severity: Medium]
> Are IP_TTL and IPV6_UNICAST_HOPS silently ignored here?
>
> Through quic_common_setsockopt(), setsockopt(SOL_IP, IP_TTL) stores its
> value in inet->uc_ttl. setsockopt(SOL_IPV6, IPV6_UNICAST_HOPS) stores its
> value in np->hop_limit. Both calls succeed, and getsockopt(IP_TTL) return=
s
> the stored value.
>
> However, this function always takes the TTL from the route.
> quic_v6_lower_xmit() does the same:
>
>         ttl =3D (u8)ip6_dst_hoplimit(dst);
>
> UDP and SCTP apply these options through ip_select_ttl() and
> ip6_sk_dst_hoplimit(). These functions already apply IP_TOS and
> IPV6_TCLASS through inet_sk(sk)->tos and inet6_sk(sk)->tclass.
>
> Should the hop limit use the socket setting as well?
>
> > +     udp_tunnel_xmit_skb((struct rtable *)dst, sk, skb, fl4->saddr,
> > +                         fl4->daddr, tos, ttl, df, fl4->fl4_sport,
> > +                         fl4->fl4_dport, false, false, 0);
> > +}
>
> [Severity: Low]
> What happens to IP_OPTIONS on a PF_INET QUIC socket?
>
> ip_setsockopt(IP_OPTIONS) parses the options and stores them in
> inet->inet_opt, and getsockopt(IP_OPTIONS) returns them.
>
> udp_tunnel_xmit_skb() ends up in iptunnel_xmit(). That function never
> reads inet->inet_opt and builds a header with no options:
>
> net/ipv4/ip_tunnel_core.c:iptunnel_xmit() {
>     ...
>         memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
>     ...
>         iph->ihl        =3D       sizeof(struct iphdr) >> 2;
>     ...
> }
>
> Options such as Record Route or Timestamp are reported as set, but they
> never appear in any packet. quic_encap_len() also reserves no room for
> them.
>
> Should QUIC sockets reject IP_OPTIONS?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1791227050.git.lucien.xin%40gmail.com
