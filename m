Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A5517BCA
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682517; cv=none; b=oZd4g9YIQSoI8UXQueB0DCvviTn0m00lP3fZpaQfNqfWJR/HdonCe9hUh+9323f0P/tDXtjhf/lXxPyW8zl0oxA//Adb2lAcgmoJFLJBY071yjjzSMKK4J3UwTQ70QL0P/zwd259vTVmRy+gvXn7Z7GpjqpbCJJmYrsvQNDMPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682517; c=relaxed/simple;
	bh=ClJqhJuYYFJXOtWZBNSRYkjOnDQUjUrJcwaL8iAY8H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KABJEAQFq3txqf8kWS+erELZKQCSocSVFVM351YQmioyjg0g6LAcpWAZnoUnwSdZntuIxT+CjP4OJeuXyGMfZJd++mtHeDOYDHHSLkldT176qOHGjS0t403vjUG8x/ih+mn9Z1ekwZ5hGLZ82SHVKyDTLoepheOyLt00pkB3Ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=RX66vsdH; arc=none smtp.client-ip=62.149.155.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="RX66vsdH"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id BWJxxyTWW5bAIBWJyxBloq; Tue, 29 Sep 2026 13:48:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790682511; bh=ClJqhJuYYFJXOtWZBNSRYkjOnDQUjUrJcwaL8iAY8H8=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=RX66vsdHQzu/w9QPE8cthOSXdhEfO4I+qBLsnkLKSainue+r42MS4i4TjLVKHF3et
	 bbiLVPzqTtOds2IZIWLV/ITKMqddcK1O+//YoRVut8N/DFV8+VKThLK7B3gEjC88nE
	 IQoTrrkkxg3Uw4d5K2l9PUnCO7OFdoblgmEk7cLQzxxN+a5koJ4OwRwd7bz/0XfsaZ
	 91XfBCCwP+u/SaWSZz6XzFBvu8RlQi/YDplwX1q+qyjqCtLc7PKr8r7uwb07MTUP/k
	 VwvZOL17LcaGBgPWgbUbxQppy1l0vtLYYt+BtZ6HjrE/KsY7gLj8l6peH/PakxGGlx
	 OdZ/4ZmOhdziw==
Message-ID: <a174957f-f414-42c9-80f9-5d60f448e044@enneenne.com>
Date: Tue, 29 Sep 2026 13:48:29 +0200
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
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <7f98cef0918465e8d6bc9e76d26afb8b12471773.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC4b7vUfyBZo67Hz7JM35nLEWhFO+/yJBxfYYYyxuLVPrDpIaSm8ipwm7yTxUZKV7iRgBPjYrDAa9vxiMlw+CIUPVy3nkAQ1O2NEmsEcclXOmPEKkK/A
 vhlse6xsaHwUblv11GlzOGSI90FDdF79lS+AyXEhYm70q6aKY/iSuUBsYPN+CG04q/oedi7AqCdf4IuCKtDdhzEh+kV+Lv8VchocKduSRhVIR/XtSe1I44Fs
 rSA0BlkmNuJq/QLWYnIfBmj+S720UU16GVA65RwqgGfoXeu3H3pHDPdZyCPSI+tn3OY3Hf21bbiMr89ZdcsqnKSWQccineNUgH/iV4xWWc2+JJsCFGEgNzo9
 2Y/xwxdSyE7YcXYH1BpJo+Ia79+vAX0VwcRqEKWYZraFhS18nSHMLPkwZ8pYWD+7lQV+M4MLuqFOu5ozaoOd5PgPTnNOJqxjQQ6fchopVQdNOx6vc53YjSb+
 EzQM+8XwIeSh39pdpJT8SzcvaisfhTUk3Qc4tY68ZmeGzFggBrTuJUSdMqWS3eyq6j3vDtHepnL2PWE/pVXp+2USR/1M7OekQmRYpGp3Phw0/DeyVz8vNTZO
 H8cTc087JdA35xobHRrE8Q30

Hi David,

On 29/09/2026 11:32, David Woodhouse wrote:
> When second_overflow() is delivering skew, timekeeping_max_deferment()
> should trigger a wakeup at the end of the second to ensure that the
> skew gets recalculated — rather than leaving it active indefinitely.

Please put this fix in the series before 2/4, as for the tick_length
one.

> So the results at https://david.woodhou.se/ntptest-r64/tickless/ need
> to be redone, but you can take a look and shout if you want me to
> change what I'm capturing or how I'm doing it.

What you capture is fine for me: the adjtimex state (offset, jitter,
stabil, errcnt) plus the per-pulse phase are what I wanted to see.

Two questions for the rerun:

- wouldn't it be better to also have the tickful baseline with the same
   board, the same GPS and the same pulse period, so the numbers can be
   compared directly?

- since typical PPS sources deliver 1 Hz, don't you think it would be
   better to also do one run with the timepulse at 1 Hz?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
