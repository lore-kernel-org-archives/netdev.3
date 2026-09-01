Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4F30649C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277109; cv=none; b=bC/1s3ADa7QITgI8sjD/IH9wdX+vjYP1vwwE+zqCoinJdcxfWtKrQ/h1fqT+YYzINL2enylJhNQ2BSWhRkdT9IN1QBGOREHoy6TEg3MGXXex8xG7MC7pFaV8mYHASodLqdHSxHMRAcEPit4XNnRhZCVS6AXqCaAvpGSpNfyHiAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277109; c=relaxed/simple;
	bh=EPqBlV2EUIg57VOZkK1TawL0gnoM5lpfEtySKIA0WuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t5USI1RdR84Vh0gD0ZmDZ4+eOJxU3BoLszntRekjsHSibNGoQO5ZWH9InQ8dohBBaBacy3uuhtPyTbBNST/yWwJLs56vOfnvudagPdNNO4WPjgV1NEl0Kb57zzar32bMqVBtJjFabJEwFRZ2DXLI7CaWk8BiSpRgdJmjT/18cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=IMeDW01F; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="IMeDW01F"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id 1QW3xKghu5Ste1QW4xBgbv; Tue, 01 Sep 2026 17:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1788276917; bh=EPqBlV2EUIg57VOZkK1TawL0gnoM5lpfEtySKIA0WuY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=IMeDW01FYqXGUItM8QMd90JdtKguzOFUiTAMgr9mbr3GazuenoFq/ZMlAW6lN0v60
	 NhNVhGR1NUGy/J0kgnzbzswB76ZvqvbL5XeS+zW4XiP5fu56Uq12CmWuJUtlj9NBZj
	 GB6dNKtUoriYEHTva+RtATAhi+N5gmZH3OZh4XXwTN+jlQ2xWGt+taispAtvhQcVPf
	 DBjkeLEAEtEAC2Ii6JRQNmTvV/csP5GxP79XhnpJcB6aMOOZyNWfWB7+HkK+Rj+Ufi
	 cus7y1y2ldkdsGR5RHPGwjdOp5UVLfz/jDhia12tkxCt+S8VjK0noMWBKUqtcYbQnC
	 VlPDJ50m+knwQ==
Message-ID: <5e4bb110-6f4f-433a-b025-2cf89f8362ab@enneenne.com>
Date: Tue, 1 Sep 2026 17:35:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add ntp_error to clock snapshot, enable NTP_PPS on
 tickless kernel
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
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260829210041.40649-1-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHfB65E8iMQe8GHPxxffuK8xALInhDTjR1W0XHnojAgymlqT6VaNRSldSPEYmpWm08zkFcJzh0+HvkIyJpDCjOquAIqOQWghZGgIwkDYW12ic9P0sDer
 At9ZpJfI2npz+pJ9Jz6xcHLW+iky4974MWXc60V6ReUL2cmMaqftwGGHQuIYbgXvQdXK+YH3HQkh133xe7xGWQgNl+/NydA7xWwqjM6uIjrIlbB4sLFBO0/R
 1E+bNhOS5N1gKwTraHyOvobph55ZJtH3HEMYGqPmI6W6CuKHNq5UO3lGnRoQ9OyEtDLWZsHTkelXtjvx/49Pw9AUEprj6KRFLkRNUMi3ZIpSOEcKAKaUAerm
 vmtwgvZpsD+vjVw/F9Poy/+aP+WSZjDcEXKnu5E2x1ZZIPSzXLkUYXgt0N4lkvJibV6x7srXGEkwVQ3gdvckNkgubxblZO2rUpYTVG50Zyd1LPheFX8kHsBD
 rcHOz28OapKVZkXgeAnfNqe7R/M+lANoyKvlLIOEnVy6paKhmDwGW7Clajf0Nr0sgMZWyvPkv6vnpXlmyet5jYSiQGTaQS1XTFZd4Oq42DdY/4rtFNV4wVzH
 XW+u5Dn85EYoSpZIN6UeaR/p

On Sat, 2026-08-29 at 21:56 +0100, David Woodhouse wrote:
> With this change, CONFIG_NTP_PPS works correctly on a tickless kernel;
> enable it. And change the non-CONFIG_NTP_PPS code path in pps_get_ts()
> to use ktime_get_snapshot_id() too, for the more accurate data.

Thanks for respinning. The idea is good, the !NO_HZ_COMMON dependency
has needed attention since 2011. Comments on 2/4 and 3/4 go in
separate mails. Here the general ones.

The series does not apply to mainline (v7.1-13176-g840ef6c78e6a). It
is written against some timekeeping rework that is not merged yet,
and there is no base-commit: and no word about which tree to use.
Please repost with "git format-patch --base=".

There is no changelog. Where are the v3 -> v4 notes? And why is this
now PATCH and no longer RFC?

3/4 does nothing at all without 1/4: it changes no timestamp value,
only the cost. So the series has to go through tip/timers as a unit,
not with the PPS bits going via Andrew separately.

1/4 itself is not mine to judge. It changes ::systime for every user of
ktime_get_snapshot_id() and get_device_system_crosststamp(), not only
PPS. Whether that is the right value for ptp4l and phc2sys is for
Richard and the PTP people to say. I raise it only because I want that
decision made explicitly, not inherited from a PPS series.

> Tested with a hack to make vmclock simulate a 1PPS signal, although there
> are now better options for that. But it's enough to show that even the
> tickless kernel converges to [...] the PPS signal and remains there
> (tested with a periodic PTP_SYS_OFFSET_EXTENDED to compare with the
> vmclock reference).

It is not enough. 4/4 takes the pulse from the same counter the
timekeeping reads, so there is no independent reference in the test at
all. Converging to +0ns against your own clock source proves very
little, and it says nothing about hardpps() driven by a real pulse.

You are asking me to undo something that has stood for fifteen years.
I am not going to ack that on this evidence. :) What I want to see
instead is in my reply to 2/4.

Rodolfo
