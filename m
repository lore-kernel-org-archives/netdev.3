Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E32DFA4A;
	Tue,  2 Jun 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403734; cv=none; b=BOKgdd257Spmj9qV5H053AYk9FanM9ZlwcCdPmxWluOHOQe5Iq/ZQQR+vVt5ctx+366vrocrnZBMCQTFkQHGTKRJGkg4vkS8IuQA5retnlPVw6AVdcqxVn+ZJPONSK26KURqJR61P7fcHTo/UxY/I4NDdNKkL3OVfikQysKDWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403734; c=relaxed/simple;
	bh=I0QDg6G6AapDDqYfMxlTIiJxSV2XtsVgT1hfH56QNfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImTgLnXT18csVeOYIL6Oyw0xTbAt9BOrDdJYMh390z/yNX/ejP/pNJxfOR/KRzS76EbVR7USYFibd95i1Cm8VeBlpeFsJ1tWhZqccjk4QogpofO5hvAv7+CSuSE/52gSG+iqo38M1cDA6goObDtwI83HcKKatt46gxU5uZbrEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PFb/PM0U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PFb/PM0U"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 450251A37CF;
	Tue,  2 Jun 2026 12:35:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A922603BC;
	Tue,  2 Jun 2026 12:35:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEE251088838A;
	Tue,  2 Jun 2026 14:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780403730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Mk3lbYAo7Fhbsq+GgLjqKB9ET89dghURWZHrREYQeRQ=;
	b=PFb/PM0UqY28pTaaO7IpOLQ8g4WoAsw6oTHFVf0Sn8eE576cajUOPp2e3QqEI0uurLwqI5
	uxKTOY7mpJ9Cc3qJMFE0XKlVMklRo7pAGrp6FtjUPYwDWgkguCA2CWmPpzmYtD45WeuBTs
	tlZf2/VRQArgoQZHeZMgu9CcZhXA6jO+tZYfrhaD10p2TeMTIwxpXoBF6IPyvWVAqGvnIT
	6sMTc/+Ax74Zt9HZvsOg/Qbnou58D8mUpFTQ2Z/pAdIpQZG3j4n0VSCklZVQSBk4XFYJet
	Nm3bKJSUtu9qIZgjmvpwsG/TD7Q/IqsLgHNKzKRjG1Nf5lwPbDmF252589avog==
Message-ID: <0a79ac7d-2a57-4679-bd35-92fea2575b19@bootlin.com>
Date: Tue, 2 Jun 2026 14:35:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/9] net: dsa: microchip: implement port_hsr_join
 for KSZ9477 only
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
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <ccd6cc44-1ade-4b29-9d7c-8e440de1651e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo,

On 6/1/26 11:03 AM, Paolo Abeni wrote:
> On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
>> @@ -1744,12 +1784,20 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
>>   	/* Setup HW supported features for lan HSR ports */
>>   	user = dsa_to_port(ds, port)->user;
>>   	user->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
>> +
>> +	dev->hsr_dev = hsr;
>> +	dev->hsr_ports |= BIT(port);
>> +
>> +	return 0;
>>   }
>>   
>> -void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
>> +static int ksz9477_hsr_leave(struct dsa_switch *ds, int port,
>> +			     struct net_device *hsr)
>>   {
>>   	struct ksz_device *dev = ds->priv;
>>   
>> +	WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);
> 
> Since the new op is used only by the relevant switch version, I think
> you could/should remove the above warning.
>

Ack, will do.


Best regards,
Bastien
