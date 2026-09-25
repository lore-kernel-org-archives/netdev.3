Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9832ED3A
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303315; cv=pass; b=c0NcI3i+FQZG2O+TQXDTdwJDDvWatv0Jh22SEpIXXa+FIyNdT7Iqgq0s9eb9NZj/4GIIBpUvWhPvlOMbAPmL4L6smE7KPwPiUcVLrp4ylaqJHVqVgluWpyRqyNZY7Uddw7o/ZDDbNCO1T0r2T/8QIpONu6fKE2Ia9579dnaaEho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303315; c=relaxed/simple;
	bh=0YgfRC7rswTCTnTN06Sr5EGaKN5yufG5O36COz/Rv6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX1DIcQZtZzDXBlyVtp771LQUIAK4bN3Wcwz8tGC59/Nlg7OsnF8vnKVkcB0Z8jt3DkBG3Z+H4Anl3COqfFErbjcW1hcobd8PxlI2qlmKIBNBIWF+UntkBdArerbD0m2RypzUtZuvFd8kaYzNijf43mRp6VYYk6HJh3i3HfltiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZVHwuXB; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZVHwuXB"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76bcb1fso5561171cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790303313; cv=none;
        d=google.com; s=arc-20260327;
        b=BBzNO1XN++5wJS1kVc4qpjGvq55MrCFOT25b6rGGDPpRb/+AXeE7QglQRrWTFLcVU7
         ko8hZtKOGgWeTs2+buwzih4lGcmZ/gn/PXo3alcZt/0SYsj5K31RJhDsGBJKZMO95X4e
         psAheGtJfhFC2BljbkR1trkUvB7OUyQgYF0ZuOzjmNNtZLFvGYhgXcmUFKKiSdXvavoK
         loDdOubhmBve0pUn0sjMWbcCVWNm/xejIuJ0MiSk7F6jXFz4+ZadPHBIfm/kOs6ApI3U
         b2SSf5Ja9o9AqMybP160BIYlB83CXTvkvcZ1CgRsEMZ1pQZvBhedVLlzG2kRq4ZlIl0c
         KBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QTWZarAuaY8j3jm/aqxMsHsPLlviheyrfUoh6zUcHbI=;
        fh=HsfM55VRH75uDRFbylDWlstAgEg4U5hqlcFLZ4AJApE=;
        b=jPrQtdFEpvMaSFvRBWNxZklBPhhdT+3P6wcVpP8xPj/XsErSAT2AQRxQmO1f0fiHs5
         MrcOzuO9lrxTyif8IAsp6Newm98u6VSis1zKG2sa7y4EvIQPs/hT6h0MC+DJRwSITSbQ
         BMd6hcQvD/toPiPcBqjdGGzM20zfHSvg7y+2roxo2ZmTFnFrVoWBxW5FDG+Se6YcDOCT
         JIqz6Yf4KjkfdEN4gxtUkFiM/lmX/OC+iM8iaSu3/nK59RmHXinPFjSw0eXFk1H4ohf2
         mPNb8tcLo/CJleNmHtb8ltvIhuZHwCf8E3Ef79XaF2u8KVVFOHVi2DJiqtaWT/VCpn7V
         +quA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790303313; x=1790908113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QTWZarAuaY8j3jm/aqxMsHsPLlviheyrfUoh6zUcHbI=;
        b=ZZVHwuXBLuQvyYJvnbsusL/oi48Aw+fVVh9vXH1NeTPyl4Fg8pJhMmGqPc6xg9IhAw
         aqcZHzfK9MOaUzRS9g7OKY+hYLIviJ/T6Ws7dtvzXU9A1xQhB8LjfNHM+GUrv8n5F7LX
         5MHp1KwMwpQ53HLN4frnBx5y/LzHe4qffy/WPzh2luXUURxxe0r3d9RifkDPV+cJIbQC
         wTKK0o5lRHguxUdPgFBDArS5A3jNwiIM6XDWdKeGajgHa2va8fv0LNptv+laVXq22ArF
         z8HM2nEdlPVd+ewhPSxi7DSnWZnDLxMvEwa3xYF6LUdqeSqAdPRvMwL/E775w+sKG9cc
         S8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790303313; x=1790908113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTWZarAuaY8j3jm/aqxMsHsPLlviheyrfUoh6zUcHbI=;
        b=QTvkDb2t9VYvSER+4enufXepdprpudFlcpN7Ay08/7GGC7iYhDnEXy20EiOQG48HNI
         sqPioEdMihyB1u/jEuQzJKnEwnYlpLQDMle+hWDF/BtbnWQErA3wPx2/8nJqe+FzO6nf
         L6nig8n7Qdtk3uQbpmH3HzUO0PfTlkn4C1JjUIxfNcIRMUfbGF30s+eKIPtzglyCpp4T
         vN2BwAOyAVOdX288gcEhTOGGDdYEEkuiiLE1y6YhlEtAPNZOFJMkmBHhkepSYsjyD3M+
         2DnMHp3Mi2H/7Zw2xorMLn39tnwJB/ut0Nm8U8bLuEh8i+Wf0rBjFvJo25azRlTDcR3i
         YxJA==
X-Forwarded-Encrypted: i=1; AKwUvBytMQoBIDR+sxWEtgP2xgJ6DF1xayG9BFJieJSwCvnBSgBvXuBPp6oD58kud6QRTvZLCx0zVpc=@vger.kernel.org
X-Gm-Message-State: AFuF++l0D9ij89OGNMdoBG0vxFbBCZgSYQnyktUg9y4d1wJkio4/rTYX
	43qIRBehW8h5IcWbpR1cQgzNDU1cl4KTbp52p3AkoKZXnUcIwD2kDq46UQqtzlUCYHBFaDo2x6D
	gn2o+PX1ea2Ebc0S1zhcAR7GSla+JsohWs44Q4ggW
X-Gm-Gg: AYBFou1Gwp69IAo9IlATeVrQ5FvP5mSJwRMziT/OwI1rwkXhzdaj5TMi00z890kiL7J
	LIrSZ7JhkS7EWDCTg70cqjR5RuRd3IZern7s4lVs3VAt5WILlwkQCsUiMBmYliJTVT8ToYow3jt
	e2d8lx1P1SvQy0PVfkVXQR/T4420xayHsUx72NPkRganFB9BzGRFYrrBJCpZvbO5blxi6bmL8Vz
	jOstGS5fnXic9ltnSf6iAr8RFCgG8eNRPz2EgCvK52i6nTKTSNqYEPRqd7W7eFWJ9LQIlGQ6/zr
	juTbWGb2zieouDGz/DYol74sAe0FjAVT7DdI/AbVCxI/PaFoCsrTxoTn8hKHVY9mZJHBgD/pJOP
	X32tICMdBL8GW2TdRAjvp1CURFtkBZa1EGJPOVS0973s3YDCF4eGLm5w0Ic7qy3Akry+JMkHuTf
	0eu+E=
X-Received: by 2002:ac8:5fd4:0:b0:532:9eb7:5429 with SMTP id
 d75a77b69052e-5330dce5dcfmr15341061cf.39.1790303312381; Thu, 24 Sep 2026
 19:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923141047.14047-1-hannu@varjosoft.com> <179030240275.2160803.7121151150196393029@kernel.org>
In-Reply-To: <179030240275.2160803.7121151150196393029@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 04:28:20 +0200
X-Gm-Features: AclHuK8jPqxBR4Q0CEomF9whPGaxQ-JSrM3dMY5MpmnNhrsu4XA13-Jag34muAQ
Message-ID: <CANn89iK7kacaAnx3nTCL8=OrCQF5kyojeoXkWU1Kq92n5gMyUA@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol
 gso_type bits
To: netdev-bot+sashiko@kernel.org
Cc: hannu@varjosoft.com, joshwash@google.com, hramamurthy@google.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, nktgrg@google.com, willemb@google.com, 
	pkaligineedi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:13=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (2) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] With the new bitmask test in gve_prep_tso()
>   (gve_tx_dqo.c:602/607), SKB_GSO_DODGY TSO/USO skbs are now accepted,=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] gve_can_send_tso()
>   (drivers/net/ethernet/google/gve/gve_tx_dqo.c:916) always computes=E2=
=80=A6
> - [Medium] gve_prep_tso() caches `shinfo =3D skb_shinfo(skb)` at line 573
>   and then calls `skb_cow_head(skb, 0)` at line 592.

Indeed.

Please Hannu send a V2 of your patch squashing the following reload of shin=
fo:

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 616c1921aebeacb4eb711ed3cf87821559eb421f..f7511aa835082e4f9b2514a212c=
497d5319844af
100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -595,6 +595,7 @@ static int gve_prep_tso(struct sk_buff *skb)
        err =3D skb_cow_head(skb, 0);
        if (err < 0)
                return err;
+       shinfo =3D shinfo =3D skb_shinfo(skb);

        l4_start =3D skb_transport_offset(skb);
        paylen =3D skb->len - l4_start;

Thanks.
