Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353142;
	b=AZTtaBfMM5Be8dD+YO5RBv7STdVPjhYwhRbMdIMBk/8Afg4oqxQ/svcF9fyd6UpW7Yd4
	 qvDa6IaqxCcZsbugDM3UiIAZ3hq3ykSM2cSG/YsP9LbxX7HTvnlX4yS/xwgVlaXikTgMB
	 qLqxUAv/wXWBHT/wCn9iktOjri9X0B+LJjbV0cRZMac1gQhOWd6hiE2NtmUavHkSbs7Ka
	 7TXZJQNQlRwQcYxpHgGqcoWi59ctb6Aa9r527ZGQ680v7tWtEhtdC8pL8eoxj3xaMzsPw
	 /UALC1ep6noYN173qOc5e9SvZfz5i4pDztNccJNJXSfG76edpTCgh+mCS6Z3kOqAxUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353142;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kzuVvzEBMW2diGcIYuw1BYGN+uSaHFkI+ufWEuT8wi0=;
	b=yHzBIqwJu8S/GQUIKtQGhJL3LoFrjUlibLY6Oh98NWj06lyiZxMk0/GpsYk2kuRIltEd
	 t9QaR93PhDa9rew7/RmD7bShYdfz9rxG3R3V6hJtSZJT3XMqWgBxEyITGxAPOqpAb3+YI
	 OW0ysRQclwhEEU89M0xr7uLzNn80RXZy3RY/6oJcvqAJ3Fku8P+n4H4YCEGuhAGZfo2ab
	 bhzsKenNBNCkTGiKvNo/FvnM1dq/WenPVLRewutOwO6s7uwIjt7+7wQSn3auUqpTpj1yn
	 Oe9QJXF821DJPKInoPGmWv81zoQi2pr/ce8LV8kS26xOavkMe8PjLPY4FPCmc93nmXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b630V1FH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2827606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b630V1FH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B571F0093C;
	Tue, 10 Nov 2026 23:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353142;
	bh=kzuVvzEBMW2diGcIYuw1BYGN+uSaHFkI+ufWEuT8wi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b630V1FHCsB+olWrNaLCZCLM7XV4quMA4lPj4P2hnceNnri5kt53DxSRALfqmOOUZ
	 Aw0yMkrMsS5k3aHLPpHg1IgbfJ/no949+ZfTyJ+RcYO1gB8woTg5Uj9WfR6bjUY6Ug
	 sp4i5WSku0WlwmXQeVzpMQh+0XCwCtJkxttwELkz3i4ye1Ka9GjYuqEjv9vzLRgP19
	 OjIJ6WaUd3TdVGsQnduVBLK7LnrPgAC4jkqAXm07PORYCg0oUepqHYAs5wGUwVA1Gr
	 4KNXo6qRlYXn2B/qufzzLEuXbdCyen/N1c4wRFxoN80rcwDYsBMtv5qOTijh5nja8f
	 3H0Uc2PPBolqQ==
Date: Tue, 10 Nov 2026 15:25:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev-bot+sinfo@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] net: Fix memory_allocated leak in
 __sk_mem_raise_allocated().
Message-ID: <20261110152541.04462dda@kernel.org>
In-Reply-To: <CAAVpQUCYHbdAdfxckQO=T5L8Y6896SZynJeGFUwP9Hv2dXDpTw@mail.gmail.com>
References: <20261105212905.3122712-1-kuniyu@google.com>
	<179391463924.488859.10033550397120765032@kernel.org>
	<CAAVpQUCYHbdAdfxckQO=T5L8Y6896SZynJeGFUwP9Hv2dXDpTw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 13:45:21 -0800 Kuniyuki Iwashima wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection).  
> 
> "Found this while converting sk_memcg to obj_cgroup."

I assume you mean to imply that this sentence answers the question of
whether it was triggered, but either I'm too limited or it doesn't.
It only explains how you find the issue, which is _not_ what the bot
is asking.

> > If it was triggered please include
> >    the symptoms, like the stack trace or error messages.  
> 
> "Then, if mem_cgroup_sk_charge() succeeds, sk_prot_mem_limits()
> checks are bypassed, and if mem_cgroup_sk_charge() fails,
> sk_memory_allocated_sub() is not called, leaking counters."

"symptoms" mean dmesg basically. Please suggest better phrasing,
if you can think of it. 
