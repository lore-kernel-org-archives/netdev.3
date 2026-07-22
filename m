Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863730F548
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746214; cv=pass; b=DRncwsOPEyWsofjlg+oD3xKhwZxgUBUeUeSE/eOO6EbQMCxZo0U8Rs5UDcXSgyJCPYocl5dw87904435v1UJU5xPcFEuIjCoDBlsXd1/nN++J23JDep7eJijKQwTwrdkNHVTctcaXD6feL6OU5eM/wcqVUQmM1gfhpwA4fiacEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746214; c=relaxed/simple;
	bh=LpzHZjjw9WWzYVr2KkbWNQpkV9bpn8GytcGc6ODCG0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm403mzkE9gSNCpVQWbT8mQcxwzyysF4ZHY5hDVpCbsMxVzzkT3a88R7IqEkLFuflGzrN+uV9j1ytTm0Pxp7JXZkpRcxB7OHFwnMaSaAqFGu1kKfgpyHEuVcHUkAd7Qlx1py0ujDQsaiSCbqLt7+RFamKJMokiFFb//NoNKcRZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwRLDPSl; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwRLDPSl"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-930c0f9c1b1so498712285a.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746211; cv=none;
        d=google.com; s=arc-20260327;
        b=C5F7LCAzxW3ZhI9XwlioSFMU/MD+HLnScUEMZ2emEw7YuBiNtkyudErJm19mnDDlFU
         XKNG0CQKOGm92ySK2w1mpwlWCnW26W1hZu5UImYB5Y50LvGTpYB+Ujq6dzj6w84KFLsV
         HTorQX+CTpUxmhd1zlo08AAKS2cLDbQVmOhl5uJlC6jEKTq4mQ3q2Zux6OdLlskGR//W
         bGpof57u2h+rpih8GZYhPnCIIYauepSgnt4T0mPhF/W6dZM/KASBc+qw2UwycEJWv05K
         tqSlBCV9KJUIY3+oLohD+eHk/njBKx9rizUHBNQUtCZ4hypHuzi+dWqn1XGl5RDUAjPC
         tDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=81PqcakE3vFqwcrUKH8WKjOfwB48ApktmKwcHNXwN8w=;
        fh=C+I1VaeQ9mAbxqpVuHm7PuNlUTo4HR0d2SqJrS3jR/0=;
        b=TVvJJlusCX5JG+UVW84NtC434rraqFiU+fnepIM6oxPSfC+DKZyF3Br3bk7JKe/jjP
         b3En87DNXflAA0gx3yD7u2WfP3ubCkrHKu55HQOXjT52EI/mB8RXAu1Fjibj8Yqq6Uyo
         kDlvXzqbDt1aeI2PyX/CoK/nMOzCDr6K9Ao9mXhMa42wIDZIvuWEzQpXAy/iMpZfoDgc
         bq2kt4KNur5QD9FPN1XP+Pri5I2yvSZ8pJh0yiZ9FW9z/H3CXgC49P0U2UhuCWq54hwT
         Bg+GBbdl/fKYE2rKmG54RNZpdgXCv0F2LQZ9bXW/Ctvy+zw0TAM8XJxl7l3hm0B27ZK0
         I2EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784746211; x=1785351011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=81PqcakE3vFqwcrUKH8WKjOfwB48ApktmKwcHNXwN8w=;
        b=TwRLDPSlaqKU0KTwYCWF45jMW5DZy9g9q0wP1M4K2l95JKX7p6gpHEKrMu7LYoe0/O
         XWTxPsO99B52ZaJD0d6YH1MbVhYO+8PNUDnrKP/53zlhjsc8kEbFZXdc7Op0K+TPjrJy
         sd1k37lE1LibVdk9GR1EH2B+mDIQecfIo9+KbonwbO8v7aKqWfT5QfOJt85vxhW7aSU0
         KQGQtxG+WgQnRCbSnYTgmo+YrRE+Q1v1TiK2xWzaNKPL24TirIGAVOSVfL+qmuo/PURY
         9adM9Cwl97B4NotDScBIBFZcxl/eppm78HqPzzdAMZmcB7q8oHT6KOhyY3p5pxHzqxVD
         A8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746211; x=1785351011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81PqcakE3vFqwcrUKH8WKjOfwB48ApktmKwcHNXwN8w=;
        b=rLfJzPYBOwJlKZY/s+6kece7F+gxezBF07zEWWTUwx7b8pYtM5mZHvbyPetudXmMQb
         xgIWmTNte+OSk9rbAxEaeKkyep0Aq8eLeNabBKvTFI2x2Vv/xgBQWX77c8pyBfI3q0bm
         zq6Ex4vr5MDYRgEEKYyidAgUXmLAg8uJpsani1jPINqNdBv+4XSm9HOO5luEYzzdDvql
         yKIs+8u3+L1bFY62JZp9L8rMKL3I2JVVRv3uWLSgArNWhLgBGIlhdbnblw14/GG3DcJF
         yVKLMpNPprZ1N1ZIRXurjUWWcz8MM2iO4uRQbJ67aAc9g8dGxvNuACX9S2ibDN0qYzcI
         pq+A==
X-Forwarded-Encrypted: i=1; AHgh+RrjOhSMoOvEswUYYkBQwSo10cQ8k5ToVrqMD+3dgfm8mq4rHAkHUEwdwnHAu495QB5VCOXEqB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDCqIo4ssaFhUF7HwSm/YHuEyVaaqe0mmDhhZJ6oZdlptXQQP
	p/Dc/E101tN83MXopm50jBY7IND0yL+4YmZKAGYDb3HptmYbkjMdxULN/kpvC43/LzrIejX734g
	WxTSJYqmIIZogt4uzjEn3LNqqRmPOmBSbUcFa9BhU
X-Gm-Gg: AR+sD11L6iI0xu8MzOV67wo6WZdli/VNnmFcmqxdkd+TTOTvbvHpQbORcVySr+zmRcV
	xt62YgW/RSZY9f2R9bckCBZxNbjt3Mv/VQnPAMmMjJQ5Kp9EsC1Xj0UftO1Cmq/oI2sEKs/2kwb
	w2kp+w2gZclPYhx/yfE6K4mXuHXVHtTVVSC+cifrQuw6NYFppzTOFF9UliFrhtMNTikhe9isKhY
	wpK8fuXzXCrGqmMNi0K7hJIKKjVmWz4fG3F3IK7/0kmhA+Cw4Anxyf/13kjPUqel7Gk5TY8itSL
	wIDhODszlltTzRPnNL3ueyI23tBGrEK+f+pyhI+eqdlpMEp968bMFlbZJ/lVEPTalI70571BwXa
	lNS4JcY8=
X-Received: by 2002:a05:620a:2781:b0:930:a3f9:93be with SMTP id
 af79cd13be357-930b41e3f78mr2166588085a.45.1784746210540; Wed, 22 Jul 2026
 11:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722170033.2763794-1-tejasbirajdar@meta.com>
In-Reply-To: <20260722170033.2763794-1-tejasbirajdar@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 20:49:58 +0200
X-Gm-Features: AUfX_my4Md1AiO3X81lIV1evIfaK05NsCXHOiqWRa_MlvfcNKZaAVltr3zCh0w4
Message-ID: <CANn89i+WLbtLYNjYipH+8=6nrq-XmdYY9TgHHNpeLLeuuvbEUQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active
 connect path
To: Tejas Birajdar <tejasbirajdar@meta.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 7:01=E2=80=AFPM Tejas Birajdar <tejasbirajdar@meta.=
com> wrote:
>
> BPF_SOCK_OPS_RWND_INIT lets a sockops BPF program pick the initial TCP
> receive window, e.g. to advertise a larger window up front in environment=
s
> where that is known to be safe. Today it is only effective for the passiv=
e
> (listener) side; on the active (connect) side the value is computed and
> then silently discarded.
>
> On the passive path tcp_openreq_init_rwin() inflates full_space when the
> program returns a non-zero window, so tcp_select_initial_window() can off=
er
> it:
>
>         else if (full_space < rcv_wnd * mss)
>                 full_space =3D rcv_wnd * mss;
>
> tcp_select_initial_window() only clamps the requested window *down* to th=
e
> available space, so without inflating the space first the BPF reply can
> never raise the offered window above tcp_full_space(sk).
>
> tcp_connect_init() calls tcp_rwnd_init_bpf() but never inflates full_spac=
e,
> so on connect() the requested window is clamped back to tcp_full_space(sk=
)
> (~64KB at the default rcvbuf) and the program's value is ignored.
>
> Mirror the listener-side inflation in tcp_connect_init() so both directio=
ns
> behave the same. tp->advmss is the mss the listener path uses as well (bo=
th
> are tcp_mss_clamp(tp, dst_metric_advmss(dst))).
>
> Fixes: 13d3b1ebe287 ("bpf: Support for setting initial receive window")
> Signed-off-by: Tejas Birajdar <tejasbirajdar@meta.com>
> ---
> Functional test: attached a cgroup sockops BPF program that sets
> skops->reply for BPF_SOCK_OPS_RWND_INIT on the connecting socket, and
> drove it with packetdrill on the active-open (connect) path (wscale 11,
> advmss 1440). On the patched kernel the advertised receive window on the
> first post-handshake ACK now reflects the requested value; unpatched it
> stays clamped at ~64 KB:
>
>   req_segs   unpatched   patched
>   256        ~64 KB      360 KB   (256  * 1440)
>   1024       ~64 KB      1.41 MB  (1024 * 1440)
>   4096       ~64 KB      5.63 MB  (4096 * 1440)
>
> (The SYN window itself is unscaled/capped; the offered window appears on
> the first scaled post-handshake ACK.)
>
> Regression: tools/testing/selftests/net/packetdrill run under virtme-ng
> on this commit vs its parent produces an identical pass/fail set (no
> newly failing tests).
>
>  net/ipv4/tcp_output.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e30..478e4951140f 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4101,6 +4101,7 @@ static void tcp_ca_dst_init(struct sock *sk, const =
struct dst_entry *dst)
>  static void tcp_connect_init(struct sock *sk)
>  {
>         const struct dst_entry *dst =3D __sk_dst_get(sk);
> +       int full_space =3D tcp_full_space(sk);
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         __u8 rcv_wscale;
>         u16 user_mss;
> @@ -4133,14 +4134,16 @@ static void tcp_connect_init(struct sock *sk)
>
>         /* limit the window selection if the user enforce a smaller rx bu=
ffer */
>         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> -           (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp =
=3D=3D 0))
> -               WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
> +           (tp->window_clamp > full_space || tp->window_clamp =3D=3D 0))
> +               WRITE_ONCE(tp->window_clamp, full_space);
>
>         rcv_wnd =3D tcp_rwnd_init_bpf(sk);
>         if (rcv_wnd =3D=3D 0)
>                 rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
> +       else if (full_space < rcv_wnd * tp->advmss)
> +               full_space =3D rcv_wnd * tp->advmss;
>
> -       tcp_select_initial_window(sk, tcp_full_space(sk),
> +       tcp_select_initial_window(sk, full_space,
>                                   tp->advmss - (tp->rx_opt.ts_recent_stam=
p ? tp->tcp_header_len - sizeof(struct tcphdr) : 0),
>                                   &tp->rcv_wnd,
>                                   &tp->window_clamp,
> --


LGTM, but it seems "rcv_wnd * tp->advmss" could overflow

I would suggest squashing to your patch the following fix to current code,
and apply the same logic to your added code.

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ddc4b17a826b52afa967e17d482403f373f2f72a..f8c1123aba433713f60b30fd4e1=
df7fe4f1860bc
100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -453,8 +453,8 @@ void tcp_openreq_init_rwin(struct request_sock *req,
        rcv_wnd =3D tcp_rwnd_init_bpf((struct sock *)req);
        if (rcv_wnd =3D=3D 0)
                rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
-       else if (full_space < rcv_wnd * mss)
-               full_space =3D rcv_wnd * mss;
+       else if (full_space < (u64)rcv_wnd * mss)
+               full_space =3D min_t(u64, (u64)rcv_wnd * mss, INT_MAX);

        /* tcp_full_space because it is guaranteed to be the first packet *=
/
        tcp_select_initial_window(sk_listener, full_space,
