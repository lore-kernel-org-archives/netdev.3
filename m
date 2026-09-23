Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF931B80D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206436; cv=pass; b=hb8KZUyt7c0IbJ9AMw6WzcXn7vUx3z1BKkw7ECNvHaGeBOEPBfC9LDNZT3j53bc0rum8W8BvYeai1UQsqUBtn2TcUBXnO8YXpCop+n1UJo3XApmaU/5dLHeT9KuN9VA2CoUQjD3y6p2b/n+9Z8rOea/xdaMy/ufd1r8jOScmn7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206436; c=relaxed/simple;
	bh=SBprGBTtStMx7RZpUukf9M0MowbciPkNiSYqCcyl6Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt5GxntCXHpH3FI21pywQjg4NqnSPZ4UwzEtcn+O7uHkS1HO8hWlVYzzT2+y0CA194iVVs+1PLNxy2VHz+WrE6bMyUvwE7UIoXBq/UrqnZ5PPGIYLk33HmHC/vkS3Q80uqNjzRGwUvin15RTOghmrFXTLzOGUSWyMqw2lQxKoQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uS315y1/; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uS315y1/"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so15432161cf.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790206433; cv=none;
        d=google.com; s=arc-20260327;
        b=fMwuMbE/dZciLuDevaN9JG2aLQfcKjQvMMucjkc+bBqJkLoMyCzmyjdot0pGXoPUi0
         O+vG2mR8woCGLR2o71Jq82Lgzd0bPoOL2+l/VgBCA7vtG2LII5/kIUnGT51pf8VKSIK+
         1bytEFoFfifif410D9+fP/XJRy3VJC3XFeOCmha8tvfrz4Al+uHo5p/ETjtljDnHjpUE
         RaJcy6jc3k3Yr29NWAT41DCAurNRQV7DdwPIQ+kwmZmA/Vj3YmLHvFywVyc2nfd+QESi
         YLo+cHISAPXYXupmxNbdArJcR7UTYsLPiWT/GhTwu023vJMGI3XrRnAD4Kn6ZHBeouI9
         L2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FR8ZnQ2vJv6H3udVOOnqyCoVoQeq9HOSiKJxdLOfxrQ=;
        fh=sSmSVS7DeAsKc+FpCSFtOUi/Dq6Lf9INpMuH6zpoLb0=;
        b=NDba0CYLSY7f7ZTLV0XWyMfP1Ee5omwVgA1daVT54gGSFzfeLcW5HF2BRUaoaio3en
         iaXWvI7tjuy02BsdRmHZ4JPL/mr3uqhDYsqEypf3bag4MJy0SiARNhoHCcAFf4hUXaJ+
         49PHaeTWA5BVVu9Q98LrYFLcvzWvToEtcNNOIXxMw2mTpE/GfuW/XVgO+fOejVxa7XVw
         /kbw3wbwxkBo/fjQW4nMW7sr/J5MBNOxWclXUwsokDf1bHZHo8hHPwvfpJHJ2D1yuRRr
         qAtXmRyeOyS4VKAoMk3LTm0GoOLISw87vtmGP8/6eQnEkMzICLjoPGzBVfXbnT5WAHMf
         jV+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790206433; x=1790811233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FR8ZnQ2vJv6H3udVOOnqyCoVoQeq9HOSiKJxdLOfxrQ=;
        b=uS315y1/qlfBQQIXFKc+YSdYUKgcezt6sanGuis3TcDLXvRuY+/+57ZlwIckJeinzz
         8ZTG3JVeebi5S+6jb5qr7cVnuguRvH/48mvwBdIaStaoEAotrpd8uwmPwE/TqOm/ext1
         WgBl+hnRwyFxZEyQBqOsXHiVSV5RINcSBNtKue+o08DdDgVdeKXVBXem8L62al6GnIPx
         6K/yWXuQL3L6FZzqLx30JmA3sJdlg1NcRZ6xvE3bQMF7Z2is8rUqVRKdgqz/L//sbAsd
         cxmBTnmqCTNC0NnFdMJEXzKlmOBKErYh16TB7Doc/+tHnwNIAiDxLtRypQ2hw0bxZl5D
         wwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790206433; x=1790811233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FR8ZnQ2vJv6H3udVOOnqyCoVoQeq9HOSiKJxdLOfxrQ=;
        b=MLucZFLDqdbeeTgudu5S4NtZf8jg2fDKusj/itD+k9LOG3OLNKs9m4VQxluAaefv5k
         jBzzWJ2pELuvkXXGFI6TG/zjrE5GqQGUEOuNlH1Z+sK7eCUKRyc0McMthAWcdZ1RACwL
         txgwU4P6mF006eSVqOkkaFZzx3gIydCpwXEutbw/8d6iBw75hNuJRikqDmtRj7yj4Q/q
         EiCqDYFt0RgXy2+K+2+aVABFdTIup+uJBLaDjGGXXxW+JWyYfqsx3pyxGJB9wKtH/ybj
         YMi1dHf9goy21O9XTM38dRqEghYAlD/0Y016eEZurdWztuefcnhERhVbe5zamI9qRUPB
         gDxg==
X-Forwarded-Encrypted: i=1; AKwUvBxiWu+7uIspxMOP9rnKAwn6I9ZjyEs8G5wKyZrYJr+PNhdo5RYHnBx4n05qxWXS3xt1j8JP5x8=@vger.kernel.org
X-Gm-Message-State: AFuF++ljApC5lB3Ft52a9UzE6DyRzNeN7LjLLYuvM0+ERFgZfrnt5blc
	+rSHLz6FMpCEQH8U2GRAWF34KiZgd04Bs+rW17m4nJTPlWAXixv8HcdjSzwEV+o0i/mGOsevvps
	6R8FSh+hFqMLr8MO9h8Mpw7Bf1Op6pCqq+5M8UpTJ
X-Gm-Gg: AYBFou0YVL71nX5OZDYLTAUJDvUf45qAgiSFY7nihkAcnUXNkO5Fi4hbDz3taOXLpvi
	9Nj5fKFiLqEJcswDyzcOnBZkhinfKiFAV9DfM9z6Bnzq9j1j7+6N1CQiXBwVrKQu7PE38IaSVmy
	2yHR8/nKTNMHRGhdDQxKx8byItpNchHm6bpKNsbt5IM3STpsoS3lVmVmIjdYiCI0vzEaS+I+fxa
	naNjx2pAiyj9dLkBHllqcOKPO0eRdorO+yCV+Ctr992Y9VUi5rrSS3q+XZ33NhvR2iMDMI8+LzJ
	J6Nqva/d/3b4V5wp4256QJ9sTPvlXzGsUUzqRfwnbBdQdSb63NAongmscCsQ4O2mPXMCYu6NIoS
	OlXEPUUO+hAsJyvk/qInZvStWgzdFpAOniA2utf9rCwZfej3kGAYnmMDvh//jKwlbtW8P
X-Received: by 2002:a05:622a:1a93:b0:530:3052:5257 with SMTP id
 d75a77b69052e-532fb56d2c0mr12960741cf.27.1790206432783; Wed, 23 Sep 2026
 16:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922163458.3900996-3-edumazet@google.com> <179020300229.2160803.17928745811588370151@kernel.org>
In-Reply-To: <179020300229.2160803.17928745811588370151@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 01:33:41 +0200
X-Gm-Features: AclHuK-npsg8aXZ4384oVYR8YsYUwrQlk-TaR5g57jiZfb5klVkk_rYppYvHfGU
Message-ID: <CANn89i+Ya8VA1p9kcjka3JR0AHCGLe8kagezCkchuFgoCHRWRQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/4] net: ethtool: generate RSS keys that
 spread flows over all queues
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:36=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
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
> - [Medium] netdev_rss_key_init() (net/ethtool/common.c:1546) is invoked
>   through DO_ONCE() from netdev_rss_key_fill()=E2=80=A6
> - [Medium] The fixup introduces key-independent collision families in the
>   bit that selects the queue.
> - [Low] Stale cross-file memory-ordering comment.
> - [Low] net/core/dev.h:93 introduces the block with '/* sysctls not
>   referred to from outside net/core/ */', and this patch adds 'extern u8=
=E2=80=A6
>
> --
>
> net: ethtool: generate RSS keys that spread flows over all queues
>
> This moves netdev_rss_key and netdev_rss_key_fill() from net/ethtool/ioct=
l.c
> to net/ethtool/common.c and replaces the plain random draw with a generat=
or
> that forces some key bits so the Toeplitz matrices of the q lowest bits o=
f a
> hashed field are non singular, then rejects keys where two 32-bit key win=
dows
> alias.
>
> > diff --git a/net/core/dev.h b/net/core/dev.h
> > index 0127b4d03e525..a5e22b2eae523 100644
> > --- a/net/core/dev.h
> > +++ b/net/core/dev.h
> > @@ -95,6 +95,7 @@ extern int          netdev_unregister_timeout_secs;
> >  extern int           weight_p;
> >  extern int           dev_weight_rx_bias;
> >  extern int           dev_weight_tx_bias;
> > +extern u8            netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
> >  extern bool          netdev_rss_key_initialized;
>
> [Severity: Low]
> This isn't a bug, but the block these two lines join is introduced by:
>
> net/core/dev.h:
>         /* sysctls not referred to from outside net/core/ */
>         extern int              netdev_unregister_timeout_secs;
>
> netdev_rss_key is now defined in net/ethtool/common.c and read from
> net/ethtool/common.c:netdev_rss_key_fill(), and netdev_rss_key_initialize=
d
> (added by the preceding patch of the series) is defined there too.
>
> Should the grouping comment be adjusted, or should these two declarations
> live somewhere that is not described as net/core/ private?
>
> > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > index 23db40618fed1..b4e766e60d38a 100644
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
>
> [ ... ]
>
> > @@ -1400,3 +1403,174 @@ enum ethtool_link_medium ethtool_str_to_medium(=
const char *str)
> >       return ETHTOOL_LINK_MEDIUM_NONE;
> >  }
> >  EXPORT_SYMBOL_GPL(ethtool_str_to_medium);
> > +
> > +u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
> > +bool netdev_rss_key_initialized __read_mostly;
>
> [ ... ]
>
> > +static void netdev_rss_key_fixup_field(u8 *key, unsigned int lsb)
> > +{
> > +     bool d[NETDEV_RSS_KEY_SPAN];
> > +     unsigned int i, t;
> > +
> > +     for (t =3D 0; t < NETDEV_RSS_KEY_SPAN; t++)
> > +             d[t] =3D netdev_rss_key_bit(key, lsb + 31 - t);
> > +
> > +     for (i =3D 0; 2 * i < NETDEV_RSS_KEY_SPAN; i++) {
> > +             bool value =3D true;
> > +
> > +             for (t =3D i; t < 2 * i; t++)
> > +                     value ^=3D d[t];
> > +
> > +             d[2 * i] =3D value;
> > +     }
>
> [Severity: Medium]
> Does this fixup create collision families that hold for every generated k=
ey?
>
> d[t] is the key bit that field bit t contributes to the lowest hash bit, =
and
> the loop above enforces, for i =3D 0..7, that the XOR of d over the set
> S_i =3D {i .. 2i} equals 1:
>
>         d[0] =3D 1
>         d[1] ^ d[2] =3D 1
>         d[2] ^ d[3] ^ d[4] =3D 1
>         ...
>
> XORing any two of those relations gives a set of field bit positions over
> which the contributions to the lowest hash bit cancel for any key the
> generator produces. On a 16-bit field, S_0 xor S_i for i =3D 1..7 gives s=
even
> independent masks:
>
>         0x0007, 0x001d, 0x0079, 0x01f1, 0x07e1, 0x1fc1, 0x7f81
>
> So starting from source port 0x8000 and XORing arbitrary subsets of those
> masks yields 128 distinct source ports, all of them above 0x8000 and so a=
ll
> unprivileged, that always land on the same value of the lowest hash bit.
>

This is a mathematical consequence of Toeplitz linearity over GF(2), not an
artifact of the generator: the q x q matrix mapping the q lowest bits of a
field to the q lowest bits of the hash is the Hankel matrix M_q(r, c) =3D
d[r + c]. Over GF(2), det(M_1) =3D ... =3D det(M_8) =3D 1 holds if and only=
 if
d[2 * i] =3D 1 ^ d[i] ^ ... ^ d[2 * i - 1] for i =3D 0..7. Every Toeplitz k=
ey
that is non-singular for all power-of-two queue counts up to 256 satisfies
these relations.

Note that these relations only constrain bit 0 of the hash (queue parity).
For 2^q queues (q >=3D 2), the remaining q - 1 bits of the queue index
(r =3D 1..q - 1) depend on d[t + r], which include the unconstrained odd bi=
ts
(d[1], d[3], ..., d[15], ...) that remain secret and uniformly random.

> With ethtool_rxfh_indir_default(), the queue is index % nq, so for a
> power-of-two queue count those 128 flows are confined to half the queues,
> and to a single queue when nq is 2:
>
> include/linux/ethtool.h:ethtool_rxfh_indir_default() {
>         return index % n_rx_rings;
> }
>
> drivers/net/ethernet/google/gve/gve_main.c:gve_init_rss_config() combines
> both, filling hash_lut with ethtool_rxfh_indir_default() and the key with
> netdev_rss_key_fill().
>
> netdev_rss_key_aliases() does not catch this since it compares whole 32-b=
it
> windows, whereas the relations above are XOR relations among their lowest
> bits only.
>
> The changelog says the key "is a secret that stops a remote attacker from
> steering flows onto a single queue". With the relations being forced by t=
he
> q =3D 1 and q =3D 2 guarantee (non-singularity alone gives d[0] =3D 1 and
> d[2] =3D 1 ^ d[1]), is that still accurate, and could the commit message =
and
> the new scaling.rst paragraph say what a chosen-port attacker can still d=
o?
>
> [ ... ]
>
> > +static bool netdev_rss_key_aliases(const u8 *key, unsigned int bits)
> > +{
> > +     u32 windows[NETDEV_RSS_KEY_LEN * BITS_PER_BYTE / 16];
> > +     unsigned int i, j, n, r;
> > +
> > +     for (r =3D 0; r < 16; r++) {
> > +             n =3D 0;
> > +             for (i =3D r; i + 32 <=3D bits; i +=3D 16)
> > +                     windows[n++] =3D netdev_rss_key_window(key, i);
> > +
> > +             for (i =3D 0; i < n; i++)
> > +                     for (j =3D i + 1; j < n; j++)
> > +                             if (windows[i] =3D=3D windows[j])
> > +                                     return true;
>
> [ ... ]
>
> > +static void netdev_rss_key_init(u8 *key, size_t len)
> > +{
> > +     unsigned int lsb, bits =3D len * BITS_PER_BYTE;
> > +
> > +     /* Four keys out of five come out of the fixup free of aliases, s=
o
> > +      * drawing another one is both simpler and cheaper than repairing=
.
> > +      */
> > +     do {
> > +             get_random_bytes(key, len);
> > +
> > +             /* A field ending at bit @lsb uses key bits [.. , @lsb + =
31],
> > +              * so stop as soon as a 32-bit window no longer fits in t=
he
> > +              * key.
> > +              */
> > +             for (lsb =3D 15; lsb + 32 <=3D bits; lsb +=3D 16)
> > +                     netdev_rss_key_fixup_field(key, lsb);
> > +     } while (netdev_rss_key_aliases(key, bits));
>
> [Severity: Medium]
> How long can this loop keep hard interrupts disabled?
>
> DO_ONCE() below runs the callback under the global once_lock with IRQs of=
f:
>
> lib/once.c:__do_once_start() {
>         spin_lock_irqsave(&once_lock, *flags);
>
> and the lock is only released in __do_once_done() after the callback
> returns. Previously the callback was a single 256-byte get_random_bytes()=
.
> It now does get_random_bytes(256), 126 netdev_rss_key_fixup_field() calls
> and netdev_rss_key_aliases(), which builds up to 127 windows for each of =
16
> residues and compares all pairs.

This runs once per boot when the first NIC driver initializes RSS (typicall=
y
during driver probe), and as noted in the changelog we already cache each
residue class on the stack specifically to keep a pass down to ~116 us, wit=
h
~80% of keys passing on the first draw.
