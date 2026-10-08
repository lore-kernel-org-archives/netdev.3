Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BDA3BB130
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497065; cv=pass; b=VBbICu8npUr8SbooBgkAhmniYX0y5jPJRClyKDQi7jMXr4RLY9L9SHITWrIRNQ/2gQmMavzET5XBwObKdJmC4XDt6kyS2y6rUjnEQYGeaJm35EVXEhDzNbZ5DRVMTVvgEveN/OS2LBEB/XQ/DnmZ5FfSHGv7/bRpt4OSNeBRZp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497065; c=relaxed/simple;
	bh=H1VfG90/T60F1s1IQvp8e9YAaTZrGbwa+1vrRytR/zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XktTCNTijChiKb8YYjZKxBERYQkT9k3iuRIF4ywjErcF21yKMNMsUJ+LhJ4Sorr6i72S2Uih0+2/s6/CBqEC3IQxAl27hvhk74e1sPh689w71rpO/+S191pyhy0yjSi3dJXt8iGP9PgL7ru4pqFizd3+Wn5Z3JYl9UwYtir2j+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jg3P38gq; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg3P38gq"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-823545ce223so4823699a34.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791497063; cv=none;
        d=google.com; s=arc-20260327;
        b=s26qfLf68OGE2oLEhDFLLj1ks5E1r9m4Bt723Q7NatgJcviriJm0/pLqhFJtZYWBSp
         84TdTro3jPUelhBAHJUFtiJI1krA0t5MmGx6YPrleUlm21DyOL+5F/XgyE4Ok09CbpwM
         Sp+jEF0EqPJY4Sys6q1chhlsW02WgEMB+xBQ3Jy5lAzAAAOKohJn0xcrmgFs0z3aQZ87
         eDokgD88a9Z0DJSpnqpbHPlBdSfYC9tGf/A4567EWpg0Kh4QQXK36dQVT4ZsRRNwkBRL
         UBBC4uEV1gVUO3fTCSJIZekX+o1+DvNGW4N4VhzILIIud8nSLlBIl1BUJPlCjk0YTH0w
         6ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QLvQWX/AxDS4mt8U2SDRfRCCqUWlEBt2LTxbKx75mPQ=;
        fh=TnihM15kYdalBfMufEe9OopMK7uzpRYBcvprYXJtzRo=;
        b=n0u6MX2GiLpQimo8dIuftzLzL39mJxO62PcgeSRNYDy6u7nDlsfmEYAUzyJ5e/sgrv
         m9dDPzsSh1KclgzJHSRRHTTyp2LPlIXENSVbeMzi/N7EwLaQoQTCW0W5IWUd3sF7dBAT
         gnbXtp/nZtF/Y8u+ZVSqmW2js3qvrv2TnNYYYIHaOyTu5E7lEqJTeY+jEE/pvLmomtUQ
         gAegOb3oDxBcFHmQwcR3/SToCn7iHEhTTxJHDqQcnYfiMVUnQSlEu+MvG331BvZXdf2s
         BiknlExrE816mH7DuqMB57FfqHzKJjpK4R6YQo38N4NhtJIUhdlSPYHYI2MWYBRFoxKT
         oGmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791497063; x=1792101863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QLvQWX/AxDS4mt8U2SDRfRCCqUWlEBt2LTxbKx75mPQ=;
        b=Jg3P38gqPX797V+eWn9E3fSeYBOC+f96bQh6EHIHPPbxV4FDF7ONRgqQFYguv5hG91
         xRnBY/f98jT0ZdHs2pRgOe851k+AYTVYUf0U1BUUUtJNOams9dt+XqzOAYMXvSRM1rOW
         9leexZB+n18WvoEEyMu2sADPvPKZo/O5teWhN+Anrzrcz5lqdstfaulv1uvyJhrJYyUm
         9b5c9N10fwVb/MTpnawYVNg0mCWQAtZlOYFY+kwssMgyBgeWHgpv0/fDkCEoAwKqN2xL
         mhDOVVFDTloOC9GrmRNryfabrYN8IngcI9Ti6gohLR1At6c7BBkRA0YKaGfPWwsi9PsC
         3aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497063; x=1792101863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QLvQWX/AxDS4mt8U2SDRfRCCqUWlEBt2LTxbKx75mPQ=;
        b=JSx5SXesvZFcMPSPCSgc/obsndC0ZyE/GiFeWGaUVgjeDP+hg4gtHfXrZgaWpth/CI
         pchEHPEdHkhJFxqwzqLVKLMRhnS8dZhH6gpNYTnlApT6QD+UwXX2dj1SgS8FFhnZCNkI
         p7b7V+Dv5haVf34nyR8GRGCdskbqawvAHGKiuONM2keUHtUpFw3tnIcN1W5SfNf7oci0
         h340aoFwAWmmskjv6tIWKBPy4mNOn9ra43FrFbEqfTa8CSUmaki/Hn6kkt8jBpsPMMP+
         0frxOqVDbXfnfIGP9Skv6iUjCibloeKlppp0osswdAKt112FYBCy/L6hxYYwuzKS5y7M
         I2jw==
X-Gm-Message-State: AFuF++kUgXTkwk9QZH+EwEBpBssoL9CqCcawQzxQDW2HvmexZUiNlWso
	/1+KMnmVrU7OdlJYHPMGIn++lC0/dxYQLKGqWjvT0jjWel9PnQIbtQMOSEzCrPOlaRUBO6nLKI7
	GJyYadBS/TtyCKUJyBP3qxfhOnf+np085ZldpmjPZ
X-Gm-Gg: AYBFou380QHxXZ7PAWmUeO2YVZ1iyUWguNWlI8hM1NcQdKZoJxfD1IIRyHaMMf8/SFL
	KgmmJ2opTwMFGgn5DQF9yzf+tgaeSSAQ6lwvZjtZKSkB70OS2xRnKrtAKJJCVBX666zZvqXY8dq
	Gs5j8/iPDzJfTCE/NDAwql89GjfbFf/oKX8erflEXWHLMVsN0cebVuS4fsrpHh4Uj6gTwglZ9/6
	sFd4Jt6ej8EHrGpEFiPJ0O72zc7Xhr1DgAFZufpboONduZQ2L27HFx2R4jgzp4Ab1fnr2+xxPMm
	oAPh9bwqgYx19IjSznT70MR5cHaMj6TVpMkwNuDD7vWxh3j/E3/HRDdoNPEQ71nQKgIDXo0iMGi
	qV83i1PDkYmHOJg==
X-Received: by 2002:a05:6808:4f21:b0:4fb:a7f3:420d with SMTP id
 5614622812f47-4fc461697f8mr6349091b6e.48.1791497062305; Thu, 08 Oct 2026
 15:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005214002.3226574-1-kaifengw@google.com> <7f377853-ae56-450b-889b-688ec335e81c@gmail.com>
In-Reply-To: <7f377853-ae56-450b-889b-688ec335e81c@gmail.com>
From: Kaifeng Wang <kaifengw@google.com>
Date: Thu, 8 Oct 2026 15:04:11 -0700
X-Gm-Features: AclHuK-XBiCo8MEasct3DpaRxKEb0yXtyqWVf5dHL0yESstGRBWSjN8kwHz5AtA
Message-ID: <CAKkY-qO=bNnyyUg_2FM+s5Gt3mW4+_ony2Bp8kRsYUcHrXcv5A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reject devmem tx with fastopen and repair
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, almasrymina@google.com, willemb@google.com, 
	kaiyuanz@google.com, sdf@fomichev.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Is it enough to check tp->repair only once, at the top of the function?

Agreed. As Stan and Pavel suggested, I will move the `if (binding)`
checks directly into the Fast Open and `tp->repair` branches in v2.
pw-bot: cr

On Thu, Oct 8, 2026 at 5:54=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 10/5/26 22:40, Kaifeng Wang wrote:
> > tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
> > zero-copy path is active and a valid dmabuf binding exists. However,
> > subsequent branches in tcp_sendmsg_locked() can still intercept the
> > message before it reaches the devmem zero-copy loop:
> >
> > 1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
> >     If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst wit=
h
> >     NETIF_F_SG (so zc =3D=3D MSG_ZEROCOPY and binding is present), but
> >     tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
> >     copy_page_from_iter() to byte-copy from the iterator. Since iov_bas=
e
> >     represents dma-buf offsets rather than user virtual addresses, this
> >     misinterprets offsets as user pointers and copies arbitrary user me=
mory
> >     into the SYN packet.
> >
> > 2. TCP repair mode:
> >     If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() simil=
arly
> >     calls skb_copy_datagram_from_iter(), byte-copying from the iterator=
.
> >
> > Neither path supports or makes sense for devmem transmission. Reject de=
vmem
> > sends if Fast Open or repair mode is active.
> >
> > This pre-existing issue was identified by Sashiko AI review on commit
> > 125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
> > hit in production.
> >
> > Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Signed-off-by: Kaifeng Wang <kaifengw@google.com>
> > ---
> >   net/ipv4/tcp.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 87ef6d5cbfeb..225e758c194a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1169,7 +1169,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct ms=
ghdr *msg, size_t size)
> >                       zc =3D MSG_SPLICE_PAGES;
> >       }
> >
> > -     if (!sockc_err && sockc.dmabuf_id && (zc !=3D MSG_ZEROCOPY || !bi=
nding)) {
> > +     if (!sockc_err && sockc.dmabuf_id &&
> > +         (zc !=3D MSG_ZEROCOPY || !binding || tp->repair ||
> > +          (flags & MSG_FASTOPEN) || inet_test_bit(DEFER_CONNECT, sk)))=
 {
>
> It becomes unhandy, and taking into account the issue Stan commented
> about, I think it'd make sense to do the checks under the repair and
> fast open "ifs".
>
> if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
>      !tcp_passive_fastopen(sk)) {
>         if (binding) // fail;
> }
>
> if (unlikely(tp->repair)) {
>         if (binding) // fail;
> }
>
> --
> Pavel Begunkov
>
