Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311764;
	b=hKCfeTIrZN5yZUGVCl4RKCEwLg/k74WvzI21r0fPM877CKYQU8SK0kO489AM7V5iI0pL
	 VzVO9R863haQdkLKIBKzkpXJ7Jb+OOLZeI4eCG9/sdLSHFXf/RHpakh3UOTQc4qZN9uES
	 mYnkRlP8nBXzJWs8YBBYkXIoxpSSNfRLe70FtRZg68QO4SXKgGTt+VBAQv/c5ZjmmVwBg
	 Vq3N3M26yl9+OvJ79qnsdrwapD0+SumtYLkrDYNwfXX8I0HFIMfa+RefuJ4w1x5lh+ADF
	 Ui7NTpnTN2IwJp/uPrSbZB3pmrsQTsRrSq8zO3jeh8R3t0N+gSXWN4oHh7yBu3RoEnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wN1QZuqk50CoSPDgAsnyPn7ZMz6ZPRvw9NxirNW+1eU=;
	b=ekpTF/HOoTbfhkA5bdMW/oj9+1+Frwva5b2sLop9nFCpbSOi2n/t8cYdmhrRngD1aUEU
	 yU1is6smAuOxnkqShejqhM6MKXDXwhZt/MD9ozU+2mXzT+Rc3CDplF5NKcLEqHhYvm554
	 igcQctYgFkt5Z/gKowZVdW/uwlhs/g9h4QrtU1teKECvqjy4beil9nEKZ54xH0c7036AW
	 Uf/1/NOqzQObnsYMMAC4EjQDRtVbNmSbfQqYEO6nbRfgI9fWNy2VRPGxYApinGNM+AHmc
	 I4qeTeCrHv7rPPAYdgSpaYkUvCu0WuL4eQBwc9deotu9d+WgtpgkMDmeRvTsn/h4sfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hlaLD3sz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A4606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 22:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hlaLD3sz
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso101869a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311762; cv=none;
        d=google.com; s=arc-20260327;
        b=dM2U+qApvXDOXsbSKRnOpdN4k3OA7UtTLEQkvAYyYhms95ndXnhmC73arGTExTh7Le
         mIT101GH62Vrziszv5X4Cr0zGTtcTa6rPYyWrol+KiC+5MIeD5pvHoYa7csyYRjpPvfX
         vWOzHDvdVnNOq4HGFkJ5oDF5nUpt+hU3xmWC5WFyjCWpprlKTazC9uLJWqmAzaQ1KNp3
         ZAjYW8CsfPkg1QkRWeL9Dl69lPUwEkiu+8g1+j36OyrjDnjKbjp8nq4Ty3AMFc8gJ1EO
         XnuTdJhEdw5Kjl3vJmSV9lic3+Goc18UGrRcMTY7Gfe5cwJnaVKnH2cqCa1kZbJat9J9
         mTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wN1QZuqk50CoSPDgAsnyPn7ZMz6ZPRvw9NxirNW+1eU=;
        fh=j4TCEVeXtP+kUrXOguLHVcsXPXRw8s7SAW3Wkcq0PgM=;
        b=S829E448KjSDD17rGbRaxOrCZLeEzXrQ7uQ93ZxhyGOW6kpI/gr/niT0pWc8XdUCKg
         eIp4ugUjSYH3q4JbZ68aIOCD61rE98ieqKvIP41D2eSAe3TMEs3cgzgd04njWB7LvUKe
         /Su4w7FCnB90m26rNKxEOSvzJRnJt6wrHjStePlpsc32QnExo16xKkihIiXObR/xKAMT
         0+roOJNnj/71sSSxdaUSW50Eea3yjngaGkwdsVRk2+wU6yuBgtObt+a2vPoutjQchzNI
         TG129j1Cl8w67Zgxs1muXuvZCdGTIaYIrd5aqZ8y4N4k/R9pG4Nui2Ayci9rkKtsrMPI
         TUXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311762; x=1793916562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wN1QZuqk50CoSPDgAsnyPn7ZMz6ZPRvw9NxirNW+1eU=;
        b=hlaLD3szJf1k72AAVSjwghaL8/MJqDKT6+xr9yFj1bsgVm+nsEKuiVt7W4t+7cJ6Ly
         9QExBgVTyI5jgCx6OXLcw93fpygWg6rt2ugWN+kiw7C9+2JHX7UVlikFfnujyfz4F7Jb
         XggPOLQ/B2X+BXXGVrFykZmKL5KS8afiHES7qC+SOr4CViHTQx4WXXTPwrmTehza5YSQ
         D8gzXpXDnAVZloLiGowhMfzeVHOvgnm+40GiubRVKG6QYEtUwofvmytug688dvaMdXO6
         JVyRopErAQRxLDP4YzCfx1OAYrUuApOs+R4qV6CZZqvlYi3aralADjuTQgl0q8o1ZhqT
         FMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311762; x=1793916562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wN1QZuqk50CoSPDgAsnyPn7ZMz6ZPRvw9NxirNW+1eU=;
        b=FrgWtcdeMt4jy8kZE0jlZk0DX2e8XNH7Oumg1SnOR3lT27EOjrjByG2ZMECaiuQpS3
         NnySj2T4iX4BPr0SB8HE2TZHPWc9yGiGsRiKt7l6WyGBsApUYunLiocLrkEaIu7hvtG2
         T0a0LX8Wi3plwghWp1h2Nt/gAN/7+zxP2uQDD8tbioyUk3xjgoOpdXTdm5jPvH0z0Rlt
         SBbLjwHsUmvp9qxAFtpf3ANKzUkRFh4oflEN9VGE5XlbGN+QuBZWwm7C8AunKySFi6rV
         goxPNMLYRR8hh9xX3ncKURZMfMEnASYYNJakBSr+iqF76ek+Ec4e3ehGK+LAJxam9PK+
         7iKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwx3IQEptYV/g/DgBeZlFRJBgs9jWrk4sVelj7LSFkzYVB76kmEzGX8SA0LXjDqBTE2mIAruQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFMwg5aVocC0uD/DRAvI+N5KcakpgpnvYtc0yzjdjtQ6AQ1q5D
	oOhiCOP48B+8G0pW07R44W/gjv009YXwa5w/NkHDsOWfZnLuXJqHuBXfQ7Ssw07DPeMKs/pjqog
	ctySaU5wcpIe0LXsaj2tw32O+xdrknCiK7OBmb0r8
X-Gm-Gg: AYBFou1jHsH7gCBVtyMfS8clcW4O/73kToBlAW4NA6SiVqv2qtgocbqYwhR5a+grA2I
	SIroa+AGmecFGunzX5g7OT4a1bOi9yWBqXoX+1CT8aLreA9KdCm9cBhc7gn/Tftk9y9kWcmxj2z
	aOmMglACQn5DNcWEa+7LqfWxs2gHHXjC+hYOQ0LAe4i7N36ie3m4o7dU4ioRboTK43Na03jtt2q
	zhsrXaSeNspgKV2qY3wDx12p9abMDQhCA/evOIy+8salpxFbKltd69kdoHLbEl9wKIlhO0EKgk1
	+8JHOD1tilLHdmxIrLm7Gy8RziV0dEuCWBW6mqVZW89/8WXhXdnJ9+MtAuT225Cqlvk46mgwYhu
	5OAopHMSaHUg5vjWlOKz3h56BkbS4Lc4PtCbtoy6oeWpbrFKgzkw8vhCDsZHHX+3r4MRmIybYGV
	KQUqiBzy+e0XYvq380RnvbSJI2X6Ql/B11L2qPtCte4WybC+uUn9+S0Y6wB1gGqKSYLSkFInXXr
	F9NTzZEQw==
X-Received: by 2002:a05:6402:501c:b0:6ac:afa3:6f72 with SMTP id
 4fb4d7f45d1cf-6b4d3372a2amr288181a12.5.1793311761310; Thu, 29 Oct 2026
 15:09:21 -0700 (PDT)
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
 <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com> <CALf2hKtiCaiabDQGpm+jzy7VKgMr78eQTKGsN10aXp0JfaOhLA@mail.gmail.com>
In-Reply-To: <CALf2hKtiCaiabDQGpm+jzy7VKgMr78eQTKGsN10aXp0JfaOhLA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 29 Oct 2026 15:09:05 -0700
X-Gm-Features: AclHuK8UuBiGBCuoGNxdg2iHLMTZpWhIDzpQqa17etVcIPrvfaNwmI8YeGEMccI
Message-ID: <CAAVpQUA3meY_3XbXsj_OG_Gqg=b5+QA6DLuMZVOmTVWHudcjqQ@mail.gmail.com>
Subject: Re: [BUG] tcp: cross-family IPv4 option echo stack overwrite
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, ncardwell@google.com, 
	dsahern@kernel.org, idosch@nvidia.com, brauner@kernel.org, 
	dhowells@redhat.com, lyutoon@gmail.com, tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dropped security@

On Wed, Oct 28, 2026 at 11:15=E2=80=AFPM Zhiyu Zhang <zhiyuzhang999@gmail.c=
om> wrote:
>
> Hi Eric, Kuniyuki,
>
> I kept Eric's tcp_ipv6.c change unchanged and added the missing MPTCP
> coverage. Two MPTCP paths called tcp_disconnect() directly, bypassing the
> protocol-specific disconnect callback. The changes below route them throu=
gh
> ssk->sk_prot->disconnect(), so IPv6 subflows run tcp_v6_disconnect() as
> well.
>
> I tested the combined change on net.git at 94cea342e891 with both TCP and
> MPTCP by reconnecting an AF_INET6 socket from a v4-mapped peer to a nativ=
e
> IPv6 peer after connect(AF_UNSPEC).
>
> The related watch_queue report and patch are:
>
> Report: https://lore.kernel.org/lkml/CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkH=
yp9yPbjORWFXagA@mail.gmail.com/
> Patch: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang99=
9@gmail.com/
>
> I have not posted a standalone [PATCH net] to avoid duplicating Kuniyuki'=
s
> work. If you would like me to submit this completed version, I can send i=
t
> right away:

Please do so.  I'm not sure why you were wondering so even
though you said you'd post a patch asap, but one thing...


>
> From ffa42bc88b0221619f6eadb3a7f5c38328a258cb Mon Sep 17 00:00:00 2001
> From: Zhiyu Zhang <zhiyuzhang999@gmail.com>

I'd keep the original author as Eric.

Thanks.

P.S. do not top-post on lkml.


> Date: Thu, 29 Oct 2026 01:58:37 -0400
> Subject: [PATCH] tcp: restore IPv6 af_ops on disconnect of a v4-mapped so=
cket
>
> A successful connect() of an IPv6 socket to a v4-mapped address switches
> icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped variants=
.
> These are only restored if the connect() fails.
>
> After connect(AF_UNSPEC), the socket can be reused for listen() or for a
> native IPv6 connect while still using the mapped handlers. IPv6 packets
> processed from the socket backlog are then handled by tcp_v4_do_rcv().
> tcp_v4_send_reset() and tcp_v4_send_ack() interpret
> TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo() can
> overflow its 40-byte destination buffer.
>
> Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
> and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native IP=
v6
> connect is still allowed.
>
> Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
> socket is disconnected, and use the same helper in the connect error path=
.
>
> MPTCP subflows override sk_prot, and two teardown paths call
> tcp_disconnect() directly. Route those calls through the protocol-specifi=
c
> disconnect operation so IPv6 MPTCP subflows receive the same restoration.
>
> Tested with TCP and MPTCP by reconnecting an AF_INET6 socket from a
> v4-mapped peer to a native IPv6 peer after connect(AF_UNSPEC).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=3Da3+jUHtPohxbra8=
gox+aYAfWathJnn-J+Q@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=3DTWRpukCq6q=3D-7296=
58FwGvieNcPXe97kLvQ@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999=
@gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> ---
>  net/ipv6/tcp_ipv6.c  | 37 ++++++++++++++++++++++++++++---------
>  net/mptcp/protocol.c |  4 ++--
>  2 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360ea..a93410aab66e 100644
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
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7a22e9388e0e..fdfbc7de2ec0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2608,7 +2608,7 @@ static void __mptcp_subflow_disconnect(struct sock =
*ssk,
>                 /* The MPTCP code never wait on the subflow sockets, TCP-=
level
>                  * disconnect should never fail
>                  */
> -               WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> +               WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, 0));
>                 mptcp_subflow_ctx_reset(subflow);
>         } else {
>                 tcp_shutdown(ssk, SEND_SHUTDOWN);
> @@ -3287,7 +3287,7 @@ void mptcp_subflow_shutdown(struct sock *sk,
> struct sock *ssk, int how)
>                         break;
>                 fallthrough;
>         case TCP_SYN_SENT:
> -               WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
> +               WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, O_NONBLOCK));
>                 break;
>         default:
>                 if (__mptcp_check_fallback(mptcp_sk(sk))) {
> --
> 2.34.1
>
> Thanks,
> Zhiyu
>
> Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 00:22=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Le mer. 28 oct. 2026 =C3=A0 16:31, Zhiyu Zhang <zhiyuzhang999@gmail.com=
> a =C3=A9crit :
> > >
> > > Hello Linux Kernel Developers and Maintainers,
> > >
> > > We found a TCP address-family mismatch that lets an IPv6 packet reach=
 an IPv4
> > > reply path. The IPv4 path interprets IPv6 skb control-block fields as=
 IPv4
> > > options and copies a packet-controlled length into a 40-byte stack bu=
ffer. We
> > > used it as the write primitive in a demonstrated unprivileged uid-to-=
root
> > > chain.
> > >
> > > The complete path is present in v7.3
> > > (c03c1a14507dfaf8b856c2608f9ac216021fc222), where we reproduced the
> > > privilege escalation with KASLR, STACKPROTECTOR_STRONG, PTI and IBT e=
nabled.
> > > It is also present by inspection in v6.12.95. CONFIG_IPV6 is required=
.
> > >
> > > Current mainline d135ab453a7400a34930bdda1ef4bdc8acfac80e contains
> > > 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash and
> > > lhash2."), which rejects the exact socket transition used by our repr=
oducer.
> > > We therefore do not claim that the complete chain works at that mainl=
ine
> > > revision. The unsafe cross-family option handling and unbounded optio=
n echo
> > > remain relevant to maintained trees without that transition restricti=
on.
> > >
> > > Root cause:
> > >
> > > tcp_v6_connect() changes icsk_af_ops and sk_backlog_rcv to the mapped=
-IPv4
> > > implementations after a successful v4-mapped connect. On affected ker=
nels,
> > > connect(AF_UNSPEC) returns the socket to TCP_CLOSE without restoring =
those
> > > pointers, and listen() reuses it. A pure-IPv6 accepted child can cons=
equently
> > > have IPv6 lookup state but tcp_v4_do_rcv as its backlog callback.
> > >
> > > For an [IPv6][DSTOPTS][TCP] packet, tcp_v6_fill_cb() stores inet6_skb=
_parm in
> > > TCP_SKB_CB(skb)->header.h6. If the packet is drained through tcp_v4_d=
o_rcv(),
> > > tcp_v4_send_reset() passes the same union bytes as header.h4.opt. The=
 aliased
> > > metadata directs __ip_options_echo() to read a packet-controlled opti=
on length
> > > and copy it into the 40-byte dopt->__data buffer. Our trigger produce=
s a
> > > 254-byte overwrite across the canary and return address in
> > > ip_send_unicast_reply().
> > >
> > > The receiving process runs as uid 65534 without capabilities or a use=
r
> > > namespace. A root helper is used only to inject the crafted IPv6 pack=
et with
> > > a raw socket inside our single-VM test; the packet may instead arrive=
 from an
> > > IPv6 peer.
> > >
> > > This is the memory-corruption half of the demonstrated privilege-esca=
lation
> > > chain. A separately reported watch_queue disclosure supplies the same=
 task's
> > > stack canary and KASLR slide. We will reply with that report's Messag=
e-ID as
> > > soon as it has been posted.
> > >
> > > Reproduction and fix:
> > >
> > > We have a source reproducer, exact config, QEMU instructions and a fu=
ll-chain
> > > exploit. In accordance with the kernel policy, we are not posting the=
m publicly.
> > > We can provide the source-only reproducer privately if a maintainer r=
equests it.
> > >
> > > Our build- and QEMU-tested fix has two layers: the IPv4 TCP reset and=
 ACK paths
> > > only pass IPv4 option state for ETH_P_IP skbs, and __ip_options_echo(=
) validates
> > > each option against the declared source area, the actual skb header a=
rea and
> > > the remaining destination space. We will post it separately as a merg=
eable
> > > [PATCH net] email and link that thread here.
> > >
> > > AI-agent tooling assisted in identifying and analyzing the issue, dev=
eloping
> > > the reproducer, and preparing the initial fix. The reporters reviewed=
 the
> > > affected paths and reproduced the issue and the fixed result in QEMU.
> > >
> > > Reported-by: Tong Liu <lyutoon@gmail.com>
> > > Reported-by: Qi Tang <tpluszz77@gmail.com>
> > > Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> > >
> > > Best regards,
> > > Zhiyu Zhang
> >
> > Worst report I got this week, and trust me I got many security reports
> > in the last 3 days
> >
> > Why don't you ask your LLM to prepare a patch ?
> >
> > Why CCing security@ at all, since you made this report public ?
> >
> > Have you read Documentation/process/security-bugs.rst ?
> >
> > MPTCP is not yet covered in this untested WIP:
> >
> > Kuniyuki, can you take over, thanks.
> >
> > commit 5108a64604b6f2fad06383386d8d5bc44f0cf35b (HEAD -> net-4)
> > Author: Eric Dumazet <edumazet@kernel.org>
> > Date:   Wed Oct 28 17:14:04 2026 +0100
> >
> >     tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
> >
> >     A successful connect() of an IPv6 socket to a v4-mapped address
> >     switches icsk_af_ops, sk_backlog_rcv and af_specific to their
> >     IPv4-mapped variants. These are only restored if the connect() fail=
s.
> >
> >     After connect(AF_UNSPEC), the socket can be reused for listen() or
> >     for a native IPv6 connect(), while still using the mapped handlers.
> >     IPv6 packets processed from the socket backlog are then handled by
> >     tcp_v4_do_rcv(). tcp_v4_send_reset() and tcp_v4_send_ack() interpre=
t
> >     TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo()
> >     can overflow its 40-byte destination buffer.
> >
> >     Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
> >     ehash and lhash2.") prevents listen() after connect(AF_UNSPEC), but
> >     a native IPv6 connect() is still allowed.
> >
> >     Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapp=
ed
> >     socket is disconnected, and use the same helper in the connect()
> >     error path.
> >
> >     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >     Reported-by: Tong Liu <lyutoon@gmail.com>
> >     Reported-by: Qi Tang <tpluszz77@gmail.com>
> >     Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> >     Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> >
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index e006a30360eae1b43a4d53173b46b931ae668825..a93410aab66e6f441d70cf7=
0c67e6d92fbb5fb26
> > 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -130,6 +130,19 @@ static int tcp_v6_pre_connect(struct sock *sk,
> > struct sockaddr_unsized *uaddr,
> >         return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
> >  }
> >
> > +/* Undo the v4-mapped setup done by tcp_v6_connect(). */
> > +static void tcp_v6_restore_af_ops(struct sock *sk)
> > +{
> > +       /* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
> > +       WRITE_ONCE(inet_csk(sk)->icsk_af_ops, &ipv6_specific);
> > +       if (sk_is_mptcp(sk))
> > +               mptcpv6_handle_mapped(sk, false);
> > +       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
> > +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> > +       tcp_sk(sk)->af_specific =3D &tcp_sock_ipv6_specific;
> > +#endif
> > +}
> > +
> >  static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *ua=
ddr,
> >                           int addr_len)
> >  {
> > @@ -243,14 +256,7 @@ static int tcp_v6_connect(struct sock *sk, struct
> > sockaddr_unsized *uaddr,
> >
> >                 if (err) {
> >                         icsk->icsk_ext_hdr_len =3D exthdrlen;
> > -                       /* Paired with READ_ONCE() in tcp_(get|set)sock=
opt() */
> > -                       WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
> > -                       if (sk_is_mptcp(sk))
> > -                               mptcpv6_handle_mapped(sk, false);
> > -                       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
> > -#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> > -                       tp->af_specific =3D &tcp_sock_ipv6_specific;
> > -#endif
> > +                       tcp_v6_restore_af_ops(sk);
> >                         goto failure;
> >                 }
> >                 np->saddr =3D sk->sk_v6_rcv_saddr;
> > @@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
> >         return 0;
> >  }
> >
> > +static int tcp_v6_disconnect(struct sock *sk, int flags)
> > +{
> > +       int ret =3D tcp_disconnect(sk, flags);
> > +
> > +       /* A socket used for a v4-mapped connection must not keep IPv4
> > +        * handlers when it is reused for listen() or a native IPv6 con=
nect().
> > +        */
> > +       if (sk->sk_backlog_rcv =3D=3D tcp_v4_do_rcv)
> > +               tcp_v6_restore_af_ops(sk);
> > +
> > +       return ret;
> > +}
> > +
> >  #ifdef CONFIG_PROC_FS
> >  /* Proc filesystem TCPv6 sock list dumping. */
> >  static void get_openreq6(struct seq_file *seq,
> > @@ -2283,7 +2302,7 @@ struct proto tcpv6_prot =3D {
> >         .close                  =3D tcp_close,
> >         .pre_connect            =3D tcp_v6_pre_connect,
> >         .connect                =3D tcp_v6_connect,
> > -       .disconnect             =3D tcp_disconnect,
> > +       .disconnect             =3D tcp_v6_disconnect,
> >         .accept                 =3D inet_csk_accept,
> >         .ioctl                  =3D tcp_ioctl,
> >         .init                   =3D tcp_v6_init_sock,
