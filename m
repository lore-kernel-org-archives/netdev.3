Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD904457A6
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770593; cv=none; b=gJcWrXazUJMJQ+IxCH9omHgB76XjMir3ScHF0jCCm15hTgAG3hzCPseeyPwMoK8L/E0TJtXy0Sng4/W6Dqu6bg7mePtQLkIjqxvQD/iUksAe6Sm6fAdx7FOjkynN+fpHpBq+dmjrQfyuXIs0r93QAmx83pwKeOOcT4+5MrX9biE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770593; c=relaxed/simple;
	bh=OywrNZ4BtrhKjQt24W3zA3T7LubwDSC/jinrjoF+zgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0ZeXXwRqIFw2SljDlbX2UvblNWIyzYsqhXwEz5dMuEHuPYmw9OVZYJz96OOURrNK2gFulQkieY2ITSfCL6pYjbvEqDs8Pxb/TjMnDmGGH+c5mEgq5dggUzELaBcp9SlQ3kOcMFn5QeZbE7xYTQEo4iH5lSoryFM9B5oG4Bv98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=coAlhRbA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="coAlhRbA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C1E374E41569;
	Mon,  7 Sep 2026 08:43:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9428760383;
	Mon,  7 Sep 2026 08:43:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9DE811C7A43E;
	Mon,  7 Sep 2026 10:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788770587; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QPH9SwD0hXddm6xXbxjZJJRgmfIRKy2x0pI2YYN7uWo=;
	b=coAlhRbAGLCBssJtWVENWIjlmTXIFDrRkn/FUW9R7GJF0H3uYFpCozKK57CHxWHqGltbl6
	9kW3LR+wuQmweNJVwCSruG51FkFy37lFfbIPWJ2tj8FtYOsdmRWain/eNRldoCVA9wn1ZA
	pmf96tNkede6vgD8UNP/fWu/8RvWsdHIM4GDVfL+SEfJgsAjpOrQsOnuCmgNxDmBocT5xT
	BzzleahE2adqKJk3b1UrFy66G9PpxIPGlFMQWq0J6Trate8IQZvyx68boN0iVG0GcMvrd6
	Ltbuk1J0B39LmRw+YRjAQUICJoLDkZwse3VzboFjj6Bbk74XoL0nX71+XUBblQ==
Message-ID: <a3ee0fb0-417a-4844-8c8d-b29189ea2b31@bootlin.com>
Date: Mon, 7 Sep 2026 10:43:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/10] net: dsa: microchip: add periodic
 output support for the KSZ8463
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902-ksz-perout-v2-10-6f277fcc9e68@bootlin.com>
 <178857332410.219967.8963048354667407581@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <178857332410.219967.8963048354667407581@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

On 9/5/26 3:55 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 (1) · Medium: 3 · Low: 0 (2)
> 
> - [High] KSZ8463 periodic output is advertised as 12 independent channels
>    (.n_pins = 12, .n_per_out = 12 in ksz_switch_chips[KSZ8463]) but the…
> - [High] KSZ8463 periodic output (TOU) is not properly disabled in
>    hardware (leaves EN bit).
> - [Medium] Build failure when CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n:
>    ksz8463_setup() in drivers/net/dsa/microchip/ksz8.c now calls…
> - [Medium] The newly added ksz8463_ptp_configure_perout() dereferences
>    dev->ptp_data.pin_config[index] (reading pin->chan to select the…
> - [Medium] KSZ8463 TOU enable bit is left set in the hardware if the
>    activation verification check fails.
> 
> Pre-existing issues:
> - [High] A non-normalized periodic-output period whose nanosecond value
>    converts to zero is accepted, stored as the global restart period, and…
> - [Low] The KSZ periodic-output implementation accepts and processes
>    PTP_PEROUT_DUTY_CYCLE (ksz_ptp_get_pin() returns -EOPNOTSUPP only for…
> - [Low] ksz_ptp_clock_unregister() only calls ptp_clock_unregister(); it
>    never disables the trigger units that the perout path enabled.
> 
> --
> 
> net: dsa: microchip: add periodic output support for the KSZ8463
> 
> This adds KSZ8463 specific periodic output handling, since the chip has one
> configuration register block per trigger unit, a smaller maximum pulse
> width and 12 outputs instead of 2.  It wires new ksz8463_ptp_* callbacks
> into a dedicated ksz8463_ptp_set_caps() and advertises 12 pins / 12
> periodic output channels for the KSZ8463.
> 
> A few questions on the new code below.
> 
>> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
>> index f2a23e2e474ac..6b08bb8fed5b7 100644
>> --- a/drivers/net/dsa/microchip/ksz8.c
>> +++ b/drivers/net/dsa/microchip/ksz8.c
>> @@ -2478,7 +2478,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
>>   		if (ret)
>>   			goto free_girq;
>>   
>> -		ksz_ptp_set_caps(ds);
>> +		ksz8463_ptp_set_caps(ds);
> 
> [Severity: Medium]
> Does this still build with CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n?
> 

No it doesn't .. I'll send a new iteration with this fixed


Best regards,
Bastien
