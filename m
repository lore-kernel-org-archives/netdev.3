Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810091;
	b=Q2oR3Vq0affmREHRyyJdEtzwpNY+K54QNyG4GM+WFcl8p4GyTJIx39uzR+/1ZL5xNx+0
	 YWxyXx5yG+Erzeu0d2VZqiFRbqBP0lvGmAJhDkNUmjNcLGepa1PQEVW8YUKNIzDvjtLDk
	 g0BbfIzLf6AQeZd4qTyp9ty54j8DwqAnkZHndmdG0mSknbR5HLMreE5hm56VYklBu1s3r
	 LmoSIphVHbuQpM2HDcV6zL5rxDlNIRzdp0fLuQA2qQHhBZPLJVTGrchYosQx0Hg2uocQ1
	 Dv1hrOYM2+mIwkmrTBJ2XiexoXTGkq7r/VZ2ydtPSncQNeRxPmA17ZPp8qj6MwwmfAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8ABIw2cgvzq2UxZn8AJWPzgym2snplGDQvoYb66l0+c=;
	b=3L48v8/V2VWAIEhUvWMoUjE7JKh/bOu2+MWaHw9nWl867rPm/61BrSCA5qQutR9ngLd3
	 GY5yAYr/GKCZ1r9VcYjI5xYZVqqE6Hn1hqbXOJxtK0nqqycFckpn7P9KtElmv2RG/ngWJ
	 YfccIg8DUwAAiO5sPyGeElT+/Et1rgim2+D7OOl88gzJNZ9dScFf2fYXwLMhXfvvqJXb3
	 tS88X+nwyJlnnw/DK334oxaxIC+sLaVlKC9sFVUnQtBdl15/9m/U25fALhX0Ln53U5841
	 GjJSXfqJPxJS35YDbUGUaWu1Mr+P8PkOkiRWt8BQOADKUFOqjzaAbQMs4Jxt4leJsVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZxRSszS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2F606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD2F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZxRSszS
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e0d885929so748335f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793810090; cv=none;
        d=google.com; s=arc-20260327;
        b=s9NAeBYlcdjDAEJaRi1sKGrYmgLhsKoK0xtDpgKdPd/TAsGaZSMOdEjx/HfUb+4k1P
         dpCOa3pmy8BPMTvp2lqpWUPsGjad5ly+xodoUK0Khe01CzFErz9BWndEp1fA1gKCkqhv
         SuunSCvXfPXVazqmQTzlvRQJDPKc7/H2G03R/f2h3nXPpsmia9wL+6ZGHgFiD7Sv70n0
         gJNR1mwbpzesMu2zp1sOqzVRe/fyp0gqJHvpNXNbNUUKlPL30VBtQrW5TSj93Q102e0Y
         jpHaRfLro/2OER/IdyCqGnMchSWfj4pshBG/WhTxQ+oD+3ViN+IS4RJv7Wo7udfa9MXV
         3Xdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ABIw2cgvzq2UxZn8AJWPzgym2snplGDQvoYb66l0+c=;
        fh=3izMTr7W6MCYBJpAb9rvf9FENxv6QIuEuDF4irJC7Cg=;
        b=gJfBjR7bhkyBiRVxmJLLv/SjaG2UpPwqn1aUQ7vQNRFYdS4qOpXMbsyfmbo3mVp+P3
         mJsbiR80pr3SF7+g7OLyd2rxHKc3ug9Y4RYn0v7duTPyi994MW7gRX+r6V4ozfub/QRN
         44+JmEP6qHETxh4rm22CuU3Ig32ixAYLHUCjpnryj8maqyl2v1BNU7zBKmPJGbs6PWI7
         WRp9AHsiBsp06DkKBgNOwZXuyPRFHCFYQ6u5MgingACiJ06YhLxbTzo5Z5KC2X3jqycx
         0qFnn9w5VxHjIqKUHotU/W/pAXCtiyUPy1FDUEiNVAVUKWtVIFd1y9zgl77sqKa6pYR+
         kEsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810090; x=1794414890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ABIw2cgvzq2UxZn8AJWPzgym2snplGDQvoYb66l0+c=;
        b=TZxRSszSH4fV7s1gh0QxIBe9EbL/8sQJI37yx+CnsIF5F9P2ZBc2/CkbdKCvLwJ2pg
         WfTN5XyawnlaOdkQEZb1GqD2/p8P0nZbDpXPlXn6nqLo0vmCLYGQZjJHqvtlSLMEhhKk
         Xic39lTIvdf6xj0hvTHy2XzSbSifTwkIZdEkESeSMyy6uo0XZZ4Df3xEWqLuA62SeU42
         iO+PN+rT/QiTYiVMqCuc7UzFFNoqD0N5bxFVFTGo9NFc6s74G/r62aJ/8J0HF93R+yhg
         buRJnyEef6UvbQ+UXNQt9iRP3y/TyW0OqgbG1O4Eq4kpPpKMSkDXmq511lJ9Dgne6+oB
         rxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810090; x=1794414890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ABIw2cgvzq2UxZn8AJWPzgym2snplGDQvoYb66l0+c=;
        b=XDctERtWKHIO/YsAEJb1kOYRcf3S8ko8PDoX0dLvT7aA3S6zxthZ0AUWvAQEXVlHbN
         2+o4JtwE5LHcFvWlKZvIQYDSgtRV6VQuHwRz0OyBXoIjpwLU28uR2qgCOQW+0eh0TOqN
         O1ozL9bD8xRYrqv/tYzLYjfkNig5hGFgqt742jX0G5yhtDH1KbQADzPsfOOV4VMOOkOG
         f8zmSFD9V93ekcdgTKuJdqL3p1y+dlwHZULxr/FUw0gEoPoN8GZBoWAXQ1KmEytGvFhE
         JWprGCZoH5OGVNCtbF6BGrrTSS5rVBEczCvSrssg1mCHmVnkn+a7iq1UQIcy9H6d2jR2
         SQSw==
X-Forwarded-Encrypted: i=1; AKwUvBw81wevxMZ0FZ0UAFSBrRKaTx24yhKtEwp0Cl2/g1YbFuKX9pBDbXBQyjYtV9wfcynjFBvknaM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6nvxL7+IFAQQOk8cV9kNGeEFVYlyuiqYc+A5+1kbaffi7Kc7R
	oPjbkL6hc8ThpbZIduHyLm+MOOHSqbqAypBM2wqLYWFvPfhppk1olSLqK04PkGw43b417AtyMRi
	VjOq63MbB0EFEOLwwefwn4JGYgVhSX5E=
X-Gm-Gg: AYBFou17en3rMMcr321nK5CpmZQfaU4gh/VBwDbPRy/qNbCXimhGQWWxJgG8Sw9u7Lh
	IrorGjuBCkoYLcvBDNa2seglj2lajuifDe+J7yrA7EFHSw82U42T1ds45pgOvzzbXlhkOObJt5q
	erI84k9AEqkvVGwmNMPRousAKcW3INdyz7Tf7hWPTkyT/m2d59B8D7rdzi+p+hW2ptO5bEw1rkQ
	W3QgpeHOIwEMNsBH3eoCGfWD9v7pHOFQdSKwSjWDMt80r9LaIxeN/nFEOERUUD+rKY3Cks0K1oi
	VkbIXQuoTAmjldZlrHMyS7qstdALsN4RnhDzqDjmmA30GKdNkLK6qu0ntlQwG4fycOkGaBErx5f
	7FEIpnoCxGyxptiPWH7+1+iO/C5dP/LID9suHO6t8T29gfbRDr9uiqI0KpD5PtqLO4kEr1haaBZ
	yZdrrM9rNenNsglHz/nO6ZRcE1yLSArlwdizqKEuYbzelEaUMsAfuIAiY4NQunzWAJOt6p9X6B4
	wo=
X-Received: by 2002:a05:6000:200b:b0:48f:fcac:a5e2 with SMTP id
 ffacd0b85a97d-48ffcaca675mr4855888f8f.38.1793810089351; Wed, 04 Nov 2026
 08:34:49 -0800 (PST)
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
 <willemdebruijn.kernel.1f1cead288fc2@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1f1cead288fc2@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Nov 2026 08:34:12 -0800
X-Gm-Features: AclHuK8gPejQ1DtXxr7Jv6CHK5UsmsQCGA5EEugdxZbubKafR1Xn9ua1r768NsI
Message-ID: <CAKgT0Ue8i8gTiJg91UYjKPvwfZ9ydf6XXDD1dmaJpjVAb7mwPg@mail.gmail.com>
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than fraglist
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kernel-team@meta.com, kuba@kernel.org, tactii@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:24=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Paolo Abeni wrote:
> > On 11/4/26 03:51, Willem de Bruijn wrote:
> > > Alexander Duyck wrote:
> > >> From: Alexander Duyck <alexanderduyck@fb.com>
> > >>
> > >> The netif_needs_gso function lets a GSO skb reach the device unsegme=
nted
> > >> when it is CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY. The second case=
 was
> > >> added for FCoE, whose transmit path marked CRC offload that way at t=
he
> > >> time. Commit 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate C=
RC
> > >> offload") moved FCoE back to CHECKSUM_PARTIAL but left the exemption=
 in
> > >> place, with nothing left that needed it. Fraglist GSO, added later, =
is
> > >> its only user today, as its segments already carry valid checksums.
> > >>
> > >> A TCP GSO skb can still arrive as CHECKSUM_UNNECESSARY without being
> > >> fraglist. Hardware LRO builds its aggregates that way, for example m=
lx5
> > >> sets SKB_GSO_TCPV4 or SKB_GSO_TCPV6 and CHECKSUM_UNNECESSARY, withou=
t
> > >> SKB_GSO_DODGY. IP forwarding and bridging turn LRO off, but a tc mir=
red
> > >> redirect does not, so such an skb can be sent out another device. It
> > >> has no csum_start and its TCP checksum field is whatever the aggrega=
te
> > >> left there. Drivers that only set up TSO for CHECKSUM_PARTIAL, such =
as
> > >> fbnic, i40e and ice, then send the whole skb as one oversized frame
> > >> with a bad checksum.
> > >>
> > >> Have the validate_xmit_skb function mark any CHECKSUM_UNNECESSARY GS=
O
> > >> skb other than fraglist as CHECKSUM_NONE, which means the same on
> > >> transmit. The netif_needs_gso function then segments it in software,
> > >
> > > tcp[46]_gso_segment convert to CHECKSUM_PARTIAL and then
> > > tcp_gso_segment will send it on to hardware if skb_gso_ok with
> > > NETIF_F_GSO_ROBUST.
> > >
> > >> and the __skb_gso_segment function unshares the header before the
> > >> protocol code rewrites the L4 checksum field. The callers of the
> > >> netif_needs_gso function that decide on segmentation for themselves,
> > >> such as tap, are left as they are.
> > >>
> > >> Found by code inspection. In QEMU with an emulated fbnic, TCPv4 and
> > >> TCPv6 GSO skbs built this way each went out as a single 11 KB frame
> > >> with a bad TCP checksum. With this change they are segmented into
> > >> MSS-sized frames with valid checksums.
> > >>
> > >> Fixes: 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC off=
load")
> > >> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > >
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > >
> > > With the above aside. Not important enough to respin imho.
> > >
> > >> ---
> > >>   net/core/dev.c |   11 +++++++++++
> > >>   1 file changed, 11 insertions(+)
> > >>
> > >> diff --git a/net/core/dev.c b/net/core/dev.c
> > >> index f32353b0467c..28b4a652d037 100644
> > >> --- a/net/core/dev.c
> > >> +++ b/net/core/dev.c
> > >> @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(stru=
ct sk_buff *skb, struct net_device
> > >>    if (unlikely(!skb))
> > >>            goto out_null;
> > >>
> > >> +  /* Only fraglist GSO, whose segments already carry valid checksum=
s,
> > >> +   * can be handed to a device as CHECKSUM_UNNECESSARY. Any other G=
SO
> > >> +   * skb has no csum_start for the device to segment from. NONE mea=
ns
> > >> +   * the same on transmit, and has netif_needs_gso() segment it in
> > >> +   * software.
> > >> +   */
> > >> +  if (unlikely(skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
> > >> +               skb_is_gso(skb) &&
> > >> +               !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
> > >> +          skb->ip_summed =3D CHECKSUM_NONE;
> > >> +
> > >
> > > It's unfortunate that we need to add yet another branch in the hot pa=
th.
> > > But I also do not see a good alternative.
> > I understand fraglist GSO has some use-case, but I'm really wondering i=
f
> > it's really worthy the pain?
> >
> > I'll personally think we should consider removing it entirely.
>
> If non-fraglist TSO packets with CHECKSUM_UNNECESSARY can be built and
> drivers are incapable of handling them, this has to be fixed up.
>
> The GSO stack trick of fixing up csum_start/csum_off and then handing off
> the TSO packet to the driver is a neat solution.
>
> Though that currently only works for TSO, not yet for USO.
>
> Apparently with a bit deeper restructuring the check can be added without
> additional overhead to the common hot path:
>
> +/* Like netif_needs_gso(), but only fraglist GSO, whose segments already
> + * carry valid checksums, may reach the device as CHECKSUM_UNNECESSARY.
> + * Any other GSO skb has no csum_start for the device to segment from.
> + *
> + * The extra test sits behind skb_is_gso() and ip_summed !=3D CHECKSUM_P=
ARTIAL,
> + * which netif_needs_gso() evaluates anyway, so non-GSO and regular
> + * CHECKSUM_PARTIAL GSO skbs see no additional branches.
> + */
> +static bool validate_xmit_needs_gso(const struct sk_buff *skb,
> +                                   netdev_features_t features)
> +{
> +       if (!skb_is_gso(skb))
> +               return false;
> +       if (!skb_gso_ok(skb, features))
> +               return true;
> +       if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> +               return false;
> +       return skb->ip_summed !=3D CHECKSUM_UNNECESSARY ||
> +              !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST);
> +}
> +
>
> @@ -4222,10 +4243,18 @@ static struct sk_buff *validate_xmit_skb(struct s=
k_buff *skb, struct net_device
>         if (unlikely(!skb))
>                 goto out_null;
>
> -       if (netif_needs_gso(skb, features)) {
> +       if (validate_xmit_needs_gso(skb, features)) {
>                 unsigned int max_segs =3D 0;
>                 struct sk_buff *segs;
>
> +               /* NONE means the same as UNNECESSARY on transmit, but ha=
s
> +                * __skb_gso_segment() unshare the header before the prot=
ocol
> +                * GSO code rewrites the L4 checksum and sets CHECKSUM_PA=
RTIAL.
> +                */
> +               if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
> +                   !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
> +                       skb->ip_summed =3D CHECKSUM_NONE;
> +
>                 if (unlikely(!gso_within_dev_limits(skb, dev)))
>                         max_segs =3D skb_gso_output_max_segs(skb, dev);
>

The problem with that is the order of operations. The issue I am
attempting to address is that there was an e1000e patch that was
trying to make changes to ndo_features_check to address this. That is
when I realized there are numerous drivers that would be encountering
the same issue.
