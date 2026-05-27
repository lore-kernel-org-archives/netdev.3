Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712F3B8922;
	Wed, 27 May 2026 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865693; cv=none; b=TnhN5/IVV0PRaryW9M1o8eNY7vgdqK6kHZNklwlBstKYhDiaM3GfzYxFvMjD9x4MduM1ujVTCFkla8A/GrKz1iRBaEuUy1ExN01sk7D0Nuk5AVu47DqAv5R1ugdL60DymFMGo2uBzNithkAK6a31H0RWp+Arz63e6pAcpGpQtuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865693; c=relaxed/simple;
	bh=+Qj21ui7IaiY0vSffZZSxZ/mE3yj7zwzLOseGZUyTJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njTSFsUwWHJtn2iGAOityCNDS1m4NlL0b8thuk6UfuQNIZaXVuZ50HSe2DG0wFQjJdCzFWbEkKl/bRbwJIKR2KXDy4W3Wt/cH6GZ+LPougSzYX+RCdQrliwDHt+OhrP9N2wM7QOk5STA+H/WPOl+WROEov384kG9rRY9El/oo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kUUNnqxb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kUUNnqxb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AB4ED4E42D5F;
	Wed, 27 May 2026 07:08:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F810601A1;
	Wed, 27 May 2026 07:08:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76E7310888226;
	Wed, 27 May 2026 09:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779865687; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=X8Lwho9zISnoiRi84OY6Q8mx0Byw577uutyyRw5MCBA=;
	b=kUUNnqxbM6foPFUbUBh0IB79e6AkprpwYMvoF/vp6+XEkxl4xf0eAx2ZZJvksDQdEOoCpK
	3bmKT0GOaBVPL8hz209ngXzJ0wiO19Nj+JuRyv0agzkAng4PsdOlBBPstdwjCvjogzDKmf
	cpYFg04FeV+zMChhIPRxMBB8rqoD95cS4z7YSUJdcMpkezHvDTnpDbgG8XN2JxtLCXPhdu
	n+k6IWNfTX4HCynydjiOhcGRuNdT/gcDhCm/ayQSwz8beSTC3N2+aFKJia+S3zYNwEj3Yi
	FmIHCToUXjfLHiYmDfnGNNpRRyopoi89YEdXhxt6LvNKwH6KHuUIVNi3haItWw==
Message-ID: <f9d0b5bf-e285-4694-8147-e7b59164da00@bootlin.com>
Date: Wed, 27 May 2026 09:07:58 +0200
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
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 5/27/26 04:47, Andrew Lunn wrote:
> On Tue, May 26, 2026 at 05:24:47PM -0700, Jakub Kicinski wrote:
>> On Fri, 22 May 2026 19:51:06 +0200 Maxime Chevallier (Netdev
>> Foundation) wrote:
>>>   Documentation/networking/pause_test_plan.rst | 556 +++++++++++++++++++
>>
>> It'd be great to hear from others but IMHO in the current form this is
>> not suitable for Documentation/networking/ We can commit the "knowledge"
>> part but enumerating the test cases seems odd for Documentation/.
> 
> Sorry, not looked too deeply at the actual content yet.
> 
> What i was thinking was a python file, which sphinx can ingest to
> produce documentation, and place holders were code would be added to
> implement the actual test during the next phase.
> 
> This is how i've done testing in the past. I would be the evil one who
> thought up the tests and described them in detail using sphinx markup
> in a python test template file. After some review they got passed off
> to a python developer for implementation. And when they got run and
> failed, sometimes the feature developer, the test developer and myself
> got together to figure who made the error.
> 
> I'm not sure we even need sphinx. What i find important is that the
> test is documented. What kAPI calls should be made with what
> parameters. What results we are expected and why? So that when a test
> fails, a developer has the information they need to fix their
> code. The Why? is important, and often missing from the kernel tests.

I see, so we'd get an actual test plan as code (likely python), with for
now placeholder tests, that would work :)

As for the kAPI testing, I agree that the end goal is to get driver
authors to get their flow control implementation right running this
suite.

But I don't really see how we can validate kAPI itself, as we're down at
the ethnl level.

This is made more complex by the fact that there are 2 drivers involved
here, the MAC and the PHY one. On top of that, either the MAC driver
uses phylink, or it doesn't. The common issues are different depending
on the case.

Raw phylib usage is by far the trickiest, but even phylink-based MAC
drivers can get it wrong, by ignoring the pause params in their 
mac_link_up() phylink callback, or getting their capabilities wrong.

The problem is we get an aggregated view of that in userspace. The
pauseparams come from the MAC driver, but the supported and advertised
modes are an aggregation of PHY + MAC stuff, which makes it very hard
to pinpoint where people are getting it wrong. Maybe people are writing
a MAC driver, but their tests fail because the PHY on their board has
a mis-behaving PHY driver, etc.

We're missing some information about what the MAC alone does, and what
the PHY driver alone also does, so that we can look at it from the
userspace perspective, and says for example "OK your MAC says that
it can only do Sym Pause, but I see that the interface reports
supporting Asym as well, and you're not using phylink, so you are
not calling phy_set_asymp_pause() correctly".

One possible path for that could be debugfs ? to let MAC/PHY expose
precise info, so we know who is wrong ?

Or, we go lower level and use the .self_test ethtool callback. We're no
longer validating the user-visible behaviour, but we have more control
on kAPI testing. We can poke into net_device, net_device->phydev, we may
even instrument phylib to validate what the MAC is doing ? But that
means we're drifting away from the netlink-level testing.

Maxime
> 
> 	Andrew

