Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794424413;
	b=UgHW0QwvskWrnttxhAw78AUj/y/xt03ebqaWzSswNiWIZCwl3ih7NSJHra1X4jtiFksN
	 kzq98gRibHJD7XEmcpAdMeF8Z+/2oxfPvmAtBGXBsTvYoi7ztmJT9HOL6138UYUHYhS2K
	 tvXoSU6yklcYw/8ydMch3tFvkf2Bdr47kjFcgKzqImBuAVMqAnP28r2b8Oa+YfeW69ox7
	 FwHMuu36gaPe5AKAl5Vhn0lJueu1953MvvNjtODZxTPZ8zErVs+8+H/QdqQ0Hd/XIAoA5
	 7Iljl0lSkN/qGbE/VLBM/9j91EVOtRPqmKQKHos0i6FoHmildvPAutFpwRwLJLMLhvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mUjd7XG+NWVc3MUtMjmyBvgOlBW9j3cmurL1LfULang=;
	b=vp8pf0Idehe17s5j3l0AmbpCImKBufDz9Jq+mRoclh+yucVaMrvG3GwaKvNqrKzXRSvf
	 KgrTX1ljlAOgucYn3y17XhoFQwBTVBVLRA0l/HTskygX2KQhX6q19eHrUA3L8ain5xIdO
	 HX8PdKO2TO/5Sjs0/BjaM2Mn2/SaS5mATC+ifVpwCiXtB5q95/AV3T0eJIer550qhdKsp
	 35faF1Kp8eJ6GhJZT8M/qbo4zOlH+W1WPJqzr6eQYyyR1A6tcd8At94PwcXWaYO1K5+AM
	 EyQufBrhGTrWAfPTkxjFcOFr3+S/mYB+VXRViqig2xd/xti6VaKW9YgetsNzveuD7bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="hjBke/V4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A0606A8A3
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 391A0606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hjBke/V4
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so5780041c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794424412; cv=none;
        d=google.com; s=arc-20260327;
        b=oYZ4kIWPJCfJW+9IhDoQBI3hlHMOBScu58oSwdPFk1oIoxaxOp3ClTiIvnUDC5SRo5
         RJ3fCaNw0QN3ojpP8whOafh/t1BOrh+S2usCIY1OIhUCTr2rEy806tmGNEwV503uqYg0
         MFd0W4ewKdygNYh1J+l4bFBReNkLv54AupITUS46r9ea7FVudTPFaoVb+IR2oLbQ8kkI
         sSpTweS1Zza9PxugxNEl7Lsi3UvHL8K7mmz308iAEZVwpwI9msVU2MwjnyyNwttmw1Sx
         LAtBAqmfiiy3yatjNEbZhZE49Z8X/k+ZIaZYxwHNaMTvTHwZg+9fKqWCRwxQXEToN+zt
         oyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mUjd7XG+NWVc3MUtMjmyBvgOlBW9j3cmurL1LfULang=;
        fh=cbT9+4JqxTzwvPnER/wiMqd6oLb+FNrFft2Gsb3HWSA=;
        b=M/zB3TVfQZ8Hqqwn+98PNw/gFOxEZdOPpL8RZYOIf4lTJ7ZDRGRh//lggbLV2t2e9Q
         jRPPRZjPJ3vtfB3MbwaDEqLFL3ZRZuykmFLORAt5RomVvJ2hJojQMUCYKW+0uz9YRnCk
         mnwYRLUqnEki/B8tHGrqNVqcVlh+UVp77guDlMtl9x8RvWfR5cvbIqylFUWxYk+Vwe/b
         k0n7QGRo+kbsJtp/KibLvqodCFEJo02F9XT1DO7KwwXvj81D7f+AAcPVFnt6gzpG3BFZ
         KS2Ec8OkrdZtr7eFxW7heCy+OtxfS8KDv/F6+40BsfDtwKfCetuhTGyupyMcfaJY8jku
         vRgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794424412; x=1795029212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mUjd7XG+NWVc3MUtMjmyBvgOlBW9j3cmurL1LfULang=;
        b=hjBke/V4N+va+Mg9ph1vFHeOnuGvz5jvW/uniXI51R4ovsg1Bs+fGvyDmdzNlBAIcu
         Y75bcZiOL1NL9DuORAi7Igrjs21YhOTfdaDCWzn4i4uoyKKOhPx3xinO5sWrvzIW8uRW
         vMj6DB1Sma9BT2YoBmAqgw/iSkR6YhaJcUHdllmrue2n/Cjc7KOE2+08RiKsA6bijh8K
         rzE9rOgN+9C5n+IFQfVV/ddBNR9pWRq0wcs6b4uIhjRlDYJ20VD2KTAN2xLfe7gfjR47
         rYbuxQ7M9GXI4CJ0PEu+bFjcOY1R4NhI66d1SRHMMAS1IwzJqiQzJj2Tb0UGwatpC6Pt
         x+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794424412; x=1795029212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUjd7XG+NWVc3MUtMjmyBvgOlBW9j3cmurL1LfULang=;
        b=QUYQQ+XL0RKwzwx0lo8vl8c2si9W19T/hgjQ5yc7Cq5nDyJbqprePezYy8SXp+7dlC
         AsMlRJU2E6T3zt+cc4/1JQpZ+BcpQ/xICFyEMM6jTPSJkaepe9Zm7WicShFmbsKT1T1o
         o7dOD+LhnISpi7qgwzcgCmQAIAiArxUhVsrx036THqqwL49/BSzqb2SfPEvgntgHs4Rz
         v1pYoj6QK2YQJOzBFUix+LZ4UkJSgsq2JU3kbljDXLHqw3CNJbZj0sXuPJKPPQOPv/uu
         byQ/wyn4xA6by5Q9TWxp8FXVDVMQmnQ5opA10Fkjm+WF6uQzHFGoFazeRWs1HdLjKP7K
         ZioA==
X-Forwarded-Encrypted: i=1; AL+hErFHBPjZY6Rqgj5/MeMDB0ssk7NPJJCvGlHd1tlpRnP8mym5LAhc3OpZcFoWy1XMeOJM/IOsb8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z90L+cBxToYzXOiDjqqkjmtAZdro3sxzLAQscskTQLjqmjdAh19
	r/4B5Scm0mpoLwmLoVvPWJciaAHU4AaZi3eYAVg+C2tcpSx8WoaJAWRxq8U/ZEffvn+PZ5gx/iK
	5JMkAJNdTEhHMidlj2uXQgzbuGgKfn+4lU3Kq5NPX
X-Gm-Gg: AYBFou0l2reB2ugYR6GmyNrAG4LW89Dn6kGECvDlKYeF7vM03TmlH8aSzJ9ev+tWaX1
	mFM5A6tIVJXRhHB0ckrvPpAyMh7iS4eIl5Rnz7oeKiUcOG0z+YmpEQOF7bXR4kddr4p16RwZQ1/
	Wrm/6MLJiOv3YEOlaZQDdf4f/qFEuzHuEFqMrS/iSfKikUnydv1BO5TjB7EAO5VodWQ01pOczfL
	GR94VGwE/+t3C/2ufiZV7VV8sk1a4fGTWYZ3VOw/O2Fe3iOpxM2n1FEWvgo3ibaSD3PT33pM4z/
	fyBDeaPMUmMy4+yEL1K6J7AC129BWmbPNDeLjssUL+yOsrAais5gxiNV5wty3tleWXRz9raYN22
	/iwPAr8NjSwD+3/eHGLVV1bk6wwPy8dttAkUS0M9Y14Bi3tLDwIjkvZf1CaYvYUnfn6+5SYLpA0
	ap2vXMuZCMz4S1OebVNY2VkXJzl8G11SPsjtZS7hfWEbBqlAtxJ793EBBy/IhUdIQk7B1D8x22C
	yfsC2WZ1enOGalQ44i2zpVkJ3c=
X-Received: by 2002:a05:7022:7e82:b0:1ab:fe29:5081 with SMTP id
 a92af1059eb24-1b3c0311fd5mr3429271c88.20.1794424409897; Wed, 11 Nov 2026
 11:13:29 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avFvW7nn7GIZmZ-a@v4bel> <179442373755.2199510.13127759467093413622@kernel.org>
In-Reply-To: <179442373755.2199510.13127759467093413622@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 11 Nov 2026 11:13:17 -0800
X-Gm-Features: AclHuK_9K-lJ5eNqk5dnaP5w_lOC-4eLc8rXOfiy8IpYv3SWU2dSRCv6dBlER9U
Message-ID: <CAAVpQUDsW-drrxi8MteUOr2fNxe-ZezRVCTtwzsY-rEx2VTk+A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reject v4mapped source addresses in IPv6 SYN
 cookie ACKs
To: netdev-bot+sashiko@kernel.org
Cc: imv4bel@gmail.com, edumazet@kernel.org, ncardwell@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	martineau@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:02=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch closes only the v4mapped trigger.
>
> --
>
> tcp: reject v4mapped source addresses in IPv6 SYN cookie ACKs
>
> This patch makes cookie_v6_check() reject ACKs whose IPv6 source address
> is v4mapped, before any child socket is created. It matches the check
> already done in tcp_v6_conn_request(). Before this, a SYN cookie child
> with a v4mapped peer could be found by tcp_v4_err() and end up caching an
> IPv4 rtable, which ip6_xmit() then used as an rt6_info.
>
> > diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> > index b581cb1ee2e8a..6c5bb4bbd349c 100644
> > --- a/net/ipv6/syncookies.c
> > +++ b/net/ipv6/syncookies.c
> > @@ -189,6 +189,12 @@ struct sock *cookie_v6_check(struct sock *sk, stru=
ct sk_buff *skb)
> >           !th->ack || th->rst)
> >               goto out;
> >
> > +     if (ipv6_addr_v4mapped(&ipv6_hdr(skb)->saddr)) {
> > +             __IP6_INC_STATS(net, NULL, IPSTATS_MIB_INHDRERRORS);
> > +             SKB_DR_SET(reason, IP_INHDR);
> > +             goto out_drop;
> > +     }
> > +
> >       if (cookie_bpf_ok(skb)) {
> >               req =3D cookie_bpf_check(sk, skb);
> >       } else {
>
> [Severity: Medium]
> This closes the v4mapped case. The commit message also names the missing
> IPv4 address initialization as part of the chain:
>
>   "cookie_v6_check() initializes the IPv6 address fields of the request
>   socket, but not its IPv4 address fields."
>
> Is that still a problem for native IPv6 SYN cookie connections after this
> patch? Further down in cookie_v6_check(), only the IPv6 fields are
> written:
>
>         ireq->ir_v6_rmt_addr =3D ipv6_hdr(skb)->saddr;
>         ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
>
> The normal SYN path sets the IPv4 fields in tcp_v6_init_req():
>
>         ireq->ir_rmt_addr =3D LOOPBACK4_IPV6;
>         ireq->ir_loc_addr =3D LOOPBACK4_IPV6;
>
> On the cookie path, the request socket comes from a slab allocation that
> is not zeroed:
>
> cookie_tcp_check()
>   cookie_tcp_reqsk_alloc()
>     inet_reqsk_alloc()
>       reqsk_alloc_noprof()
>         kmem_cache_alloc_noprof(ops->slab, GFP_ATOMIC | __GFP_NOWARN)
>
> Neither inet_reqsk_alloc() nor cookie_tcp_reqsk_init() sets skc_daddr or
> skc_rcv_saddr. inet_csk_clone_lock() then copies those fields into the
> child:
>
>         newsk->sk_daddr =3D ireq->ir_rmt_addr;
>         newsk->sk_rcv_saddr =3D ireq->ir_loc_addr;
>         newinet->inet_saddr =3D ireq->ir_loc_addr;
>
> Since commit a3a128f611a965 ("inet: consolidate inet_csk_clone_lock()"),
> tcp_v6_syn_recv_sock() no longer writes LOOPBACK4_IPV6 into the child.
> So it looks like leftover slab bytes stay in inet_daddr, inet_rcv_saddr
> and inet_saddr of every AF_INET6 child created from a SYN cookie.
>
> Both ipv6_update_options() and do_ip_setsockopt(IP_OPTIONS) branch on
> that value:
>
>         inet_sk(sk)->inet_daddr !=3D LOOPBACK4_IPV6
>
> Could this make icsk_ext_hdr_len and the MSS different for a SYN cookie
> child than for a normally accepted IPv6 child? Could it also trigger KMSA=
N
> uninit-value reports? The leftover bytes would also show up in the
> inet_sock_set_state tracepoint and the BPF ip4 context fields.
>
> Would it make sense to also set ir_rmt_addr and ir_loc_addr to
> LOOPBACK4_IPV6 in cookie_v6_check(), as tcp_v6_init_req() does? That
> would be in addition to the v4mapped rejection, not a replacement for it.

I have two patches in my queue for syncookie bugs, and one addresses this.
I'll post them later today.
