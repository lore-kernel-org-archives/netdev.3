Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F0233D9E;
	Wed, 29 Apr 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464827; cv=none; b=fhwQ1uyHW/UWYofx2J8HU/9InbBZhJX0flOqs5xO+Tb0T0INWIsmCYdd40FN70Kp03Q/OukHyihwFDi+nkKUuXA3ILMF9qo2UQbXXBaJJJPVmtYuS7+Uj2jDIMXWVXgK7oux38x9haK39XPRBwgwmdBls8a2thN662wnnj8aNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464827; c=relaxed/simple;
	bh=YgfhusDbmypFyboMX5KBAWajcI3SDsTVHoY1eSLksyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iS3u8mvY2bZUXmWK3cfDxLiRFWhVDlCeVl4lMu5kTO+mvyo/bHodMxSuQg/dF5WOkmzmtyMiDTneFEKKOExUbPaiRNiy8sNdf97D4YXSMi/uweNjtzSOc82xCy7RRm9IfHTYu0v+YjSsKxk8ONUBrPPc3QjF6PWFK+WJnusFDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMOdbp2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMOdbp2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412BCC19425;
	Wed, 29 Apr 2026 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777464826;
	bh=YgfhusDbmypFyboMX5KBAWajcI3SDsTVHoY1eSLksyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UMOdbp2pgNSfq7Y85sU8OdB5gWkj2gJPlg5sMLILBUkW1aBV+YSXPYKxIuoiDXWje
	 Q3r5/EAwetqH7SidBtQVFTgns8N+KFF+WDdUNDeL8zBeVMwK1KErlvrCj/n9bhTjYp
	 cSj9A67e0aZmt0xhknXJASk6tOn2WPwfL99L4MNyr2HI/Kr9VHMq8GQAJg6tmjwoI6
	 BNetgist0Z5tykn29lh0iqFLyZA4eq/EAymrrmjMcl7cYkLw9HKMy8GzWB1XH/+lSN
	 B2/OR4YKGL0RWsrgKb7nHHmJE/3nUobElCxagLT3jHjsMk82qvjnIBwvEwPvQUSGs2
	 r5MmoDGMwEShQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Karsten
 <mkarsten@uwaterloo.ca>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Joe Damato <joe@dama.to>, Frederik Deweerdt
 <fdeweerdt@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
In-Reply-To: <36csl4lgsy3psknzdpssq4zc2zsy36negybhhvfhozthhnmfl4@c6y75w6udaiv>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-3-dtatulea@nvidia.com>
 <20260428173844.1354aabe@kernel.org>
 <36csl4lgsy3psknzdpssq4zc2zsy36negybhhvfhozthhnmfl4@c6y75w6udaiv>
Date: Wed, 29 Apr 2026 14:13:43 +0200
Message-ID: <87o6j2hslk.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dragos Tatulea <dtatulea@nvidia.com> writes:

> On Tue, Apr 28, 2026 at 05:38:44PM -0700, Jakub Kicinski wrote:
>> On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:
>> > +	local_irq_save(flags);
>> > +	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
>> > +		      HRTIMER_MODE_REL_PINNED);
>> >  	clear_bit(NAPI_STATE_SCHED, &napi->state);
>> > +	local_irq_restore(flags);
>>=20
>> I don't think disabling IRQ is necessary?
>> Isn't it legal to clear the bit first then schedule the timer?
>> The timer does not own the napi instance.
>
> Isn't the following scenario possible (but extremely unlikely)?
>
> 1. busy_poll_stop(): napi timer is schedueled.
> 2. Hard irq pre-empts busy_poll_stop() and takes an unusually long time.
> 4. napi timer triggers (also hard irq), napi_watchdog() skips schedule
>    because NAPI_STATE_SCHED is set.
> 5. busy_poll_stop(): NAPI_STATE_SCHED gets cleared.

(Nice work finding the bug! I had to jog my memory to understand the
gnarly busy-poll details again!)

You're right that you need the save/restore if you do arm timer/clear,
but not if you do what Jakub suggests.

  clear_bit(...);
  hrtimer_start();

That would also follow the scheme in napi_schedule_done(). (Note that
swapping arm/clear does mean that we can get a wasted-timer outcome.)


Bj=C3=B6rn
