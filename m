Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F64F55A4
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790296; cv=pass; b=T9SYzau65JPcNr016k0lPBNcW6d3S9sYoNRub7vbBvzsG4eDiVFxdqwMO2eZ5dlu3t5M3Iqen2U1V1SFAEN7UDLFwdO88Iwjd1hWgiDlxIb2ENkbtPTIq6xhLoexYIx2SeusSwZZD72caK2pvw+dMw+60iUFpyd11LYDOdRlZ9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790296; c=relaxed/simple;
	bh=YQcfcs+zJnOKaJQ5IHf2t2NLY66T+7nBA+9fE31khyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOJ6BTdB1vgmj/QJUVXwc6MCo0DZyfoDjpiANh9sFATiSPlkIsZBnamN03SpDD82z7tXy+EVhF0HiQg4BEGiDxPa7VAiY6X+gXqCgIMSvIqFRHIyHLWjVOvyqvJ4wn8+w4eM1WEbcpsLIQYQaqT5ybmfCDKyVCzC2HBTlYPGTL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUT5lBe4; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUT5lBe4"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9103f5b813aso26899576d6.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788790293; cv=none;
        d=google.com; s=arc-20260327;
        b=qzU/qSL5m1qtrzuv/SDN2O7BkfcK2yYnI+y4Me62mZhYSU9V5Q9cbWInjzhHFM47cX
         8z8GPPwLqR8HVqEA/ZmaAsF0spRKrcZU+0x3mvVkZx4icT1njPI9u5/e/0ehY02qx1eG
         Eb+Q285kIhfROYE2TpU80fcc+sRAWjtO8OyuReo5xKFzqXZV0KDQvcLKnjupDHIZiXeE
         1VNqSVaJ8QHKOBcCyFyET66i6+/eQ2jB4x+TafA8vdOgueEpFgBSdBoCAJG0Ny8jB4+3
         59ZFgiOyyRb1tBd8NPXIaQgtzXsWJtKgpErtoWzeMKGSxCxT5p9NGc3TAJqVf7LG9vOq
         k5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HbWRZ7ulK/8VAdzXceDJhVzPUhV9UxTFxMw6kD/qZtY=;
        fh=AfiTE2jFBzVeTnsCCo18PmV1klQx4yZ+n/v4bg58Ae4=;
        b=c8vX0oXRh7MRsUoMIj+qfHgufPe+J+OS+Yk7xtc1ek9mLthDuc2+vQiG4VcypTTtnQ
         FzG88lnw6ExnAEGFxsJWR6MrnqwVoOFcV1olRhYGutGd2kuEtcWyn/nM1bCEaTZyPJ3s
         97m3dddwwBfLKCq7coBnHluS68VIdgxxtWWyyCoJeKXqmn4yaubPPOHu10pvLIYrlp/+
         WZ13zDIqRU6ihS2PrZhZhErcPJ9BYBKZaULCzxXAbjz7bqu63wCpWY/gQUEZQppCtJI3
         cO73G84kVMSDLvP0twdU6M8kw6EY/EJUCYpFfWZpMZy+G0/1PRYg+8VUzxRpVyABqBTF
         JgqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788790293; x=1789395093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HbWRZ7ulK/8VAdzXceDJhVzPUhV9UxTFxMw6kD/qZtY=;
        b=JUT5lBe4hL/zqbC2Uwqj8vWMyII/h2zp4y7Ykmaq7VpmjUueNh0D2OyWrxXuHV6ZLT
         MCL/d9y3CSYPyNNLatVLugi61ARDCnOU54nBtBiQV7W9VwwvrHFrk4LcgxY0sfghjZjF
         PfysSuIhF+EYCssVpXVZ2V86gVYi9fH6GKz16NNjc1EFOfBP2L9x3F+GGiY3mi5eZLZN
         mA0icAfimtKiHwVjE/Gk5XTxA5RC+5paQtq++bsdLCYMIJd+A7EpAPJgrfo2v6Yp9tVr
         ASFJS6NnfgGM7kFrp9D4PCTiJSA3zUjT0Yqy/DBNUwcXbWzNO+i1FpX5Szo6jAOgxQ8n
         mJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788790293; x=1789395093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbWRZ7ulK/8VAdzXceDJhVzPUhV9UxTFxMw6kD/qZtY=;
        b=G/Y6JnjgL31TRPKEPhE3qSnqrEKt+dM5/V+2GoOhEftzheHt/fnWOdIX6LcKDAnJyW
         J985YQlMzvT8Rc7/F2wDmQlz4PdHCF9s0NjGwP/Ir1RAkrAR9FK6o2dMgPTPmAJv9FyY
         hhDNo1UItjuEhxRT4hGhJqBg2mzjfhCu2AYotL70K28wBZE2CFeI5LPICcNHUeBJnWDT
         fP7ae6n4a7i+mF9+Ikx83HaAagsT6rhlKWorRpTW5/KzX26GT/BWqxP5mW2QbUarUziG
         wTI4f1qLAnwXSbKV+H1T9wOgt5Dq2+8/+Ve64/FI3eFaI5CsKTXv4W7jAecqs/OS2aRB
         Syeg==
X-Gm-Message-State: AFuF++lnfQMt5ZawYVlU/I1ZSFzt26vhbj9LzXV+kxruHVhlAh8VYDvF
	kIEIPdLyQHVPraR2HWM+a8R104BV1fW57bXKYj+Xx/gLm+Wv3GY4U9Hl1ftkIp33JSzJuTqoDxI
	Dsyk3T82IS3PeA/zPVG8zdeeqZZSonhT2r6k/aMW4
X-Gm-Gg: AYBFou1RR/NuWhsCse4BwLPRG4PdaPb18J694vKNJ1sLIiblN5+sZaVj5dQmVOHgPo8
	du4OEd/y6UO4hQAnixG36AURqanlBZ+1UIzxycKzGVeUIgKEK1J+D5v8rwyR1/yRQKDFnzG4R4L
	JIUx8eQ3Og4TVedmx5iIjUz+o0oq2totPgsi2+YZm+iMw7EsmX0XQYrIDiXOdeAEvQGvlW73ozy
	neP1x1ERS+JqKkbX9eVZmvfvniwiSJFKdZcL0uKx48vsMkaShoyGm96cBHpMBd2pmtH2Qq5/F5D
	cF4bts/52KzSEuOR3YuubSU6XiNju72oDm9QhW7pQ+Sej0vYfqWT/qzBapcT7kJg25bZwmx2EYR
	4m2o96IC5ccpk8lPkGaRctAyXht/6iNo4tsMYoJghL1YR9xhIsPDo+q7a9Q==
X-Received: by 2002:a05:622a:447:b0:52f:a17e:a37c with SMTP id
 d75a77b69052e-530548b37demr250752421cf.21.1788790287557; Mon, 07 Sep 2026
 07:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788775605.git.zihanx@nebusec.ai> <d1b0d3a224167afa0ee61db0c9f778a2d12ff9b6.1788775605.git.zihanx@nebusec.ai>
In-Reply-To: <d1b0d3a224167afa0ee61db0c9f778a2d12ff9b6.1788775605.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 16:11:16 +0200
X-Gm-Features: AcwNN1UohThSqovfEz5VNgNu8UI12XNXXPGGypkZuhzhsenoEmI5CUiOgty9A4k
Message-ID: <CANn89iJjUL9LJPipeCZKq3F=Rjhq-gdCKwnuW0pkvvpS_ai7UQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] inet_diag: cap bytecode filter complexity
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vega <vega@nebusec.ai>, 
	Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:53=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> inet_diag dumps run request-supplied bytecode through inet_diag_bc_sk()
> while walking TCP, UDP and MPTCP hash buckets under their bucket locks.
> The auditor currently accepts an arbitrarily long program, so a dump
> can spend unbounded time in that locked section.
>
> That fact is already present at the git epoch: tcpdiag_bc_audit() had
> no op cap, and tcpdiag_dump() ran the bytecode under the listener and
> ehash locks. Later inet_diag extraction only moved the same code.
>
> ss(8) filters only need a handful of compare/host/mark operations.
> Reject programs with more than 64 ops in inet_diag_bc_audit() so TCP,
> UDP and MPTCP dumps share the same limit. 64 is a policy cap above a
> normal ss(8) filter, not a lock-hold budget.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>  net/ipv4/inet_diag.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 34b77aa87d0a4..1ca528cd3e72b 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -725,6 +725,12 @@ static bool valid_cgroupcond(const struct inet_diag_=
bc_op *op, int len,
>  }
>  #endif
>
> +/* ss(8) filters only need a handful of compare/host/mark ops.
> + * Bound the program so dump walks cannot run an arbitrarily long
> + * bytecode sequence under the socket hash bucket locks.
> + */
> +#define INET_DIAG_BC_MAX_OPS 64

This is unacceptable.

I am tempted to say that any hash bucket with more than 1000 sockets
in it is a problem, not only for inet_diag.

Since there is no soft lockup, this really looks like an attempt by AI
to break legitimate Linux uses.
(Or slow down as your prior versions did)
