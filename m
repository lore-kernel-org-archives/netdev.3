Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08F568553
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200922; cv=pass; b=PitaLZq0zWGLSuGKhy5rRKA0R+kYeOfDAE6TDIMSeWntIJMiyIlgZJmv23WKtlbMfv4lV+mgw1fTGo5YM/wY4T2JXQZ39aXt8Sx6bjGUGxkYZOJvxKu7D5NuuWzTxwBwndMruHmNOgO7dUGSUmiPCBn3Uw6xk16An7mR44KZ0cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200922; c=relaxed/simple;
	bh=BxmE6TWumSdxnCF/DfZwHpDmrPK8bOfrOvAJ6PVHIdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5NFMDJy4bs2s+r6GkAJroPUnAAhPM30oPw+8EgOTVj8VR+YsuyNM37OPLU5broHAJIUoALYuuaHwSK5kxcHV+zHtqg4yoEQhDRBzjBlNLeIbWj8VrZ/EBoQn7zzC7zivfmly/74x88lCBoJMKeZ81w+9odQLOau43/HhJQzl5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlANmcmw; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlANmcmw"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-143880e27dfso399596c88.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200920; cv=none;
        d=google.com; s=arc-20260327;
        b=AzXiYEas1kXllQnIKjHsnpcZuQppUMWdflkc7n8gHxwt5UKcPUEFtzN9BYs/O5wwOc
         1GeJoSfzXA2TDyAz712AEMclAm9TmQms/GLB5HKfuBvBn3o+u/ATId6GhqUoBBMbPna/
         GIMsc+ErtAIzXqUyjq12Ykgi7trPohw3L3Rl3oW5WGQ/3baNA+cea8zg9Wly9phWBcIh
         WeIVBhneEuTU+JZPUlXoXj5YcdZS8tStlSnaa09/it12/VSykMvHdaQ592QSmusX4OYF
         rcziMvl0gJ6nZ3TvheHIozgR6cuMSRefGLNECKxH5PrhJ6iAJWQRkGbk0uvCP1ZyK0iU
         pbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfI6pOLVyMhdWWBgVl1aRFnTQKav9Gx6fgY4yEFrfL4=;
        fh=E1YHgG3XNQwKSb0d9XoptaWDzfrN0C0Fl5u32hWijfk=;
        b=ZX2VsqwK8mVByk9Dn4hQ8rA/POc98KXEi8Mk4eAvyYr4oc4M/Uprr15cQxHW1MZbFf
         6MioDcZgYi9u0viYJ51HvjDuW9U3Zai8d9JRyNQucpfd72JkADiRO06g7zX0diJLefSA
         KN0VSlrK4h84u+rkw6UgoqEiIZwfbJnX0RdReG8rFii4Nyo1Zo7ysg58omv43Qk1ljao
         Xq5Pgx+fEZwNsvxQxc+4hiY8Vw1z9U0qP0xL6nrByKSmxru+nLLsR6lpBd9wfmXa43Pf
         XNwSt3ck4Ijlh73EP8fzrKPlIfevGnytI5U46jJ5Sn9v6KPRo7+o8IJdUdeK22RZI0qf
         rwaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200920; x=1790805720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FfI6pOLVyMhdWWBgVl1aRFnTQKav9Gx6fgY4yEFrfL4=;
        b=IlANmcmw1JU1vK7oYd47dVpH5TE/YIivNtMPgvhWwewMm03BHaANGNng5xoVoPRovO
         8/9OoLSzkGt/mtciZFHinG+TBR+U/my2w2g70Q0IYoLWxyppRCXbngoPYTyEZ+R0sMjP
         8cd2AxZ0CjdjQ5UG+XP1BvQG1P2Sy29nAUfekBZLHhwKSn/i9SkoaVJnOyX+8KHdAx0P
         8XwdYz06vHf88v2l98/ZP7tgW/MZ1FIfDCcUIW5F85nquXLVTNexdAQKIZh0bMLj5mct
         YE29UPag34lHQs8Iq+Qb8ssfKUi4/HnE1H0+4fkLNn2dBYLqHcleDg1oCltibUXE9GkF
         3ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200920; x=1790805720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FfI6pOLVyMhdWWBgVl1aRFnTQKav9Gx6fgY4yEFrfL4=;
        b=pC78KODLoifR+8Zf+F0wFOa+AWoCezDHNqAaTrSOYM2gcByRiPKo9fl0CfLh6KNRJo
         65kDero+nukn3CkyzRQIwRkal+sr036RRwqAcYU7zGjAwIacSTqZ3jAJfEA9Uxj0hzel
         tBPAWtGu7XH62rGXY+tQ22qoDRT7RdxqJaL/2jfRDznnHuOKq8Y9XIQhJtVb84jIv69/
         xRALfiZJBjLQN4liyTzGcNkVaVPo1/MmACekAY2tLVywem0fnL6OKUEhBmRE4J568owm
         iuaWktQ8QfsSyOhD6YB6O0qt66oDO9GK+5yPGWAQM2NSGamvHtTigCxcFIJ9n3NXTPXo
         sYDA==
X-Forwarded-Encrypted: i=1; AKwUvBzeFDvn8t5hnXkhJu80w75bZoKNZnujYAAPiam6ZgI5u5mxf356OPBlMAWXqj2Rcvp97QjJnAs=@vger.kernel.org
X-Gm-Message-State: AFuF++k8Z4x82axCmQEzQ88n8tCAsh34MWCK5ulYAI8yDnv/tKZ4yeqY
	90WS2pOw3BMu08QVqt9oMe/6duo8prOQUrYZ8g5/hrmRFtkPugZ6/2EtDtbRCuShc/Z4ujxADuv
	xp+r6z+C9J9uI67WhlCzI2Z405LB2aB/BJ/+vzilh
X-Gm-Gg: AYBFou2urSlO3vu61zI2iyEtBb9LNjMuPai4zR421vX2V7YCGEmTxy2XOCDtTQbnqgL
	I08cv/e3asTuh3FdcsKCrTk1AQo+98mL4B4szyJWpzq8q+tjFHSlhB3f7lLrHLfbzPiCi5blIwb
	/Xh9vG+vaYDLLB6tj/3Mevw0u+C+pE5vSw85UgFWIrn64a/Vxzm1gpTfp7x3LHZuY3S/3sxogSJ
	YW37Ke9jTRNRB4HJeUmAZCo/fWJvDuE16E0aMbOKxlrZlr9gsoWNGDNBtWh262LYdSroRFihtjp
	YDErGaURXI4rDbhfCR6UabjKxO30E8KpAqTT9nsgjCNVhPqPK6gBv4RsM0qcCMCMOpYX5magwMN
	0Tj8M+gsqulSEf4DqBnodakOfeU7TEgb3tipysMD6vpWD2pRAegpYdMKwOccQDFLzW46gg8WEU9
	/ndK+SIQYZL1URxCq30bUMrU+noOznGVi2E9F31A5OJpk=
X-Received: by 2002:a05:701b:4254:10b0:13e:5c8f:ff87 with SMTP id
 a92af1059eb24-14503fde871mr359786c88.23.1790200918799; Wed, 23 Sep 2026
 15:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-10-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-10-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 15:01:47 -0700
X-Gm-Features: AcwNN1XX7Bp4RXL6-2RL4GYzKxofidszLSs7wL9J9cjszmzLoC_ENtsq69MFP08
Message-ID: <CAAVpQUAx=UqBz8w5F=_Ken87mJKmPpdsJUcA85w1dcDs=Dh4Ew@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] tcp: add tp->tcp_nospace
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_check_space() runs for every incoming ACK and for every packet we
> send, and reads SOCK_NOSPACE from sk->sk_socket->flags.
>
> struct socket lives in its own cache line, which the TCP fast paths do
> not otherwise touch, so testing sk->sk_socket->flags pulls in an extra
> cache line that is cold when the working set is large.
>
> Add tp->tcp_nospace, a mirror of SOCK_NOSPACE placed in the
> tcp_sock_write_txrx group, that is in a cache line both the transmit
> and the receive paths already have to touch.  It fits in an existing
> hole, sizeof(struct tcp_sock) is unchanged.
>
> The two flags are now only changed from sk_set_nospace() and
> sk_clear_nospace(), which maintain this invariant:
>
>         SOCK_NOSPACE set  =3D>  tp->tcp_nospace set
>
> tcp_check_space() can thus test tp->tcp_nospace alone and leave the
> authoritative SOCK_NOSPACE test to __tcp_check_space().  The
> invariant is one directional on purpose: a stale tp->tcp_nospace only
> costs an extra call to __tcp_check_space(), which is what we do
> unconditionally today, while a stale SOCK_NOSPACE would cost a
> missed EPOLLOUT.
>
> Note the smp_mb() is kept.  tcp_poll() sets the flag without the
> socket lock, and the store-buffer pattern it forms with
> tcp_check_space() needs a full barrier on both sides.
>
> MPTCP subflows share the struct socket of their parent, hence its
> SOCK_NOSPACE bit, which can not be mirrored in the subflow tcp_sock.
> Pin their tp->tcp_nospace in subflow_ulp_init(), so that they always
> reach __tcp_check_space() and keep the current behavior.
>
> Microbenchmark on an AMD EPYC 7B13, 64 threads, each thread calling
> tcp_check_space() in a loop over a private set of sockets.  Numbers
> are cycles per call above a baseline loop that performs the work the
> callers already did (the cache lines tcp_write_xmit() and
> tcp_clean_rtx_queue() touched) but not tcp_check_space() itself, so
> they are the marginal cost of the function.  Median of 11 runs.
> The set size controls whether struct socket is still cached:
>
>     sockets/thread      before   after
>     1                     +0.6    +0.7
>     256    (64 KB)        +8.3    +3.9
>     4096   (1 MB)        +22.4    +1.1
>     262144 (64 MB)       +48.4    -0.8
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
