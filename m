Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0207415F1F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770644; cv=none; b=K8/tUcPZHzCdQUTh7Xy7+Jrq617rinRtPylAQ4bUC+IPj03R8ffTeN4W7dLusKlAgAkCTKmzUJ0VRpYnvMf/429RL+/SBj5pZVQK2rD9GeeiqRfYKfORKSqDM41ocOPOZBTfrfZbHqj1AKTULI86ZVnqXBBY9mjPtNIGhSzlrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770644; c=relaxed/simple;
	bh=dICn3G7BjBZWiKbEREeyamu7JZMOY5ZC1RrVDZ1/6XU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uzaN3CztNaM8MQVWnj0PP/t8Lz1e5VXhfTuecfGpsOVFelT3cGu7+hbs9nrm0IeajsfSZexuATLp+6jSzGrNtuazF1vTQls5n41+j8YfbejgLCl44BZ3Ll1djI54RLayfqQGQxKWzXteu/tdIuKGRus6uBOa0ePwInH9LAczUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj+CkS65; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj+CkS65"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81f52945098so164987b3.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785770641; x=1786375441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sE+lFIM3UFlIMDzXhXPT065cUaDU4oEMPdyY1ZBUy+g=;
        b=Rj+CkS65VroNVDvGG7R00vps4KCYej7qOQ5h5LAjNXkwkAbx+C77ioy4S2c4b35fGQ
         P6b+Kov9LTrNFj+ErxHVqoi9gqOcd2A0UHxe2m968tGS6rV6Bcxi1AG+VshX3lcnKIIo
         CvyvDFbzkSiCSTmYX2dfWQHJCJKJ2WgNwfmRZRC9+B0oyrzKWvmehbIiBqiZW8ZvGkDf
         ayNBRI62g6BuRc/YoWC/dnHE1nPmDzfKkBuGsvIQ7rZ7stklqqaHC/9K+vmYgwOU32DV
         6G6aAFas9WF/NL5JO97jbLqGP6i4U+LxXGYG2Z6wQBc0nk5nZiMo1mCoMfb30fWazd+l
         QT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770641; x=1786375441;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sE+lFIM3UFlIMDzXhXPT065cUaDU4oEMPdyY1ZBUy+g=;
        b=nyK5Aug1eUltJonvWMQZ+Cs1QwdVQFJzbgyAxgt5KrYj1z4cQeFCmV2SPNxqwTHR13
         mNCCkQgl7DHbnn0RhqurgKAr8nEX/RSIYAaoAFh4SJHNsZqUbIWK4dm+DhAQqfsUjtKx
         f1swwwtf8aBOZ/K7njnoRZTHjsCw5irZ6VqTXaixsLK6MpUbLLWvnlvTlos0BuWJOxOh
         cIJuARY2yljhcijykxZlQp8VmV6BsvdYaIGGOpaCQqZZgsYEPXQUSP+hViniOqwLRuQq
         MsYB2Ux6dAtIzsWsBKEOVYDbgMfgm3gRIv9SGR05RwCg9qzf6mEQ567vYocy/h2q5zZR
         2DRw==
X-Forwarded-Encrypted: i=1; AHgh+RrbEeY7lStbiwgXgw9sJ4i7CzhRZktOQrSy0LyEBecnnHflIJSoaKHy0vD/za0ebyPTC0k3Hdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yu2y6oyxFx/CJdmy+XwAoBakC4pBMDrqRtgMs3Sf1rQYi+7n
	WXsr90ri803UgHo9vdubyi0Od6LtUgp043NE3phN+id6h5sYI4Sr7ZD2
X-Gm-Gg: AR+sD10WJvwZiOxgzb9QGpxxLQlae/LjGkf9cP1ecyeFLiYBN6nvJs9F+JS7HL6yubq
	Z+JmZZCRDHlMyn6sYjo38jKgw0WduqTWHFYGLzoritFHsUOsMbDwMrlrTbnnnXF9Ak1QGQBXcO5
	eHtnzdAvoJh0AatdF/ymfwYK77XC4AAkxP5VgMJdWJNMvsTFXD7iJDeHepkhU38HyjB1oYYlhC7
	YEC+2LfaE6AJKLvJQtR8JkwkhMvzVM3Kug0kkjfL3IDvBtJT2KW6CK3ul3lTJHmIPqxyxHobghS
	XtnhHdA3rX9qtEJQDrXz68oAR30PMmHtmhji0V23l40O9NfCr+2h4LebPeHHFAYHEnygb/qgIY2
	AC+e8SoJDEyIMRYGPOH/IDquMV4QAMfg5B+F6LDH4PNkFWtGih8uEbWO5/d/JnOHDsjWGllYtsL
	N8Kf3HN5kQRjPNd92iki5SK587hpjlUuq7BfEpB+6IX/dni/7r59PhNDlnTSGff8kbnrRPqHLa7
	SnrPDhGGSOOssLtRlUdVogPKV361ZPQULUFQZm20izsZwI=
X-Received: by 2002:a05:690c:6701:b0:81e:abe2:e022 with SMTP id 00721157ae682-81fd4d6e458mr131027997b3.5.1785770641326;
        Mon, 03 Aug 2026 08:24:01 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d5ec2sm56116767b3.23.2026.08.03.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:24:00 -0700 (PDT)
Date: Mon, 03 Aug 2026 11:24:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "willemb@google.com" <willemb@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "kuniyu@google.com" <kuniyu@google.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "imv4bel@gmail.com" <imv4bel@gmail.com>, 
 "alice@isovalent.com" <alice@isovalent.com>, 
 "eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, 
 =?UTF-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
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
 "sd@queasysnail.net" <sd@queasysnail.net>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "ncardwell@google.com" <ncardwell@google.com>
Message-ID: <willemdebruijn.kernel.104ee0d69507c@gmail.com>
In-Reply-To: <c84c9f4bd495977e08ee38343282f05f42b080fb.camel@mediatek.com>
References: <20260723091601.72103-1-zhaoping.shu@mediatek.com>
 <20260723063935.75bf55e3@kernel.org>
 <CA+FuTSfgBbPkdLanqEgbDq-jLVQJax4fUxQ-tuzTuFwQANwxBA@mail.gmail.com>
 <0f5668da79eb9a13dfdb9c97c7d71c5153b3a48f.camel@mediatek.com>
 <willemdebruijn.kernel.1758c8f19209@gmail.com>
 <c84c9f4bd495977e08ee38343282f05f42b080fb.camel@mediatek.com>
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
> On Wed, 2026-07-29 at 14:57 -0400, Willem de Bruijn wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > =

> > =

> > Zhaoping Shu (=E8=88=92=E5=8F=AC=E5=B9=B3) wrote:
> > > On Thu, 2026-07-23 at 16:02 +0200, Willem de Bruijn wrote:
> > > > On Thu, Jul 23, 2026 at 3:39=E2=80=AFPM Jakub Kicinski <kuba@kern=
el.org>
> > > > wrote:
> > > > > =

> > > > > On Thu, 23 Jul 2026 17:16:01 +0800 zhaoping.shu@mediatek.com
> > > > > wrote:
> > > > > > From: HW He <hw.he@mediatek.com>
> > > > > > =

> > > > > > On devices that support both NETIF_F_GRO_HW and
> > > > > > NETIF_F_GRO_FRAGLIST,
> > > > > =

> > > > > "devices that support FRAGLIST"? Isn't it a software feature?
> > > =

> > > Sorry for not making it clear. The test environment is:
> > > device supports GRO_HW, and enable NETIF_F_GRO_FRAGLIST in
> > > driver.
> > > =

> > > > > =

> > > > > > the hardware or driver may deliver packets that have already
> > > > > > been
> > > > > =

> > > > > If you have a driver in mind please name it.
> > > > > =

> > > > > > aggregated into a TCP GSO skb with frags[]. GRO may then
> > > > > > aggregate the skb again in skb_gro_receive_list().
> > > > > > =

> > > > > > This can create a nested GSO skb, which is not handled
> > > > > > correctly
> > > > > > by the
> > > > > > later GSO segmentation paths. When the skb is segmented by
> > > > > > skb_segment_list(), it not be fully restored to the original
> > > > > > packets.
> > > > > > =

> > > > > > Avoid this by setting NAPI_GRO_CB(skb)->flush for GSO skbs
> > > > > > before
> > > > > > aggregation.
> > > > > =

> > > > > I don't think we can do this. For GRO_HW devices re-aggregating=

> > > > > in SW is quite helpful, HW often runs out of contexts or times
> > > > > out too soon, generating skbs with 16kB..32kB of data, the SW
> > > > > can help bring it up to full TSO.
> > > =

> > > I'll try to explain this issue below.
> > > =

> > > > =

> > > > Also, after e751256486d0 ("net: gro: fix double aggregation of
> > > > flush-marked skbs"), it's not clear an another bug remains.
> > > > =

> > > > If it is: as said "nested GRO" of hw + sw GRO is intentional,
> > > > e.g.,
> > > > for BIG-TCP.
> > > > =

> > > > But it may not be anticipated for skb_gro_receive_list. One
> > > > option
> > > > would be to skip the fraglist GSO optimization for such packets.
> > > > =

> > > > First I'd like to understand better what exact bug remains.
> > > =

> > > I agree that re-aggregation is useful for improving GRO efficiency.=

> > > =

> > > However, as a general rule, a GSO skb must be segment back to the
> > > exact original packets stream. In tethering test,
> > > skb_segment_list()
> > > cannot correctly segment a nested GSO skb produced by this path.
> > =

> > So the specific issue is a driver that builds a regular (HW) GSO
> > packet followed by software GSO that uses fraglist?
> > =

> > Then I see three paths to fixing this
> > =

> > 1. decline to further apply SW GRO if skb is GSO and in fraglist mode=

> > 2. if in fraglist mode, further apply SW GRO, but do not use fraglist=

> > 3. in skb_segment_list detect this case and fall back onto
> >    skb_segment
> > =

> > We already apply option 3 to various cases where skb_segment_list
> > cannot handle complex use-cases of fraglist.
> > =

> > This patch chooses option 1, which is fine. Alternatively it could
> > fall through to the regular skb_gro_receive path below.
> > =

> =

> Thanks for the feedback.
>  =

> Patch (option 1) is a minimal fix for the reported issue.

And that would be sufficient.
  =

> For the other options, my initial thought is to handle this in
> tcp4_check_fraglist_gro()/tcp6_check_fraglist_gro(): if the netdev
> has both NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST enabled, do not set
> NAPI_GRO_CB(skb)->is_flist, so that this tethering/forwarding case
> can keep using SW GRO and fall through to the regular skb_gro_receive()=

> path instead of skb_gro_receive_list().

Yes, that sounds good. And then the above option 1 is not needed.

No HW-GRO implementation generates fraglist GRO packets, so the two
are fundamentally at odds anyway.

Ignoring the fraglist hint for HW-GRO skbs sounds good to me, thanks.
  =

> If that direction makes sense, I can work on it,
> or send a follow-up patch to fix the reported issue with option 1.
> =

> > > This issue can reproduce in the following scenario:
> > > 1.Driver submits a single TCP packet, P1. P1 is kept in the
> > > gro_list as the first packet.
> > > =

> > > 2. The driver submits a TCP GSO skb, P2. P2 has already aggregated
> > > multiple TCP packets by HW_GRO, and its non-linear data is stored
> > > in
> > > frags[].
> > > =

> > > 3. P1 and P2 match the GRO rules, and since there is no local
> > > socket,
> > > they are aggregated by skb_gro_receive_list(). The resulting skb,
> > > P3, has a frag_list entry that still contains frags[]:
> > > P3: [ Linear Data ] -> frag_list -> [ Linear Data ]
> > >                                     [ frag[1] ]
> > >                                     [ frag[2] ]
> > >                                     ...
> > > =

> > > 4. Later, tcp4_gso_segment() or tcp6_gso_segment() calls
> > > skb_segment_list() to segment P3. However, skb_segment_list() only
> > > segments the entries in frag_list. It does not segment the frags[]
> > > inside P2, so P3 is not restored to the original packets, which
> > > leads
> > > to IP fragmentation or packet drop in the following path.
> > > =

> > > The patch only prevents that nested case before
> > > skb_gro_receive_list()
> > > aggregation. It does not affect packets that are re-aggregated by
> > > skb_gro_receive().
> > =

> > Thanks for the detailed explanation.
> > =

> > =

> =



