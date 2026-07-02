Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8E478E49;
	Thu,  2 Jul 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985238; cv=none; b=XFN2TE1pFqwjkyujrOTlv9zzUlq1+dJq7zNaB0nt+6OGPnz9WbAjxjnC98RbPzlDnup3P3dZUA5VfzZ8vA1J+ihHOzE0RQiZJViZ/jqvktRZ9sCmexl3bzHl9mzFIVwPbwNT/VKulKNWi+gDFF5eKeO3AeFD7Pccg0FGfyqW8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985238; c=relaxed/simple;
	bh=JFmrIFdZ1wJy91RPSvdF0wqD4CSWLEl1M63OL9LABD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jv9nkwfcfUP/m8Bh/6pOruzOJxkybg3egIjwwQKa8RDhAD+oQDDiZoYdSH+Or2cJogdRp0EZ2GwyDSSWrcv3W7/Vc0/K+1d2ZO38WrqRDBgYSQECy7RH0IWbwPp4kmyWxB9WMVUkL/2ENHHzRmA63zcj0JQnOngFRZln9pOAZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "moderated list:CAKE QDISC"
 <cake@lists.bufferbloat.net>, "open list:TC subsystem"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net/sched: cake: reject overhead values that
 underflow length
In-Reply-To: <20260702000758.297407.e5c888d9d99d.cake-overhead-underflow@trailofbits.com>
References: <20260702000758.297407.e5c888d9d99d.cake-overhead-underflow@trailofbits.com>
Date: Thu, 02 Jul 2026 11:40:27 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pl1520hg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Moelius <sam.moelius@trailofbits.com> writes:

> CAKE accepts signed overhead values and stores them in an s16, but the
> adjusted packet length calculation uses unsigned arithmetic.  A negative
> effective length can therefore wrap to a large value.
>
> Such configurations make rate accounting depend on integer wraparound
> rather than on the packet size userspace intended to model.  A static
> netlink lower bound is not enough because packets reaching CAKE can be
> smaller than any reasonable manual-overhead allowance.
>
> Fold the signed overhead adjustment into the existing datapath MPU clamp
> so negative adjusted lengths are clamped before link-layer framing
> adjustments.
>
> Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the =
rate shaper")
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
