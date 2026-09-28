Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2C466AED
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582295; cv=none; b=TtxD6m7S1apLDrFv9oAwpEOWQSf4KIsczjPeJ7r/MGN8d3NFXc3okyz2zL55jX+yVgmnZNc2A4kN6Q0eBtJRVNGwlfRa54MmzgcAQ/x+TT+Nzil633h/lyvu2jWo/YUafidQzabLgegWh+BI67W6SGLxWbVqKTMRjNBoXCgIdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582295; c=relaxed/simple;
	bh=FYiBSD2IKOEJoDyKbArro/hKFldwTHLZGK/L1fhcESA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ajXV19536UZmvssTrkx3KiD89rt3CAxxmbP3Ed3o7gxalfmWCeAFA4PDX47AUi9sdDOOeRElIrnOs5/3onEuC3yl/jzI4dR3tljciM4sXi61eBl8sPkFs+8FUuFhPzlhRo0nWyjDRP1idWpXn8iTb0BYORdyIIUN+/+os5x1hC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=YuW4Iawc; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="YuW4Iawc"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id B6FOx5k81Bm78B6FOxHNQS; Mon, 28 Sep 2026 09:58:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790582283; bh=FYiBSD2IKOEJoDyKbArro/hKFldwTHLZGK/L1fhcESA=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=YuW4IawcQq8pk7wS3YCjYspQ2SvginI0P0pqRyxka36V2ZuJuoGuJslgAL9Aj4b9j
	 WSj0sVmhIAPtSEVusYvhVS+o8rRm0yoNsSwPArvXnUvIVMU4sStoCCvYas/31NYHuk
	 mLjwzqFeOPQUc7tM2EA6eLhjDab5zk+uoqbBRIvvPtU1N64SrMsJo4FsmIDDqCQp/A
	 sy76dsb/6luu2jRlz8vDei1J4/jNKrqtqtRS0/dKKqc23Rza88VHMD2ptsuFo1YxAN
	 j4L/yoBTMmyUGbqtWJxGkXmlaBXQrG4InI/K2J46FNZZLKwVFuYES3tmwygrv37sWV
	 /5ZSw4UaUkJEw==
Message-ID: <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
Date: Mon, 28 Sep 2026 09:58:02 +0200
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
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <d1af17dff1d6f181d74edd3b6358398469d61917.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLK5gGeMJMuqtRHU1WYiSTU4sfsnaNAWMZlJRUIFuJCZ3nm3Mn6iMxq4CcBiOB5DzzqOjtsP7pT+QRzhQyWvBqrz9X+5T5E3gv9Uu+Ot9vRFbaccgecZ
 uL6NtK1DUuhxp6d9Vexi+R2T0baP0x0cbvMvP48cKhup5Wemas41Mze/9S7G2CvTgtId54HDNap/79fhYs2FKJSdi/6XThNXp7ut/MEFIJ3eBxiFUw8uvEPU
 5goQqo4HIrpb/PuVkifvA/PmuNHOAxUGviuW6srpbIoJje2al9BfLTVs+4ThJ7lM7GGAGWSzgRG1inyiFp3sxBtUccIxcVEuC8jUN1nNcnZkHWvF/tcHoZa9
 d7GEscpNQ0911tS8ARcEzGy/vRQdy9w/DzX5bRBRe3YlRBFsreAnKdLv5hWfeIkfmy9m1Ji8eF+cU2jaDBCuurawKOvA7UY7Gp3dOk9wnYe271aH3IEUcUlO
 xm9Z6aKEEI9O+Aw27a/VVjotJtUOFB/wwIpmKS5pUmLTQQkwZoaVOjVZYLNM8lWO5oEqPa45Jjxs7bWp15BTJb5kPOg3gHPTEKNp5ZQYgASgD0AuXAt8TzJF
 MLOpzKAtlXQkimB+x65Bjm5T

On Sat, 2026-09-26 at 21:38 +0100, David Woodhouse wrote:
> So yes, the specific code path you're looking at *does* get slightly
> longer (50ns to the counter read instead of 30ns).
[...]
> However, they are *entirely* in the noise, as there's about 600 ns of
> hardware and 2-4 *microseconds* of software latency before we even get
> there.

Thanks for measuring it, and on real hardware with a real edge. That
answers my concern: ~20 ns of constant cost against microseconds of
latency upstream of the handler is not something PPS can see, and
trading it for the removal of a non-constant error is the right
trade. It is arm64 rather than the 32-bit board I asked about, but I
accept the argument holds there too, since the software latency only
gets larger.

There is still one thing I want to be sure we agree on, about what
ts_real means for userspace.

Today, without CONFIG_NTP_PPS, ts_real comes from ktime_get_real_ts64(),
which is the same value userspace reads with
clock_gettime(CLOCK_REALTIME). A PPS timestamp and a clock_gettime()
reading are identical by construction: both are the sanitized clock.
With CONFIG_NTP_PPS the same held so far, since ktime_get_snapshot_id()
also returned the sanitized value.

After 1/4 and this patch that is no longer true. Your 1/4 says it
explicitly: callers of ktime_get_snapshot_id() now receive the ideal
time, "not the sanitized version provided to gettimeofday()". So ts_real
becomes the ideal line, while clock_gettime(CLOCK_REALTIME) keeps
returning the sanitized one, and the two differ by ntp_error at the
instant of the edge.

For hardpps this is clearly what we want, and your 1/4 and 2/4 make
that case. For userspace I am less sure. chrony and ntpd compare PPS
timestamps against other sources whose timestamps come from
clock_gettime(), i.e. from the sanitized clock, so after this series
the two would be referenced to different lines, ntp_error apart.
Miroslav, is that something chrony would notice? And David, how large
can that difference get in practice? Your 1/4 says the divergence can
span many ticks under NO_HZ.

Since the main users of ts_real are chrony and ntpd, not the kernel,
I would like an Acked-by from their maintainers before I ack this
patch. They are the ones who will have to live with the new semantics,
so they should know what is coming and agree with it.

So for v5 please put this in the commit message, not only in the
thread: why ktime_get_real_ts64() is inaccurate (the quantisation of
the multiplier), that ts_real is now the ideal NTP-disciplined time
rather than what clock_gettime() returns, the order of magnitude of
the difference, and a short summary of the latency numbers above.
Whoever runs git blame on pps_get_ts() in a few years should not have
to find this thread.

Ciao,

Rodolfo
