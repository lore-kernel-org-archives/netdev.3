Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02138836F
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777757726; cv=none; b=DftZR6ha8ZlULhU4yyiquOTlkZgtvd4BRT3KKVNENqGooAqSSrxYAQSimNfT1si4+EcS79yXYdJJhGBOOQspbbyd7pfLvMTAwhHMGSfsbHnGBf5hL3kmHiLAf2sXJe1l5H8Sla+dNz7vWUZSyWukI+03m312ZQAtZ6BH1vbbs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777757726; c=relaxed/simple;
	bh=PS7eP0ksFCALNNAUSVpPhaFc3/lIjopaBzYEKAyM7Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCp2EGF5HutUDiEPpGNk0FPxfSwNyxJjixPlhwhWQxcn8O54me7f7uXAvE5AKw14DeOm72gmp62lnVLE0V/XBKRVd47aHDLG0dQU3ZyVikuQChuNZvWKhjxDrhyCDegzYXD2P+erM3M+2INmh4e9S4/9l00KhRkYsVc4dO8qVbU=
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
Subject: Re: [PATCH net 2/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (II)
In-Reply-To: <20260430061610.3503483-3-edumazet@google.com>
References: <20260430061610.3503483-1-edumazet@google.com>
 <20260430061610.3503483-3-edumazet@google.com>
Date: Sat, 02 May 2026 23:35:22 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ecjth4v9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> cake_dump_class_stats() runs without qdisc spinlock being held.
>
> In this second patch, I add READ_ONCE()/WRITE_ONCE() annotations for:
>
> - flow->deficit
> - flow->cvars.dropping
> - flow->cvars.count
> - flow->cvars.p_drop
> - flow->cvars.blue_timer
> - flow->cvars.drop_next
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
