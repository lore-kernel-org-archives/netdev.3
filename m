Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13F3A4535;
	Wed, 10 Jun 2026 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079169; cv=none; b=JMQ4hX3JnjrGFDLVYhT/0lM7gOtR9TV1JmGtRT1UcSGMttagCZ2as7FGPR0Ek8B6MKc5wC/74UFPLt7vcu8lsuDBreyhH2xyLytL51IryHOPsyA4hOng+CxjhaBvymQ3KOkbEs1UjCgPN8JsyswOWc97GHQJXbnKVG+CrQxZOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079169; c=relaxed/simple;
	bh=aK2q3BbWD03U5yexJGsk3sWQvKsJGRPzWsplh0nC1VU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGfBFJugVIpSjd+8uFkGReFzmYD5zZLaeFR081SwFIH1gxmLLmIcT+uo+fCcCYctu5CIAWMtzWlnCmP0vrwuLO9OUVmwpfES90UUbsit1H/hHzX1oPsiCBWKtIrc2feqwhsryTVwRJEAuwBwBD0UGG2oZ4mW5wPTcsfoXvZprQQ=
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
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
In-Reply-To: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
Date: Wed, 10 Jun 2026 10:06:04 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877bo6akgj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Moelius <sam.moelius@trailofbits.com> writes:

> CAKE accepts overhead values that can make adjusted packet length
> arithmetic underflow.  A negative effective length can wrap through
> unsigned arithmetic and become a large value.
>
> Such configurations make rate accounting depend on integer wraparound
> rather than on the packet size userspace intended to model.
>
> Validate overhead settings before using them in adjusted length
> calculations.
>
> Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the =
rate shaper")
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
