Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683742EEB8;
	Mon, 29 Jun 2026 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746701; cv=none; b=ewr8UhI1OoAHixogyoCQ+Y4hAMntvu5Ro8FgEubWkTjjXN9fbGDS5CN3EXnB6t6kWBKIbO7QQu0Ko7ELVtwSLPExds/nalbVz4CfQ/Ac4ZnvI7YrQ33k904sOqa0Mfjs8aPvLH7C/60E8+drDZvB8SgaX/CsIq9wB4aX2vfrx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746701; c=relaxed/simple;
	bh=BxWHJw/g4OM8boiB+iRC+r6pkkeo8B1ZZ8goj81rBAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFUtDAufAg1I4r8aF2dSGM9YhxuGmt/uNXjiNj/Pq8PUxiRZhe0uHRkPU3sBa7KYyCd2TKF1dozXmDb9XNk6azeEqoHYHWzIEgLwf8HGpz/I1YUGZQZl6VJyjwWaWJVgxNCdtcdvoKFmQnWY8zSaUWN4PjsbWDkmAQrIsnt0yfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YU+wIcTk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YU+wIcTk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 74C884E40B48;
	Mon, 29 Jun 2026 15:24:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 421805FF96;
	Mon, 29 Jun 2026 15:24:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6028106F1895;
	Mon, 29 Jun 2026 17:24:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782746697; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cV6cOM+bj7USh7hCsNibU/8DXk3lJFDt0xAap2b262Q=;
	b=YU+wIcTkwOnnxgVT4g6EJRE0b0YtGWGu0SsA0ZopVUg/3hUzDC269GIpMtRq+zsV95prjU
	eGtdXY+xxOaBVjJ3JKPk3ApBjhyli3rSEcIG1DLkgM722wa0O5ykt3uhdCTzSLh//Djg21
	vuEIcH5a7E/DhnPSRKGbS9hxlfWJvzvzaNjj7j+MdI/iaSAzllXNbD9hdNUvCQ5+PXlYQw
	HeDOuVjvd2hDtY7TnRXoWyO5KNsNwXM71aBT3liz33aftyvOJheMG8mfwfpCt8ahwlyCOu
	fxM7PXJhGTz3+y1EiCsNk7A7L6TN2h2GLGFgfprz6U5oSykWr6l9zVt2Me2X1A==
Message-ID: <01e3d32b-6d50-4179-8e2f-25cdf8ff6c32@bootlin.com>
Date: Mon, 29 Jun 2026 17:24:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
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
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
 <58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
 <65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
 <5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
 <20260626173352.7dc8f106@kernel.org>
 <12b66ea3-42df-4ecb-8eb7-44471407b83f@bootlin.com>
 <20260627143028.5afed23a@kernel.org>
 <3b8abe17-5da7-4a7e-a42c-eb39a631843e@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <3b8abe17-5da7-4a7e-a42c-eb39a631843e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub, Andrew,

On 6/28/26 01:46, Andrew Lunn wrote:
> On Sat, Jun 27, 2026 at 02:30:28PM -0700, Jakub Kicinski wrote:
>> On Sat, 27 Jun 2026 07:34:31 +0200 Maxime Chevallier wrote:
>>>> This is very far from what existing python tests do in netdev.  
>>>
>>> We can probably drop the class, as it is with this discussion, it's merely a way
>>> to regroup doc common to similar tests. The rest really is the usual set of
>>> ksft funcs you can feed to the run function, with a set of ksft_ethtool_*
>>> annotators for generic checks.
>>
>> The common way of checking prereqs in the tests is to call a function
>> called require_xyz() which then raises a skip. At a quick glance - the
>> rss_api and xdp_metadata are good tests to get a sense of the usual format.
> 
> The counter example is the ksft_disruptive() decorator.
> 
> Pythons own unittest framework makes use of decorators to skip
> tests. Its the Pythonic way.

So maybe in the end, we can try to have something a bit less python-y, while still
using extensive documentation using sphynx doc format ?

Let me send a V2 with the full test list, we'll see how much scaffolding
we can build for ethtool testing, and how. I suspect that running/skipping based on
the device's capabilities is going to be used throughout lots of tests
beyond pause.

For now the important part is to get that test list right, and iterate on the
test implementation once we agree on what to test, why and how.

Maxime

