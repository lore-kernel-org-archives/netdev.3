Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792776060;
	b=a0zXO4cIRF0ca9QtMSrpZhtl+M/nAN3718NYv/j7jrrAMss30z/WGu9uAJOGHCGqksBc
	 di44sJtkp8doypO+d51C5yBEAUCOXo8Lqdsq0xg41ZWtiEZcibLSMLJB+hf1H566olDZL
	 rMfVghOShxYRnervG+YBA28WY9f2fm0CqTyVvScw9Yqwc+XlwGZ13DalXTWDHK1Ej7i9K
	 p5IcLCKRq/l5WhRqkcZVGME8Dta8D2avWG4hPRkPwKeEjyOfId3mC9p6EU5ed6wXk0e0d
	 XiTsc//8ybolbiasZUL2UfyJSEsNoYVu2piD2pOMP20R4woV/7oVUExprl4vG44W3/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776060;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=0nbb1+gmo3RWuWZWMTmbysNnHRUp8yuozX3bwCuD0eE=;
	b=ZRyvgJIJAUPI4GG0tdEAKmVvzZALOUpVU1uyfZ1qh9r1UrwLSnf7D2N6Zk6xRgeVJ4yX
	 kWQ4PtHl8TZvZ5Wyx7k4kHP5jU/S4a1zYJn9glOqx/BcJoBss1M4IrTZQK0Q6qEPHdno2
	 Rzxj+Widyg3qtV2BqIydJ6S/ATXTVvorl0L0hyN77o0Qe577yr0+jiVzym8FbBguxJPh/
	 cINkfA2gaczkr1WreObsWXH2CED0i2MQmDnwBhoCNNv1MN68TuUiyxl02Gv/rbBJKWeBr
	 nHK07qtS789aLGC+5CkXVdq9XNEWaYNKomDwZNvyEyb3JeprNWf9DjegUmITaqO5wHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=h3kNNRZv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14813606A32E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 17:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14813606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=h3kNNRZv
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6haD000515
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:20:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=0nbb1+gmo3R
	WuWZWMTmbysNnHRUp8yuozX3bwCuD0eE=; b=h3kNNRZvutJwWAllbDFrnQwAZTw
	LG+gBqrvftpvkVL2Dj7rqcYubAM29ajILxm6v6nsanzUkBIpg/GCbDS1qVcDXwm+
	VGaWd2n0sEFU2xw78bl/HyX/fYYAcLSdJnkYRPo27n0TzdrJWVk3H2xhd2CuJo84
	aIK+kKO8TNgQKua3fQkgSyQb2AtLi46S7f955iyyr6qeRE6rR8qU3TP0vZyDWSfY
	53asbrSxz8jlpPYUtbPkGhrKeW/oGOrXR7PrtXj/IcHFFTMzNlwUth43qkugZ/U6
	syPiY8YaLwHhXU0xXQbf5DUS9WaF2jSp1USV9GmOL+cNuUBohsK9vhSnYBw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hf9mxchb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:20:57 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea71803effso10734465ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792776057; cv=none;
        d=google.com; s=arc-20260327;
        b=DLKws2Vj9NFXGfDHst3/3BhxII9VeT6CEvk6G7Cq3QajyjDOdGygPS+tS7YWAykjvc
         OpE93pGX07zcSDfOMBUCBoN+YdPA+Ea/bD5ZwGcqFRhnoLsCYnSKeack6shvPjGmRIql
         bEO7/95nucGa9WrFUPKeDykmGaT1+vm+0/jShZanniOosE9urJ1N/sWLt9tjW8jqa8qt
         v5CPxfMGf7UtNufKO56axkf//hmmjJ8cZ8qTdnONFKA8sHwEh5IJELI7Q9pmy8h3luBx
         g6fwO5lgAbC+YtmL4xNigXMtZEEagnoMbKNJOc63MNZ7DMco0MoRHvmX+ZWiMl3ZP0dw
         jzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=0nbb1+gmo3RWuWZWMTmbysNnHRUp8yuozX3bwCuD0eE=;
        fh=Gy957YhP/bIcmyJ7BgG3Dfjg1w3vremvzYvdibXp9YY=;
        b=qb1UHSni2MF3OU6T04LAKEtlYcd3FCXtROdvqW+6y/qepQmR/uFhG1QDnI09fj9/dL
         KruZFdvVxwCsttrBNQpS4FzEk4GgSnld7a50+5+kSvHWKFRoa35zg85ML7SumbsfpKiY
         ELPJT6ccVtAd6JaJXyQiGS7okD5NR0u1hHgTX+PumTEJ75l+dM4jJv19m4LFswhFAlmX
         h8xYwI5hlczbUdxq6ObwuqJE1Q7Xvi6ceXb6mG9y2dMzAJlLaiTkeCrOoItkdv3/420e
         lLvCNuLf1eQJroJmvRiVVz92sKGGbSopV9uqFDdkkzSk6s66LF5yYvyjIf5nP5Qv6ok7
         vsuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776057; x=1793380857;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0nbb1+gmo3RWuWZWMTmbysNnHRUp8yuozX3bwCuD0eE=;
        b=0dON9T6TVwHGYdRDQGv7/N6+Hx4ycB204PXH/9PNqmVW3ilyvwWxgFinTEgDRBie2Z
         Cpz/66JiSsjUD5PMde6iAZulScuSiIRZx+K0mDwDyY5bIyAx3Bs4k/3YYc/Zxpzh5yoD
         0kBe5Ti5wyJTbQiXy8AQCQYTO2Udi8H7veq4MKRlKVr2/7ssNDdV/IxiG8Q68UZvPnpd
         +fa6D6eCwaX/Lz3iiaCYmBZkwJhmg5VVy0kqS+BDf/KqG40Va9NKmaZRtH5Bu/dXxopt
         C+slTRLwmIkTDMlivOf9T0KhUjsasNRB/5p5L6Ib4eYExYCwx+0xaZbZckawpFLcNyLm
         Nu+Q==
X-Gm-Message-State: AFq9FYKs6EUHDwjNWvCfPSY9QRvVvmaJgHw+bJSXIegQz8ByJ1B33HRA
	DTLSR0WB2/r8hiTuAqt1qq6PRDPlOV23iu466CwrPjpc5vJxN1l0RmMedFATEFIz+Iaa1mVV9IT
	X5RvNPFvT+heiTGecyaufWBoFkY7qDEdDFZA1jceWPRMgTym8qb6NoHylVLQDSj0nzGnpRUJDY0
	Q+deTsMBcIQ22yXA573zXM9fLCIrZtsYs=
X-Gm-Gg: AYBFou2+aNbrC/Ba8BuJ6YKWCHbFegNJ1GOZvdvrpXfP6Z1DfT8hlJbTAkF7UqGT//r
	mDK4A36HDdP2EJIOF3qZbpHKE37Prjk79r2eexj0YBh/REJPonCMqc06G5B0sj6DRxNpKHPtpLw
	DmUZNJWrJBM/u3n2R0jvOorUqxU5qz9GBiVMj0QOMpPJZO5z89RQgxr/vICgXYv0O4wwf0sRvme
	leMN9twtSNZASrk57sXZTCu7KB+zFrR
X-Received: by 2002:a17:902:ffcf:b0:2e9:658f:c33e with SMTP id d9443c01a7336-2ea7ce435ebmr26441455ad.8.1792776056567;
        Fri, 23 Oct 2026 10:20:56 -0700 (PDT)
X-Received: by 2002:a17:902:ffcf:b0:2e9:658f:c33e with SMTP id
 d9443c01a7336-2ea7ce435ebmr26441315ad.8.1792776056075; Fri, 23 Oct 2026
 10:20:56 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022223014.556388-1-toddfreed@meta.com> <20261022223014.556388-2-toddfreed@meta.com>
 <DMC6H9OT57RA.30RKA7CO0856R@gmail.com>
In-Reply-To: <DMC6H9OT57RA.30RKA7CO0856R@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Fri, 23 Oct 2026 10:20:44 -0700
X-Gm-Features: AclHuK88YhWMifFuKF48zzEpiv1AW4dXYQLz0yCHzxNvKSvxsDASMAUa-8p8mZU
Message-ID: <CADh2yMyVZawNObS1WOjahqsO=XJjpwoxSFMXyc=kOzWhXMOc3Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] psp: fix transport mode encap with ipv6
 extension headers
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Shuah Khan <shuah@kernel.org>, Raed Salem <raeds@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Cosmin Ratiu <cratiu@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: UWX05UGzDKMeBYbiH2B0jIMyKotVfLOb
X-Authority-Analysis: v=2.4 cv=G7iJgNk5 c=1 sm=1 tr=0 ts=6adb9779 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=glYwtrVRrWtjULxB9TQA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX7u6ODC5yF37u
 jTHE3C8wgqt3sGAvcv2F4rMjoAl1Tx64akGEsaVpLOYkmrSIGBojcP4pYS9krgDgEaY+iOICCY/
 h3WFzqVIx6WcxCOFkhNLjB9whMcN2/s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXz7MPr3G1IK/L
 vuw6tRwdWSI8XkD7NJ1JQoemW0p0tZ+6XpHpKJtbTlBAYifPNyi6y9Xj1f7feXoPziox9paUiwB
 CFcApiR3GZkYzEpK39oegTgIgFEzkzuvFiWmgZlGny6FbQiiA74yrxRLzUQ0oj5Duad3CralivE
 2lPogpl+gl/UcchMP6l8Sv1FeDDaEpfGS26g+njluDWrjG3H45F8rrLXbtHnH2IEbjisy/5WQ4r
 XDZInbIaO/ngT4Wx8AcpWMVYq4Po9Gh0ADvoPQ5yYCBfgDTUj3OWwRTskN80diDT1FjmlWUKyFn
 rxerenjC0tqkU6w7JCck691nRmqbiWLEVO8JYGhdjx4UqVkwz5ACeNy8fHDzBkqJzWEd3u2C2hn
 viD3Ks/oXsJi5D0EDPmZMrCpNDSsoTW/Mod6AedbTe371Cf0Tm3rrE1ZAqtz+kDlmCDh+/J5Ssu
 6hFFGVIajujDjNYifSw==
X-Proofpoint-ORIG-GUID: UWX05UGzDKMeBYbiH2B0jIMyKotVfLOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01

> > - NEXTHDR_ROUTING. the tcp checksum covers the final destination, but
> >   drivers seed tso checksums from the daddr in the fixed hdr
> >   (mlx5e_psp_handle_tx_skb()), so this would produce bad checksums.
> >   could be supported with more work.
> >
>
> The stack should seed the tcp check correctly with the sk dst addr. If
> mlx5's lso implementation can't take that into account, I'm not sure a
> generic helper should be the one rejecting the skb.

Fair enough. In v3 I will fix the mlx5 bug, and accept routing headers, too.

Or if it's more suitable in a bugfix, to effect the narrower behavior change
e.g. drop, please let me know (ack that such a drop should be in the driver
though).

> > +             if (!ipv6_ext_hdr(type) || type == NEXTHDR_NONE ||
> > +                 type == NEXTHDR_FRAGMENT || type == NEXTHDR_ROUTING)
> > +                     return -1;
>
> return an error code instead of -1?

ack

> > +             rem = len - off;
> > +             if (rem < sizeof(*eh))
> > +                     return -1;
> > +
> > +             nh = off + offsetof(struct ipv6_opt_hdr, nexthdr);
> > +             if (type == NEXTHDR_AUTH)
> > +                     off += ipv6_authlen(eh);
>
> I was expecting auth header to be part of the reject list.

I will do more testing with auth header.

> > @@ -331,8 +375,23 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
> >                       return -EINVAL;
>
> If you send a v3, I think you should put the psp_dev_rcv() in a
> serparate patch.

Okay.

-Todd
