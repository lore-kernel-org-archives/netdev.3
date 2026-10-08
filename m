Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126C4657FD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473032; cv=none; b=D4B9uycYYIick6BtsjQHbfCA77PUDoqH1yMSaqmkjTeXngwRERE5Uk5/iwNlArcRNsheGPi0C29Ic8OFo0iNe13giTLtgpHobt6PSFEGC4WX84+aCrwdQxfO8+eI+Tyi7Q6vyIN6b8vyEdThatrU6S99lEfWtClHSA2p9CkAUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473032; c=relaxed/simple;
	bh=HFpZNzJ7hMF7uOeDE/y2phCur9YgPkP3RKc91yp0O2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXR0SbcGMtooEceauQt7ud4DmJwtMxLsNK12ZwgBSt0O6JiYwKb8zNu/5pdK7aOUUnz8WPEDnh0p3Sz32IlBnbW7liHK3qeiFyDaTIjy4OzguhkfKCISSvE7fVu4FybuHlvQbMtnPJT55O+BWAw6GkE4sfFDvyxbmNnFcYov3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=R3CY8/+X; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="R3CY8/+X"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso2857158a91.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791473029; x=1792077829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HFpZNzJ7hMF7uOeDE/y2phCur9YgPkP3RKc91yp0O2I=;
        b=R3CY8/+Xr07v2SXfBCz5icBQ+Ebn8CSkfpO+iAQ/ZEp2XNjW/M5OG2lBLfInkJsIz9
         G06RLoFu2xsNc+4MvPTFgGIs/nuPosBENh70cARU8JNG+vaAiwRxjszXiD/rxc0PdU5L
         07W38jXEN/tP+ARZ+fHn2pfMQVdqEQPD1HuvHQmpBOlozGoO+3soI6yia/vMsQDYb1eq
         uyn9gFlxXQrnqlehuldgq9hFeZ4EH8/vdps1h/r6swzTKhzf1eBk07mJX8xFbH/ZgUYe
         y3n/wzpfMdok/lO+FbrXjevSVrWn1LfVCaXOceLpm3Rm81Qcb//ZbhC8BeYUgn30iAk7
         z9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473029; x=1792077829;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HFpZNzJ7hMF7uOeDE/y2phCur9YgPkP3RKc91yp0O2I=;
        b=pyJ9uQ9xrG/Jq5pb9jbDyGNP2IGypAwiaWIRfdsfaG/RGXjjxp0QKuOWVug2Vunvlz
         QRCKBzuVroWAz+2nXyc1ZBJXOig6emuPNOnq/unS5KGWMRu5ZUiPaUrrd6EmeSOGrtW8
         p6z1SQ5k3BaA+a+kj1WRIqTueTAsbR/kiE1XULQXjhl7JVPfuZNemtxLXpyoHCzRZ0jw
         RhYZh/zipptYX2ZgTz7hPtpsT1hUn5nt2Wqb9WcuiftrTYwJh7Sdk3+iNAqwkFdLJeiM
         BTNFnXb9mZUUgOPr0RxkgCSBKt0Y5PLetIDtEyLKjv4L1SxXz7EwUuwkVX+rIMOyUGWb
         TTNg==
X-Forwarded-Encrypted: i=1; AKwUvBwih1w2uobkFv8FXL3hyM9DqUbBLO6pLomPUG6pZ7cTag85ZieHC8exkziOsBpYICfTdD3oFhY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvEQLpAhbK/Yzvew+E6GdXdJm7TygfD1L17Y3apJ+oXiKrL5ya
	yKzjbPclrcg2cooVIiCv9R6WH7UPQuPCvlPym7B886n4IrnRNPBPoivwKqAiFI6/swY=
X-Gm-Gg: AYBFou2xnvQVcw0bdtsOOmQvqcdeLfl64Kehdbu+WKERuzO4GtHrN47rvuhTMja8tPS
	qE2dc8btr2NCC45wNTrrgGG2shZfhBwCLhMaa27Wzqu3sq6wJAvEbkBnhbyYyWN5evP5U5byJT8
	c3i4H6i4A0H+VSrhB/chLoLv9/2gyR44PdlzRu1OZ3YbHKuogYAHaihP9lHoKtc4WBmb8GvGLOD
	cKTeKlZ40uOODvvl8Pbdz7oXRFO4feM224QNwweg4tJAAAO45lqonyl8gsjK3Ri9dibKsx9+pC8
	Datk7hF6bpwuocE7SMpuh5n4N8pEnMtqIMQq/5Uz7yDU00khx5eJ+ZzqIKFw/P0Dixst3pJDbSY
	yaSyaLPXO9vk62qD1Le5Bw5q/y7d1XzLpd0SZ2r5XKYCQivSNl2zHOqtHUBzm/AAZNje9uDX/qr
	nR82p6LLQA6C0QX6PryI6hiuHnefm48knNa+920X6s3PwnqLAf8ZyJ8Hd6egR6tqp4OqXilbjwm
	XK9fK2YAzZCeM4pBNVS5qK3WFFMh8qqA9rZDVZv
X-Received: by 2002:a17:90b:5486:b0:3a4:9c30:425 with SMTP id 98e67ed59e1d1-3a8a117a9e4mr4971001a91.44.1791473029071;
        Thu, 08 Oct 2026 08:23:49 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1a2d9aasm4520225a91.4.2026.10.08.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:23:48 -0700 (PDT)
Date: Thu, 8 Oct 2026 08:23:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, moeller0@gmx.de, cake@lists.bufferbloat.net, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v5] net/sched: cap the accounted backlog before
 it can wrap
Message-ID: <20261008082345.5e16ca44@phoenix.local>
In-Reply-To: <87pkxks68f.fsf@toke.dk>
References: <QDISC-BA27.v5.20261007171509@mojatatu.com>
	<87a4oottcj.fsf@toke.dk>
	<CAM0EoMmYEr4DLrjuM5hdPR5Lf1c=mU6WNpYydbzkGnWjqFxMrw@mail.gmail.com>
	<87pkxks68f.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Oct 2026 14:54:08 +0200
Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> wrote:

> >> =20
> >> > +/* Compute the flow/host hash keys from the packet as received. Mus=
t run
> >> > + * before skb_gso_segment(), which rewrites an encapsulated GSO pac=
ket's
> >> > + * headers to the inner ones and would change the keys. Reads only =
the skb
> >> > + * and commits no qdisc state, so it may run before admission is kn=
own.
> >> > + */ =20
> >>
> >> And drop the weird LLM comments, please. If you split the series
> >> properly they are not needed.
> >> =20
> >
> > Like I said, it's a dilemma. =20
>=20
> See above.

As heavy LLM user, I often have to tell it.
"Thats good, now rewrite the commit and comments for humans. Make the result
 conform to the style of other places in the same code"
