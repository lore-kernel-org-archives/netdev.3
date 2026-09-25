Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D01F427C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344785; cv=none; b=CPrMcyE9CXm78+qRnjsMCVMXeHrEN1neYBVbjO1ojfUr7FcBCCmG+GXGmU9x3HIzCQ366gin882ybRspfcFlSPCHgxnCLbiKAoHTDwDcr+3YJGsRqiV2lhqEOTxVWdLlFOmMHXLCj7LNiSwAOHmVrRzq4YcMi059Z/bAL3qCAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344785; c=relaxed/simple;
	bh=AIxHoYBASwLQOXohCuC2aRCgahGgWljtbfksp8mHyfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b301KoFlA5nvW1bapGSq4bIjm3WCoAT/TDyWgRu9v38kJnOU+o1QUcv8+FXLir+/XMw0D6f2XdQeGzYWM241qBWiy2IEjObATNhs9h5I9osdIDhvq/iT1k+jpcGgk4gdU+ZonHfb0ZQZ1Uz7A4d1ZY8SUAgGFBXGe98O6IwftMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c9oIkeJo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c9oIkeJo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 019331A101D;
	Fri, 25 Sep 2026 13:59:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFF706073B;
	Fri, 25 Sep 2026 13:59:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 206FE10328856;
	Fri, 25 Sep 2026 15:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790344773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aycBG7kmkLd0baAzRQ2OkIRVPs3/PNyoRtHVPTB/LeA=;
	b=c9oIkeJoGC/yiwLUaSy5a9wXxa+86agp6C6WLnFNTQi2aBtiONLMSeMlf6J//rjV3rXiY2
	B5mMBPiUIkQIjVvjgdMSj/eiVk1Trf7tfg+cJRmqcVsCYGHiYMkJgtvwOpQNgE/utY7RYc
	bPHODZxdyGYueSohoZTS3cNEsVnF+DDYrHqn1sun6cWgbmhwAvgHhdp+PCz3C3rIsaQqSX
	ZJRWCogVcks1bx4XjDIvovkSyRndk9il8FLShk2HohwXvoC2oBzyTFfzhanYgPafUX0+nn
	hWiFLwyvTftb0SUipXKxEDYQ0JT5b33Vsaa+wuWO+/OgcqC/NW0qDWc/IqMyyQ==
Message-ID: <d06c0f50-777b-4ffb-a3c9-affde5bb5030@bootlin.com>
Date: Fri, 25 Sep 2026 15:59:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: Introduce a selftest for
 ethtool flow control
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
 <20260920164732.349744-2-maxime.chevallier@bootlin.com>
 <20260922194251.06e00e2e@kernel.org>
 <72bdfa09-34ea-43ab-88ad-b3c64c7e1f70@bootlin.com>
 <20260923201051.66e9bf14@kernel.org>
 <fb18618d-6402-4f7d-b318-1872570ceb27@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <fb18618d-6402-4f7d-b318-1872570ceb27@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/24/26 15:54, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 08:10:51PM -0700, Jakub Kicinski wrote:
>> On Wed, 23 Sep 2026 07:41:13 +0200 Maxime Chevallier wrote:
>>> On 9/23/26 04:42, Jakub Kicinski wrote:
>>>> On Sun, 20 Sep 2026 18:47:27 +0200 Maxime Chevallier (Netdev
>>>> Foundation) wrote:  
>>>>> Future ethtool selftests are expected to use the same, these helpers
>>>>> are put in the net selftest lib.  
>>>>
>>>> Please resist the urge to create libraries.
>>>>
>>>> If you're doing this I suspect you didn't even read the README and 
>>>> you expect people to search around for libraries?  
>>>
>>> I did read the README and fought the urge, that was something Andrew
>>> was asking for in the previous round :( I'm ok with either TBH.
>>
>> I guess it was Andrew that didn't read the docs then :)
> 
> Yes.
> 
> I apply software engineering principles to tests as i would to any
> other code. It has to be maintained, bug fixed etc. For my $DAY_JOB, i
> spend as much time maintaining test code as feature code. So i don't
> really want lots of copy/paste version of the same code.
> 
> So, for flow control, lets follow the README. When EEE is implemented,
> we can see how bad the copy/paste is, and then consider a library.

Some side question, as the whole thing goes into the same file, do you
prefer that the series stays split into 3 patches, or do you prefer
the whole thing in one single patch ?

The diffstat would be :

tools/testing/selftests/drivers/net/hw/Makefile |   1 +
tools/testing/selftests/drivers/net/hw/pause.py | 998 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Maxime
