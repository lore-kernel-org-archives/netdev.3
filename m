Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA24374E5A;
	Thu, 20 Aug 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240985; cv=none; b=PUWxDkU28iPcUJDU6Vme136RyI+idZ68c91P1B7gRCs/QIiziiGI/eR3iTHqtpY7WLuigBbzc/F1qoBAu4g0QejEqAQvB9VSMxHuTEWG4CDYBvmnqTsrO/gkyuH8KiJ5l9fZAktIDFllT9Uhji4vXlxWEIMxSm3+lM/Up5i5Pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240985; c=relaxed/simple;
	bh=hzdrQqo8irMZNLzm5tO6LcGfYI3nXISL2p+rzT4J2Vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q0NncBObV2OAvfXd/5XLHuZe33ulIu3dJzwXAjRVJcOP4axupx5N4lxIkMbGXIMeAeFcdfCpG8Gm6rqsXEgDTF73katfQYxrwsHN6rpL9hlgnzmgVQ+VpYYxlEaoI06iGnjAgheQJLCYQ+gxnV0Ghtc4mZ95eP3NqHKXyvm3wWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Giuseppe Piscitelli <ooonea@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net/sched: sch_cake: fix autorate
 reconfiguration throttling
In-Reply-To: <20260820154503.892214-1-ooonea@gmail.com>
References: <20260820154503.892214-1-ooonea@gmail.com>
Date: Thu, 20 Aug 2026 17:49:32 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fr08g5bn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Giuseppe Piscitelli <ooonea@gmail.com> writes:

> CAKE's autorate-ingress path intends to limit shaper reconfiguration to
> once per 250 ms, but last_reconfig_time is only checked and never updated.
> Since the field stays zero, every qualifying capacity-estimate window can
> call cake_reconfigure(), causing avoidable rate churn and scheduler work
> under bursty traffic.
>
> Store the current timestamp when autorate actually reconfigures the qdisc
> so the guard enforces the intended interval.
>
> Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Giuseppe Piscitelli <ooonea@gmail.com>

Please retain ACKs when reposting.

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
