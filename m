Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4573DDAED
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273364; cv=none; b=kketxC6MVaNYzpHxRq+cEgjHVjCVy97EkCxT8ep9QhqH/gXYoDS1L4wSFqqEB6ixtNO3EZUKB/drZB++a7eW71XdFmsZw+7AtGlE2NqhzaU++ZQzJNU3A78HecZMo+UrLgfaKW7RMocAUDSnLxHako34J7iWLqFM6O3VGWI6HSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273364; c=relaxed/simple;
	bh=1L7xzjA6Na98mzu7Yo1KgT4IZ7UHAiaAArg/YAdi670=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RE/rpACs9qq63E28mWRcckRp7W1+G+fkZ1z9v2vYl/NdnJSHiDTv6fYeNsoWIBh+gGkQQyA9OPdlw82fxQslrjFwi08siLoZhUCA4ekdBnn/NnC0pX3BEiSNd6yH2HzPmtFJ468Zv9BptdsO6zA1kX7/v45B5zlU4eAXurm48Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3aj7yOD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3aj7yOD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81ee6b2da98so14732467b3.3
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784273353; x=1784878153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y5kOROv84H4DL2HflWSf7SFqBdvf1DqWm1XVhOUiXsw=;
        b=o3aj7yODEUbWJ6xr5TG8/owMILYBq+9pnBIfpx2Z+SjRPHD50OA36fQ6tNnpWOhYDI
         TRDtcHU6bNKPx67GpWtlBYUsul0wVAT9CGeoqVJfATBS10vELW2zN6Tef+Y/NNh/GPem
         iglUB8lss+c2ACZDwRko9ju53By6mPOpTNfu2q7iQ1XirGoGr263Yz4FmwAt4pNXmhJK
         aEsYh91hiXbsjNiRUznv24/FFyLEaYFit0c9EFvvzN9YopR5wboSZ1aoddF/4iZ72GHA
         8N45qaks4Pf8QlWEPignP3F+I/+UyWbP4/gxmAeTFAXtRBtTSHL9bWwoP4Es4nhIhE1t
         XDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273353; x=1784878153;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5kOROv84H4DL2HflWSf7SFqBdvf1DqWm1XVhOUiXsw=;
        b=Za3MCLwtcFr+VExopaKay9ceMbqHeXk907rXyUtjwY0pnZYCewnBUw4UzFh2Y8t92D
         9N8VOQAE8XfwyZK+u7VSXcM7ZLoNqDK4WzH/6NmXK3PaXzPZe/pfG5aSPgavOv1Zaf1t
         B4T+cBjGwkIAAdrnehMhCy3CdJ8smmhdw/HRc3yM3Z1fD2oTt5nMPItKcyfmhOeLfJ1V
         oxk4f6JYjxBjJ7sxCjv7XzUPtqVyBcv6Q8gBMfBurcP90k+VhSNm9VVsgEAHF0F8vGqe
         JOJ7eWElh9oyU0kfSI6Dmc/Fi4WjTmeP/RBiYFyNi65wm+DEq8V95pFco5k23+8B03FV
         hsFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlEo9fmYxP19x9UWVFNleRR06cWPbhlwmOY/DTgTtGsPwjbfJhgbBPGS9bbiDerC4Kimi3wCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nMVjxRmDadbqda+4IYUt4UcbHAzhczOg3QgPiyy/PjKSThpf
	w8rK68LbsQA02mT/CvK9mga+RUgYBtbwJeekJRpK3yaZ9gBrOCmrZ54g
X-Gm-Gg: AfdE7ck4+vtm0VzYLsqxx0thDHYN2lA9CnpFk65JHzt9un8KzGAAgxzTJxR0Yd9g2eA
	AGfwMscZ7JiDSPs83snEfUQJdPledKqFkZK7X95ZMloMXYdZ6Y3zelfE9jxySoXTAK3za8lQfdZ
	ZSZQqC5tfncfnYQ/IkZrgXAviZWBmiVbAGy/f9ivqb7gK1sxMjeK30iH2/szqBVkTeHAoaF3vVs
	JHAeV26MHCE+LyJXu/y3WMxWFPaqS0j18LL8CrOuGE4z05g51faOWUt2GpHtRB1PBM3XyDxLEwT
	PAdBmklDPhPhcdTsi9X+xlNODrIyUcLH3pMm1Bn1mPSwi7c5WTNmNtFfwfqyp6C3JLoqVEOs53J
	FjRSu5e8oYkuxm+LG/E8LigpJwpe4RV8/+/kECOOeUIqa4MYNsCX89LNszpBXN/9fhPX8g0S7pz
	rxydHq9bBJTdzoWZfbopCbn4S2mqwa4TLHFId/oYGbcqF/y/U6+6FgT4j3Euc1Op7aqiPm9Ie3h
	N+Z
X-Received: by 2002:a05:690c:6b04:b0:81e:6915:b43e with SMTP id 00721157ae682-81ef25e0e4fmr4551307b3.39.1784273353429;
        Fri, 17 Jul 2026 00:29:13 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4034901sm3299557b3.12.2026.07.17.00.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:29:12 -0700 (PDT)
Date: Fri, 17 Jul 2026 03:29:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Octavian Purdila <tavip@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
Message-ID: <willemdebruijn.kernel.790bf95c6439@gmail.com>
In-Reply-To: <20260709183315.965751-3-kuniyu@google.com>
References: <20260709183315.965751-1-kuniyu@google.com>
 <20260709183315.965751-3-kuniyu@google.com>
Subject: Re: [PATCH v1 net 2/2] net: Call net_enable_timestamp() before
 failure in sk_clone().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> When sk_clone() fails, sk_destruct() is called for the new socket.
> 
> If the parent socket has SK_FLAGS_TIMESTAMP in sk->sk_flags,
> net_disable_timestamp() is called for the child socket even though
> net_enable_timestamp() is not called for it.
> 
> Let's call net_enable_timestamp() before any failure path in
> sk_clone().
> 
> Fixes: 704da560c0a0 ("tcp: update the netstamp_needed counter when cloning sockets")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260709032007.9E4D61F000E9@smtp.kernel.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
