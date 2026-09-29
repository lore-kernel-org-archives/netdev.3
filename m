Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A25383F2
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692940; cv=none; b=Y6h2eKymMQaIUybQjTPE91cxm9I0c2hYm4icsMaNej22mBUR4Stuue9O7WiesSSv/+PX/9FKo3+iUnY7Hjvx4+OXkZH8423M/35v6OXpE6AMW0/KyJc2muJjpS8I8uuBU4hAqYgA/QMEebtaaJ88JAQ5O+HBnh5glk4cZJEntLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692940; c=relaxed/simple;
	bh=QPhGD2tzq/MohOfOyWKlfII/ivWJ/1HwH7q4f0v8GH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea45GVfoEBmyh/xCZuQhsYoCN0N/bDB2Atq5znMXXD7/zAVpVRYg8Dw7+I8jJEJk74YzF+j1tCLFDawOmyWooeYzcvSvdLSUh0zGR4ub8Vvmmv8L33Ts9g9OZvFSHugDQtA493/5OBxXOAvUJJnqIMKxZKgRz4cD/0/vCdTYJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ek7XAPuO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ek7XAPuO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC3CA1A1064;
	Tue, 29 Sep 2026 14:42:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 82584601BD;
	Tue, 29 Sep 2026 14:42:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5262A103297F7;
	Tue, 29 Sep 2026 16:42:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790692929; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tc1nEVZolmCCR2ZFwJ+f5R5PC/tPEHSlzkXfC/LcRKA=;
	b=ek7XAPuO1G7nNgqyPmnGpWp22ylr5Zdpydl4tYrkQ8CwHDtO9qSK2tj+umhPnUlPjoGAAo
	kZX0ZM9hokjIoYu3zS6INykyiC8C7nvMrGFDgHDJIDjRQHQF1wQLlKR70pMsep2w9rz8Db
	xbzK2IcBs0dSzdv1wzeRDtQUXRMLDYGCZkWHvNG2GrhPOMkKyofpMT8NEmQm9TRgv0y90e
	nfCqZ4eeFKMHi0r/V6VaFaMgQ9GNb3LppmiBRmOPT+eTYqrpvg6oGw3IweFUDwV2ckTnW7
	bzNk603rjnAzoREbiOhLqmXKgSsJMBPd79wTYizp6zeDcnN4xldTD6dihcGNwA==
Message-ID: <dc37c03d-b604-404d-af90-18d617c96f37@bootlin.com>
Date: Tue, 29 Sep 2026 16:42:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 01/11] net: dsa: microchip: fully save the
 periodic output request
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260925-ksz-perout-v4-1-d675bd21ce49@bootlin.com>
 <179068487632.434549.12891294812675724957@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <179068487632.434549.12891294812675724957@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

On 9/29/26 2:27 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch keeps one saved request (ptp_data->perout_request) and
>    one device-wide tou_mode, but the driver allows several trigger output…
> - [Medium] This patch fixes a user-visible bug that already exists on the
>    switches supported today (KSZ9477 family), but the commit message does…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is serious.
> - [Medium] This problem wasn't introduced by this patch, but the restart
>    path calls ptp_find_pin() without holding ptp_clock::pincfg_mux, which…
> - [Low] ksz_ptp_enable_perout() selects the TOU and resets it with
>    ksz_ptp_tou_reset(), which clears TRIG_ENABLE, before validation,…
> 
> --
> 
> net: dsa: microchip: fully save the periodic output request
> 
> This commit replaces the saved start time and period in struct
> ksz_ptp_data with a full copy of the last successful struct
> ptp_perout_request. After settime/adjtime, ksz_ptp_restart_perout() now
> reuses that saved request, including its index and flags, instead of
> forcing both to zero.
> 
>> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
>> index 39cc70d65900b..47cf397481d5e 100644
>> --- a/drivers/net/dsa/microchip/ksz_ptp.c
>> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> 
> [ ... ]
> 
>> @@ -263,6 +261,8 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
>>   	if (ret)
>>   		return ret;
>>   
>> +	memcpy(&ptp_data->perout_request, request,
>> +	       sizeof(struct ptp_perout_request));
>>   	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;
>>   
>>   	return 0;
> 
> [Severity: High]
> struct ksz_ptp_data has only one perout_request and one tou_mode. What
> happens when more than one periodic output is active?
> 

Indeed, this patch series supports only one periodic output at a time, 
as is already the case for the others switches (which also have several 
output pins). This is sufficient for my use case, and it doesn't prevent 
more advanced support from being added later.
[...]

> 
> [Severity: Low]
> This isn't a bug introduced by this patch,

[...]
> 
> [Severity: High]
> This isn't a bug introduced by this patch,

[...]
> 
> [Severity: Medium]
> The commit message says:
> 
>    I don't know if other switches use non-zero indexes but the KSZ8463 has
>    twelve periodic outputs, so this index has to also be saved from now on.
> 
> Doesn't the removed request.index = 0 already break restart on the
> KSZ9477-family switches supported today? ksz_ptp_clock_register()
> advertises:
> 
> 	ptp_data->caps.n_per_out	= 3;
> 
> ptp_perout_request() in drivers/ptp/ptp_chardev.c only rejects
> perout->index >= n_per_out, so indexes 1 and 2 reach
> ksz_ptp_enable_perout().
> 
> With the old code, a clock step through ksz_ptp_settime() or
> ksz_ptp_adjtime() while channel 1 or 2 is running goes one of two ways:
> 
> - If no pin is assigned to PEROUT channel 0, ptp_find_pin() fails and
>    ksz_ptp_enable_perout() returns -EINVAL. settime/adjtime then returns
>    an error and the real channel is never re-armed.
> 
> - If a pin is assigned to channel 0, TOU0 is re-armed on that pin with
>    the other channel's period.
> 
> Could the commit message describe this? Should it also carry a Fixes: tag
> for 1f12ae5b67608f ("net: dsa: microchip: ptp: add periodic output
> signal") so it can be considered for stable?
>

I had sent a fix for this but we agreed to handle this directly in 
net-next (cf 
https://lore.kernel.org/all/ee69ae01-97ab-470c-ba1d-658f1700463c@bootlin.com/)

>>   
>>   	return ksz_ptp_enable_perout(dev, &request, 1);
> 
> [Severity: Medium]
> This is a pre-existing issue,

[...]


Best regards,
Bastien
