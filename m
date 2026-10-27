Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793128335;
	b=XAYp2dExC8mAZUg/w1Njwca7HrdasBFmTxfaOhHbEoWFyjx+26KuhQN8OJ4WdRr+7Oa1
	 us/7KuWLhPeP75DVJiHgQjYnUkOHFZSxHfUr4DALbcW9N0jBdJupPr/jet9r0LUmE2Yxb
	 wm26ecVg5LSApT+hB8XBxPKO5bDRnhKLIPzjHSpxkn8ohUnbPkHB12WzUqHSzfaGLGeRj
	 KmUbzlsWhMozTfohi3Dcs+OI3S3viBdKOEqF7tWGhs8RdpVQnGAZA5BuwLIGn81ZKzBEU
	 Fyq4aMUZCkUxRhICaVD9PZg4n83X2zTHbz/k1vBgTzLPZOPJtOWY/RqIF9IC67yMrXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=03hZHxe6mWjnCPsj/94GuPeA+fkLcIr7pPP60+ktb3I=;
	b=THeQpd4p8bblYhy76O7xet6kPgi21xwzayMm7KH9xeW98n0vj/17XrNL0e7jGYAAPsV3
	 QA0ngtRoOVJT4U94p35dLoCCwTCf9UML+CcyJ0CDjKZtlbLc1B8rv6yY7A6/LwYRWqUkK
	 mv16ItLg/HOWD83UTBmVKLCbINuojTInYD2nSSv/Wab9TYviqzaiHlJcRy59pAwhUmeyX
	 NrjnlvhUgpPweSwfpXFYQCOK/AU5UnDgUMhzTf1TZEOht9p3s5aQqLUorQlUjmNHJtNKf
	 NmZs/uD/yFLo1g7N0FZeKoNcGJLc6Cbl3GZZkRgXEKpVhEt2wnJykf9JUwe6qrlb+oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=DXbujnIT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7263606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7263606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=DXbujnIT
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7bec5112765so88747137.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793128334; cv=none;
        d=google.com; s=arc-20260327;
        b=XxgwW+wV/Do1cO4uzfeujSW/o+utCSeP9QYkjicmWb1/crw/JgA6S+AvF9Day5WfYv
         ikrTMQ//Z7LQT/c7dBbGPtDzp/L06N2OVBV7Js536Y69z9R5482pACgU183VuQ7XzYOn
         GxSwzgR/kPvcmY/VuW04Iib9juPhYRyq6rqdlYqT1/uxSORQX6N7UXRHHEDZizrtKLxz
         d7Y2Qgzbkoa3zp9LKIhYo4EC/YQ8otGfEOxy3OnpllnbUG7tgJL0BuEs9DVGIpIUJIPL
         dBbXbeOmuhC2i0VejxwJRc3ZiEt6gkGnMOhgH4xcIUQxTFmNZotsH+UPJMNxHDcLUWyo
         4AuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03hZHxe6mWjnCPsj/94GuPeA+fkLcIr7pPP60+ktb3I=;
        fh=8fT76YiNm8JJnTBSqdB1rZ0uDTZ14WZswsdIDWdMOQQ=;
        b=DUvSsvHmzALwQ2AuD1x685L8ZPiSe/gDktu0PfZEcO8k8rx123mQxZK3tEaj13+2Ss
         0v7UYp0bGsrOwCk2n6YouMLDTtv8hRLpxHVooBIqNr/N1Xw/MW6sgPuge5wfa7Eqd3Yw
         7Cdhqa/ZcaIbbWrskjP09HazvnGS38Arm75xVQDUpp8PeqZPWAhjJgnE9EMGRQ/3fnB1
         IlQ1UHZUaw7vOr+hDWDAZ7Nw2WfboyNuzXgZw1ZWNSLei5f72YMWOuhqTDUDCGpJS5/m
         nn1S4t0hBODaHOkb655Pt4UE+0my7zMPd1A1v/aRaO4JgoD/vMmTqIRd0cVCMaUK5odk
         MtxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793128334; x=1793733134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03hZHxe6mWjnCPsj/94GuPeA+fkLcIr7pPP60+ktb3I=;
        b=DXbujnITwYZxena585DfwFPWr955Hnb5T2/gODMrIh1uO0T4flnSLd/C1/sqV9y9Dr
         Voy96Cn+gRdlw8aryQKC4NApvEhNv9YU63neqQlkbM362pOxKee8R9djuJNN9yHtLnVK
         JVcd0J3yKxewUsLk8KGrbEOgvbr6jJKbKtvRDbJ6TbMOv8fHTJn5TXSa+cbCXEGKWIay
         tcoUTCDNCb8oxBEDmQIcDjvx1NdgQBR0NvX5j3ipuj4MWEFfu92QblSEoVcmCb2n1Gbk
         f1P3q9PqC2h/Q20KAf88B5LH8UXrrVIynB8FxkFnW5kp9/yIAn2jcFAHgoPL1Lkd4EJ2
         5a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128334; x=1793733134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03hZHxe6mWjnCPsj/94GuPeA+fkLcIr7pPP60+ktb3I=;
        b=SKTZ5mGO0d4Sq+rtJHUIpBLmV+uQWMOR9bzAYjeZshG3/Mea5NJZViQAPX0w5Tq70S
         olAgnnkRJiv89nmdtLz09yYBSKYMLNfX7zyRV5FkteCtNNcsO6sZ9NYn68N/pSr+lF/j
         bt4YhY2IdLNrFRBCZaIE/6vP6yjZ9dw3LXiX6aGyYkYYmegYxSfb6uCDyMOssX6oG6SW
         RC+Nu0Df+ZqJAabAwhD4ZfmpN/zmS0E/1Wa4b69do/jPr/r4fh2/LVT+Xe5JzQMMpyNU
         O7IxD5JK4I87ErOTM172Lw7XOspQ4QxYq/npiJnJwCTKYJyx9YfNr96jZb4WNdKwx3vV
         wJwg==
X-Gm-Message-State: AFq9FYJcRAm8sOPMSGMQ5ucmD8HnnQD6jnx6BNK7dnZMRp0hCfRAbbOe
	DoC9QYb9JIOesQ60LIAs+Z+6Jx6if55H+azIMs3svSlpp2w5UmE60m2PbW5R3gnZV+9kecJZ4B0
	hdFV+cJ9qpFDooqK3+W5wVgoEtRHleix6qlyVHjsTDw==
X-Gm-Gg: AYBFou2a3cLJbmRvBNKqVVDdODQ39mLnrY5lAZto5kaP4/N50855/DeAhJ5XBk9zSoN
	TDJ9h6XwqzJ9qsp5+z6gypwUFSoD5SosBcKY7j1JUHTApY2kJWoYIwUKukHztshEDwcJ7oZIkT9
	YJVU1/baHsRDUX7xUSynkqbm+cYWi4Bn+aP9+6VGXKs6l16dExvrkVGRkwH7q61/HlYjVPVE9NX
	EYdf1v2iJpgnNNG9l6brGadyv73YE0yZB1WPPYnXs/YOyMoX3YtWVuF52xI7DATIK160QQOJiP3
	5IbFQSYTEckCTwfZiG0i3uAIoesZrb3oNZ8ERE0ouJngLTjDTLdvUNreKNbk5AXGrzDJ2SxLLOc
	6mRY5FRvin/W/VENWtZtUTIwFe3mbG1cfTkzVhCYImQFj2TRLBuRKR68AjgP1cnpYcE+bSQRKuv
	1BjWFNeqJrthl8nKmCi6WQwLQtcjbPyv0nzhtNvgYNhB9KvCaU2Ka4UdLDvsTURSlrN+e1kUgvB
	l4aAGArSBWSgBLbAk/TOXmGCw==
X-Received: by 2002:a05:6102:6043:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7d03a417b55mr134881137.11.1793128333505; Tue, 27 Oct 2026
 12:12:13 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019212651.733565-1-rjethwani@purestorage.com> <179279158210.3134.17242732656375934492@kernel.org>
In-Reply-To: <179279158210.3134.17242732656375934492@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 27 Oct 2026 12:12:02 -0700
X-Gm-Features: AclHuK_2_ItZTrTeqhOK0PG7ZE_kdMA131f4dMrK76gCje1VE4UDWDRchgiMw1U
Message-ID: <CAKaoeS2jxG3VLzqhpaWkJ-srvYhC_E7E+7V5M7+nZ4VKK_KNQA@mail.gmail.com>
Subject: Re: [PATCH net] tls: device: keep tls_sw_fallback() from encrypting
 its own output
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:39=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
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
> - [Medium] The patch makes complete_skb() in
>   net/tls/tls_device_fallback.c run `nskb->decrypted =3D 0;` on every skb=
=E2=80=A6
>
> --
>
> tls: device: keep tls_sw_fallback() from encrypting its own output
>
> This patch makes tls_sw_fallback() pass through any skb that lacks the
> decrypted bit. It also makes complete_skb() clear the decrypted bit on
> the fallback's output. Together these stop a skb from being encrypted a
> second time when it is validated at both a bond master and its slave.
>
> > diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallbac=
k.c
> > index 3b7d0ab2bcf1..24fba12febd1 100644
> > --- a/net/tls/tls_device_fallback.c
> > +++ b/net/tls/tls_device_fallback.c
> > @@ -192,6 +192,14 @@ static void complete_skb(struct sk_buff *nskb, str=
uct sk_buff *skb, int headln)
> >       skb->destructor =3D NULL;
> >       skb->sk =3D NULL;
> >
> > +     /* nskb carries ciphertext now, but skb_copy_header() inherited t=
he
> > +      * plaintext original's decrypted bit. Clear it so the bit keeps =
meaning
> > +      * "still-plaintext, needs an encryptor": a requeued nskb would o=
therwise
> > +      * be re-validated and encrypted a second time on any re-entry in=
to
> > +      * tls_sw_fallback().
> > +      */
> > +     nskb->decrypted =3D 0;
>
> [Severity: Medium]
> Can clearing skb->decrypted here strip PSP encapsulation from fallback
> output?
>
> PSP also uses skb->decrypted on transmit, but it means "this skb belongs
> to a PSP TX association". The bit is set at enqueue time:
>
> include/net/psp/functions.h:psp_enqueue_set_decrypted() {
>         ...
>         pas =3D psp_sk_assoc(sk);
>         if (pas && pas->tx.spi)
>                 skb->decrypted =3D 1;
> }
>
> Drivers then use it to decide on PSP TX offload:
>
> include/net/psp/functions.h:psp_skb_get_assoc_rcu() {
>         if (!skb->decrypted || !skb->sk)
>                 return NULL;
>
>         return psp_sk_get_assoc_rcu(skb->sk);
> }
>
> mlx5 reaches this through mlx5e_accel_tx_begin()->mlx5e_psp_is_offload(),
> and netdevsim through nsim_do_psp(). mlx5e_accel_tx_begin() applies kTLS
> and then PSP to the same skb.
>
> Nothing seems to prevent one socket from having both features.
> psp_sock_assoc_set_tx() installs psp_validate_xmit without checking for a
> TLS ULP. tls_set_device_offload() overwrites sk->sk_validate_xmit_skb
> unconditionally. Documentation/networking/psp.rst also describes starting
> with TLS and then switching to PSP.
>
> On such a socket the TLS SW fallback can engage in two ways.
> tls_device_down() can install tls_validate_xmit_skb_sw() after a port
> bounce, or tls_validate_xmit_skb() can fall back after a reroute. The
> path is then:
>
> tls_sw_fallback()
>   tls_enc_skb()
>     complete_skb()
>       nskb->decrypted =3D 0;
> mlx5e_accel_tx_begin()
>   mlx5e_psp_is_offload()
>     psp_skb_get_assoc_rcu() returns NULL
>
> The result is that the segment goes out as plain TCP with no PSP header.
>
> Before this patch, skb_copy_header() carried decrypted=3D1 over to nskb, =
so
> PSP encapsulation still happened. Once the fallback is active,
> retransmits go through it as well. The peer's __psp_sk_rx_policy_check()
> would then drop the non-PSP data segments, so the connection could stall.
> PSP protection would also be skipped silently on the wire, although the
> payload stays TLS-encrypted.
>
> Could this be fixed without clearing skb->decrypted? Some options:

A socket can't have both. Commit a41f24c612c3 ("net: psp: avoid conflicts
with skb->decrypted and sk_validate_xmit_skb()") made PSP and TCP ULPs
mutually exclusive for exactly this reason, and sk_has_decrypt_user() in
net/core/sock.c enforces it:

        bool sk_has_decrypt_user(const struct sock *sk)
        {
                return psp_sk_assoc(sk) ||
                       (sk_is_inet(sk) && inet_csk_has_ulp(sk)); /* for tls=
 */
        }

It is checked in both directions:

 - __tcp_set_ulp() returns -EINVAL if the socket already has a PSP
   assoc, so TLS_TX can never be configured on a PSP socket.

 - psp_sock_assoc_set_rx() fails with "Socket has incompatible state"
   if a ULP is attached. psp_sock_assoc_set_tx() requires an existing
   RX assoc ("Socket has no Rx key"), so a kTLS socket can't get a PSP
   TX assoc either.

Neither the ULP nor sk->psp_assoc can be removed while the socket is
alive: tcp_cleanup_ulp() only runs from tcp_v4_destroy_sock(), and
psp_sk_assoc_free() only from inet_sock_destruct(). The TX check doesn't
look for a TLS ULP because the RX step already did.

The listener gap that commit mentions doesn't affect this either. PSP has
no TCP_LISTEN check, so a listener can hold an RX assoc, but sk_clone()
clears newsk->psp_assoc and nothing re-sets it during child creation. An
accepted socket therefore starts with no PSP assoc, and __tcp_set_ulp()
succeeds on it precisely because of that.

So any skb that reaches tls_sw_fallback() belongs to a socket with no
PSP assoc. Its decrypted bit only ever has the TLS meaning ("plaintext
for offload"), and clearing it on the encrypted output can't affect
PSP.

Your mechanism is otherwise correct: decrypted is inside the headers group,
so before this patch skb_copy_header() carried decrypted=3D1 over to nskb, =
and
clearing it would make psp_skb_get_assoc_rcu() return NULL and drop the PSP
encapsulation. It just isn't reachable.

I considered the bond-master skip instead, but it would make correctness
depend on tls_validate_xmit_skb_sw() knowing every upper device that
validates the skb before the real one. Bond is only the one that is
special-cased today. If an offloaded socket is rerouted through a VLAN
or macsec device, the skb is validated there and again at the lower
device, since both re-queue with dev_queue_xmit(). Clearing decrypted
makes the fallback idempotent by construction: its output is never
encrypted again, whatever path the skb takes.

As for Documentation/networking/psp.rst: that passage describes using TLS t=
o
negotiate keys for a connection, not attaching both features to one socket.
a41f24c612c3 deliberately closed the combination ("PSP was not designed to
be used with ULPs") and left the doc alone. I can post a separate doc patch
if the wording is worth tightening.

I'll keep the patch as is.

> - Use a separate marker for fallback output.
> - Skip the bond-master pass in tls_validate_xmit_skb_sw() the same way
>   tls_validate_xmit_skb() already does with netif_is_bond_master().
> - Keep the bit when the socket has a PSP TX association.
>
> > +
> >       update_chksum(nskb, headln);
> >
> >       /* sock_efree means skb must gone through skb_orphan_partial() */
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261019212651.733565-1-rjethwani%40purestorage.com
