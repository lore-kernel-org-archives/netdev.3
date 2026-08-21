Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99B324B33
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319704; cv=none; b=WayroEZnSgEzw2PpRayAYydMUJgnGmLXQw72QPJ4PnKxSmo1V1BcXWWQpjUvLn2900yiKFrvO3ls2gAC+ZbYnqwOKsR96g0yEPU4dhcFs4QwMm57DR3J/2PwjofFB67SLjrdr48XN9s5sImht+BSxQXP6KIPI2wKkzXh2+fPUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319704; c=relaxed/simple;
	bh=csKG4jsdSZoEyLklM2fqjsuhF4NA0+aRfRToqSPhd+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXwyGPnwbCDMAg8PV7p6F2jiqrZGycPNBwQhlX0y7Y3RcvWE31SUDGuqWqL0FXwe+cjaMJCth8n+YOlZDzi5nH8Tnm9XoLoygJtbkSrWa5d3bjEVYPDoFLmk5rgFQGSTMXKdLarOAd3tyvffqQLMMjeHU/LHhBNMqeLFyiChVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AvqrzzRi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AvqrzzRi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 164874E4131C;
	Fri, 21 Aug 2026 13:41:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D4CF9604AA;
	Fri, 21 Aug 2026 13:41:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1F8011C77174;
	Fri, 21 Aug 2026 15:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787319692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0zgZgDh7aVAOkoqDbyZC6cL4rz+qele9fsZ91dWkXpg=;
	b=AvqrzzRi+NQofrXerRpVaUlPTHMdubK8vJEVHpvd5n3vpY3hl7s1q+Drkz88ytOfSNvBUT
	50qqcaqJkrPUomdZvFRO/2hiKkicz7NjhEbJa67uOCGDflXDGba1c+pK9s8yDKudYf/bXd
	b3pshwfgjRkxfrMY/AY4NljfBFR6hwvEinqkSLai+LDJkgn6oH/l8WTa+SupL9zRigA90v
	Gn5BMW1PrjKEV+ACddGYpEH72sW+oJdAp4efjtau+0piUPrnmHP1WKuEmY1rQI38bOyU9d
	iQUP6LVY5oWzWmEhsHaoy4BENg+khWgebv3TTVPmcNf2EHDGCwCntjYG5EdCtQ==
Message-ID: <5693c628-dffb-46c4-8f7c-5a5a6c101660@bootlin.com>
Date: Fri, 21 Aug 2026 15:41:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues
 default settings
To: Kurt Kanzenbach <kurt@linutronix.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
 <20260817103337.74c30adc@kernel.org> <87mrujzzjv.fsf@jax.kurt.home>
 <20260818075335.48936b08@kernel.org> <87h5kq1s1f.fsf@jax.kurt.home>
 <20260820144528.7107ba90@kernel.org> <87y0e0x7ic.fsf@jax.kurt.home>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <87y0e0x7ic.fsf@jax.kurt.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kurt,

On 8/21/26 09:22, Kurt Kanzenbach wrote:
> On Thu Aug 20 2026, Jakub Kicinski wrote:
>> On Wed, 19 Aug 2026 09:35:40 +0200 Kurt Kanzenbach wrote:
>>>>> I want to use ETF Qdisc with hardware offload, which is currently not
>>>>> possible on the stm32mp2.  
>>>>
>>>> Do you need multiple queues for ETF/normal traffic?
>>>> Or one ETF and one "normal"?
>>>>
>>>> How do you sort the traffic between the queues?  
>>>
>>> So the stm32mp2 has two CPU cores. I've isolated CPU1 for Profinet. That
>>> one uses Tx/Rx queue 1 with ETF to reduce the Tx jitter. Everything else
>>> is routed to Tx/Rx queue 0.
>>>
>>> Config looks like this:
>>>
>>> #
>>> # Tx Assignment with SP.
>>> #
>>> # Tx Q 0 - Everything else
>>> # Tx Q 1 - RTC
>>> #
>>> tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 2 \
>>>   map 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 \
>>>   queues 1@0 1@1 \
>>>   hw 1
>>>
>>> #
>>> # Enable Tx launch time support for TC 1.
>>> #
>>> tc qdisc replace dev ${INTERFACE} parent 100:2 etf \
>>>   clockid CLOCK_TAI \
>>>   delta 500000 \
>>>   offload
>>>
>>> On Rx incoming frames are steered via PCP field (vlan tagged).
>>
>> Thanks for explaining!
> 
> No problem.
> 
>>
>>>>> It seems like a static configuration in the driver today. I basically
>>>>> followed the same convention as dwmac-imx, dwmac-intel, dwmac-mediatek
>>>>> and dwmac-qcom-ethqos. Only dwmac-socfpga does it differently.
>>>>>
>>>>> Tx Launch Time requires a different DMA descriptor layout. Currently
>>>>> tc_setup_etf() just returns -EINVAL if the DMA configuration is not
>>>>> setup appropriately. I guess a dynamic configuration requires to change
>>>>> the DMA config and perform a full release/open cycle.  
>>>>
>>>> release/open is not ideal but still better than hardcoding?  
>>>
>>> For sure it's better than hardcoding :). But, again the driver does it
>>> statically. Maybe there's a good reason for it. Maybe not. I'm not that
>>> familiar with the stmmac driver. I'll prototype something to see whether
>>> we can enable TBS at run time using the ETF Qdisc callback. It may take
>>> some time though.
>>
>> I think the m in stmmac stand for 'mistake'. 

let's rename it stmmmmmmmmmmmmmmmmmmmmmmmac then

> 
> :D
> 
>> We need to start cleaning it up.
> 
> No objections here. I've briefly looked at the TBS thingy. I think we
> just need to reconfigure one Tx queue instead of doing a full
> release/open cycle. The XDP/ZC code does something similar. So the
> infrastructure seems to be in place.
> 
> However, we need to keep track of what SoC implementation can enable TBS
> on which queue. For gmac4 we can probably reuse tbs_en and for xgmac
> there's is capability field tbs_ch_num. Let's see.

Thanks for tackling this, let me know if you need testing. In the past weeks
I've been looking deep in my drawers as well as on various online shops, and
I'm starting to have a farily comprehensive set of stmmac-enabled devices
(although I couldn't get my hands on XGMAC, AgileX5 devkits appear to be way
outside my budget).

Let me know if you need help in testing for this, and we can ask the Altera folks
for some help in XGMAC testing.

Maxime

> 
> Thanks,
> Kurt

