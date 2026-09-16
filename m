Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B538A729
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571918; cv=pass; b=YdIv3447VeGDIMrcdO8BMUCZTJ4U31hrBXjyukC7lIsMA9YLb1mlAMMNhWbODIy3Y1w0urD782s3lZ9lhB2ECcW5va/wghCCE1LTwdl09QUF1zbvWDFu7mobs7rJGAjwE/3pXmDnXTqQie2ejsJMlZ5F1/uBm7D0pbM0sbdN1Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571918; c=relaxed/simple;
	bh=Dj+80PpyFtuTTPI24RANQuQHDc3eXfflbc+ICFvzogo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N72e5LF7zZo71cPCUNMh+f2B80btBNUi4cny7C84p5v3Tp6DEYgFyNUrExsJ3rEhQNsaIpRLVk3mZgv3kXorUg2VNp5P2akKTsX8AxYBu8qyD0WFAmGFDajCuWrXmO6NsC4JjlKxyCoO4nHeS9D8Cdo8jNpkFysOIMRr8ccFgxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6Fz9oeg; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6Fz9oeg"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85a4329731cso784073b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789571916; cv=none;
        d=google.com; s=arc-20260327;
        b=AKNJZVZNQuJK6Sl0qg8UmmWoXWoJy7WCamlwSySTqfM6SJpSiRdfntv2XmXuG5wCzQ
         192c+2Tu1c3gnbfyWvUOhZ8/PKy7QNbeYo/UcKXGrFfSS89RomtQfAX2nu5ektNRA6F+
         VVuu4LG19Y0xY8zcQND0mCw0emaITkDvxKfD+FGJM0EsUn36Mi7+vWq9WPe8Mdv5DEF4
         gbsW8z5T3OxwvNFEjjLG09D9zdz0fik4lzZRtE/OYAcEjQovuLItqF73gV6mayz1DyM7
         /6+DCkPw+9eHCCtriiiAf5fkSD7IG8+braCau3++7hSLk0k5uPUX8S4eR/D6Cqe5z0JK
         e05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhkqwMNKc8zR/oVQWFJv9edBfd9F+9BsRk6J/+nHhu0=;
        fh=QFMgEb3XV5rS/ZRBmyHUP58oM4AaOHTWaWQeeAou20k=;
        b=Z4UDieBHaBxvZBVFQXvgilu6dTW2R4ddBiRl3+7PxjLEC13eCEmVZarNU0HweUqugS
         i3Z1FbwPMi/bRM0fdo1mnYPwhz8VHB1x9snvYl2kTWg9G6YSrW6Zk1IScXlG9Kid1MGt
         u+OaLbqgr+JrwQ0FyokJ5LSqc1DELXp9AlhReicZfrgyJoH8Hpvbr2BMxUM490IezbbB
         7qTOo6Az4/qdhLe7S0cmCKTQxTfJ6QWQmqZMD5pI0nCPsRUGkofsnTuIB798pFPplJ4O
         FUHaGF2OmcwZZTun+SQ83HHWtaAayYmrvyNELUiHdkdL6t33j12qGIZsV3PZ5aCWiapV
         3Jjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789571916; x=1790176716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BhkqwMNKc8zR/oVQWFJv9edBfd9F+9BsRk6J/+nHhu0=;
        b=p6Fz9oegCiY0ldDuMQC7sX59TPJXzw7/kyXWVmfnl4qllZ4GRV9nfMxf0QtI57k0xS
         JpVtRCXr1hZJH9TPgqJl+kiUqIXVzjduJ7pIQ/XBT1oAMGKaQFieqanEKMraRsACm/yz
         79TlIcVSC3b4rJ5NiihuJNqbJCpyBw0B8uBj2kH8HXF09pxpUXj5ssitf4xByslbSmnp
         VfVfhB0ddLZNAys6ry4cGKz/v8Ika4hE3yv8w8Ml+dRPUQGih3FMqWvrBWHoWoNbH9Bm
         SKCQfMHWzfzK34VK6DZoNL3VlZcLw0aUoCahoePztk0ik4MaO2x74g+sHjqCWz+9k3PJ
         6UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789571916; x=1790176716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhkqwMNKc8zR/oVQWFJv9edBfd9F+9BsRk6J/+nHhu0=;
        b=e2/coqXVHNsCBF8OMYszwfFTkU112TeZt0WrXYctRGxQjJcruwXt9LdiRD54g4V5CB
         M3V9qT/zByW0tnq3cQ+owz8bhyILNyZCN9P8wv1VnnJ3QRH1O2Il0eP8HQV6fLGomMN4
         +EkYfDE7YTzt6fhhNYe60E7yjF1WkpEglgaGv1pLzmzhUz5Cr4db/AVC5xO3+X0P9UMQ
         /ZfEidGZFb48bJFxfJ2HBt1mI4jP6Uys4fk/uF2VHra+VhENktuOHAyi9nYq4YYd0ryX
         P5vBIlOUCT6xIc8jAvCzl4kDVCE+MKg10+md45E4fRTZDD21RGFip8IZVD9S3w3hInI8
         DAFA==
X-Gm-Message-State: AFuF++llpFSBCMr/CuZuz8R/kfLsWviD31Xxnw0fV4S81TjX33mSxyoW
	pdx/N29EQ5krv5nHXmpFMJXYyq2XI7qyAQez82YCVtB8B++gX0P9pPrEnt1r9mEgVLxwDGFLOyc
	4lyXVOjz15QBG83XA3xpRkbmrdhX+P9Q=
X-Gm-Gg: AYBFou0xvK9JrYXSxaA5+HnP9TKGlDYM7JLN2+AgGzFIj2wuMveHBZifZKq70pnJgTV
	Nov+4xhIcaY5zlgitlHI4Cer4A4K/AxboyI6mL56Ho34mH9IpvUlZI9hc6CG7TRAev6LpnVf4nJ
	Z15cCOXLslQquG6V8AQzbxMOPLcR/YCdMhVnfDQQcwepLsdlD8LnsPlwHYT7aJVEkBrmTk0S8Tk
	mAinP4N6pQRWTWtPm1RSD2WHiYJP5nnp8f4u3KqAWM1/CHMh7yy17puN2IrEblX3pNcZv4m5GJ+
	DT6lI/2MOp2tK4VWwyUDU69kqOn1vr2p1nNOzITulYdttgQvYmDEA/SIROUmPq/nNtkRFnoh0Lp
	Q+aI1SpPTXUDzItDO9xz3iS3MVij2Zm+AfaV/YmKh9W3kIYUWLVnLqyLNJfEVccJZXtA=
X-Received: by 2002:a05:6a00:c481:b0:872:6004:f117 with SMTP id
 d2e1a72fcca58-8726004f36dmr4040074b3a.24.1789571915717; Wed, 16 Sep 2026
 08:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1cf83a4eb178197cd842e34468f4e357f42b9c28.1789393775.git.lucien.xin@gmail.com>
 <178950182306.22033.14152384539754204368@kernel.org>
In-Reply-To: <178950182306.22033.14152384539754204368@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Sep 2026 11:18:23 -0400
X-Gm-Features: AcwNN1UEOUO9io4IO0BxkvntuRVWDPeW_lFsEE-noRtB4rxUETC2sWqvf53BLHc
Message-ID: <CADvbK_ejURHE3C6BPv+b=Qnu8jPAcWDHMmqYOyEQ324_qsgknA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/15] quic: provide common utilities and
 data structures
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
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] Weak hash seeding in the new QUIC hash helpers:
>   `quic_sock_hash()` (net/quic/common.c:40-53) reduces IPv6 addresses to=
=E2=80=A6
>
> --
>
> quic: provide common utilities and data structures
>
> This patch adds net/quic/common.c and net/quic/common.h with the QUIC
> packet header types, connection ID and address helpers, the socket and
> connection ID hash tables, and the varint/transport-parameter encoding
> helpers. quic_init() now initializes and tears down the hash tables.
>
> One question below about the hash helpers.
>
> > diff --git a/net/quic/common.c b/net/quic/common.c
> > new file mode 100644
> > index 0000000000000..51d71b6733c7d
> > --- /dev/null
> > +++ b/net/quic/common.c
> > @@ -0,0 +1,565 @@
>
> [ ... ]
>
> > +u32 quic_sock_hash(struct net *net, union quic_addr *s, union quic_add=
r *d)
> > +{
> > +     u32 ports =3D ((__force u32)s->v4.sin_port) << 16 |
> > +                 (__force u32)d->v4.sin_port;
> > +     u32 saddr =3D (s->sa.sa_family =3D=3D AF_INET6) ?
> > +                 jhash(&s->v6.sin6_addr, 16, 0) :
> > +                 (__force u32)s->v4.sin_addr.s_addr;
> > +     u32 daddr =3D (d->sa.sa_family =3D=3D AF_INET6) ?
> > +                 jhash(&d->v6.sin6_addr, 16, 0) :
> > +                 (__force u32)d->v4.sin_addr.s_addr;
> > +     u32 hash =3D jhash_3words(saddr, daddr, ports, net_hash_mix(net))=
;
> > +
> > +     return hash & (quic_sock_hash_size() - 1);
> > +}
>
> [Severity: Medium]
> Should the inner IPv6 fold in quic_sock_hash() be seeded?
>
> The per-netns secret is only mixed in the outer jhash_3words() call, whil=
e
> the 128-bit address is first reduced to 32 bits with jhash(..., 0). Since
> jhash_3words(a, b, c, initval) is a pure function of its inputs, two peer
> addresses whose unseeded 32-bit fold is equal produce identical (saddr,
> daddr, ports) triples and therefore the same bucket for every value of
> net_hash_mix(net).
>
> Does that let a peer controlling an IPv6 prefix pick colliding source
> addresses offline, without knowing the secret, and collapse many
> connections into one chain of quic_hashinfo.chash (capped at 16K buckets)
> that the per-packet lookup then walks?
>
> Compare with sctp_hashfn() in net/sctp/input.c, which the commit message
> cites as the model and which passes the seed into the inner fold:
>
>         if (paddr->sa.sa_family =3D=3D AF_INET6)
>                 addr =3D jhash(&paddr->v6.sin6_addr, 16, seed);
>         else
>                 addr =3D (__force __u32)paddr->v4.sin_addr.s_addr;
>
>         return  jhash_3words(addr, ((__force __u32)paddr->v4.sin_port) <<=
 16 |
>                              (__force __u32)lport, net_hash_mix(net), see=
d);
>
> Would jhash(&s->v6.sin6_addr, 16, net_hash_mix(net)) here be equivalent i=
n
> cost?
>
> [ ... ]
>
> > +struct quic_shash_head *quic_source_conn_id_head(struct net *net, u8 *=
scid,
> > +                                              u32 len)
> > +{
> > +     u32 hash =3D jhash_1word(jhash(scid, len, 0), net_hash_mix(net));
> > +     struct quic_shash_table *ht =3D &quic_hashinfo.shash;
> > +
> > +     return &ht->hash[hash & (ht->size - 1)];
> > +}
>
> [Severity: Medium]
> Same pattern here: the connection ID bytes are folded with jhash(scid, le=
n,
> 0) before the secret is applied, so any two connection IDs colliding in
> that unseeded fold share a bucket for any secret. Would passing
> net_hash_mix(net) as the initval of the inner jhash() be preferable?
>
> Note the connection IDs inserted in this series come from
> quic_conn_id_generate() using get_random_bytes(), so the practical exposu=
re
> is smaller than for the connection socket table.
>
> > +u32 quic_addr_hash(struct net *net, union quic_addr *a)
> > +{
> > +     u32 addr =3D (a->sa.sa_family =3D=3D AF_INET6) ?
> > +                jhash(&a->v6.sin6_addr, 16, 0) :
> > +                (__force u32)a->v4.sin_addr.s_addr;
> > +
> > +     return jhash_2words(addr, (__force u32)a->v4.sin_port,
> > +                         net_hash_mix(net));
> > +}
>
> [Severity: Medium]
> And the same unseeded sin6_addr fold appears in quic_addr_hash(), so
> address-keyed hashing inherits the same property. Should all three helper=
s
> be updated together?
>
False:

Not necessary. The per-netns net_hash_mix(net) is already used as the seed
of the final jhash_3words()/jhash_2words() call.

Thanks.
