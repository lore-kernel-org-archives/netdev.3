Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0393E9C1C;
	Tue,  2 Jun 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409175; cv=none; b=WzJyh6EBswINKj5mxmvxqpI5f6HADOstp+rawSjKcIoFCQlyzexeh4AJvb4Wude33FGAtuWmx4cyVsYd2HitYbOuZIaU5jCpFVrg/SDp9EQHrkYtsDSFxKtE1Ekl+xpUWv9UcSmJ0sOFFuXjHkRXIeX/u1td0qWB0XB/rl7sd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409175; c=relaxed/simple;
	bh=GxfaAHTJvymW9iUhiFO+Sx6ymhlxBbVQjaoTEvnickA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ipB7k+s9Zh+bzqeYxlPLqIw7IPqWodOj8ML+8JrrpXyZCT3jTfUisG+yEg7xlCFzet0BbIRpQ+51iKkqSxZhqeD2LiBhgNt7k6Wi96SEZPl50Em16pbvfknsfQ14mOH+xiJs6U8CVwZdyiIIaGkMvlXwpFnRzLb09lychNTvycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=piM+xKgf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="piM+xKgf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7231B1A37D0;
	Tue,  2 Jun 2026 14:06:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 435A7603BC;
	Tue,  2 Jun 2026 14:06:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3148D108883E7;
	Tue,  2 Jun 2026 16:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780409169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sCyHaYS6wI1h5bixiKt7mgCwRJBOeMLVJ44ZFdmSaVU=;
	b=piM+xKgfrxuHRh/h5Uw8okxfHQUx5IpIjFRZFzCnnvFvUPU+j6JCa6lQxI3cVW80sr6xV7
	/46dPc5FzM0rY5/LNiyovDBVBD5LuCrGvo2yz4Lwrup2qV9zhwrdoiu9JeUk6YOm+DS1c+
	PBeTi4wdvwcQtKPoukuSsqoxCmvfmGNOCjf/4y2GT6rO5G8X0C2aOoEyhm8UTub4GMJJaw
	YeZfiZ4AKrnZhpBCReaPz31Jz2DsOyKMTSFt7o5WsJyd1OaBb4yB7kghV6judL4+5yBAyc
	FR+95msSRVuUClAcz5oc9SjxKRGUa7ufAe8nIKwpitJc2RYbkEhPFBdgqltaEQ==
Message-ID: <20276935-8e9d-4c6b-a4e4-d73b6bcef6a0@bootlin.com>
Date: Tue, 2 Jun 2026 16:06:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/9] net: dsa: microchip: implement port_hsr_join
 for KSZ9477 only
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-7-5b63e732149a@bootlin.com>
 <ccd6cc44-1ade-4b29-9d7c-8e440de1651e@redhat.com>
 <0a79ac7d-2a57-4679-bd35-92fea2575b19@bootlin.com>
Content-Language: en-US
In-Reply-To: <0a79ac7d-2a57-4679-bd35-92fea2575b19@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi again Paolo,

On 6/2/26 2:35 PM, Bastien Curutchet wrote:
> Hi Paolo,
> 
> On 6/1/26 11:03 AM, Paolo Abeni wrote:
>> On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
>>> @@ -1744,12 +1784,20 @@ void ksz9477_hsr_join(struct dsa_switch *ds, 
>>> int port, struct net_device *hsr)
>>>       /* Setup HW supported features for lan HSR ports */
>>>       user = dsa_to_port(ds, port)->user;
>>>       user->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
>>> +
>>> +    dev->hsr_dev = hsr;
>>> +    dev->hsr_ports |= BIT(port);
>>> +
>>> +    return 0;
>>>   }
>>> -void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct 
>>> net_device *hsr)
>>> +static int ksz9477_hsr_leave(struct dsa_switch *ds, int port,
>>> +                 struct net_device *hsr)
>>>   {
>>>       struct ksz_device *dev = ds->priv;
>>> +    WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);
>>
>> Since the new op is used only by the relevant switch version, I think
>> you could/should remove the above warning.
>>
> 
> Ack, will do.
> 

I'm having second thoughts now that I'm about to do it.

This HSR feature is only supported by the KSZ9477 itself, not by all the 
switches using ksz9477_switch_ops. A check is done against the 
KSZ9477_CHIP_ID in ksz9477_hsr_join(). This WARN_ON is kind of symmetric 
with the ksz9477_hsr_join()'s check so, IMHO, it makes sense to keep it.



Best regards,
Bastien
