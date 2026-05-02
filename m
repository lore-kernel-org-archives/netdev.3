Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041601A6808
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777757547; cv=none; b=mQWvBzy9xmOb2Q7NUTo2YJGE59nCTRJxOIZpDEGAIYbMiEejr2UAWRuiZWnsg11egY+yzkVp5zhOXSpPdGZk465SgJhvnn0V2CuPGqTT+dQMu6iFHl38ZfDbhAFAPdp3xrIFH3x8Eky2BEGJ7YuYy6QIV91+scaJZu8ihLU/WB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777757547; c=relaxed/simple;
	bh=GXKRvXsACEJDlKFXVoVpKKz4RufFX459qAild/p1PtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qAWBw52oIaLvWnSPwj3H1oZj9jqmefhbTZFSVgPoEAxHxR2KUZvyryPN5fR5NBZPY+oK8IVMhyaNkg+784VmaRAyifVeIfi4BAYvRgPmOifKEcJX4TJKQhr5B4MYQT2NsIUaOMUkugwAG+hdIetd6C6aXq+Z8xfdBcHsfFYUeVE=
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
Subject: Re: [PATCH net 1/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (I)
In-Reply-To: <20260430061610.3503483-2-edumazet@google.com>
References: <20260430061610.3503483-1-edumazet@google.com>
 <20260430061610.3503483-2-edumazet@google.com>
Date: Sat, 02 May 2026 23:32:13 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h5oph50i.fsf@toke.dk>
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
> In this first patch, I add READ_ONCE()/WRITE_ONCE() annotations for:
>
> - flow->head
> - flow->dropped
> - b->backlogs[]
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
