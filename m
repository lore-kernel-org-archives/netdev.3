Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251E38F951
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666936; cv=none; b=P+QcPul/QcXKAZENyJKlb8gllJraCuxPY1VWEt3q5BIsleOqQ45yj+wS8YSWwulV4kxsLMqTJ+FQXrfGc+9yS/BSgaQc8ryhBnfYSS+N9DmnqQhFre6CATLGyhPbkiL/JAq7FzO1S5IEiVp5O2/N4oXfZxGHjqLydrWS6M27kNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666936; c=relaxed/simple;
	bh=eWJ8n/QLajUYFkBpkYxWY7XF8XCyaH6+HWQ9C505Nqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=to9suXMEnyB1/T3bAVsNInFqlsS6RXjV0rKoFlm8C/jd89Oj0E4E69jWjo2EEEj+c31k80URV5Om0CVbzaJTZw1TMw/mDDsV3CiDDZOVJxAwERkHCfxSg+gK07gGtHHFAK8uh3cXFQsYMiZd9T0xfjqr2jq8pJ5MyUhbOrkB3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Ido
 Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next 0/3] net/sched: changes around
 qdisc_qstats_qlen_backlog()
In-Reply-To: <20260513080853.1383975-1-edumazet@google.com>
References: <20260513080853.1383975-1-edumazet@google.com>
Date: Wed, 13 May 2026 12:08:46 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875x4ry635.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> First patch makes clear qdisc_qstats_qlen_backlog() runs locklessly.
>
> Second patch changes ioam6 to not acquire qdisc spinlock anymore.
>
> Third pach adds missing READ_ONCE()/WRITE_ONCE() annotations in hfsc.
>
> htb still needs fixes, I will take care of them separately.
>
> Eric Dumazet (3):
>   net/sched: qdisc_qstats_qlen_backlog() runs locklessly
>   net: ioam6: no longer acquire qdisc spinlock while calling
>     qdisc_qstats_qlen_backlog()
>   net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
>
>  include/net/sch_generic.h |  6 +++---
>  net/ipv6/ioam6.c          |  4 +---
>  net/sched/sch_hfsc.c      | 22 +++++++++++-----------
>  3 files changed, 15 insertions(+), 17 deletions(-)

For the series:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
