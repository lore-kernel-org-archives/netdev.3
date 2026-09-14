Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548B34A78F
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422144; cv=none; b=OR4UcH0XDsnpd91fhCEE3IE1rtn0qAU9pobex2SZx11XRDmrCzascpOpipUC/TPrGt9EMQ9QtoFJHapn4y8js1vb63HSTMXQve1ZmQxxSKMYXR/Lcuy9x8stzt3c81Kr5XZfhog91mAXpX8pCbqwOnZTdx8cru/voFuHq115m3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422144; c=relaxed/simple;
	bh=B4zA7K36axit+9vT+E7PeUJoYNNifteK6yA67k6fKAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOQcZIxZSs+jmrwOGMELMgefMdcVVvMOyyFjc5gomDehHmB/U476c1QJW4OFGnjHXbDSBvVo2B24rcISAYoyzRKorYylh207Fdf87TiUf/3zzBQghmHe2BmGs952LTc/1pIBfqAuewYcjF+3YSvkNl3tHl787RY2nsk0FmTrzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uDJQl9s8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uDJQl9s8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1ED43C62214;
	Mon, 14 Sep 2026 21:43:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCAF160323;
	Mon, 14 Sep 2026 21:42:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EC8C11C7AFED;
	Mon, 14 Sep 2026 23:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789422137; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=piD8wQm0D0jvS8xi+fm35j5ohG/rtESi7JgX4KxZ8dg=;
	b=uDJQl9s8evQ9q+TmFFdV3HApW4nmU3aeRHPBrhOCg/sBeVj2qPrHdrMiEPWSBygeEDEXMT
	g/Km3XvssNyr5JBHr0G9Cf4xeu05ptVz7L2p7vHy00RNEtQC1hxSf+nZSYHghl3ar/ArmL
	t3NAZrFFxOnY2TiyJdQGf8gokwPYAPW8hSF3Vc7257v/K+EbI53c+p+X5yZ6u+wSP4U88e
	C+UomPGhivVl17sVo3Lg3SUGssOV9VRR4Y0yhjn9V3jTr72rOsUjT0nZQwS9B5cSa1lyYo
	2Cj4gmGmY9tVkakkHnMFjnueSrarXAo9BhmAMwP/CDC3r10eg2IUydO1NqUhPQ==
Message-ID: <652d0b7b-bc1b-44de-a2de-56e4319fcafb@bootlin.com>
Date: Mon, 14 Sep 2026 23:42:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stmmac in the netdev CI ?
To: Andrew Lunn <andrew@lunn.ch>
Cc: Matthieu Baerts <matttbe@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, netdev <netdev@vger.kernel.org>
References: <4ec29d6e-2afe-4710-b3a4-7d7e035de063@bootlin.com>
 <d90fa457-67d9-4c09-acfa-9ce0e09e87c2@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <d90fa457-67d9-4c09-acfa-9ce0e09e87c2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

+netdev@

On 9/14/26 22:30, Andrew Lunn wrote:
> On Mon, Sep 14, 2026 at 10:45:57AM +0200, Maxime Chevallier wrote:
>> Hi,
>>
>> sorry this is off-list, I don't know what's the correct channel for
>> this kind of discussion, maybe directly in the nipa GH ?

[Bringing this to netdev@, for the context, this is me considering the addition
of stmmac to the netdev CI infra]

>>
>> As part of the stmmac maintenance work I've undertaken, I've setup
>> a local CI for stmmac, allowing to make sure we detect breakages
>> early on, and on a good variety of HW platforms covering most variants
>> of the IP.
>>
>> As an experiment I've plugged that to netdev@, with nightly tests of submitted
>> series, and ajudsted my infra so that I can fully build + run the whole set
>> of patches under a few hours.
>>
>> The next logical step is to plug that to the netdev CI, but I have a few questions
>> for you :
>>
>> - I currently have 8 boards with stmmac on them, and 7 more on their way to me, so
>>   in total I'd be adding around 15 more devices to NIPA, is it OK to add 15 or
>>   should I somehow try to condense these results ?
> 
> Do you have enough interfaces on these boards you can have 4 pairs of
> boards with directly connected interfaces?

Most of the boards with a few rare exceptions are single-port, and for now they
are either facing non-stmmac embedded boards, or cheap USB<->Ethernet adapters
plugged to my testing infra. I still have a couple of devices that are reaching
the CI infra through a switch, but not for long.

I can run tests that involve configuring the peer :)

> 
>> - The current kselftest don't mean much for stmmac, I don't have any board that has
>>   RSS, queueing stuff also doesn't really apply, the meaningful ksft are mostly
>>   csum and timestamping.
> 
> Does kselftest at least do the correct thing and declare a skip? I
> guess most NICs don't actually have RSS and queue stuff.

It's a mix of both, some gracefully skip, some fail.

> 
>> I'd be happy to have stmmac plugged to NIPA though, I think it's quite a good
>> candidate for an embedded driver to run these, hopefully this could set the example
>> for other vendors...
> 
> I also hope it is something bootlin can turn into a training course,
> so more vendors setup their own runners.

It can at least be a good topic for netdevconf / LPC / ELCE :)

Maxime

