Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF03F4829;
	Thu,  1 Oct 2026 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896310; cv=none; b=t0c+UKVFRjKtLk4OmZRtVHwJHEfgMW44lkOyFSWJzFzyoqYko4RFKUUXTYdWDpdk3SHzvbpleM8JXrytr1oecDL2A6B1QcR0mx2OVmk1mb+g519Q93kvExUYEmQ7egXxgSemYsjwoLFkIEVMgPLfAsJcbZdRf835Wg1b4/sOilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896310; c=relaxed/simple;
	bh=kNFSA9YbKim6YXQDkqz9wzqYtqo1Z8c0lWeDeMGLLh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aso7SLTfFrKgi9jAo6OF2whXf37CamXzZaGiPAaH3inwXKVKU215q9tdd5312muBx72ZaLngRUkdTa2TN91EIuZG0SFEsUP5hgtn8xzzNdf6ZwzZngwI4eyBjB/5/hGcN1jWY6dsvNmdjleJmxMC8+3624KJzpGmImC+YyvXElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ecCQFT7o; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ecCQFT7o"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F91C1073CF;
	Fri, 02 Oct 2026 01:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790896302;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rsGAq8HSvUzJC7GII4xXk2cib1xNUHDcCfOGhmM7R8w=;
	b=ecCQFT7oep5Tubzy6dA+uBD3p67i3cFCCV3uzfe+vvz7HdkODym4wXpLPyJAHtirOIS1L8
	OSJhhuzZL5Km52yHqQ1boi46dX/joU+VtDA7NLil3JUiIY7YFhuja9AFHU+QifS2q7HLWY
	7fDo7/m7tUUXed2SHjenn3gxTi/9FPh2AKmnM2pDRmtO/o9qNq0+Cq4nVU+toWtZabe7ED
	XLPUaiI5eFfWFsqb15n7Il2LTY5EWqEV/hH04sBGSjsG4z4lWCmONsjo1pXXraEHh1kT5A
	tyCrX9WtO6ryb11hkEwVHri8CVLzA6h9Eg9nVvHZ3T08UxkqQ6i2ImO4zxXozA==
Message-ID: <6b22d5e7-1f94-4c3c-8a0e-5c5573c4c7cb@nabladev.com>
Date: Fri, 2 Oct 2026 01:11:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
 <20261001155129.51ea9930@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261001155129.51ea9930@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/2/26 12:51 AM, Jakub Kicinski wrote:
> On Thu, 1 Oct 2026 03:34:09 +0200 Marek Vasut wrote:
>> Jakub, do you want a revert of this one, fix, or follow up patch ?
> 
> FWIW the answer was follow up, thanks for sending it!

Of course, sorry for the mess this created.

I'll try to figure out some more flexible way of configuring the MDC 
clock together with Wei, basically what Andrew suggested, in another 
follow up patch. Hopefully there is a way to do that for all the SoCs 
which have this IP.
