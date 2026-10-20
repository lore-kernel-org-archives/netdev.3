Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792532333;
	b=LjLSlaDpBjHohngSZaxAwI7SWLAMCTJUgKc37MlfPMllVAu1ElqcAPvaPKLaFfpVFOyG
	 ZARw0zUSVof9ajMuhSWTi/jU2A8pKV8n5kByftmeXhI0V6Wi6SGzjEl9r2M6PLqVGgcOc
	 lWxgGLx5OIcuECYrT/rl/N5m3c25+Ft8cu5K9ditn3Ot3rnxTI9Zr3FVOK7KWCiJR3ywY
	 W3kg+8Ox/rPmtWYMXbrSj87odyGx9a6Dt6ZFTSOg7YheD3tsS2YF9T95lOxMIXrMCUFjr
	 DEh/6Yak/ZMagyeXDmmNdJK6RNCl4YufRNG7crV8ZjsVWfCm5LyQW87RqygEkd3lfhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=T07kOSF9AnuZjBYq6sbm0WLv57Cp3iAwopu/k0yBEUo=;
	b=HN0dRqeviny/tPaxZRK3yXyf/Hp8Pl/GU/XgpVk3UAnddVGpHos2NedVbITULV7Kiz0x
	 Vtm6kfwxxniOPIsm9XJOGnTvkCr18bkZ6PZrS9iPyL7DypDBhYpEmeJy/xTf8zwsJXyL6
	 hwcEE6u8Gw0SIYmhWEEH+7TFBph1CmnovhRRwQiMR2Y38/IAcTL1+Ff+XPXB1Rq2Q7A/a
	 DvcIlXA/aLFOwR1jtaZt7ISdbeWt5hjKIAaz7B6XDtUmK2zhRpvkd0O08tEv4XS6toAmo
	 Nn4eL8WuychWCeHlLvg2OWYftVdfsrhSLhUPC3O7Rg97u9HcSH0mawnw9Sd3nvsDjBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dAgFX6tJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878C60A260B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3878C60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dAgFX6tJ
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e9528732b4so33263e0c.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792532332; cv=none;
        d=google.com; s=arc-20260327;
        b=ChYcCU8oqaYpIK3Zu+XuyxliJf6uKEgzBntV1kl8CufyF7VBY5dlYQaeNkgFTc6zjb
         C1E+5MclWVjHSYpwO1JJcoWXNL9KtiEjv0DrnRCTYlkRXi/M6harvIbNZYcYbdcEUs6E
         FqoCPGJzthbIEYbWcmoQ7H1e/gvznU+HeAh/UF9feQydZl2E0qlMz+p0EKIpmX4A8y5I
         HxZ4RjvMMr+PnyjC+X0m4YGY7mvtKtiQVBBYR1wc77wUExYuF0DPdW8f72er/sWfFUbp
         AduYRMp0P9iN1Una1nZEEIlfp00HoZe07ODkDvrveugAz+jaFTNJH4ISAtbuQMhUyezD
         Ev8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T07kOSF9AnuZjBYq6sbm0WLv57Cp3iAwopu/k0yBEUo=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=Wv871iSYqAj32bGWzRZ/235PgTtpWC5GfB5z6u3dU7fbfMqDDYuMx7MzV83NpgGCll
         hmOiTD2k7xCr8ZYppeDnCqFmW8RmmAq0OQl71/8MvTDCg1V4EssN5vXvYGlkwNMw788S
         5cSQJaqt8Qm1lAyBVOWCJNhKXcrImPuyFHZSRWgIY2tjKYsKaEm5bWpzIqOseZoNnH1V
         BEMfwEeymbaaDR1eIdPiOeMcL5vasrIX2ZvAFwc2wdr/UrZnRlzcvn0V2t8jGNC3Pe7n
         5E+ASh4flaEto9OXZwLn0ATLlIjHJyGvuYricJBAs3HFPUEXhzhbmWDAHGyRzWTthK2x
         dF5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792532332; x=1793137132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T07kOSF9AnuZjBYq6sbm0WLv57Cp3iAwopu/k0yBEUo=;
        b=dAgFX6tJjFIcJcwrmmWjfMPEG6dEgCSTu3WVsdtgFsEKlSOBKIFvbieKpoxY7cGFAr
         fP5sIai4+7Mn3tMBDqj9RL8VqFleyeU16XLAIEnbJktxu5Qj6HeilEcjGMvM9ZIkm75T
         ZNwVKRrLObDKrV00n8W2PYFM2MHakX1dEApvttkovOpIffMVgYAIuHIN8JEPeR5m88fa
         sKyraStB4izPLYt73PnK+9Yb/tCJkthAm0ecEbT+mteLRHeDJ7DCLEWvSC/0PUpV6a3W
         ReEQa792mYSEte3RWOojbthrjlucZQ9SvMjHXTyXD5azVyMkdo0jsTCX9dyU7vN/i4xo
         xw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532332; x=1793137132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T07kOSF9AnuZjBYq6sbm0WLv57Cp3iAwopu/k0yBEUo=;
        b=QPv2sMVSkNowBWwhxH2/H0rdvj5ZkZOhPNU3yqdajKLzLyeqWYBGrhR0/bJucUyV4J
         N+ApMr34dyqfr8KZUzwTpqwvi22sCTmGHCl/vzwnzwA9mu784b0FOovJFJDy6JEIYea0
         iUTBIxPH8T8EIZRzyK5fimbw/ZbypW3pE2YvFmrwy98INA+jxfEoRgwbk8TvPOTUtQac
         F8rwMx6Wao78+tqQjwEyky1MsfODGR8EdRJkpTgJDWrT8rZCxD2HC4yimYLmyzopTGZp
         v5t8VfmTVhc4IsxfkKu9c6lt0pLC1DilXqgqVUhypCTkFJEsUymhFnt0QbVbzR2MDC1q
         wQAw==
X-Gm-Message-State: AFq9FYJbQQcHR6fDt5Vt9LsEwD2ne8wjVWoO5enC5IgSciiz66uz9GnX
	vPO4tq/vs/ebSUIaphZf8l9Z+oYTxyRcy2r7SqiRT7On06zS1hVAIX5yCPI4+55hDrZ70tyXUx6
	Pwn5Ny7ZqmB9aLdfeZOw2yJNr3TM6XPk=
X-Gm-Gg: AYBFou07iaCwzURHZTwyqo722aG1B5GaRVDlVNDrL9QLXQLmmwvqnlTKBZ03B6IvL4E
	ugd4YRA/JZIq16vgvQ1e3cJ355bU00hto4gakue/KNubKm/HSq926yspIMkJdIznG/SNGjgVNRU
	k9dy7GzTUzU2i2Yh9O1yJLYcs5TVySViljYlkzFsCWlMDlioSqPt1q/J1PjVMmXs9WN+i03oQFr
	BWdo2Bzj0HKZFUBw1opVMWH/Gfj7BQBjwiXDWyzc0R50aImSlwhlF2rMKZeamXDI14umTXVyDeP
	nX73JjGkZJA0wRjuN3OtXqTgHdhj1JTtBHzZb8D2icffK6WgeuD5iWzwNPEqrlaFqfNPtI4KVNJ
	ySPh24d79dlPPQ5LRS+qI4M6TKXEFKTi2Li2OrddXJ0OSqpopKINTgGAfvZ3NqhFrDPdlmk2fi5
	9unM0vnYYqmf9p
X-Received: by 2002:a05:6122:f8f:b0:5c9:a60b:e5a2 with SMTP id
 71dfb90a1353d-5eaebe1fda5mr38131e0c.13.1792532332203; Tue, 20 Oct 2026
 14:38:52 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <25d5d63b6de931191e4c1bb0d99edf427facf1a6.1792164438.git.lucien.xin@gmail.com>
 <179244540755.3135.6629272689764365696@kernel.org>
In-Reply-To: <179244540755.3135.6629272689764365696@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Oct 2026 17:38:39 -0400
X-Gm-Features: AclHuK_BijVex1bq8DNyjPV3DVLOPmzVNY4j7ByN2m0CAL1TjImhtpQ-k6hL3bE
Message-ID: <CADvbK_fJ1czV0OU_oTKAjKG+3807yhBbOTddkzJE0+Aqz3+u6A@mail.gmail.com>
Subject: Re: [PATCH net-next v17 12/15] quic: add crypto packet encryption and decryption
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
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The token timestamp is sent in cleartext, and the obfuscation
>   offset is too narrow to hide server uptime.
> - [Medium] NEW_TOKEN tokens can be linked to the connection that issued
>   them, which RFC 9000 Section 8.1.3 forbids.
> - [Low] quic_crypto_decrypt() adds every payload-stage failure to the
>   connection-wide integrity counter crypto->rx_fails, not just=E2=80=A6
> - [Low] When an old-key TX packet resumes after async encryption, it can
>   start the key-retention timer meant for the first new-key packet.
>
> --
>
> quic: add crypto packet encryption and decryption
>
> This patch adds AEAD payload protection and QUIC header protection for
> packets on TX and RX, along with key phase tracking and key update
> handling. It also adds helpers to compute the Retry integrity tag and to
> generate and verify Retry and address validation tokens.
>
> > diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> > index 2b72a781493af..93fd4cdb055f2 100644
> > --- a/net/quic/crypto.c
> > +++ b/net/quic/crypto.c
>
> [ ... ]
>
> > @@ -269,6 +270,484 @@ ciphers[QUIC_CIPHER_MAX + 1 - QUIC_CIPHER_MIN] =
=3D {
>
> [ ... ]
>
> > +int quic_crypto_encrypt(struct quic_crypto *crypto, struct sk_buff *sk=
b,
> > +                     gfp_t gfp)
> > +{
> > +     struct quic_skb_cb *cb =3D QUIC_SKB_CB(skb);
> > +     int err;
> > +
> > +     /* Packet payload is already encrypted (e.g., resumed from async)=
,
> > +      * proceed to header protection only.
> > +      */
> > +     if (cb->resume) {
> > +             err =3D cb->crypto_err;
> > +             if (err)
> > +                     return err;
> > +             goto out;
> > +     }
> > +
> > +     cb->key_phase =3D crypto->key_phase;
>
> [ ... ]
>
> > +out:
> > +     err =3D quic_crypto_header_protect(crypto, skb, true, gfp);
> > +     if (err)
> > +             return err;
> > +     /* If a key update is pending and this is the first packet using =
the
> > +      * new key, save the current time. Later used to clear old keys a=
fter
> > +      * some time has passed (see quic_crypto_decrypt()).
> > +      */
> > +     if (crypto->key_pending && !crypto->key_update_send_time)
> > +             crypto->key_update_send_time =3D quic_ktime_get_us();
>
> [Severity: Low]
>
> Can a packet protected with the old key start the old-key retention timer
> here when it resumes from async encryption?
>
> One possible sequence:
>
>   TX packet encrypted asynchronously with cb->key_phase =3D 0
>     (async_pending[0]++)
>
>   RX packet with key phase 1 arrives on the backlog
>     quic_crypto_decrypt()
>       async_pending[1] check passes
>       quic_crypto_key_update()
>       key_pending =3D 1, key_phase =3D 1, key_update_send_time still 0
>
>   Phase 0 TX packet resumes
>     quic_crypto_encrypt()
>       cb->resume -> goto out
>       key_update_send_time =3D quic_ktime_get_us()
>
> The comment says the timestamp is for "the first packet using the new
> key", but this packet used the old key.
>
> The next phase 1 RX packet in quic_crypto_decrypt() can then clear
> key_pending based on this earlier timestamp. A later reordered phase 0
> packet would then trigger a new key derivation instead of being decrypted
> with the retained old keys.
>
> Should this condition also require cb->key_phase =3D=3D crypto->key_phase=
?
>
> > +     return 0;
> > +}
>
> [ ... ]
>
> > +int quic_crypto_decrypt(struct quic_crypto *crypto, struct sk_buff *sk=
b,
> > +                     gfp_t gfp)
> > +{
>
> [ ... ]
>
> > +     err =3D quic_crypto_payload_protect(crypto, skb, false, gfp);
> > +     if (err) {
> > +             if (err =3D=3D -EINPROGRESS)
> > +                     return err;
>
> [ ... ]
>
> > +             goto err;
> > +     }
>
> [ ... ]
>
> > +     return 0;
> > +err:
> > +     if (++crypto->rx_fails >=3D crypto->cipher->rxlimit)
> > +             err =3D -EKEYEXPIRED;
>
> [Severity: Low]
>
> Should rx_fails only count authentication failures here?
>
> Every error that reaches the err label is counted. That includes -ENOMEM
> from quic_crypto_aead_mem_alloc() and negative returns from skb_to_sgvec(=
)
> in quic_crypto_payload_protect(). It also includes any non-authentication
> error a driver reports through cb->crypto_err on the resume path.
>
> RFC 9001 Section 6.6 defines the integrity limit in terms of packets that
> fail authentication. For AES-CCM the rxlimit is about 2^21.5. On a
> long-lived connection, repeated local allocation failures under memory
> pressure could eventually push it to -EKEYEXPIRED.
>
> Would it be more accurate to increment rx_fails only when
> err =3D=3D -EBADMSG?
>
> > +     return err;
> > +}
>
> [ ... ]
>
> > @@ -565,6 +1044,241 @@ int quic_crypto_initial_keys_install(struct quic=
_crypto *crypto,
>
> [ ... ]
>
> > +int quic_crypto_generate_token(struct quic_crypto *crypto, void *addr,
> > +                            u32 addrlen, struct quic_conn_id *conn_id,
> > +                            u8 *token, u32 *tlen)
> > +{
> > +     u64 ts =3D quic_ktime_get_us() - crypto->ts_off;
>
> [Severity: Medium]
>
> Does this offset hide the server uptime?
>
> quic_ktime_get_us() is the monotonic clock in microseconds, but ts_off is
> only 32 bits wide:
>
> net/quic/crypto.h:
>         u32 ts_off;      /* Random offset for token timestamps */
>
> net/quic/crypto.c:quic_crypto_set_token_secret() {
>     ...
>         if (!crypto->ts_off)
>                 get_random_bytes(&crypto->ts_off, sizeof(crypto->ts_off))=
;
>     ...
> }
>
> That caps the offset at 2^32 us, or about 71.6 minutes.
>
> The timestamp is also part of adlen in the quic_crypto_token_protect()
> call below. Bytes 1..8 of the token are therefore authenticated but not
> encrypted, and they go out in cleartext.
>
> Any client that receives a Retry or NEW_TOKEN token can read the server's
> monotonic uptime to within about 72 minutes. The v17 changelog says ts_of=
f
> is used "to prevent timestamps from directly revealing system uptime". Is
> that achieved with a 32-bit offset?
>
> quic_crypto_verify_token() already uses the wrap-safe age =3D (s64)(ts - =
t).
> Would a 64-bit random offset work here with no other changes?
>
True.

will move ts from AAD to the encrypted part of the token.

> > +     u8 *token_buf, *p, flag =3D *token;
> > +     u32 len, tslen =3D sizeof(ts);
> > +     int err;
> > +
> > +     len =3D sizeof(flag) + tslen + addrlen + conn_id->len + QUIC_TAG_=
LEN;
> > +     token_buf =3D kmalloc(len, GFP_KERNEL);
> > +     if (!token_buf)
> > +             return -ENOMEM;
> > +
> > +     p =3D token_buf;
> > +     p =3D quic_put_int(p, flag, sizeof(flag));
> > +     p =3D quic_put_int(p, ts, tslen);
> > +     p =3D quic_put_data(p, addr, addrlen);
> > +     quic_put_data(p, conn_id->data, conn_id->len);
> > +
> > +     err =3D quic_crypto_token_protect(crypto, token_buf, len,
> > +                                     sizeof(flag) + tslen, true);
>
> [Severity: Medium]
>
> Can an observer link a NEW_TOKEN token to the connection that issued it?
>
> With adlen =3D sizeof(flag) + tslen, the microsecond timestamp is associa=
ted
> data. The client later presents the token in the Token field of an Initia=
l
> packet, and the timestamp is readable there in cleartext.
>
> ts_off is set only once per crypto context. Tokens are generated and
> verified with the listener's initial crypto, so every token from a
> listener uses the same offset.
>
> An on-path observer could find that offset by requesting its own Retry
> token. It could then map the ts in any presented token to the microsecond
> it was issued and match that against the packet timing of the earlier
> connection, even across address changes.
>
> RFC 9000 Section 8.1.3 requires that a token issued with NEW_TOKEN must
> not include information that would allow an observer to link it to the
> connection on which it was issued.
>
> This appears to come from the v14 change that moved the timestamp from th=
e
> encrypted part into the AAD so it could be used to derive the nonce. Coul=
d
> the timestamp stay in the encrypted part, with the nonce built from
> something that does not reveal the issue time?
>
True.

will add a field (u64 random) in the AAD part in the token, and use
iv xor  random to generate the nonce for token encryption.

Thanks.
> > +     if (err)
> > +             goto out;
> > +
> > +     memcpy(token, token_buf, len);
> > +     *tlen =3D len;
> > +out:
> > +     kfree_sensitive(token_buf);
> > +     return err;
> > +}
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1792164438.git.lucien.xin%40gmail.com
