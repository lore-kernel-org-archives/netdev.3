Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792530641;
	b=nqXata1I8FvOHM25v4fS/11clO2UKUYs/GaEzM6nQh/RksFK7jOaVKY0WlkD2w3BpZ0V
	 eD0tIDLNqAVkUudFeJviP86z+zbFNMLJ/LMBJQav4c5yPs3OmHc90rHYG9FLBP/toVwO8
	 7SHj/5laJpRAPenL+Q4d9MpDdY4iBGK78MZvy1ojomQT8aqVWqqEcOp49wcEXCO6HG0lW
	 mx/RnPjIGDBXqW973HR61VxOcYD8u/nxdb5s3L5fJJbYjfhehYxWY27JVdmUhUI3UYvfw
	 XJi9RnWMiQE/HNAxC6jAykkW3kaBd9BmmGUBvVfnAjPrWQsUXLxJDqo5KviZqJAj3Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IjpJhJj3XPvV3nh0FGBKO62yC++yDA1DsEy0orMi22E=;
	b=GojAyIXLtWpoMRcuGye1f1Ejx9L2fMYqFn47FqDFM4+Ie9Ga7oX9SKdHWidhPp9vxciV
	 zGhS/8BT13THfuC2gzX5wIyhjlkr//gjL4zWF50GEKOo8F6RrWyknoGlj/eK0ld0a/+zJ
	 dVcorjESorY2rGKfK0y+mJNQK3lss4TNN1RM5li2jMRgng/7n0oZTE8eLj0RWPrRJm9uK
	 FCxkKbEambW3hmZ1zPgM0lalmswl90+NAyXVhBoEZHkdQcW2CHq4MOypMY6Esse5iVxdr
	 oQgG/9TCXganTtdlp5sWyx0yCu3+Ud8KnmjoxFUKHNEsD0oLr4mdl7BEbBRYFexaO1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VAlefrrF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312C606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8312C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VAlefrrF
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so932870e0c.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792530640; cv=none;
        d=google.com; s=arc-20260327;
        b=U73nSuylzhq7nBidn9UOKxFt0zl1otK28o4TOh2ZtByltJaM+ztxyDK+bm6aasiHj2
         K80Gfg8slD3HWYjrtL7rrDJIYiJ9WzSz89pjnkfzgxMXIrh9mzn8zfcDDsYbcFsM59KA
         m2DbI+qtQAgH1sUoZGVY1Li1B62X001lAapERKiXg6jqpfaND/AQncqdhSIGs4Ngu0GV
         Ibq3z3oODJXU8nEpr2qrhNiRjNVnPvV9A3wCtPlP90sOdhy00NbBs4zqsAHY6kBjGJnb
         +i/OwzivSMoQ4uyZ+Ext60ncnmvTgJGmYudCsCUFVK5TX7p0uhfxg50uf+CChQ6P90Jz
         bSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IjpJhJj3XPvV3nh0FGBKO62yC++yDA1DsEy0orMi22E=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=Z87/A/HTfejUvuzd9fZ5wzbCkYzSQOb4ip9xXFl4nznnrkzvWkykgCk/k6iiYzzQYQ
         MUIsmSnyoNkVJrnF9ZMOrLBheuEwfhhxYm6Kl2NdVHuK89dXd3lxKi/pOsGM1nQbRhKp
         fq/oWyDtTHCA8YUBH1bdbFCgpMwrje1VpWlEL8h5dct0jGjTbF60gi6WD8p5nKAwR7x6
         s4/kfrsj8dYfr2TPV1dTYOJ1OaAHFhJHAGnqc+wefZIaqUanTIdpjiWPA7tX2uYe1kzj
         FhkCfvN3JJEJB9fwiRGuj6DqtPtzxH8Y2GD8lHDJeSY39Kcv+ohu5C91UkrXVltH0U3X
         gtWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792530640; x=1793135440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IjpJhJj3XPvV3nh0FGBKO62yC++yDA1DsEy0orMi22E=;
        b=VAlefrrFGpsB10R/HV2ZE8WP35YOUkmlIE4u3r/K38kdKpGrP0RwLQ+dPgC8MofmVf
         JHODPfUJ2VM1pTEZFlEQKEGrj3tq9bwGzUmyjp9mI6BeQ92VJ0IeZrgUF8i8rek/yzXt
         V4/B4W+v7jVl5naD5G5wlkvZtDmpqeC1XeAFSf4nO12XqmWA3j8L5Ba6LDoLHpMpQETG
         FbxWGSe2Sofgb5bYSNxex8qPDxXjFnNQKBNuPA1eppLmFukM7FiyRVQ/z/D5HtoX+Mr+
         LPaC7kHOoaXQEZT2SO1Nai2Lz8t6lyAXsxLWkZMYBC3YTGsr+8E0kAO4/VXSVuvTJBRn
         JH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792530640; x=1793135440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjpJhJj3XPvV3nh0FGBKO62yC++yDA1DsEy0orMi22E=;
        b=o0tWHg6V7tYfUr3vYHlk2AUzMwaruDaGVseXmDsN+JllhfRK1eXXbe/P2MZmXjBuSM
         bN2dQUSFhxCTJA9Lk4k8OVWfUrNxp2SWrJsGSyXivRqI5gyWVnYgcGUoEpCVniycRgd9
         x21gzMnJCQtWNRlmerxLNNqa2NeWfse8pgWAn/4dU1D5YNVKTxWZF1tKoUQPqxkNBb25
         Ir9GTS7+kUd36I3jP32GoB4ipqKc1n463MkWjxRiG3lFKK1IEt3zNQYMd23RGCnynuFt
         f3jE89TGFb/L2YZhJE5ApO3pH7QMcWrSM4+un8Nvl/8y/7H/4mX+sN6OpG3jLX0Rkw+E
         gjrQ==
X-Gm-Message-State: AFq9FYIyqQlQY8lZNXH5aP+IDC9qLcKJ+cZhu2qGI6jvFiP/s306GCZt
	XAuRRugg3sVIHpUqEjJVnIq9MkDdfIZvJ+KM6u1DofIVMmGIVMkVbAH9xl7jA52s08og/I9GWiy
	H6on+r0XUZGQYme5S41fDuKw/Ibv86rE=
X-Gm-Gg: AYBFou1SjATQ0VPOfLIyM/0cFdljWXiROTcvDuvzgxDqAMdQl4H1BY1csT+RI4tNxLH
	yTyvHYkhlzm2ossHSFzZO+WPM6VcwsH/j5zg4cfDjFLr+VLdLsRF5tLJ2fyBfK2xo5iK0T+5VaQ
	qDDiauYzCQyrMkOM0b8QnX6f3AK88+UcVNAbLHk/JuPxtn3oalaTa2qsjdtyVv3ksYrTTLOPtwq
	a3+7Hf2DMu/cKiFlNjiTFt/ppspW5teWHaY7nQSFpCSpwdiSi/GaDBu6LX5u80Xy+WVs32JQTS4
	WmCG9H+F/ytOEvhQTJQkRCoa4e7eyI77yE/ewraLtivuwg4FV65SIhN/FLCCZj0UviufWcbN8cD
	nA0g9og5sf4/oBVQKVLHF31c+hGE5YkYyDgWSyqDXbikCxorW8qx9EpXd4qVqz60j7Gf977n6ld
	87TQJGPxXs+My0
X-Received: by 2002:a05:6122:8b0a:b0:5ea:aedd:6077 with SMTP id
 71dfb90a1353d-5eaebdb8b25mr11924e0c.5.1792530640358; Tue, 20 Oct 2026
 14:10:40 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <89a17e38fca0c84eb23ccde147942e44034ce05b.1792164438.git.lucien.xin@gmail.com>
 <179244539028.3135.8632269420764172979@kernel.org>
In-Reply-To: <179244539028.3135.8632269420764172979@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Oct 2026 17:10:27 -0400
X-Gm-Features: AclHuK90ubiZ_3Vt7ioV-VUXcLL_AkSfJ2ivx6yoB89OB2lkvKl3ARidx8adw2s
Message-ID: <CADvbK_fNMJxJq8QFiFLtAE1op_bAGYU7bMi8qZ58Ai-aGGP7KQ@mail.gmail.com>
Subject: Re: [PATCH net-next v17 04/15] quic: provide family ops for address
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

On Mon, Oct 19, 2026 at 5:29=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] quic_common_setsockopt() (net/quic/family.c:416) passes every
>   SOL_IP/SOL_IPV6 option to the core IP stack without filtering.
> - [Low] The commit message describes the patch as only adding
>   family.{c,h} helpers (routing, transmit, address parsing and=E2=80=A6
> - [Low] When routing picks a link-local source for a wildcard sa,
>   quic_v6_flow_route() (net/quic/family.c:131) sets=E2=80=A6
>
> --
>
> quic: provide family ops for address and protocol
>
> This patch adds net/quic/family.{c,h} with IPv4/IPv6 helpers for routing,
> UDP tunnel transmit, address parsing and comparison, and UDP socket confi=
g
> setup. It also connects quic_inet_getname() to quic_get_sk_addr(), and se=
nds
> setsockopt/getsockopt calls for any level other than SOL_QUIC to the
> IP/IPv6 handlers.
>
> > Introduce QUIC address and protocol family operations to handle IPv4/IP=
v6
> > specifics consistently. The new family.{c,h} provide helpers for routin=
g,
> > skb transmit handling, address parsing and comparison and UDP socket co=
nfig
> > initializing etc.
>
> [Severity: Low]
> This isn't a bug, but the commit message only talks about new helpers. Th=
e
> patch also changes three socket entry points that userspace can see.
>
> quic_inet_getname() in net/quic/protocol.c used to return -EOPNOTSUPP. It
> now calls quic_get_sk_addr(), so getsockname() and getpeername() return
> real addresses. IPv4-mapped results on AF_INET6 sockets are also rewritte=
n
> to sockaddr_in.
>
> quic_setsockopt() and quic_getsockopt() in net/quic/socket.c now pass eve=
ry
> level other than SOL_QUIC to ip_setsockopt()/ipv6_setsockopt() and
> ip_getsockopt()/ipv6_getsockopt(). That makes the full SOL_IP and SOL_IPV=
6
> option sets reachable on QUIC sockets.
>
> The errno for unknown levels changes as well. setsockopt() now returns
> -ENOPROTOOPT. getsockopt() returns -EOPNOTSUPP from do_ip_getsockopt() on
> IPv4 sockets and -ENOPROTOOPT from ipv6_getsockopt() on IPv6 sockets.
>
> Could the commit message mention these changes?
>
> > diff --git a/net/quic/family.c b/net/quic/family.c
> > new file mode 100644
> > index 0000000000000..dc41a0ae07086
> > --- /dev/null
> > +++ b/net/quic/family.c
> > @@ -0,0 +1,441 @@
>
> [ ... ]
>
> > +static int quic_v6_flow_route(struct sock *sk, union quic_addr *da,
> > +                           union quic_addr *sa, struct flowi *fl)
> > +{
>
> [ ... ]
>
> > +     fl6->flowi6_proto =3D IPPROTO_UDP;
> > +     fl6->flowi6_oif =3D quic_get_dev_if(sk, da);
>
> [ ... ]
>
> > +     dst =3D ip6_dst_lookup_flow(sock_net(sk), sk, fl6, NULL);
> > +     if (IS_ERR(dst))
> > +             return PTR_ERR(dst);
> > +
> > +     if (quic_v6_is_any_addr(sa)) {
> > +             sa->v6.sin6_family =3D AF_INET6;
> > +             sa->v6.sin6_addr =3D fl6->saddr;
> > +             if ((ipv6_addr_type(&fl6->saddr) & IPV6_ADDR_LINKLOCAL))
> > +                     sa->v6.sin6_scope_id =3D fl6->flowi6_oif;
>
> [Severity: Low]
> Is fl6->flowi6_oif the right value to store as the scope id here?
>
> It holds the oif requested before the lookup, which is
> quic_get_dev_if(sk, da). The ip6_dst_lookup_flow()->ip6_dst_lookup_tail()
> path doesn't appear to write the chosen egress device back into it.
>
> On the fib6 rules path, l3mdev_update_flow() can also clear it when the o=
if
> is an L3 master:
>
>         if (netif_is_l3_master(dev))
>                 fl->flowi_oif =3D 0;
>
> The IPv4 side is different. ip_route_output_flow() sets
> flp4->flowi4_oif =3D rt->dst.dev->ifindex after the lookup.
>
> Two cases can store a link-local source with sin6_scope_id =3D=3D 0: an u=
nbound
> socket with a link-local destination that has no scope, or routing pickin=
g
> a link-local source.
>
> After that, quic_get_dev_if(sk, sa) falls back to sk->sk_bound_dev_if (0)=
.
> quic_v6_udp_conf_init() then asks to bind a link-local local_ip6 with
> bind_ifindex 0, which __inet6_bind() rejects. The link-local scope check =
in
> quic_v6_cmp_sk_addr() is also skipped, because one side's scope is 0.
>
> Would dst_dev(dst)->ifindex record the real egress interface instead?
>
> > +     }
> > +     ip6_dst_store(sk, dst, false, false);
> > +     return 0;
> > +}
>
> [ ... ]
>
> > +int quic_common_setsockopt(struct sock *sk, int level, int optname,
> > +                        sockptr_t optval, unsigned int optlen)
> > +{
> > +     return quic_pf_ipv4(sk) ?
> > +            ip_setsockopt(sk, level, optname, optval, optlen) :
> > +            ipv6_setsockopt(sk, level, optname, optval, optlen);
> > +}
>
> [Severity: Medium]
> This passes every SOL_IP and SOL_IPV6 option to the core IP stack. The
> QUIC route and transmit helpers above only use part of the resulting
> socket state: tos/tclass, uc_ttl/hop_limit, pmtudisc, SNDFLOW flow labels=
,
> sk_bound_dev_if, mark and uid.
>
> Can setsockopt() then report success for options that never take effect o=
n
> QUIC traffic? Some examples follow.
>
> IP_OPTIONS sets inet->inet_opt. However, quic_v4_lower_xmit() goes throug=
h
> udp_tunnel_xmit_skb()->iptunnel_xmit(), which always builds a header with
> no options:
>
> net/ipv4/ip_tunnel_core.c:iptunnel_xmit() {
>     ...
>         iph->ihl        =3D       sizeof(struct iphdr) >> 2;
>     ...
> }
>
> quic_v4_flow_route() also does no source route handling.
>
> IPV6_RTHDR, IPV6_HOPOPTS and IPV6_DSTOPTS set np->opt, but
> udp_tunnel6_xmit_skb() never adds extension headers. The v17 changelog
> notes this when it drops fl6_update_dst(), yet these options are still
> accepted.
>
> IP_UNICAST_IF (inet->uc_index) and IPV6_UNICAST_IF (np->ucast_oif) are
> ignored, because quic_get_dev_if() only looks at the link-local scope id
> and sk_bound_dev_if. UDP does use ucast_oif in udpv6_sendmsg():
>
>         fl6->flowi6_oif =3D READ_ONCE(np->ucast_oif);
>
> The sticky IPV6_PKTINFO (np->sticky_pktinfo) and IP_TRANSPARENT are not
> checked either.
>
> Would an allow-list in quic_common_setsockopt() make sense, returning
> -EOPNOTSUPP for options the QUIC path can't honour, as MPTCP does?
>
True.

But this is more like an improvement, it will take a long time to go over
all IP/IPv6/SOL socket options. I may leave it for future work.

Thanks.
