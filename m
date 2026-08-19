Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6B442390;
	Wed, 19 Aug 2026 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134566; cv=none; b=Tbmk86nRoEKumyY9PWBQS8RVklo5L/EYFA0tAXSx6q+nOiu/feAgwPX0mENkVhGmJ00RLMwEo5H9WkAeEuqkTDkWjx/vowT//0PHKXgDk/KxwSs5PPUo6V/90MRm7jPUXSwFUjlZB+pESe04LOeaVyBb9tUHhkLCpNCBmwKss7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134566; c=relaxed/simple;
	bh=Yk0RRpSWujlij57FPVwiMlNTqe9ran/GZG/RGVCIzWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ggrav/+ce6R4/VV1gQ7a1i5Vnrq4QwyUYP2Jm4KVvDyFzKAvlwtxqoPQ0aO/XQzfyzYgoXcrGbJUD4nb3oTjTfB6auoH1yliWBpAQyjrYgWxNpxcG0AbXpUDoFW9W5d97tAmPs7l+2s+yXEag2lKNDyz1qLlvTOIa11NQREI/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: ooonea <ooonea@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: sch_cake: fix autorate reconfiguration
 throttling
In-Reply-To: <20260816012109.2865223-1-ooonea@gmail.com>
References: <20260816012109.2865223-1-ooonea@gmail.com>
Date: Wed, 19 Aug 2026 12:08:52 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87qzjufmmj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ooonea <ooonea@gmail.com> writes:

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
> Signed-off-by: ooonea <ooonea@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
