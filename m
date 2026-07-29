Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED663C1D6B
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351477; cv=none; b=IYkC7WlQSngAvkGRAXCNHv58iol8S7gaxS6EbAucol20UVXi3/bbSvUUgfjVRt/RGqap23pSz+AFABXuMtgCpbY7hqezYKuniRCM7dITOQH6SolmQvFW9NbgK6dQrOpTGq0dKUFUi5I3y8fAiYrAdaruneCzKsNR7NrxYjwc3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351477; c=relaxed/simple;
	bh=T0qNX5ES2sgbZ3BPP7iEUFJrGmYNi/ZHkumTWHW7cLM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hvaDUs4hFbQ2/pSdVnHVRk55/puQX1rapqTX+5O3PLXsGjteTeRCNIMOvT8kFW616FMqsuCUQlxAGqhwA1/FddfCpWnRzuS4CKvFC2NPlrMJFgPcxFlUa/uP5cWLQS1MkPHxrsURIrGlm36IssSYNG/9bIQVkBVOVwqFQP6srh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb5Tafjz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb5Tafjz"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e9f7491ffso20901107b3.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351475; x=1785956275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EBrvDEnJYvhnFH7fX5PvcLxlTQTad9r13RWJQAwNzRY=;
        b=Fb5Tafjzi9r+2tNjm49t8/iaQ48Hqps5bvbk7ctwCr/YatueMKyCs6/HJRZ2W9XhUE
         RZ9AoePrYNC5vzeBJjvqv9VoF+R1NbB4lah3WWzI1I3396Mk3PIMeb5g2mtuYSvS7Fc0
         eksi+XAUcHV5AE6gpELPox6RgaZPhwxX/sDPTT6jfm5Lon6D/09ByKiM9mYVlwEEshYZ
         zB7khhPVz/Lh38x3QoQty2vIZTrLCcqZveO3MuXij7hSmQ8ZkJRezaqT8d7lYYxg5fGc
         ZPfZX21ZQFzqSZaGgx/wjdKpwd2VKmXgJU3TPbTQEnczE/Uv8F/cLHNI37CQEjGvzqVZ
         yp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351475; x=1785956275;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBrvDEnJYvhnFH7fX5PvcLxlTQTad9r13RWJQAwNzRY=;
        b=fHED5q2/LQ1sf8SvHhdFqugTcm0svDDe4JOI35uvM/IK0qhHIh/M1FwFMhp2lmTzPg
         mAb+10TfW+itl291AE/N3paRrtbJEmuOI8u3auIVqptR0FOUvhCVeWyxYz1MkiKy0fmh
         4GqGQaaxbqmmY/87Y2SWU4iTCX4KNb/+6rfNutZ3Po6S9J7igPHrztltXM9RU6l9/csZ
         lYXUeOsvXtMtz8XBqDkDHmZ3gWdorgGUupuS/RvF95NkUIheUC1qtZatLqXqfARJjQ5q
         UI9TNmuQS+ZvYoubof9Ijyh7GIc07yWi5J+KF1JPwr5IjvYNz37sjmvvl5acO3Jxv4Ad
         q5Ng==
X-Forwarded-Encrypted: i=1; AHgh+RrSQ6PSJw6l7Wmci88iGUvPeWGI/5nNdiFcl5Rzahdr1lqYlsOnkVDE1opkmFUjEEG/vu7+6MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2mgf7Iijd39K37LVyudXfQobeO+jHVEd5X/ClV+Dqbg59Oah
	Vqteo2G6wyX+/h66v81i/mImjdz9tUfdLq79trfim7O9+G1U30As8NA0
X-Gm-Gg: AR+sD13UcOyxheAEwQqo1cgyLvjeXvBDv1iv9YQR/0Vhi6+y7qTu5IGHOKJM5gXNQ18
	5NKj8h2fOOQsKQc2rnrbyriXZEWjIP1ARtH96LJXxxJywKUWXQQwlGK+Ux2hwVL0nD0pLLEIfm+
	e92b9PxHo6nKuzTs+xrfTq/qban9AqWAm+iyyXuovaUFmlumHPuFcAZ6rOA80DWez6QhcfO2BE5
	IDIa0eT8i7dSzscYqKlxuYiKxMDtkIo6uWMyZMLFDrOK5by1PqY7VKlFqZRnGw3hMKI7mcrvqvK
	jhmZP/2/Fao/jIQDvXeozWE/bLrK0A/rL/VuYQHQimkkTB2dqk4q4WJdJNrroiw7u/BD3OrTL8a
	e81tykZGzB7sdBtWkex8tu+iOUgaMYDIs9wuqgehkaPjvK2FQKH3yswlfdmnjwGKzep5f/qn32b
	Z3Hw7C056smxKMLhQk6jiroSTR/pn9Pg9DQGxVV1Kxsg5f5vgG0fJGTY9+CTYFnkSWxugUlHOH5
	SciNnrH5jAtmYV8q3DTu9GkrEUDnuoIgzK/BQ==
X-Received: by 2002:a05:690c:c08:b0:81e:4886:2727 with SMTP id 00721157ae682-81fb5de8df5mr374317b3.58.1785351474737;
        Wed, 29 Jul 2026 11:57:54 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa2756af8sm24846587b3.3.2026.07.29.11.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:57:53 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:57:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "willemb@google.com" <willemb@google.com>
Cc: "sd@queasysnail.net" <sd@queasysnail.net>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "imv4bel@gmail.com" <imv4bel@gmail.com>, 
 "alice@isovalent.com" <alice@isovalent.com>, 
 "eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, 
 =?UTF-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>, 
 =?UTF-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= <haijun.liu@mediatek.com>, 
 "horms@kernel.org" <horms@kernel.org>, 
 =?UTF-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= <Xiayu.Zhang@mediatek.com>, 
 =?UTF-8?B?SXZlbiBZYW5nICjpmLPlhYkp?= <Iven.Yang@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 =?UTF-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= <Lambert.Wang@mediatek.com>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "kuniyu@google.com" <kuniyu@google.com>, 
 "ncardwell@google.com" <ncardwell@google.com>, 
 steffen.klassert@secunet.com
Message-ID: <willemdebruijn.kernel.1758c8f19209@gmail.com>
In-Reply-To: <0f5668da79eb9a13dfdb9c97c7d71c5153b3a48f.camel@mediatek.com>
References: <20260723091601.72103-1-zhaoping.shu@mediatek.com>
 <20260723063935.75bf55e3@kernel.org>
 <CA+FuTSfgBbPkdLanqEgbDq-jLVQJax4fUxQ-tuzTuFwQANwxBA@mail.gmail.com>
 <0f5668da79eb9a13dfdb9c97c7d71c5153b3a48f.camel@mediatek.com>
Subject: Re: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in
 skb_gro_receive_list()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zhaoping Shu (=E8=88=92=E5=8F=AC=E5=B9=B3) wrote:
> On Thu, 2026-07-23 at 16:02 +0200, Willem de Bruijn wrote:
> > On Thu, Jul 23, 2026 at 3:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg>
> > wrote:
> > > =

> > > On Thu, 23 Jul 2026 17:16:01 +0800 zhaoping.shu@mediatek.com wrote:=

> > > > From: HW He <hw.he@mediatek.com>
> > > > =

> > > > On devices that support both NETIF_F_GRO_HW and
> > > > NETIF_F_GRO_FRAGLIST,
> > > =

> > > "devices that support FRAGLIST"? Isn't it a software feature?
> =

> Sorry for not making it clear. The test environment is:
> device supports GRO_HW, and enable NETIF_F_GRO_FRAGLIST in
> driver.
> =

> > > =

> > > > the hardware or driver may deliver packets that have already been=

> > > =

> > > If you have a driver in mind please name it.
> > > =

> > > > aggregated into a TCP GSO skb with frags[]. GRO may then
> > > > aggregate the skb again in skb_gro_receive_list().
> > > > =

> > > > This can create a nested GSO skb, which is not handled correctly
> > > > by the
> > > > later GSO segmentation paths. When the skb is segmented by
> > > > skb_segment_list(), it not be fully restored to the original
> > > > packets.
> > > > =

> > > > Avoid this by setting NAPI_GRO_CB(skb)->flush for GSO skbs before=

> > > > aggregation.
> > > =

> > > I don't think we can do this. For GRO_HW devices re-aggregating
> > > in SW is quite helpful, HW often runs out of contexts or times
> > > out too soon, generating skbs with 16kB..32kB of data, the SW
> > > can help bring it up to full TSO.
> =

> I'll try to explain this issue below.
> =

> > =

> > Also, after e751256486d0 ("net: gro: fix double aggregation of
> > flush-marked skbs"), it's not clear an another bug remains.
> > =

> > If it is: as said "nested GRO" of hw + sw GRO is intentional, e.g.,
> > for BIG-TCP.
> > =

> > But it may not be anticipated for skb_gro_receive_list. One option
> > would be to skip the fraglist GSO optimization for such packets.
> > =

> > First I'd like to understand better what exact bug remains.
> =

> I agree that re-aggregation is useful for improving GRO efficiency.
> =

> However, as a general rule, a GSO skb must be segment back to the
> exact original packets stream. In tethering test, skb_segment_list()
> cannot correctly segment a nested GSO skb produced by this path.

So the specific issue is a driver that builds a regular (HW) GSO
packet followed by software GSO that uses fraglist?

Then I see three paths to fixing this

1. decline to further apply SW GRO if skb is GSO and in fraglist mode
2. if in fraglist mode, further apply SW GRO, but do not use fraglist
3. in skb_segment_list detect this case and fall back onto
   skb_segment

We already apply option 3 to various cases where skb_segment_list
cannot handle complex use-cases of fraglist.

This patch chooses option 1, which is fine. Alternatively it could
fall through to the regular skb_gro_receive path below.

> This issue can reproduce in the following scenario:
> 1.Driver submits a single TCP packet, P1. P1 is kept in the
> gro_list as the first packet.
> =

> 2. The driver submits a TCP GSO skb, P2. P2 has already aggregated
> multiple TCP packets by HW_GRO, and its non-linear data is stored in
> frags[].
> =

> 3. P1 and P2 match the GRO rules, and since there is no local socket,
> they are aggregated by skb_gro_receive_list(). The resulting skb,
> P3, has a frag_list entry that still contains frags[]:
> P3: [ Linear Data ] -> frag_list -> [ Linear Data ]
>                                     [ frag[1] ]
>                                     [ frag[2] ]
>                                     ...
> =

> 4. Later, tcp4_gso_segment() or tcp6_gso_segment() calls
> skb_segment_list() to segment P3. However, skb_segment_list() only
> segments the entries in frag_list. It does not segment the frags[]
> inside P2, so P3 is not restored to the original packets, which leads
> to IP fragmentation or packet drop in the following path.
> =

> The patch only prevents that nested case before skb_gro_receive_list()
> aggregation. It does not affect packets that are re-aggregated by
> skb_gro_receive().

Thanks for the detailed explanation.


