Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365A4E73B2
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773063; cv=none; b=bqwVEMymkNqOuViJHI3heSCwlJiGrB8lGJU0mHhCBawCvnY3neOM1V3m2CIKa/cgzMQwNLUjhs8JC+MjEdum8es0SEixzWzMBe0CZwUiUk4BTxzHmWYArFsMhhx5XmqpbEPY3YXCqQb3bLrDqXuG+ZXIZo6Fa79UUBdTbxPi6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773063; c=relaxed/simple;
	bh=yJ+AMpqp+M649wqJ21a9igcmGHvNhmj3mxfY3dnvOVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A527W+OPzpcUbdKMx8ZmGo+wnkrNMUDk8ZiMPIRc+VXcepqrG2uGHrBm4vGhw8R1pFDEQnaEhNfHTow2u5Gb8ILKFpvJppnvsDcQuiWsWvWwnUXea5wdNq1o6vJit5Mw6xCOYGvyreHBnnSFazzKrwfju3Y8a/n6lPjN+gbaglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=SQ8cC3iI; arc=none smtp.client-ip=62.149.156.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="SQ8cC3iI"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id BtsLxxWBIxUh5BtsMxWDW9; Wed, 30 Sep 2026 14:57:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790773055; bh=yJ+AMpqp+M649wqJ21a9igcmGHvNhmj3mxfY3dnvOVg=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=SQ8cC3iItzSoPptC+T0sbCuoEHs+aBv0zXHCKACRmbKtMjRGA/b8zxQdF0mO2CY1+
	 5KGPbnHjXUYgYHajVnTtt5aHXq8hN23qLqqWzPnIa+IHXJiS/DOfkOoakov70C6y7w
	 8E7TjxmLFaauLYNUysLoQ4KvIiAjoD5ckDAGReZJddyTNNv9dVe1UN5UpGbFLPn9im
	 A6ckTnzdAoYZzSsMo9AzoY49azjPoiQF9z3qG6woFr+xJP0bc9SNMJunRdaiXDgnIk
	 x1FfwdqnDGOQD4B7lPTkD6LzzWkyDYtPaJ+fmFjcGg5twD3WBglx9wZiPh3lsKCGfA
	 xl2L74g9PoZjw==
Message-ID: <a2db0e1b-0796-499d-ba9c-dff749f9dc1d@enneenne.com>
Date: Wed, 30 Sep 2026 14:57:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] pps: Drop the !NO_HZ_COMMON dependency from
 NTP_PPS
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
 <20260829210041.40649-3-dwmw2@infradead.org>
 <f6e90a49-8c68-42e6-bdff-ea9b3ecbaf7b@enneenne.com>
 <fc1ec38dbc3723f7aed73ebf3413e1d81c161228.camel@infradead.org>
 <7098f5d2-043d-464a-82d9-a105e4000c02@enneenne.com>
 <cb992b22907085c4ced8d9a35cd1c8836aad20ad.camel@infradead.org>
 <decd5d05-1373-4ddc-95bc-46b73d6f6b99@enneenne.com>
 <7f98cef0918465e8d6bc9e76d26afb8b12471773.camel@infradead.org>
 <a174957f-f414-42c9-80f9-5d60f448e044@enneenne.com>
 <3f15c68bce92c57821fba53c80aed7fce13cf8c0.camel@infradead.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <3f15c68bce92c57821fba53c80aed7fce13cf8c0.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGAFuaPf9QOYALJW9Pz217G1MMeWwLREY1Ih/k33cSMtm4xGekCoRi83TpX0gZ3kvem4CXGnzJ5FolHhIBm/JqFatmGKTLxFFiODQo0WE80Vwjem+oUZ
 2ciZAvcs6PfRBAyc21nn9fRlRWFUyIMctafUojSV+QyMnds3yZB7siPtz1cs7+fyI2De0hOqlwZiox0F1ElkM5rq7RVdmb28Cn2wHVltRRzSx3Wc5Z+YakNw
 K321gEW97AdSHUUuQen/HQz6cIW15NWkQwZ0LvnFMHeFL4IV/dCl9U04sL9/T8+WbRY1I82sAr6jjPp2+VpKFtj4U1onkWLa5cQ/f3mBOpWoe0mYcma1bb0x
 sh2+j/b0U3ESV8v1J3iNVE+//huz45QpH8765xfZ9SxFod1ShBjNY4mjr4M2CAzw7gHzmlYwbuxbGJ9wssvs+sr03P5lp0rrz6ZbAKt8Zfr7JnEhbyLM6PJ6
 I6yO/pDCYIGZwuEzD6RVW7A4lyIg4Lglq6F+IyHSt/7lsy2PV/xwc4gE64DbGtZpa0umQT8WCzsgPXGkFf3oltrCY+u4z+6/0jmOgxGpzBhbdZCtEHxUtjYV
 O4FbvCPrQAu93azE/Lj7sUp1

Hi David,

On 30/09/2026 03:28, David Woodhouse wrote:
> Ok, I have the series in the shape I want to test it now. I got caught
> up in more side quests around minimising ntp_error, which aren't
> *strictly* around hardpps or snapshots at all but it was annoying me.
>
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/timekeeping
> now has:
>
>  • timekeeping: Allow tick_length changes to apply mid-tick
>    (reduce a fairly gratuitous cause of ntp_error accumulation, when
>     we *account* for a rate change before it actually takes effect)
>
>  • timekeeping: Apply extrapolated ntp_error to clock snapshots
>    (you know this one; as discussed maybe it'll shift to later)
>
>  • timekeeping: Bound idle sleep while a phase slew is in flight
>    (even standard adjtime() was hosed for tickless and would keep
>     applying 500µs/s skew the whole time the system slept)
>
>  • timekeeping: Reinstate proportional correction of ntp_error
>    (because once I fix the above, we *can*)
>
>  • ntp: Recalculate skew_delta when the phase offset changes
>    (another gratuitous cause of ntp_error accumulation. If time_offset
>     goes away *while* we're skewing towards it, the continued skew
>     for the rest of the second is unwanted and goes to ntp_error.
>     Just... stop skewing!)
>
>  • arm64: Support inlined clocksource reads for the arch counter
>    (this seems like an oversight)
>
>  • timekeeping: Read the counter as early as possible in ktime_get_snapshot_id()
>    (as I said, those 20ns are in the noise... but you can have them
>     back anyway)
>
>  • pps: Drop the !NO_HZ_COMMON dependency from NTP_PPS
>    (Really, it isn't needed. This is working)
>
>  • pps: Always use ktime_get_snapshot_id() for pps_get_ts()
>    (I think I mostly eliminated ntp_error as a significant source of
>     discrepancies now, but this is still the right thing to do for
>     precision)

As you suggested on the 28th, wouldn't it be better to move "pps: Always
use ktime_get_snapshot_id() for pps_get_ts()" before "timekeeping: Apply
extrapolated ntp_error to clock snapshots"? So the PPS patch has no
visible effect on ts_real, and the change stays in the timekeeping
patch, where the chrony and ntpd people can judge it.

Ciao,

Rodolfo
