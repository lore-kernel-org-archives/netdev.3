Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87E3EB801
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946263; cv=none; b=iVoBpA0fhB07Q2s/gMg/K+rb7ynTcI7shZcK0TzEYuBxqH8D/v6AlinsRB77q1/GS/ODkTKVmi/7r+eWcj8wVS1L7CeuDGJQMJWlI4BAs3iNWSL/82awUPaGCstPR7catErb9PjEiiuVdwQNFY6l9jKyp55syDs+d6CWOd3jaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946263; c=relaxed/simple;
	bh=KhWqerK0DY5rV1yBA2kJutYqkWJchjpI1tdRUFnxflM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dBIYMxni7WmgumcKZfzPWegJTF3G12OJHCzcQrKi6faPoLtc8yBqn3P8yI3DPK76Lq52icNdnKCdkqEWGStD1cKT+uiQu9rOFwf0bem0jGG5RGCm113TZhyMsdWs5Dgml2gNc+jWjK+SPnVT3y84cHnWma8YHwMEam749+WSbc0=
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
Subject: Re: [PATCH net 3/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (III)
In-Reply-To: <20260423102324.3172448-4-edumazet@google.com>
References: <20260423102324.3172448-1-edumazet@google.com>
 <20260423102324.3172448-4-edumazet@google.com>
Date: Thu, 23 Apr 2026 14:11:00 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874il1yizv.fsf@toke.dk>
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
> In this third patch, I add READ_ONCE()/WRITE_ONCE() annotations
> for the following fields:
>
> - packets
> - tin_dropped
> - tin_ecn_mark
> - ack_drops
> - peak_delay
> - avge_delay
> - base_delay
>
> Other annotations are added in following patches, to ease code review.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
