Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810386;
	b=p0tot/pQtpzkTePSce/9mTqW8jwTc1WStULHYF8Sc74sKSCR+o7rBTpG5uSvjsdm7lvj
	 hQQ4zfe0/Ir3kLw+3jRizSfsfb53Gq24X/frm8Vslrsd28IPf+ojlwCFQGG4EEaQB+tey
	 jrWizKVhNi+itvUcQhzMhNDoXgJICR1GFtW2uozV/wn5zaAKLUEDNJ7KPLOED5WEBJi/z
	 sjaQZcQDtejoEMasMwQEtJOoK6jVCqNxrUFT9XU8vKDHvCByhUy3XRki2OeI+pTHwjfwb
	 MvD4P4QBWMluI1pupAyeKxtlR5M5ezrZm/zsECPG16n5ZEkvtUUxSghIvfWH+STyvFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v9hFqWhtC5GX+p4lP05SUZf7Nx79dRHnQWtHSWGeSxQ=;
	b=VGc2LiN16nQpAw9Mv590azL/BKiTzA/wkzBRdRooq351eINabunwNVvT2mmnMGzKf8eZ
	 MW87R2a+xo5cdisc+ZliljjuJ0dUbIXTEgHcINyxCiRkoS31uFE6TGVfBSMwJO8Jw3hTw
	 NA/PgXNgVF+wXf0N9uetAu9hxABcjRvrQrZCzV/6b/ABM4qEHonrOhu6zmkRFcNbkVRmb
	 9smc3CQEganCFwOiWL2oSgnp/h1RpfCuapSrL3XLpM1BcBPKYzDbjHwFLawdDFeEUJW0Y
	 QDsQlEiaHkDvfVzwvTAM65DP4TGuItnJJ0H0iy7g4b6ocerF728ePOTD/puYzc7D4CQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ujSReGkM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B2606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79B2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ujSReGkM
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490f38e9688so147642f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:39:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793810384; cv=none;
        d=google.com; s=arc-20260327;
        b=gIlpJFZyElOXLt1x4aVcKtjyIFIWc8R7KZ/6O6JjvhyAbLPJ3NKPeed/yn3c8UIYzn
         3bCe2+uZxeWjeVGnk3TKuDVJ7PvfCggWWKuG7+06upCBmkwh9LjTXsciXOerjpFBLvU0
         GlIkZ06UUqlXouGaCXC0+k0gRWa1gokJlCD1wvTSDtcnDvaVLGYBDhWWmFxyEIVO+kfS
         y9SjOqsZfTVSj+JE812nBgv/RuffaK3LDEpVmV7qlVkUoyK3n0hKQRh63NhHBpG3U1Wh
         smtkjELV/c8+d3UkZcMkw/VS0q3R2tnEadd+pa8hz9Gj6wIZq3yF+gazzVh9/FdIvQGW
         5svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9hFqWhtC5GX+p4lP05SUZf7Nx79dRHnQWtHSWGeSxQ=;
        fh=zjBcUWYfBi6qaSihV/EWRgQ2+4c3+e3u5D97wRVhSYQ=;
        b=MeKK5urWhWIH8N7neOAJIGSaIrs270HX24LUDM5l8XYi59AAStdjJlHP9hipb4tqog
         vC8yQX+92Y5HeHfB0KwBgisx4skkB2YgOEgcl5Nrt1C3ckcojUJfKn3kxWvVH4ivP/6c
         p7dRqfBK6rp0Alq8dQaiQuQLA99BJ+L6wxjSl3q6JCIfXw9qzh2Bq4RopCaEaORKMVAf
         KFT1AiN+1iWGItdfp31FRFexdQRtr8RLNUTiVOa1TXWgoTWEu4Zvjfe+Fsdg0N+fIv1B
         gkf1mLbKZtFwMawOSDPDhgosCO+cUOHR9A1q6stNPT1CCaYnvZM3YHD+LFNVBZJEQAcX
         xBTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810384; x=1794415184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9hFqWhtC5GX+p4lP05SUZf7Nx79dRHnQWtHSWGeSxQ=;
        b=ujSReGkMHDN10N9A76S9V4++cdgbBj66eecwgWY5849ZCMaoISw55A7+h2iVC0GoZf
         aa3ZqWMNvKIkddAR3w8F0BhKJXk7GkZCj9OzDOJMVC/e1+spxp7RhVlZN1VdrOoKqEMo
         0sTBPU7wunyHq3MW0GEoYLeyy8uNqeEKvV5nI9tXcdyJQ4otvKL3AROzwneaDU3Rr4rZ
         O9XPLpuRSCwKgIj24jQXdjkUsuogGmmpTNeAoAHFogqyTe5Fy+e3QQaJCYu5p93Yr3pX
         RjH1h2xG9C0G9G8pi5c67akT9Eceu+3U43JnomWQH3we/BvDqCKVl6q/ysHePJ4iiM8f
         ZIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810384; x=1794415184;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9hFqWhtC5GX+p4lP05SUZf7Nx79dRHnQWtHSWGeSxQ=;
        b=efnfvWUlUlseko/2xBLKXATQ6hA7GVXs1xPwIo7h23SwQzjqy5dILqhB75tUel8+7m
         GRudGG2SP8jfPN1ttnghr+VFhK5/E0U3o/pCqvrqQzQHNJub+FJEONYoKARSq0zUmiIE
         Dq/oaq9Rrn5Bt/S1Gqy169HbJ2l4LxO9bSwcc/A5LpmCQxPhWmuGGXziNUSz+hfPhLpT
         A7vhADpELLX92AHAc4Wcubs23FlqMo7gji3Uhi8dSudKH5T0HRIwCPIIHis3e52fzJ8P
         /1KoKGaUhUubky1ek7fXjnK3ro3WrXbqURsRDZ8qTTb6Vtjy17P7/niVwqQtsdeWMCxk
         BuTw==
X-Forwarded-Encrypted: i=1; AKwUvBwcL4aZv9+38ed7ZiiGokx328YDd29xMINCHRtexvOsXTVaqxU+Us6yH10Z70RLiNEif1kWayI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mtMUxcTNX/UjWTk9op+wSt/nt3H0rOswLJJK7OpGYYWjdh2ir
	X4U/Fvfz2X8M6yXBtf0QppsfeleO+ywApUTPUAUBfXMgYbBtiQ/xnisfT7wKp0pME3NzbVZm0JD
	TykD93Od8zzzM61G2PQOOyKaosTt1K64=
X-Gm-Gg: AYBFou2wBhsyIM9ptIN9lKSl9aoSTV3SfSiZjECud+wVt/mIZGWT1ZPomubhr9JrDeS
	sUZgYJZoAOGYWuzUkH8JwH9ANy8aYOjFzd9ZyKcxOismcx+yrEaT9cDmIng3UbN+A4Hlii0A/6n
	/LhUtBK7TW9urkUjNc/gyvmXHYgC6VeVaC65CKywFZ1tpBrwjd1Wnjj+N4xntd+LU6Y/KVlKAUT
	T6MqCXu4lgVu3dcWhNBma6hlyYLcvNFUPARFVU3YMOQyyNAAE5pZNdBxAOHMXgciQ/Ijl2WoxDN
	MODqE/ith7PItKfR9bZfJSA9328jDezFH+t0hTFs3erHgQy7ddAkUWKVD87oNdKcAm54NNJ3ea8
	ZOzKCzCUuiG1kY+j3TmjrkpkeIOMwt7IkgrNQX1zQvBs+oqzlSkvXqZE/A43poOPXXKh/v9NMl8
	5O8BGE/6ER0saih9dxjBggwnNU0m2QfmDxQtoppK2gXGXKy+tq2zLQQQ==
X-Received: by 2002:a05:6000:4610:b0:48e:1b11:7ee6 with SMTP id
 ffacd0b85a97d-49114d42ea3mr83089f8f.2.1793810384089; Wed, 04 Nov 2026
 08:39:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
 <willemdebruijn.kernel.2de9d4f8c5034@gmail.com> <ce3e6832-ca9f-4e91-8302-b5bd7cf2f178@redhat.com>
 <willemdebruijn.kernel.1f1cead288fc2@gmail.com> <CAKgT0Ue8i8gTiJg91UYjKPvwfZ9ydf6XXDD1dmaJpjVAb7mwPg@mail.gmail.com>
In-Reply-To: <CAKgT0Ue8i8gTiJg91UYjKPvwfZ9ydf6XXDD1dmaJpjVAb7mwPg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Nov 2026 08:39:07 -0800
X-Gm-Features: AclHuK_6Btf1MVbem2YTlVMjTK1eWRQjhmWMdUbWSxj8DsaTUyRgbKNHVKKDXbI
Message-ID: <CAKgT0Ue6yT1+ON2v_xEQef+eY8tUzEaF=zWaFY1udnLUybPVsQ@mail.gmail.com>
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than fraglist
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kernel-team@meta.com, kuba@kernel.org, tactii@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:34=E2=80=AFAM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Wed, Nov 4, 2026 at 8:24=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Paolo Abeni wrote:
> > > On 11/4/26 03:51, Willem de Bruijn wrote:
> > > > Alexander Duyck wrote:
> > > >> From: Alexander Duyck <alexanderduyck@fb.com>
> > > >>
> > > >> The netif_needs_gso function lets a GSO skb reach the device unseg=
mented
> > > >> when it is CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY. The second ca=
se was
> > > >> added for FCoE, whose transmit path marked CRC offload that way at=
 the
> > > >> time. Commit 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate=
 CRC
> > > >> offload") moved FCoE back to CHECKSUM_PARTIAL but left the exempti=
on in
> > > >> place, with nothing left that needed it. Fraglist GSO, added later=
, is
> > > >> its only user today, as its segments already carry valid checksums=
.
> > > >>
> > > >> A TCP GSO skb can still arrive as CHECKSUM_UNNECESSARY without bei=
ng
> > > >> fraglist. Hardware LRO builds its aggregates that way, for example=
 mlx5
> > > >> sets SKB_GSO_TCPV4 or SKB_GSO_TCPV6 and CHECKSUM_UNNECESSARY, with=
out
> > > >> SKB_GSO_DODGY. IP forwarding and bridging turn LRO off, but a tc m=
irred
> > > >> redirect does not, so such an skb can be sent out another device. =
It
> > > >> has no csum_start and its TCP checksum field is whatever the aggre=
gate
> > > >> left there. Drivers that only set up TSO for CHECKSUM_PARTIAL, suc=
h as
> > > >> fbnic, i40e and ice, then send the whole skb as one oversized fram=
e
> > > >> with a bad checksum.
> > > >>
> > > >> Have the validate_xmit_skb function mark any CHECKSUM_UNNECESSARY =
GSO
> > > >> skb other than fraglist as CHECKSUM_NONE, which means the same on
> > > >> transmit. The netif_needs_gso function then segments it in softwar=
e,
> > > >
> > > > tcp[46]_gso_segment convert to CHECKSUM_PARTIAL and then
> > > > tcp_gso_segment will send it on to hardware if skb_gso_ok with
> > > > NETIF_F_GSO_ROBUST.
> > > >
> > > >> and the __skb_gso_segment function unshares the header before the
> > > >> protocol code rewrites the L4 checksum field. The callers of the
> > > >> netif_needs_gso function that decide on segmentation for themselve=
s,
> > > >> such as tap, are left as they are.
> > > >>
> > > >> Found by code inspection. In QEMU with an emulated fbnic, TCPv4 an=
d
> > > >> TCPv6 GSO skbs built this way each went out as a single 11 KB fram=
e
> > > >> with a bad TCP checksum. With this change they are segmented into
> > > >> MSS-sized frames with valid checksums.
> > > >>
> > > >> Fixes: 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC o=
ffload")
> > > >> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > > >
> > > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > >
> > > > With the above aside. Not important enough to respin imho.
> > > >
> > > >> ---
> > > >>   net/core/dev.c |   11 +++++++++++
> > > >>   1 file changed, 11 insertions(+)
> > > >>
> > > >> diff --git a/net/core/dev.c b/net/core/dev.c
> > > >> index f32353b0467c..28b4a652d037 100644
> > > >> --- a/net/core/dev.c
> > > >> +++ b/net/core/dev.c
> > > >> @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(st=
ruct sk_buff *skb, struct net_device
> > > >>    if (unlikely(!skb))
> > > >>            goto out_null;
> > > >>
> > > >> +  /* Only fraglist GSO, whose segments already carry valid checks=
ums,
> > > >> +   * can be handed to a device as CHECKSUM_UNNECESSARY. Any other=
 GSO
> > > >> +   * skb has no csum_start for the device to segment from. NONE m=
eans
> > > >> +   * the same on transmit, and has netif_needs_gso() segment it i=
n
> > > >> +   * software.
> > > >> +   */
> > > >> +  if (unlikely(skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
> > > >> +               skb_is_gso(skb) &&
> > > >> +               !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
> > > >> +          skb->ip_summed =3D CHECKSUM_NONE;
> > > >> +
> > > >
> > > > It's unfortunate that we need to add yet another branch in the hot =
path.
> > > > But I also do not see a good alternative.
> > > I understand fraglist GSO has some use-case, but I'm really wondering=
 if
> > > it's really worthy the pain?
> > >
> > > I'll personally think we should consider removing it entirely.
> >
> > If non-fraglist TSO packets with CHECKSUM_UNNECESSARY can be built and
> > drivers are incapable of handling them, this has to be fixed up.
> >
> > The GSO stack trick of fixing up csum_start/csum_off and then handing o=
ff
> > the TSO packet to the driver is a neat solution.
> >
> > Though that currently only works for TSO, not yet for USO.
> >
> > Apparently with a bit deeper restructuring the check can be added witho=
ut
> > additional overhead to the common hot path:
> >
> > +/* Like netif_needs_gso(), but only fraglist GSO, whose segments alrea=
dy
> > + * carry valid checksums, may reach the device as CHECKSUM_UNNECESSARY=
.
> > + * Any other GSO skb has no csum_start for the device to segment from.
> > + *
> > + * The extra test sits behind skb_is_gso() and ip_summed !=3D CHECKSUM=
_PARTIAL,
> > + * which netif_needs_gso() evaluates anyway, so non-GSO and regular
> > + * CHECKSUM_PARTIAL GSO skbs see no additional branches.
> > + */
> > +static bool validate_xmit_needs_gso(const struct sk_buff *skb,
> > +                                   netdev_features_t features)
> > +{
> > +       if (!skb_is_gso(skb))
> > +               return false;
> > +       if (!skb_gso_ok(skb, features))
> > +               return true;
> > +       if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> > +               return false;
> > +       return skb->ip_summed !=3D CHECKSUM_UNNECESSARY ||
> > +              !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST);
> > +}
> > +
> >
> > @@ -4222,10 +4243,18 @@ static struct sk_buff *validate_xmit_skb(struct=
 sk_buff *skb, struct net_device
> >         if (unlikely(!skb))
> >                 goto out_null;
> >
> > -       if (netif_needs_gso(skb, features)) {
> > +       if (validate_xmit_needs_gso(skb, features)) {
> >                 unsigned int max_segs =3D 0;
> >                 struct sk_buff *segs;
> >
> > +               /* NONE means the same as UNNECESSARY on transmit, but =
has
> > +                * __skb_gso_segment() unshare the header before the pr=
otocol
> > +                * GSO code rewrites the L4 checksum and sets CHECKSUM_=
PARTIAL.
> > +                */
> > +               if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
> > +                   !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
> > +                       skb->ip_summed =3D CHECKSUM_NONE;
> > +
> >                 if (unlikely(!gso_within_dev_limits(skb, dev)))
> >                         max_segs =3D skb_gso_output_max_segs(skb, dev);
> >
>
> The problem with that is the order of operations. The issue I am
> attempting to address is that there was an e1000e patch that was
> trying to make changes to ndo_features_check to address this. That is
> when I realized there are numerous drivers that would be encountering
> the same issue.

One alternative we could probably look at would be to modify something
like gso_features_check to strip all the GSO features except for
SKB_GSO_FRAGLIST if CHECKSUM_UNECESSARY is set. Thoughts?
