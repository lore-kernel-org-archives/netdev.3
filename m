Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2C4E36C6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613883; cv=none; b=Ze/53ER+DPxCA6Ucu3Nj6LmN9Um8pyuDPDkoM7QegU9/BRFeRAIOk+gp22uS1GdMaf38ZlURy9AaDLtIW0qKu+ZaiHpGHUDkfltlK8I6hFw5i+sbimkFVrUrecs/QAkaHMKYJV/0fOdb/EszKjdh4V+UgY96B4WAzjj22RBemfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613883; c=relaxed/simple;
	bh=AC6+tFMzXdKskA8S8jt2sm1Xgv6hj813Iiqi0b3dCqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DjOcTRqubyWi3yyIvuFsFaVZVGgbfhVrcf2IRNfIUfQoXQPd6VEsgPs6gDk7sfP1SnuY5gv5Gqyy3DGyUQl0K4TiiOSTMfUdpC1iAuviGZnSoIPl3eCjqkOPQKreRZSHknFgnDQN0Wr8JjIvS/fyajWFaG7HGRiiUogyNCNmWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=AplXT1Lz; arc=none smtp.client-ip=62.149.158.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="AplXT1Lz"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id BEPxxBNV9rqLfBEPxx8lpo; Mon, 28 Sep 2026 18:41:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790613690; bh=AC6+tFMzXdKskA8S8jt2sm1Xgv6hj813Iiqi0b3dCqY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=AplXT1LzXmZGGkO/fk7TyeLoa4XE2+rZXeSC3sEcgRflcOhlnvwwbFd2nhm3sOUgM
	 qItU0PLo8SqdpihNqwLm/mT1mLwCaub73jr9ar/IDzic6nnc8l1WJEoYb2U0D0CGw/
	 rx4rPHUSaP9v8VxhxoWxgcDolciAId3nzh///FkVeILxzU1yA7Gq1M3BZ6KOjW0NSy
	 idwlVmrZpTvqS9zGlNdi0QYYp0aEbHIcWV+VlSaLy1wqB3zXx5NcQ15iI5EcPIbvJq
	 hvWm1NlFeojgRVJVMiw7sRSGM8D9j5wBmtv+V5ynkZflbebU4b2qfywYURy5H5OMCK
	 CrTEO0JIC9iOQ==
Message-ID: <2ccdc198-8284-4a6c-8afd-32dafbaf27cf@enneenne.com>
Date: Mon, 28 Sep 2026 18:41:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] pps: Always use ktime_get_snapshot_id() for
 pps_get_ts()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260829210041.40649-1-dwmw2@infradead.org>
 <20260829210041.40649-4-dwmw2@infradead.org>
 <920a2d70-c1ec-452b-8fc4-aebf1f6af412@enneenne.com>
 <d1af17dff1d6f181d74edd3b6358398469d61917.camel@infradead.org>
 <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
 <aa9a0ec325a0cff908d19542b71b780424a4af30.camel@infradead.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <aa9a0ec325a0cff908d19542b71b780424a4af30.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEmvwZHg2eI7Ms2sW9fTCyDdCgjM36bA9ss0XMZesxjPI/4Qs8GJMFp+iDQcvabXqWclRkWlfK8lf1I2OB3mCszx4oX8H9nJfSRW0KQHGwGTZszOsbz9
 /N0VuleieZi5k4lZTsQctpZw6eQCNPK+m4rZt5BeOLFmGnp0ydmojiiP8nXxQVOrtPP3QtooWWXn2CbGmNZj59kpL4nG2D/sjPsAONJCgpR7GZvpLlDU8FLo
 s86FWdBHUWLBJkr+O3mv/fB+5QZY146IMob14FTxflFHliFj0JmhoIO3B9q0EptpZK2mg14BPFjwwUTl7UH/L1lTzqQopOSY8NAfqsy+YHNSmjSqJLwFmqhR
 sXdE95FbmoQHKaPSXXTAyaVqXXRgoXO28sThn7HAMZjmSwDXdtJLhzwQnW0K4HzWWc3tvMfd5O9i+fQOJapPu0264XbosCqSgp0SQAoSwnJ9BBfbG3QJ6pA3
 ZyQfVW7i8JCWPvl+MhwEVBXVfyEyV7BR3RmSwW9DPyS/54vgVSESquykqc7kP4e8odQOZnGt5ryHHc/Z2+qIs66EMYsYGVjkI0ciW79QAn/zldvzGsf8PO88
 YhUx4Vr4pOr1cMaYHsrJF6d4

On Mon, 2026-09-28 at 13:59 +0100, David Woodhouse wrote:
> Theoretically, absent other bugs (qv), ntp_error should rarely be more
> than a few tens of nanoseconds and even that is the extreme case.
[...]
> However, I *have* seen (and fixed) the tick_length changes at chrony
> startup introducing 83µs into ntp_error, which would take *days* to
> drain through the normal ±1 dithering, and would screw up the actual
> frequency settings while it was draining.

Thanks, that gives the order of magnitude I was asking for. Tens of
nanoseconds is below what chrony or ntpd can resolve from a PPS
source, so in the normal case the two lines are indistinguishable.

I think the "Allow tick_length changes to apply mid-tick" fix should
land before (or together with) the patch applying ntp_error to the
snapshots, and the commit message of the latter should say so.

> I wonder if we should switch PPS to using ktime_get_snapshot_id() in an
> *earlier* patch, which wouldn't then include the behavioural change.
> Then the note in the 'Apply extrapolated error' patch can then cover
> PPS and we consider them all together.

Yes, please. That split works well for me:

- the patch switching pps_get_ts() to ktime_get_snapshot_id() is pure
   plumbing: ts_real keeps its current meaning, and its cost is the
   one you measured and I already accepted. I can ack that one;

- the semantic change then lives in "timekeeping: Apply extrapolated
   ntp_error to clock snapshots", covering PPS and the other snapshot
   users together. That is a timekeeping decision, and it is the patch
   where the chrony and ntpd maintainers should be Cc'ed and ack.

As a bonus the two changes can be bisected and reverted independently,
which helps if userspace does notice something.

> The PPS change does stand alone anyway — regardless of the snapshot
> *corrections*, I want PPS using snapshots so that it can report the
> actual *counter* values to userspace, like PTP is going to be able to.

That is new ABI for the PPS subsystem, so please post it as a separate
series, and I would like to see the proposed interface before the
code. Things I would want settled there: how userspace learns which
counter the value refers to (and what happens when the clocksource
changes), and that the existing ioctls and struct pps_ktime stay
unchanged for current users.

Please also keep RFC 2783 in mind: the PPS API is defined there and
LinuxPPS has to stay compliant with it, so the counter values should
come as an extension on top of it that RFC-based users (e.g.
time_pps_fetch() via timepps.h) can simply ignore.

> They shouldn't be compared directly with a clock_gettime() where
> userspace... is preempted and... calls into the vDSO to get the time...
> is preempted again and... eventually does something with that timestamp
> which it considers to be current, or worse paired with whatever happens
> before or after it.

Agreed for a single reading. My concern is systematic rather than
per-sample: chrony and ntpd do compare PPS timestamps with timestamps
taken from the sanitized clock (e.g. NTP packet timestamps), and a
slowly varying offset between the two lines does not average out the
way preemption jitter does. With ntp_error in the tens of nanoseconds
it is irrelevant; I just want the larger cases fixed first and
documented. I'll wait for Miroslav's opinion on the userspace side.

Ciao,

Rodolfo
