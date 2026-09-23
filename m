Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323B5678DB
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191434; cv=pass; b=FWvqWheXZPYXRQWAtmA1VOpbbmFWaGj5ZAMZR4wYEMeJSSrYx4hjR1e5sfnfZECVtNysgpgJZS4vyUfWsGyvbZUy8qddfgUuEM/CwAKc9Ti9sZASu0VBTEw9GL4kCP1c5rAtGVNwq7SCY4wgi+N66NQYtUSwh1kGQqYnO5A/61o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191434; c=relaxed/simple;
	bh=8Ytyzo3Cstyv41FSR2oY9DUCX3JVIiDtDCUz+J7mE9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuUwfL/7TeUFWh6ZQCqRPHL3Z2d4zSVkRAmFNEYYnPBSo9YCKGbI77+XHJ0XUUONoPoQlugDboyRS9LRWl/66bjZ+s2RQAsJoBb4g7v9BmVzrLVPmQatHYOPzaTisjeZBwPBRvcETRAnmOKSIAu9Mn12vj7YNA6VxIK2ub5Se0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKuFa8oL; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKuFa8oL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2db33db4de9so19365ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790191432; cv=none;
        d=google.com; s=arc-20260327;
        b=cw8KyF5NjAbB6wvw9k+aiioikmNkIQPFZK7rPQYwSyfn5MkK7RzGx7tvsV02QYl2Jo
         qeqYtLwhj//sGdZooJBI80GYLPytAUzmU+2VrNtJIZ/+gx4DLSmYwXAIUrZx9uxplDxI
         D9exNlgJ6WvrCJFT1wKMGUO+85bqk4EQVYE9cRbi8ztEXsS4n0i4XYyNLYWNmIHVzq9U
         4ZM4zqPgUWuKz3kQz1KrZxdmZwZWoSA+vCfXyYexcN+FSf3AUp4xmBY7JN0zOU6XQJTW
         bARbBTMnXTZqhCJUi73vkie05osot2vWg0eOEpVioeqyPku0XL0OPHwDxsozPebx0fzH
         I89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjbpeTzL0D+bm9/wq6fbdsu4mBQdwvLGFrJBuUnOg/Q=;
        fh=8ye4B41ypQNlPIOTJn4lemsLBNTaRlWzWvccOwpDPRk=;
        b=AKyaognk8vHq/dK3UrCCbGXviCDqvSg6HgYG18aqHMjGuiXVSQpqljSGOSegdM2xcC
         zE+YNsefXJTohZ5DVljqpBnVLI75M58drBvyL7K310TNeYsZ57anvLQcBDU7sGuq6M8D
         68twY9KodS9pm2pODR9qvTcmFsqOeLGY26YLMwV9+S/bmJjx9fZ4+kYgVJtk1gFW5Fi3
         xPtFQ3in6ITnZWAiCM3w/LufHY0koYbDr3E8olhJXAlZ1brwNCC9LsuffUvITzCpFV3M
         GX33gjkZZCUY1J3cbh4X6SBAgrn9kpIgXblER42h/sc7ilpUgv7ZYsCou+1xYKEM02Q8
         Ev3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790191432; x=1790796232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cjbpeTzL0D+bm9/wq6fbdsu4mBQdwvLGFrJBuUnOg/Q=;
        b=JKuFa8oLhEFWv1Ab5Y0Mbcqn1/Z2esfjzkY6tokywS4Pa6hSe1Km+YhLC8PaOX6cv/
         om52sSMI56T9TmfnINl0jCsTo6iZrUA0gcDZ3PbW2jpW0Lb5e9BFcqBRzTnx1uZTqmNI
         qTqNxaMMBzhwJZxP5S2CVVuv+msG2N/OkzaYPGz3I5vXqoz3H/2O61QFuByViq+YsUGd
         +3/3zKQ4m5kicRSZbpQHWSwQMHNnX2AEeC6JvTjT+xP6mfdJpKyqmUm6RdPxMigHo+HC
         dV29Proeld6TtlIU45QaZMH5NWWQEeyhO2t0UgeG5i+BKujd5d651iGDWbw7kJ+Gi/bK
         Qqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191432; x=1790796232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjbpeTzL0D+bm9/wq6fbdsu4mBQdwvLGFrJBuUnOg/Q=;
        b=Bw/tBuK7ucU4xIqtw/QvYdvVbsFNGyPPaInHf3CXm1UxQQVPft8lGJ5AbG8LbfizeT
         HSbQOaIk2CEVWH4NXwNQJlOQbKgemgA60Bs9D6eWvQ0HspgGwHp155EBGptDVn0ReRXd
         tsRcYWKKPd414+Ju+TDaYkaWzNduPZeokh7tKdrES4prffXhB9QP/4kCRSQ4oHcsddgI
         zEjnkE39K5E6G4V+vEtpPbMA+xXjm5uFSJU04/bQa/UHHZap7E8gvlAZkHIP4B2ybAC4
         rlCucWMiOAKUAXatjmVgZHuThnkRZe0S3A/OjrREkL4rAW0D6OMlHh6ayRW7864CFR5J
         RuVg==
X-Forwarded-Encrypted: i=1; AKwUvByKRwOAyYWHV+KBoTI5lPjzeoQIx+4SIcT0k9acxHlfL6JCtV/DM7871/avXm00LrvZ1XUmHM4=@vger.kernel.org
X-Gm-Message-State: AFuF++nYj6N85av9DtEM7mhB8It7PgGRtorGO5iNlt09GuFPpOY85mAW
	zXHkgQXw4ag1++A+VUOyFKYoZUzrAUDY6uGPxs5hdvm6s2nVycpQwyAKweItdKeHgP4dKkaaC89
	TP1jEeJ08iiVTSynBU5STw1IzSBy25X0+3OMKpR1ch9PEso50YJDaHuaXSaA=
X-Gm-Gg: AYBFou2Vunu78RK9ik1kMWhYK7HsMBoKLluXRZFKpixRFezn8SWorHWpY/tp1vBtclY
	pVK/PDdo/Gte5cydqzELbt3RJ9ZaLUT8FY++YRcWKqmCGhdmgYZINS7l68+GULppPK7uZuetakf
	pKuvXpu1XRIffVFoHWIilkcntEDzgjMd6va1d0i8eMqCd6aECkXW49U+NJTyYM55luL93Yostgp
	Ri89w569d88UtH3bkLcimQExKkdogqKU6TXTGu7wGoZ3dwk5DT38NV4jGDdijHir7IkP2NicVr/
	JJdzO4T+EKKVplr3BREXMvReOWcNMnoA/4f50bIc6MZ/w1dYW20DuUJUHPyYLzHMjvvtuTCVPgm
	MenzbVQ4KFdYVFRDO8rMNrYdAOKiO+ErbAr/olfZEzWz1rUgelfaxOsd/
X-Received: by 2002:a17:903:46cd:b0:2dd:b837:48b8 with SMTP id
 d9443c01a7336-2df7b50e8b2mr1431535ad.14.1790191431686; Wed, 23 Sep 2026
 12:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923141047.14047-1-hannu@varjosoft.com>
In-Reply-To: <20260923141047.14047-1-hannu@varjosoft.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 23 Sep 2026 12:23:40 -0700
X-Gm-Features: AcwNN1Xxcv_5F3z2tc9CpAyeFwGvleoEfPBFILiv2eW7DdcnaC8Sg9h3_Ps108E
Message-ID: <CAEAWyHfaV4tYSWTjfCJZ0bAHnk5XcEWQkycfHP-0toqHZ0C6Mw@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol
 gso_type bits
To: Hannu Varjoranta <hannu@varjosoft.com>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ankit Garg <nktgrg@google.com>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:11=E2=80=AFAM Hannu Varjoranta <hannu@varjosoft.c=
om> wrote:
>
> Since commit 014c607f86ab ("gve: add support for UDP GSO for DQO
> format"), gve_prep_tso() matches shinfo->gso_type exactly. gso_type is
> a bitmask, though: SKB_GSO_DODGY is set on every GSO packet that comes
> from tun/tap, packet sockets or other untrusted sources, and
> SKB_GSO_TCP_ECN and SKB_GSO_TCP_FIXEDID can be set as well. Such packets
> hit the default case, gve_tx_add_skb_dqo() fails and gve_try_tx_skb()
> drops them, counting them in tx_dropped.
>
> These packets do reach the driver: tcp_gso_segment() passes DODGY skbs
> through unsegmented to devices that support TSO, after recomputing
> gso_segs, so drivers must tolerate the bit.
>
> This breaks virtual machines behind a tap on GCE instances using the DQO
> queue formats. Every TSO packet forwarded from a guest (gso_type
> SKB_GSO_TCPV4 | SKB_GSO_DODGY) is dropped, and guest uploads slow to a
> crawl of retransmissions or stall entirely, while the host's own TSO
> traffic (gso_type SKB_GSO_TCPV4) is unaffected. On an n4 instance
> (DQO-QPL) with a Cloud Hypervisor guest, a 64 MB upload from the guest
> went from a 60 s timeout at ~0.9 MB/s to 0.19 s with this change, with
> tx_dropped no longer increasing.
>
> Restore the bitmask test that commit 1b9f75634441 ("gve: ignore
> nonrelevant GSO type bits when processing TSO headers") introduced for
> the same problem, keeping the UDP GSO support.
>
> Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
> Signed-off-by: Hannu Varjoranta <hannu@varjosoft.com>

Thanks for the fix,
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> index 80ab0a449ff5..675c7644817a 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -596,21 +596,20 @@ static int gve_prep_tso(struct sk_buff *skb)
>         l4_start =3D skb_transport_offset(skb);
>         paylen =3D skb->len - l4_start;
>
> -       switch (shinfo->gso_type) {
> -       case SKB_GSO_TCPV4:
> -       case SKB_GSO_TCPV6:
> +       /* gso_type is a bitmask: SKB_GSO_DODGY, SKB_GSO_TCP_ECN and
> +        * SKB_GSO_TCP_FIXEDID may be set alongside the protocol bit.
> +        */
> +       if (shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
>                 tcp =3D tcp_hdr(skb);
>                 csum_replace_by_diff(&tcp->check,
>                                      (__force __wsum)htonl(paylen));
>                 header_len =3D skb_tcp_all_headers(skb);
> -               break;
> -       case SKB_GSO_UDP_L4:
> +       } else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
>                 udp =3D udp_hdr(skb);
>                 csum_replace_by_diff(&udp->check,
>                                      (__force __wsum)htonl(paylen));
>                 header_len =3D sizeof(struct udphdr) + l4_start;
> -               break;
> -       default:
> +       } else {
>                 return -EINVAL;
>         }
>
> --
> 2.55.0
>
