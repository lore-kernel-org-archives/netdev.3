Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783E3D648F;
	Fri, 12 Jun 2026 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249883; cv=none; b=hwJuB61VqhgkUuTkLUFVHUIOpv7Ayo0PfkETYpaNoQaXZFEIBJZoxoWRk69fvVnw8FfWFH1PsY3Vs0sM+wufRi8jgUE+vaRL9nfRCtxxZdEqlix24yKO+uSiVy7UMTIuCYUIhldgl2Zkw1thhhHezD/VJIwhpma4RzH5z7ZUh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249883; c=relaxed/simple;
	bh=mrgJ2VAuh5P273BwV2G8Wc+0omO2pHh4Muntb/vB+Qw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hVUAMqycsnW35JMOZDqATLXmS9AM0QS/swrcT0f9P4fv+C0NZ+kCCJ9jpzzTTnNSG+Rjrc5ZOQY21sI+vX1UMiQ8Kftk5hqcHxL7zdfwk0QAXiYu7s5Ly9akwZ1JnnPJu0UtgP4N+cz2+oIjLH4fE3oYEQoSyqsiFNs7mUrmq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=c0esgBag; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="c0esgBag"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B1F6A4BFC;
	Fri, 12 Jun 2026 09:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781249870; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TrOeP1rKDBqme1EicP8zK1y41xE2ImzrIlX9k96aKck=;
	b=c0esgBag4k4MdaGFwx3QG2e4LlMTIVfYmi65wUzJPiW6ixURwmrmmnPQFEqXnmbGJU/+nm
	6ZMCa6TMWdGrgWhsFQHkk2ihNBzbF9hzqsmIO+kZcU3dQWog/U05lb5gqlYgmgMjea1Hid
	onstumaIWOSeYAqALxllUKlI/fYFYhHEB7cSFBhaS7sfdigv+huBzgF86hJcV6XKshpcNo
	nRdrcoNzo4a2mxWrUhaeVmyVsxr7Rb/sueTHFzqMKt9bOWJ0cfAZwZRsxD0iL1hB1jQ5Tw
	I5NfzNGL/4rpZZv5hN+eFVG4QyeMfiiT2ARP3f/F052nH0yDkva4c/Y7NkrJiA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 09:37:47 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: Use weighted round-robin TX DMA
 arbitration
In-Reply-To: <d700f8b0-b315-468d-8681-b97653ed76e8@broadcom.com>
References: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
 <2f7e70123887fcfd8bbf4ce92f73574d@tipi-net.de>
 <d700f8b0-b315-468d-8681-b97653ed76e8@broadcom.com>
Message-ID: <69d920a3b52cc049dc1b96a9c7d5e3b6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11.6.2026 19:27, Justin Chen wrote:

> [...]

>> AFAIK the existing queue mechanism dates back to the STB QoS use cases 
>> Florian
>> had in mind when he wrote the driver, so let's hear what he has to say 
>> on this.
>> 
>> The change itself looks correct to me. My concern is the targeting. 
>> This
>> flips the default policy for every GENET user rather than fixing a 
>> specific
>> defect, and Justin's series already called the persistent timeouts a 
>> design
>> issue rather than a bug.
>> 
>> So isn't this more net-next material than net with a broad Fixes: tag?
>> Please also add to the commit message that it drops the existing 
>> priority
>> handling for rings 1-4.
>> 
> 
> I'm ok with these changes. Internally we no longer require priority 
> queues. It is a legacy use case we no longer have. My idea was to 
> remove the queues entirely and have one big queue. But I figured I 
> would wait for Nicolai's XDP changes so we do not need to remove and 
> re-add queues for XDP. This could be a stop-gap solution until that is 
> done.

Thanks Justin. IMHO XDP could benefit from a queue-refactoring prep. It 
gets simpler on top of a single queue, and dropping q1-4 frees up a 
bunch of BDs for the XDP ring instead of the 32 it has atm.

Happy to take it on, or leave it to you :)

> [...]

Thanks
Nicolai
