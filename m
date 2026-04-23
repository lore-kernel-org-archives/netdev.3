Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298162BE026
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946106; cv=none; b=aP5GxccjgtBLmuzkD1/ZJrd1052Ks+890PON0+098GYNgicPhl1f8h0MdAaJTSHzMsHI1e9poKYST9KIpguZvvmOtMzplBYpELeTZbrWIL0WpD8w6vyHyLPRLoQQAx2rwcD5furt/6Fy7imBgZ6tcGfL69x1yx0qC+cflSVLKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946106; c=relaxed/simple;
	bh=9Amh17detrVqvzU7RxH1v/MIpeUMgRuJt11KfZMbzag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSD4Z9VIHj8ui79DEC++KReuWkoWhVQsSkm295ibrbTakpka2HNwgggDuN+W+Y7ZckgWvc1kIHglnLf/be0jSLs/C9SUI4INldum8qKC/slUcP57TI77zl5PZgO2Fg16FhGvkbbjuuvQajMmuAOejsc0ZUKYCEr2axVhh+uTdcQ=
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
Subject: Re: [PATCH net 1/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (I)
In-Reply-To: <20260423102324.3172448-2-edumazet@google.com>
References: <20260423102324.3172448-1-edumazet@google.com>
 <20260423102324.3172448-2-edumazet@google.com>
Date: Thu, 23 Apr 2026 14:08:20 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bjf9yj4b.fsf@toke.dk>
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
> In this first patch, I add READ_ONCE()/WRITE_ONCE() annotations
> for the following fields:
>
> - way_hits
> - way_misses
> - way_collisions
> - sparse_flow_count
> - decaying_flow_count
>
> Other annotations are added in following patches, to ease code review.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

