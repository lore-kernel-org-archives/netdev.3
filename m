Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04649B5B9;
	Thu,  1 Oct 2026 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892057; cv=none; b=kSfW6dvGJpD8PHgQAdTlDQLO6U4CZimhVJGCM03iWdylghO0oG+7O6fHFbuJqRD8hulKrSCCSVmDlw4bhgfZOgxaCHk//G/Ac+n0Ud+Y19t1AlZI2pSDn/SyQ35BVoOXqdWVFwJQXlbrunroWGxrkltCWqPfQxKd7ggAOIt87Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892057; c=relaxed/simple;
	bh=ELivsARhygXT/WSI2Il9Y8RftwyUPEQXL7HxEm2Xews=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IkjvWXlYdbGaSG2ChRI4gjpqGWtNWZAah89tFaj977u7c0zxFcYTAWff6tT3J6GCLe91neIbfqetMYLv1V8jymHIbLJwmOpkcyQ3kA6n68mUSlPuALSjbFXWmXo2PWK8KiKmlQ7OyotdHlzJers9/K4is30ubsm1/j1G9DAMkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=bWMydpux; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="bWMydpux"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A4C71073A4;
	Fri, 02 Oct 2026 00:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790892035;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FKrxggt6tXLHGGG9Az9Ua8a0Hw1UqySB4ol4URFxVGk=;
	b=bWMydpuxo1omedBW6n3KLeflnr/fWMnVMB5hPzZsoxMqTD+zwK+Xrv47g9qgDqjRP3LbX5
	G32k6ed4zsJFX0CyCZiWLavUshopo5Pag6p0NJJMem6E/rQ3SueNtm2enV4DTfS+erRcif
	+4OJ1mjCUz/LJOWBy0tW4MNjj34DgyLA+i0UsNSwlA1NwD6DxtA7VUlVxQkViPIbVMXXV+
	oGaW9+l0HnZb9Gw8RFqVBz9KUzsAi1a4CmuX4cyh4QUMOIil3JvVvwkO6JxY6tx7GBzsS5
	LYHM9NLyyTRhuu42nnpOQygJgg/z1xAeclSDuK6fFcMjM2TJJn2c38TcxWxK5g==
Message-ID: <d8e72848-1611-4d6e-b3e8-17013bce7948@nabladev.com>
Date: Fri, 2 Oct 2026 00:00:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
From: Marek Vasut <marex@nabladev.com>
To: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
Content-Language: en-US
In-Reply-To: <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/30/26 3:27 PM, Marek Vasut wrote:

Hello again,

>> Clark helped measure the MDC rate on the 95 EVK board this morning, 
>> and the
>> result was 644KHz, which is consistent with the theoretical value. The 
>> scope's
>> accuracy or other factors may be causing you to observe a rate of 558kHz.
> 
> That 644 kHz and 558 kHz differs too much to be an equipment 
> miscalibration / misuse.

For the sake of completeness, the MX95 B0 I have on my desk now prints 
this in SM:

 >$ clock.r
...
097: busnetcmix           =  on,  133333333Hz
098: enet                 =  on,  666666666Hz
099: enetphytest200m      =  on,   24000000Hz
100: enetphytest500m      =  on,   24000000Hz
101: enetphytest667m      =  on,   24000000Hz
102: enetref              =  on,  250000000Hz
103: enettimer1           =  on,   24000000Hz

And the cycle time of MDC is 1.8ms , which is some 550 kHz .
