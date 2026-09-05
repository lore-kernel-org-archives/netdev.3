Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B7348465;
	Sat,  5 Sep 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613318; cv=none; b=KdUL4MHdMH+eCG+dLkfC1suhSPHd/PlzrqOGRo5zZbrz2LD5f5F4jSzVPADMLR6PWg0eJgQI/cqgrxH5sIlFC2bAhkFa0uNexZLC/qg3ARtez/ZaunMOdBcDthUZtnBL9PqaawbXpghnKXqbpVKevxUkOLpXUW9x+vs3bH4npU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613318; c=relaxed/simple;
	bh=Hp/pIeAuVJdhAbn3gEUZVq+HRG4VxTxMpyxpcZQ0yVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzd3USXHH9viVOeZuUSwfvhoYzP3mmNP3u/Gt02vjyUQ2RsMkHuSXa7iWjBQ28z2Fs7uVNLSsSQ36SXWMVxBNWgnot3pwhiowblVHAN1Uq+cGoX0quXekp9g2+on2d/lHRrEF4Pf/8dfwMxtJb8cKKh7REID6CxejY52oEjpr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Z8SQA1sX; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Z8SQA1sX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E797511D95B;
	Sat, 05 Sep 2026 15:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788613310;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S7/Cw5rwYbEzRDJP7yp4ExFO+R7hIXrTQg4UYQtafD4=;
	b=Z8SQA1sXk1RgIURrCEgpGflux+mdZ9/St3xZXh3xWDzh5g87P1D1bWgMrnA/8U1hjWlzy1
	bW2jHIKPLR+ywGTsC+zhtX2GHGbxBxomiTEdNJ8zpEz0nZYwVzOYwOrJLbWc8YR9ulNLNH
	tn/0Y7tVgNhFWZHwQiKzBv9S1Wev840OgdXo6H1JaZyPAr6jLSec6wiO4rlWgHljm7gXnG
	7noCHfFgJ5a9V8HY4DUSKgyhKthuy9QSONvkn66NbcPeFv9ilKACI2OIWV7zHxJppchjbs
	+atUg5aerda7YlJxsqczRWWvCPJZsAJbpvpnzl5QEZVLHBx7j8wvW/S1yi72ZQ==
Message-ID: <8622fe1a-38ca-46d5-809f-94bc1f1ec159@nabladev.com>
Date: Sat, 5 Sep 2026 15:01:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v1] net: ks8851: Fix receiver error in 100BASE-TX mode
 following software power-down
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, bigeasy@linutronix.de,
 yiconghui@gmail.com, kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260901173925.96183-1-marex@nabladev.com>
 <20260904003712.3484001-1-kuba@kernel.org>
 <f7149e71-2c32-4f53-86c9-d1c586218fc2@nabladev.com>
 <20260904182812.303b91c0@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260904182812.303b91c0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/5/26 3:28 AM, Jakub Kicinski wrote:
> On Sat, 5 Sep 2026 03:16:12 +0200 Marek Vasut wrote:
>> On 9/4/26 2:37 AM, Jakub Kicinski wrote:
>>> This is an AI-generated review of your patch.
>>
>> Sigh, a wall of generated text.
> 
> I'd feel bad if most of the patches I have to suffer thru
> these days weren't entirely YOLO'ed slop where every lines comes
> with a 15 line comment :/ (not speaking about your patch, just
> a general vent)

I do understand.

This happens in other areas/projects too, although it seems netdev is 
really pummeled by this.

>>>> @@ -506,8 +503,6 @@ static int ks8851_net_stop(struct net_device *dev)
>>>>    	/* shutdown TX process */
>>>>    	ks8851_wrreg16(ks, KS_TXCR, 0x0000);
>>>>    
>>>> -	/* set powermode to soft power down to save power */
>>>> -	ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
>>>>    	ks8851_unlock(ks);
>>>
>>> [Severity: Low]
>>> Related to the above: the kernel-doc for ks8851_net_stop() just above this
>>> function still promises the low power transition that is being removed here:
>>>
>>> 	/**
>>> 	 * ks8851_net_stop - close network device
>>> 	 * @dev: The device being closed.
>>> 	 *
>>> 	 * Called to close down a network device which has been active. Cancel any
>                                                  vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>> 	 * work, shutdown the RX and TX process and then place the chip into a low
>             vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvXXXX^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> 	 * power state whilst it is not being used.\
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> 	 */
>>>
>>> The post-patch body only masks IER/ISR, zeroes RXCR1/TXCR, drains ks->txq
>>> and calls free_irq(), with no PMECR access left. Should that last sentence
>>> be dropped or reworded to mention the errata, so readers of
>>> ks8851_suspend()->ks8851_net_stop() are not told a low power transition
>>> happens?
>>
>> What exactly should I adjust in V2 ?
> 
> Drop the part of the sentence in the ks8851_net_stop() kdoc that says
> we'll put the device in low power mode?

I will do so in V2. I appreciate the human feedback. Thank you.
