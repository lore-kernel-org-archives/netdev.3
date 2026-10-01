Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00384AE8A0
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843029; cv=none; b=K2ABmb2FMBmiMbti35L+rGpBzaLwSgVLjioReF169NeE/15SH8FkGUfG62x3JxAZhmBEVIIQRg1xNTZ5Pj7qGPXJ83PiGLs9ownANe2YA6DVP0PNh8vuq791DRUCaad1h8OK0mho13MJluIww/Tbu9eEeEI3jve661Nkl8ZZQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843029; c=relaxed/simple;
	bh=5ii2wsmim5NNuQYKQidppV2R7J5iURxqkVb508DATbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h7GAyT8Ze69jOdXD62CqDLNTG76ugp4LeYPkVuLyQKAAF8bjfYVCZjdrZj+1lkFzu0X6sjw3hl7OuYV3H1WL8iz/o9xsXQzg4Cll4WcXCntMki3+M03WdvK2iRzGJSRXRyZ8CH52wQU0dYaj8tHGldq8r0Xd7whVx4Fp3+KJMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=DcRHM2er; arc=none smtp.client-ip=62.149.156.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="DcRHM2er"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id CC1oxVAz8l4ytCC1oxmhmk; Thu, 01 Oct 2026 10:20:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790842834; bh=5ii2wsmim5NNuQYKQidppV2R7J5iURxqkVb508DATbo=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=DcRHM2erSauuABoy5m3lY34wozJdaHok7MToYxoY5xKC5xVxipZY/h8KV+BkNlBhI
	 R5cZweUWjz9rWhrqwSbc9pep2lHEGwLjqdSlscqxvbHi0plmDFQM9s4AoWr3T36h9G
	 UJBusN9ZhyfnhjJDsmlFKVSkxpVye4al8ocX6ZH4LqHS02+Mdwlwk18zi8x0vzYYdN
	 0u/EuVhaH2kauIRM+NFmVgmZcWLiALpMqv9wEcrBSQ/tQ+bGocjvbMm9ffegHquWsT
	 UdLRGaet8x0gHFDZYk4Z6TBR7+8ySTZg49JO2Rp1PtUFp029oHkNpfrfHhYaLjEKz9
	 xm/6r6gOs0ECQ==
Message-ID: <fbc06405-c7a0-441e-af5c-be7d55e732b5@enneenne.com>
Date: Thu, 1 Oct 2026 10:20:31 +0200
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
 <fc473eab-c72e-4641-b617-8f22389c8f68@enneenne.com>
 <6a529b5fe8c5bbb664748b85be011f5cf2e6c44d.camel@infradead.org>
 <14280dde8487260f4c590d49a0297777b690660d.camel@infradead.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <14280dde8487260f4c590d49a0297777b690660d.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP2FmQHNkKJ0TJLV9n1zHxyQ0nW5TVhkzauVFFpukSMWwqTh5S198FuvYZDzk+JnNYN9aR3n9hbo8jN1tZt/bWI3oAYJrWULkG7Uie38M0nNZIrcOHWf
 Z8EzphhxTgBS2oD4BDB9jSpebexAOvFz59ZeLYDLiawRiAqE13ztPCtxTCy4vWg6/K+HeNJYCTBOZoQNwU2oW3ZiX2qxwSjH9IXboEcj53TT4CjPBADER7tH
 K9rhTHvZCendM9l2utQ7m3Aa6a/2PpMv7id0xGdjSOAju1oaVstrlj/qo2mgkYq9r0iHAJoGUfgQ7gQPDW+skc2lFNiarYru7xw0a28iBFLz5C5hNPfEYJun
 fkGmT+L7COC6z7XP7ffRMH+H/QvO6pEMRsMRYQ6g991S2d6uBbnWiBAuBlwx5n96u1Zh80TlmDMmGw84vGvJTanmu83momVo/xt0rxLKMwp0IxYOzRVEYkM2
 iIessap1RDYqsm5SS2By4G90z/FrUkdtTQ2bxPvyTsAi9o6nKyH5xbFp+CkMUey2tDfhwLT3AjTvsF/CFmwdHUv2elgbdfqqnpAXtEmNdfdh6O+cfvFYhbNc
 etsrLTV2mgrzypWDp25QNZFb

Hi David,

On 30/09/2026 20:24, David Woodhouse wrote:
> On Wed, 2026-09-30 at 15:05 +0100, David Woodhouse wrote:
>> [...] But
>> I don't think we're ever going to be allowed to do it that way in
>> entry.S but the *hardware-captured* stamps will want the same handling,
>> so I wanted to prototype it anyway.

Hardware-captured stamps are something I'd really like to see in the PPS
subsystem. When you get there, I think it should be its own series,
discussed together with the raw counter export you mentioned on the
28th, since both change what a PPS driver hands to the core and what
userspace gets back. As I said for the export, I'd prefer to agree on
the interface first.

> We don't actually do *any* filtering. Even pps_phase_filter_get() is
> just using the first sample, with a comment:
>
> 	/* TODO: test various filters */
>
> Looking closer at the actual captures, even Mills's median-of-three
> wouldn't save us here when two of the three pulses are outliers. We'd
> want an ongoing frequency estimation.
>
> But that's definitely a problem for another day.

Agreed, but I'm interested in it too. Your setup, with the per-pulse
captures, looks like a good way to evaluate a filter, so if you or
anyone else picks it up, please Cc me and I'll be glad to review it.

Ciao,

Rodolfo
