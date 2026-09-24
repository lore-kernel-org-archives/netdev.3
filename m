Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DB37BE95;
	Thu, 24 Sep 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258543; cv=none; b=PjKLNoDsFKTO1MuVsvYEKgyHta1gmDf14dfjuPHzAsPY0xjoy6YsovgvVNFxCpIn3KfimL94OLSnuvhdGq/BceOlg0ZuMFiDnM8YZqB2L1K0hUFJ3WTxwD2FQOn8hMQPFZiZWo7JKtb3GjDlM6vnYKgxC7axPlxLhHP2aGjr4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258543; c=relaxed/simple;
	bh=484oSIKe/RnoJoviTpGDQCgCbvEWvNEB71sJJ0VrvZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+AUbT9QSRz0PXX8b/D/xwwHhQ5qxafXH7DEJlItCgoVwzE6wc8BaCkM+eu2+eID8BpuMLLgefHeHvj0lgDZLM29nx0XwI3t/wKN25jIosmyHz3L/nEA9gTsdEjzqiL5EQaA+Si5UyhLvOlyhbkyT2bC8N5PMzV79YRpblaiEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wvVd3Jbv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wvVd3Jbv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EBCED1A1002;
	Thu, 24 Sep 2026 14:02:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCFBC60341;
	Thu, 24 Sep 2026 14:02:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B147D10328D17;
	Thu, 24 Sep 2026 16:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790258533; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nW9aH4UcrPlKXMD8jE6q04zh6nM5TWqfr29IzD99IS8=;
	b=wvVd3Jbv3Pa5D8SACi9+6DdDhn3lQXAV86tEd5I4RstVoT5Yc2iSiIO0o87N+zxWGMlrn8
	6s95w1WJHND8sea+TSNUWaf9nThR8hH1IsYLB6cZVjXKPN6ln/qV1wX9dsI5R+D9KBJNH5
	DUzd/ney6QzDtxtzodtCCY4X5wU0Zhk8rCVjb9Vm8S64SPmKjpaCvbFNOnFMC9sSDi0qc8
	PkJ39Dk4RZgF8tXsR5vVczyfbzOx7Pn0BOAMQJudwVEXN750i3o2i9j5uLO4l8ijwJ6raL
	aIHtHM+55eCTswSuYP+vofkg4Y5Nf51+rm8Tgiqrl/Px/sKbf2WI6lso98EMRw==
Message-ID: <e05ec35f-202c-4b69-a409-5421faa58b16@bootlin.com>
Date: Thu, 24 Sep 2026 16:02:02 +0200
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

Hi,

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
No problem, should be easier to review as well :)

Thank you both,

Maxime
