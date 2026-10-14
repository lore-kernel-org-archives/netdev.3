Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065751D51F
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985159; cv=pass; b=DNuYpgTO4lTxFI7dMnC3eVSQJT2wETiMJEN+bvyVyP0LFC0b2RBafvr7KP2XUlBfacLjs0JJXZ3CKxI2BBIVPgIBc07sWDsdeizZ5YRFQtMN+9QInQ7LjAkYKw1m6WfoBMyREr6LAw+ZUlwtv3yLAB7PL6dRLJ992IzCD266DDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985159; c=relaxed/simple;
	bh=Do9GJSHJpFcW9ngUtQfrvC4whS6LlUvXOjfDqOxXyQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZzc9R6551Q5urIibaZZ2NbKtWWHY9cF2yZ7YlsETk3oFEP4ASnhbQ4pFgDb2JXEzgOx231B8VUQwRp+mgKmKTTDT5i8rTR7ofmBIfPC8NIO+Vp+4HpOY7qM948oRMzqCSlcGHKxhdPQLQTY4U2hXYpv5AnVMWv4EwsXFNUX9zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Okg5AC82; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Okg5AC82"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so724246a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791985157; cv=none;
        d=google.com; s=arc-20260327;
        b=tDYqgBWe6NP9Mp4Y/0rDG0VuaHbLoc0Kuu0A1MaeQSZi1S8oPNB5PVxsvwnjqcrJkh
         HjPWwIXgg1jJOQWZR+COLi2Ko6tA6ON+XOeqFCADUBw3ibI0VGDiyyxjxTEXFHvRla2F
         fpEVhZBPU5lCGWUdeehkk3EG1h9aKrJ2qKJWI8JF0mlBIYkOL535UALtlawwHgiTbLGh
         ACuc0STxfJJcCesIUH3qvH7SKf+STmKFeudjtPu4YuSFPt8uI54mJ6evoqa2MtzDXmNx
         jo0Y4wneQn+y8cClOShIZh3zB1gquW4oGUDGwh8vK4SnjFnjMEcBrnfBTb1V1Z+r6muc
         beFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8jbQ8jR2CLMXltfdllAESeZcdCWDCj/wLLhk4ndzVs=;
        fh=L/mW3demSFQjeGpAHaKGR00p0oVE6TEUUqBUvOHfDJc=;
        b=EZQSgEtUfgk0vokYrItMgyUT7LlSZv7iVkhROC0Jl4Rw8kXoTaxwXe42MXuBD88p+O
         7gTZix3egdTSnQPjtsY8/7GTfLqzpFjiNQSFO1kdw/Qit0nI22M/cCiEfpFpnh+Vq7rz
         90r5ZE4cLqcPQZuhixtEhORzi+8KiOvHWZ+dAxw3vUbMOp40MI0cdR1Gz6sZS7Zc8PVS
         TNylodC7Al1zilASnXu3J8fWa77zl7Jpba6Uap9Q0hyKT6J5G8oCQPzGtmOXoJSiRROa
         eHk8Q8a2tDAvGduoNPSsl3ETM/2evosn0+g6W6/h5Qnm/l0qHKbOoxb2fqnUHJ1oTzFj
         tN/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791985157; x=1792589957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8jbQ8jR2CLMXltfdllAESeZcdCWDCj/wLLhk4ndzVs=;
        b=Okg5AC82e4NFZFA9coJWwxesOOIKLy7WqvIK8cn4z97zP34unYpGqaZIwtMVN/rbE3
         WgmYdIJ4CVTw0LqPWNLsNT2ZtePV+0EMFvGpUK554+6V0/OKY8Sq3oLm/sPGr3Knwpcf
         WnSFDvwLjO7COUd2u6QwkAABKpC510CKEf08c+42LomJJuUKBx7ZpXwCgy8gPbS3pDd4
         YHNTumUyxNXOAzhG74DFAf82tWMXJhgKp7zjK/oQfS8c50XiO1y3I4Ln8WTAWFCjCrH8
         YgDwjRU31NvsHT5Od6vglOYQBLnjkoSnzl8pqUTRtPx2PUSPKFiwIadEp6bIkL4fOxBy
         kHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985157; x=1792589957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8jbQ8jR2CLMXltfdllAESeZcdCWDCj/wLLhk4ndzVs=;
        b=XmHjK0vUwo3Us4JWXYn7xPKPT9cqfOQI2rgSUEhX8cTNg7TWC8GFhjofQ5L01t7+6U
         sTU/tRwLasKkVeo12LbhHB1CKv7M9zfjqJXpDQT6MYC9f7YEhSmSBZ/Ts5BcADoRyUVX
         RrT4CvhOyBqr0hpdKYlpvgTI8jW013CHVApi//HympfhG9Q2SOXjZ2LRMVTy3a5i/SDQ
         QPHT38V0BdaLzvHo0gQn7J52Vc9s45Rb4wHva+gk8/mn1xYNTvQhxI4vku2ZmF1rxum6
         Dun9nT2Ao19bJf0fY/zinXPd6RV62i3S4iT2KDofJd1kjP7BCoIcYgC6R/jCQqmyQPAY
         Hq7Q==
X-Forwarded-Encrypted: i=1; AKwUvBx4fWh8JVnSoIJnoxO0N8ntmD4Po2OTXrW2wXkBPQKrAS9ETikvuEF4PzZ1WYi32U3GHO4H+Jc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPjWQIUXbWXsr1l5bZ6+BgXBIxftLDxnnKg0mLG9ILw7Nj1H4E
	I+3hNl5NqDaOWm6w2dZ4YEwX/9MbMaT6Gym9tU0qi5N5MPWKBhKrvAjiE0X/2qTiYmYvi5PBZgr
	MbDcNNt9kofTevpUhAxz0IbDq1ArXNd+HNmr2sEiOfsFsnhc+SpQy1h2J
X-Gm-Gg: AYBFou11vRWN6n/pIelDxcy0aT9wl3rrJ2NEqrwL8fScK1jjyu52l9sxEWIObMWE82F
	qBEfnOQ2d5/JGxy/eTLueIZAuNQc0xkVaaF+3nwmzW2kV/KMEWgigZoy6PKrN8+NCG5HmpJNpQV
	9ben50AHTNfqOVK8IQOBf5NkbZyarL2CfrSUXiM5gg1okf2GgndziL0UZo3sE9Gr9ekiO5QklQ4
	147Rl8nR4m9i3awrbqPwNFb1r/qrg6HAVa+g4YcPsnEC4eDFDiL8prl1erGJwojHq43HJZYHjxl
	1AfVGGrR5ZtKFwn77QdBnGma5S3JUptz0GB0kR/mpL6u+fL+re+1/IwV9ozX2coZFZsX83eVjTa
	ckEBrw7m/nU4=
X-Received: by 2002:a05:6a21:3a93:b0:3de:4662:16f3 with SMTP id
 adf61e73a8af0-3e16bed388emr12712043637.50.1791985154402; Wed, 14 Oct 2026
 06:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179138670045.80227.16292613517250896744@gmail.com> <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
In-Reply-To: <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Oct 2026 09:39:02 -0400
X-Gm-Features: AclHuK8AkUpNImhF-LHJr3XzRnL-uuVSv_ZOVg-oORi05OKdAiHssAdOH-8pRvA
Message-ID: <CAHC9VhT5w3K1MvmP=1Mxf6KKWZD5BbK14bVHJGYFN93080j5jg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: update payload_len when removing the CALIPSO option
To: Eric Dumazet <edumazet@kernel.org>, Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alice Mikityanska <alice.kernel@fastmail.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:45=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
> Le mer. 7 oct. 2026 =C3=A0 17:26, Joas Antonio dos Santos
> <joasantonio108@gmail.com> a =C3=A9crit :
> >
> > calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
> > extension header, or the whole extension header if CALIPSO is its only
> > option, and pulls the skb by the removed length.  It never updates
> > ipv6hdr->payload_len, so after a successful removal the header still
> > claims the original length.
> >
> > calipso_skbuff_setattr() already adjusts payload_len by the length it
> > adds; the delete path was missed.
> >
> > This is reached on the forward path when a packet carrying CALIPSO is
> > sent to a destination mapped to an unlabeled NetLabel domain.  The
> > forwarded packet then has a payload_len larger than its real payload
> > by the removed length (8 to 264 bytes), and the receiver drops it as
> > truncated.
> >
> > Adjust payload_len after the header is moved.
> >
> > Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff direct=
ly.")
> > Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> > Assisted-by: Claude:claude-opus-5-5
> > ---
> > Found by code review.  Compile-tested only (arm64, W=3D1); not runtime-=
tested.
>
> The analysis looks right to me, but this means removing the label on
> the forward path has been broken since 2016 for every packet that is
> not resegmented later (SYN, UDP, ICMPv6...).

I'm going to follow-up with a review on the v2 posting but I just
wanted to add a quick comment that while basic CALIPSO labeling is
tested via an automated test job, this particular code path is not
part of the automated testing.  Improvements to the tests are always
welcome.

https://github.com/SELinuxProject/selinux-testsuite
https://github.com/SELinuxProject/selinux-testsuite/tree/main/tests/inet_so=
cket

--=20
paul-moore.com
