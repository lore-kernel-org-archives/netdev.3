Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A53F1042
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859782; cv=none; b=Ij430xZK78I+Go7E1cLttCLimaFBuFKXwBk7g9FcP971tS5RdjMd3NYVArgmeQH3kJy9x2KVZ0NuB4BxPw9f95r9rvQCFx0XLrNUXH59rlwdVh5uT5OSFXkwSqG6GnJ8zZW8djptG5NN3TYf6K+aGPk3EJXXcmHotP9vosgq0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859782; c=relaxed/simple;
	bh=WtiPzDoSOzG0T7Ywspf6pTI618IyJwZwx1GqXuQY7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVa/GbNI0kMYnHvWR90X7f0w8U1FcPRQANfn1Hc/+wnxjRPRk21UcVuNVla9GaNS3RVBRjFeL6rR8B6rrAalLjPO6RZGlALnNWehkQ/pYUCFloEVqzDy57ao7jV6CIhm1AFFw0fEEELQ/z7iP4VGz/b8ADszhbIzfgsFZr7sJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeMq4TAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeMq4TAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B989D1F00A3A;
	Thu, 27 Aug 2026 19:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859781;
	bh=kv4Hw3VNn5QJhvIE4Ouu8f0tz4L7ZJQ4RnfMELS9Lek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NeMq4TAPtSoT5kO3GNTVFa9vdKgVfsglrTOnfA+Flr+OFu9vSGSQq67BN4rA2cbAD
	 R4zhqiKLG76Bew0i/lsJDmdbsgU/SwCDjuk3my4HKr3m0WdmYWLH8Cm1Kw+4osevUB
	 VKn6ZhutLgtjYkcb7ZaQjjUSFOd1ueDLCBIY6znR25+Q+ViTFgsFAjhDOskLpEk+9e
	 wP+UJgLNqwF2SQ/+VSk4dInJVw3CDYyilt3CFLkC5uknnMXiFL+ffUY+okb4l67zfR
	 cOCggFEc85VlyGQ1u9NKj+GS0LzEJnosIN0ARsGqBS27BctV/Q6wMsDb8BZxKt1RYi
	 mJxRdMTcgxyfw==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 3/5] ipv6: mcast: fix delay calculation in igmp6_join_group()
Date: Thu, 27 Aug 2026 12:42:59 -0700
Message-ID: <20260827194259.4022994-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826103711.3302915-4-edumazet@google.com>
References: <20260826103711.3302915-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ipv6: mcast: fix delay calculation in igmp6_join_group()

igmp6_join_group() reused the remaining expiry of an already scheduled
report work as the new delay without bounding it. The patch initializes
delay to unsolicited_report_interval(ma->idev) and re-randomizes it with
get_random_u32_below(interval) whenever delay >= interval, matching
igmp6_group_queried().

No Link: tags present in the commit header.

Only the changelog wording looks questionable to me; the code change itself
reads correctly, so the diff hunks are omitted.

> 1. If the timer has already expired (timer.expires <= jiffies),
>    ma->mca_work.timer.expires - jiffies underflows to a very large
>    unsigned long value (~ULONG_MAX), causing mod_delayed_work() to
>    schedule the report weeks/months into the future.

[Severity: Medium]
Can mod_delayed_work() really push the report weeks or months out in this
case?

The delayed work layer converts the delay straight back into an absolute
expiry in __queue_delayed_work():

kernel/workqueue.c:__queue_delayed_work() {
	...
	timer->expires = jiffies + delay;
	...
}

With delay == expires_old - jiffies_old, that modular arithmetic gives back
expires_old, i.e. the same already-past expiry rather than a near-ULONG_MAX
value.

__queue_delayed_work() then calls add_timer_global()/add_timer_on(), which
end in __mod_timer(timer, timer->expires, ...) and calc_wheel_index():

kernel/time/timer.c:calc_wheel_index() {
	...
	} else if ((long) delta < 0) {
		idx = clk & LVL_MASK;
		*bucket_expiry = clk;
	} else {
		/*
		 * Force expire obscene large timeouts to expire at the
		 * capacity limit of the wheel.
		 */
		if (delta >= WHEEL_TIMEOUT_CUTOFF)
			expires = clk + WHEEL_TIMEOUT_MAX;
	...
}

A past expiry takes the (long) delta < 0 branch and lands in the current
bucket, so it fires at the next tick; the WHEEL_TIMEOUT_CUTOFF capping
branch is not reachable for a delta that is negative when read as signed.
add_timer()'s kerneldoc says the same thing:

kernel/time/timer.c:add_timer() {
 * If @timer->expires is already in the past @timer will be queued to
 * expire at the next timer tick.
}

So for case 1, is the actual symptom that the randomized delay is lost and
the second unsolicited report goes out on the next tick, right behind the
first one, rather than a report deferred for weeks or months? The stated
symptom implies dropped membership reports and multicast traffic loss, which
reads differently for anyone triaging this for stable.

Case 2 (a delay inherited from a query with a large maximum response delay
exceeding unsolicited_report_interval()) matches the code, and the clamp
added here covers both cases either way. Could the first paragraph be
reworded to describe the lost randomization and the reuse of the stale
expiry instead?
