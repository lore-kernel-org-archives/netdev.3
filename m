Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1362386552
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645618; cv=pass; b=G1+qbQewrFZUEe+RDrjA5wetUoLS+hX0Eefk3W6KMWHuRJzfEdIV863x5jPV0WWtM/mejJiwNQMbi+Fb88dUaUa/iQbwOnIbQDm0Q3tYiY20J7IFvh9YjNTtXUajMCnZv51Wr/OY8Ov+UrfLKJZZvHAVLJc1gZCgPmi6LkjsNyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645618; c=relaxed/simple;
	bh=E7ZeHAOi/fYgjm5BKB44ZCQNyv64n2PWDJzOgJ67vCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uR6XiqcsgwPRIYiOCcmXukwaELa7k6UoeDWvB1SKgw5JryPpYqfLAitF2bsPJifnpvF43+f+XfGfLOhXPhf7v1myMahcErZ2Tgysf+ZbKDS/7kilclAEyZ81XCNzQmaZ2j+srsBxUze7k1MmKt6aTD43IdFmhBc5HTrLntFoPCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XANPd4PH; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XANPd4PH"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4f14642adb4so388134b6e.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791645615; cv=none;
        d=google.com; s=arc-20260327;
        b=VroGzVx1m8XF351DKAV4+qkoG8lP5LVXX+LjtBbdszjI1wyiZ4SvG3E2tyb+Os9NDv
         Stqw83lfDqxDvSGsBYz3xjqHuC2gW2rNippzck5zq+BGmsxpSIDI+b1AA1wzJXfwsXE0
         g5SwxsqWpRSNxJt2IwEsXFjHegjHFocvBlRYhJFXIwNxv9q5SKi/7vJtB7pIyT1ozGXd
         LwanFAoDcLbKWzg+QRgSrKHjyzBSU/lmUiD0OCreXwJCtpwMw/rP9OjPKmGJLhIqUu3A
         QPBPGb6nNz0EqX+VlwLlnRm8Y+48K6VftnyXfYzbctQpzoyeY2HNx7rvHNNVECwO1jOb
         YCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0r8TfOvbRgQfBK9+ea8iQw89imBytAP98AivsS+jTBs=;
        fh=f4X23IbhUTi9IztatKHNZfUJZtAOYRlm8qHiK9Myuj8=;
        b=APwV5BfY39GjkvTMWHwSvmUh9wxdBH2bX4daYgM7Y/jhUuZ5Dld8+7vn4Hwon8PVOU
         8dqUmALiivlZiz0s7jvbEkuak93Jl1EH6+jd3BSPPyQsnXnl0rw0w/HcpYVyQMdCPEXV
         ZYECWlZ/yByD1koONaDjk0qlQ7eeRPtUMns4YL6Zyt5ovdxcz5x+jRrUILSxY5htY0RV
         4InBWszDn+NrZ3Ts2U/qpxJDJniYQS/Mr22iycRbWoyI2eFHr4QVnqpzKbyqtolzrySK
         L8jgz6ng5mfcbPVo3a9ufUEVm5tDQ6bFuek5fyT8N/VNtpeCZd3zwHQCFSTT/g/GSPnU
         daKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791645615; x=1792250415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0r8TfOvbRgQfBK9+ea8iQw89imBytAP98AivsS+jTBs=;
        b=XANPd4PH7GEu0r3ldUOAhnsz4rT+nu9KC9F7qr1+ht/ufgnQChyLFwSE/nzAoTWNrz
         xLHpIyopsEXgKarDAiWIn2IPaMxCHL74MWk3Z7dTFLlMh0ZTFwmPIpSBTdXIkdP9j15b
         BJYVYqgAx9yP0JRueKMXI2MwAY3ALCqdEj1VTgUDcNyT76aG00GiGTyi8XU8ZJmqlLa2
         uryHA7a4mXJsfZN97MpVIlnWDsi0sPI/B+Chd8q248ap27IZflQZ0SK3cZ5p4JgWiVln
         5fbY/qilKqGaFWVCWM8YS73bOVZ+S3vjZ9vMdDHlHV/GuODTiLdoGpf5cWVcD+8j3Shj
         OyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791645615; x=1792250415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0r8TfOvbRgQfBK9+ea8iQw89imBytAP98AivsS+jTBs=;
        b=1gkFVoUR33N+5jwypiNXYGWROjdFI+eb2olD0Pu8PgBaAgUSaiue3yZ/8e7uP7V8Ci
         10jUitZ5uLFVM+2OJ9BsALBvrIf4ytwyGIqNqkOrZhO8TbiD2B3DjH54sKHCQK/xZByV
         YwRo82NrdYOTEVJlPwZ/gY++QlxQaWIG+fF30BsGPobB1OGXIIMVSJ0axT4WE4TwhXL6
         ViN5DYDqnz+eCrs+mkhtUrjIoEbvIohBqjM4CucVHfYD6USNbbneKlfKoJIL4RCb+QNb
         XGL2Xe/9VcGW4+APqIKi6XXaIr+U2pYk72wa7ds00Kj2+Lm+0HZBg7Ez+jWVJdjvA/Og
         l3sw==
X-Forwarded-Encrypted: i=1; AKwUvByRnjU8TWSDJTT995HzTuYyGr8EiXUoYIYhhNVOwf4LJ/f0R2zYqnX4zGLnWAtMj9ArKoyst/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlrMWDIJYo5N6oL8l34FAoMJOsG/ppctPXVmvOQX+Z5xK9iXvQ
	f5NrcbsHrkXzbgX67oCgtcaBzsZCSgYljGNatQ2kb7v981AlnFDCYc9dPoEcaQUNvWTovFsdY+K
	q1f786BaxFcTcoX0tmqpQtHnRIXuuSmA=
X-Gm-Gg: AYBFou3iQ5YcaO6XpsxljKmMflcgz/5uNDOZ9I37L2TtgXB7TDLXtqA4XJZlSFEN3Hj
	uC9agFpjdLKiYv+pE16MBaIqvi4h0rB4X94MXAxFEZVRVRkPypQXsUUOLV4NT8iOpoj/JKxCPJy
	5FJ/+FlVs6M63M+cVM9HOVBPRLfCFox9zO5z1C5ZTNUFNQGJZggRxnowWJZaRZdiXNYNrTI7VSV
	JMsf0S+hTnRg7Pagj07zLeW1iR7IBvqvOpdEDuff+aOoP4kPEmf8PC/+lMD5W2FuNS0IfAjuopO
	qsZaYOGmQPXfPTIz3R4t2aBwBLWL2Aum7pjfVI6nBb5sBmVqs3wY4+uomVyTcP/1XA==
X-Received: by 2002:a05:6808:17a5:b0:4d6:93c3:1af1 with SMTP id
 5614622812f47-50c5672caecmr4433056b6e.60.1791645615441; Sat, 10 Oct 2026
 08:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009201455.1904698-1-omar@blockcast.net> <20261009213749.2226283-1-omar@blockcast.net>
In-Reply-To: <20261009213749.2226283-1-omar@blockcast.net>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 11 Oct 2026 00:20:02 +0900
X-Gm-Features: AclHuK_7zrT0KF3tsElevHgKPz5H9bXkrlPQ5TcpBKzZvse1AQ9JsAqg6GmaQXc
Message-ID: <CAMArcTUK5vRJX8VQzv+29zVrObp6XzHkdx00Q8bBSfa4HTWMcg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/3] amt: fix relay tunnel keying and
 unauthenticated-Request DoS
To: Omar Ramadan <omar@blockcast.net>
Cc: netdev-bot+sinfo@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 6:37=E2=80=AFAM Omar Ramadan <omar@blockcast.net> w=
rote:
>

Hi Omar,

Thank you so much for your work!
I'm currently traveling for LPC, so my review will be delayed.
Sorry for the delay. I will take a look at your patches in the next 2-3 day=
s.

Thanks a lot!
Taehee Yoo

> Thanks -- both are fair asks. Answers below; they are also reflected in
> the v2 cover letter. v1 was generated against v7.1 and did not apply to
> net, so this is answered against v2, which is posted against net with the
> General Query patch dropped (that fix is already in net as afae89de73dd).
> v2 is three patches.
>
> How it was found
>   Manual code inspection of the AMT relay path in drivers/net/amt.c, read
>   against RFC 7450, with LLM assistance -- hence the Assisted-by: LLM
>   trailer on patch 3/3. It was not a syzbot report or a static-analysis
>   tool scan. Patch 1/3 (endpoint keying) came out of the same reading of
>   amt_request_handler() and amt_update_handler() against RFC 7450 s4.2.2.
>
> Whether it was triggered
>   Found by inspection; not observed in production. These are availability
>   and correctness defects, not memory-safety bugs, so there is no oops or
>   stack trace to attach. The symptoms follow deterministically from the
>   code the diffs change:
>
>    - 3/3, exhaustion: amt_request_handler() allocated a tunnel before any
>      validation of the source, so Relay Membership Requests from distinct
>      spoofable source endpoints fill the table to max_tunnels (default
>      128). Once full, further Requests are answered with ICMP_DEST_UNREAC=
H
>      to the (spoofed) source and genuine gateways are refused; re-sending
>      once per amt_gmi() interval holds it full.
>    - 3/3, desync: the pre-validation lookup jumped to the send path and
>      overwrote an established tunnel's ->nonce/->mac, so a single spoofed
>      Request carrying a known gateway's source endpoint made that
>      gateway's next Membership Update fail the "Invalid MAC" check -- a
>      silent one-packet denial that consumes no table slot.
>    - 1/3, aliasing: address-only keying collapses two endpoints that shar=
e
>      a source address (NAT, or one host using separate IPv4/IPv6 ports pe=
r
>      RFC 7450 s4.2.2) onto one tunnel; the later Request wins and the
>      earlier gateway silently stops receiving.
>
>   I have not staged a live end-to-end exploit run -- the above is read
>   from the code paths, not a captured trace.
>
> Fix testing (this part is observed, not inferred)
>   The three patches were applied to net and the kernel booted (arm64,
>   QEMU via virtme-ng) with CONFIG_KASAN=3Dy, CONFIG_PROVE_LOCKING=3Dy,
>   CONFIG_PROVE_RCU=3Dy and CONFIG_DEBUG_LIST=3Dy on top of
>   tools/testing/selftests/net/config. tools/testing/selftests/net/amt.sh
>   passes all six tests -- amt discovery, IPv4 and IPv6 multicast
>   forwarding, and both IPv4/IPv6 traffic-forwarding torture cases all
>   report [ OK ] -- with no KASAN, lockdep or RCU reports.
