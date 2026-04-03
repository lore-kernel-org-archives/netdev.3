Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EF3368A6;
	Fri,  3 Apr 2026 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242054; cv=none; b=kVRz8LX0poltBcfgo1Jl2paIXGwr3yuwN/tTM3zK7lYWl1vhc83ytDs9l8L5J32DgalJKRJ2v+P37fs6EmlwKXD6g6IgQpwO4cfh2YCAs3ZtQn3Cjh8iqdN4gJvOja1izoHcHmMt/UUNogDdLOTV6bOGvIAxO6J8eTNKhalYDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242054; c=relaxed/simple;
	bh=5BPMK30EdUf6lrcstEuFWW/L/u0KTrVwDcnY4J3PKh8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mQf+KmGSm81zQEIPrXhOk4OJCRCEBjhIacmStkV+RYmQm9JFJspTpdRSjWcipEo/VbJHfj3mOd3S8N4ls+2bxDXohE28p+9B01CfDuoOFzgMEpM2xQ/LMK9mqOzz0IW/gJCGt/7k515meRwCCPrQ7lui6XyQ6rxpUwPwx+483Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=rLNZUIBF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="rLNZUIBF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0AC0A0311;
	Fri,  3 Apr 2026 20:47:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775242044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CH0yyrQZInUfuLOCxhhnxj/VLPGjptiPMOMcl+uV17Q=;
	b=rLNZUIBFOzrCOxM1V4KGaaInTgEujeIcuq50ffTG6PpJG8p6FDg1q+uUFbpRkGVW6ylnMk
	Fa4Bi3XBRWwP40XM7Ww3vNDVvflSzzAT9b0tSVl99AHKACBP9K93deK90yPg4Q8Gv+L0hp
	yVNkZqgYIDyF1HF3SXKK7sJFkZYWRb3XMDAFbwFPjnEcY234UsMuw1oM90RqUR4tq862Q0
	RonCPzTBASuq/NnQSHB053GL0/VY29jW9HUq45dv/kITWK8eBusuL9a6EYnAcYPWWXywi9
	QoiyiysX/7EvkTyTsLuMPPr/vbyJF/xOsYvqlryng8IhZEyBAHr+XU1O6iazpA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 03 Apr 2026 20:47:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/3] net: phy: add support for disabling
 PHY-autonomous EEE
In-Reply-To: <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
References: <20260403090656.733985-1-nb@tipi-net.de>
 <20260403090656.733985-2-nb@tipi-net.de>
 <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
Message-ID: <7cc447d8fcc2d38a53e614e675746457@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3.4.2026 17:27, Andrew Lunn wrote:
>> + * @autonomous_eee_disabled: Set when autonomous EEE has been 
>> disabled via
>> + *	phy_support_eee(), used to re-apply after PHY soft reset
> 
> Thinking ahead to when autonomous EEE is supported, there will be
> other reasons to disable it than just phy_support_eee(). So i would
> not say this here.

Makes sense. I will amend all comments accordingly.
> 
>>   * @eee_cfg: User configuration of EEE
>>   * @lp_advertising: Current link partner advertised linkmodes
>>   * @host_interfaces: PHY interface modes supported by host
>> @@ -739,6 +741,7 @@ struct phy_device {
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
>>  	bool enable_tx_lpi;
>>  	bool eee_active;
>> +	bool autonomous_eee_disabled;
>>  	struct eee_config eee_cfg;
>> 
>>  	/* Host supported PHY interface types. Should be ignored if empty. 
>> */
>> @@ -1359,6 +1362,21 @@ struct phy_driver {
>>  	void (*get_stats)(struct phy_device *dev,
>>  			  struct ethtool_stats *stats, u64 *data);
>> 
>> +	/**
>> +	 * @disable_autonomous_eee: Disable PHY-autonomous EEE
>> +	 *
>> +	 * Some PHYs manage EEE LPI autonomously without forwarding LPI
>> +	 * signaling to the MAC.
> 
> My understanding is that LPI is always from the MAC to the PHY?

Probably not the right wording, agreed. I was thinking of the RX LPI
counter on macb, which wasn't incrementing until I noticed that the PHY
had AutogrEEEn enabled. After disabling it, the RX LPI signaling
worked.
> 
> 
>> +	 * Called by phy_support_eee() when the MAC indicates it supports
>> +	 * EEE. PHY drivers that implement autonomous EEE should provide
>> +	 * this callback.
> 
> Again, there will be other reasons to call this, than just
> phy_support_eee().

Will do.

> 
>     Andrew
> 
> ---
> pw-bot: cr

Thanks for the prompt review

Nicolai
