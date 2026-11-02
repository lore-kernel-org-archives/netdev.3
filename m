Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793631878;
	b=oVScSKbF+vMbtpe8TylMzdjunJWJs/8tkLZicuiKie8ADQZTin2OnKK+VBaK0eBP48dI
	 W0ieKI3mlwmcnixOiCxzQ2a7Ufxa7/D2NWH8fcLMCEWlE3h7W9o9Xlo+/Dl88nHcEKJJc
	 Om8HMjs0Ex4ju6unZ6K3a4fItv0Jwf3S42nMmWsyzscgA5MjAlEm4fthzl4JM4DRRKANw
	 Ka5X9zOm3sp7uGRKmfzzYONGLScImMFj5IpNRN0PC7Fs8xfwvEMumWoEgPx0UzLL7mgwV
	 TEgDQFU4OuOp/M7r/ihcG0LzSQKhIHCL29oiVfuTlzLjgys/P2QrUqf7hsOq8it3y0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=05lWnnP5zkhuHkEZ+/p+NXTZRQ419Z9JuLN2UY1R6P0=;
	b=HuM5jw/19qNdJpPhhCtD9ujCKxdOgDGm5J6wambzj9e+1OLIQHTtJ7wXpUv1ZnWCWTFO
	 iDbXDK+nGSnytwvXLoiOabGMU72e1rrbDFGVGGvS23YFa5hXBhbdlG+mJCk+axBSsNdLI
	 +jYpw/gpL16T2qbbsr4hEAFGrXjPWNnaHTinLuh8UHfW/UxM3+P2wJNbA2ZUW6OyxQCj8
	 Z991pp1z/igO/WrXkmMK7y1UcyK2BX+aPJbd0qlF7ICZDRNNCsMOYP+1Hc+gsnRGR4DbB
	 av6I4Ul86TqRd8S8D35beBHc1eO5fjqLvKU+1x/6AwwBIMOP2ZJBgo+clFiWItEuO6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="N/TUj6rV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4E16070C80
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D4E16070C80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N/TUj6rV
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso20562a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:04:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793631876; cv=none;
        d=google.com; s=arc-20260327;
        b=fjeOznDrEg+2Vy+776+6Y7vl1swhha8R+0dCSYb5FKn420svON66JER8j5o9vj3SYp
         G0Tp1TNDQC4IjIZRmhXrNg0H7qYJe0II0OtEmXTv8/T/C4CRV/M6xSzsqe/jGsCy6Kpa
         5ZAcygcbGAPxSSqlxCscHFbvQJ7ZMFXUsEmMxF1ACXYFB+1IstTK3f9naILV4noOgPEt
         WxIY6QjqGjP1AMjevgOyZ3gdLwmIa/XvTcydEJfG9zMiGP6AqFonQg15cM2qz+qZVpb6
         qHrYmVEEYYoHfzmwFTlEa1YL8h9wnqOtvgPVlzT8jyMLhpEhXTitO//4eW+vlGn45Bq9
         VDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=05lWnnP5zkhuHkEZ+/p+NXTZRQ419Z9JuLN2UY1R6P0=;
        fh=ileJ+n5gJzSqLAqeWqLM/hg2b+G2oziM88xmjLw1pMo=;
        b=XR9tAR6BPvD4aZ5NxqLubg5aV0GUkJSxsiDfh1TYnNvaLPQy9l20Vd1lpAXKlu6E7j
         taIsVeCbuIfdEo92q134IWkthkQsJZ2fm/LsQaN9nbkQCp+a7TpblgaTpmJbaiT4L/CR
         WhSGJzD76QnAWMAs5409ok1seXtL7SgYlqtO4D84Afa3yWuPAVXRFGuGcpjZXMTH2v6u
         DH1c0prdXR2iWSjwlWUEh6RuJj074yC5dLVxg5V37EIooDVtIhu8RLL4NMgt0XrSO8vc
         jI4zfji9CGZdrjwDmIW6vY3CUEDlWvOIbc6/39AZv2Fzf1qsYGLMBe58gwn4NiT1h4DN
         BVqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793631876; x=1794236676; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=05lWnnP5zkhuHkEZ+/p+NXTZRQ419Z9JuLN2UY1R6P0=;
        b=N/TUj6rVR1WdnV2y37Zl15E+mc9OJqdFRKNJWs8ilG4wlpCKUEhWCvd6jmvAleTUpK
         ujhx+GVfsfIpiu8TBqMVNEuroKm4oOO2e0MD04Wbqpzt7qdNwswze3ulCE/8wSS0NZ4v
         8R5L60G0nBjVPPCT0BjvvK8uWVtc8HlLIgaQ7mBKoJE2GqUiZ6NRkl9JlO1V0FE5lkh5
         Wp1tTbVBxcoVlEZEEZdHYhhVyGjRiv+R353ceD3OAzlihXOSXC/uYAGVVvR3sYfYVL4+
         vXZDHi+IJpID7FfNH5Ui/37WEm6SWt5DtlYBGLFAVQEWUH9I6E/E5afZ+//xWt4of6yn
         +gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631876; x=1794236676;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=05lWnnP5zkhuHkEZ+/p+NXTZRQ419Z9JuLN2UY1R6P0=;
        b=HTLsuuNcluQ7o7aiKIhj//l615qMUgnN1M7IMYjHW6WH6GbpQuzMivwEN9Hyh5i5Au
         RXkyPMxDQ16D/ZTll/wSuEOss93PBezji/U2q8evguEyiLLvkf+Vl/4TXxBY+G2mCeoL
         cl2Hv0S4+cClzAAZGtxe//PWsS1l2M6y2apUML67ZaCt09okOLYSeFdfWXg3U2Je7IvS
         lZt8uzMv/VjzYbr4jjvWDzHlAZF1JqUoBvsBc9mFjBu3JpGuBdNDyA9l5IAmUk8nQfRt
         X4WIDkDNGuMVjJJCENYV0qrPXQmZnykqonUgwNPmeE2Ydwd0mYGrofNO4xqubYK3BimW
         4/tQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLZLxCS55nUwEwhEjgmGN/aPGhx/E55DffIv4s7tGw1AW4h8yLKiQxsfKExmQ0Hak/E6at1ug=@vger.kernel.org
X-Gm-Message-State: APuU4Z84kz2b0dsX/P3mvb88FXjfITnsKklsAV+5VaPh5zxjkcEqw1pu
	nWHooY7cVOi/KS/wFZO4Jj7U4wqSgp4vDkwgXi/HPQuJCdG7XrtwTnWMGYxzB2TPHSf4UalPXhu
	9Do+GFv7aQVps1tLblpOETpXi+m2sysfSFgvbhRUt
X-Gm-Gg: AYBFou3etg35D7kARA7Yu8krhtArJXcgS/Alqlm1jUWT13QpzCAkGdDqDZ/xnZ+9OsS
	DuUlfG1vnSuIHUp8U6CYr7qtTdaRcWZ3P1BiMXjM4PU3HpGyuWPQlhDJZQZSAyGi8uSozo2gdf6
	FYiTkAMG9fhj8S9CsjmdgHufqh4jMK1EpITM+I60mXdS6C19vH8tXT3X91/wTsFfJbT0BjrJywK
	zMoWZch2pvuuR0Ofwf0K7x89aQX58GJdZP7DFCmbeiqrUeEAV+NJRmqDKKl1H8Qa7AsAVELJn6k
	O17llofq1/LicDzCQOOtVoX+GtkFPzrIungax39tD0TXJORJPIpoBr7ByM+YwjyVjJseZQNVIEB
	wypL+OmPZO/6m8UYfCPc2V6p/HQ2sXspJvlwo59C9tc7N3eHqJMHtQ8cTFyS+xkBggWTOFw1yHs
	x2Os0mgvkTRCd3/87bWtsrTSfsjuuKPI/XvcCMEUR9pwfQ7b9R
X-Received: by 2002:aa7:d695:0:b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6b4b42b05f8mr336525a12.15.1793631872289; Mon, 02 Nov 2026
 07:04:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102075441.3771550-1-edumazet@kernel.org> <CADVnQy=yWFLCMYyoTDUJBLciiM_N17H6DT4mvLq92N=ZC3UmkA@mail.gmail.com>
In-Reply-To: <CADVnQy=yWFLCMYyoTDUJBLciiM_N17H6DT4mvLq92N=ZC3UmkA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 2 Nov 2026 10:04:02 -0500
X-Gm-Features: AclHuK9R8aWAyx-fwq-p_dPdL8WMLhx277jmipmy0bCZe6IL_R7yaDRcp3mlRdI
Message-ID: <CADVnQy=vXuw5kQW7z3MbAB+NDk_qxvGy4yDNMnwzAFYWUws9wA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Anvik Loitongbam <permissiontogallop@gmail.com>, 
	Yingjie Wang <x-professor@outlook.com>
Content-Type: multipart/mixed; boundary="0000000000009c9f67065f4c762c"

--0000000000009c9f67065f4c762c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:47=E2=80=AFAM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Mon, Nov 2, 2026 at 2:54=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
> >
> > When IPV6_FL_F_REFLECT is set on a listener, or the
> > net.ipv6.flowlabel_reflect sysctl has FLOWLABEL_REFLECT_ESTABLISHED,
> > tcp_v6_send_synack() reflects the flowlabel of the SYN packet,
> > reading it from the skb stored in ireq->pktopts.
> >
> > Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
> > into ehash table"), request sockets are processed without holding
> > the listener lock. A cpu can then process a retransmitted SYN for a
> > request socket, and send a SYNACK from tcp_check_req(), while another
> > cpu receives the ACK completing the 3WHS. tcp_v6_syn_recv_sock()
> > consumes ireq->pktopts when it wins the hashdance, and the first cpu
> > reads a freed skb:
> >
> >   BUG: KASAN: slab-use-after-free in tcp_v6_send_synack (include/linux/=
skbuff.h:3152 include/linux/ipv6.h:110 net/ipv6/tcp_ipv6.c:582)
> >   Read of size 8 at addr ffff88802b08b608 by task poc-ipv6-pktopt/5076
> >
> >   Call Trace:
> >    <IRQ>
> >    tcp_v6_send_synack (include/linux/skbuff.h:3152 include/linux/ipv6.h=
:110 net/ipv6/tcp_ipv6.c:582)
> >    tcp_rtx_synack (net/ipv4/tcp_output.c:4719)
> >    tcp_check_req (net/ipv4/tcp_minisocks.c:762)
> >    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
> >    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
> >    ip6_input_finish (net/ipv6/ip6_input.c:534)
> >    ip6_input (include/linux/netfilter.h:325 include/linux/netfilter.h:3=
19 net/ipv6/ip6_input.c:545)
> >    ipv6_rcv (include/net/dst.h:481 net/ipv6/ip6_input.c:119 include/lin=
ux/netfilter.h:325 include/linux/netfilter.h:319 net/ipv6/ip6_input.c:351)
> >
> >   Freed by task 5074 on cpu 0 at 15.412249s:
> >    kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:=
6630 mm/slub.c:6757)
> >    tcp_v6_syn_recv_sock (net/ipv6/tcp_ipv6.c:1528)
> >    tcp_check_req (net/ipv4/tcp_minisocks.c:934)
> >    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
> >    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
> >    ip6_input_finish (net/ipv6/ip6_input.c:534)
> >
> > Request socket migration has the same issue: reqsk_migrate_reset()
> > transfers ireq->pktopts to the clone, which can be freed while
> > another cpu holding a reference on the old request socket is still
> > sending a SYNACK.
> >
> > The SYNACK timer itself is not an issue, because
> > inet_csk_reqsk_queue_drop() calls timer_delete_sync().
> >
> > Save the flowlabel of the SYN in the request socket instead, so that
> > tcp_v6_send_synack() no longer needs ireq->pktopts.
> >
> > As a side effect, the flowlabel is also reflected for SYN packets
> > reusing a TIME_WAIT socket, as ireq->pktopts is not set in this case.
> >
> > Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets"=
)
> > Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash ta=
ble")
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
> > Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
> > Reported-by: Yingjie Wang <x-professor@outlook.com>
> > Closes: https://lore.kernel.org/netdev/82c31e4d5043f3dbd11b44177cfba779=
d335aae3.1793599929.git.x-professor@outlook.com/
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > ---
> > Initially reported to security@ mailing list by Anvik Loitongbam, with =
a patch.
> > Anvik Loitongbam provided a reproducer.
> > I was able to trigger the ASAN warning before the patch, and checked
> > the warning can no longer trigger.
> >
> > Yingjie Wang also sent a public patch later, very similar to Anvik's on=
e.
> >
> >  include/linux/tcp.h | 3 +++
> >  net/ipv6/tcp_ipv6.c | 5 +++--
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index d18f7bc1e5d0f73c1c7452fbc573fa7cb38b206f..5a4c61fc240ec2d4554795c=
ea7bbd65bbea0ef02 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -179,6 +179,9 @@ struct tcp_request_sock {
> >         u8                              ao_rcv_next;
> >         bool                            used_tcp_ao;
> >  #endif
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +       __be32                          syn_flowlabel;
> > +#endif
> >  };
> >
> >  #define tcp_rsk(ptr) container_of_const(ptr, struct tcp_request_sock, =
req.req)
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index e006a30360eae1b43a4d53173b46b931ae668825..d406cd3c8ceabfdbb66f3e1=
b4f9e9a74754e8d0b 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -578,8 +578,8 @@ static int tcp_v6_send_synack(const struct sock *sk=
, struct dst_entry *dst,
> >                                     &ireq->ir_v6_rmt_addr);
> >
> >                 fl6->daddr =3D ireq->ir_v6_rmt_addr;
> > -               if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
> > -                       fl6->flowlabel =3D ip6_flowlabel(ipv6_hdr(ireq-=
>pktopts));
> > +               if (inet6_test_bit(REPFLOW, sk))
> > +                       fl6->flowlabel =3D tcp_rsk(req)->syn_flowlabel;
> >
> >                 tclass =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_refl=
ect_tos) ?
> >                                 (tcp_rsk(req)->syn_tos & ~INET_ECN_MASK=
) |
> > @@ -789,6 +789,7 @@ static void tcp_v6_init_req(struct request_sock *re=
q,
> >         ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
> >         ireq->ir_rmt_addr =3D LOOPBACK4_IPV6;
> >         ireq->ir_loc_addr =3D LOOPBACK4_IPV6;
> > +       tcp_rsk(req)->syn_flowlabel =3D ip6_flowlabel(ipv6_hdr(skb));
> >
> >         /* So that link locals have meaning */
> >         if ((!sk_listener->sk_bound_dev_if || l3_slave) &&
> > --
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>
>
> Thanks, Eric! The fix looks correct to me, and I ran it through two
> frontier LLMs, and they agreed that the fix was correct. They also
> suggested your follow-up change of:
>
> -            np->rxopt.bits.rxohlim || inet6_test_bit(REPFLOW, sk_listene=
r))) {
> +            np->rxopt.bits.rxohlim)) {
>
> So that follow-up looks good to me and the models.
>
> The models suggested two tweaks to the changelog. AFAICT their
> suggested changelog tweaks are correct, so I'm including them below
> for discussion and completeness, in case it is worth respinning the
> patches to update the changelog:
>
> (a) The changelog says: "The SYNACK timer itself is not an issue,
>     because inet_csk_reqsk_queue_drop() calls timer_delete_sync()."
>
>     This looks carried over from e3f33b0a1d89 ("ipv4: free inet_opt and
>     ireq_opt after an RCU grace period"). It is true there, because
>     ireq_opt is handed to the child, and the child cannot be freed
>     before timer_delete_sync().
>
>     It is not true for pktopts:
>     - tcp_v6_syn_recv_sock() frees pktopts immediately with
>       consume_skb() (tcp_ipv6.c:1528).
>     - tcp_check_req() calls ->syn_recv_sock() at tcp_minisocks.c:934.
>     - Only afterward does it reach inet_csk_complete_hashdance()
>       (tcp_minisocks.c:952), then inet_csk_reqsk_queue_drop(), then
>       timer_delete_sync() (inet_connection_sock.c:1016).
>     - The MPTCP rsk_drop_req() path has the same ordering.
>
>     So the timer path (reqsk_timer_handler() -> tcp_rtx_synack() ->
>     tcp_v6_send_synack()) running on another CPU races with that
>     consume_skb() just like the dup-SYN path. The patch fixes this too,
>     since pktopts is no longer read, but the sentence should
>     ideally be corrected. Suggested wording:
>
>       "The SYNACK timer has the same issue: tcp_v6_syn_recv_sock()
>        frees pktopts before inet_csk_complete_hashdance() reaches
>        timer_delete_sync()."
>
> (b) Missing side effect: after this commit, TFO SYN-ACKs will now
>     correctly carry the reflected flow label.
>     - With TFO, the child is created and pktopts consumed
>       (tcp_try_fastopen() -> tcp_fastopen_create_child() ->
>       tcp_v6_syn_recv_sock()) *before* tcp_conn_request() sends the TFO
>       SYN-ACK.
>     - So today, TFO SYN-ACKs, including retransmits from
>       tcp_fastopen_synack_timer(), never reflect the label.
>     The new behavior is the correct one. But it changes what
>     goes on the wire, so it would be good to add
>     a sentence next to the TIME_WAIT note.

I had an LLM write packetdrill tests to verify that TFO SYNACK flow
label reflection is broken before this patch and fixed after this
patch. I've attached the packetdrill scripts and packetdrill
enhancements to support them, in case it's useful. I can merge the
packetdrill enhancement patches and send the packetdrill self tests to
the list if there's consensus that this is useful.


neal

--0000000000009c9f67065f4c762c
Content-Type: application/x-patch; 
	name="linux-0001-selftests-net-packetdrill-add-TFO-IPv6-flow-label-reflection-tests.patch"
Content-Disposition: attachment; 
	filename="linux-0001-selftests-net-packetdrill-add-TFO-IPv6-flow-label-reflection-tests.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvze0v0d0>
X-Attachment-Id: f_mvze0v0d0

RnJvbSBlZDg1MDZiNjg1MTlkNWFkYTFiYjVlMjM1YTE3NWQ1NGNhNDEwYWFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4K
RGF0ZTogTW9uLCAyIE5vdiAyMDI2IDA2OjE5OjA4IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Vs
ZnRlc3RzL25ldDogcGFja2V0ZHJpbGw6IGFkZCBURk8gSVB2NiBmbG93IGxhYmVsCiByZWZsZWN0
aW9uIHRlc3RzCgpBZGQgdHdvIHBhY2tldGRyaWxsIHRlc3RzIGNoZWNraW5nIHRoYXQgYSBUQ1Ag
RmFzdCBPcGVuIHNlcnZlciByZWZsZWN0cwp0aGUgZmxvdyBsYWJlbCBvZiB0aGUgU1lOIGluIGl0
cyBTWU4tQUNLLCBhbmQgaW4gU1lOLUFDSyByZXRyYW5zbWl0cywKd2hlbiBmbG93IGxhYmVsIHJl
ZmxlY3Rpb24gaXMgZW5hYmxlZCBlaXRoZXI6CgogLSB3aXRoIElQVjZfRkxfRl9SRUZMRUNUIHNl
dCBvbiB0aGUgbGlzdGVuZXIgd2l0aCBJUFY2X0ZMT1dMQUJFTF9NR1IKICAgKHRjcF9mYXN0b3Bl
bl9zZXJ2ZXJfaXB2Ni1mbG93bGFiZWwtcmVmbGVjdC1zb2Nrb3B0LnBrdCksIG9yCgogLSB3aXRo
IEZMT1dMQUJFTF9SRUZMRUNUX0VTVEFCTElTSEVEIGluIHRoZSBuZXQuaXB2Ni5mbG93bGFiZWxf
cmVmbGVjdAogICBzeXNjdGwgKHRjcF9mYXN0b3Blbl9zZXJ2ZXJfaXB2Ni1mbG93bGFiZWwtcmVm
bGVjdC1zeXNjdGwucGt0KS4KCldpdGggVEZPLCB0Y3BfZmFzdG9wZW5fY3JlYXRlX2NoaWxkKCkg
LT4gdGNwX3Y2X3N5bl9yZWN2X3NvY2soKQpjb25zdW1lcyBpcmVxLT5wa3RvcHRzIGJlZm9yZSB0
Y3BfY29ubl9yZXF1ZXN0KCkgc2VuZHMgdGhlIFNZTi1BQ0suClNvLCBiZWZvcmUgY29tbWl0ICJ0
Y3A6IGlwdjY6IGRvIG5vdCByZWFkIGlyZXEtPnBrdG9wdHMgZnJvbQp0Y3BfdjZfc2VuZF9zeW5h
Y2soKSIsIHRjcF92Nl9zZW5kX3N5bmFjaygpIGRpZCBub3QgcmVmbGVjdCB0aGUgZmxvdwpsYWJl
bCBpbiBURk8gU1lOLUFDS3MsIGFuZCB0aGVzZSB0ZXN0cyBmYWlsLiBUaGV5IHBhc3Mgd2l0aCB0
aGF0IGNvbW1pdC4KClRoZSB0ZXN0cyBkaXNhYmxlIGF1dG8gZmxvdyBsYWJlbHMsIHNvIHRoYXQg
YSBTWU4tQUNLIHRoYXQgZG9lcyBub3QKcmVmbGVjdCB0aGUgZmxvdyBsYWJlbCBjYXJyaWVzIGZs
b3cgbGFiZWwgMCByYXRoZXIgdGhhbiBhIHJhbmRvbSBvbmUuCgpUaGUgdGVzdHMgbmVlZCBwYWNr
ZXRkcmlsbCBzdXBwb3J0IGZvciBleGFjdCBmbG93IGxhYmVsIGNoZWNrcwooImZsb3dsYWJlbF9l
eGFjdCIpIGFuZCBmb3IgdGhlIElQVjZfRkxPV0xBQkVMX01HUiBzb2NrZXQgb3B0aW9uLgoKVGhp
cyBwYXRjaCB3YXMgZGV2ZWxvcGVkIHdpdGggdGhlIGhlbHAgb2YgYW4gQUkgY29kaW5nIGFzc2lz
dGFudC4KCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI2MTEwMjA3NTQ0
MS4zNzcxNTUwLTEtZWR1bWF6ZXRAa2VybmVsLm9yZy8KLS0tCiAuLi5fc2VydmVyX2lwdjYtZmxv
d2xhYmVsLXJlZmxlY3Qtc29ja29wdC5wa3QgfCAzOSArKysrKysrKysrKysrKysrKysrCiAuLi5u
X3NlcnZlcl9pcHY2LWZsb3dsYWJlbC1yZWZsZWN0LXN5c2N0bC5wa3QgfCAzOCArKysrKysrKysr
KysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wYWNrZXRkcmlsbC90Y3BfZmFzdG9w
ZW5fc2VydmVyX2lwdjYtZmxvd2xhYmVsLXJlZmxlY3Qtc29ja29wdC5wa3QKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvdGNwX2Zhc3Rv
cGVuX3NlcnZlcl9pcHY2LWZsb3dsYWJlbC1yZWZsZWN0LXN5c2N0bC5wa3QKCmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvdGNwX2Zhc3RvcGVuX3Nl
cnZlcl9pcHY2LWZsb3dsYWJlbC1yZWZsZWN0LXNvY2tvcHQucGt0IGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbmV0L3BhY2tldGRyaWxsL3RjcF9mYXN0b3Blbl9zZXJ2ZXJfaXB2Ni1mbG93bGFi
ZWwtcmVmbGVjdC1zb2Nrb3B0LnBrdApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
MDAuLjRhODFkYTA2NQotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L25ldC9wYWNrZXRkcmlsbC90Y3BfZmFzdG9wZW5fc2VydmVyX2lwdjYtZmxvd2xhYmVsLXJlZmxl
Y3Qtc29ja29wdC5wa3QKQEAgLTAsMCArMSwzOSBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAKKy8vCisvLyBUZXN0IHRoYXQgYSBURk8gc2VydmVyIHJlZmxlY3RzIHRoZSBm
bG93IGxhYmVsIG9mIHRoZSBTWU4gaW4gaXRzCisvLyBTWU4tQUNLLCBhbmQgaW4gU1lOLUFDSyBy
ZXRyYW5zbWl0cywgd2hlbiBJUFY2X0ZMX0ZfUkVGTEVDVCBpcyBzZXQKKy8vIG9uIHRoZSBsaXN0
ZW5lci4KKy8vCisvLyBXaXRoIFRGTywgdGhlIGNoaWxkIHNvY2tldCBpcyBjcmVhdGVkIGJlZm9y
ZSB0aGUgU1lOLUFDSyBpcyBzZW50LgorCistLWlwX3ZlcnNpb249aXB2NgorCisvLyBJUFY2X0ZM
X0ZfUkVGTEVDVCByZXF1aXJlcyBmbG93bGFiZWxfY29uc2lzdGVuY3k9MC4KKy8vIERpc2FibGUg
YXV0byBmbG93IGxhYmVscyBzbyB0aGF0IGEgU1lOLUFDSyB0aGF0IGRvZXMgbm90IHJlZmxlY3Qg
dGhlCisvLyBmbG93IGxhYmVsIG9mIHRoZSBTWU4gY2FycmllcyBmbG93IGxhYmVsIDAuCitgLi9k
ZWZhdWx0cy5zaAorc3lzY3RsIC1xIG5ldC5pcHY0LnRjcF9mYXN0b3Blbj0weDIwMgorc3lzY3Rs
IC1xIG5ldC5pcHY2LmZsb3dsYWJlbF9jb25zaXN0ZW5jeT0wCitzeXNjdGwgLXEgbmV0LmlwdjYu
YXV0b19mbG93bGFiZWxzPTBgCisKKyAgICAwIHNvY2tldCguLi4sIFNPQ0tfU1RSRUFNfFNPQ0tf
Tk9OQkxPQ0ssIElQUFJPVE9fVENQKSA9IDMKKyAgICswIHNldHNvY2tvcHQoMywgU09MX1NPQ0tF
VCwgU09fUkVVU0VBRERSLCBbMV0sIDQpID0gMAorICAgKzAgc2V0c29ja29wdCgzLCBTT0xfSVBW
NiwgSVBWNl9GTE9XTEFCRUxfTUdSLCB7ZmxyX2xhYmVsPTAsIGZscl9hY3Rpb249SVBWNl9GTF9B
X0dFVCwgZmxyX3NoYXJlPUlQVjZfRkxfU19OT05FLCBmbHJfZmxhZ3M9SVBWNl9GTF9GX1JFRkxF
Q1QsIGZscl9leHBpcmVzPTAsIGZscl9saW5nZXI9MH0sIDMyKSA9IDAKKyAgICswIGJpbmQoMywg
Li4uLCAuLi4pID0gMAorICAgKzAgbGlzdGVuKDMsIDEpID0gMAorICAgKzAgc2V0c29ja29wdCgz
LCBTT0xfVENQLCBUQ1BfRkFTVE9QRU4sIFsxXSwgNCkgPSAwCisKKy8vIFRGT19TRVJWRVJfQ09P
S0lFX05PVF9SRVFEOiBhIFNZTiB3aXRoIGRhdGEgY3JlYXRlcyBhIFRGTyBjaGlsZC4KKy8vIFRo
ZSBTWU4tQUNLIG11c3QgY2FycnkgdGhlIGZsb3cgbGFiZWwgb2YgdGhlIFNZTi4KKyAgICswIDwg
KGZsb3dsYWJlbCAweDEyMzQ1KSBTIDA6MTAwMCgxMDAwKSB3aW4gMzI3OTIgPG1zcyAxNDYwLHNh
Y2tPSyxub3Asbm9wPgorICAgKzAgPiAoZmxvd2xhYmVsX2V4YWN0IDB4MTIzNDUpIFMuIDA6MCgw
KSBhY2sgMTAwMSA8bXNzIDE0NjAsbm9wLG5vcCxzYWNrT0s+CisgICArMCBhY2NlcHQoMywgLi4u
LCAuLi4pID0gNAorICAgKzAgJXsgYXNzZXJ0ICh0Y3BpX29wdGlvbnMgJiBUQ1BJX09QVF9TWU5f
REFUQSkgIT0gMCwgdGNwaV9vcHRpb25zIH0lCisgICArMCByZWFkKDQsIC4uLiwgMTAyNCkgPSAx
MDAwCisKKy8vIFRoZSBTWU4tQUNLIGlzIGxvc3QuIFRoZSByZXRyYW5zbWl0dGVkIFNZTi1BQ0sg
bXVzdCBhbHNvIGNhcnJ5IHRoZQorLy8gZmxvdyBsYWJlbCBvZiB0aGUgU1lOLgorICAgKzEgPiAo
Zmxvd2xhYmVsX2V4YWN0IDB4MTIzNDUpIFMuIDA6MCgwKSBhY2sgMTAwMSA8bXNzIDE0NjAsbm9w
LG5vcCxzYWNrT0s+CisKKy8vIENvbXBsZXRlIHRoZSBoYW5kc2hha2UuCisgKy4wMSA8IChmbG93
bGFiZWwgMHgxMjM0NSkgLiAxMDAxOjEwMDEoMCkgYWNrIDEgd2luIDU4NDAKZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wYWNrZXRkcmlsbC90Y3BfZmFzdG9wZW5fc2Vy
dmVyX2lwdjYtZmxvd2xhYmVsLXJlZmxlY3Qtc3lzY3RsLnBrdCBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL25ldC9wYWNrZXRkcmlsbC90Y3BfZmFzdG9wZW5fc2VydmVyX2lwdjYtZmxvd2xhYmVs
LXJlZmxlY3Qtc3lzY3RsLnBrdApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAu
LmU3MDZiMjI1YwotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25l
dC9wYWNrZXRkcmlsbC90Y3BfZmFzdG9wZW5fc2VydmVyX2lwdjYtZmxvd2xhYmVsLXJlZmxlY3Qt
c3lzY3RsLnBrdApAQCAtMCwwICsxLDM4IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMAorLy8KKy8vIFRlc3QgdGhhdCBhIFRGTyBzZXJ2ZXIgcmVmbGVjdHMgdGhlIGZsb3cg
bGFiZWwgb2YgdGhlIFNZTiBpbiBpdHMKKy8vIFNZTi1BQ0ssIGFuZCBpbiBTWU4tQUNLIHJldHJh
bnNtaXRzLCB3aGVuIHRoZSBuZXQuaXB2Ni5mbG93bGFiZWxfcmVmbGVjdAorLy8gc3lzY3RsIGhh
cyBGTE9XTEFCRUxfUkVGTEVDVF9FU1RBQkxJU0hFRCAoMSkuCisvLworLy8gV2l0aCBURk8sIHRo
ZSBjaGlsZCBzb2NrZXQgaXMgY3JlYXRlZCBiZWZvcmUgdGhlIFNZTi1BQ0sgaXMgc2VudC4KKwor
LS1pcF92ZXJzaW9uPWlwdjYKKworLy8gRkxPV0xBQkVMX1JFRkxFQ1RfRVNUQUJMSVNIRUQgYXBw
bGllcyB0byBzb2NrZXRzIGNyZWF0ZWQgYWZ0ZXIgaXQgaXMgc2V0LgorLy8gRGlzYWJsZSBhdXRv
IGZsb3cgbGFiZWxzIHNvIHRoYXQgYSBTWU4tQUNLIHRoYXQgZG9lcyBub3QgcmVmbGVjdCB0aGUK
Ky8vIGZsb3cgbGFiZWwgb2YgdGhlIFNZTiBjYXJyaWVzIGZsb3cgbGFiZWwgMC4KK2AuL2RlZmF1
bHRzLnNoCitzeXNjdGwgLXEgbmV0LmlwdjQudGNwX2Zhc3RvcGVuPTB4MjAyCitzeXNjdGwgLXEg
bmV0LmlwdjYuZmxvd2xhYmVsX3JlZmxlY3Q9MQorc3lzY3RsIC1xIG5ldC5pcHY2LmF1dG9fZmxv
d2xhYmVscz0wYAorCisgICAgMCBzb2NrZXQoLi4uLCBTT0NLX1NUUkVBTXxTT0NLX05PTkJMT0NL
LCBJUFBST1RPX1RDUCkgPSAzCisgICArMCBzZXRzb2Nrb3B0KDMsIFNPTF9TT0NLRVQsIFNPX1JF
VVNFQUREUiwgWzFdLCA0KSA9IDAKKyAgICswIGJpbmQoMywgLi4uLCAuLi4pID0gMAorICAgKzAg
bGlzdGVuKDMsIDEpID0gMAorICAgKzAgc2V0c29ja29wdCgzLCBTT0xfVENQLCBUQ1BfRkFTVE9Q
RU4sIFsxXSwgNCkgPSAwCisKKy8vIFRGT19TRVJWRVJfQ09PS0lFX05PVF9SRVFEOiBhIFNZTiB3
aXRoIGRhdGEgY3JlYXRlcyBhIFRGTyBjaGlsZC4KKy8vIFRoZSBTWU4tQUNLIG11c3QgY2Fycnkg
dGhlIGZsb3cgbGFiZWwgb2YgdGhlIFNZTi4KKyAgICswIDwgKGZsb3dsYWJlbCAweDEyMzQ1KSBT
IDA6MTAwMCgxMDAwKSB3aW4gMzI3OTIgPG1zcyAxNDYwLHNhY2tPSyxub3Asbm9wPgorICAgKzAg
PiAoZmxvd2xhYmVsX2V4YWN0IDB4MTIzNDUpIFMuIDA6MCgwKSBhY2sgMTAwMSA8bXNzIDE0NjAs
bm9wLG5vcCxzYWNrT0s+CisgICArMCBhY2NlcHQoMywgLi4uLCAuLi4pID0gNAorICAgKzAgJXsg
YXNzZXJ0ICh0Y3BpX29wdGlvbnMgJiBUQ1BJX09QVF9TWU5fREFUQSkgIT0gMCwgdGNwaV9vcHRp
b25zIH0lCisgICArMCByZWFkKDQsIC4uLiwgMTAyNCkgPSAxMDAwCisKKy8vIFRoZSBTWU4tQUNL
IGlzIGxvc3QuIFRoZSByZXRyYW5zbWl0dGVkIFNZTi1BQ0sgbXVzdCBhbHNvIGNhcnJ5IHRoZQor
Ly8gZmxvdyBsYWJlbCBvZiB0aGUgU1lOLgorICAgKzEgPiAoZmxvd2xhYmVsX2V4YWN0IDB4MTIz
NDUpIFMuIDA6MCgwKSBhY2sgMTAwMSA8bXNzIDE0NjAsbm9wLG5vcCxzYWNrT0s+CisKKy8vIENv
bXBsZXRlIHRoZSBoYW5kc2hha2UuCisgKy4wMSA8IChmbG93bGFiZWwgMHgxMjM0NSkgLiAxMDAx
OjEwMDEoMCkgYWNrIDEgd2luIDU4NDAKLS0gCjIuNTYuMC4zOTguZzg4MmNiYWQyNzUtZ29vZwoK
--0000000000009c9f67065f4c762c
Content-Type: application/x-patch; 
	name="packetdrill-0001-support-exact-IPv6-flow-label-checks.patch"
Content-Disposition: attachment; 
	filename="packetdrill-0001-support-exact-IPv6-flow-label-checks.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvze11301>
X-Attachment-Id: f_mvze11301

RnJvbSA3ZjZlNGQxZjI0OGQzYWQyNjk0NzIzNDMzMGMwMzg3OGJjNjI0N2RkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4K
RGF0ZTogTW9uLCAyIE5vdiAyMDI2IDA2OjE5OjQ2IC0wODAwClN1YmplY3Q6IFtQQVRDSCAxLzJd
IG5ldC10ZXN0OiBwYWNrZXRkcmlsbDogc3VwcG9ydCBleGFjdCBJUHY2IGZsb3cgbGFiZWwKIGNo
ZWNrcwoKVG9kYXkgYSBmbG93IGxhYmVsIG9uIGFuIG91dGJvdW5kIElQdjYgcGFja2V0IGluIGEg
c2NyaXB0IGlzIG9ubHkKY2hlY2tlZCBmb3IgY29uc2lzdGVuY3k6IHRoZSBmaXJzdCBvdXRib3Vu
ZCBwYWNrZXQgd2l0aCBhIGdpdmVuIHNjcmlwdApmbG93IGxhYmVsIHJlY29yZHMgd2hpY2ggbGl2
ZSBmbG93IGxhYmVsIGl0IG1hcHMgdG8sIGFuZCBsYXRlciBwYWNrZXRzCm11c3QgdXNlIHRoZSBz
YW1lIChvciwgZm9yIGEgZGlmZmVyZW50IHNjcmlwdCBsYWJlbCwgYSBkaWZmZXJlbnQpIGxpdmUK
bGFiZWwuIFRoaXMgaXMgdXNlZnVsIGZvciBhdXRvLWdlbmVyYXRlZCBmbG93IGxhYmVscywgd2hv
c2UgdmFsdWVzIGFyZQpub3QgcHJlZGljdGFibGUsIGJ1dCBpdCBjYW5ub3QgY2hlY2sgdGhhdCB0
aGUga2VybmVsIHNlbmRzIGEgc3BlY2lmaWMKZmxvdyBsYWJlbCwgZS5nLiB3aGVuIGl0IHJlZmxl
Y3RzIHRoZSBmbG93IGxhYmVsIG9mIGFuIGluY29taW5nIHBhY2tldAooSVBWNl9GTF9GX1JFRkxF
Q1QsIG9yIHRoZSBuZXQuaXB2Ni5mbG93bGFiZWxfcmVmbGVjdCBzeXNjdGwpLgoKQWRkIGEgImZs
b3dsYWJlbF9leGFjdCA8aGV4PiIgSVAgaW5mbyBvcHRpb24uIEZvciBhbiBvdXRib3VuZCBwYWNr
ZXQsCnRoZSBsaXZlIGZsb3cgbGFiZWwgbXVzdCBiZSBleGFjdGx5IHRoZSBnaXZlbiB2YWx1ZSwg
ZS5nLjoKCiAgKzAgPCAoZmxvd2xhYmVsIDB4MTIzNDUpIFMgMDowKDApIHdpbiAzMjc5MiA8bXNz
IDE0NjA+CiAgKzAgPiAoZmxvd2xhYmVsX2V4YWN0IDB4MTIzNDUpIFMuIDA6MCgwKSBhY2sgMSA8
bXNzIDE0NjA+CgpGb3IgYW4gaW5ib3VuZCBwYWNrZXQsICJmbG93bGFiZWxfZXhhY3QiIGlzIHRo
ZSBzYW1lIGFzICJmbG93bGFiZWwiLgpUaGUgZXhpc3RpbmcgImZsb3dsYWJlbCA8aGV4PiIgYmVo
YXZpb3IgaXMgdW5jaGFuZ2VkLgoKVGhpcyBwYXRjaCB3YXMgZGV2ZWxvcGVkIHdpdGggdGhlIGhl
bHAgb2YgYW4gQUkgY29kaW5nIGFzc2lzdGFudC4KLS0tCiBndGVzdHMvbmV0L3BhY2tldGRyaWxs
L2ljbXBfcGFja2V0LmMgfCAgMiArKwogZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9sZXhlci5sICAg
ICAgIHwgIDEgKwogZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9wYWNrZXQuaCAgICAgIHwgIDEgKwog
Z3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9wYXJzZXIueSAgICAgIHwgNDYgKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLQogZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9ydW5fcGFja2V0LmMgIHwgMTIg
KysrKysrKysKIGd0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvdGNwX3BhY2tldC5jICB8ICAyICsrCiBn
dGVzdHMvbmV0L3BhY2tldGRyaWxsL3R5cGVzLmggICAgICAgfCAgMSArCiBndGVzdHMvbmV0L3Bh
Y2tldGRyaWxsL3VkcF9wYWNrZXQuYyAgfCAgMiArKwogOCBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2d0ZXN0cy9uZXQvcGFja2V0
ZHJpbGwvaWNtcF9wYWNrZXQuYyBiL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvaWNtcF9wYWNrZXQu
YwppbmRleCA2ZGM1ZjliLi4xNzA4OWZkIDEwMDY0NAotLS0gYS9ndGVzdHMvbmV0L3BhY2tldGRy
aWxsL2ljbXBfcGFja2V0LmMKKysrIGIvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9pY21wX3BhY2tl
dC5jCkBAIC0zNjEsNiArMzYxLDggQEAgc3RydWN0IHBhY2tldCAqbmV3X2ljbXBfcGFja2V0KGlu
dCBhZGRyZXNzX2ZhbWlseSwKIAlwYWNrZXQtPmRpcmVjdGlvbiA9IGRpcmVjdGlvbjsKIAlwYWNr
ZXQtPmZsYWdzID0gMDsKIAlwYWNrZXQtPnRvc19jaGsgPSBpcF9pbmZvLnRvcy5jaGVjazsKKwlp
ZiAoaXBfaW5mby5mbG93X2xhYmVsX2V4YWN0KQorCQlwYWNrZXQtPmZsYWdzIHw9IEZMQUdfRkxP
V0xBQkVMX0VYQUNUOwogCiAJLyogU2V0IElQIGhlYWRlciBmaWVsZHMgKi8KIAlzZXRfcGFja2V0
X2lwX2hlYWRlcihwYWNrZXQsIGFkZHJlc3NfZmFtaWx5LCBpcF9ieXRlcywgaXBfaW5mby50b3Mu
dmFsdWUsCmRpZmYgLS1naXQgYS9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL2xleGVyLmwgYi9ndGVz
dHMvbmV0L3BhY2tldGRyaWxsL2xleGVyLmwKaW5kZXggNjNlNzBlZS4uZjY5YjM3MiAxMDA2NDQK
LS0tIGEvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9sZXhlci5sCisrKyBiL2d0ZXN0cy9uZXQvcGFj
a2V0ZHJpbGwvbGV4ZXIubApAQCAtMjY3LDYgKzI2Nyw3IEBAIGUxYgkJCXJldHVybiBBQ0NFQ05f
RTFCOwogY2ViCQkJcmV0dXJuIEFDQ0VDTl9DRUI7CiB0b3MJCQlyZXR1cm4gVE9TOwogZmxvd2xh
YmVsCQlyZXR1cm4gRkxPV0xBQkVMOworZmxvd2xhYmVsX2V4YWN0CQlyZXR1cm4gRkxPV0xBQkVM
X0VYQUNUOwogZmxhZ3MJCQlyZXR1cm4gRkxBR1M7CiBGbGFncwkJCXJldHVybiBGTEFHUzsKIHZh
bAkJCXJldHVybiBWQUw7CmRpZmYgLS1naXQgYS9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3BhY2tl
dC5oIGIvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9wYWNrZXQuaAppbmRleCA4NzQzOWFkLi42ZmRj
ZGQ2IDEwMDY0NAotLS0gYS9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3BhY2tldC5oCisrKyBiL2d0
ZXN0cy9uZXQvcGFja2V0ZHJpbGwvcGFja2V0LmgKQEAgLTEwOCw2ICsxMDgsNyBAQCBzdHJ1Y3Qg
cGFja2V0IHsKICNkZWZpbmUgRkxBR19XSU5fTk9DSEVDSwkweDEgIC8qIGRvbid0IGNoZWNrIFRD
UCByZWNlaXZlIHdpbmRvdyAqLwogI2RlZmluZSBGTEFHX09QVElPTlNfTk9DSEVDSwkweDIgIC8q
IGRvbid0IGNoZWNrIFRDUCBvcHRpb25zICovCiAjZGVmaW5lIEZMQUdfUEFSU0VfQUNFCQkweDQw
MCAvKiBvdXRwdXQgcGFyc2VkIEFjY0VDTiBBQ0UgZmllbGQgKi8KKyNkZWZpbmUgRkxBR19GTE9X
TEFCRUxfRVhBQ1QJMHg4MDAgLyogY2hlY2sgSVB2NiBmbG93IGxhYmVsIGV4YWN0bHkgKi8KIAog
CWVudW0gdG9zX2Noa190IHRvc19jaGs7CS8qIGhvdyB0byB0cmVhdCB0aGUgVE9TIGJ5dGUgb2Yg
YSBwYWNrZXQgKi8KIApkaWZmIC0tZ2l0IGEvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9wYXJzZXIu
eSBiL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvcGFyc2VyLnkKaW5kZXggZTYyNDhmYi4uMDM1ZDli
YSAxMDA2NDQKLS0tIGEvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9wYXJzZXIueQorKysgYi9ndGVz
dHMvbmV0L3BhY2tldGRyaWxsL3BhcnNlci55CkBAIC01ODYsNyArNTg2LDcgQEAgc3RhdGljIHN0
cnVjdCBwYWNrZXQgKmFwcGVuZF9ncmUoc3RydWN0IHBhY2tldCAqcGFja2V0LCBzdHJ1Y3QgZXhw
cmVzc2lvbiAqZXhwcikKICV0b2tlbiA8cmVzZXJ2ZWQ+IEFDSyBFQ1IgRU9MIE1TUyBOT1AgU0FD
SyBTQUNLT0sgVElNRVNUQU1QIFZBTCBXSU4gV1NDQUxFCiAldG9rZW4gPHJlc2VydmVkPiBVUkcg
TUQ1IEZBU1RfT1BFTiBGQVNUX09QRU5fRVhQIEFDQ0VDTgogJXRva2VuIDxyZXNlcnZlZD4gQUND
RUNOX0UwQiBBQ0NFQ05fRTFCIEFDQ0VDTl9DRUIKLSV0b2tlbiA8cmVzZXJ2ZWQ+IFRPUyBGTEFH
UyBGTE9XTEFCRUwKKyV0b2tlbiA8cmVzZXJ2ZWQ+IFRPUyBGTEFHUyBGTE9XTEFCRUwgRkxPV0xB
QkVMX0VYQUNUCiAldG9rZW4gPHJlc2VydmVkPiBFQ1QwIEVDVDEgQ0UgRUNUMDEgTk9fRUNOCiAl
dG9rZW4gPHJlc2VydmVkPiBJUFY0IElQVjYgSUNNUCBVRFAgUkFXIEdSRSBNVFUgSUQKICV0b2tl
biA8cmVzZXJ2ZWQ+IE1QTFMgTEFCRUwgVEMgVFRMCkBAIC02MTgsNyArNjE4LDggQEAgc3RhdGlj
IHN0cnVjdCBwYWNrZXQgKmFwcGVuZF9ncmUoc3RydWN0IHBhY2tldCAqcGFja2V0LCBzdHJ1Y3Qg
ZXhwcmVzc2lvbiAqZXhwcikKICV0eXBlIDxpbnRlZ2VyPiBncmVfZmxhZ3NfbGlzdCBncmVfZmxh
Z3MgZ3JlX2ZsYWcKICV0eXBlIDxpbnRlZ2VyPiBncmVfc3VtIGdyZV9vZmYgZ3JlX2tleSBncmVf
c2VxCiAldHlwZSA8aW50ZWdlcj4gb3B0X2ljbXBfZWNob19pZAotJXR5cGUgPGludGVnZXI+IGZs
b3dfbGFiZWwKKyV0eXBlIDxpbnRlZ2VyPiBmbG93X2xhYmVsIGZsb3dfbGFiZWxfdmFsdWUKKyV0
eXBlIDxpcF9pbmZvPiBmbG93X2xhYmVsX3NwZWMKICV0eXBlIDxpbnRlZ2VyPiBhY2NlY25fdmFs
CiAldHlwZSA8aW50ZWdlcj4gcHNwX3NwaQogJXR5cGUgPHN0cmluZz4gaWNtcF90eXBlIG9wdF9p
Y21wX2NvZGUgb3B0X2Fja19mbGFnIG9wdF93b3JkIGFja19hbmRfYWNlIGZsYWdzCkBAIC0xMjA1
LDkgKzEyMDYsOSBAQCBmbGFncwogfCAnLScgICAgICAgICAgeyAkJCA9IHN0cmR1cCgiIik7IH0g
IC8qIG5vIFRDUCBmbGFncyBzZXQgaW4gc2VnbWVudCAqLwogOwogCi1mbG93X2xhYmVsCi06IEZM
T1dMQUJFTCBIRVhfSU5URUdFUiB7Ci0JczY0IGZsb3dsYWJlbCA9ICQyOworZmxvd19sYWJlbF92
YWx1ZQorOiBIRVhfSU5URUdFUiB7CisJczY0IGZsb3dsYWJlbCA9ICQxOwogCiAJaWYgKCFpc192
YWxpZF91MjAoZmxvd2xhYmVsKSkgewogCQlzZW1hbnRpY19lcnJvcigiZmxvd2xhYmVsIG91dCBv
ZiByYW5nZSBmb3IgMjAgYml0cyIpOwpAQCAtMTIxNiwyOSArMTIxNyw1NSBAQCBmbG93X2xhYmVs
CiB9CiA7CiAKK2Zsb3dfbGFiZWwKKzogRkxPV0xBQkVMIGZsb3dfbGFiZWxfdmFsdWUJeyAkJCA9
ICQyOyB9Cis7CisKKy8qICJmbG93bGFiZWwgPGhleD4iOiBmb3IgYW4gb3V0Ym91bmQgcGFja2V0
LCB0aGUgZmxvdyBsYWJlbCBtdXN0IGJlCisgKiBjb25zaXN0ZW50IHdpdGggdGhlIGZsb3cgbGFi
ZWxzIG9mIHByZXZpb3VzIHBhY2tldHMgb2YgdGhlIGZsb3cKKyAqIChsYWJlbHMgbWF5IGJlIGF1
dG8tZ2VuZXJhdGVkLCBzbyBvbmx5IGNvbnNpc3RlbmN5IGlzIGNoZWNrZWQpLgorICogImZsb3ds
YWJlbF9leGFjdCA8aGV4PiI6IGZvciBhbiBvdXRib3VuZCBwYWNrZXQsIHRoZSBsaXZlIGZsb3cg
bGFiZWwKKyAqIG11c3QgYmUgZXhhY3RseSB0aGUgZ2l2ZW4gdmFsdWUgKGUuZy4gdG8gY2hlY2sg
ZmxvdyBsYWJlbCByZWZsZWN0aW9uKS4KKyAqIEluYm91bmQgcGFja2V0cyBjYXJyeSB0aGUgZ2l2
ZW4gZmxvdyBsYWJlbCBpbiBib3RoIGNhc2VzLgorICovCitmbG93X2xhYmVsX3NwZWMKKzogZmxv
d19sYWJlbCB7CisJJCQuZmxvd19sYWJlbCA9ICQxOworCSQkLmZsb3dfbGFiZWxfZXhhY3QgPSBm
YWxzZTsKK30KK3wgRkxPV0xBQkVMX0VYQUNUIGZsb3dfbGFiZWxfdmFsdWUgeworCSQkLmZsb3df
bGFiZWwgPSAkMjsKKwkkJC5mbG93X2xhYmVsX2V4YWN0ID0gdHJ1ZTsKK30KKzsKKwogaXBfaW5m
bwogOiB0b3Nfc3BlYwl7CiAJJCQudG9zLmNoZWNrID0gJDEuY2hlY2s7CiAJJCQudG9zLnZhbHVl
ID0gJDEudmFsdWU7CiAJJCQuZmxvd19sYWJlbCA9IDA7CisJJCQuZmxvd19sYWJlbF9leGFjdCA9
IGZhbHNlOwogCSQkLnR0bCA9IDA7CiB9Ci18IGZsb3dfbGFiZWwJeworfCBmbG93X2xhYmVsX3Nw
ZWMJewogCSQkLnRvcy5jaGVjayA9IFRPU19DSEVDS19OT05FOwogCSQkLnRvcy52YWx1ZSA9IDA7
Ci0JJCQuZmxvd19sYWJlbCA9ICQxOworCSQkLmZsb3dfbGFiZWwgPSAkMS5mbG93X2xhYmVsOwor
CSQkLmZsb3dfbGFiZWxfZXhhY3QgPSAkMS5mbG93X2xhYmVsX2V4YWN0OwogCSQkLnR0bCA9IDA7
CiB9CiB8IFRUTCBJTlRFR0VSIHsKIAkkJC50b3MuY2hlY2sgPSBUT1NfQ0hFQ0tfTk9ORTsKIAkk
JC50b3MudmFsdWUgPSAwOwogCSQkLmZsb3dfbGFiZWwgPSAwOworCSQkLmZsb3dfbGFiZWxfZXhh
Y3QgPSBmYWxzZTsKIAkkJC50dGwgPSAkMjsKIH0KLXwgdG9zX3NwZWMgJywnIGZsb3dfbGFiZWwg
eworfCB0b3Nfc3BlYyAnLCcgZmxvd19sYWJlbF9zcGVjIHsKIAkkJC50b3MuY2hlY2sgPSAkMS5j
aGVjazsKIAkkJC50b3MudmFsdWUgPSAkMS52YWx1ZTsKLQkkJC5mbG93X2xhYmVsID0gJDM7CisJ
JCQuZmxvd19sYWJlbCA9ICQzLmZsb3dfbGFiZWw7CisJJCQuZmxvd19sYWJlbF9leGFjdCA9ICQz
LmZsb3dfbGFiZWxfZXhhY3Q7CiAJJCQudHRsID0gMDsKIH0KIDsKQEAgLTEyNDgsNiArMTI3NSw3
IEBAIG9wdF9pcF9pbmZvCiAJJCQudG9zLmNoZWNrID0gVE9TX0NIRUNLX05PTkU7CiAJJCQudG9z
LnZhbHVlID0gMDsKIAkkJC5mbG93X2xhYmVsID0gMDsKKwkkJC5mbG93X2xhYmVsX2V4YWN0ID0g
ZmFsc2U7CiAJJCQudHRsID0gMDsKIH0KIHwgJygnIGlwX2luZm8gJyknCXsgJCQgPSAkMjsgfQpk
aWZmIC0tZ2l0IGEvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9ydW5fcGFja2V0LmMgYi9ndGVzdHMv
bmV0L3BhY2tldGRyaWxsL3J1bl9wYWNrZXQuYwppbmRleCBiN2Y4ODQ4Li42NjI4YzQ1IDEwMDY0
NAotLS0gYS9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3J1bl9wYWNrZXQuYworKysgYi9ndGVzdHMv
bmV0L3BhY2tldGRyaWxsL3J1bl9wYWNrZXQuYwpAQCAtMTI4MSw2ICsxMjgxLDE4IEBAIHN0YXRp
YyBpbnQgdmVyaWZ5X291dGJvdW5kX2xpdmVfaXB2Nl9mbG93bGFiZWwoCiAJdTMyIHNjcmlwdF9m
bG93bGFiZWwgPSBpcHY2X2Zsb3dfbGFiZWwoc2NyaXB0X3BhY2tldC0+aXB2Nik7CiAJdTMyIGxp
dmVfZmxvd2xhYmVsID0gaXB2Nl9mbG93X2xhYmVsKGFjdHVhbF9wYWNrZXQtPmlwdjYpOwogCisJ
LyogV2l0aCBmbG93bGFiZWxfZXhhY3QsIHRoZSBsaXZlIGZsb3cgbGFiZWwgbXVzdCBtYXRjaCBl
eGFjdGx5LiAqLworCWlmIChzY3JpcHRfcGFja2V0LT5mbGFncyAmIEZMQUdfRkxPV0xBQkVMX0VY
QUNUKSB7CisJCWlmIChsaXZlX2Zsb3dsYWJlbCAhPSBzY3JpcHRfZmxvd2xhYmVsKSB7CisJCQlh
c3ByaW50ZihlcnJvciwKKwkJCQkgImJhZCBvdXRib3VuZCBJUHY2IGZsb3cgbGFiZWw6ICIKKwkJ
CQkgImV4cGVjdGVkOiAweCUwNXggdnMgYWN0dWFsOiAweCUwNXgiLAorCQkJCSBzY3JpcHRfZmxv
d2xhYmVsLCBsaXZlX2Zsb3dsYWJlbCk7CisJCQlyZXR1cm4gU1RBVFVTX0VSUjsKKwkJfQorCQly
ZXR1cm4gU1RBVFVTX09LOworCX0KKwogCS8qIFJldHVybiBkaXJlY3RseSBpZiBzY3JpcHRfZmxv
d2xhYmVsIGlzIG5vdCBzZXQgKi8KIAlpZiAoIXNjcmlwdF9mbG93bGFiZWwpCiAJCXJldHVybiBT
VEFUVVNfT0s7CmRpZmYgLS1naXQgYS9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3RjcF9wYWNrZXQu
YyBiL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvdGNwX3BhY2tldC5jCmluZGV4IDI4YjUyYzMuLjNj
NGVjZTYgMTAwNjQ0Ci0tLSBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvdGNwX3BhY2tldC5jCisr
KyBiL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvdGNwX3BhY2tldC5jCkBAIC0xNTYsNiArMTU2LDgg
QEAgc3RydWN0IHBhY2tldCAqbmV3X3RjcF9wYWNrZXQoaW50IGFkZHJlc3NfZmFtaWx5LAogCXBh
Y2tldC0+ZGlyZWN0aW9uID0gZGlyZWN0aW9uOwogCXBhY2tldC0+ZmxhZ3MgPSAwOwogCXBhY2tl
dC0+dG9zX2NoayA9IGlwX2luZm8udG9zLmNoZWNrOworCWlmIChpcF9pbmZvLmZsb3dfbGFiZWxf
ZXhhY3QpCisJCXBhY2tldC0+ZmxhZ3MgfD0gRkxBR19GTE9XTEFCRUxfRVhBQ1Q7CiAKIAkvKiBT
ZXQgSVAgaGVhZGVyIGZpZWxkcyAqLwogCXNldF9wYWNrZXRfaXBfaGVhZGVyKHBhY2tldCwgYWRk
cmVzc19mYW1pbHksIGlwX2J5dGVzLApkaWZmIC0tZ2l0IGEvZ3Rlc3RzL25ldC9wYWNrZXRkcmls
bC90eXBlcy5oIGIvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC90eXBlcy5oCmluZGV4IDM3Y2I3NDAu
LjdmYjk3Y2EgMTAwNjQ0Ci0tLSBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvdHlwZXMuaAorKysg
Yi9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3R5cGVzLmgKQEAgLTExMSw2ICsxMTEsNyBAQCBzdHJ1
Y3QgdG9zX3NwZWMgewogc3RydWN0IGlwX2luZm8gewogCXN0cnVjdCB0b3Nfc3BlYyB0b3M7CiAJ
dTMyIGZsb3dfbGFiZWw7CisJYm9vbCBmbG93X2xhYmVsX2V4YWN0OwkvKiBvdXRib3VuZDogY2hl
Y2sgZmxvd19sYWJlbCBleGFjdGx5ICovCiAJdTggdHRsOwogfTsKIApkaWZmIC0tZ2l0IGEvZ3Rl
c3RzL25ldC9wYWNrZXRkcmlsbC91ZHBfcGFja2V0LmMgYi9ndGVzdHMvbmV0L3BhY2tldGRyaWxs
L3VkcF9wYWNrZXQuYwppbmRleCBlODAwNGM1Li40MjJkZmJjIDEwMDY0NAotLS0gYS9ndGVzdHMv
bmV0L3BhY2tldGRyaWxsL3VkcF9wYWNrZXQuYworKysgYi9ndGVzdHMvbmV0L3BhY2tldGRyaWxs
L3VkcF9wYWNrZXQuYwpAQCAtMTAxLDYgKzEwMSw4IEBAIHN0cnVjdCBwYWNrZXQgKm5ld191ZHBf
cGFja2V0KGludCBhZGRyZXNzX2ZhbWlseSwKIAlwYWNrZXQtPmRpcmVjdGlvbiA9IGRpcmVjdGlv
bjsKIAlwYWNrZXQtPmZsYWdzID0gMDsKIAlwYWNrZXQtPnRvc19jaGsgPSBpcF9pbmZvLnRvcy5j
aGVjazsKKwlpZiAoaXBfaW5mby5mbG93X2xhYmVsX2V4YWN0KQorCQlwYWNrZXQtPmZsYWdzIHw9
IEZMQUdfRkxPV0xBQkVMX0VYQUNUOwogCiAJLyogU2V0IElQIGhlYWRlciBmaWVsZHMgKi8KIAlz
ZXRfcGFja2V0X2lwX2hlYWRlcihwYWNrZXQsIGFkZHJlc3NfZmFtaWx5LCBpcF9ieXRlcywKLS0g
CjIuNTYuMC4zOTguZzg4MmNiYWQyNzUtZ29vZwoK
--0000000000009c9f67065f4c762c
Content-Type: application/x-patch; 
	name="packetdrill-0002-support-IPV6_FLOWLABEL_MGR-setsockopt.patch"
Content-Disposition: attachment; 
	filename="packetdrill-0002-support-IPV6_FLOWLABEL_MGR-setsockopt.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvze15cb2>
X-Attachment-Id: f_mvze15cb2

RnJvbSA5ZDE2N2M5YThjYWY4ZjU3MDMxNDY1N2E1YWYwYzM4YjQxY2EyYTY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4K
RGF0ZTogTW9uLCAyIE5vdiAyMDI2IDA2OjE5OjQ3IC0wODAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IG5ldC10ZXN0OiBwYWNrZXRkcmlsbDogc3VwcG9ydCBJUFY2X0ZMT1dMQUJFTF9NR1IKIHNldHNv
Y2tvcHQKCkFkZCBzdXBwb3J0IGZvciBwYXNzaW5nIGEgc3RydWN0IGluNl9mbG93bGFiZWxfcmVx
IHRvIHNldHNvY2tvcHQoKSwgc28KdGhhdCBzY3JpcHRzIGNhbiB1c2UgdGhlIElQVjZfRkxPV0xB
QkVMX01HUiBzb2NrZXQgb3B0aW9uLCBlLmcuIHRvCmVuYWJsZSBmbG93IGxhYmVsIHJlZmxlY3Rp
b24gb24gYSBUQ1AgbGlzdGVuZXI6CgogIHNldHNvY2tvcHQoMywgU09MX0lQVjYsIElQVjZfRkxP
V0xBQkVMX01HUiwge2Zscl9sYWJlbD0wLAogICAgICAgICAgICAgZmxyX2FjdGlvbj1JUFY2X0ZM
X0FfR0VULCBmbHJfc2hhcmU9SVBWNl9GTF9TX05PTkUsCiAgICAgICAgICAgICBmbHJfZmxhZ3M9
SVBWNl9GTF9GX1JFRkxFQ1QsIGZscl9leHBpcmVzPTAsCiAgICAgICAgICAgICBmbHJfbGluZ2Vy
PTB9LCAzMikgPSAwCgpmbHJfbGFiZWwgaXMgZ2l2ZW4gaW4gaG9zdCBieXRlIG9yZGVyLCBhbmQg
ZmxyX2RzdCBpcyB6ZXJvZWQuIEZpZWxkCnZhbHVlcyBjYW4gYmUgaW50ZWdlcnMgb3Igc3ltYm9s
aWMgbmFtZXMuIEFkZCB0aGUgSVBWNl9GTF9BXyosCklQVjZfRkxfRl8qIGFuZCBJUFY2X0ZMX1Nf
KiBzeW1ib2xzLCBwbHVzIElQVjZfRkxPV0xBQkVMX01HUiBhbmQKSVBWNl9GTE9XSU5GT19TRU5E
LgoKQXMgd2l0aCBzdHJ1Y3QgaW42X2lmcmVxLCBkZWNsYXJlIG91ciBvd24gY29weSBvZiBzdHJ1
Y3QKaW42X2Zsb3dsYWJlbF9yZXEgYW5kIGl0cyBjb25zdGFudHMgaW4gaXB2Ni5oLCBzaW5jZSB0
aGV5IGFyZSBvbmx5CmF2YWlsYWJsZSBpbiBsaW51eC9pbjYuaCwgd2hpY2ggY29uZmxpY3RzIHdp
dGggPG5ldGluZXQvaW4uaD4uCgpUaGlzIHBhdGNoIHdhcyBkZXZlbG9wZWQgd2l0aCB0aGUgaGVs
cCBvZiBhbiBBSSBjb2RpbmcgYXNzaXN0YW50LgotLS0KIGd0ZXN0cy9uZXQvcGFja2V0ZHJpbGwv
aXB2Ni5oICAgICAgICAgICAgfCA0NSArKysrKysrKysrKysrKysrKysKIGd0ZXN0cy9uZXQvcGFj
a2V0ZHJpbGwvbGV4ZXIubCAgICAgICAgICAgfCAgNiArKysKIGd0ZXN0cy9uZXQvcGFja2V0ZHJp
bGwvcGFyc2VyLnkgICAgICAgICAgfCA1OCArKysrKysrKysrKysrKysrKysrKysrKysKIGd0ZXN0
cy9uZXQvcGFja2V0ZHJpbGwvcnVuX3N5c3RlbV9jYWxsLmMgfCAgMiArCiBndGVzdHMvbmV0L3Bh
Y2tldGRyaWxsL3NjcmlwdC5jICAgICAgICAgIHwgIDcgKysrCiBndGVzdHMvbmV0L3BhY2tldGRy
aWxsL3NjcmlwdC5oICAgICAgICAgIHwgIDIgKwogZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9zeW1i
b2xzX2xpbnV4LmMgICB8IDE1ICsrKysrKwogNyBmaWxlcyBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvaXB2Ni5oIGIvZ3Rlc3Rz
L25ldC9wYWNrZXRkcmlsbC9pcHY2LmgKaW5kZXggMDdhMDk2NC4uODA4MzlkNiAxMDA2NDQKLS0t
IGEvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9pcHY2LmgKKysrIGIvZ3Rlc3RzL25ldC9wYWNrZXRk
cmlsbC9pcHY2LmgKQEAgLTg5LDQgKzg5LDQ5IEBAIHN0cnVjdCBpbjZfaWZyZXEgewogCWludAkJ
aWZyNl9pZmluZGV4OwogfTsKIAorLyogSVB2NiBmbG93IGxhYmVsIG1hbmFnZXIgKElQVjZfRkxP
V0xBQkVMX01HUiBzb2NrZXQgb3B0aW9uKS4gQXMgd2l0aAorICogc3RydWN0IGluNl9pZnJlcSBh
Ym92ZSwgd2UgaGF2ZSB0byBkZWNsYXJlIG91ciBvd24gdmVyc2lvbnMgYmVjYXVzZQorICogdGhl
c2UgYXJlIG9ubHkgYXZhaWxhYmxlIGluIC91c3IvaW5jbHVkZS9saW51eC9pbjYuaCwgd2hpY2gg
Y29uZmxpY3RzCisgKiB3aXRoIHN0YW5kYXJkIHVzZXItc3BhY2UgSVB2NiBkZWNsYXJhdGlvbnMu
CisgKi8KKyNpZmRlZiBsaW51eAorI2lmbmRlZiBJUFY2X0ZMT1dMQUJFTF9NR1IKKyNkZWZpbmUg
SVBWNl9GTE9XTEFCRUxfTUdSCTMyCisjZW5kaWYKKyNpZm5kZWYgSVBWNl9GTE9XSU5GT19TRU5E
CisjZGVmaW5lIElQVjZfRkxPV0lORk9fU0VORAkzMworI2VuZGlmCisjZW5kaWYgIC8qIGxpbnV4
ICovCisKKyNpZm5kZWYgSVBWNl9GTF9BX0dFVAorLyogZmxyX2FjdGlvbiB2YWx1ZXMgKi8KKyNk
ZWZpbmUgSVBWNl9GTF9BX0dFVAkJMAorI2RlZmluZSBJUFY2X0ZMX0FfUFVUCQkxCisjZGVmaW5l
IElQVjZfRkxfQV9SRU5FVwkJMgorCisvKiBmbHJfZmxhZ3MgdmFsdWVzICovCisjZGVmaW5lIElQ
VjZfRkxfRl9DUkVBVEUJMQorI2RlZmluZSBJUFY2X0ZMX0ZfRVhDTAkJMgorI2RlZmluZSBJUFY2
X0ZMX0ZfUkVGTEVDVAk0CisjZGVmaW5lIElQVjZfRkxfRl9SRU1PVEUJOAorCisvKiBmbHJfc2hh
cmUgdmFsdWVzICovCisjZGVmaW5lIElQVjZfRkxfU19OT05FCQkwCisjZGVmaW5lIElQVjZfRkxf
U19FWENMCQkxCisjZGVmaW5lIElQVjZfRkxfU19QUk9DRVNTCTIKKyNkZWZpbmUgSVBWNl9GTF9T
X1VTRVIJCTMKKyNkZWZpbmUgSVBWNl9GTF9TX0FOWQkJMjU1CisjZW5kaWYgIC8qIElQVjZfRkxf
QV9HRVQgKi8KKworc3RydWN0IGluNl9mbG93bGFiZWxfcmVxIHsKKwlzdHJ1Y3QgaW42X2FkZHIJ
ZmxyX2RzdDsKKwlfX2JlMzIJCWZscl9sYWJlbDsKKwlfX3U4CQlmbHJfYWN0aW9uOworCV9fdTgJ
CWZscl9zaGFyZTsKKwlfX3UxNgkJZmxyX2ZsYWdzOworCV9fdTE2CQlmbHJfZXhwaXJlczsKKwlf
X3UxNgkJZmxyX2xpbmdlcjsKKwlfX3UzMgkJX19mbHJfcGFkOworfTsKKwogI2VuZGlmIC8qIF9f
SVBWNl9IRUFERVJTX0hfXyAqLwpkaWZmIC0tZ2l0IGEvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9s
ZXhlci5sIGIvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9sZXhlci5sCmluZGV4IGY2OWIzNzIuLmQ0
YTE3YTYgMTAwNjQ0Ci0tLSBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvbGV4ZXIubAorKysgYi9n
dGVzdHMvbmV0L3BhY2tldGRyaWxsL2xleGVyLmwKQEAgLTIyNCw2ICsyMjQsMTIgQEAgZXZlbnRz
CQkJcmV0dXJuIEVWRU5UUzsKIHJldmVudHMJCQlyZXR1cm4gUkVWRU5UUzsKIG9ub2ZmCQkJcmV0
dXJuIE9OT0ZGOwogbGluZ2VyCQkJcmV0dXJuIExJTkdFUjsKK2Zscl9sYWJlbAkJcmV0dXJuIEZM
Ul9MQUJFTDsKK2Zscl9hY3Rpb24JCXJldHVybiBGTFJfQUNUSU9OOworZmxyX3NoYXJlCQlyZXR1
cm4gRkxSX1NIQVJFOworZmxyX2ZsYWdzCQlyZXR1cm4gRkxSX0ZMQUdTOworZmxyX2V4cGlyZXMJ
CXJldHVybiBGTFJfRVhQSVJFUzsKK2Zscl9saW5nZXIJCXJldHVybiBGTFJfTElOR0VSOwogaHRv
bnMJCQlyZXR1cm4gX0hUT05TXzsKIGlwdjQJCQlyZXR1cm4gSVBWNDsKIGlwdjYJCQlyZXR1cm4g
SVBWNjsKZGlmZiAtLWdpdCBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvcGFyc2VyLnkgYi9ndGVz
dHMvbmV0L3BhY2tldGRyaWxsL3BhcnNlci55CmluZGV4IDAzNWQ5YmEuLjhmNTIzNjEgMTAwNjQ0
Ci0tLSBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvcGFyc2VyLnkKKysrIGIvZ3Rlc3RzL25ldC9w
YWNrZXRkcmlsbC9wYXJzZXIueQpAQCAtNTgyLDYgKzU4Miw4IEBAIHN0YXRpYyBzdHJ1Y3QgcGFj
a2V0ICphcHBlbmRfZ3JlKHN0cnVjdCBwYWNrZXQgKnBhY2tldCwgc3RydWN0IGV4cHJlc3Npb24g
KmV4cHIpCiAldG9rZW4gPHJlc2VydmVkPiBNU0dfTkFNRSBNU0dfSU9WIE1TR19GTEFHUyBNU0df
Q09OVFJPTAogJXRva2VuIDxyZXNlcnZlZD4gQ01TR19MRVZFTCBDTVNHX1RZUEUgQ01TR19EQVRB
CiAldG9rZW4gPHJlc2VydmVkPiBGRCBFVkVOVFMgUkVWRU5UUyBPTk9GRiBMSU5HRVIKKyV0b2tl
biA8cmVzZXJ2ZWQ+IEZMUl9MQUJFTCBGTFJfQUNUSU9OIEZMUl9TSEFSRSBGTFJfRkxBR1MKKyV0
b2tlbiA8cmVzZXJ2ZWQ+IEZMUl9FWFBJUkVTIEZMUl9MSU5HRVIKICV0b2tlbiA8cmVzZXJ2ZWQ+
IFUzMiBVNjQgUFRSCiAldG9rZW4gPHJlc2VydmVkPiBBQ0sgRUNSIEVPTCBNU1MgTk9QIFNBQ0sg
U0FDS09LIFRJTUVTVEFNUCBWQUwgV0lOIFdTQ0FMRQogJXRva2VuIDxyZXNlcnZlZD4gVVJHIE1E
NSBGQVNUX09QRU4gRkFTVF9PUEVOX0VYUCBBQ0NFQ04KQEAgLTY0MCw2ICs2NDIsOCBAQCBzdGF0
aWMgc3RydWN0IHBhY2tldCAqYXBwZW5kX2dyZShzdHJ1Y3QgcGFja2V0ICpwYWNrZXQsIHN0cnVj
dCBleHByZXNzaW9uICpleHByKQogJXR5cGUgPGV4cHJlc3Npb24+IGFueV9pbnQgZGVjaW1hbF9p
bnRlZ2VyIGhleF9pbnRlZ2VyCiAldHlwZSA8ZXhwcmVzc2lvbj4gc3RyaW5nX2V4cHJlc3Npb24g
c3RyaW5nX3NlcXVlbmNlCiAldHlwZSA8ZXhwcmVzc2lvbj4gaW5hZGRyIGluNmFkZHIgc29ja2Fk
ZHIgbXNnaGRyIGlvdmVjIHBvbGxmZCBvcHRfcmV2ZW50cyBsaW5nZXIKKyV0eXBlIDxleHByZXNz
aW9uPiBpbjZfZmxvd2xhYmVsX3JlcQorJXR5cGUgPGludGVnZXI+IGZscl92YWx1ZQogJXR5cGUg
PGV4cHJlc3Npb24+IG9wdF9jbXNnIGNtc2dfZXhwcgogJXR5cGUgPGV4cHJlc3Npb24+IHNjbV90
aW1lc3RhbXBpbmdfZXhwcgogJXR5cGUgPGV4cHJlc3Npb24+IHNvY2tfZXh0ZW5kZWRfZXJyX2V4
cHIKQEAgLTE2MDUsNiArMTYwOSw5IEBAIGV4cHJlc3Npb24KIHwgbGluZ2VyICAgICAgICAgICAg
ewogCSQkID0gJDE7CiB9Cit8IGluNl9mbG93bGFiZWxfcmVxIHsKKwkkJCA9ICQxOworfQogfCBt
cGxzX3N0YWNrX2V4cHJlc3Npb24gewogCSQkID0gJDE7CiB9CkBAIC0xODkwLDYgKzE4OTcsNTcg
QEAgbGluZ2VyCiB9CiA7CiAKKy8qIEFuIGludGVnZXIsIG9yIGEgc3ltYm9saWMgbmFtZSBzdWNo
IGFzIElQVjZfRkxfRl9SRUZMRUNULiAqLworZmxyX3ZhbHVlCis6IElOVEVHRVIJCXsgJCQgPSAk
MTsgfQorfCBIRVhfSU5URUdFUgkJeyAkJCA9ICQxOyB9Cit8IFdPUkQJCQl7CisJY2hhciAqZXJy
b3IgPSBOVUxMOworCXM2NCB2YWx1ZSA9IDA7CisKKwlpZiAoc3ltYm9sX3RvX2ludCgkMSwgJnZh
bHVlLCAmZXJyb3IpKSB7CisJCXNlbWFudGljX2Vycm9yKGVycm9yKTsKKwkJZnJlZShlcnJvcik7
CisJfQorCWZyZWUoJDEpOworCSQkID0gdmFsdWU7Cit9Cis7CisKKy8qIHN0cnVjdCBpbjZfZmxv
d2xhYmVsX3JlcSBmb3IgdGhlIElQVjZfRkxPV0xBQkVMX01HUiBzb2NrZXQgb3B0aW9uOworICog
ZmxyX2RzdCBpcyB6ZXJvZWQuIGZscl9sYWJlbCBpcyBpbiBob3N0IGJ5dGUgb3JkZXIgaW4gdGhl
IHNjcmlwdC4KKyAqLworaW42X2Zsb3dsYWJlbF9yZXEKKzogJ3snIEZMUl9MQUJFTCAnPScgZmxy
X3ZhbHVlICcsJyBGTFJfQUNUSU9OICc9JyBmbHJfdmFsdWUgJywnCisgICAgICBGTFJfU0hBUkUg
Jz0nIGZscl92YWx1ZSAnLCcgRkxSX0ZMQUdTICc9JyBmbHJfdmFsdWUgJywnCisgICAgICBGTFJf
RVhQSVJFUyAnPScgZmxyX3ZhbHVlICcsJyBGTFJfTElOR0VSICc9JyBmbHJfdmFsdWUgJ30nIHsK
KwlzdHJ1Y3QgaW42X2Zsb3dsYWJlbF9yZXEgKmZyZXE7CisKKwlpZiAoIWlzX3ZhbGlkX3UyMCgk
NCkpCisJCXNlbWFudGljX2Vycm9yKCJmbHJfbGFiZWwgb3V0IG9mIHJhbmdlIGZvciAyMCBiaXRz
Iik7CisJaWYgKCFpc192YWxpZF91OCgkOCkpCisJCXNlbWFudGljX2Vycm9yKCJmbHJfYWN0aW9u
IG91dCBvZiByYW5nZSIpOworCWlmICghaXNfdmFsaWRfdTgoJDEyKSkKKwkJc2VtYW50aWNfZXJy
b3IoImZscl9zaGFyZSBvdXQgb2YgcmFuZ2UiKTsKKwlpZiAoIWlzX3ZhbGlkX3UxNigkMTYpKQor
CQlzZW1hbnRpY19lcnJvcigiZmxyX2ZsYWdzIG91dCBvZiByYW5nZSIpOworCWlmICghaXNfdmFs
aWRfdTE2KCQyMCkpCisJCXNlbWFudGljX2Vycm9yKCJmbHJfZXhwaXJlcyBvdXQgb2YgcmFuZ2Ui
KTsKKwlpZiAoIWlzX3ZhbGlkX3UxNigkMjQpKQorCQlzZW1hbnRpY19lcnJvcigiZmxyX2xpbmdl
ciBvdXQgb2YgcmFuZ2UiKTsKKworCSQkID0gbmV3X2V4cHJlc3Npb24oRVhQUl9JTjZfRkxPV0xB
QkVMX1JFUSk7CisJZnJlcSA9ICYkJC0+dmFsdWUuaW42X2Zsb3dsYWJlbF9yZXE7CisJbWVtc2V0
KGZyZXEsIDAsIHNpemVvZigqZnJlcSkpOworCWZyZXEtPmZscl9sYWJlbCAgID0gaHRvbmwoJDQp
OworCWZyZXEtPmZscl9hY3Rpb24gID0gJDg7CisJZnJlcS0+ZmxyX3NoYXJlICAgPSAkMTI7CisJ
ZnJlcS0+ZmxyX2ZsYWdzICAgPSAkMTY7CisJZnJlcS0+ZmxyX2V4cGlyZXMgPSAkMjA7CisJZnJl
cS0+ZmxyX2xpbmdlciAgPSAkMjQ7Cit9Cis7CisKIG1wbHNfc3RhY2tfZXhwcmVzc2lvbgogOgog
J3snIG1wbHNfc3RhY2sgJ30nCXsKZGlmZiAtLWdpdCBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwv
cnVuX3N5c3RlbV9jYWxsLmMgYi9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3J1bl9zeXN0ZW1fY2Fs
bC5jCmluZGV4IDM2ZjlmNTEuLjFmZGI4YTQgMTAwNjQ0Ci0tLSBhL2d0ZXN0cy9uZXQvcGFja2V0
ZHJpbGwvcnVuX3N5c3RlbV9jYWxsLmMKKysrIGIvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9ydW5f
c3lzdGVtX2NhbGwuYwpAQCAtMjczNyw2ICsyNzM3LDggQEAgc3RhdGljIGludCBzeXNjYWxsX3Nl
dHNvY2tvcHQoc3RydWN0IHN0YXRlICpzdGF0ZSwgc3RydWN0IHN5c2NhbGxfc3BlYyAqc3lzY2Fs
bCwKIAkJcmV0dXJuIFNUQVRVU19FUlI7CiAJaWYgKHZhbF9leHByZXNzaW9uLT50eXBlID09IEVY
UFJfTElOR0VSKSB7CiAJCW9wdHZhbCA9ICZ2YWxfZXhwcmVzc2lvbi0+dmFsdWUubGluZ2VyOwor
CX0gZWxzZSBpZiAodmFsX2V4cHJlc3Npb24tPnR5cGUgPT0gRVhQUl9JTjZfRkxPV0xBQkVMX1JF
USkgeworCQlvcHR2YWwgPSAmdmFsX2V4cHJlc3Npb24tPnZhbHVlLmluNl9mbG93bGFiZWxfcmVx
OwogCX0gZWxzZSBpZiAodmFsX2V4cHJlc3Npb24tPnR5cGUgPT0gRVhQUl9HUkUpIHsKIAkJb3B0
dmFsID0gJnZhbF9leHByZXNzaW9uLT52YWx1ZS5ncmU7CiAJfSBlbHNlIGlmICh2YWxfZXhwcmVz
c2lvbi0+dHlwZSA9PSBFWFBSX0lONl9BRERSKSB7CmRpZmYgLS1naXQgYS9ndGVzdHMvbmV0L3Bh
Y2tldGRyaWxsL3NjcmlwdC5jIGIvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9zY3JpcHQuYwppbmRl
eCBiNzEzNzEzLi41MzNhNTZiIDEwMDY0NAotLS0gYS9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3Nj
cmlwdC5jCisrKyBiL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvc2NyaXB0LmMKQEAgLTYyLDYgKzYy
LDcgQEAgc3RydWN0IGV4cHJlc3Npb25fdHlwZV9lbnRyeSBleHByZXNzaW9uX3R5cGVfdGFibGVb
XSA9IHsKIAl7IEVYUFJfU09DS0VUX0FERFJFU1NfSVBWNCwgICJzb2NrYWRkcl9pbiIgfSwKIAl7
IEVYUFJfU09DS0VUX0FERFJFU1NfSVBWNiwgICJzb2NrYWRkcl9pbjYiIH0sCiAJeyBFWFBSX0xJ
TkdFUiwgICAgICAgICAgICAgICAibGluZ2VyIiB9LAorCXsgRVhQUl9JTjZfRkxPV0xBQkVMX1JF
USwgICAgImluNl9mbG93bGFiZWxfcmVxIiB9LAogCXsgRVhQUl9CSU5BUlksICAgICAgICAgICAg
ICAgImJpbmFyeV9leHByZXNzaW9uIiB9LAogCXsgRVhQUl9MSVNULCAgICAgICAgICAgICAgICAg
Imxpc3QiIH0sCiAJeyBFWFBSX0lPVkVDLCAgICAgICAgICAgICAgICAiaW92ZWMiIH0sCkBAIC0z
MDIsNiArMzAzLDcgQEAgdm9pZCBmcmVlX2V4cHJlc3Npb24oc3RydWN0IGV4cHJlc3Npb24gKmV4
cHJlc3Npb24pCiAJY2FzZSBFWFBSX0dSRToKIAljYXNlIEVYUFJfSU42X0FERFI6CiAJY2FzZSBF
WFBSX0xJTkdFUjoKKwljYXNlIEVYUFJfSU42X0ZMT1dMQUJFTF9SRVE6CiAJCWJyZWFrOwogCWNh
c2UgRVhQUl9XT1JEOgogCQlhc3NlcnQoZXhwcmVzc2lvbi0+dmFsdWUuYnVmLnB0cik7CkBAIC02
ODQsNiArNjg2LDExIEBAIHN0YXRpYyBpbnQgZXZhbHVhdGUoc3RydWN0IGV4cHJlc3Npb24gKmlu
LAogCQltZW1jcHkoJm91dC0+dmFsdWUubGluZ2VyLCAmaW4tPnZhbHVlLmxpbmdlciwKIAkJICAg
ICAgIHNpemVvZihpbi0+dmFsdWUubGluZ2VyKSk7CiAJCWJyZWFrOworCWNhc2UgRVhQUl9JTjZf
RkxPV0xBQkVMX1JFUToJLyogY29weSBhcy1pcyAqLworCQltZW1jcHkoJm91dC0+dmFsdWUuaW42
X2Zsb3dsYWJlbF9yZXEsCisJCSAgICAgICAmaW4tPnZhbHVlLmluNl9mbG93bGFiZWxfcmVxLAor
CQkgICAgICAgc2l6ZW9mKGluLT52YWx1ZS5pbjZfZmxvd2xhYmVsX3JlcSkpOworCQlicmVhazsK
IAljYXNlIEVYUFJfV09SRDoKIAkJb3V0LT50eXBlID0gRVhQUl9JTlRFR0VSOwogCQlpZiAoc3lt
Ym9sX3RvX2ludChpbi0+dmFsdWUuYnVmLnB0ciwKZGlmZiAtLWdpdCBhL2d0ZXN0cy9uZXQvcGFj
a2V0ZHJpbGwvc2NyaXB0LmggYi9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3NjcmlwdC5oCmluZGV4
IGUyOTM5YmUuLjljNDY2ZWEgMTAwNjQ0Ci0tLSBhL2d0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvc2Ny
aXB0LmgKKysrIGIvZ3Rlc3RzL25ldC9wYWNrZXRkcmlsbC9zY3JpcHQuaApAQCAtMzcsNiArMzcs
NyBAQCBlbnVtIGV4cHJlc3Npb25fdCB7CiAJRVhQUl9FTExJUFNJUywJCSAgLyogLi4uIGJ1dCBu
byB2YWx1ZSAqLwogCUVYUFJfSU5URUdFUiwJCSAgLyogaW50ZWdlciBpbiAnbnVtJyAqLwogCUVY
UFJfTElOR0VSLAkJICAvKiBzdHJ1Y3QgbGluZ2VyIGZvciBTT19MSU5HRVIgKi8KKwlFWFBSX0lO
Nl9GTE9XTEFCRUxfUkVRLAkgIC8qIHN0cnVjdCBpbjZfZmxvd2xhYmVsX3JlcSAqLwogCUVYUFJf
V09SRCwJCSAgLyogdW5xdW90ZWQgd29yZCBpbiAnc3RyaW5nJyAqLwogCUVYUFJfU1RSSU5HLAkJ
ICAvKiBkb3VibGUtcXVvdGVkIHN0cmluZyBpbiAnc3RyaW5nJyAqLwogCUVYUFJfR1JFLAkJICAv
KiBHUkUgaGVhZGVyICovCkBAIC03MSw2ICs3Miw3IEBAIHN0cnVjdCBleHByZXNzaW9uIHsKIAkJ
czY0IG51bTsKIAkJc3RydWN0IG1lbW9yeV9idWZmZXIgYnVmOwogCQlzdHJ1Y3QgbGluZ2VyIGxp
bmdlcjsKKwkJc3RydWN0IGluNl9mbG93bGFiZWxfcmVxIGluNl9mbG93bGFiZWxfcmVxOwogCQlz
dHJ1Y3QgZ3JlIGdyZTsKIAkJc3RydWN0IGluNl9hZGRyIGFkZHJlc3NfaXB2NjsKIAkJc3RydWN0
IHNvY2thZGRyX2luICpzb2NrZXRfYWRkcmVzc19pcHY0OwpkaWZmIC0tZ2l0IGEvZ3Rlc3RzL25l
dC9wYWNrZXRkcmlsbC9zeW1ib2xzX2xpbnV4LmMgYi9ndGVzdHMvbmV0L3BhY2tldGRyaWxsL3N5
bWJvbHNfbGludXguYwppbmRleCAxNjU1MTQzLi40Njk3MTFkIDEwMDY0NAotLS0gYS9ndGVzdHMv
bmV0L3BhY2tldGRyaWxsL3N5bWJvbHNfbGludXguYworKysgYi9ndGVzdHMvbmV0L3BhY2tldGRy
aWxsL3N5bWJvbHNfbGludXguYwpAQCAtNDYsNiArNDYsNyBAQAogCiAjaW5jbHVkZSAiZXBvbGwu
aCIKICNpbmNsdWRlICJpcC5oIgorI2luY2x1ZGUgImlwdjYuaCIKICNpbmNsdWRlICJ0Y3AuaCIK
ICNpbmNsdWRlICJjYXBhYmlsaXR5LmgiCiAKQEAgLTE2Nyw2ICsxNjgsMjAgQEAgc3RydWN0IGlu
dF9zeW1ib2wgcGxhdGZvcm1fc3ltYm9sc190YWJsZVtdID0gewogCXsgSVBWNl9NVFUsICAgICAg
ICAgICAgICAgICAgICAgICAgICJJUFY2X01UVSIgICAgICAgICAgICAgICAgICAgICAgICB9LAog
I2VuZGlmCiAJeyBJUFY2X1RDTEFTUywgICAgICAgICAgICAgICAgICAgICAgIklQVjZfVENMQVNT
IiAgICAgICAgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMT1dMQUJFTF9NR1IsICAgICAgICAg
ICAgICAgIklQVjZfRkxPV0xBQkVMX01HUiIgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMT1dJ
TkZPX1NFTkQsICAgICAgICAgICAgICAgIklQVjZfRkxPV0lORk9fU0VORCIgICAgICAgICAgICAg
IH0sCisJeyBJUFY2X0ZMX0FfR0VULCAgICAgICAgICAgICAgICAgICAgIklQVjZfRkxfQV9HRVQi
ICAgICAgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX0FfUFVULCAgICAgICAgICAgICAgICAg
ICAgIklQVjZfRkxfQV9QVVQiICAgICAgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX0FfUkVO
RVcsICAgICAgICAgICAgICAgICAgIklQVjZfRkxfQV9SRU5FVyIgICAgICAgICAgICAgICAgIH0s
CisJeyBJUFY2X0ZMX0ZfQ1JFQVRFLCAgICAgICAgICAgICAgICAgIklQVjZfRkxfRl9DUkVBVEUi
ICAgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX0ZfRVhDTCwgICAgICAgICAgICAgICAgICAg
IklQVjZfRkxfRl9FWENMIiAgICAgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX0ZfUkVGTEVD
VCwgICAgICAgICAgICAgICAgIklQVjZfRkxfRl9SRUZMRUNUIiAgICAgICAgICAgICAgIH0sCisJ
eyBJUFY2X0ZMX0ZfUkVNT1RFLCAgICAgICAgICAgICAgICAgIklQVjZfRkxfRl9SRU1PVEUiICAg
ICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX1NfTk9ORSwgICAgICAgICAgICAgICAgICAgIklQ
VjZfRkxfU19OT05FIiAgICAgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX1NfRVhDTCwgICAg
ICAgICAgICAgICAgICAgIklQVjZfRkxfU19FWENMIiAgICAgICAgICAgICAgICAgIH0sCisJeyBJ
UFY2X0ZMX1NfUFJPQ0VTUywgICAgICAgICAgICAgICAgIklQVjZfRkxfU19QUk9DRVNTIiAgICAg
ICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX1NfVVNFUiwgICAgICAgICAgICAgICAgICAgIklQVjZf
RkxfU19VU0VSIiAgICAgICAgICAgICAgICAgIH0sCisJeyBJUFY2X0ZMX1NfQU5ZLCAgICAgICAg
ICAgICAgICAgICAgIklQVjZfRkxfU19BTlkiICAgICAgICAgICAgICAgICAgIH0sCiAJeyBJUFY2
X0hPUExJTUlULCAgICAgICAgICAgICAgICAgICAgIklQVjZfSE9QTElNSVQiICAgICAgICAgICAg
ICAgICAgIH0sCiAKIAl7IFRDUF9OT0RFTEFZLCAgICAgICAgICAgICAgICAgICAgICAiVENQX05P
REVMQVkiICAgICAgICAgICAgICAgICAgICAgfSwKLS0gCjIuNTYuMC4zOTguZzg4MmNiYWQyNzUt
Z29vZwoK
--0000000000009c9f67065f4c762c--
