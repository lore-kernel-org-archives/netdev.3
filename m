Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55F43F0BB
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663814; cv=none; b=mKJYRz901IpNAu3hT1GUX6UMMMvQUoaRml+/hGytBBlfRc2UZZfqWhjiWAoCeASeFPTqEdWAO0de4Ji776cLLSf2LK6bmogzJFSXuyY2htu7ScLEMBRaPB3I7B/AGPNaJTZVsCxXeq/H9SOckfUlTG12qQP93JkVXaVMlEgianI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663814; c=relaxed/simple;
	bh=XApIJdJt9qvKv26L7T5HvfW0f+l+v5xatimMnJLKgZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=US37L5Vebron1Mn8EwQmsg3nuuklkP4Yq7ageNb6xk/aYuNJk5gjnw3kH4qfHf+aLTgVZ13PonDHkVsT9WDaR91aJoUoB0DuTrBnnv6YkjgCC9vT3T2JLNfOROFXNmjiHpj1c5wdq+Sx7zBNkU+ReSTb276SGcoidc7Xh1ZdA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Iu1XawDZ; arc=none smtp.client-ip=62.149.155.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Iu1XawDZ"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id BRPIxrKOe5bAIBRPJx8VQb; Tue, 29 Sep 2026 08:33:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790663621; bh=XApIJdJt9qvKv26L7T5HvfW0f+l+v5xatimMnJLKgZs=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Iu1XawDZry/JBK4GcI45mZ2n3wW4ZzyByRwTuGYX1Dgj/Lmc7knxEgpxJkIBRHuv2
	 K3VXCtwaCvdJiOaXb8hoiqfCIParx5pFus9v8ipHQGr3LCfYp5pcL8upd8CSlkSj46
	 yiI9a2By07k83BStTOoh7owxdY7eKHFOj1QZkuRUMW2UWjyyu+iAUCWjA6ldrGxxw5
	 jzUs8SjHcr/Q/DcDAbLmJexXK1ObxJ1rpI2zCHFUVl5m9DAx+LQGU+AJzBhh6t3z88
	 qtjaNJSjCRpQ+5FAYMJnhLWODvwHYNUEAM3qfzKVAu2cNS/ibsqO70T82n1ScylEeM
	 ajryb+hmSThfw==
Message-ID: <decd5d05-1373-4ddc-95bc-46b73d6f6b99@enneenne.com>
Date: Tue, 29 Sep 2026 08:33:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] pps: Drop the !NO_HZ_COMMON dependency from
 NTP_PPS
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
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <cb992b22907085c4ced8d9a35cd1c8836aad20ad.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBXYAjp0HtUnk1MTaqBjy0aHW1KxuibbGGMZo0NbDhrE3eQ/pf63AhywT1qaFog9Ez/XFpIdeMetO0rMsnWo31fdvvhosQ0iav2dU5jaZ7mq9ccVCitT
 owtxeWh/Kf3uuP5dxziWwo1a0A8YRDEwVSM6AM5PZvWgFDpedMpDz8OHFBjCwxMmkZolCF5kKQW9A2yefEOpvs1c+U338STq6RIASwnDX/wpvSoGXLmysIBm
 NgwTLBeb8+cO+Qj8Kvvqa92J02ksojOB+DTnUmdtiXlQWbdgOoxhLXCL4Xw9pwm6BrTgAY9B/MqhzXtxFGD+4NyUUj1qIaTYJ4V4493fYAzHio3OzcmB01vw
 lzuuG9EeUBeb8Uv/XgW6G0xqLsT+nNgm1GzncSuXiKmWcKKVVemSGXBCdNwfYnQqcRjA4Jdu4q6TNbq/YodvSDd9+PJcvdXSAQ9dRM2lBtQG2pesGa8M3UbK
 GRUmfO820XxCvJHKcsKQ8UCGTt4y19yG65OWM0IJ79Z6PGlare33lSadW5LNgnQJY9vLxoPODLfSiEVhPB0lR96tt7eLHdPkTQZqVoDqrR73l73uYduFCyBE
 8TCzwzQUKiMzlNkoMgve0HLJ

On Mon, 2026-09-28 at 20:28 +0100, David Woodhouse wrote:
> Yeah, working on that now. My first soak test on the nohz_full build
> didn't have nohz_idle, so it wasn't really very tickless.
[...]
> More data, and pretty graphs, when I'm confident of the results and have the
> A/B testing.

Thanks, looking forward to it.

For the A/B comparison, could you also report the hardpps side, i.e.
the PPS offset, jitter and stability as returned by adjtimex(), on
both the tickful and the tickless kernel? ntp_error shows that the
correction works; those show whether the PPS discipline converges as
well as it does today, which is what 2/4 is about.

Please also state whether the pulse comes from a real GPS on a GPIO
or from the vmclock 1PPS in 4/4.

> The ntp_error being corrected is still two orders of magnitude less
> than the jitter on the IRQ, mind you.

Worth a sentence in the commit message too, I think.

Ciao,

Rodolfo
