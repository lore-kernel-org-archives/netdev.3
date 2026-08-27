Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228C361959
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861302; cv=none; b=l2gqqFGob0yevwqf2Fy3gbMkuZtOUCZ0X92I34iNqUZZsq/xJJjMaMpM0iDT8zXyU5H11WfrjaAL/TivjzmuJIGbPeQGwkrFzAjD1UNFFFMICe9K6meBxl5ER0eQwFj3hEo7MtZIx7Ob+GMH44tYMqUA/8R1snGQ6atBw5C0yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861302; c=relaxed/simple;
	bh=eJWWkcQn6zFex8g4tzDJdYLweQBEUlGkwYFJdCKqkVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAXLkBoM+SOalDbLSHPvrmHBu184YlItJ4wiY1BOWcaurtJuNWlATErY3Hummxsio4jiBUVyJuv57m4j/LA+lNW0r0Ka98ez+FP8ArlxShn9U1ytBFfXItEOkzhbi4MdlTCOMVNntDkv1fEZjojJRfqt3X52ehcw7NsAOK9EjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw1r1K1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw1r1K1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EBA1F000E9;
	Thu, 27 Aug 2026 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787861300;
	bh=vIMYHFhVZS8xU7+9c6NV9j1AcxuVR7wd7Zas9PEvl6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zw1r1K1itZ6J8I8u4euZZtr7Ogtaqfxx2tTwQ4878Ql4Qtv97dQo0QKvixMJ0KHYQ
	 Dync8Bt9Fs4enZrxDX1rUcs7orMCna8n9YJblo3deHLVlLykD80eRgnR/JjxzobG96
	 Cx545viptUCJMB0VYqoO6HT7zzEGjtAA1RgP9x3tIaYDd0UFaqrrlHMHl7g0XmOd3q
	 YaKUX8xwSaAamnVqLbdTU2EIbs6DCBmFyscQ+gHOGMkXz/jjCBPYvUeC6BfWkfS146
	 Zm+v4DFnD22AoMW5U/uDzFs23yuHcAyarMFoQ6NSuO664TL1CeMsu9QjJLFZ1VP6sJ
	 S9R2FxHDUoedw==
Date: Thu, 27 Aug 2026 13:08:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net 3/5] ipv6: mcast: fix delay calculation in
 igmp6_join_group()
Message-ID: <20260827130819.293763e1@kernel.org>
In-Reply-To: <CANn89iJmape+9Nkf=U2vjydp89UPLvoyGh6wPusMFE_yLUoUeg@mail.gmail.com>
References: <20260826103711.3302915-4-edumazet@google.com>
	<20260827194259.4022994-1-kuba@kernel.org>
	<CANn89iJmape+9Nkf=U2vjydp89UPLvoyGh6wPusMFE_yLUoUeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 22:02:27 +0200 Eric Dumazet wrote:
> > So for case 1, is the actual symptom that the randomized delay is lost and
> > the second unsolicited report goes out on the next tick, right behind the
> > first one, rather than a report deferred for weeks or months? The stated
> > symptom implies dropped membership reports and multicast traffic loss, which
> > reads differently for anyone triaging this for stable.
> >
> > Case 2 (a delay inherited from a query with a large maximum response delay
> > exceeding unsolicited_report_interval()) matches the code, and the clamp
> > added here covers both cases either way. Could the first paragraph be
> > reworded to describe the lost randomization and the reuse of the stale
> > expiry instead?  
> 
> OK I can rephrase the changelog to:
> 
> 1. If the timer has already expired (timer.expires <= jiffies), the
>    stale expiry is reused by mod_delayed_work(), causing the second
>    unsolicited report to fire on the very next tick without a
>    randomized delay.
> 
> 2. If the timer was originally armed by a query with a large maximum
>    response delay, delay could exceed unsolicited_report_interval(ma->idev).
> 
> 
> Hopefully, all the AI agents will be happy this time.

Feel free to ignore, I hit send because of the complaint on patch 2.
I may have misunderstood but I read that one as "delete requires 
optmem headroom".
