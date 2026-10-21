Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602917;
	b=Z9CioKMnCwj8wZSYLxeELMj2DBRC3KW+kkGP67+4K8R5x8W/1BKDjYKAN3jnHYlX6PBu
	 fu/PS2Lg6qXD4pkXYeLZi/Q6ReEHMnvA+lle981IXRtP2jQX5EXuUJ5CWIMg5l91HLwb6
	 XM0FLVfvWqVgB9Q+bywY6TB87Clvf0CplzaZKt4BU4pDn50w70w+iNsLC7t/KFiZ2jH5N
	 dajmVQshBprn2Zjxi2rM+ZhZmHX9iJBX39wFXHcES8KQryl1gALGumAYin1w37wDu3Vpp
	 fS5/YnaeO+0T9ax7bnWCPIcsZ2l9mCCyuTegYnuhTMkMEVdb76lbLu6joH9TAp2mdJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1tGGVt5JpRhP2W4EJx+5ELzjqyqkrNAqI8MgC60d5J8=;
	b=kDZVGEuxlmr7Jt1iqyWMqYqXznxTNUJTerDJeOYzm7pBOZGTq7gA387X62uH90xG5+Tv
	 aPvTa0tDzF3+vs5OLN4r0rTPobi1yDvFqAtvSd72uksIc+SQXZpHwxP07D05holO875WK
	 EOZpsZKrVJ9vwodj+ZZg5S0BaRsRSm3SqzWl3mgWhSxiUPV1kM6lYMSNUInbqnGE7MzI8
	 nHkcFZHJ3EIOCZU1/6q4ruzJ4UkLzi+MNAqDAkCpslqmLrJ0W7DyTLWP01qdlRYIZYUVp
	 dnFAGjx/SEYbK55gdeGjUTtHWiDtFXkEBDTYiXzPY1+1VXoJS2KpTMV45KDUx8s3WMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=unOyOiC8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADF606A323
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39ADF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=unOyOiC8
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so496a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792602915; cv=none;
        d=google.com; s=arc-20260327;
        b=YLpeml11J2PK28HxAfbuILiPXbIqU+eaAMVo5Y9E0NlDW6mzr3TlQYlb08wsqoBTuq
         +jk9oLxB8y+o8UUvEzGkW7GPAtggM2aUS3S5S+aKETjJ0RPhH93MmSkYncMfEwCU6kGG
         7e7a06341/rGIKUtEaIqAbhJtiKOZL2BL3IwRqrAxrkNc/1pEoO/ENwlNfqyW1sGKIhQ
         4lEvLGfUmYLiOI5o6sVx6YCCOB4ld2Dx9BOt6V8JrWB/Nsv4eB1FjqgeiOnqz3utbb2k
         iOuOpQBXeu/gBrN2CWZ3QZ9fHaABVG5+sCUNf50HAVSgt7k7YNqjeN8Qh3NhKgNS/XAK
         BIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1tGGVt5JpRhP2W4EJx+5ELzjqyqkrNAqI8MgC60d5J8=;
        fh=A2Z6YWy6EBRXd1Dsi1iln5rYlpjt8Mfx8iAkEMVdq2k=;
        b=BAg0EkdexyFrOC0djW/jOXImCOf8i5IxXZambZZ4iuJ4lEndxjmPnD7CF6oRprTi1Z
         CK6sLGgUXkZWnn3F7JH9jH4fI67M4STMbBUUbtFOOQo/z7K+lGeDjgqxLC9ZPPv33JQi
         Y3Vpz9LJxYDaGHOgI1fGxWHj/jyTh9wIRGef8U2pzUbVvOCh+b3fFHaH/5zrm+91DAfo
         V2OaukPASdgQ0jt9ybm9Z2mrNovb6u1ers5talcQVWcEMNu8ct7lia8wyMpU2EXkHRpL
         6014jCzKXwLD7Dkn2iyRBCvFT2C5AQGZ+Jri3zz9zeYRW3qp0ZtF9Kir6OVE+7yYdmWa
         9PyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602915; x=1793207715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1tGGVt5JpRhP2W4EJx+5ELzjqyqkrNAqI8MgC60d5J8=;
        b=unOyOiC8BZwLryVYJ6/ei52c2FCAsDZYRdhw8IpxIpw0w+Ax/ESGa7XKcqri+Y5JfU
         74kc9X3tkz0ffL/8vQzTmMGaLviiqfiOF/oPM/vauqGi1g2S+p0b4c9VDRc61tH+I44k
         2SMZFTFgQ5Lb6YUcDJK5BcTMLoKdquSLbQK5vf5b+48xKJLiqO7gX0um1Pw4llOYFgg5
         8gnHIf5pIutrDQpB4QsmCiLhLw/vZXw45vYhCFkwyWJ3Vhgvta0R8AtLPbqQp/AggAtj
         wj96wWp4ZUxV3r36mm4wbSQnjyAQ1cywOOLRLkOuCqEc7bBJkKO1mg1feiLRKhIRUS9G
         NsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602915; x=1793207715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1tGGVt5JpRhP2W4EJx+5ELzjqyqkrNAqI8MgC60d5J8=;
        b=nUgRQxMuYI0V1BN/+GNPKXMLSpskh9PVDGvW09GT7vzelF2kXXHghh2jKCKZMmBkO8
         kmp8FiGgeKEhamr5px6VYFZ9rP+/wPRlQPr8mSwHtCs2oodiNqfLgLmjy1+uJiykBT3Z
         iXnNyOR+4S/fuLYvQf0c9YA6IJ0sJ3PIXANqWwx5og8dm6qwnpJpUJWwPkKpcoStsyDm
         /7js2KziSX+NQd6tBRAl1r0SOwsLZAC8cYSYM2KVxnSmm3HKKjhGKpImXbGLcAj5q/nK
         PxRykZDnMf8e3R8mS7vsO2iiiwP5ll2884CKH/pnkRnBKkpwpqk6dO0SYpeFmNCDEGE9
         ULFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDWDCfElWE8j3Tvv1gdKpkz0gkpZpGoXt1uVQPRY4QfApq19LZaUNJKjzPmppginMhJCB347g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZr32+XN9qZrzyHXIxrI36jowx3qDkxNx9z+9ZngO4vy+eAf0N
	bK/dU2XIt/hZ9bQDiHdfaSeAOmkOATrkQm4gRMTdYFcdvwgySdx4INPH7fF//yRGdQV1DxjzBXx
	8ZjdQ78R3KmGRf/Ulz1pYg5hHb14VKus3C1yOEDSN
X-Gm-Gg: AYBFou01qjqGETiXPdfHuz1tADuXOIRtGOYkZruJObxBitqWdSODsV9HRDFp01mRuIX
	5OD0NlI739cdmI+iDP7giCDxlQIWYNOHSPPd6MXrtC9KqXQcEb8lOPUKh0GGanAe5qxpKxnOp2z
	4abek6CDJ6JVT5fWEhBCrs2iIhQTjkSZAgD9smKEOB9VQM03UByiJOb3qV8xF5c16cqpjik7cM9
	7xLbUXpMs+GYNaA2ejE/lFgwgI7Ji3szMJNHIJ7BkmyCSsogKwABCS5DUcS+mwbx811dQM6rcAu
	d6iKYr2xRB5oPrf5xsMtH/hXAg0AXqBKNhl3AOrlyhjThGVB+ld6hWUNjuIKIuQv2kBB4R93AYx
	dI7B/wxIlLI08KqqT48rG1iYz5Tq1TlH4EjZDYMhqYtOzeq4guGOlWKZLCy43WiQIko1eDu4/OV
	913RHcZG003ipm
X-Received: by 2002:a05:6402:4259:10b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b3e58e0cb8mr131835a12.3.1792602914983; Wed, 21 Oct 2026
 10:15:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019174522.55644-1-kaifengw@google.com> <4d5e00b9-5081-4530-ade5-41570e4a5b2f@gmail.com>
In-Reply-To: <4d5e00b9-5081-4530-ade5-41570e4a5b2f@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Oct 2026 10:15:03 -0700
X-Gm-Features: AclHuK9Owbr01ebTbFz9aYLKFv95LZHGS0yoErAU0QV9EF94ce89DoEcv1Rm3wc
Message-ID: <CAHS8izN72w--+5pxxzg44eCOdaeYcJUpXSeJUoqEdZRRq7xPXg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: reject devmem tx with fastopen and repair
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Kaifeng Wang <kaifengw@google.com>, netdev@vger.kernel.org, edumazet@google.com, 
	ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kaiyuanz@google.com, 
	sdf@fomichev.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 8:17=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 10/19/26 18:45, Kaifeng Wang wrote:
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
> >     misinterprets offsets as user pointers and copies the caller's memo=
ry
> >     at those addresses into the SYN packet.
> >
> > 2. TCP repair mode:
> >     If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() simil=
arly
> >     calls skb_copy_datagram_from_iter(), byte-copying from the iterator=
.
> >
> > Neither path supports or makes sense for devmem transmission. Reject
> > devmem sends inside the Fast Open and TCP repair branches when a devmem
> > binding is present. Checking inside the tp->repair branch also covers
> > the case where repair mode is enabled while sk_stream_wait_connect()
> > drops the socket lock.
> >
> > Additionally, drop the !sockc_err gate from the devmem validation check
> > and return sockc_err if set. Otherwise, if a valid SCM_DEVMEM_DMABUF is
> > followed by a failing cmsg, sockc.dmabuf_id remains set while binding i=
s
> > not acquired, allowing the Fast Open and TCP_RECV_QUEUE repair paths to
> > proceed and return before sockc_err is checked.
> >
> > This pre-existing issue was identified by Sashiko AI review on commit
> > 125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
> > hit in production.
> >
> > Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Kaifeng Wang <kaifengw@google.com>
> > ---
> > v1 -> v2:
> > - Move the devmem rejection checks into the Fast Open and TCP repair
> >    branches directly, also covering the case where tp->repair is enable=
d
> >    while sk_stream_wait_connect() drops the socket lock.
> > - Drop the !sockc_err gate from the devmem validation check and return
> >    sockc_err if set, preventing a valid SCM_DEVMEM_DMABUF followed by a
> >    failing cmsg from bypassing the check.
> >
> >   net/ipv4/tcp.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 87ef6d5cbfeb..2792923f0748 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1169,14 +1169,18 @@ int tcp_sendmsg_locked(struct sock *sk, struct =
msghdr *msg, size_t size)
> >                       zc =3D MSG_SPLICE_PAGES;
> >       }
> >
> > -     if (!sockc_err && sockc.dmabuf_id && (zc !=3D MSG_ZEROCOPY || !bi=
nding)) {
> > -             err =3D -EINVAL;
> > +     if (sockc.dmabuf_id && (zc !=3D MSG_ZEROCOPY || !binding)) {
>
> I wonder why it does sockc_err checks like that for devmem, e.g. instead =
of
> failing earlier. Maybe Mina remembers?

IIRC, Paolo caught an issue where we were subtely changing behavior.
Like if someone passes in a bad sockc flags, it's usually ignored, but
if we process the sockc_err before we need it for devmem we change
behavior for existing users that were passing bad sockc but not using
devmem.

--=20
Thanks,
Mina
