Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9A4EA368
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773069; cv=none; b=EVvDwpq9zDFM9OZVOXpcUOpN5pfTyrLka8tYieBXlGENdoMMkSJKAp1rlzE8qOJ1Anumq9M8NRPtgWPRmU6c7R1cZyEvDbPOXNu8paYIMSBU5dbWyfEp38BR3iQ1U4oZICwQEZs+0qVvCUPpaFIlWxHkEe1l7B9w1XzOH6wC+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773069; c=relaxed/simple;
	bh=NLEFbG8BDC+qDCcLlMhXEiudTPwKaSSEY39srfy/RKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aIu1fs2J4XkQT+OfpQ7f8QmLIvWImOrayDmGx7wWgVNQObOE3jt5G8Q9UCDl4ZskC51I0XzxpKyGtFdWx/jqsrm3tuEOi11TwRrjQM00+/i6xbBjOOy1tSTxjVvBKIHe0v+KmhPzCaqAWwy4ki5zd0x3MvEwDhdFTWyqrsF5Bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=JHQGdjeB; arc=none smtp.client-ip=62.149.156.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="JHQGdjeB"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id BtsUxxWMexUh5BtsUxWDdB; Wed, 30 Sep 2026 14:57:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790773063; bh=NLEFbG8BDC+qDCcLlMhXEiudTPwKaSSEY39srfy/RKc=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=JHQGdjeB3T+ES/jctnM5l9P2xfPXlkfHlE5yyES/X4bPEsrW9Cfpc/3/vUYt+Ympu
	 HxIak4VJBO5I2Dy353ZZ00TVPTOhZay3Vy+XxF8+sAKxwwJicPPAWKi0J3W6BCoDxq
	 YJAQN7Mu7zZsiIBR5yyMwUlQNsUjOCJlven1Shq8kQbAPQaEvfcJZKK/uJKp0TrNkr
	 DYM3HurSD1nZwWvBwiIOQWU4BdfoXCOrt91qUCHzAcF/eFTPXLiO22tRIHvICcbcHA
	 FbsHTlT6bJy3JzeC0fSM5+u4KIZreQs/GP8sb+/OPLb8PQtQGnBYdZ7K4FrnWnPY/K
	 ehkpXmugek9UQ==
Message-ID: <fc473eab-c72e-4641-b617-8f22389c8f68@enneenne.com>
Date: Wed, 30 Sep 2026 14:57:42 +0200
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
 <37ad7bb611c0e79840dfdb5c3706be3430c34bb4.camel@infradead.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <37ad7bb611c0e79840dfdb5c3706be3430c34bb4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOs606fkAnRViiT9dh9FtZlBosfsbRugn1aJbyQs2U5ai7KYznOah/2pJCkKCABXwJCmc+oCJ5ZrJWH4V5pB+tvsFzyIlB/xwdFpn0DiyuQpxTEJ8/7f
 yyt32uZgk1QzuOSH6XoYObrP3znfOfDU1qL3aagP0di6FJ2dft3gNqZjaPJtE5zMgn6owZYzuglXfgblf9J6qed50bmTGilMCkB+Yla3jfGf/OfGmMpD3m4K
 bDQwUDQbnw4e8/yOec9wPpGm4GWGDKM98WSCHCm7In2Bz0DUC4bwh0o3qnOcCxGTKvovxOWSH1JBiaTrhL4syPTrUw2cmVto4G+2AFscNXSDKlGEN78RzMHI
 fNTyGD9/dCahRMXHTZPJGUYKTz5kGUtxx4965bJEFsIkIStEIcuQCUswZmzXwFtZ7PoUhnSF0oswWc4nEw9fpX+SZBY9yZm+OdTu4CHGctYMI0GxgfahkMxo
 B+aYLUiSmD+WuOCcQLjtieEmpD+rwp1OqS2rgICDdIST6pkw1xa5eol+qCWxKVA87Dhy+YgFQUX+Junq9pDOykgE6wGTqJJ3scnarewmuUy5McMKDP2FdKc0
 zcPzHR8tR8v6WvLt+wZien7U

Hi David,

On 30/09/2026 12:37, David Woodhouse wrote:
> Three parts of the 2x2 grid are now at
>  • https://david.woodhou.se/ntptest-r64/tickful-1hz/
>  • https://david.woodhou.se/ntptest-r64/tickless-1hz/
>  • https://david.woodhou.se/ntptest-r64/tickless-5s/
>
> The fourth is running now, about 90 minutes in. After which I might
> play with that IRQF_HWTIMESTAMP thing, because they're *all* seeing a
> bunch of late pulses (and the tickless ones are doing all the
> timekeeping catchup before they even capture the pulse timestamp, some
> of which gets hidden as common mode latency):
>
>   ┌────────────────┬────────┬─────────┬─────────┬────────┐
>   │      cell      │  p50   │   p95   │   p99   │ >3 µs  │
>   ├────────────────┼────────┼─────────┼─────────┼────────┤
>   │ tickless, 5 s  │ 728 ns │ 4188 ns │ 4847 ns │ 14.5 % │
>   ├────────────────┼────────┼─────────┼─────────┼────────┤
>   │ tickless, 1 Hz │ 294 ns │ 2258 ns │ 4837 ns │ 3.6 %  │
>   ├────────────────┼────────┼─────────┼─────────┼────────┤
>   │ tickful, 1 Hz  │ 84 ns  │ 1206 ns │ 4012 ns │ 2.0 %  │
>   └────────────────┴────────┴─────────┴─────────┴────────┘
>
> But ultimately, the hardpps discipline appears to be working fine with
> full nohz idle, even when we dial down the pulse *itself* to 0.2Hz to
> actually let the box sleep for 5s at a time.

Thanks for running the whole grid.

Could you put these numbers, with the fourth cell once it is done, in
the commit message of 2/4? They show both that hardpps works on a
tickless kernel and what it costs in timestamp latency, which is what
someone enabling NTP_PPS there will want to know.

At this point it could be fine for me, but before acking I'd like to
hear from the userland side, Miroslav for chrony and the ntpd folks,
since the change in ts_real is theirs to judge.

Ciao,

Rodolfo
