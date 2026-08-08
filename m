Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CDA31E837
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786153269; cv=pass; b=AEVGxfN+SXhZYcrViAQM8EUjgKrN4BHkLWHY8b30RK96jNfQA3a7WOkKThuy80hShvUCTboujKHCz/hV39rjGMAec0cIpoCLIaKP8TvJspoJ2B9s+4l80ked1zQzeZiUpXiVGaixPZTO0iHm1EnYT1Til7l6rO8HtuWxQfYtJYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786153269; c=relaxed/simple;
	bh=J6v6peq2pcAz4ZTnsFALAfBpXXwe0QNWMxVmWduDSlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l559rDE+ZxToXMPaRe9eeS2s0QY4rkLopIJDpcgLq7LdAr/WVqTDM0EbwjhsHfRCcJ9/NE0RkwuPVmcsN8CizqHW8jTYJJMIpubqO3ffCTQJZyqAJ3VBY2fUkTyn10uxByPYiRxdenkrXVG+o455tr3sL/9MgZM9MPw5RyMwa44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9rnqsxr; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9rnqsxr"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so112883a91.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 18:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786153268; cv=none;
        d=google.com; s=arc-20260327;
        b=Ja/sZsZchhiBOE2lv3kQTZZF5ks//aN0BEEmUxkUlZjnbvcIEYfTjUjjd44PxX8sMa
         H1ngz4xhLHezlIVpWo831xko3Fda0esYSeVL2iNXy3C2y6+OnlZ0b3d8UVPj+BIztgs0
         9sgLX8Cw0rd3WtEgjzH6Hwzirrppus89/r9lKltOEvwkQ1WktPH/7HMCdsOtPkFecW8K
         bq4bgxZVM44j0a+BMooShmL9JPgdn0U92kmEzkoT0YkPvac3o4l4PxltTWPTRGJeboTB
         SxIx/X7q9QQGvEjQyuHiciz5dD3rcpFdnLswb5Nht8iSDHanvgYK8cWRCboT1N9WeVCC
         RaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K33TW3QT82O6/MHuB/paGse9ECFvxfuZooBXxXgxnaI=;
        fh=JmGpHUwFQSvqEk8506ax+r3Erjp00V9ivQL3nD+Clo0=;
        b=A8pHEcKlcqa3gmUZN9O6Gb8gBXK6ZJwHOiXFuUTQCf+NkpchkpsQwsEn6qJ8vC42Dh
         ecS38bJCp+cQM/Ai26povKA39wCO1LqNrAUkIykM1/MTRPCZGlMZYbZGcM316EDSohmK
         F8vM3fVFAaLlUXa+xQ8FNlI01mS6hPLCIx1bhmOPcxy2HoAz9lN89A1CUj1NOyh3mL8g
         GR+Dts+q5G4aBY80ZXHClN4edkm4qO8rqSqCWYdxdVr50WkF2kS6ZJwYiI1tDZzhySNF
         vld41BxvDNEfHGw9TJ91EJvMhZwFSWD9hR5yVVg+xCEacYC1dk6/yInd3YhEsbm+qmqD
         /Djg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786153268; x=1786758068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K33TW3QT82O6/MHuB/paGse9ECFvxfuZooBXxXgxnaI=;
        b=S9rnqsxrUk8/+6bAJuHNSzw/5VgLOhzwV9SWzeIuA7gTYfwvWbUPyDCoLzNM1jlqlf
         M3HWi4fYCJ8f/0MG2n06Hy0CmZ7RVE7JoV6XXjg16SJhBe3I2pL60fy4fj4bMaV1KvIN
         HgwbMaAR0MaTvG0Jf7EAAz0mXKfyqkB853A8ob1SPJXcIAn0qwWCUI60ZKqX3WqE0RTP
         qtS5Yr97zwwz39HewRekrHKSfySOr672krX5TtZ9W/S8Pwl4rgQRNtnhasjuR+/NPqKq
         Oxha5gdeh0eeicKrQedsD1xgmP8D+EsN+NbzcKYxek2qKjWa+d6CtqWe8bcT5hSljHh2
         2qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786153268; x=1786758068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K33TW3QT82O6/MHuB/paGse9ECFvxfuZooBXxXgxnaI=;
        b=c+NlN7AzURRNVODKwEDTL3EoYAlAFBTuPYdexA6e1Z/TuIq1k9QUWYP+SyqU8lB4YP
         RnRGiCvIiSErkX7lVELAshYkpDQXPOjYIBtQj3zzSZ35wPpngv8d3afXBaJyka9o8eVk
         5C8/SiDE7YAOM65CB4edV3GXVXuJDbBfIIgB/eQ6hqrZdEo9KaGtIQYdnpuN+mSVrFSU
         zlrMHJo0EUWS85Dz3wRKfX1IgEGN4bZMTcjdqKhgDYbviMRh7gDFqCGEY1oEFHKSRsQM
         7exDyjDj5a6bTjzALKNxiRQ42lUmMbdiGAoe+kh4cIyyrt/KB6HL2RTMg8PgbcQuUf8J
         rP3w==
X-Forwarded-Encrypted: i=1; AHgh+RpTm/z8BDsqyoiTYpFIwUYMA16oz+DydN+DhOPyfKGSnH0cl/BR+swChgYboxYV76EkosdzSUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC41ughvy3g5AALgERUS3ow7CCnuJHJ9aCAkUUAfZmKQ/yQu34
	D5u0d6HYFa7JHjQ5oRrOyZ/80AXBVslubeoekJz5uZTlDslM6x9R67R0va29W6/4eImZ4Zl8hd3
	RRfjzGmicT4ofO7QZeynrg8t/xxHi8ptxLYbGqQLs
X-Gm-Gg: AR+sD12NYlxnAQRAJdkHaImhr9dPQ7Ay+AqJ8bkL6UPI4o9iLGcSQoC3RED1eecqY40
	iEwNo2Lozs1IRVlgWlBaxgn/AUqAFgNSAZOUGZ2omZ5j9H9a5ZCocxX1rKMMBHHRK8D6aUxUoze
	evu5hed5zv8imGfFmrckTTEkBOi3KVukDaCdgPPXcJLzkIMseTcNDYnLxypIgO1kGjjm5N+8cip
	JV7REiCT1n79dStypbG8T518gIwthRbAoKEJaTU2wChY9Kxe0LDPkEqR9zw94ImvzWlV0SffzUR
	NhUrgtSpm+/U2Kr53egXESmFSqPNGAKTuZgMzVkC/Cajnjq5k6v2OxqZEDnX1EBoDfZhUa7znDg
	Wbnk5OA9QSUbzvk+M6kOpB5h7CoTUUmKgM1LhcKoFgFItammkG0GjJhAkXmfX+sJno72qSRIF29
	gqSOxuVmvfHr8oTA==
X-Received: by 2002:a17:90b:5343:b0:37f:a915:1c29 with SMTP id
 98e67ed59e1d1-3909d9174b2mr12356788a91.19.1786153267129; Fri, 07 Aug 2026
 18:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785824313.git.namcao@linutronix.de> <bc759ceba26d6e20fab3bcf7333ee7e6246696b6.1785824313.git.namcao@linutronix.de>
 <20260807180709.6fb7f2b2@kernel.org>
In-Reply-To: <20260807180709.6fb7f2b2@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 7 Aug 2026 18:40:55 -0700
X-Gm-Features: AUfX_mwkQ2n41h6YY5wbT9_yjGRlbcWzEI_ZrbQgH0BeSD9IvCNWMhOBG_HaYpA
Message-ID: <CAAVpQUC5mY9gZH=LmRvdZb1F+QbxGPuNBgSXvHh6pTzZO5QSNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/1] af_unix: Do not wait for garbage
 collector in sendmsg()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  4 Aug 2026 08:46:16 +0200 Nam Cao wrote:
> > AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collecto=
r if
> > user has too many inflight unix sockets and there is cyclic reference i=
n
> > the system. This causes real-time issues, as cyclic reference can be
> > created by any task in the system, and high priority tasks who do need =
to
> > send lots of AF_UNIX sockets get blocked by the garbage collector which
> > runs as workqueue, causing a priority inversion scenario.
>
> Hi Kuniyuki! Any thoughts?

flush_work() makes an insane process slow down by itself and
the sane users (whose peers receive fd in timely manner) can
likely acquire the gc lock before insane users.

The commit message assumes the GC is low priority, and it will
be easier to trigger OOM and soft lockup without the penalty.

If priority inversion on RT kernel is the only problem here, there will
be more flush_work() instances triggered from userspace, and the real
problem is that flush_work() does not implement priority inheritance
like mutex.
