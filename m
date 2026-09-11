Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB23914E0;
	Fri, 11 Sep 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111400; cv=none; b=YVMLvXm/IyF45jWAqxhFlks9AvaGHJIbUZX5F9DcZqURghiPBLyYDgFyFe7nQXygyq1eHu5oF69X76fnWgnDW+3ftiKEM4lCUBJp/P8n1dxG6kgPf42kpYle9jWMCoTBQ/1kQryp4NIb0MSxPYEJR0BnozIkVnMeXQqbS9bdQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111400; c=relaxed/simple;
	bh=c1AgHRS0EmU60Bp3vjCVJYjmTqk8yTorX8Rct+9ymOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=daib2x2HPQ41Uo4PyQjOGND1IGDclJBYOxn0gXNd7948oGRD+CNDjByfYo/kwBn97nQ7w5q4xMbX7sz8aYvtckySITjlCAzC8y1YWTtuaGlpcah9jdgaU7uuzxJjedOkmB9Iy8XwgCbgswsBbMKgGHUFMM0XhQJCoaAUCEQgE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MezZ0rUu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MezZ0rUu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 575F24E40131;
	Fri, 11 Sep 2026 07:23:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 190C8601DE;
	Fri, 11 Sep 2026 07:23:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 292A211C78B21;
	Fri, 11 Sep 2026 09:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789111391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/gXD+hctxQcqJ1MwkURWgWTFxlz6PrTXT5u2lwgFMC8=;
	b=MezZ0rUuAOjrB53VSshI2Voqb9PWyHBapUK0ta1NUJCLmltBLv+wsw541j2LGCWrJC03co
	XVQtky8z1HET1GVwLkeMlVDhuD8ntgpE4qvsnQH5DQXzeXEwFwtU5hI4tzRogz08m3kxp6
	UuefjZhmPfWZOSKabD8B2hmEuH3RU/71Tka3KkZck3XohISaYIATcAxVRp2eIIAY6NkAr9
	+l7ZR+y6k2oORY+rT49CXbxXaT5Uw03nFTKhv9lOzEZTTt5y37kwuKNkZunpCho4u/CkD/
	kig5UildctR+REsqBqh75HpRiUScRkw/U7PXZZwGjNO59PDu06tDIL6s4Dv1YQ==
Message-ID: <e2ecdd7e-80dd-4540-a316-0718d05cb367@bootlin.com>
Date: Fri, 11 Sep 2026 09:23:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/10] net: dsa: microchip: add periodic
 output support for the KSZ8463
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260908-ksz-perout-v3-10-6722a3f1ca75@bootlin.com>
 <178903621782.219967.1067616730052651942@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <178903621782.219967.1067616730052651942@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

On 9/10/26 12:30 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 (2) · Medium: 2 · Low: 1
> 
> - [High] KSZ8463 advertises 12 periodic-output channels (.n_pins = 12,
>    .n_per_out = 12, copied into caps by ksz8463_ptp_set_caps()) while the…
> - [Medium] ksz8463_ptp_enable_perout() is not transactional: it calls
>    ksz8463_ptp_tou_reset(dev, request->index) (stopping an already…
> - [Medium] ksz8463_ptp_configure_perout() dereferences
>    dev->ptp_data.pin_config[index]…
> - [Low] ksz8463_ptp_set_caps() (drivers/net/dsa/microchip/ksz_ptp.c:1335)
>    does not set ptp_data->caps.supported_perout_flags, while the code…
> 
> Pre-existing issues:
> - [High] The new KSZ8463 settime/adjtime paths funnel into
>    ksz_ptp_prepare_restart_perout(), whose catch-up arithmetic can…
> - [High] A denormalized periodic-output period is accepted as zero
>    nanoseconds and later causes a kernel divide-by-zero or an infinite…
> 
> --
> 
> net: dsa: microchip: add periodic output support for the KSZ8463
> 
> This adds KSZ8463 specific periodic output handling: per-unit trigger
> configuration registers, a smaller maximum pulse width, and a new set of
> ksz8463_* PTP callbacks installed by ksz8463_ptp_set_caps().  The chip
> data now advertises 12 pins and 12 periodic output channels.
> 
> A few questions below about the new paths.
> 
>> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
>> index 041bb4f963659..9e234ad71b723 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.c
>> +++ b/drivers/net/dsa/microchip/ksz_common.c
>> @@ -1161,6 +1161,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>>   		.supports_mii = {false, false, true},
>>   		.supports_rmii = {false, false, true},
>>   		.internal_phy = {true, true, false},
>> +		.n_pins = 12,
>> +		.n_per_out = 12,
>>   	},
> 
> [Severity: High]
> Twelve periodic output channels are advertised here, but struct
> ksz_ptp_data still keeps only one set of perout state (a single tou_mode,
> one perout_target_time_first, one perout_period), and the restart helper
> always rebuilds a request for channel 0:
> 
> drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_prepare_restart_perout() {
> 	...
> 	request->index = 0;
> 	request->flags = 0;
> 
> 	return 0;
> }
> 

This is an already existing bug. It made me realize that I forgot to 
send the fix ..

The fix conflicts with this series. I can either send the fix now, wait 
for it to enter net-next and then send a new iteration of this series; 
or send the fix once this series has been merged. I checked the other 
Sashiko comments, and IMHO, this comment is the only one that is really 
relevant.

What do you prefer ?


Best regards,
Bastien
