Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3D51616F;
	Wed, 30 Sep 2026 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801860; cv=none; b=QPmYuRsLcuT/SNbokIdpDAs19L2Wt+zXU03Q+rL2gHBwsfJg3plyyrEykuo34kQvbEvUr9r56QCtcNFgyfAwKgUMBN/4wmjl2mLAzUNm/Q7g+6uy9McMqWWvtr6daObGa2fb1N2ftzi3+3Zv5hmmgTYYJOurxp4pEFPRGzUPtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801860; c=relaxed/simple;
	bh=nmUsv0J5pUhQ3dpH/PXEA/rw7xaDEijL2dSc0anSXRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiyuA/Kr6eXurE/JpREtX3Cwawb0bW0dZVHAXeeP2uZTiD5ET22YMUopu9A+LaNJLjuj3z/tWPcrDxy7lCXkiJ1YGZRPdgjxUdrDhLPKxZlp5Su8VGVGpk/MmuzENk2Vmdc5agg/YfM8+BXzCSu4CMcOufcxtDX5GnE3DPSPIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o+GwCXRJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o+GwCXRJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C6CD54E410DC;
	Wed, 30 Sep 2026 20:57:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7AE2160749;
	Wed, 30 Sep 2026 20:57:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEA0C103284B8;
	Wed, 30 Sep 2026 22:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790801852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TyaAbpuPiS5y6K2q3h0tQGdPcgfkiiLZd4EjA7XRNRg=;
	b=o+GwCXRJ5P3nMMk5uq9+VDdeNGNKmjxFBB/NfW7tKT9LUocomZ/u+yCOSFvqxixlZW5RhC
	jz6/mmQdkTbOv86Q/j3Ctlgl4/nn08j6bZbqmK9C7HFRBr1fnkshCw6oVj4A4YBh+HU6oy
	KizH7yfjGCKXxEw9cwyeoxU9CDvXIT+27wwCizDuRLb12JgGQD0FHCR/w9RpZ+uP45sAjj
	0oN+577vTvIjF9vLxpal1A2BzGYdyO+IK5n3bKgFrT+XNMQaK3hlxI63r1o7QG6WtdPowO
	jYynfZgIuQQHXpUlj1bTMxfN+zxR8rY8ChggQEcPivTt/TLnS+OlA2besyPpFQ==
Message-ID: <82cd7194-bc61-46b1-ae44-a78b33047017@bootlin.com>
Date: Wed, 30 Sep 2026 22:57:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: keep the NAPI_DISABLE flag while napi is
 disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260926194714.648819-1-maxime.chevallier@bootlin.com>
 <20260927154142.656700c6@kernel.org>
 <189e048f-d04a-4440-bf65-166c747ed6cf@bootlin.com>
 <20260930134109.0fc3824a@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260930134109.0fc3824a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/30/26 22:41, Jakub Kicinski wrote:
> On Mon, 28 Sep 2026 09:08:29 +0200 Maxime Chevallier wrote:
>> On 9/28/26 00:41, Jakub Kicinski wrote:
>>> On Sat, 26 Sep 2026 21:47:13 +0200 Maxime Chevallier wrote:  
>>>> This seems to be more general than stmmac though, there are lots of
>>>> drivers that create the napi instances in .probe(), so they still live
>>>> outside of .open()/.close(). It was verified by running the following on
>>>> an mvneta board :  
>>>
>>> Not sure this works, you assume ownership if DISABLE is set but we set
>>> it to start the shutdown, not once we stopped the poller.
>>>
>>> We've been tempted to "fix" this multiple times. I'd prefer to fix
>>> drivers.  
>>
>> There's 2 classes of problems then
>>
>> - drivers that create a napi instance but don't use it even when
>> admin up (stmmac, I think it used to be the case for i40e looking
>> at the history). Fixing the driver makes sense then
>>
>> - drivers that add napi instances at .probe() time, in which
>> case setting threaded to 1 -> 0 when the interface is admin down
>> is always going to hang. There's quite a few of them :
>>
>> git grep -p netif_napi_add | grep probe | wc -l
>> 75
> 
> TIL git grep -p, nice!
> 
>> So at least 75 drivers call netif_napi_add from their probe
>> functions.
> 
> Mostly old drivers, half of which we should probably delete :S
> 
> Can we not refuse disabling the threaded state if the device
> is down and has NAPIs?

I don't see why not :) TBH this is a bit outside of my comfort zone,
I'll spin something and give it a test on as much HW as possible.

Thanks,

Maxime
