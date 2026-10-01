Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACA3B3BF3
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869849; cv=none; b=QEdYwzqNw5oLq8weJQrFZkAwtBJQO27cdSBckLzxRLQcaTMiO3DwcfbTbqFCuBAz7pMjL+guN/fiiLOjEpuV65D1xkLarxO0wIaSRMgpvfM0KtaBsBXiySKDL5m3Kh8UbaxjExtQGLYTJ5J2AhzE93JMuAtUmu4Br4FN/MyAvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869849; c=relaxed/simple;
	bh=fPg/5Lh198wl8wNHDUF/cs++ekRTVvwZsWqq2UO3qpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUuuDCjmQEu0TMxmXgZzVpiABzPiL4AYuqO1mqMVfUbataoouhzALC4GDrXL6oPauTfBCyNII54aji7l32SW2QWw8vYNZD2i55+nt1HR9RL2Sdn/7+IMLPZS1wgKBqAx7+dOcnaedaMSzlC6RacGiUDHUB7WfE3uioO9I9FmDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQn+qRM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQn+qRM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789B61F0089D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869847;
	bh=/Qj5vMw6z9zWWETOq6cYpSaNX4x97oFrpPqJ8DAFF1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lQn+qRM2Q/y5wi87ogcbIBUHBvbSrnkHFaQVQbfuAcMYyjJlbC04j0O2GqWIA/+87
	 9OBZsRrrCjOWbyByCPjqBB/N8xTVlzWQ7l4Jby3X+JWS0g9/y5uggQTS+b/8uuRyLV
	 I/4DGuZ5KI9Pqp5eCYTxfdPzd4DdFQdcZlrkFR41P6s9MQrHjaWEziGtQoKwAp9TwK
	 fDe6lBLdG5tjTjsHPhuKDloM3tpE1BpDvAgJu6HiSE0PvxRgyZtODiNsHxFtfsZgrw
	 ZzoyGMW03ymP3uWDL+xMGP+ITOa3ZFKkD/IME9qy+Q32oJzpADs2q/+buXV4UqkWRJ
	 bj/TWzzozW/LQ==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2ad8so4141512fac.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:50:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzzmCREJgQAQ4BA8nASt/awM2E/KXLA7Q+CZsKab2ZMFJJiWN/WxxFKmbfSlavrVeQTotM1Nfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVCONAOqDNwiNPCU0ngpecOnQbIBZdiV1hH0hcExNn3fgcM9zz
	lBsKr3WXVCQ0WT3F3h8H0oNUPS4HuuOW0vGMk/zwiT70Xz6iHlm+cPUrmqHLB8mPoyNuW0Ft8ql
	/FyJFCO+gQpeBUhTPzzkygp++LX4iPSs=
X-Received: by 2002:a05:6870:b150:b0:49d:cc3f:a9e1 with SMTP id
 586e51a60fabf-49ddd604b86mr5345341fac.45.1790869846763; Thu, 01 Oct 2026
 08:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929153834.566551-1-edumazet@kernel.org> <179084696215.434549.12886942915829094069@kernel.org>
In-Reply-To: <179084696215.434549.12886942915829094069@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 17:50:35 +0200
X-Gmail-Original-Message-ID: <CAL4WiioxFUwex7ARPHhJ2DWKTn2dEVkd6peRULtNHudC_j_D8Q@mail.gmail.com>
X-Gm-Features: AclHuK83qBHqvTNYQcBUL1A26Q7OQSEw3_7ksDWQs-iNAretvwYCTyVTDI0zMqk
Message-ID: <CAL4WiioxFUwex7ARPHhJ2DWKTn2dEVkd6peRULtNHudC_j_D8Q@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: use zero IPID for atomic datagrams on
 connected sockets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org, 
	idosch@nvidia.com, edumazet@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:29=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] TCP TSO/GSO skbs now carry IPv4 IDs that restart at 0 on every
>   skb.

GRO already terminates each sender TSO packet since 2019, commit 051ba67447=
de
("tcp: force a PSH flag on TSO packets"), every TSO skb carries PSH on
its last segment, and tcp_gro_receive() flushes on PSH. IP ID restarting
at 0 on every TSO skb therefore does not add GRO flushes.

The only extra flush is a 1-MSS skb (without PSH) followed by a TSO skb,
which happens under cwnd/congestion limited conditions, where we already
choose to delay delivery on purpose.

> - [Low] The kernel-doc for struct inet_sock (include/net/inet_sock.h)
>   still says `@inet_id - ID counter for DF pkts`.

Okay I will update the inet_id kernel-doc in v2.

pw-bot: cr
