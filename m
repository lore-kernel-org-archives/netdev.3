Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704535292A
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508470; cv=pass; b=WJf9G+v1KN1zJGivj6j4VlsUQlQ/y3Q002k5S17kJSr4V3/n8K4o2SyyhWyHX2r39pLYUTyQ5V2RbJ0u3dwtZclIQOWbyUtNCfGWG61t4LgC1CefAPvVjqeTsw2/SLwPiY2SCvSdsDE5dIF0bEu390CGVQ9pqGEeiy6nZkgw/B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508470; c=relaxed/simple;
	bh=TQRGBrrDXcmDIzvEBw2UOVN7uPX1DaJFuWM/UhCsOCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmmdQoR30QtvZ5qGw2aAFvEczr2pKeYsHEkjJ+brcNCm7U9vczQMn8a4WjQ79IfUDZxzN7Sb8Ay2JOasYSWbi8N1Nuka+vDLaMAaXqWmfjEBbswQKAuAwUz6IrHuPs5opbRy0eDGMGW/J6ESztR3l/IkTuC/Kas6Iz6C2wxWf5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6epJbrz; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6epJbrz"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5309ce58730so2328261cf.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789508468; cv=none;
        d=google.com; s=arc-20260327;
        b=SrRn8qJKNOjVC6CscZKzWdAo6Hl91bqdYlwy3s9sYXOmWPsICFaMcIGqUjK8KSjX2x
         WiRq1SqJ4SIDdep7nfyPj2AIhaEU44pV0krIMQLJM4niVY8wHE+dYyBJ2VOuYJK6258d
         q4bqVH/mNNZh3pZBB27gbRtyp8BGPTb6a+j6plzAd0fbl1aFq/67Wg73PwXxLB6UKdXo
         m2h0a7L6lLdlTCe8NFK1dL1WBwg8EtlIJhOX2zOVM55cUvAWoWsNJLxg6/UFK1+ZbGmA
         BZYzZt2CRFYroLTgzjAQEu7ce+PiWiBPU8PdoezJUo7nXSyDcRhJWAmTeitsw7u6UTtW
         rW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mYh/6i1QA2nX7JSpaFmJOLlBXi3crvLXfZ91g38PHCk=;
        fh=kQW6sjO6b2wkCW968v+on5OX4Z2BjLEPQ6H8gLk1gCw=;
        b=GYwXqlKiOG+2llYFktw1kCoV7cWVyfviFJxUAAw6rURSjqOEakJG3KzhnWmCEoWYH9
         pxaC3oJ5UC9hQr2NRhvUFDOHuugy22mMqFy8PNRBze/yq8OoXmn2s4XkyR33sIQJHj3J
         GIJ/td47vIhzSdsh8CVd2pOdoCDX0atoDvShaOFyFbKlbWENY+1YLqdh/227itNVTEld
         FoFIhqhipvHVQzO5Cu6CDphG98UapuZoWCoDpWES1B9Y5FlJYWG2C6BjLakxnFmP2BvI
         PxOzUtfsBKgbBBpfLTGcFyIigOJ0cv/dtBIllu2HWSbSd2lkhAxCoR1jHuL5Ki7BFKr9
         0wZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789508468; x=1790113268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYh/6i1QA2nX7JSpaFmJOLlBXi3crvLXfZ91g38PHCk=;
        b=q6epJbrzKAr9h5U3XYJ43GUquH2ItqBdiYblt/gtLwzD2etHxH3LzdKAGPJA69ST8j
         4Undrbb2kjxSpjqX6Eq+1Azi6TBhBovshA8koJg4FXSfHjxtbSDx5prGVq7yVINsFJN1
         q6AKp7QrAkVODobKAKzcLR9QsrT4xbPDKXrO9/SUwu6MO9AA9QGHJz6lOH8OmJRw4GNb
         5uFQWBMei9DMuL13wRrTmOFGbdidt20t9dMeV1zy4QvaMtCZ2grkzjjzYfAbSAf5diZP
         bTyRhiaoVqy4eiZIJv/MBnBys4hM5nNPDG1dxkg/HHSl5VY4++w3pYJQOQUh6BEOiCSg
         tTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508468; x=1790113268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYh/6i1QA2nX7JSpaFmJOLlBXi3crvLXfZ91g38PHCk=;
        b=w2UakN7D8WA8/ntw9A/7VW6zL8L0E3ENslhSGuCPqQQAbioTQo03OqeEQGTWuHWCx+
         t85DviSGs8inqG6CZQ9eIgVWagv+cZZYsRyOe+Ng+r4+pM3rlXwUhZFC2x2XgFqtlpzd
         b9BaM6CIwSaaJUD5hO46ek3ycCpdlIbn8AsK0E8KEvqqlrEWB0BzMksX1h636hAcOiWR
         XBH4g1VhdAc+6nOtS1/h+SdUcsNffuI9TSYGqVa/vtdDDlzrOJcVncX0yejB39Y69rVB
         Pk+9Mox93k1p89E8XcuzWlBG1FPZx05PMGZl0O8QA//pNLOgWGGAPsCggVVffi7HtD3L
         CkCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWkJWl9GpvSb63nhTqzGNcZfWVxdbqW9oPA3Gpux/85wyCrYm1hjO1DB0PrfEIYecyYahotw8=@vger.kernel.org
X-Gm-Message-State: AFuF++mMznE//gSv0M/z3ejLVLhEUeVt4CmML/Uoo3ZDtKeeJj6ROCQP
	nAwcYTSFylAMAnqmNtx92MLhTM4tIUWHkYrRqOulUrDltmjwKYanpvV3u0f9pMW1k8l7Mektrh7
	PCT1E88igOG8moOb0yCAEJNeq/DA4K/SFDEAh3n/t1kkEWkuWKzEZylbrtpJtUg==
X-Gm-Gg: AYBFou28xKM647inoyoGiOmyiEgbJiWRfdikdbMN8HAb3AppdMhk4tZFyGexuoBf8bM
	PZpTIiK2TvOJQnKPjwa2HzRQNNeMhvfRO7Hu/7jlZy6TtUzrS2+oQpxstgGTgsROCM2PLInEvQU
	SpLW9ey3oYNshTvgOzU4MjgjblXaQdBtCYnOnZIxz0axDG9pwPFE8wwpRgMCVKHyvYYx1NJ1Hd7
	/l/l1QRaealFsVt5XyUP+sUOX52yRCpGbrv1TOkP+bmK+Aiu7PkVbwDYSg2D7N8JueLZ3QrjUFT
	TxJGwRo4UwpX4B8LJkDC+KFb9oQMVNe0s0NpaClydRxTOO+6rVJEBsjIOrBSRp7entFz1bXRh1y
	OD+OYepzHZohfEGKG0PP0x1blJOoI419tYbqdImaif+h0DBVlLVQlgeEtknuWLOS2i8jD9/EUjR
	fbv90xNadoZclMoOKpIbCgZYUnxOf4JNw=
X-Received: by 2002:a05:622a:4811:b0:530:f75a:5ca1 with SMTP id
 d75a77b69052e-5327f26256emr1796801cf.25.1789508467689; Tue, 15 Sep 2026
 14:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <114FAFBD-F7BC-46AE-AF9F-0D15124F130E@doyensec.com> <de0fd2e5-8509-406c-9f92-cb644c42229d@ovn.org>
In-Reply-To: <de0fd2e5-8509-406c-9f92-cb644c42229d@ovn.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 14:40:56 -0700
X-Gm-Features: AcwNN1UDwoPPJIYobKlWbkakSBHVH6lAHt1e7TNhgMdoK5J8Fcfu6-zh-uufg2c
Message-ID: <CANn89iJbs9n=kmt1putx=izvr3w17U4g6RDoDzdh4NWz+7uRaw@mail.gmail.com>
Subject: Re: [PATCH net] openvswitch: reject a negative transport length in
 the IPv6 L4 checksum update
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, dev@openvswitch.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:13=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 9/15/26 9:55 PM, Norbert Szetei wrote:
> > update_ipv6_checksum() computes
> >
> >       int transport_len =3D skb->len - skb_transport_offset(skb);
> >
> > and gates the L4 access on
> >
> >       if (likely(transport_len >=3D sizeof(struct tcphdr)))
> >
> > sizeof yields size_t, so transport_len is converted to unsigned and eve=
ry
> > negative value passes the guard.  inet_proto_csum_replace16() then read=
s
> > the transport checksum field out of bounds, and writes the updated valu=
e
> > back to the same address:
> >
> >   BUG: KASAN: slab-use-after-free in inet_proto_csum_replace16+0x445/0x=
470
> >   Read of size 2 at addr ffff888131a4cb06 by task ovs_ipv6_oob/696
> >   CPU: 3 UID: 1000 PID: 696 Comm: ovs_ipv6_oob Tainted: G N 7.3.0-rc2+ =
#338
> >   Call Trace:
> >    inet_proto_csum_replace16+0x445/0x470
> >    set_ipv6_addr+0x3dd/0x460
> >    do_execute_actions+0x6a3d/0x7c40
> >    ovs_execute_actions+0xfd/0x480
> >    ovs_packet_cmd_execute+0xc38/0xf20
> >    genl_rcv_msg+0x59e/0x870
> >    netlink_rcv_skb+0x18b/0x450
> >    genl_rcv+0x2d/0x40
> >    netlink_unicast+0x6bc/0xa20
> >
> >   The buggy address belongs to the object at ffff888131a4c980
> >    which belongs to the cache skbuff_small_head of size 704
> >   The buggy address is located 390 bytes inside of
> >    freed 704-byte region [ffff888131a4c980, ffff888131a4cc40)
> >
> > ipv6_find_hdr() walks the extension header chain, skipping each header
> > by the length that header itself declares, and ipv6_optlen() returns up
> > to 2048.  The last skip is never checked against skb->len, and
> > parse_ipv6hdr() installs the result as the transport header.
>
> Hi, Norbert.
>
> This looks like something that needs to be fixed in the ipv6_find_hdr().
> IMO, this function should not return an offset that doesn't exist in the
> packet, i.e. we should not be able to find what's not in there.
>
> CC: David and Ido.
>
> In general, we should be able to trust the skb_transport_offset(),
> otherwise there could be other issues all over the place, not only in
> openvswitch.

Totally agree.
We keep receiving defensive code instead of finding and fixing the
root causes :/

Fix ipv6_find_hdr() in net/ipv6/exthdrs_core.c

if (skb->len - start < hdrlen)
    return -EBADMSG;
