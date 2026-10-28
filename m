Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793205598;
	b=QQoxZiADkDWeH6dYfbtJcq0mK7ZHJOFkw+GUwu/tZra3uStQjbNuaJnMVmjVD1ZsI47d
	 Y0NRs+2sYEmzFkBp6nM3R++oG6pbd8QE2uviBFPLQMih+yV4j3kY0I97Dxuj4yfCWfxkj
	 4l//r0jgex8hMXj/JwarFwkZZpjBN5W1s/IvS84KfCjFPuhpgRVvc5XLlT3eICkRvUNMG
	 cSoeAcnvNGNnRcqJUjomv6Uh81+9J9SGQ69Voz7H2jO1QRz+lQmniKjO+rjMRw78SGVvw
	 LOBjUQOtBrY+mCyB4FF/mUG2WOz8/huZG6+FdbcoTZ7N32RlWAO+CAd8o1tjTOzOJKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Exn9gYgxz7NdoqRqyZeSuqCKQ+a5/5rC6WMWV+gCS48=;
	b=egGVE0flnJQBRs8qQnbqyEwXHElHksHotwAQgTUgiF99fj8/oblBo6fo9mzaf+omUeJM
	 J4Xi2/GOVQVGgxrf3stEWidv3svrPUTWaTGLhQhvuh73saPApnejQ61Y4uc8iA8qSujW/
	 TPZtX7yVA3vwSR7tBof98jLZsPcXIYpcRxT92Ar2vbjEV7MpZgfdKIbMgkJtIkb5fn2f0
	 E1eCRghCpchWNnD9tBEzNJQUvAw16VuYKIAwkcqoj+hPGEJGinKsVAWq87PIEz74q3/h7
	 ez31T2fj1MJQ3Aic4vWE07//h4HCCV5hv9WbOkgHAWVn2cIzBHiCnNzTDAV7RI6Fg6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RyqRCdZJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC55606A336
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC55606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RyqRCdZJ
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-8446af403b5so748072a34.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793205597; cv=none;
        d=google.com; s=arc-20260327;
        b=Rhw9DLFsBK6cPi+z0dQ52E8IzCf6dMRUac7bBq/EE7XJ8wCyMAnN0P2I1p/+Eb60BE
         3xFTzQlYf7OW6cII2pZw1KHMP1g6uSSbw5vSpGo+X5UJGagfJLbLZnEAO2R4IzIoQb2E
         MQOqlTB2IzLCloOAcgOFI6S8eRbbqKrF3PseWN4xVisyqBUUGCq1SbmNVVEitBwLyBKH
         RNpdvKqdchXdID1FABAplvrNMNLJDTtK5hdbM5ryBq/+aDznyhaoHY9/Xan7rDgDxNqb
         1kaRImK5Xbv88e7tUQ8+pNNULk6bBxurCXNRwP+HzTB+mejfQQr6bzl2OKntGEMbw3hZ
         U03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Exn9gYgxz7NdoqRqyZeSuqCKQ+a5/5rC6WMWV+gCS48=;
        fh=GVsdUoYSse6pUoYNgSphPv48tmYpzrNB980NPLA8DUg=;
        b=OVFVfBzT4pi+CumsHvgl1MTI+Ds+y/9HbcODLqPxEbo4sQAY+mC7CmNnP9YttwQl5w
         nSrhkIlBtVcZEm/UIjefSWl3lyYagNfH/95Zf44iqK8UenECPEs6YjeywBMZHT7iwkOv
         p+hAhen1J9uTkSfNgKqa9K5e1hQHgWjuRW8Da4j+2yr0ycweweSaot0NphI2l+B4WoTz
         vvujjqULGSEEmgmD3n0UWauAPToNt8Wzl2R8pFtiWdkA3+PJJhok4WClU5YlDSOwoY7T
         4vPbfcjdedon634FdtKSxO4O9bMcM/KJaVlkL2+Dg8KYKZr1JVuQ9I+V3bAPp4GVYrR4
         r79g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793205597; x=1793810397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Exn9gYgxz7NdoqRqyZeSuqCKQ+a5/5rC6WMWV+gCS48=;
        b=RyqRCdZJnRu0jxxQD+2z34YWihWajisqc/Z62DgLrN5gS5cA7V0hGVqzxOU67PtBhu
         vl/KSZqYBOkpjxADzev5Cl75tnbD0wlajQssMycAS3frYR0nTE3gd2dzpR/55fG033Lb
         DydlUWexeWMmNVrjPyUqTQjaMQNzqBXqY85BKfICk6vJAKG0g6T0+Q1lRC4IJE64KPv+
         jseXJ7OVVzUfaOUWN5Lj7o20ZCE1cqESQKiIL6rsSDbyo39yqUbE7kj4nS0TdVSn7gYU
         nWH0NE9xAm5JCFDp0Xusg762ISQOnf/67F/NG8GdOuVrS1n27FnSg+sebFfCtBrgTNOQ
         Zk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205597; x=1793810397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Exn9gYgxz7NdoqRqyZeSuqCKQ+a5/5rC6WMWV+gCS48=;
        b=MGf8rAnn1gxks/xhPq/mmeU9yOND4r7mhLIHOWM0gskkTMN12GUzRb6NL4yGmXuMnk
         CoOGdgpjqguanKgiSqqQz3krauzGGap9Xf4V9yc790JW8fB5pg1GQzylgvFCbmcQLBmK
         5RAOagz1DHsbzPJ3Nbqk6JCOc0KuhmBst8+hx/tIvmdtDROaif523Vx2SzZfm0LG1dmn
         tWR2z7jwJEdsHaeGIFwpxjD+9iKCGDajjgTClFxfDFpGPEHr5L609+TsnPnHduiAxppO
         x4YHvd+r4U/L6mH4F/U/sD/C9RaOdL+McCvZTjGKk4Ovi1y1qiC6UzGcVglNO5LhTKb2
         6ANg==
X-Gm-Message-State: AFq9FYJFPnWrfZWggo1mq/IvgJx+8CVzVwPy4INfNS2jR9qqcmOCze3/
	U6eKwMp78pChmIaBKe1NeAHzpFkqePwPq87XVRlNBWHLIjdKEMpl3EeJo0muEphZmyxYdESYQR0
	Rc7SJizIpfNWYa3x0Uqtiihn3aHtU62Y=
X-Gm-Gg: AYBFou1mRQlqbC0BgexnO6k/ARsEyAFMWb5nQBUPwBbBCi0sHTOH0DKlUlXMMtCu2DG
	diQ4ixzfxs+1OEgDHmNQwTsFCSJ6DAvLuAF2DO73AGYV8FZ05nhsQBZO0PMw4MByFR2Ikw2kmnF
	cYpkvvHxMxYBF52tk63HSvhHM/T3tJuwxkY2/ngzaV6lUY+xh/vjA0XxuCd1sTXbQjrKvjKBuhC
	i3ALTFPloAUXoHtIvf01hB+s2hrmN3i2XK3suVBods9/rBps4KT0t/zuPuB6CvtOTPislOG6Tes
	kmyp00yk9g+fl7hqDh8ByFxxZwaxcqnRmz5EpCAQbgLZoGPp3EhNRZec6+4ZrXBapzbGVN95NfN
	H7veNoI7A9Uqv1ca9Lyu/eSuCIsjOJM0s3lQc
X-Received: by 2002:a05:6808:c234:b0:53a:8c5:d7d6 with SMTP id
 5614622812f47-5637f3f5889mr2077720b6e.6.1793205596842; Wed, 28 Oct 2026
 09:39:56 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com>
 <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com>
In-Reply-To: <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Thu, 29 Oct 2026 00:39:45 +0800
X-Gm-Features: AclHuK_2xvYstgKVhP5W3PiHsnI1B5NkbOv_BO8bQcHV3QrRqgSnI6tylbmw1lU
Message-ID: <CALf2hKuwJxBcuS_ErUfXNOm5oGy8szFcPSaSYz8_qzx0GZr23Q@mail.gmail.com>
Subject: Re: [BUG] tcp: cross-family IPv4 option echo stack overwrite
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	dsahern@kernel.org, idosch@nvidia.com, brauner@kernel.org, 
	dhowells@redhat.com, security@kernel.org, lyutoon@gmail.com, 
	tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

I'm sorry for the noise. The Cc to security@ was unnecessary.

We already have the patches ready (tested). I sent the report first to get =
a
public URL for the Closes: tags. I'll post the patch asap.

Best,
Zhiyu

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 00:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Le mer. 28 oct. 2026 =C3=A0 16:31, Zhiyu Zhang <zhiyuzhang999@gmail.com> =
a =C3=A9crit :
> >
> > Hello Linux Kernel Developers and Maintainers,
> >
> > We found a TCP address-family mismatch that lets an IPv6 packet reach a=
n IPv4
> > reply path. The IPv4 path interprets IPv6 skb control-block fields as I=
Pv4
> > options and copies a packet-controlled length into a 40-byte stack buff=
er. We
> > used it as the write primitive in a demonstrated unprivileged uid-to-ro=
ot
> > chain.
> >
> > The complete path is present in v7.3
> > (c03c1a14507dfaf8b856c2608f9ac216021fc222), where we reproduced the
> > privilege escalation with KASLR, STACKPROTECTOR_STRONG, PTI and IBT ena=
bled.
> > It is also present by inspection in v6.12.95. CONFIG_IPV6 is required.
> >
> > Current mainline d135ab453a7400a34930bdda1ef4bdc8acfac80e contains
> > 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash and
> > lhash2."), which rejects the exact socket transition used by our reprod=
ucer.
> > We therefore do not claim that the complete chain works at that mainlin=
e
> > revision. The unsafe cross-family option handling and unbounded option =
echo
> > remain relevant to maintained trees without that transition restriction=
.
> >
> > Root cause:
> >
> > tcp_v6_connect() changes icsk_af_ops and sk_backlog_rcv to the mapped-I=
Pv4
> > implementations after a successful v4-mapped connect. On affected kerne=
ls,
> > connect(AF_UNSPEC) returns the socket to TCP_CLOSE without restoring th=
ose
> > pointers, and listen() reuses it. A pure-IPv6 accepted child can conseq=
uently
> > have IPv6 lookup state but tcp_v4_do_rcv as its backlog callback.
> >
> > For an [IPv6][DSTOPTS][TCP] packet, tcp_v6_fill_cb() stores inet6_skb_p=
arm in
> > TCP_SKB_CB(skb)->header.h6. If the packet is drained through tcp_v4_do_=
rcv(),
> > tcp_v4_send_reset() passes the same union bytes as header.h4.opt. The a=
liased
> > metadata directs __ip_options_echo() to read a packet-controlled option=
 length
> > and copy it into the 40-byte dopt->__data buffer. Our trigger produces =
a
> > 254-byte overwrite across the canary and return address in
> > ip_send_unicast_reply().
> >
> > The receiving process runs as uid 65534 without capabilities or a user
> > namespace. A root helper is used only to inject the crafted IPv6 packet=
 with
> > a raw socket inside our single-VM test; the packet may instead arrive f=
rom an
> > IPv6 peer.
> >
> > This is the memory-corruption half of the demonstrated privilege-escala=
tion
> > chain. A separately reported watch_queue disclosure supplies the same t=
ask's
> > stack canary and KASLR slide. We will reply with that report's Message-=
ID as
> > soon as it has been posted.
> >
> > Reproduction and fix:
> >
> > We have a source reproducer, exact config, QEMU instructions and a full=
-chain
> > exploit. In accordance with the kernel policy, we are not posting them =
publicly.
> > We can provide the source-only reproducer privately if a maintainer req=
uests it.
> >
> > Our build- and QEMU-tested fix has two layers: the IPv4 TCP reset and A=
CK paths
> > only pass IPv4 option state for ETH_P_IP skbs, and __ip_options_echo() =
validates
> > each option against the declared source area, the actual skb header are=
a and
> > the remaining destination space. We will post it separately as a mergea=
ble
> > [PATCH net] email and link that thread here.
> >
> > AI-agent tooling assisted in identifying and analyzing the issue, devel=
oping
> > the reproducer, and preparing the initial fix. The reporters reviewed t=
he
> > affected paths and reproduced the issue and the fixed result in QEMU.
> >
> > Reported-by: Tong Liu <lyutoon@gmail.com>
> > Reported-by: Qi Tang <tpluszz77@gmail.com>
> > Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> >
> > Best regards,
> > Zhiyu Zhang
>
> Worst report I got this week, and trust me I got many security reports
> in the last 3 days
>
> Why don't you ask your LLM to prepare a patch ?
>
> Why CCing security@ at all, since you made this report public ?
>
> Have you read Documentation/process/security-bugs.rst ?
>
> MPTCP is not yet covered in this untested WIP:
>
> Kuniyuki, can you take over, thanks.
>
> commit 5108a64604b6f2fad06383386d8d5bc44f0cf35b (HEAD -> net-4)
> Author: Eric Dumazet <edumazet@kernel.org>
> Date:   Wed Oct 28 17:14:04 2026 +0100
>
>     tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
>
>     A successful connect() of an IPv6 socket to a v4-mapped address
>     switches icsk_af_ops, sk_backlog_rcv and af_specific to their
>     IPv4-mapped variants. These are only restored if the connect() fails.
>
>     After connect(AF_UNSPEC), the socket can be reused for listen() or
>     for a native IPv6 connect(), while still using the mapped handlers.
>     IPv6 packets processed from the socket backlog are then handled by
>     tcp_v4_do_rcv(). tcp_v4_send_reset() and tcp_v4_send_ack() interpret
>     TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo()
>     can overflow its 40-byte destination buffer.
>
>     Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
>     ehash and lhash2.") prevents listen() after connect(AF_UNSPEC), but
>     a native IPv6 connect() is still allowed.
>
>     Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
>     socket is disconnected, and use the same helper in the connect()
>     error path.
>
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>     Reported-by: Tong Liu <lyutoon@gmail.com>
>     Reported-by: Qi Tang <tpluszz77@gmail.com>
>     Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>     Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae1b43a4d53173b46b931ae668825..a93410aab66e6f441d70cf70c=
67e6d92fbb5fb26
> 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -130,6 +130,19 @@ static int tcp_v6_pre_connect(struct sock *sk,
> struct sockaddr_unsized *uaddr,
>         return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
>  }
>
> +/* Undo the v4-mapped setup done by tcp_v6_connect(). */
> +static void tcp_v6_restore_af_ops(struct sock *sk)
> +{
> +       /* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
> +       WRITE_ONCE(inet_csk(sk)->icsk_af_ops, &ipv6_specific);
> +       if (sk_is_mptcp(sk))
> +               mptcpv6_handle_mapped(sk, false);
> +       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
> +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> +       tcp_sk(sk)->af_specific =3D &tcp_sock_ipv6_specific;
> +#endif
> +}
> +
>  static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uadd=
r,
>                           int addr_len)
>  {
> @@ -243,14 +256,7 @@ static int tcp_v6_connect(struct sock *sk, struct
> sockaddr_unsized *uaddr,
>
>                 if (err) {
>                         icsk->icsk_ext_hdr_len =3D exthdrlen;
> -                       /* Paired with READ_ONCE() in tcp_(get|set)sockop=
t() */
> -                       WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
> -                       if (sk_is_mptcp(sk))
> -                               mptcpv6_handle_mapped(sk, false);
> -                       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
> -#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> -                       tp->af_specific =3D &tcp_sock_ipv6_specific;
> -#endif
> +                       tcp_v6_restore_af_ops(sk);
>                         goto failure;
>                 }
>                 np->saddr =3D sk->sk_v6_rcv_saddr;
> @@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
>         return 0;
>  }
>
> +static int tcp_v6_disconnect(struct sock *sk, int flags)
> +{
> +       int ret =3D tcp_disconnect(sk, flags);
> +
> +       /* A socket used for a v4-mapped connection must not keep IPv4
> +        * handlers when it is reused for listen() or a native IPv6 conne=
ct().
> +        */
> +       if (sk->sk_backlog_rcv =3D=3D tcp_v4_do_rcv)
> +               tcp_v6_restore_af_ops(sk);
> +
> +       return ret;
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  /* Proc filesystem TCPv6 sock list dumping. */
>  static void get_openreq6(struct seq_file *seq,
> @@ -2283,7 +2302,7 @@ struct proto tcpv6_prot =3D {
>         .close                  =3D tcp_close,
>         .pre_connect            =3D tcp_v6_pre_connect,
>         .connect                =3D tcp_v6_connect,
> -       .disconnect             =3D tcp_disconnect,
> +       .disconnect             =3D tcp_v6_disconnect,
>         .accept                 =3D inet_csk_accept,
>         .ioctl                  =3D tcp_ioctl,
>         .init                   =3D tcp_v6_init_sock,
