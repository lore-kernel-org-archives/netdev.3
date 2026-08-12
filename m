Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97B4582FC
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543722; cv=none; b=L2g5AX3Z0sqJW901Opprvc5k6pfDmEuZNVnFnDaiP2zAawtHB80EHML5JP+GEyiAlLUbYM5+1X/eNAY9dM6CD4SyDXrOa1HT42smp7npunCi44CfmpqwLKWRFcLjK9UccS2OssXgD77tOWoeGBxBzRO2bC9wDsf5dDCsYKuibA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543722; c=relaxed/simple;
	bh=44XfeALrVwsP5R/6anlBbm2mYqBy2A3GIfRvQT4WGZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcd/z+9rS8ttjKNjz1jyFXmAIddmCyVKiJsiFQIQ/OiMcjjYoF26BHyn+5WvyL6Taz0sH9A38eI+fvh3NqsYP4YiwicBBjifJIlBeh8AqPLV9eS0UOwfK+9qEag7XoVfNWmW1w5RMByYjt9vK/hiK5j8aAtqsoOLeGlCbsVbdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dfBfHwg/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dfBfHwg/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 62EB61A15B6;
	Wed, 12 Aug 2026 14:08:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E7C86045E;
	Wed, 12 Aug 2026 14:08:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8A5911C4CF5E;
	Wed, 12 Aug 2026 16:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786543711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XBityMeKqjyowdclncFOnu3VU0emdWfgWBP0wAYzEhU=;
	b=dfBfHwg/xTtwCKIqKwd6LzkSS7fZ2K9nMLgE4fMNGfMg0gHXnyWzjlg9RB0m/YIpasZRb7
	wjzm05kYbHoV5COM9bUImVh4MFL+fs+ZmPeqe6pw8KBKbO7hqg3xOQNw3ZpTlWoGCGmvWJ
	7jdEaauWKroly5iz/cE8P+HQcmQV3+5eJJ8pdTVLKSR+bCDE0qkvmiRkClbfVczb9Ftq4z
	Tp2UrALb+ixnUULxtX03D0D53nyok21dsNwlP0X3mzWqczSI5oyC15HPb39l+ACCtRfJ2U
	ZZ+ZGLEUBcvqaLuQbS0h1VZdC1kyU0g5dtk6mg+GhqU1jg5Qdk1LarYlUYBx/g==
Message-ID: <96146485-03f4-4c82-bb4b-9338b6591b2f@bootlin.com>
Date: Wed, 12 Aug 2026 16:08:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: add XGMAC timestamp
 interrupt support
To: Zxyan Zhu <zxyan0222@gmail.com>,
 "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, richardcochran@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260810100221.9166-1-zxyan0222@gmail.com>
 <b3d90606-781a-4055-8529-e68e22a45ce9@bootlin.com>
 <20260812202027.976@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260812202027.976@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

+Nazim

On 8/12/26 14:59, Zxyan Zhu wrote:
> Hi Maxime,
> 
> On 8/12/26 5:10 PM, Maxime Chevallier wrote:
>> If there's an interrupt storm, then this should probably be a fix for -net
>> with a Fixes tag.
> 
> There is no interrupt storm. XGMAC_TSIE was never enabled before this
> patch (XGMAC_INT_DEFAULT_EN was LPIIE | PMTIE only), and
> dwxgmac2_host_irq_status() masks the status with the enable mask, so
> XGMAC_INT_TSIS could never fire. The actual symptom is that
> auxiliary-snapshot extts events were never reported -- a feature that
> was never wired up, not a live interrupt storm.

Ah indeed, quite the opposite then.

> 
> So I'd like to keep this on net-next as a new feature rather than
> retarget it to net.

Yes makes sense indeed.

Can you take a look at the sashiko-reported issues, it spots that this
could interfere with the timestamping on agilex5 (another XGMAC platform) :

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810100221.9166-1-zxyan0222%40gmail.com

Maybe there's some stuff that could be made more generic by moving them out
of the socfpga code and putting it in the more generic timestamping code ?

I don't have any xgmac boards to verify sashiko's claim though.

> 
> Thanks,
> Zxyan
> 

