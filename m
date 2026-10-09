Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCD3101D0;
	Fri,  9 Oct 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534527; cv=none; b=vBsXqJw5Fn8gjzmu2QHHM/UE8t829aWXdjeq+9vcTBESCnC+zh7cnVp/OHd80nrC6iU2gIWL1Hg8oF99vKQyoe8mem5Q6ncO0nlYje91HldpT6gJ2LruF9fGmYoAitsR08R62aBgxaBztH5PscGsSUuJ0D98vGZmsuOSEmm4s34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534527; c=relaxed/simple;
	bh=ZGMjphjVRG+EqkKY2GbeiSMoAegjQTgc+qG7pej+Yds=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ahl9u3nxId/M6AMTzB9dMa55ZBash1WsvBMJJACrr2oqZelcIVx+cJCYwD7g4Xl5+3VMIgGXxRn1vp7NqwT2CUNaItHB92zp5857iDwIuyDKlEklryG5KrlN7ezGw9Sz5nIzSnZOiqfv8mTvKwnNNU3be0WXJnQPb1LE69JdMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=GU8rHtvz; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="GU8rHtvz"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FFEEA1551;
	Fri,  9 Oct 2026 10:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791534513; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HQbvHG9dS6Fz273yiv0iGKMQDZdhvY99dKZijkTdQdE=;
	b=GU8rHtvzBPZb+mxT4QKfqAHxlxmrtxZDw4fH6wYEN7QpgALC9hLkjtigEDwUvDHkXmaPhE
	FbiIXwS3Lm2oweabliX9wL7h0R0OiSAPRt5smELMkp69bpGjGS4qErVswRkTEaFdPJt3sP
	JTJwORh9PlwEDyHM2B6MHxZkHKuxr37cZeXng9lHBN360ZwUju7Tcko0dLcy1XB27uUTAg
	CvSyAcXFwmcRj6hc3EEoSyX/DLa1plxz2axwVV7boU8hoqKoED6Ovar/+n7lXW8sVsWrE+
	8JP0Sg0fE0nDTaPL6FuJxcN1T3HAg2dg1DuIK2KxSwn3Jc4f25t9pg7HVmDkXA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 10:28:31 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefano Munari <stefanomunari.sm@gmail.com>, netdev@vger.kernel.org,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nisar Sayed
 <Nisar.Sayed@microchip.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: reject invalid EEPROM write
 requests
In-Reply-To: <cc1a471e-ba76-4fe5-a982-0cbe1775c915@lunn.ch>
References: <20261009005702.164936-1-stefanomunari.sm@gmail.com>
 <cc1a471e-ba76-4fe5-a982-0cbe1775c915@lunn.ch>
Message-ID: <4fbcbf4e3caf264ee5abef2275e02cfb@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9.10.2026 03:27, Andrew Lunn wrote:
> On Fri, Oct 09, 2026 at 02:57:02AM +0200, Stefano Munari wrote:
>> The runtime PM handling removed the -EINVAL return for invalid
>> EEPROM/OTP write requests. These requests now return zero from a
>> successful usb_autopm_get_interface() call, even though no data is
>> written.
>> 
>> Set ret to -EINVAL for invalid requests while preserving the runtime
>> PM reference release.
>> 
>> Fixes: 8a7ffeb795f8 ("lan78xx: Fix for eeprom read/write when device 
>> auto suspend")
>> Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>
>> ---
>> Tested on a Raspberry Pi 3 Model B+ with the onboard Ethernet
>> controller, using raspberrypi/linux commit bba53a117a4a on the
>> rpi-6.6.y branch as the baseline.
>> 
>>   ethtool -E eth0 magic 0 offset 0 length 1 value 0
>> 
>> The command succeeds without the patch and reports "Invalid argument"
>> with the patch applied.
>> ---
>>  drivers/net/usb/lan78xx.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
>> index 5655941f1478..7ac263454d45 100644
>> --- a/drivers/net/usb/lan78xx.c
>> +++ b/drivers/net/usb/lan78xx.c
>> @@ -1719,6 +1719,8 @@ static int lan78xx_ethtool_set_eeprom(struct 
>> net_device *netdev,
>>  		 (ee->len == 512) &&
>>  		 (data[0] == OTP_INDICATOR_1))
>>  		ret = lan78xx_write_raw_otp(dev, ee->offset, ee->len, data);
>> +	else
>> +		ret = -EINVAL;
> 
> It might be the nested if's without {} which caused the broken patch?
> 
> Maybe add some brackets to make it clearer?
> 
>       Andrew

8a7ffeb795f8 dropped the final return -EINVAL when it converted the
returns to ret = ..., braces wouldn't have caught that. Fine with
adding them for a v2 though.

In either case:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi 3B+ 
(LAN7515)

Thanks,
Nicolai
