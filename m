Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792518910;
	b=EBQQLPPAodUh295oQP5+akcp17exgrwQ1p84KQ6+w/hz0OLhGO83hONzfmTwOellx73R
	 skdnEpQHdvCoqW5J/HqfyeBF7IlwL9whlVU8S4P6PVZmQdNZE0kU+HK8S8YgRXpghD3oj
	 OgmtCsCeW+cTjJeNukEklk0NT/SJkP6lwfaNtRuA+qrW7iXWBQqfydS0U6eo9OZP1l2tg
	 ZJvex2OFwXAr1PdVEq5ka/nCcCyLwO0UO+Eqte//Qgt8i9bwfO+foN7nqZ2OkYtw5Cesr
	 fGlemD9WWWATbRnATZZfyzv+O0rVXUaqze6vVUIFFs/9knnBrdmNwwVbtSk6FGaA9hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=y9HpxehbmG7Pgq3cB5qfed70gkzJnlMwj02Bgt/gGcs=;
	b=V+QDjlwXvS1weQFBmKZDvkThaw6045ASd8x+YAwRIjEZsdw45U5V22PcyLjpR7ZJMwdr
	 YvqQpPrDiAbQiuO2YdmOkipGezwp0PCw6h6q8O1HrAjekBkRFmcHI/h7WxrbAP1T7fj6H
	 AgXt/I29pOlMsO67Kug87hWxF5ZeaKGni/cZSeRnXY8ySWHx25aq4vtmXr83oIQyqsZqr
	 s6QhPh7I7zLbceEU8VAq+xTbhc3vtJy6Jeg7pSKTbdvUiyrtbhd6uie1EDPQPJYI651x7
	 YGnuK1pMjiMt3YXAZKvJCerLUrjculZvuBL5ystj+spFWsXO518RDDYtDqC+gUf3Oqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=muNwDr78;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544D606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0544D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=muNwDr78
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eae8ad9392so98520e0c.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792518908; cv=none;
        d=google.com; s=arc-20260327;
        b=ciQvvowoTYXEi7u86D58Tm0TfQusw2D9yZQOdrJoqKE8CQ+uNNshVwbPbF0VbKjYyC
         LVHA9qnrnpfG6+ulbr1mgIHKHjTXPPBGp/8OCahsDsiMP+JU54Xpqei8m2e/xH2koMxF
         mp2dvLG9cATHSlp+6L3uRNg1ylst1IrShckt7ZQ08SKTrYCcNG5fS/Pw7pALdGBPc3tw
         ZQtF1UiZZarVdkt677WnnYLxLR6kkoKchkwB5dge9PyxH66LygFMERfhYPKiZkCX2acf
         nnCvKr+Bep2K1MUczAKo88HX0vbq7Qt8n7C7P23BQtur1AX8Z29RSD7QBrgazJysI9YA
         VhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9HpxehbmG7Pgq3cB5qfed70gkzJnlMwj02Bgt/gGcs=;
        fh=cHOC66LjWX1A9xKq+Dsf2D2qEheeNko/uJ+ZAQ3iP9Q=;
        b=Nxh7dOBSdP9GUb8JR21g6jk8etPkZeiJU94ZAK60p5+yiyMxMWcOyfKmXU6EAdTi/c
         HK7nHU+sYoAuO3jHCoX7LYAQJppqUObuFyxtmAEMwyFQYGbU/mOSoHmUfIdeux2X1YWH
         CXrvbtxbHRY/hraIarPyGUAv+MpiajQniSmQqhD0CqbXwYMDME5pcjKdfzv6atF1aDVr
         c6oK/wPyht2/943KF3pyJoXToyNKSM5dpRfIEgMQPPEZAMT1inAOMJsDUNmFstBrVV4s
         EHgkxY0GzquxNY+kZJL4j4YCC7q8FUsq14Fx/pJlLS5b9iPfqqU+KiEXwuQWVSbwaBqL
         a4mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792518908; x=1793123708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y9HpxehbmG7Pgq3cB5qfed70gkzJnlMwj02Bgt/gGcs=;
        b=muNwDr780gVOPOUtu5RLcskgnDy+/Y51C7VIArzXn80HBhuJFSXfl+/byFcl8tmTAf
         7/83dau48Vn+Cn32qEoRbCVh3q9GGxMxocdI3wVbQ9RZHQahozlQHSSnjc55GA5KhiBl
         F6vQOEe0ZhrEAjvu9qm1k+UZ0yoqsDfT3IDn7b/Tchm27AbKlx5eTHMcSpew4M/G6OLo
         N1t8fJg33gBx4x+JGuC+lYebKXu/5YhTnbXgUncziymf2Zpz/VyAT90/dQ0qrDFyCqKo
         dkae9MxZrRLDe6uoj+c6tBGLuWXIt+f7ghrliefycO2ZreO8kSW3GDTGwdW17NcvlD8u
         WRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518908; x=1793123708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9HpxehbmG7Pgq3cB5qfed70gkzJnlMwj02Bgt/gGcs=;
        b=u3Q4OanYwMynmW+nqju8oJOv4O74ljdxwI4/jlLpdyQ1wLk6lsAH2202BVaqlcSr4X
         6O3goyUhigz0rgARETdFgu074XH98uR/kCXzpYFefIXMlFeBWDxrYYmbtMSjIdPdpDXD
         MSZaf+HYxIUskzW/tB/ZMYD+gO0iUJJDT1d2/D+4nhVdXoHy3/DFfJsPbf/EymHTXfyR
         raryLfd0MtU/v9qNnW0aI9hY7+efhHTUUOeerZHFCkJmUv8u0AlJb4mE0VB+0T7Q3HuG
         TGzakeAmzWkXo4TuGLpn+MwrdljjQRInicx05NXPXSRDtlatwvLN2SXTVcNR2BLAbolf
         1w4Q==
X-Gm-Message-State: AFq9FYJFdcx+lbE5c3qq3zuLTGKG5s3e3rq6mCC9+Xu9K1s2X095EGIn
	2Ai2s38OrqNXnnaM5ew4xgK3RpW1yoxKTwJIEhe69iOqIYaBzSjJW3zZgk524nrY29ZastPg/Ru
	XyKZl9vQXGw3pEWpcdsK6efiRubH3aKIVPtcJCoMW9w==
X-Gm-Gg: AYBFou3OR/yZ1x3x9cYMHr93HbQ3XaBeXl0uSa1DxmutVszR93wDsJP4DuK6SZvGr2M
	nlUtwIyS9t6Pze/VdSgp+9Q5prUwmtj3gwN5D03KcE0XJV2WPcXfeh/n2yMG6Ye84VqNLCeii5U
	c9Z11ayYr7Pvkjx6UjNlefO1dbEodbmUEwzU4CffXD57yCELQuOwnBWZyOjhg4e9ssN5AH4CU8C
	NHAmSOsh/5ko/b7nCim75VHZcLZ5jtZLOfa2/vrF7z0JZb6im8EqB++elv9XZQSXt2ALCtqMJlZ
	XlsIU9jZneLRm1bRAklStpBlYuW20ep49Ou9Wm2+H9bMo8xNIso0sNhS7o14geUroh3TPcY0caj
	cogjhyYJKS4InS+zpGiw20UtwVh4oUsKoycsNdaRKTSSjWP5XndoY/EPUiWMwtTFNIwFQhYAMDv
	K2oRxGL4JddlJvhUYsHU/dSZNNAdgYPe8NgHwllmnn
X-Received: by 2002:a05:6102:3c92:b0:7a7:195a:1b2a with SMTP id
 ada2fe7eead31-7cc36af715bmr2410635137.36.1792518907708; Tue, 20 Oct 2026
 10:55:07 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016042604.357739-1-rjethwani@purestorage.com> <atH1ThJGVObmpeKT@krikkit>
In-Reply-To: <atH1ThJGVObmpeKT@krikkit>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 20 Oct 2026 10:54:56 -0700
X-Gm-Features: AclHuK9koDIljjad_6okkmgr1_AHzXjpT3jzcnthxdH7jkI-vtrm4xJ9DHNQB40
Message-ID: <CAKaoeS3UFK-mBcw_Rd82z_HbF32E9MUg8pcAKmNbgYraDi-m8A@mail.gmail.com>
Subject: Re: [PATCH net] tls: only install push_pending_record for a TX context
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 2:58=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-10-15, 22:26:04 -0600, Rishikesh Jethwani wrote:
> > tls_set_sw_offload() assigns ctx->push_pending_record for both
> > directions, but the hook is a TX-side dispatcher. On a socket whose TX
> > side is HW offloaded, tls_set_device_offload() installs
> > tls_device_push_pending_record(); any later TLS_RX setsockopt overwrite=
s
> > it with tls_sw_push_pending_record(), because tls_set_device_offload_rx=
()
> > itself calls tls_set_sw_offload(sk, 0, NULL) for the software half of a
> > successful HW RX offload, and so does the fallback when the RX offload
> > is declined (NIC with TX-only offload, tls_dev_add() failure).
>
> This makes sense. Some comments:
>
> > From then on tls_handle_open_record() (a TLS_SET_RECORD_TYPE cmsg after
> > a MSG_MORE send, or the close path with a pending writer) runs
> > tls_sw_push_pending_record() against priv_ctx_tx, which is a
> > struct tls_offload_context_tx, not a struct tls_sw_context_tx, and
> > reads open_rec from inside the offload context. On x86_64 without
> > lock debugging that field overlays sg_tx_data[2].dma_address,
> > which is never set, so the push is silently skipped and the data
>
> Do we have arches that support TLS offload but use dma_address, or
> where the struct layout would allow something more harmful than "wrong
> payload"? I'm worried that we could access some random address for the
> open record.

  The more harmful case is possible on x86_64 as well. sg_tx_data is
  initialized with sg_init_table() and filled by tls_push_record() for
  tls_push_sg(); it is never DMA-mapped, so I did not find an
  architecture-specific writer of its .dma_address fields.

  I checked the layouts using the compiler and this tree's headers. In the
  tested x86_64 configuration, open_rec is at offset 144, sg_tx_data starts
  at 64 and sizeof(struct scatterlist) is 32, so open_rec overlays
  sg_tx_data[2].dma_address (80 =3D 2 * 32 + 16), which stays zero and the
  push is skipped. Enabling CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_LOCK_ALLOC
  and CONFIG_LOCKDEP (with CONFIG_LOCK_STAT disabled) moves the offsets to
  280 and 120, so open_rec overlaps sg_tx_data[5].page_link (160 =3D 5 * 32=
).
  Entries are not cleared between records, so once an earlier record on
  the socket had at least six frags, that page pointer plus scatterlist
  flag bits is interpreted as a struct tls_rec pointer. The first invalid
  dereference is msg_plaintext.sg.size, before bpf_exec_tx_verdict(). So
  the address is not random but a struct page pointer with flag bits; a
  non-zero value read there would make bpf_exec_tx_verdict() operate on a
  bogus record. I have not reproduced a kernel fault or established
  exploitability; the offsets and field writes are confirmed from the build
  and code.

> But on its own, the wrong payload within a TLS stream seems bad
> enough, I think it's worth a Cc: stable tag.
>
> > buffered by the MSG_MORE send is later sent under the cmsg's
> > record type, e.g. application data in a handshake
> > or alert record. With a layout where the field lands on a non-zero
> > value it is dereferenced and fed to bpf_exec_tx_verdict().
> >
> > Only set the hook when initialising the TX side.
> >
> > Found by code review while developing TLS 1.3 HW offload
> > rekey support.
> >
> > Tested with HW TLS TX and RX offload on Mellanox ConnectX-6 Dx
> > (Crypto Enabled): after setting TLS_RX,
> > send() "AAAA" with MSG_MORE, then sendmsg() "BBBB" with a
> > TLS_SET_RECORD_TYPE cmsg for a handshake record. Without this patch
> > the peer receives a single handshake record "AAAABBBB"; with it, an
> > application data record "AAAA" followed by a handshake record "BBBB".
>
> If we already had selftests for offload, I'd request a selftest for
> this.
>
> Would it be feasible to extract the non-1.3/non-rekey bits of the
> selftests you have in your 1.3 offload series? Those would be valuable
> on their own.

Thanks for the suggestion. I=E2=80=99ll submit v2 with the non-1.3, non-rek=
ey portions
of the selftests extracted as standalone selftests.

> > Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> > Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> > ---
> > This is independent of the TLS 1.3 HW offload KeyUpdate series, but
> > that series' TX rekey path (tls_device_start_rekey()) calls
> > ctx->push_pending_record() and depends on this fix.
> > ---
> >  net/tls/tls_sw.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index d1ad31986cf2..b3fe153c3c68 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -2591,7 +2591,12 @@ int tls_set_sw_offload(struct sock *sk, int tx,
> >               }
> >       }
> >
> > -     ctx->push_pending_record =3D tls_sw_push_pending_record;
> > +     /* The RX path shares tls_context with a TX side that may be HW
> > +      * offloaded and rely on tls_device_push_pending_record(); only t=
he TX
> > +      * setup owns this hook.
> > +      */
>
> Please, no. If I see "if (tx) install_push_callback;", I don't wonder
> why we install the callback or why we install it only for TX.

I'll add Cc: stable@vger.kernel.org and remove the comment

> > +     if (tx)
> > +             ctx->push_pending_record =3D tls_sw_push_pending_record;
>
> --
> Sabrina
