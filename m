Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193B3890EE
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573933; cv=pass; b=UOg7042A7gtnPjH9eG+q8oj+lSUfHlQYcxLuLRBT0y9AoPEP7/qTVTQh75kq/Pp41ow5KB5gmT5OXoF+S5z/OTVRNRlo1DIBR25WlKf+DjELVdsfyIeoQp7c1tcopqkj8+iorLDx4ETF20N4Zv0/IpwFAs2IXndxyD99Ddq/Y0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573933; c=relaxed/simple;
	bh=95yWInc3f+wvYQiaDhRAR54L526l6o9/CFXKuqW3YLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTYp5NYwzh9JrKPcT/+yo4mukbGOERT0K2pSVTuq+dOZsbqZ6B9lqNpERS64Ds/Xu1pgHzhME70EKcxwuBpQV3oeoy2cs66FYcj2V4dmcJ1AgB8b6ymVDOjuKVAl/WQdfp8tJgU8SwLZhKTmSaVkYkJFGO7EZ0DiMnlLJn/fa5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp1xQj1r; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp1xQj1r"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85a4329731cso819070b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789573928; cv=none;
        d=google.com; s=arc-20260327;
        b=r2hqk3pMVS8JUdOLp6Zzsgwi+3DK44hkGMELXobd8CgRDo+2ZcDzbvivhpAzQCnvV6
         7xjTCJTH0eIVcJeDKsdyyQfefrQSitHLpLYLkC+AG5F9eZd2gJEkVhlCbM5l/qayG7so
         DV2jaX4pSQS2JeDa+qd6a877Ai2wfx2MxgvzG5MNYFSbu5FigEvWYAcZR1Oii/Rd8+cH
         7ezUURK068SaZdBWYzpXDatnOeR86c6EV+2m25iDotdfa1olSQ7nRZF55G8T0yUZMrlA
         6b+sZX9PMcQ/5qEL2Hxk1DeZHyniYIZo467mmyy0jQoA1h8E/XEtTd/NhYVkngLTW9Hn
         jm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5EyfF2xmjvND7Ej5BcVBP3F4zIxnNANBeziUA4WJEI=;
        fh=QFMgEb3XV5rS/ZRBmyHUP58oM4AaOHTWaWQeeAou20k=;
        b=SaIzibhwknj3Kt5i6yzvnElJ+cAG1Y/qgCyeoudw40k9B6Nd+PDNzm/ByLuonb2ve/
         NMW2oFr1Nw5qPnmF2DJGiP/0yms5XLltOoz/m4k/ehJZhaBEb04IsFGtGAqEmyWSKst/
         6u5RLERSkGii2ryTUxs0e1p6x81Ok9z1aPZ8LHSrhHWGzPsxMRmQzRxyFmRhNkA14yhA
         BTTqgI+XA7dH/pS/jZcN9G6NfvlcK55NhdeevVvSBAo07oaTqDxQylLSjlLmekIgulgi
         3n1WADH3ALuTHXosOkLjFIrczeWdOB5c6WsYYwWgtPLBN1uOyO+mOeKklIldtakH8qt2
         sq+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789573928; x=1790178728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5EyfF2xmjvND7Ej5BcVBP3F4zIxnNANBeziUA4WJEI=;
        b=Bp1xQj1rLBv1pXqQByiF36455pmW8LlSKKP9/y8U4Q9S6I/4uYomxtCWuer0U8uoDd
         T+UihBOOvLPGHKuEDQ6KwuF6WPaT1cDn5Q1QzSUH190BNqcahEFgAjcnjptgqbCM+XpC
         LWHDvpBeeZC4qnRnePNsskbaAh6Muj79j9UOk6inJfV9goWOY1KBazj7kc25TQCZ+qE4
         stQkV8VwS90y5IA8Vh69cDpo3RjfByx0SAOE0wRcJUHZnuaCazAwbpZuM/Ro6IuirT8/
         8DWmKCS+HaX9vahSrSrAeC9iso4oM8ro8ulFEK+nVQ49HkcEcoUpYUnsOca3gsfETLll
         NjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573928; x=1790178728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5EyfF2xmjvND7Ej5BcVBP3F4zIxnNANBeziUA4WJEI=;
        b=OhAZNlB/LXMrdeEN6nHIrQiobZ50phmOkUUL54tVEncpNsJfjh0ec9ffdZaYGYF8K8
         xCODo2wC6mfmRKB1Is4fr09jECtYMZVXVSchVTGCsamt/MjosE5kz97cwTyndsX+bWsh
         emhHarpYObmjrwVb6X9RAbEy1NTTbLA93M5hCAH4K2Z2KcQSP2Oiw5se3AuoRtdQZcu1
         VZ6GK4YzqpCpcEpJky0nD5CHUGeRaVyBreXr3Yx6eE8KXiz7dbeDXLgpr7it2ZEJRAZI
         +ZYPNxO8Ig29rfCuiSw0jqNVJkzgMFMLcOvaMS/IVq5aOQ350MbMTvUoEUIwcVUzg+gZ
         i92Q==
X-Gm-Message-State: AFuF++k9fBbR7gbT1gcYuD25amxNUw/nHTP9hXigTU4yz8DHduiy2s2g
	V5BKlRtuBRJtYW+mGyZJ79AHSE5O/eNugFPoj4cWlYvCaTxJwU9jKEtJaGgq5Sa+FmPmHdmysEq
	P7NxNqZkujI4BPAAjPkD//p5mwcwiqnw=
X-Gm-Gg: AYBFou1nMeUztIhHdQnYiWONc8SECkDxATc5q+HAu3bRPluLb4jCgdO5nf3OWh09/J4
	PJkflbfJ2Kvxe7GbFxX/x5V+oJkuYG6eunANjmZKYSBuuzzLu0OSMJHs1ucM+ZWhid9pLtZBA9R
	bIkCpocmH/x9rY8CFAk7/TI9PGpo/JF3qW1/GvdBU9kmG09hvnHxNM/P2hCxHToiAUQuHe8BBwv
	zaC5PYEwIMVLSsUCu+XuEfd+mM9ZPcTZZXoDReB2KMQZsAyw3uxOQ6ccXrHdA9KECS4AEBP+RjJ
	fjeZj2oMeiEgA+hyXmFfheOq9EpL65QPmZdjUex0PjVqfyP7kmcYxku6/X/WscfxCTIGenEIjLQ
	paZQGwQ+jMZ3zgX361A0jYG+qOeIYNtGHu4PoY9S48uw0TsMk0sHT2wTM
X-Received: by 2002:a05:6a00:4b0f:b0:857:7317:cff4 with SMTP id
 d2e1a72fcca58-8723a199a5amr6423934b3a.21.1789573927943; Wed, 16 Sep 2026
 08:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f886c618bd560e42692c0ac3296bae4878755cc1.1789393775.git.lucien.xin@gmail.com>
 <178950185147.22033.10922498784930147476@kernel.org>
In-Reply-To: <178950185147.22033.10922498784930147476@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Sep 2026 11:51:55 -0400
X-Gm-Features: AcwNN1UzfBxaJOMB6iv3Yg7aIgS3jN1akwkjx3YEKnt_lo6ALcoTP6dYS_KHoK0
Message-ID: <CADvbK_f8PF0uvQsULf2Z6ZO4Ln4b4=670EH8ixZZLjE_1uSM5g@mail.gmail.com>
Subject: Re: [PATCH net-next v15 11/15] quic: add crypto key derivation and installation
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
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:50=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> - [Medium] net/quic/Kconfig selects CRYPTO_HMAC but not a concrete digest
>   implementation, while every entry of the new ciphers[] table in=E2=80=
=A6
> - [Low] quic_crypto_set_secret() consumes the uAPI struct
>   quic_crypto_secret but never reads `level` or `reserved`, and honours=
=E2=80=A6
>
> --
>
> quic: add crypto key derivation and installation
>
> This adds net/quic/crypto.c with the QUIC key schedule: HKDF-Extract and
> HKDF-Expand-Label helpers, Initial secret derivation, traffic secret
> installation, key update, and stateless reset token derivation.  The new
> struct quic_crypto is embedded per encryption level in struct quic_sock a=
nd
> freed from the new quic_sock_destruct().
>
> > diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> > new file mode 100644
> > index 0000000000000..910557b680524
> > --- /dev/null
> > +++ b/net/quic/crypto.c
> > @@ -0,0 +1,567 @@
>
> [ ... ]
>
> > +static const struct quic_cipher
> > +ciphers[QUIC_CIPHER_MAX + 1 - QUIC_CIPHER_MIN] =3D {
> > +     CIPHER_DESC(TLS_CIPHER_AES_GCM_128,
> > +                 "gcm(aes)", "ecb(aes)", "hmac(sha256)"),
> > +     CIPHER_DESC(TLS_CIPHER_AES_GCM_256,
> > +                 "gcm(aes)", "ecb(aes)", "hmac(sha384)"),
> > +     CIPHER_DESC(TLS_CIPHER_AES_CCM_128,
> > +                 "ccm(aes)", "ecb(aes)", "hmac(sha256)"),
> > +     CIPHER_DESC(TLS_CIPHER_CHACHA20_POLY1305,
> > +                 "rfc7539(chacha20,poly1305)", "chacha20", "hmac(sha25=
6)"),
> > +};
> > +
> > +int quic_crypto_set_cipher(struct quic_crypto *crypto, u32 type)
> > +{
> > +     const struct quic_cipher *cipher;
> > +     void *tfm;
> > +     int err;
> > +
> > +     if (type < QUIC_CIPHER_MIN || type > QUIC_CIPHER_MAX)
> > +             return -EINVAL;
> > +
> > +     cipher =3D &ciphers[type - QUIC_CIPHER_MIN];
> > +     tfm =3D crypto_alloc_shash(cipher->shash, 0, 0);
> > +     if (IS_ERR(tfm))
> > +             return PTR_ERR(tfm);
> > +     crypto->secret_tfm =3D tfm;
>
> [Severity: Medium]
>
> Every entry of ciphers[] requests either hmac(sha256) or hmac(sha384), bu=
t
> net/quic/Kconfig does not select a digest implementation:
>
>         select CRYPTO
>         select CRYPTO_HMAC
>         select CRYPTO_AES
>         select CRYPTO_GCM
>         select CRYPTO_CCM
>         select CRYPTO_CHACHA20POLY1305
>         select NET_UDP_TUNNEL
>
> CRYPTO_HMAC is only the template (it selects CRYPTO_HASH and
> CRYPTO_MANAGER), while CRYPTO_SHA256 and CRYPTO_SHA512 are independent
> tristates without default y.
>
> With IP_QUIC=3Dy/m and CRYPTO_SHA256=3Dn, does crypto_alloc_shash(cipher-=
>shash,
> 0, 0) in quic_crypto_set_cipher() fail with -ENOENT, so that
> quic_crypto_set_secret() and quic_crypto_initial_keys_install() can never
> install keys and no connection can be established?
>
> Should IP_QUIC also select CRYPTO_SHA256 and CRYPTO_SHA512 (the latter fo=
r
> the hmac(sha384) entry)?
>
True:

Verified that CRYPTO_SHA512 can be disabled while QUIC is enabled. I'll add
CRYPTO_SHA256 and CRYPTO_SHA512 to the select list.

Thanks.
