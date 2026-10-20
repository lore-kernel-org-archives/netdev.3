Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792529759;
	b=XiBR/GX0fIoozcInGaOsplnhK87X+x7Jr6i2ehM/nIucKdJTV2IWMdXcxdjI7ZKylwTS
	 Bj0fUNxrYEtWQqr4u7RGJvPKmNyPCENfM2dF4Q+k7hrUzUoB8ELO4LJ7TKh/eo1h9TMvi
	 SjHi8tlnD0uDQYx+v9OO8XvKIJBGDMQhtIWh1B7NCu7zsdy6ED7Hk30Qfqdl51oHbETQ2
	 jU8ZlmCqD09C8ECvIAbbf+mqmLBlJHkFxkZHkThIBYa86sAXZdRVygr2ygR9YRZVwwdm9
	 PM0Xn9zdAGGB/rB06hhwYaA9dlA6EGW+BTxn6zIauSWdIzsvz424uFhH+7/imXk9nog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9va69Z70VDBET6RC2fy59u2Ycvr0LSmJxWPH1bvD2co=;
	b=VH74xKjx+LXHCxnJR2bMkezUsiGU5EubI3jqg9NIB8o8Tbq4E90SQhVHQc0dDiHrYDm2
	 FGjyva4Rq/vt5PhJND9Nl9Qwpo1JZBywJRWkrBWkOMQNspTBRqhCska59h5thVTtj2uCF
	 3gElnqy0aWnmdMkjzsHzphN1Y+Vi+vSt6QRZGNNTdfTwkESbK7IWwJgzLgDsERokFC1B5
	 XfOn6BLQkDqHiXyj0RLEbs9ifwqAEoKoeDXajHvHPTbuzlh8DrauV8AkVoWC6aqheJt3E
	 iI2W3t2ODE7jIy6Zw31hOnRRWNjEpvGfLl9BoSn/4VnFbvdJyiDg4wNDZ/SR3nriO4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QrNh3kgc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31C606A323
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F31C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QrNh3kgc
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a06b436dffso16899b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792529758; cv=none;
        d=google.com; s=arc-20260327;
        b=N2k7Ifuev8h7ARVYGXjWTNn9OvJT5+wgH/+/IRO1Ntp17YSjk9fbihZzrzJRn4bXg9
         S98mbzPUi7aq4btvLtv7UZoa0xWORalOqyoH9bjKfrzTvCqerKVoTHk5iTp+lKSVIzpR
         pHWqAjbRWbYRDXkViHGEoRooV9yNYuoAWFqUDRqjhfZhxgIXTlHW8ttLSV+TucUa5Zrs
         KV/m7+Tbi1mjHoAFihihONEc+3qg0PljNGcvY4uP4rqAw8ZR9tAlcX2k3WBU1UDOJc+k
         xpHuulAklJKNZv40zBHKIy9wsV5xkVTUjaTcA33h6TRA3rzx1UqJ2oO6zBSmfd37mqkW
         Ru0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9va69Z70VDBET6RC2fy59u2Ycvr0LSmJxWPH1bvD2co=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=ie9AZtQZ/rkHTgnBAZcLVaTpvy85v3uHRLm6QpMZGCFgd20az+YJe2Zitq2WN+yrlr
         XbFqNZ+4H7tAw0VI0T4w7kETzBQAAW/8NbuidC2G4UnIN3dUHp2i02GRv8E3mhKk6KOB
         dWL15b9LnnXRjlo7gMdcayQ8oyjlFicqQfEUqJXl0OkkMA71Q5rASr/qbjAUCu16wbtT
         5FytPlRNxQCe5OxuatVywgmq6HieR7brQogT0RHOAK8vsA9F66dGQ8YTMKCibruJ3g+o
         N3pSuAs9i6U1DXqXnI/6yzyxOD0pAtZ0P3AsVjI8Jck+YXXSN8biWtygsZk5dZNZRCto
         rTYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792529758; x=1793134558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9va69Z70VDBET6RC2fy59u2Ycvr0LSmJxWPH1bvD2co=;
        b=QrNh3kgcdR/6jLgf7MwS2UZRSkGRoGZhk18YMBsEnRYrGG5nJKu38/qpATYqjQli2M
         BlCzS9dUMi8inZgL5aGyjJ+dQBf842MYTJrRhpJxlNHs2t1yFjMDpHPC2fTAjy7F0O57
         GFqSWT2CpgAxr5SAXS5zLNQMWBQuweohGGNKyIy009mlEGwi+m2Q9Zu9/zvut3wcuPL1
         TrcK7XZqqswCRpvhXdW6PLYomEFiBbocJzkD1yEbaeE+Numo51nFgBTZmU3+oBz9Yp6x
         fcFX1Nc2xS+g/h7UbOcfRwr7UqVol1rCW6bl/KSAtRnXIST4bjOlAJwJfq6wVhUS5Hao
         VVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529758; x=1793134558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9va69Z70VDBET6RC2fy59u2Ycvr0LSmJxWPH1bvD2co=;
        b=sHZqFOUTwSrb0OJ7wYKWfMD8bWj0gdFump/R/gOn1Ytr/ObwpJcuYnpf3L2jeMBjnB
         CBhAZiZppyjAEjRJrKz46vttSMUuYySH+4YUCr8Zu/hvW4N3bdziqLujA9quTCf+OjaI
         VS3uFk+yrvTN8inIak9mL26rlWMs709aX5E06DG3DwkjkL3PbsewzHjOu8LkhJ6pAryP
         cBMM1Ma1tN0jOqxzG5g4Ns4aCxheNOouylOwfO8I1eH0S8gtDl751Qp5QgdsAUySlu1j
         AxgjzJw1wRiX3nF3PD3Vtuo4+EcRLjWAxh11cH40BnQMo90Ly6ayI3usrIqjPdcZXu2V
         8auA==
X-Gm-Message-State: AFq9FYLtNlzlLCwfYJhhVB4xPDdH+QF1RsLinwppNKjZknv9Bd4mwl4a
	kgbZP5YXN6IKNUiGa9fiIu9UvGipr7vRSTFnNce759RFLB6XPvZKtsEz5zlL/oGzh+Lz0JoWMfg
	U9BrHFQQnB7circo2bY27O6EDzLMswfw=
X-Gm-Gg: AYBFou1YNpdWJ87SYuKdfgjA6cGx4WWo0p/PlN+w7tFvaAPzfxeircXC+v2CaCpOUEO
	9jw3Cw9nTxZWPQA1hf4iNrHTpHT0Q+xoksXJe/vnGw3UO6sUtbwAP1aHr6hj0MPxljIbxe0+slb
	yCsOCu9joo2W4zR0BSi1zq4z1DjRW7xJbX+lxMj9Qbnb2sEZUrPp4je6t0Qef9RZjy0fNYeR/IC
	ZCCxfQ6K3DrtRj0bWHkBXEUCWgeLscgGaK8ttbI7Q/j3lbExVQE1p9GFVERvJOXGax5KWN773kd
	aTvVpOTJoA6UPLBx4LzRBNrkxmIoB1t8EGhmjRA9VQJSdKlo1sxjD5mxY/J3XibL3RLE4LZCw9g
	pyNIh6sR46avdo7XpCxpokG8m2ninOdL2dqJipjYnvEnr0oL3xsdcWlzekq4TWKxqPMwteWuWIw
	6sp27EdrrcJXEv8Q==
X-Received: by 2002:a05:6a00:4c92:b0:89e:261c:447a with SMTP id
 d2e1a72fcca58-8a089d8f4cdmr110909b3a.7.1792529757792; Tue, 20 Oct 2026
 13:55:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1da72318e969eb252977ccf5d8e3e506c2fa2e69.1792164438.git.lucien.xin@gmail.com>
 <179244540463.3135.17132817693152829356@kernel.org>
In-Reply-To: <179244540463.3135.17132817693152829356@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Oct 2026 16:55:46 -0400
X-Gm-Features: AclHuK_xypNF_3ZupZmQ5gCHrMwwp4u_9BbDfwJ9qW_3NU4_ksSvUmCEVd-BZ04
Message-ID: <CADvbK_d=J7Oq8VQFRYzoxX0YPs26tnJvxE7wMa4hyoe_M5n39A@mail.gmail.com>
Subject: Re: [PATCH net-next v17 11/15] quic: add crypto key derivation and installation
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	metze@samba.org, mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 5:30=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] quic_init_sock() (net/quic/socket.c:58) sets sk->sk_destruct =3D
>   quic_sock_destruct.
>
> --
>
> quic: add crypto key derivation and installation
>
> This patch adds quic_crypto, which derives and installs QUIC packet
> protection keys for the Initial, Handshake, 0-RTT and 1-RTT levels. It
> handles key updates and stateless reset token generation. It also adds a
> quic_sock_destruct() callback that frees the per-level crypto transforms
> when the last socket reference goes away.
>
> > diff --git a/net/quic/socket.c b/net/quic/socket.c
> > index 12f0817c8b55f..9b1106a9f5e73 100644
> > --- a/net/quic/socket.c
> > +++ b/net/quic/socket.c
> > @@ -40,10 +40,22 @@ static void quic_write_space(struct sock *sk)
> >       rcu_read_unlock();
> >  }
> >
> > +static void quic_sock_destruct(struct sock *sk)
> > +{
> > +     u8 i;
> > +
> > +     /* Deferred crypto free for async encryption/decryption. */
> > +     for (i =3D 0; i < QUIC_CRYPTO_MAX; i++)
> > +             quic_crypto_free(quic_crypto(sk, i));
>
> [Severity: High]
> Is it safe to free the crypto transforms from sk_destruct, given the
> context it can run in?
>
> sk_destruct runs in whatever context drops the last socket reference.
> Later in this series, several of those contexts are softirq:
>
>   quic_packet_rcv() (UDP encap receive) ends with sock_put(sk)
>   quic_timer_timeout() ends with sock_put(sk)
>   quic_packet_rcv_err() drops its reference with sock_put()
>   quic_packet_xmit() takes a reference per TX skb through
>     skb_set_owner_sk_safe(); sock_efree() releases it on TX completion,
>     usually in NAPI
>
> If the user has already closed the socket, any of these can end up as:
>
>   sock_put()
>     __sk_destruct()
>       quic_sock_destruct()
>         quic_crypto_free()
>           crypto_free_aead()
>             crypto_destroy_tfm()
>               alg->cra_exit()
>
> The AEADs come from crypto_alloc_aead(cipher->aead, 0, 0), so an async
> hardware implementation can be selected. hisi_sec2, for example, register=
s
> both "gcm(aes)" and "ccm(aes)". Its sec_aead_exit() calls
> dma_free_coherent(). Behind an IOMMU that leads to __iommu_dma_free() and
> then vunmap(), which begins with:
>
> mm/vmalloc.c:vunmap() {
>         ...
>         BUG_ON(in_interrupt());
>         ...
> }
>
> Can this hit that BUG when a QUIC socket is destroyed from softirq?
> Listen sockets already hold AEAD transforms in this series, via
> quic_packet_get_alpn()->quic_crypto_initial_keys_install().
>
> macsec hit the same crash and fixed it in commit 6624bba469a3 ("macsec:
> use rcu_work to defer RX SA crypto cleanup out of softirq").
>
> The note about in-flight async requests holding a socket reference covers
> the lifetime of the transforms. It does not cover the context in which
> the free runs.
>
> Would it work to defer the tfm teardown to process context, for example
> with a work item or rcu_work queued from quic_sock_destruct()?
>
True.

Didn't know crypto_free_aead() must be called in process context
due to the async hardware crypto implementation.

I will  defer crypto cleanup to a work thread like quic_udp_sock.

Thanks.
