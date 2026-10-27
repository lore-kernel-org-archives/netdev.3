Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793124399;
	b=OG714q97JsEQKKC5hhcXOcqIVanTM/8l0NaeEfOGQKOxC+jGUqg+zKOTJTyae0ZsUfpb
	 CFcAknUMoj9CQ/hvGc79jzu1Za5nz8UhvjuJTxQOQiEA5cczbVpNU5ENQPJJM4Eom39OZ
	 RF7zrr8lluYVV8CYv5IYQ6wqOi0Tw4HZLz7R8MTOatu75ImxIZZ9MZO1AM7brHWjcDOtr
	 6STPPNYkc91ODhT/Y/89U8SWoH3JFcndFSWLr0wfJL0/vPc4LVnnGCaZdsh7z3de9MCOR
	 GWtND750oa+JdRfAbt4kdY5s2By/zY6opNjQ89ZQoHS6rKrWLeB7TyYZfx34vsAZKvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=YIa8cnD1c6AuCIf6bi+2H8Rp6ZuWBprgbDUrVNg5BxI=;
	b=sqM/pYfttztikvVWdQ+JgU/9YLHqt3vr8RO8Y14mQe/Sbz6zA2NYlJ28x1NhN5W9oib8
	 823rp3k3CbPiuLvv/b4qNS0PaoXEJa3EL9DNiqK9eClnsVuaT2zgXnN5zDhn/Ycukit/0
	 flVATqCt2um4CGcoowA/d90CkzOzmdJ+viFwdf78V7r59bU7PvWA/W9oh4VWtbyqFVImb
	 yh+T4nezEKlHRpQeQm6+TRvGqZHd7fxiwFWMy3no6cYbJWgcnu/SqPz7ylrBq7RDPl6VK
	 0LkvnpSnOTXN2tZIU7WYFKqATgayxv2ZCULU3D9jXwBq3NOq2HlpeLm06S5GwKzEZ8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=bnbx0c51;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09C606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 18:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF09C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=bnbx0c51
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ec3561ad39so87926e0c.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124398; cv=none;
        d=google.com; s=arc-20260327;
        b=FhvTza6yQuXmcTUXrXzo28XELnrJHrhzzlLlzx1bhAHDxyTrnY8vEMGCdzFdzcF2Mk
         mqqGp15y9FaaXpfID6q61k+s5Nou2vQrBMAnueijL7bPnoytAlUh7uzf4w72tDFzzqYn
         fUESsX/Yk5GjLX+I9zjffOYehFP4UMnB8i069kEFO7dyBaUd+3PQCL9haeHcF+5J1d8+
         SYbNw57VsCuWqZPeebNsQ3IZlM7m6JUWjX1KdbEXPBzEVGM9KH174QPsdDlAKRyoJdtl
         AemNoSN+tdPvuTOHe+R7EG+d7QIqIgg71cIDZ8ftAaAdAgmQBDT+o//wqcG464KeYl1p
         igZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YIa8cnD1c6AuCIf6bi+2H8Rp6ZuWBprgbDUrVNg5BxI=;
        fh=WJi+5tcmycMMnBNq6sq/1t4bH1Io3lXMdWfeTIy6yPA=;
        b=A888CpN0OjItIPt/cDFaEdYXUFEnbYFHZreauDhQiqliH4uxaVM89fDikxQBUR/0he
         aWoDCX+bfqiErD8RdW0BMIZ2cOMIXd65TamKDMhjnLNhcnfF/029MVJCMts3ocrj5Y02
         cmIZWqmR4FZlLe8xsaRFhWa8K+KentFQFXNmFQ0gEXBP1HQHq66K5IHCVa/BJGyyIIK5
         pOvxPV5F9/OGO63JRnDqfQcWrEo2dTXD3zx4cfT8108nHVTa7BKNHuQrK6D5EjP0u89B
         t04qBnxjMQZv8gH5tI16WD9HFK1ngYXbNb2mCzV/jcu9WXBKk1MUQSoYh1wW1nuBHrr3
         KPvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793124398; x=1793729198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YIa8cnD1c6AuCIf6bi+2H8Rp6ZuWBprgbDUrVNg5BxI=;
        b=bnbx0c51U+nUvfX/j79nCsJetkh88LNGfoTJLGA3xzmYftiKJdYVLqhLPqdZ0k18z0
         bIqFKDGt83HphhpMIJWDSq5IemPgknKJvobWXMkQQ7VO6bjFrkqAvo1+AFXjuhKxvIpk
         W8u9aa3z90Pfix4p1IqN/zzeSVEpuibE23dJovE1vgXkceZPgC5wnHgHRyGpVHnFHSqo
         4QcZMxNMU1TfozGRggqrzXwePOAeXQO8QEHgSxDifyLvTVK7mcoRyMt9joRrDyXsUkpz
         YOKZ8loy08dOxfLcfLVqOuFleKGvv4GBmszpAIV2b00wvKXhI27wlxfj8LFdjAx97rjC
         1cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124398; x=1793729198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YIa8cnD1c6AuCIf6bi+2H8Rp6ZuWBprgbDUrVNg5BxI=;
        b=0wHgtjwjQrujjhdqzhGB6In1Z0vcxDuYXBx7v98B8v4nKq6RLJwukXN6y/jiFJAXqJ
         EPlp4xOzDX0hJXx4miS6m68sSIoxjruDYNKO3WhpHMPrqvBm3UKzxFUtHFBmr8NC4vOo
         HnrF8kKQwSZpS6nuQXbv7KMjm5MvHYEq7XCVl4EQ73sQuqgxBkyt/0xt39gSIj50ejvX
         qN8HzscE5tgxSg2bEvN96wonvRsdoTt/JHaZksolrSxKsgAIoxfi3JKTKHR/FkwRuVPO
         03VTuig0kfh+THPoWEt3bap5TrZ4ytOIocTLju7exK3SlXKN2PrDBLAKC5uxR580pyyr
         hZcQ==
X-Gm-Message-State: AFq9FYKDIDVAmrmFftv8wCcvXu061gJYSecavd5bUu8lG7gNUnu1ZalP
	ARmqWJU3p8wU1iNpSpJ1U1HH8w2eneYzSPkRi6aTZ47oA4an2Ek5WAmiOD/D5UEP6kWjJ8RDw9T
	gmVJQFcfS8Vn5/1Js5xMj9KuWPTDtbZtR8tWjCuTXDw==
X-Gm-Gg: AYBFou2uwFlsgDAIF4s5JrHGkEp35SIqOYwdoAOObeEzDmJTddx0YFXQ+52NGacKCrj
	gDjXrN6b0gX6vxUU4s5hBVjw+G7RUgh1BhfyujIudhj9b4qr/iq3gKWbO2Mp6L81ZjZDLCUGuuD
	AKsuS6gccjeA5RJN8miCJB5+x8YUpzwG55BVTU4eDt3FePRNV6X0cvOf+u6CPOcZa6YoppkYVUa
	JILuLDog+SMYjwOTTCFF7AoqySJTZS4jltq7pwrZZ25KMe9n0yepBlAA9iimRmLorOv33X743ll
	OmsmsIpzd4s7Zv+wJqTNybEtkhNj16IXp6SQGvVwGh5rywEC1xVRaJfd4X0jb6pN2/9OikZbeQz
	WKtNuiRku1Ccl+S/3HKH5+0R93RUF7KZbNUfF9qXlWeP4772BLLnniDVtUK/990mVStJ4Ed97vr
	Drsdnvxw1jEJ72NWtzmLVz5CY0UKMkIjN/EQZ4OwIqmVYif/7Rfi782LhL/j1+lkVGWJ099ykZU
	120w7wUkwVIXvcFRv7I8hPR1Q==
X-Received: by 2002:a05:6122:6e09:b0:5ea:94cd:c5d7 with SMTP id
 71dfb90a1353d-5ec232a3210mr4742163e0c.16.1793124397567; Tue, 27 Oct 2026
 11:06:37 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020214500.972308-1-rjethwani@purestorage.com> <179287933702.3134.9880453017789029456@kernel.org>
In-Reply-To: <179287933702.3134.9880453017789029456@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 27 Oct 2026 11:06:26 -0700
X-Gm-Features: AclHuK_h_Qz1FLeM8P1E7678UoCNdVQNXwMlAzhrzR7bz3Jo7FQlCV3uB9oLBb4
Message-ID: <CAKaoeS3EJK9kJ-mT9ZJChHFFX9MvTJkfqCyb_g37=5O-9wGkaQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tls: keep TX and RX hardware offload on the same device
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, borisp@mellanox.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 3:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] tls: type confusion and UAF in tls_device_down() when TX is
>   not TLS_HW
>
> Pre-existing issues:
> - [High] tls_set_sw_offload() (net/tls/tls_sw.c:2594) sets the shared
>   ctx->push_pending_record =3D tls_sw_push_pending_record unconditionally=
,=E2=80=A6
>
> --
>
> tls: keep TX and RX hardware offload on the same device
>
> This patch adds tls_device_can_attach(), which is checked under
> device_offload_lock before each tls_dev_add() in tls_set_device_offload()
> and tls_set_device_offload_rx(). A second direction is only offloaded if
> it resolves to the netdev already bound to the context; otherwise setup
> falls back to software for that direction.
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index f11d0528fc431..9df183d0dd972 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
>
> [ ... ]
>
> > @@ -1227,6 +1246,11 @@ int tls_set_device_offload_rx(struct sock *sk, s=
truct tls_context *ctx)
> >               goto release_lock;
> >       }
> >
> > +     if (!tls_device_can_attach(ctx, sk, netdev)) {
> > +             rc =3D -EOPNOTSUPP;
> > +             goto release_lock;
> > +     }
> > +
>
> [Severity: Critical]
> This isn't introduced by this patch, but the patch now deliberately
> steers sockets into the state that hits it, so it seems worth raising
> here.
>
> When RX is on hardware and TX is declined by tls_device_can_attach(),
> do_tls_setsockopt_conf() falls back to TLS_SW for TX (or TX is simply
> never configured and stays TLS_BASE), while ctx stays on
> tls_device_list bound to the RX device. If that device later goes down,
> tls_device_down() does this for every matching ctx:
>
>         WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
>                    tls_validate_xmit_skb_sw);
>
> without looking at ctx->tx_conf. The tls_dev_del() calls further down
> are guarded by tx_conf =3D=3D TLS_HW and rx_conf =3D=3D TLS_HW, but this =
store
> is not.
>
> >From then on every skb with TCP payload on the socket goes through
> validate_xmit_skb() -> tls_validate_xmit_skb_sw() -> tls_sw_fallback(),
> which casts tls_ctx->priv_ctx_tx with tls_offload_ctx_tx() and passes
> the result to fill_sg_in(), which takes ctx->lock and walks
> ctx->records_list through tls_get_record().
>
> With tx_conf =3D=3D TLS_BASE, priv_ctx_tx is NULL. Isn't this a NULL
> pointer dereference on the first data segment sent after the device
> goes down? With tx_conf =3D=3D TLS_SW, priv_ctx_tx is the struct
> tls_sw_context_tx from init_ctx_tx(), so fill_sg_in() would take a
> spinlock and walk a list that are really unrelated fields of that
> structure.
>
> Close looks worse still. tls_sk_proto_close() frees priv_ctx_tx via
> tls_sw_free_ctx_tx() before calling ctx->sk_proto->close(), but with
> rx_conf =3D=3D TLS_HW the tls_context and the sk_validate_xmit_skb hook s=
tay
> around until tls_device_sk_destruct(). Data pushed out by tcp_close()
> or retransmitted afterwards would run tls_sw_fallback() on freed
> memory.
>
> The updated tls-offload.rst says a declined direction "uses software
> instead", and NETDEV_DOWN clearing the binding is now an explicit
> reason to decline TX, so the patch relies on this combination working.
>
> Should tls_device_down() only switch sk_validate_xmit_skb when TX is
> really device offloaded? ctx->tx_conf is only set by
> do_tls_setsockopt_conf() after tls_set_device_offload() has dropped
> device_offload_lock, so I'm not sure tx_conf alone is a reliable test
> there. Would comparing against tls_validate_xmit_skb, or having
> tls_validate_xmit_skb_sw() bail out when TX is not TLS_HW, work better?

Thanks, agreed this is real, and it predates this patch.
It's fixed separately in "tls: restrict device-down TX fallback to
hardware TX sockets"
https://lore.kernel.org/netdev/20261027015205.2169253-1-rjethwani@purestora=
ge.com/
That patch publishes tls_validate_xmit_skb and sets tx_conf =3D TLS_HW befo=
re
tls_set_device_offload() drops device_offload_lock. tls_device_down()
then switches
to tls_validate_xmit_skb_sw, and calls tls_dev_del(TX), only when
tx_conf is TLS_HW,
so software-TX and RX-only sockets keep their validator unchanged.
It also sets rx_conf under the lock to close the matching RX leak.
Since neither kind of socket gets the fallback validator, the
close-path use-after-free
you describe can't happen either.

> [Severity: High]
> This isn't a bug introduced by this patch, but it is related to the new
> tls-offload.rst wording that a declined direction "is handled in software
> as if offload had never been tried".
>
> Suppose TX is already on hardware and RX is rejected here. Then
> do_tls_setsockopt_conf() falls back to tls_set_sw_offload(sk, 0, ...),
> and that function sets the shared TX callback whatever the direction:
>
> net/tls/tls_sw.c:tls_set_sw_offload() {
>     ...
>         ctx->push_pending_record =3D tls_sw_push_pending_record;
>     ...
> }
>
> This replaces the callback that tls_set_device_offload() installed:
>
>         ctx->push_pending_record =3D tls_device_push_pending_record;
>
> The hardware RX success path also calls tls_set_sw_offload(sk, 0, NULL),
> so this could already happen before this patch.
>
> Now suppose device TX leaves an open record, for example because
> sendmsg() with MSG_MORE set pending_open_record_frags. A later sendmsg()
> with a TLS_SET_RECORD_TYPE cmsg then takes this path:
>
> tls_device_sendmsg()
>   tls_process_cmsg()
>     tls_handle_open_record()
>       ctx->push_pending_record() -> tls_sw_push_pending_record()
>
> tls_sk_proto_cleanup() reaches the same callback on close when
> sk_write_pending is set. tls_sw_push_pending_record() does:
>
>         struct tls_sw_context_tx *ctx =3D tls_sw_ctx_tx(tls_ctx);
>         struct tls_rec *rec =3D ctx->open_rec;
>
> but priv_ctx_tx is really a struct tls_offload_context_tx here.
>
> Doesn't this read an unrelated field of tls_offload_context_tx as a
> struct tls_rec pointer?
>
> If that field is NULL, the open device record is not flushed before the
> record type changes. Data that is already buffered then goes out under
> the new record type. If the field is non-NULL, rec->msg_plaintext is
> read through a garbage pointer.
>
> This seems to go back to 3c4d7559159b (2017). Could tls_set_sw_offload()
> set push_pending_record only when tx is set? Then RX setup, hardware or
> software fallback, would leave the device TX callback in place.

Thanks, agreed this is real, and it predates this patch.
It's fixed separately in "tls: only install push_pending_record for a
TX context"
https://lore.kernel.org/netdev/20261027171537.2317025-1-rjethwani@purestora=
ge.com/

> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261020214500.972308-1-rjethwani%40purestorage.com
