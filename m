Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86893ECBE9
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946371; cv=none; b=S9daccJVXiYzF30LsBZjcyyGQEh3GpWaBTKW0U6ECU3yFT9pzI6J+qVIfksSjqYf1SuvO4LMBFqgbaP+3uFq91JNCUDc9Xak6bApcCKY7dHZBADCOgoQHPYY3G2eaL3Y8MfHKFwFG1tUo8KkBXs6MXHwohSh+SYiSWjqU1VigLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946371; c=relaxed/simple;
	bh=u54kYNPhTC1emoKlu5/PTAQRXuISI77ZbuQ7M3w2jxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pETGM/eT6JU6UYSxWzDi7AMUhVfOjLdlHPVNOOs9mzKD6n7/9bOYQk67wNL50ovl7UVLPJBjprS8qNnntNiRslzRhzhKTxgx9nc+bQpiVklxtgkNo8D/iwntsjkOeMHTO+dsUETYAUIbU7h6A94oqXpPzyN7PGyKN1UO+IsKxbs=
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
Subject: Re: [PATCH net 5/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (V)
In-Reply-To: <20260423102324.3172448-6-edumazet@google.com>
References: <20260423102324.3172448-1-edumazet@google.com>
 <20260423102324.3172448-6-edumazet@google.com>
Date: Thu, 23 Apr 2026 14:12:48 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y0idx4cf.fsf@toke.dk>
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
> In this final patch, I add READ_ONCE()/WRITE_ONCE() annotations
> for cparams.target and cparams.interval.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
