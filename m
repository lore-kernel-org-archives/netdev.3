Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE134D382
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924836; cv=none; b=LxUk9kGi5hPbcS9eySEs6Ip0XdAxdDTaCRD1sbide2i96sIWYVvBHKnpc83Rw5vVZtJ1XFYmPopl6m3D7EI4iFK8P57rB7QHotkfWQROxipSneOqOyD6pzcGAbearrVYeXkYFXRa3ZJJjwDfH829QLe+lBkPEQx4suplu/CXgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924836; c=relaxed/simple;
	bh=8Kq1JLz5JD+AYs8jTUJp1zVK8kB22uq7gMAKi38hWdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqM/ZhZyL17APiP9gJ+xUSm35EGcnhT4pKyIzgjn34ehEWMQZrWUY5K5TV2Cu0Ji7V/6bAAgtZe/WD+qLU3RUd4sjXa9MS/x0n8ijjfEpmcxFIaIdSRH7YLcirZQYSCos2nYZX0uHUTH6sa+YScf7lhZ/coHEEVNSdZGJKTzOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=V5dV7XCD; arc=none smtp.client-ip=62.149.158.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="V5dV7XCD"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id CXJLxfVaxXmotCXJMx3D2Z; Fri, 02 Oct 2026 09:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790924645; bh=8Kq1JLz5JD+AYs8jTUJp1zVK8kB22uq7gMAKi38hWdg=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=V5dV7XCDlkFhDc6EhQHPfuVyMH/Jtda4rLCustGjSPtW/O/jTrpav1Hj9t6AHU/5p
	 YxVeHkZOrh72hei1m2ZDayMOjZhCtwwmQ4crjCA0Zd9wj+GOx7YVuCp5mTXukU/Ikb
	 T89iBjQMpxO1F6gckuME/qbBGFt+pcdzsXiTYRNDI+jwMbrAcH9gApxU7DezA77J9E
	 AmhwjnR1W2IxNctTxZjiXaSxVdc/v19jiFUqGATsouduNCxvvVNeJGgi5HyKYCvXzg
	 dOSVpKuy9QWcyLzOLOkZs8nlH/G33Pnr/EwmcFyn1syvAqayCxGwECMwU17SYWosMu
	 BzY4rxLIQ9qMA==
Message-ID: <b567acf8-c3e3-4b51-99a8-058ab42f3026@enneenne.com>
Date: Fri, 2 Oct 2026 09:04:03 +0200
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
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260829210041.40649-1-dwmw2@infradead.org>
 <20260829210041.40649-4-dwmw2@infradead.org>
 <920a2d70-c1ec-452b-8fc4-aebf1f6af412@enneenne.com>
 <d1af17dff1d6f181d74edd3b6358398469d61917.camel@infradead.org>
 <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
 <ar5cq0vslvQ00Pek@localhost>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <ar5cq0vslvQ00Pek@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLVksAyqsJ4qsACPeEYUOoad1jqeDXmmCGhR1HeGvNfx1iqpK02OcibkwQHzfCBiX4QCOVUiKf7OAv9OHCBxU9zLOEOqAB0ALM+4zLJ6cqgMQDC11Z9J
 7sw8tLQ/Yt+F2w8CsZZqVrxIFW+N4X0bfuqPzF7iHRHlaJKGsEdG83hmqw/P+8PAa6onzIWHvaVIaZ+HHN4e08SgN5aNIS6HdQnAZE3jarAb4JcKJYblt9e6
 XgoB2bTkxu0389WWxo+zYojBXAWmp+hLYUZinba9OZ5XqJS5G0ciaixwJlSCiPqkTH89xqjGdP1sClP+ke7mNCFyRKYQz0d4WxXyuFLdF8WJg80YfxfgJlzJ
 w2knqCeHPqIPZ+mnlAnmk2H6UmH+DtBICEAFvEHDHheBFFBz1i+rWjtCVtWG9Lje1zS2xre+CoiG9TL8Ec/jw1JlW7Xg4G/q6fgAfbSN0P2SeYT4R/hHmVWb
 tJwoPkPdMGj/odu2lGJjrjI1m1KAzWq4NIUNzaHtgw5Q8iZX8Wscn58dG0Af5jlcC9FXpixJXcY3vd6Vc6Ar5ekI5r9zIOPFrodBIfP4QJ0Iv9h539RWwdNt
 6C2Qrvuom0I8WJFG3sybSLFp

On 01/10/2026 15:14, Miroslav Lichvar wrote:
> On Mon, Sep 28, 2026 at 09:58:02AM +0200, Rodolfo Giometti wrote:
>> On Sat, 2026-09-26 at 21:38 +0100, David Woodhouse wrote:
>>> So yes, the specific code path you're looking at *does* get slightly
>>> longer (50ns to the counter read instead of 30ns).
>> [...]
>>> However, they are *entirely* in the noise, as there's about 600 ns of
>>> hardware and 2-4 *microseconds* of software latency before we even get
>>> there.
>>
>> Thanks for measuring it, and on real hardware with a real edge. That
>> answers my concern: ~20 ns of constant cost against microseconds of
>> latency upstream of the handler is not something PPS can see, and
>> trading it for the removal of a non-constant error is the right
>> trade.
> 
> FWIW, there are some polling versions of the pps-gpio driver (out of
> tree), which provide much more stable measurements by trading
> interrupts for higher CPU use and where this additional delay might be
> visible.
>

If polling gives that much better stability, I'd be glad to have it in
drivers/pps/clients, as a mode of pps-gpio or as a client of its own.
Its timestamping needs would then be part of the discussion about the
timestamping interface started in the 2/4 thread.

Do you see the extra delay there as a shift of the offset or as more
jitter?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
