Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560761;
	b=QKGtTRBBJoM81eKBuKTxWufFtuSc3zIO9iNcIZQU5zesqUekkTiiV0ztmJAKpEkuFaWN
	 4TNvxWH7n8Ndn3gb7EWa+WvLi/R/2RIVdWIMdh0vLxzsUbrREqaELN2s8t4homCAmHeuw
	 EVFzZGi0R8sNCu4KGxNNxvJ9yqNj98++EfmFTPv7UUCTyEDUcvpMDyHkrqAbdU0CJfDe5
	 o4E3DA1tb9uNFKJ+zvdCsIcd5jaxm52drb2EE97YzIVv3UxqJxwjFD5x1VsAexlWOhcEP
	 i+RjOg0dY7zNWx7hkD16ooaMKoAMzG+LbAD6y/LME9AUiKWNJRCas3lG5GugPwa2W/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560761;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=m9B2HLqDdiE/y5FWXTFo38VfZGVo4F39dSrwK05GBbY=;
	b=JM5C16ng0BIyEQ5BFVmcN2KAahrFB88CneWhXqSzYDMjSwEU9H4Zz8oZxA5ZrUPEwOzT
	 dZjXW5nKD4oYQ0VWRGIfknUJEnn65T8pIToihcgfzmrCyiVTT3ajJpQhLToYReMueEuIo
	 a+YPTwxHsP1OoxVMyuHzfn+d8/3CEpSZRt3Pbco5pRE0H6GCXkyrJ0bPA8vXO4uuRx0SC
	 5RYvKUuQWdL6VTIcoGulWBx9E4AgAkJ0i78wylo40ROSVFzlOPWjubFzDyiR2v4thdcTd
	 EDsKj2kWC5dwKpOq94HZgDhf/n4jPVmSc+2fNIH7EINKnzABY798RZ+R6cZ1NhbKp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=f0vffpVZ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936C606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1936C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=f0vffpVZ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 14E5E1A164C;
	Fri, 13 Nov 2026 09:05:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D57B7601D5;
	Fri, 13 Nov 2026 09:05:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1469611BC04C2;
	Fri, 13 Nov 2026 10:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794560752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=m9B2HLqDdiE/y5FWXTFo38VfZGVo4F39dSrwK05GBbY=;
	b=f0vffpVZZrslinjhbIpY9qf8M3/CTvC1z9yRuJJogyIu+IMIeQXQfStNZCfvTBfaholj0T
	XaUi5RncKXMF7GgfOhQVDBRYLBVRFb5xKn4JFbmA7GBQjCWX675/Mp4q0uAlmhPbkYexMp
	9BVS2T1GmGDfln9dDKXTOClFTBVMsv+n0CadBkAkLrnTz494mmEpVvD8eiqM0gdGSByExO
	bEJoOGwXZBlIhKafG9ATQYOfWbZvmV28m3FFXd0ZU1yGK8PgofIRLbNVkIbZrZwQAxmfD6
	4SgqesLYSHv0C1TIzkodXek6GjHCpZ0gw2QZYIxh9kwnrThjZzgVWgWre5XuhQ==
Message-ID: <03612a8a-0899-47e9-b992-d166bc7fd63a@bootlin.com>
Date: Fri, 13 Nov 2026 10:05:43 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: re-base EST after PTP settime64
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
 <ea9ae0f9-d373-4e97-b96b-3855c01100ee@bootlin.com>
 <avbOwepxkFf1F717@lore-desk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <avbOwepxkFf1F717@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/13/26 09:48, Lorenzo Bianconi wrote:
> On Nov 12, Maxime Chevallier wrote:
>> Hi Lorenzo,
>>
>> On 11/11/26 10:54, Lorenzo Bianconi wrote:
>>> stmmac_set_time() initializes the PTP clock through
>>> stmmac_init_systime() (TSINIT) while holding only ptp_lock.  It neither
>>> takes est_lock nor disables and re-bases EST around the step, unlike
>>> stmmac_adjust_time(), which performs TSUPDT through
>>> stmmac_adjust_systime() under est_lock.
>>>
>>> Both operations change the PHC system time, so both invalidate the
>>> absolute EST base time.  With settime64, a concurrent
>>> tc_taprio_configure() can read the pre-step clock through gettimex64()
>>> and program EST with a base time that is already stale once TSINIT
>>> lands.  Separately, a taprio offload installed before the clock_settime()
>>> is never re-based and keeps running with its old base time until taprio
>>> is reconfigured.
>>>
>>> Take est_lock for the whole disable/step/reprogram sequence, as
>>> stmmac_adjust_time() does: disable EST before initializing the clock and
>>> call __stmmac_setup_est() afterwards so the base time is recomputed from
>>> the reserved taprio base time and the new clock.
>>>
>>> This keeps the established est_lock -> ptp_lock ordering:
>>> stmmac_init_systime() only uses readl_poll_timeout_atomic() under
>>> ptp_lock, and __stmmac_setup_est() takes ptp_lock through gettimex64().
>>>
>>> Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>>
>> This LGTM, the return values from stmmac_est_configure/__stmmac_setup_est are 
>> ignored though, the [cl|s]ashiko gang may not like that.
>>
>> Besides one of the EST commands timing out, it seems unlikely though.
> 
> I used the same approach used in stmmac_adjust_time(). I guess we can update
> both of them if required.

Bah, I'm OK doing that as a followup then,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> 
> Regards,
> Lorenzo
> 
>>
>> Maxime
>>
>>> ---
>>>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>>> index 31a66e855d6b..6370bdc6c58b 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>>> @@ -129,10 +129,19 @@ static int stmmac_set_time(struct ptp_clock_info *ptp,
>>>  	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
>>>  	unsigned long flags;
>>>  
>>> +	mutex_lock(&priv->est_lock);
>>> +	if (priv->est && priv->est->enable)
>>> +		stmmac_est_configure(priv, priv, priv->est,
>>> +				     priv->plat->clk_ptp_rate, false);
>>> +
>>>  	write_lock_irqsave(&priv->ptp_lock, flags);
>>>  	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
>>>  	write_unlock_irqrestore(&priv->ptp_lock, flags);
>>>  
>>> +	if (priv->est && priv->est->enable)
>>> +		__stmmac_setup_est(priv);
>>> +	mutex_unlock(&priv->est_lock);
>>> +
>>>  	return 0;
>>>  }
>>>  
>>>
>>> ---
>>> base-commit: 22b7cb932c6a0f7566d41072be6956cb6c8af4e1
>>> change-id: 20261111-stmmac_set_time-est_lock-f74f4ce678b7
>>>
>>> Best regards,
>>

