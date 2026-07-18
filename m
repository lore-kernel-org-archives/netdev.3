Received: from shout01.mail.de (shout01.mail.de [62.201.172.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020632720D
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388782; cv=none; b=oTKZA1ZcujXHGwkCJVUggGHAQyy0JIbIdWI2Hwa/x7kDVG4iL5+BRLgryDCEJGBHgUObIipLKFsTWmbZreoe0z+Up2uwE2rx01aCz6CRG00oN4w3HzmNVS5LLsXZcdks6EhUGTM9Cl9z95zAzbV6eEvnqKZgY13344W9wRsing0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388782; c=relaxed/simple;
	bh=mL3ezG/p8I0SnvZhwQumvt4nAc1t5cPnYddgX++tRIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TN4QxRMrp003mLBhHl8wJGrZXbl8meMBnvYToRRC0BRWfY/YOmoQgEmKueiFMWcL+m5GuxfpqZYWDGIapN2SJk18q7yxsZfilFvlpI5jXjTkkjVe6vq8iXL4i6DmG9mEOIp2p5OodNw8aBvS8QFMRMPSV0AAhj6ZURHwFDyFWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=YdnYNGan; arc=none smtp.client-ip=62.201.172.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="YdnYNGan"
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout01.mail.de (Postfix) with ESMTP id EA5722408B0;
	Sat, 18 Jul 2026 17:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784388778;
	bh=mL3ezG/p8I0SnvZhwQumvt4nAc1t5cPnYddgX++tRIk=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=YdnYNGan2nfpP1PrAkn6D0MgCB+7lsQVO4kHPrBXjeGk5whKTfnCYV/3+NFLoR4ur
	 9CcgQmZgXZGHj5aru6O13gRGQ4cTGeP5GLuzxOiAWuIF7B6XO+iMKAbc+MTtVZ7FwY
	 /IyCUt36VEpintbjPB3KWlzdSxneEldQVyYiMxYJWROjxjUfebV+hgBabTrGe5FzIz
	 3R9gzT44kcO98x7s+aYExdi8ZrSWl+Z9YmfqtLTG1FIwltDp4RhC4JYG2JD5DxjECX
	 eEaQXFsrJxZRKcYyRSLX/OgHwtqZy2pQZdE635YPp7vJUG9COYnvf0hrFwrCl+vw7J
	 7b0W/ZbFEmV4g==
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix02.mail.de (Postfix) with ESMTP id B1D282405BE;
	Sat, 18 Jul 2026 17:32:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id D13E324064D;
	Sat, 18 Jul 2026 17:32:57 +0200 (CEST)
Message-ID: <045bafd3-45be-4e7d-b828-77f9fcf6beab@mail.de>
Date: Sat, 18 Jul 2026 17:32:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, regressions@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, kuba@kernel.org
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
 <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
 <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>
 <46e90a47-4507-40fe-b74e-efef932e9b62@bootlin.com>
 <54128253-eb77-48f5-a673-94fb65edb78f@mail.de>
 <36957839-b03a-4403-b08e-12bbadd8bc0c@lunn.ch>
Content-Language: en-US
From: tresonic <tresonic@mail.de>
In-Reply-To: <36957839-b03a-4403-b08e-12bbadd8bc0c@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 641
X-purgate-ID: 154282::1784388778-4AD848A6-A8C9B97D/0/0

On 7/18/26 4:11 PM, Andrew Lunn wrote:

> There are two documents for you to read:
> 
> https://docs.kernel.org/process/submitting-patches.html
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> Since this is a fix, please use the net tree. And include a Fixes: tag
> indicating the patch which broke it.
> 
>> Just commit and separately git send-email to netdev@vger.kernel.org?
> 
> ./scripts/get_maintainer.pl will give you a list of email addresses.
I did your suggested change, read through the documents and hope to have
sent everything correctly :)

Thanks for your help,
Luis/tresonic
