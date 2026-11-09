Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229764;
	b=JhzOe5/FBx0Uw/QxaUiZqeN1f/6hfDtlzGvvliwZE+cOAWbperV8NilNiDt+2J3Ezcjp
	 vl52Iy18uLE2wzV2VH/Tlcdtqkm/j8YIR25V3M9ZXHfjig5uArCX9+B7rxbUOpIjl0a5B
	 ByXCoY1oLawImI4QfBna4D3N2D24e62A1/odmBATQt0GoCA/Q/F0JvCAeE1dZJPLnFUCE
	 au2bkdU+FhV7udi+bCOBMTxsDuzXOOWrelbcWi+qfQ1QBJiPRitT4OKRowt7vi0CBouDs
	 WPZK3nUcNGpYBWFidfkLCW9ihgDdA5BrHj+lEkO9J5RrXgKoWjJc07LtlVmGZI0irOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229764;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wVb94j5oWA2XXVhXgiQspwdYnM+eA6VBMFxjzm5MA9Y=;
	b=TqmlyHG7XJnOt4dBreRdblMCs1od9rBTcaifhqTpwc1QkMYIPp6ZbT6htvS4gXPbaIby
	 3eQM3v3z1Th0/941AX9V3eYmWr+ts4XmTQwrGRtWfDYBtwlpabgRTQ2VWdNOGwiWVILG2
	 QFkSEk/6r/pDUCxWlvLyi0CsKmGf9bQuZU3WBv0hms62hhwjlTQ7sZbXRu+CzSIoqpTp7
	 UPehFTv7quK6SKErMVjsPt2oONtxNCqcSukBYV7EXoX30ppdhI/ptWy+1FHWZWHaoDkLn
	 NTeUYn9GTAphpjy90P178yibHeupgLbmK/nF9jZmx5OuR3V/Mctv26EMyoSP4XhUuTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8vmDinm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44314606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8vmDinm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20451F008A3
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794229764;
	bh=wVb94j5oWA2XXVhXgiQspwdYnM+eA6VBMFxjzm5MA9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h8vmDinmpVjjtL7AnZY3bRVSMMimVlMtJjRWlsgnL/hGGY/5O9COI6PcF7h7NpiUJ
	 ydUlhltrQVD5nsH5pfEC2aYjfbJR8Ekdx/RyWlcFnYyP5+nX/86JHIA7GlAv+f3gbZ
	 /sfJxxthUp/GqJiGZAsbI2zK0RCpN+YofD7av8RGgPv0BqLS4AmZHNKtj7GJoNo5RS
	 VM7GOciukuWXhA3G2JtnylKQfpSf24naOORHx2j+/5VLI4L/QIhz1oO2XLhPLO8v21
	 lFa6JwGtYBLxCJJFLCsFPO/SMsz+VHki2hqdY2a7+tqPiZ559CykGtXQT0ONgI1lco
	 9XLMWei5FZbsw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6aa9606ddadso439388eaf.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:09:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG+O++Ze6GKO3cYaV940Dt1Cu72Q1k/+z5ZKoxrGY1vI2lFPvNTHRkc5rYx6VaPUJQTJqs/gLM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wSaYMOBHEHNTcNR939K0LQIc2no9KxAn9ME8kIzAKjLGn17yX
	kdzxy8ChUYNDAmgu+kBd1uBZD+SbDrk0AAjNshs+CYW+4Ru20fZmcrKFI1+IyuG7EICAkC6+xfN
	IFBPdwnZpHlRXCYABYysvQOkCI16dw7I=
X-Received: by 2002:a05:6820:4a18:b0:702:3087:ca56 with SMTP id
 006d021491bc7-7170f25b44dmr1354549eaf.26.1794229763205; Mon, 09 Nov 2026
 05:09:23 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106234313.2537882-2-edumazet@kernel.org> <179409673700.994134.1614691544438367987@kernel.org>
In-Reply-To: <179409673700.994134.1614691544438367987@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 9 Nov 2026 14:09:11 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq67pFNB1r13YxjA4Btabg=mEZb9N7Z4Dqsw+WA_4C2sQ@mail.gmail.com>
X-Gm-Features: AclHuK-oRMKMgOuax-68pJRAsFibJFXSOgnmPj4y7N8K2Fhs0kFwf1YHobFMK8g
Message-ID: <CAL4Wiiq67pFNB1r13YxjA4Btabg=mEZb9N7Z4Dqsw+WA_4C2sQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ipv4: unshare headers before recompiling IP
 options in ipv4_send_dest_unreach()
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, idosch@nvidia.com, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org, kylebot@openai.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 8 nov. 2026 =C3=A0 01:12, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] This patch adds skb_unclone(skb, GFP_ATOMIC) to
>   ipv4_send_dest_unreach() (net/ipv4/route.c:1272-1274).
>
> --
>
> ipv4: unshare headers before recompiling IP options in ipv4_send_dest_unr=
each()
>
> The patch makes the IPv4 header private with skb_unclone() before
> __ip_options_compile() rewrites Record Route and Timestamp options in
> place in ipv4_send_dest_unreach(). The goal is to stop concurrent
> link-failure processing of clones from changing an option pointer after
> it has been checked. If the copy fails, no ICMP error is sent.
>
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index 3a90c8d28b940..4d8fcc95c2f46 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -1269,7 +1269,8 @@ static void ipv4_send_dest_unreach(struct sk_buff=
 *skb)
> >
> >       memset(&parm, 0, sizeof(parm));
> >       if (ip_hdr(skb)->ihl > 5) {
> > -             if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
> > +             if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4) ||
> > +                 skb_unclone(skb, GFP_ATOMIC))
>
> [Severity: High]
> Can this skb_unclone() leave stale header pointers in callers of
> dst_link_failure()?
>
> ipv4_send_dest_unreach() runs as the ipv4 dst_ops->link_failure
> callback. Before this patch, a header that was already linear was never
> reallocated on this path, because pskb_network_may_pull() returns early.
> Now, when the skb is cloned and has options (ihl > 5),
> pskb_expand_head() swaps skb->head and calls skb_release_data() on the
> old head, which drops this skb's reference.
>
> ip_tunnel_xmit() in net/ipv4/ip_tunnel.c saves a raw pointer into the
> head before calling dst_link_failure(), and does not reload it
> afterwards:
>
> ip_tunnel_xmit() {
>     ...
>         inner_iph =3D (const struct iphdr *)skb_inner_network_header(skb)=
;
>     ...
>                         WRITE_ONCE(tunnel->err_count, err_count - 1);
>
>                         dst_link_failure(skb);
>     ...
>         tos =3D ip_tunnel_ecn_encap(tos, inner_iph, skb);
>         ttl =3D tnl_params->ttl;
>         if (ttl =3D=3D 0) {
>                 if (payload_protocol =3D=3D htons(ETH_P_IP))
>                         ttl =3D inner_iph->ttl;
>     ...
> }
>
> For header_ops GRE devices, ipgre_xmit() in net/ipv4/ip_gre.c also
> points tnl_params into the head:
>
>         tnl_params =3D (const struct iphdr *)skb->data;
>
> The call chain is:
>
> ip_tunnel_xmit()->dst_link_failure()->ipv4_link_failure()->
> ipv4_send_dest_unreach()->skb_unclone()->pskb_expand_head()
>
> Cloned skbs do get here. TCP transmits nohdr clones, so
> skb_header_cloned() is false and skb_cow_head() in
> ipgre_xmit()/gre_tap_xmit() does not unclone them, but skb_cloned() is
> still true. An unprivileged user can add RR/TS options with
> setsockopt(IP_OPTIONS). err_count goes up on ICMP errors from remote
> hosts in ipgre_err().
>
> After the expand, the old head stays alive only while the other clone
> holder, such as the TCP rtx queue skb or a tc-mirred original, keeps its
> reference. If the tunnel has a qdisc, the clone can be sent without the
> socket lock, and an ACK on another CPU could free the original. That
> could happen during __icmp_send(), or even inside pskb_expand_head()
> between the skb_cloned() check and skb_release_data().
>
> In that case, are the inner_iph->tos, tnl_params->ttl and inner_iph->ttl
> reads use-after-free reads, with the stale bytes written into the outer
> header's TOS/TTL?
>
> Would it be safer to compile and echo the options from a private copy
> rather than uncloning the caller's skb inside a link_failure callback?
> Another option would be to reload inner_iph and tnl_params in
> ip_tunnel_xmit() after dst_link_failure(). Either way, it seems worth
> checking the other dst_link_failure() callers for the same pattern.

Good catch, thanks. Callers of dst_link_failure() such as
ip_tunnel_xmit() keep pointers into skb->head (inner_iph, and
tnl_params for GRE devices with header_ops) across the call, so
ipv4_send_dest_unreach() must not reallocate the caller's skb head.

v2 will compile and echo the options on a private pskb_copy() instead,
leaving the caller's skb untouched.

pw-bot: cr
