Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399386;
	b=Rq/JGuF0gRzL0nBdskbMkS5fcVz5YAWMZDAacSIt3zAI+N/01FoZ1VAnFMKc4ZOF8B/p
	 +PbNW34ZE4BuzBRsLWDfhaxLSyueezkZOsIyCRkpKNECVyH7pOT6wksE1c30Ukz9vSv5L
	 LXJkmaHUGefuWli0AD3xLYtU29bM6RieyTo4Km3RBAVptBC1SENnKdQkuzx2MjPtniMvD
	 hvK6ro+onQouHBrUxFQgQc/MHX5R8cKRehW7eJfrRHD9T/MTHFjTxjP4pjS790JIgVOgS
	 DlurmdfqBmqKox+FUfanYyy99c5bARRL8Xx2Sj3kawoxjXp+CPeJene6iLka0IDmFAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Te+EXzznd0wdlADA+6XlZTiqeKUHZc1UFKzEbNtjc8Q=;
	b=frIenYunhG435HrJoD97xtfCychBb3ScDJDz+3JYlU/ArnX5C61e8Vzqc/ilsftPssQ1
	 hwJYN8SZewfXmnag9n18O6iWMBem2OR0x3dsZKDYehNOnbqslmjVMLOt6ZyG9hKHVtubV
	 dp5BD0sPzpOHrNryM2/lNc8E/yTk9IragVIMZg9lvjFHItvGSgn1rqhTcbsQd/NVRhuwH
	 a5yn9uCvXZqSqXyvFdKX+pJV9RRSLldNm9BKz4KDtYBcmlyMVJLPGQ2v68LQDLByrpflo
	 4QwTKvjaHpkYKX6bPoZCy2fHMADxZcNiduuIZ5OybiOLE/MiGhlhN71CXShY5I6Iigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h4BaQDlw;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556B606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9556B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h4BaQDlw
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eafb65e204so396966e0c.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399384; x=1794004184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Te+EXzznd0wdlADA+6XlZTiqeKUHZc1UFKzEbNtjc8Q=;
        b=h4BaQDlw9kEiKvqZ+Ita/tYbWxguQr3je0TpUgs0aZddKG2SZAnksywc81QOkg4B2G
         pxG7abPLoOeER6tNce+qXAAqd7uNDSKXQqPoo4HvbE5DYsWPK9PG2EDzgfmC44KuCkMs
         fkHRTlwuD3sYpWGvWdGc+KIXMbhSGtqichphJSkY54kFnf8CmZo+N6WhRS6EL2pJHU3C
         3eACCDdR2QNjW6w8M07GRGwdhjpWfHevtfE9l4bqhYLeBV5PjXrBiIkhHuL1Sqg73Hfa
         YGkmE2qvvgCXlQjez9B+jGmr3UQDYlz/XxLaflbkKu7B6ZDLkzTSgHtWUfxFIDYS9KbE
         8Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399384; x=1794004184;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Te+EXzznd0wdlADA+6XlZTiqeKUHZc1UFKzEbNtjc8Q=;
        b=rsQUg9pO2W5womXhcGe6CurfkRZHbsxTZcdTCLMM26rEx824eobsvwPnyx5yrRlj5b
         Xd72tKoGuDsrlP4utRf7r/nDbTsMV8UOWeSHrCn/ShrOK4gi0wWkcwOMlxGvaWhX2EFH
         zu1oR82bY5FUaJW06JcBtyrc4hKJms6wwA322P6GnhDxbIAG8TpbLwkJ9KNktscnV1bb
         d5f93zK0MNJgAwUu7Fr0QvrFEp36zFGYsvaK8hI/q11oqm2fMGI4HAb2HrwNwMZm4/ro
         tHAcAVvEFfUguDJiwLS7sArc8kx0Bjds8URVUUJXVF6teowAKGvWdEl16QnSGVjGQtJP
         d0ig==
X-Gm-Message-State: AFq9FYJT9IqpWyfffNI/i7Etblar4hTAVlBP/5NdLCTP6sJifBRNaxtK
	mD1N3yQpKIrjPPzG7wCNpKwvjNVwEGnEgfQ8tsa5d4Bx0pWIItarAap9
X-Gm-Gg: AYBFou0fWpAngtzJWxKV1ph3ds00PS0TasuKw2JXChqXoEcLqehWgmXLo3Uop2tkhk2
	w5vByF4T1CbRIHYfDVMHxR/bgl+cqYHApi5JPs41qMAnjnAVcdmOpErcPHK+LV8UnQKgYDKbtmT
	2dVUbhcohicRu+7skGVPXPPQLh4RZ2Y4KuObOYtZiSbqRsNb0H7SjIFdmtcVFF9DMW79NInY0L6
	NmH2B3gNt0nV0bifeFE4sAZILxO5V0kLoG1Y9tdKou9giWoK4RWJ0egwG1c/NBSzxOG5zwsw+fo
	xvkqrhL/5UVscdV4L6pSzYO8b9Ji7htt62zhYmXkeRmELcyW/BU0kdE5pbzgteZlCvBuBjmwMte
	/KPRIxMwPKSbZee58nM77oMK5o9NQk6cHnJNNTBulSLqUMmKho0Uf7O30diwzSzS4JPiOtPY1k4
	VqChhAmgmmVpmna1T4HLavr6SwXBCt4Cd0mcQniLpqKdjpSOBSkRX3FXE21AUKWdyk3b4sBms8I
	6qK1233hC6H1K42oh12AxdpoXqXBogRF3wTXYoDnY3U2PI/UOvSSBiNZg3744dD+fyKTzEhaIdW
	m4TzflUK0GQIkc7lIL4c75kqnXQ2FbUdslV/l57kBSNJRUR85ED60mDotKIOlNFNLEk2xB5HlDJ
	3hDKHwsgvfj1fPucv3ujRYddNS5YulIkF23J4ozozDg+6usEVO3odOeGqK4P6b7Old+lN
X-Received: by 2002:a05:6122:20a9:b0:5c9:a60d:3276 with SMTP id 71dfb90a1353d-5ec6894bf69mr2018923e0c.10.1793399384580;
        Fri, 30 Oct 2026 15:29:44 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c99e3csm3840233e0c.15.2026.10.30.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:29:43 -0700 (PDT)
Date: Fri, 30 Oct 2026 18:29:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 =?UTF-8?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1PlronlhajlhazlhbHpgq7nrrEp?= <tencentos_secure@tencent.com>
Cc: netdev@vger.kernel.org, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Steffen Klassert <klassert@kernel.org>, 
 security@kernel.org
Message-ID: <willemdebruijn.kernel.15f496f9f2418@gmail.com>
In-Reply-To: <CAL4Wiio2inRipSSWgFKkRjuPA=iLkynvWCXQ7cpe9G5XWi9=7Q@mail.gmail.com>
References: <v2-20261026-cover@tencent.com>
 <98906F734B5D43DA+v2-20261026-p2@tencent.com>
 <CAL4Wiio2inRipSSWgFKkRjuPA=iLkynvWCXQ7cpe9G5XWi9=7Q@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net/ipv4: fail append when the moved fraggap
 exceeds the fragment data
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> Le lun. 26 oct. 2026 =C3=A0 12:23, tencentos_secure(TencentOS=E5=AE=89=E5=
=85=A8=E5=85=AC=E5=85=B1=E9=82=AE=E7=AE=B1)
> <tencentos_secure@tencent.com> a =C3=A9crit :
> >
> > When the first fragment of a cork is already at maxfraglen, the next
> > __ip_append_data() iteration relays the previous fragment's tail,
> > fraggap =3D skb_prev->len - maxfraglen, into the new skb. The moved
> > fraggap is charged against datalen by computing
> >
> >         copy =3D datalen - transhdrlen - fraggap - pagedlen;
> >
> > but once datalen is capped at maxfraglen - fragheaderlen it can becom=
e
> > smaller than transhdrlen + fraggap. Then copy goes negative: no paylo=
ad
> > is copied and the iteration makes no progress. Worse, in the paged
> > branch (MSG_SPLICE_PAGES / MSG_ZEROCOPY / GSO) pagedlen =3D datalen -=

> > transhdrlen - fraggap additionally wraps unsigned, breaking the
> > alloclen + pagedlen =3D=3D fraglen invariant that commit eca856950f7c=

> > ("ipv4: account for fraggap on the paged allocation path") relies
> > on; the loop then either queues skbs with garbage tail accounting
> > (silent packet corruption) or, when maxfraglen =3D=3D fragheaderlen,
> > never makes progress and grinds on until -ENOBUFS.
> >
> > Reject such an append before any allocation: if the moved tail
> > (transhdrlen + fraggap) cannot fit in the fragment's datalen, the
> > iteration cannot make progress, so fail with -EINVAL. This covers all=

> > three alloclen branches, including the paged one. With the preceding
> > fix fraggap is bounded by the alignment slop, but the condition stays=

> > reachable with extreme geometries (e.g. an effective mtu too small fo=
r
> > fragheaderlen + transhdrlen), so pin the geometry explicitly, as
> > __ip6_append_data() has done since commit 232cd35d0804 ("ipv6: fix
> > out of bound writes in __ip6_append_data()").
> >
> =

> I do not think this is reachable once patch 1 is applied.
> =

> ip_setup_cork() rejects cork->fragsize < 68 (inetdev_valid_mtu()), and
> fragheaderlen is at most 60, so a capped datalen is at least 8, and
> maxfraglen =3D=3D fragheaderlen cannot happen.
> =

> transhdrlen is non zero only on the first iteration with an empty
> queue, where fraggap is 0, and current callers pass at most 8 bytes
> (UDP, ICMP, ping). On later iterations transhdrlen is 0 and, with
> patch 1, fraggap <=3D mtu - maxfraglen <=3D 7.
> =

> So transhdrlen + fraggap > datalen can not be true.

Supposedly there is a path where

    transhdrlen + fraggap > IPV4_MIN_MTU

icmp_timestamp sets transhdrlen to 20
