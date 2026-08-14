Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A737F72F
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734911; cv=pass; b=Ziwbz5EKiTgqaFR7WYTVMAsJKDT2bnknnxYlld91KJAdGUasPfpmFZBPByvY6zNqRj/CxUhM4CtfXKNx1VPUHX/hhVpVPcFsQFzWnH44X7ts+C1TNAbweaWLcdbC0iExG0AY/UrgLFG6Vv1UmZUZwbAmbMx3L+I/1L21CY9rDAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734911; c=relaxed/simple;
	bh=YARhzzSQQ1PYu0fWMrgI/uEX5C0qrr5INxA7sSEl8ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYv+Jcux24UEwxSR0RAlNPinATVO4wiUSSIDyOTt5SJk0ypnqIELcox2fp+f/uV56MQucVm5TaO3yY36wtscc/L0meXT2SmcQzyR6t/a1OWBr+A9sKczLAu974aJoynIpE2+QbPVdwnbMTE1IbL2vYaKZekHTLtvupOJW5TNQX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYQ/nw7u; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYQ/nw7u"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-664e3ed58bcso3489810d50.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786734908; cv=none;
        d=google.com; s=arc-20260327;
        b=KUOV2ZM90Lt6ArbWgLJRo3n7n0uA8Bri0HYzLcdpLra9LMqEaNAwhutbKu99Dmde58
         RifCOZTL9yxDtQgQiVHXhVSEQ8CWw/JEzIeI0ZOVkWOnrcAOhfP7yZjG+ndpRwWbq4zb
         QNjY/T84tB1TZertlFB8ifmGxK0sY3oS4UN2sfzj2ZAKk1P3Q4O81ZxAvvy5bJ1l41UM
         qCvaqtc5V2ZDjxl0woIL07VOOTz9HNRkFqYIVvoK8HHvB6zchsnReJi9KGQP82xzy1jk
         /gK2/SqqSWha5kqokF1cpRmKM7qHjH0wE6ER/H/iELZ9g+dqlW1ILOYBgcyTfg3GKt+G
         kCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        fh=Iw3dLv1bd31tplWoqvT1g2su2WoxWs4LPe16XVYG/QI=;
        b=dz84tE4wm9ra2QaHaEDvaBylLv47YgY6mg1cnp4TYW9CaS+xnozJHtcQlbXbG5Mepp
         yLgwv4GSDMh4Bf7ygZiP3NSxgDOCHQfQsweaRad5dt8QLCceILxEaGUGJCZXyTRTBxSE
         d0t4beDjqECAjlBnaj3mm+TY8bwBseCl2Gigtw1Ig+gdaLZoNHGHdQTsIQSGNjuzGJ0l
         RD2nZdgxEsR1yhLDrCrBXO5yvIGXfS3RCeeNgUIJ0p/Kq/3tlvS/LXTkjt6Q0cRY3kwM
         /Oslnh1BOYg0KKfKi9cp9EHPeeRxVfeAlOoPfBDXFY/+1l7gd8KRCPNo7+JR/1s+KcRR
         16cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734908; x=1787339708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        b=KYQ/nw7u3tV0TExnGT+kd0AY6B8/6BK+QfWLRP/6E4dlPlPZz1LjL8JhAJk+dBX+6w
         sblw4YbI6vQcbyROFtTvoxUEp7GvqM4YlGJonR16otVkwHGhkYgLS5HqOJQ2C+POypbu
         fTg9mPpzjVG1vy+EwpPg2/NNng118TQwedSvAwOTFyU0bX8sasEcM21H1lNUb57/hXOb
         PQJIkXuhhcw159yLRuQYcuIhk7/AeADb4t2d28HLXcH/QZWiw3jbR22ZauT4PoIJ2izm
         0mjHu1/pT0/fudQazr0Ra9taP5SbUPkRm3vmKuIZcHS/DfYBk5sBXpODtIGIOK4RxW/S
         cLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734908; x=1787339708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        b=EOqwS3RonixlDbPgOE3IAyXX6BLDV7ERtZh7ZwtPisuYX3RwVL9k1RhRy6bNBP/m7j
         OeN7PGElmI6SG14TBms0/1eC9szr8HXrRGzIuCqsXICDdVuY17FUstQrS54b39ChmXEq
         iBd5LbEcWJkmT9/340foDJg2E22Q2JJqP2XI5UMpi10RmYIS0ZDieo+T9oeEHuekwgPT
         PL7TIKkdF0kVLtn3msfl8WvmTf9yE/cUIzaP6BZaSXwkkssLs76cP4/jKlB+tSatucO4
         cywMMg4EuFMT5qUTLtjELDYqQg+MfOFpT3Ur7BzlKG75I/Sw6pvH+IOkJBgp/zIYCRev
         7dYg==
X-Forwarded-Encrypted: i=1; AHgh+RqkQ9pAlFwi+RSqSmyt4ipYjatDeYR8/RaKuTymIktarpNvfqOp/uHMM5fFTI0uwPLmQ+/a7AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqjFjudXdpPV6HtzQNxA2A21IP9CAAbSnjUh70sBgziVszQfR
	P82lkpQ2jpYTetPrHWW7nmvtOREX6fafe6IBp9M6OmcS3/+JS6WpalJfw8QxhgWhpC5I2nyxe/F
	a7AixI+ptwxCmunWUtyK5Xy30IAi1bM4=
X-Gm-Gg: AR+sD13GLl5g7SwhrLQgh1ML97NDFA7Si91+kYfIZvTcMqEzQ/3uBbi+KCmPHMFXXXa
	CuwAs/4TP3QDZEcXvwyJlEI3W3Aug/4Hc14709b7gJlNxtRY0yp2PQz8igd9l+jfwkqrct2/uZQ
	QP0AgZlFOoucuLx1G1oORDydT3nbyUedp337yycPG2GR4CKtijqd6Xap5YE15d0HFAESoOusdYd
	pBNplOhslqKeteqdzV+ObW3eI0nmr3TnZOqdEyAmLg/g10wmIcS1JQ/BIp7XZQcwLO8ZSyRE8XE
	btCyV1yKLSZYb2KD8K74GJouMet7Xn5BgMBNoxYPP1WVZZp3dLXTpZ7R1YCEfemLF+g/wMWljBQ
	aHw==
X-Received: by 2002:a53:dd0a:0:b0:668:894a:f534 with SMTP id
 956f58d0204a3-66c54cc5fcfmr4473139d50.25.1786734907868; Fri, 14 Aug 2026
 12:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804213510.673084-1-chia-yu.chang@nokia-bell-labs.com>
 <20260804213510.673084-2-chia-yu.chang@nokia-bell-labs.com>
 <20260811173017.3d18dfdc@kernel.org> <PAXPR07MB79849A3F1724DBB2DA8EA20AA3DC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260812155430.6ec81eec@kernel.org> <PAXPR07MB7984E3E73868BF8966821C27A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CAF=yD-LQbndjPZiXcfA6fMp6msza_+YdzqqwyeUDVTdOCOHhDw@mail.gmail.com>
 <47BE8A8A-F80C-4C30-BC95-C85FEBFFB606@ericsson.com> <PAXPR07MB7984ED42ED0849D3A9AB8C19A3DA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <willemdebruijn.kernel.c248a28f9c86@gmail.com> <20260814120121.50e61d01@kernel.org>
In-Reply-To: <20260814120121.50e61d01@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 14 Aug 2026 15:14:30 -0400
X-Gm-Features: AUfX_mzfpoxQCDCly02kzT0GRl9rBucQ1xz8t4L_tqiifrYvAjnLnYkwChvD3sw
Message-ID: <CAF=yD-L1-Sxz9uyP_4WqtNRJHnwTVMhQba_KF-=Eiy=d9Jf-qA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>, 
	"shaojijie@huawei.com" <shaojijie@huawei.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	Ingemar Johansson S <ingemar.s.johansson@ericsson.com>, 
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>, 
	Parav Pandit <parav@nvidia.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 09:34:01 -0400 Willem de Bruijn wrote:
> > > Current SW GRO sets SKB_GSO_TCP_ACCECN when the flushed skb carries C=
WR in tcp_gro_complete():
> > > if (th->cwr)
> > >     shinfo->gso_type |=3D SKB_GSO_TCP_ACCECN;
> >
> > And I suppose it follows correct AccECN rules for coalescing.
> >
> > That is a performance regression from RFC 3168 ECN, as it allows for
> > less effective coalescing. I have no intuition how much it will
> > differ in practice.
> >
> > > For HW GRO of a legacy device that implementing RFC3168 semantics, se=
tting SKB_GSO_TCP_ECN seems reasonable.
> > > However, such a device would not be able to preserve ACCECN signaling=
 across the GRO/GSO.
> > > In that case, if preserving AccECN signaling is required, disabling H=
W GRO may indeed be necessary.
> >
> > Right.
>
> I'm still not following.. Maybe Willem can ELI5 what the problem is.
>
> _SW_ GRO follows only the AccECN rules.
> But if HW GRO follows RFC 3168 and we mark the aggregate as
> SKB_GSO_TCP_ECN - TSO will also abide, and segmented output
> will be identical to pre-GRO input.

+1

> Are we trying to ban RFC 3168 behavior in HW purely to match SW?

I think that's the intent here?

>
> > And there currently is no kernel API to disable only ECN
> > coalescing. NETIF_F_GRO_HW enables or disables HW-GRO entirely.
> > Or even to signal whether a HW-GRO implementation is AccECN
> > capable.
> >
> > Disabling HW-GRO can be a huge efficiency regression. I suspect
> > many users will prioritize the efficiency over preserving the AccECN
> > signal.
> >
> > That said, some devices may have other ways to configure such
> > finer details of their HW-GRO, even though not available through
> > Ethtool.
