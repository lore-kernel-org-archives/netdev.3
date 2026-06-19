Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387523BE621;
	Fri, 19 Jun 2026 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900514; cv=none; b=EZgtm7TTipJwUpI2teK5e8xF3bT0M1SKZBjlm34XiAWDWY75486ONC/2NK4Nzx8/RZJEMXY3OZ9z16ft3mdIlB43MbzhbUY5mLOrP8qUZd0J0S7FQuyaclRUFXBd1eyRg9pe3sUmkrIFtYhIT66iRoYemfX2D38Pw9/sBVsqxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900514; c=relaxed/simple;
	bh=c3p30iJf6vP2vOevQUxWudo/fAEiOp4atg0sveRLH+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1v6FRcQqyiPODlLhYoW0Owc+m3Y3JfEUmWe9f7pwCTBYoiW32qNRYHsCQjDjMq71hc3ar0kb15gr09te/5N02GADqSpc4AjA/BwQzgedUr3VoqWyR6qscc1uKTPcFgOt0FzaUEDbCgQyc+5vH2G1+xCfHclZaKP0UJpM48DAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCXj6Ozq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCXj6Ozq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A701F000E9;
	Fri, 19 Jun 2026 20:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781900511;
	bh=KkQteI3i9sw2D6wj9D6uUuZHhc+JaXk42nvNrXHU0NE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fCXj6Ozq3kUcGxTtqjFc9BwaK7y7BTVm5drAoPiQGz6IQ1966Yxk43Y81csizQXum
	 0+qUpPERS3EDGcAYv6kcLl+82O/UZtWOmMs/YAEaZCFh8d/+xTr9avRd3JH+b7COx7
	 DAD7PeNZdafXzX5A3M+Ky9+GbjzkdTizms1kO7I8BDhXPlLtme7QK1l3azuJPjxy9N
	 qfdj8J+pKIIc9hUdcn/Fa9ilO4TUhX0Om/fTlEBorYN/cAtZoPts05QxWVf33U0T0z
	 f17n8Bq68JthX93gP1F/YFskQ5b1UfJ2avj9JYw4+Klmqot7+VceRX/fxu/6UapEH5
	 ZCrUO3u/EcXfw==
From: Thomas Gleixner <tglx@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [RFC] Enabling CONFIG_NTP_PPS for NOHZ by adding ntp_error to
 system_time_snapshot
In-Reply-To: <02564e5f0b6be4aeb6198af87b46269963985768.camel@infradead.org>
References: <3616fc9718614bf11915569599038a5bcb268c02.camel@infradead.org>
 <87h5myd56x.ffs@fw13>
 <02564e5f0b6be4aeb6198af87b46269963985768.camel@infradead.org>
Date: Fri, 19 Jun 2026 22:21:48 +0200
Message-ID: <87v7beb7s3.ffs@fw13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19 2026 at 16:34, David Woodhouse wrote:
> On Fri, 2026-06-19 at 15:34 +0200, Thomas Gleixner wrote:
>>=20
>> This formatting makes my brain hurt. Can you please split that out into
>> a separate function?
>
> Yep. There's also a potential error there =E2=80=94 an *additional* discr=
epancy
> comes from the enforced monotonicity that timekeeping_cycles_to_ns()
> applies (the case where it just returns tkr->xtime_nsec >> tkr_shift).
>
> I couldn't work out if I cared about the clocksource-is-non-monotonic
> casse, and even if I did, what I should do about it.

I think the right thing is just to ignore it.

The problem is very narrow and mostly related to the historically badly
synchronized TSC between sockets. The TSC_ADJUST fixup is obviously
error prone as it adjusts only to the point where the error is not
longer observable. But in the update transition phase it can result in
time going backwards because the readout on the other CPU is slightly
behind tk::tkr_mono::cycles_last. That happens only once in a while and
we talk about a very low single digit number of TSC cycles.

> I also wasn't sure if this should be a new CLOCK_REALTIME_NONMONOTONIC
> or something like that, such that e.g. PTP clients could *ask* for it.

Hell no!

> It's all very well hard-coding it in pps_get_ts() and unconditionally
> changing the behaviour... I *think* we could justify that. But the
> example I actually used in the patch was PTP, and that's slightly
> harder to justify the behavioural change.

Just leave it alone.

If the TSCs between sockets are slightly out of [mostly unobservable]
sync then if you don't hit this corner case at the edge of the update
then you have to live with that discrepancy anyway as you don't know
about it at all. So making a magic extra case for this unlikely event is
overkill. Due to speculation, caches etc. pp the snapshot is anyway in
that low single digit TSC cycles margin of inaccuracy.

Don't try to defeat reality and the underlying physics. Perfect is the
enemy of good.

Thanks,

        tglx
