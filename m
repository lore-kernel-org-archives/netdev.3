Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792775108;
	b=dqhms8YJND8CZVKz0iRKzO6DAJfR7DQ0nIlp8OMTELius4WIdsKFwphOj5Qbwc8r6X2Z
	 r3qr0h0e4gg8q0vaDTUdax+1EYYQaF1j3tAIsFzDWBTftZVin3+fFixBVbwwVhuK9Ejz5
	 9uvSM5qA3cdZ07HzqNKZhM98rmKEMuhgTzlaQ9CEcncabcUnTvwhvHl3ivdPIOZQPQjZc
	 GynnTTFKwernBg0Yx3A6o6tnptl67DRXPz0HyZlsCCr57GrU8U4dZU1oLJIeznyOhMJuW
	 Hv1yiAjuN6x27MhWHxVCJb8Gvx3icKZyloPPjd7Pw3LhtUGGAh/+hb143F0cX1XjTHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5mwwCva8nwrkvJev0pLVI8T+E8QDyvsyCFbv3XJ/ogQ=;
	b=lMoJsajrqHSjI0kLFRv5WhM1bICcZQJDrUjGbeX/BHrR0IJKriaA9ZG6bQhF5rp0xs3x
	 AI47n6fQu8CA4dUzQ3mVXSI5nP6INJhgWDPTf4dPdoUl+DqReKOIV2sbuIDY/HXCC7xk/
	 DL0WelFNJMfuX5aUObySB7hx/cvWcHx/J7x3H8XQyXAwa02RzRjILn3LxDf5562EEovgX
	 O8PSYam3B2hgFMQg7MXOvx9ZG/lg9u89wVKOYmOWr7CFit0RaZ2BYOr1sEeuxu17cZHuc
	 AexRVT4Xo2w4sbC4jDg2CHf5CC+4F58MyIG63X/NRTumLAzDx92mIb+BiP2faiT4VWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ro5bp7sj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F8606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 17:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 552F8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ro5bp7sj
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337fa12431so71cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792775107; cv=none;
        d=google.com; s=arc-20260327;
        b=YUN8RaXvg7fG3FImIvFcyTlWs85JpbUaZ1nuw+j6xwshyq9NuoTnPF3E7eL/OTHki4
         A6ild0/2FrEDroz1uHp8iwbZKA5L9WHOO9YJkCjT4/B7gd1WbNr0c9BKsyJCtosEY8YL
         cA4KF+yQd2t6rpl7jRd3qjLbexLrhF7drNX7k20dtl9iH8FfhVoqDtsFH3MaluirKqOj
         pFudMH61SFcXA/wUn59LEo3tkUbo6J7tyI1GEfFLoCq9m1huZKdTXVPbxNxoNnQbuVqV
         2OmVU07fogN94BIxOaGRbl9I4sCCueTXRpcAXtwrvQgOpt+E+6zAMzhbuah+isrI7w72
         wIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5mwwCva8nwrkvJev0pLVI8T+E8QDyvsyCFbv3XJ/ogQ=;
        fh=dkUi789owRvYEGvC61GkCsOXhHNpXioAqawUPUMotGc=;
        b=L6zynSmdW4TSMR7mhXKyXEXw7Hskv1x8IMtN+KD8HWa8qtsWhnyVkFS33HR5d/O6im
         gR5M6f2h5QdEVnjeilui8Fypff3ZPnfkPe7REJmcxF0mOGXNg8VnK9TmRlpHtr3zz12m
         qmBehvc7ygo8SIadFMGl4gOTYm1Cb/uZn7IzhfQQE4UR7mxD8Qefz3+A9UQpkAfNsXOM
         3vbaEoSpz4XE3mfkCwBiZnJEEkXb3LViXltCPU6HzT/0yhy2xShrfzsIW3xt1SPsLv93
         Y2ead4Rmtsm/KCxBYQMV6ryoIfbAIAjphcrx/IjVawKq0lBQ4Rse6/l8trn2yn2hgC1D
         z7Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792775107; x=1793379907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5mwwCva8nwrkvJev0pLVI8T+E8QDyvsyCFbv3XJ/ogQ=;
        b=Ro5bp7sj6/26bZBtvr3JqIBbuW+Aflx2aDxtUb6fIjcbFvWj7xUzBygAVpTGoDK2au
         WvmlIgS947gLIAOGzHBBfKicKfpby82m5S5REvM8uUZ7jJyNzJZIjSK0QIdFxNkMr6EL
         Gi2DtviYzP3cPDPocNag8eobvIu3orYaAJ/zgwF0oEWL4x482ZB7ZWNPNRyXzwMQ4KpX
         MA7gqzCutLGFHBgSuSU1oZJRKjJ2zIpjO8gDW6rJ3GNAGJRJ8UFiSz5ALdWvAJzWIOel
         VmOsVzyLKSM4H1oG7U0PX2LrpaOSn1nuG3Wy5c+ZfNsdtD1Yex5CsO+F4EkD6TVx95jz
         cAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775107; x=1793379907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mwwCva8nwrkvJev0pLVI8T+E8QDyvsyCFbv3XJ/ogQ=;
        b=gDdT2J9IMI8jfnvEudJb0qrFSM2nW+XpYtjbNVTUrcrXI5QqjHMlXjWygdxWLL9vXi
         IH6lSqNPky6/q9I/J4Zzq7JcN2bRRZShl7Mz/aQ2rm9dtOWssAyYLVfBQIo70SQBN/yW
         lgJaQumNjbT05IN+nhEVt6ZSb194iWqOJjpCnV37SAh+FjlAVEtN45NpSoGlafygxHem
         +IdrZW2nhMjRcrYPV7nN8SJFEi18L1bXe1fVRr/AXSBWnAmAw5amhilgyYs44SZ6oNss
         xU4s4gUWaFac62xrIRs1KDwu4h6Y0rK1JLQpLywiEFYM3dVD4ZnUef2lJ1BC6WLAEDsx
         w6SA==
X-Forwarded-Encrypted: i=1; AKwUvByGU92gEWPcgXvXWaxvUA5k0sHbKJQ4tipQrmaGMuOcpfc4XZ62Fr+unpTkodYZp5LM1+wr4KU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTNSKPxmYEoYhEik1cTTF1JkS8v1ycvRkarg2sy77nRRzWypPx
	5wtqF8qmZAhQURBbAEXblJRmi22Ucfvc1nFN+R5X/krVkfFBQaPr46KBBUMTHM87O5lZ5aoN6kI
	/V2yTcac7mNDGS5hYHPB8QSIcCiAvqYBfhPeTlsVX
X-Gm-Gg: AYBFou1bBdGSMn3JDwX13xD+lFI5fFZlMtlKyNluDU1qdyJ74LevNIY/ZzARuZzKW4Z
	v440F5dlo1k33jxJWAx39SxjSXE4sn0E+6q3ufv3I3PTkqYvkPx/gxOhxgmBxX8/A8Aqm4pSjko
	HpqaO1UY1a9X2S/bszenNQl2w1RaoCCi6i5xyyXKIF9QTQFS72W1WNTnlVaJpyzlmo/k7uY2ap0
	oZqNrsEI0uc8zOHcYDN9L7SykTFFmpycukhlWz+cQw7VNvUITTcNcl6K6eyjow6Nl3EOu8NERfm
	pQmP679MazEHcvsAcA7NHgDl/fN/09WNWR+zsxurzXHrk5/62RiNsdacZ6emHxFE4/olf+IL954
	F5IP/HslnzOND865PNCV7ySWH0R2um3B7dZxsB/SK+Zgk4BRa6Z2vAReNJ04Ka33N7BhuQ6OFRm
	pe2MP8/OADr8ceQe11HfAlGWs=
X-Received: by 2002:a05:622a:591a:b0:536:35e0:4f97 with SMTP id
 d75a77b69052e-536c48e852dmr1164901cf.11.1792775106358; Fri, 23 Oct 2026
 10:05:06 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
 <20261023161013.3079347-1-ncardwell.sw@gmail.com>
In-Reply-To: <20261023161013.3079347-1-ncardwell.sw@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 23 Oct 2026 13:04:48 -0400
X-Gm-Features: AclHuK-92dG441HaooN8rnQ969chIph7pkWJTm9ZPlDhMci-5_lVrvnJ5MRxBdk
Message-ID: <CADVnQymSV+Z9T_XSELAeoE46CNVAK2XveHb4s6ntLvSn8fw_Pg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: gnault@redhat.com, Tom.D.Williams@morganstanley.com, davem@davemloft.net, 
	edumazet@kernel.org, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, ycheng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 12:10=E2=80=AFPM Neal Cardwell <ncardwell.sw@gmail.=
com> wrote:
...
> Below is a proposed patch, cooked by a frontier LLM and lightly edited by=
 me,
> that should factor in all these considerations. This is compiled but not =
yet
> tested. I will kick off some tests for it.
>
> ~~~~ possible patch:
>
> Currently, FLAG_WIN_UPDATE (/* Incoming ACK was a window update. */) is s=
et
> in two places even when tp->snd_wnd does not change:
>
> 1. In tcp_ack_update_window(), flag |=3D FLAG_WIN_UPDATE is set whenever
>    tcp_may_update_window() returns true, outside the if (tp->snd_wnd !=3D=
 nwin)
>    check.
> 2. In the tcp_ack() header-prediction fast path, where tp->pred_flags has
>    already verified that the advertised window is unchanged
>    (ntohs(th->window) =3D=3D (tp->snd_wnd >> tp->rx_opt.snd_wscale)), lin=
e 4357
>    unconditionally sets flag |=3D FLAG_WIN_UPDATE.
>
> This causes two issues:
>
> First, on the slow path in tcp_ack_update_window(), a pure duplicate ACK
> (ack =3D=3D tp->snd_una) with an unchanged window (nwin =3D=3D tp->snd_wn=
d) still
> satisfies tcp_may_update_window() whenever after(ack_seq, tp->snd_wl1) is=
 true
> (or when ack_seq =3D=3D tp->snd_wl1 && !nwin). In particular, when the pe=
er sends
> an in-order data segment of length L > 0 with sequence number S, tcp_upda=
te_wl()
> sets tp->snd_wl1 =3D S while tp->rcv_nxt advances to S + L. If the peer's=
 next
> packet is a pure duplicate ACK with unchanged window, its ack_seq is S + =
L >
> tp->snd_wl1. tcp_ack_update_window() therefore sets FLAG_WIN_UPDATE (whic=
h is
> part of FLAG_NOT_DUP), preventing the ACK from being counted as a duplica=
te ACK
> (RFC 5681, Section 2, condition (e)) and inhibiting Fast Retransmit on no=
n-SACK
> connections.
>
> Second, tcp_in_ack_event() maps FLAG_WIN_UPDATE to CA_ACK_WIN_UPDATE and =
passes
> it to icsk_ca_ops->in_ack_event(). Because both the fast path and slow pa=
th set
> FLAG_WIN_UPDATE whenever snd_una or snd_wl1 advances, CA_ACK_WIN_UPDATE i=
s
> falsely reported on every cumulative ACK even when the peer's advertised =
receive
> window is unchanged.
>
> Note that when an ACK advances tp->snd_una by less than 1 whole segment o=
f the
> head skb in the retransmit queue, tcp_clean_rtx_queue() breaks out early =
without
> setting FLAG_ACKED. Previously, such a pure ACK relied on FLAG_WIN_UPDATE=
 being
> set in order to have FLAG_NOT_DUP set and avoid being treated as dubious =
by
> tcp_ack_is_dubious() in TCP_CA_Open, and thus avoid calling
> tcp_fastretrans_alert().
>
> Fix this by:
> 1. Including FLAG_SND_UNA_ADVANCED in FLAG_NOT_DUP, since an ACK that adv=
ances
>    SND.UNA is by definition not a duplicate ACK.
> 2. Moving flag |=3D FLAG_WIN_UPDATE inside if (tp->snd_wnd !=3D nwin) in
>    tcp_ack_update_window(), so FLAG_WIN_UPDATE is only set when tp->snd_w=
nd
>    actually changes.
> 3. Removing flag |=3D FLAG_WIN_UPDATE from the constant-window header-pre=
diction
>    fast path in tcp_ack().
>
> This updates FLAG_WIN_UPDATE to match part (e) of the RFC 5681 dupack
> definition: "the advertised window in the incoming acknowledgment equals =
the
> advertised window in the last incoming acknowledgment".
>
> This updates FLAG_NOT_DUP to include part (d) of the RFC 5681 dupack
> definition: "the acknowledgment number is equal to the greatest acknowled=
gment
> received on the given connection (TCP.UNA from [RFC793])"
>
> ---
>  net/ipv4/tcp_input.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 99baf14afdfd..1feb370804b1 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -107,7 +107,8 @@ int sysctl_tcp_max_orphans __read_mostly =3D NR_FILE;
>  #define FLAG_TS_PROGRESS       0x40000 /* Positive timestamp delta */
>
>  #define FLAG_ACKED             (FLAG_DATA_ACKED|FLAG_SYN_ACKED)
> -#define FLAG_NOT_DUP           (FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
> +#define FLAG_NOT_DUP           (FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED|\
> +                                FLAG_SND_UNA_ADVANCED)
>  #define FLAG_CA_ALERT          (FLAG_DATA_SACKED|FLAG_ECE|FLAG_DSACKING_=
ACK)
>  #define FLAG_FORWARD_PROGRESS  (FLAG_ACKED|FLAG_DATA_SACKED)
>
> @@ -3959,10 +3960,10 @@ static int tcp_ack_update_window(struct sock *sk,=
 const struct sk_buff *skb, u32
>                 nwin <<=3D tp->rx_opt.snd_wscale;
>
>         if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
> -               flag |=3D FLAG_WIN_UPDATE;
>                 tcp_update_wl(tp, ack_seq);
>
>                 if (tp->snd_wnd !=3D nwin) {
> +                       flag |=3D FLAG_WIN_UPDATE;
>                         tp->snd_wnd =3D nwin;
>
>                         /* Note, it is the only place, where
> @@ -4354,7 +4355,6 @@ static int tcp_ack(struct sock *sk, const struct sk=
_buff *skb, int flag)
>                  */
>                 tcp_update_wl(tp, ack_seq);
>                 tcp_snd_una_update(tp, ack);
> -               flag |=3D FLAG_WIN_UPDATE;
>
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
>         } else {
> --
> 2.47.3

This patch passes all of our internal tests, as well as the new
tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pk=
t
test that Guillaume Nault posted in this thread.

neal
