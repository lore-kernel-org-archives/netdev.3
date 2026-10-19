Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792443935;
	b=dGZUbcc147DW+9PHaQpmfbCgYPhQjYzdu7gmuCnjCAYM7ANLhyez7iz+QPoZ/+U4ODRj
	 We5oLLadi8NXekibuPhKX024nPdLn/1BkW2dSZW9daKF1RloWPce0GmR+9NJEjc+KDVEJ
	 Turlwoof5YQmcGJr+Gvgz+5MCIEwCzj/KutjU3d2nPW+zMRv1pi9m5XYuLs31FqBPMLmK
	 45uuPR0czrhhCFjBfcqkPD14DBl2BLvjmDw8sVhN8C1s0bTNWi/1Qv5AV4rDSBPRd6zIk
	 QQ3WydaVldFcxhYzee2p9i5NMEITILhjzBEtRXPKtxf/76xNtHOWqbFhSgeMreUwg1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+3Z+Jqh03P6wtlS3IA1RNnZq+SVbTEAx87ffjwIp0hQ=;
	b=LTIWA2qE16+J2kckZ5KY2+Dp6rUqHrsZjCAqUM1DCMhHLEZ/BZXRl+DVjxfcrhXBUFGO
	 cfWPlDpuqVWYUeOE/6EkfuS3cl838+FclIoWJFeE9uBce3JOBY+C0jWJqaYUwhGUdyykr
	 5Ux8X5vm/isdy6wxNYy1p7WA8Goey/EjeoRD1XENCn5nkDvKCYpND8UPdkiYb3C/mqiv9
	 oAZpg14+41Aguvwh6LPmDVRihWC/efr9FglkdNNB+wY3kJNPTcRA0qfhyZzHbB3UfUZq3
	 dbawY4jP3RzqXd836dwuBH03yaxZtRyzajcOn1107S+E1ObRmK7HoUlVZzWF9+QAeTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KsqGtIXT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59465606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59465606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KsqGtIXT
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89d6bd67045so40720b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792443934; cv=none;
        d=google.com; s=arc-20260327;
        b=U3eH1zi57jRbY8+u1Y/cv2f+KNEvdx4pmj6GSbRIpLssJudGyp/AMQTiSRtdF0LYSB
         RURfBOcU+z9bZCUyHAOG/Hlbu03nkHtXil8foneXo5fBitQamQQneSKhC0AYNynXi8VK
         XK6BO9P1uhHcxhbPYyoT6vYXtzYPGjA0L2/ke4KtNoMeY5/tJ0rqEeLpAGpL7fhnR7co
         8okzm6cDQ0jcDNlBq7fS+9slbXkxAyV7OaIhuC+B00vKCp0Cg3NWfjqPvZPGhxRC9nkb
         GDQdQHEMEZ3ae0GzNIVtN3bCkDmMLzodjhNN9nrUjr4no6gWlksD0M3U2e4OiHcQZLS8
         G7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3Z+Jqh03P6wtlS3IA1RNnZq+SVbTEAx87ffjwIp0hQ=;
        fh=xmp1vX2ksVRtN/ju6J6bqhuSKfOgjk3q1XA6KuGu+8E=;
        b=q58FV+qQwK+sg0Y7n/vtQ6DIB1zhUdoKJhjAYEUhXsboqIoDTV5VoN79v9Zz5Ye7C8
         xMvZM4LRBClV5FPPpyZkhR5R+C2H8kmQuNxuDit/6CqeCMvW4Ic6dcdXL9VroU+GrHM/
         iYgISMdQzUrPLyw9MNq0MiZ1uuW8WDZbi+WTVLdx4K9U0txxuMhPbGzeMLpr4DFz2ii/
         6YzeDExsIwqM29lI55esPQJiMEaDubbgjQYtzD/tIvSAr98aE4bhvgqo6UaZna3zacN8
         wCwwLETzXYHlqUIZ1kyIrmJY5lpcwc6p7qLFCdAyXRQVTOaVLGw68aV18sCPz/2R9CCr
         L7nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792443934; x=1793048734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3Z+Jqh03P6wtlS3IA1RNnZq+SVbTEAx87ffjwIp0hQ=;
        b=KsqGtIXTwPkNQrz4xrjlzrEAFzoXxVoD0UqXvNS+14rOZAf8mJ6k6/phiWEx2+Cm5L
         DsZEPgcvBQ0qG7i5dXP27f8/gz/MS1EqpjqvZzIS//Lj1sXvw3IhlYMUVglq/nqzDSE1
         bjutsr0Lsm0+bM+pGJ4lzENKx1hFXGQZB6RfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443934; x=1793048734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3Z+Jqh03P6wtlS3IA1RNnZq+SVbTEAx87ffjwIp0hQ=;
        b=0nlTu6lnqUvHFStrSgTG/aRd0gvi5I8sFEdTpUcKPlUKV9oZeYUln/4191Bat3x0R1
         hTDwxvHv8Zzxzq0oBJXP1ptKG6p7AsGOY7qfWIkRsQbIKLIZ4nVJ2EYhiDzWYHhVqEdc
         rr7VaZ2jZPQa/LRcCslg/jTdko5ts94dIticEtVE3DUQAaf3DoQYMoNjIugM0MsFXxJc
         0I6wf2BNA1KfumUBtAKrzkSK3A4CptbpJm2xb3AKv7rpa6wYeDYzbzO48375IMIRoY58
         ArOeb4mJCtvRVmCH1QKBlbNRfMZQqkAF36FF4hIDtNgZdnxHOhVmkRmnzOWD33eqAtB4
         0ZEg==
X-Gm-Message-State: AFq9FYKi801vn/SUUcP+6SAO0Z19JTTP0Yerciy+3RwjtwI9s7W2pman
	LUyu5U2wwoGC0hPN3ftN2MNAMag6c1ReswtAka6wL430WSFLDXJ9zSY6p606BOqmTpf8lBOpspP
	ANZlWTfAOjWX/QauRaWQNNMhBfJjYTmDbVy0vlFlL
X-Gm-Gg: AYBFou2KxnKobnOeGR/U4i6znmkVZ8i8qz0xVajxtnf9Jl0acHMoB7Yrsyhuq+kl4C/
	AV4cAZQDIAkalDfuaZBExGsPZ68JT/ZPQrwg2r0GBd7Bbab4JjINkl2dMbEQD0/S9m+xchNMH3T
	k4QcMFV0b/PoVEwNRvoaUhfeuFM9xT4OC+PIt8dczTFfwLCsj0CS6s2i+Iq0ROo6pilAi0vNJWI
	7+sKdUqupmt1j9GsE60t8hvC5zEBveBYxj5qDq/KQmjmrBtIt9SGivg731fsGd8npOksz16hoJR
	yZOMfIJjSs8Ya5pEB5jWNaQI0raKBA3hjdlWK/Z6ddDjFc3vWGfpefDKzD1aZgPvorZmO/0nKUf
	iFGyeov+EUvFCg/PsNeHct+2xuUjKphockdoJINqfD/HhpLWF6Os6IzFMWXwhqU7Y4Z+4hXh/7i
	7lOQQXZGevdYtCOYw=
X-Received: by 2002:a05:6a00:13a4:b0:8a0:5b29:269c with SMTP id
 d2e1a72fcca58-8a07bfe865fmr176294b3a.13.1792443934445; Mon, 19 Oct 2026
 14:05:34 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com> <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com>
 <87wlrdwof7.fsf@toke.dk>
In-Reply-To: <87wlrdwof7.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 19 Oct 2026 17:05:22 -0400
X-Gm-Features: AclHuK80iIG0o50u8QTvZF7FmPTPFC2S1ybNJm9DexdEPm7FgzHZm7k39rVhfOo
Message-ID: <CAM0EoM=6joWtYQdkw0KheH0sEx0r1P7_+6aEt3235OQZSxD9Mg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] net/sched: cake, fq_codel: return the
 classifier result to the caller
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:11=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > The Fix:
> > cake and fq_codel run an optional external classifier from their enqueu=
e
> > path and then compute the flow hash inside the helper. Have the helper
> > return the filter's overrides (cake) or a 1-based flow index or a reque=
st
> > to hash (fq_codel) instead, so the caller owns the flow selection.
> >
> > This is preparation for the accounting changes that follow. Packet
> > classification and flow selection are unchanged.
>
> It's not clear to me why this change is needed at all for fq_codel?
> fq_codel_hash just does a reciprocal_scale() of the skb hash, it doesn't
> mutate any qdisc state. So why can't fq_codel_classify not just stay as
> it is?

It is not functionaly needed for fq_codel, it is more because these
two are cousins and simplifies subsequent patches.
Note in patch 4 we force the same semantics on cake as in fq_codel
(classifier decides the drop, the caller owns flow selection). Keeping
fq_codel's classify the same makes patch 3 hunks in the two files
similar. There is another reason: the old helper encoded "drop" as a
magic return and carried the 1-based +1 arithmetic on every return
path.
In any case, unless you feel strongly i would rather keep it.

cheers,
jamal
