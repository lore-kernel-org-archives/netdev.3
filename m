Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209138910D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279536; cv=none; b=X7qJw9B6ZuD529wKEn/JEdZO41fjtEmt2oaJkTuLS3FbQ8fNAWphrPqTs9EVozLUw99h3hvQpMw0Kyc7hqSDkx+3FEzjnBvpQo7WhThbPknLDbNr5Ay2n4l1fRY6McBGK0P/nbvBU1KNgaczD6qow/0nCBDlaVhn1PZ+IfBVY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279536; c=relaxed/simple;
	bh=XQWKQAFBedlVMgnH3/vNwY18jy5DnjHrHjt5tVOiOpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TqDes11wLRlbje4KfNz2duYxGNZprnFUjIjK0xgJy5tGcBccbRV59sbL64MYAC7TjVA1kxQY9uyGkfmgcnLt+t4E/6nYBoS+uWNpnm5i8iPkDp0RthwZV633ldEq1LR0qGqLEWjhRQmgk9NRcxLkotmtntNz8/G8kqBX4JLdwFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net 4/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (IV)
In-Reply-To: <20260427083606.459355-5-edumazet@google.com>
References: <20260427083606.459355-1-edumazet@google.com>
 <20260427083606.459355-5-edumazet@google.com>
Date: Mon, 27 Apr 2026 10:45:25 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pl3kx04a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> cake_dump_stats() runs without qdisc spinlock being held.
>
> In this fourth patch, I add READ_ONCE()/WRITE_ONCE() annotations
> for the following fields:
>
> - avg_peak_bandwidth
> - buffer_limit
> - buffer_max_used
> - avg_netoff
> - max_netlen
> - max_adjlen
> - min_netlen
> - min_adjlen
> - active_queues
> - tin_rate_bps
> - bytes
> - tin_backlog
>
> Other annotations are added in following patch, to ease code review.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>

Looks better, thank you for re-spinning!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
