Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049F5A79B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785906930; cv=pass; b=XvY416JmPw8II1IG5lbAZf1rz40joY/Uv3RT9tPtDWFlhdBeKOCkBOL9NZOHnHIk0HcJ/oCChEWQb/tfqMGMbFWw3s0ElWhiHD+XWW8LcJbgrdJJkuQXX0ioq+ETNxka0IYsN1ooU0nYRPKHTtvQWbP1jFJ9NtV9WuWGBZVBmm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785906930; c=relaxed/simple;
	bh=Cv91Q5KG9Qlh4InOrwZvyCGwnt54f+chCcW/ClvGp3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEzGBTgK/jO6bCQZS+nLYXBZ1Me26Ap0BmomnN5eCFn7SxUKy+Bz73e0AlYvgFH9YzAQsndnR0eO5nTH30rD7EcXL1KiMlFHNynPKi6hCA+FPZMTaV5RdzXpHOAKIq3Q9TmbS22gNOy7tM9mjYJFPReVUNRHB0Rx5VCtEn8m9Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGmMLL/S; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGmMLL/S"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so584456a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 22:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785906928; cv=none;
        d=google.com; s=arc-20260327;
        b=FxzkX4rosjZ8EaIrrnUfySXX9V6HR9g2+QESkkDSoBMVRf/6FRO6GhFoKpyTNpJCLs
         EhctLIoPB9j2SqKrM2waCwVQsRBYWerQlvcLfnoYYPVWp2VxgBkv+A8aVeObOrH1S4PU
         apQ8Guu39RF1LvI/vBu+zWT473L4rcw2XEKUY0sAaV/zOQtfGDowXZ3AQKRTF67GDnEf
         Pykn6fpfGyqPNyA+yN9OAwd4ybAd3SjlKhrJMcD5XG7RCIZpW0gof65S78wveATRc4u/
         +qyzYM22ZdnoW1yTQxUEbOPFBJoxGOkTV6uPM8Pl61chEPnY8XfUyPuy5M2jTqAdV9JD
         Ay5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zD5Y/bMG7jyFHCeefmncNfBOipowYXYouSx/pSuqb9s=;
        fh=SQlKo18ON3T28h9R6SGyvyqN5ZfZZLe+qKKt+YAnmHw=;
        b=LqNOa7VTztY92JQbeza3EDVT5512rZQBvyjVSevrxzngUJzvA6BQ7IejjIO2Etdmso
         7o187N6K3oduiB4W7aJ/Lmusebq9SafBv8srV6FfiVYggiqxCDkDbRureGHZmXMrP6wX
         4ic49mPapJDSF7iZ2npsKKRPb4dzaelGlNBpS2cdboKTLJ3e0Ti28AgLZodCt/yi/f97
         5YR8GswCoT5KNsV+/dL6jg2uGR7qhVa53djLOaA4m+qbxv9kGT5df7uQAKOmRRrw3esm
         3OG7zYInD7EX1o7FAueVHusrqRyIdsLLohkthbbsD82rz0EqLCWSvvfsVuyyj07VjaEQ
         MNzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785906928; x=1786511728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zD5Y/bMG7jyFHCeefmncNfBOipowYXYouSx/pSuqb9s=;
        b=BGmMLL/SCi60rFnuTaL1nVCuyOLHg9S7XlMlDbt0iBjXkik9ZITk3/wXJvHR1wR4Bc
         sz6GkDVtNOnx+R8Y5k4pFMdSIE+UuAqEkyjCVgOHfGMWANczuC47wzN856DL2emLO05N
         IQ+JhESfeejEorRbv6+cc7kAR2p6nDB/Ek3yIp7JpvCKBA7s+/hiNdPiFIfE6sL2/fkM
         x+wz9lSCgrM+PfsWdNHgaQVQtADkHFtjuGnxpdhopuZaNr35OP2OiiFnwk7h4Jjrlw0o
         n02EUkamgo8SXhEnpe8nY0fdMQTc82sRv36UgyzR6Y0+/VmMWSOtr0Q7oS0yWYgvAgWe
         me3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785906928; x=1786511728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zD5Y/bMG7jyFHCeefmncNfBOipowYXYouSx/pSuqb9s=;
        b=Nhpgpp8RU00CXAARhePb7yKluJm9L/0NZ04R1BG1QmJ25eSM1tG5mpXwqZR5wjYnbK
         vo6KhoIaJnXToT5tYzzSs9+oB/VKF3c/P9CD8GM6HpV3EZPhEBTcFCWkdaSf9YJsu8oi
         BAFX8FLAY1nvSPYXOhHYXmVPQk67WJ/jzeHx4eX8YOMi4glQBmvSTf6W8aF87/jDbxiq
         30eYzVtIxO7EoBI1MQ2IXARvIhqgK7T5u5r+r2S2kbxlSz5CxiYxfhfAZAZC1/Ppqd+a
         Xj1ISxeQnYLeiTAhEcHJ6KyJFDWt35A/nIRQKlVVZzgWXYQmU83H7A6KHuQnaex6LPVA
         A0Aw==
X-Gm-Message-State: AOJu0YzW2zz7nL99+Z4Fx2r63XrrTy9utZK9SK2Dlz8WNJQVtOPVcVy9
	gAQiiaB/auExMBzUbhbD7p2ac2iMtLnbfx3JysU7vVH7sI9dSw84LXvS9qu8/2yYcP9Gig9WKQe
	h8JI7eHow24duyYv91l6fT4KZ9WrJlWykOi1CaK75HnPGgJCb+BVfb56ktJ8=
X-Gm-Gg: AR+sD12Jl02WnS97vVN6sgB1ge0AR4kw/F23x+aomJdt01rXmZ1CXhk6VKvdtxfwx4M
	xaguhDBC658DRN5Q9QqUJahVoT+J1mepTuarv9L1fsG5YHn3svJURPGVjiONgh5s0EV2w2nSO+l
	Ck9hggSYlFyOSG+3nC1YOkI0fU7qrnXjKCY6swZyGCa5gEEsuH49+bFbBkqZMf193szvfFN7bVQ
	KlXX5y360c9W31nAtKIknGRe18anwHhxsLrBETVy5+CzJdB2hCg6WsiDAp6viFsZ1ePMS4yx/cm
	LBpj5zAdtU9Qx9hypRK02HCPOSBMLkRmV3JjYim2DeFpm7wWT9yNuljYet+2ZTvLe26R637TCj5
	pGrawN8k3EUnOQnWeutGo8WSt66hq2GC9w3kpq8EvXSnfvBsuUnBI5GcsOcudoV9IBDtvUzyTdf
	ktrqVN11thaOs=
X-Received: by 2002:a17:90b:1c84:b0:38f:5828:857e with SMTP id
 98e67ed59e1d1-3903c5b4c5emr3730648a91.16.1785906927812; Tue, 04 Aug 2026
 22:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803061739.134737-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260803061739.134737-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 22:15:16 -0700
X-Gm-Features: AUfX_mwhhvr6Q5m6FFApFT8durAkIm0kN7jttZvB8q7qQLXYF2Zvt09seNWHZ_0
Message-ID: <CAAVpQUD4X+TpL+tTc3Gn4Uz8Yc7qbtXHA=u=UHjbhbXyt7dxdA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix TFO max_qlen accounting across reuseport migration
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 11:18=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> A listener's TCP_FASTOPEN max_qlen stops being accurate and lets through
> far more pending Fast Open requests than it was configured for.
>
> This only shows up with SO_REUSEPORT listener migration, where closing a
> listener hands its still-pending TFO children over to a surviving one.
>
> fastopenq.qlen is charged in tcp_fastopen_create_child() when the child
> is created and uncharged in reqsk_fastopen_remove() when the handshake
> completes.  The uncharge follows rsk_listener of the request the child
> points at, and inet_reqsk_clone() has repointed the child at a new
> request owned by the new listener, so the ++ and the -- land on two
> different sockets.  The new listener's qlen drifts negative and its
> limit no longer binds.
>
> Charge the new listener during migration, like reqsk_queue_migrated()
> already does for queue->young and queue->qlen.
>
> Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets i=
n accept queues.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
