Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B63839A9
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709849; cv=pass; b=m01TISGPZCr6++fYVT9ItPK4PniqwhQbz9UVzM9RUgMgQR+o2R7FQcjTYouFuydcS3AXPZ2Niz2hjsvUvKr6asegzDQH19ysiBCUchyA7b6HXdOOqKXh+MSboWtoFa6GV/utfY7fhoNyQ8ed0Dbh5JfuxZ6LBljiWNNaUxrmD0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709849; c=relaxed/simple;
	bh=Mvrna4jvxkFVgS1b64bAUhxq+n8ulTPOweBBUkKg7uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTbxtftTQqeE2u6nnrZUTb2vCGe1Fe/gidKc5vaS3qE290t4X+iP5dLZkmnHwp+LeVPA9Q0vlLUaNz6e88aJu7J72B6uEpvE/dQzByli5/uiHYr9zqNRNn8Kma2AZ3yS2zC2Y2WbWao4EguQgsg5+a+23F9A7fsI8fZCOE5896w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiwRBBFN; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiwRBBFN"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-853e2610bb4so925660b3a.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789709848; cv=none;
        d=google.com; s=arc-20260327;
        b=X59iAyjYgfiOAlVLg2zUpBqJpp/dJZcfS4RYReDPb6DdxuDLds0h9gDl/gxcU532cl
         11+yeDNeRO4XD6l/yiAn9gqrNWzDpEtkvAHE/FfzCAO/sQnapbT0HuRV4JFihShi6E85
         Mj/A6akUoSGa0zomb/+3SKssUI6/MRole1w3wx8EaUzLcj1SwkxXGhIQb9VGU1eKfi9N
         XJn03emmTYHY4pmgJv4GiaNXF/vtPBwft5gsirl7BP47Kb19yFFYB+tN/gZ71C2BdS4c
         gf/zP2DPeNyy0V1GR50lD049AtniGfgBqXHdHI2pXj0wYJBS31QdkHj/P+odYQ6PxSK3
         03Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jEMZq46+kEkOwx/obMONIAwhlN1wF5UDPG1BZpx3PqU=;
        fh=PvCJjGnTDwQqIe7H6F6QzAukBXvNMERTec5mOyz7dao=;
        b=kTVVcyUjCyiueY/ZPMmmIG/TooUI5TjqbEFr2/C2LfE/OkyuBnyghPU5imQXZLaf28
         /AVB/VNcypOejfSrW98c0XJq0m1yloJt7giwlelmThzQ1jPWtmDvHq6FdE+CoVGW02Io
         sK3IREN0/vwwfPiyHVKDHBFbCsVZ2ALy9XoJhPOTEbR2IXQmiaezuLVgJ5gOH41lXySr
         Rzf5mGdGH9uqqlaM5oIecBHup+rTx5AZgbQVKLAeOxkqqJBeh8/H9OpymLAhuWHkumPf
         0d29LQ9SJEEIPD/X2Q/gF8Hni6XdbdUlbhSCL5xMtXItsI0D9RJIw3xCuVYNwK9Xw+b/
         7JgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709848; x=1790314648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jEMZq46+kEkOwx/obMONIAwhlN1wF5UDPG1BZpx3PqU=;
        b=DiwRBBFNK4YOXB2DOfqWr0onpPWqYHSoc4nRj9CHk2riON8FT4AfOx3It1kERuAskk
         +1bA1EXypi1e3m29pPSg86kqZhfuBvo2N25/r7VJk+GtTMNzLvOXvrx4Ki6XLnCmpOEJ
         iMk68JQSleLguihObSVWAe5ZxcmyUss3K9Xje3DdjiZqemHliyPWoaHl6f2f7KpWLtsj
         LBE53FOHaNaiIR3kn1AokAIqtc9tlsN+qCYloMmgNl/51Kl+0WTGr6Xmc122waQ1XaDy
         ioF9J0N/kGmw8XMk56+wp0M06Hb+O/E7mn36LwwPWPQBZ3JOlnD0b0blEWnXpGhatM3P
         bQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709848; x=1790314648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEMZq46+kEkOwx/obMONIAwhlN1wF5UDPG1BZpx3PqU=;
        b=goTwclkx0TYzT1ed5k1gMhDLUgyJ6CILyGfQ6BSSArclnbfs5agKGEhWECqCQ7NbOC
         Un/TBIltuFxeuuC7awzSL9CZeKuXX2wGWe1SOqXnIj5MiFE9eaZ5kSiceLXjzQyPheIN
         zyTgATZgNYixeWeRnBj4F/sxyuNDht+wGADKUduynkNnWzZ4DsRQ7HYvwVO0R/HzbKh0
         XEyldKykRNhv+B4S8LSnnx/fV/f5PWNcS68LEsp1ZUg39BIo+UdRi81TNuQMLbgTDaYt
         1j5192CSrdPrnK5dfCFeCQbwaUcNvnpsc8ZmzeKOEOrZ6GZLUf489baVFS83Knvw3408
         vgPg==
X-Forwarded-Encrypted: i=1; AKwUvBwI4/Cf4BB4no4HJRAcszllDwRamY6HoFQpHvgOqTYB3DMQgnT3BKN8P6kXGteCzN055som/0o=@vger.kernel.org
X-Gm-Message-State: AFuF++lyWYCpzvdtFQwD04yqybMd+7V2TGpSJl5iKWparjMz8yrSFsVC
	kKKf63wUwD5skoPd2FeWLxkinq3sNstQfxicuFtc1u3Uhyfd2mp+9+X10HYOnArvAFagUrJQX5G
	pddgNusQnbDBeqZIjaaqUp0irvugtUPQ=
X-Gm-Gg: AYBFou0+e9bPI4zr8Mq/tpJ4EqDoUUqDmDsTFnNHyBQkOelupNgl/JmvJ5rTJ4I0LEZ
	YnnqG4GA+ryMn0aGEGKTq1+MsI70DN795oTEVWzKoI1yon1aPj8DWVTIvBPvqY0oAjA45NC4jvF
	kwAT0jVBCapU02AuZKo4xwr+SurPP5qlM1e7Qyq/L6DoyvkB0VdeyUVa7Dqn0/BJCrvGWtpTfo2
	nlyjoNhvd24sDIUsbyHsMOaNT48PA+jQzAtgrwurzJAvMN91yw6pJYHeL6TIJN+2M6PyZPW0QKl
	hzVAhiiTVqRwHG3+wMoYFEPbx6iISPeGdMgY1FuvzLDlOSR4hKamvbLYkh9yELp0k6uaoRfHBVe
	dUNT/hojQqH+oo2Sq6WlHFwkBbjdANF0yWVSXBUKRrgbaTg==
X-Received: by 2002:a05:6a20:9192:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3dd726822e4mr8491471637.19.1789709847642; Thu, 17 Sep 2026
 22:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com> <20260917120801.GA51261@horms.kernel.org>
In-Reply-To: <20260917120801.GA51261@horms.kernel.org>
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Date: Fri, 18 Sep 2026 07:37:16 +0200
X-Gm-Features: AcwNN1XuOOFlVfui2KqsTshS0VrgY9RyzdlgQl-KYZ1_KJDbJwuAG01QqdpO8CE
Message-ID: <CAKYWH0RMJ+sxMku8UGmmcujnO9fJBg3Ok_ofbvyh5eTJm=2uTQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix manual hash table handle
 IDR aliasing
To: Simon Horman <horms@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Victor Nogueira <victor@mojatatu.com>, 
	hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 17 sept. 2026 =C3=A0 14:08, Simon Horman <horms@kernel.org> a =C3=
=A9crit :
>
> On Wed, Sep 16, 2026 at 06:01:14AM -0400, Jamal Hadi Salim wrote:
> > A u32 hash table created with an explicit handle ('tc filter add ...
> > handle 801: u32 divisor N') keys its IDR entry on the raw handle, while
> > the destroy paths free it under handle2id(handle). The two key domains
> > disagree for handles in the 0x800..0xFFF htid range:
> > handle2id() folds them back into the auto-allocated id space (1..0x7FF)=
.
> >
> > A manual table therefore leaves its raw-keyed IDR entry unreachable on
> > delete (a permanent leak), and its delete can drop the idr entry of an
> > unrelated live auto table. A later auto allocation can then hand out a
> > handle that aliases the live manual table; u32_lookup_ht() first-match
> > routes lookups and TCA_U32_LINK for that htid to the wrong table.
> >
> > Key the divisor-path alloc on handle2id(handle) so allocation and
> > removal share one key domain. A manual handle that maps onto an id
> > already in use is rejected with -ENOSPC, and auto allocation skips ids
> > held by live manual tables.
> >
> > Conditions to recreate:
> >   ip link add test0 type dummy
> >   tc qdisc add dev test0 clsact
> >   tc filter add dev test0 ingress protocol ip pref 1 \
> >           handle 801: u32 divisor 16
> >   tc filter add dev test0 ingress protocol ip pref 2 u32 divisor 16
> >   tc -d filter show dev test0 ingress | grep 'fh 801:'
> >   # unpatched: two live tables with handle 0x80100000 (the pref 2 root
> >   # hnode is auto-allocated id 1); patched: the auto hnode takes id 2.
> >
> > Also tested with a poc with a live u32 table on the block, add/delete a=
 manual
> > table 'handle 901: u32 divisor 1' twice; unpatched, the re-add fails wi=
th
> > -ENOSPC because the raw key leaked on the first delete.
> >
> > Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic failure=
 to free IDR entries for hnodes.")
> > Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260822222049.114526-1-jhs@moja=
tatu.com
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Tested-by: hybris <hybris@mojatatu.ai>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>

Hi Jamal, Simon,

Thanks a lot for the fix.
One nit I'd like to pick is the "Fixes:" header.
Specifically, it mentions my patch:

     Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic
failure to free IDR entries for hnodes.")

However, what this does fix is *not* a regression introduced by the
above patch, but an age-old inconsistency between handle encodings.
So, It would be more accurate to mention an earlier commit:

    Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter handles=
")

What do you think ?

-Alex
