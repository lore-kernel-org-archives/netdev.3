Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295308;
	b=BqebEEBwQrweukZG2ufBQLYr7jm31hpuhqKF7ZvYoLeRoMoX8kDmcu44AZ8g7udK9Ecr
	 e+cm1RoagaO0ff/JLxdY3E4XoejaY86mxG+UkhFemaIioV7QAtBEVrNb4GG5OStdgBOZ5
	 QW/9g3xpGYfXqAIzW7VfqoKPmbCsh1x1/HITjkVnR6acfqdYYbsGptFWPUjfYUGWcYlkK
	 6b9yTSlIyZyTj4VSmiwUl+NA9BRB+INENIAIY9r3pEogeC5V34h266CeV/a2hima6hkDB
	 K89r2IpyJp1S6nm04juIgYdBYoB/dTcSo1ahiV/flhIKZkPcMIUpR2swl+0DI5aeaIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RmBXCpAEN/ZLhIS3rfNAZDYz2sNDq9Q0TKTm0QMgBPk=;
	b=hrXzi3YGw1oSGd+Q6ZEwwAnDYKHT/cv9ZzIIv3uZht5tX/HZ4kgqM8TPTA3OlLx/NbQf
	 FIdYjWi+6MGotbvKdVHQEI4C3jgmeGlmDsQHIbKE1UebYlfnSFq6srqu+NHkTuyfHb/rJ
	 4fdUqmvwlex+Ofrp+iN+IlotqbDxap4fSy90h89W9gKm5sQZRezFfSc+l105R20N+Q03N
	 TdjkbJG9Pp1fxOHHL93XREw+k2mXzWX0zCblkDunqlqcLxa/QBLlkPRm4yLsvHSzhtKee
	 gq2bu1fJpxM+yqniK4mNDxLslpMFHezB9NvVyVIJVVIIL/7NYlhuTqA1mXYtmj9fmTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inOVOqcy;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE1606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CE1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inOVOqcy
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso682159a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295307; x=1793900107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmBXCpAEN/ZLhIS3rfNAZDYz2sNDq9Q0TKTm0QMgBPk=;
        b=inOVOqcybKyMjPOYFE6gu6IVOtsK5uwJhr8yfYKJIf+y8YnaotatogG2LbhV9p1p5R
         Ev4xIGBwfdw7VKUqYY6tU6QLxHsEz0FMPI4Z8xCzMAf2zDNzfB0eSGd3JmqL/G7uF1Qu
         VxdkXD3NjLolO4RM3KqFVVv4B2qRZUWAaMVrmfgIon+fmVgjHFUv7RAfySXBXsStS+1Q
         i8DSt+JFXu/m2LpB/QUhqfPIRNhxTGZ7M4epRwaf09x98fEuY8XjVXeR0Watnv1x2fc+
         FHaq4TTnuJoItB6yPXCfH42SiWK+ExwT1ZI4Yia9HGhJ7+KhyU98Mlapu7cRXth0NSQg
         zKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295307; x=1793900107;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmBXCpAEN/ZLhIS3rfNAZDYz2sNDq9Q0TKTm0QMgBPk=;
        b=E3tqR0cU6qo/Lm2IuB8nAMvB40RFQ1V5dFXbvYPYTlhsDLZUp6iYdhTnuXZQDuztGj
         zxDexCTi3ACkLdFqH85pmRQYHw3i2zxmYqlGggqyhXQXL4SXLcrJGb4BZKmtMxQwAopd
         A8OOVdQtMTFxaO60HXOOavbcOSuptJJuMXZ75wPE3R04YYx6lcFT/1ZP6HP2TpELtB2F
         h+tc48dsdIdSK+WdFMzvIHGxtUU0lwk7qGoF11V+PvI0YXdpu3eAZQ5UVljDH6Juvdmx
         FbxifbBqxIuRb70u2XHoSg/CDefZS4ddwCi9XyOkvEQPanPhVtDhzgrfUGbEBnTFrUYb
         y9Kg==
X-Gm-Message-State: AFq9FYJbeq4z53d1yJlVT9nh6qj/Pb8Odug/QiUKDBEt3lQGy1L+AI+c
	fWHKTYpqBeQfEuKzvvo9YVj9xynduKC/1/TZKY0z9UicR76n0tRBhhLJ
X-Gm-Gg: AYBFou3HdoRgyMzdT5CI12Y224Kd+whJbBmLTT5Y9cdxLpxfhq2Lk3IQib/OQ7wdOGK
	bHiQ3yIT6dRV75/RM8bPN9iDlgidlRcT8TIBeuCG8R/fJJQurIIpP1G4JtWU8H+bb43dW73kfrq
	K6E28Au3sYBNxsHm+rWTCTpn+FWP8W0fsTx+2gxv+8SWqYfugVrtt6I1gFe0k1QOA6Es2XmS0xS
	tyFMxmYjW6uRa2UseezimG/v6Ah65z/+OiQxIdABzUmdOlneXw2rVn5qNnF7ZcuCzfOhEJ1YckL
	HHKPg5TpZNrZ+omRdXgvli9pTJqFQCiWI0N9M9VMlgcwgrBj+6aOf5dDCElycD6D5eOxmVkNxxc
	NnNRZ03muEsTUTaoR81tokSSKhNpgN43EnDYeH+Frbx2gaWitSEySmoKRoCxVC6PtK/vd+gpkWA
	CUtFq/nAuBVrxFy4mHgXfQrr2r68W0eCtLjOACCvXokY4nPHA4n/gkmbPzS84VzjWHSCGiBUyTz
	c1wLPiPNtDpNGdoM0e6v8NdzNmqVs4aEngPaGWWhxnMwybScT8la2hL2qzVOljw3381UqlQ/vay
	bgxfspuK5WHV+znebVhVwHXfv2UdRnVU+bHGeDDBNpHPniMOfONbicM3
X-Received: by 2002:a17:90b:3ec8:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3ae6ed47185mr2035559a91.24.1793295307219;
        Thu, 29 Oct 2026 10:35:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e973ac6sm5327703a91.11.2026.10.29.10.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:35:05 -0700 (PDT)
Message-ID: <3dfe3089-dd17-48d3-9ac1-5ee26b62e256@gmail.com>
Date: Thu, 29 Oct 2026 10:35:02 -0700
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
Subject: Re: [PATCH net 07/11] net: au1000: fix buffer descriptor free list
 insertion
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, shaojijie@huawei.com,
 horms@kernel.org, runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org,
 jeff@garzik.org, danny.kukawka@bisect.de, mugunthanvnm@ti.com,
 sebastian.hesselbarth@gmail.com, linux-kernel@vger.kernel.org,
 manuel.lauss@gmail.com
References: <20261027223140.3774570-8-f.fainelli@gmail.com>
 <179329051744.3134.5754193683869445346@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179329051744.3134.5754193683869445346@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/26 09:15, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit message and Fixes: tag present this as a functional
>    bug fix, but the bug never affects runtime behaviour.
> 
> --
> 
> net: au1000: fix buffer descriptor free list insertion
> 
> The patch changes au1000_ReleaseDB() so the returned descriptor is pushed
> onto the head of aup->pDBfree with its pnext pointing at the old head.
> This matches au1000_GetFreeDB() and the list setup loop in au1000_probe().
> It is tagged as fixing the initial git import.
> 
>> ReleaseDB links the old head to the returned descriptor and makes the
>> returned descriptor the new head without updating its stale next
>> pointer. This loses free descriptors and can create cycles. Link the
>> returned descriptor to the old head instead, matching GetFreeDB and the
>> list initialization.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
>> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
>> index c0e38a507f892..f8976e324f0e7 100644
>> --- a/drivers/net/ethernet/amd/au1000_eth.c
>> +++ b/drivers/net/ethernet/amd/au1000_eth.c
>> @@ -583,9 +583,7 @@ static struct db_dest *au1000_GetFreeDB(struct au1000_private *aup)
>>
>>   static void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>>   {
>> -	struct db_dest *pDBfree = aup->pDBfree;
>> -	if (pDBfree)
>> -		pDBfree->pnext = pDB;
>> +	pDB->pnext = aup->pDBfree;
>>   	aup->pDBfree = pDB;
>>   }
> 
> [Severity: Low]
> The new linking looks correct. Can the old behaviour actually be seen at
> runtime, though?
> 
> au1000_GetFreeDB() is only called during the first ring fill in
> au1000_probe(), before any au1000_ReleaseDB() call can happen.
> 
> au1000_ReleaseDB() is only called from two teardown paths. In both, the
> next steps free the descriptor buffers and the au1000_private that holds
> pDBfree and db[]. The first is the au1000_probe() error path:
> 
> au1000_probe() {
>      ...
> 	for (i = 0; i < NUM_RX_DMA; i++) {
> 		if (aup->rx_db_inuse[i])
> 			au1000_ReleaseDB(aup, aup->rx_db_inuse[i]);
> 	}
> 	for (i = 0; i < NUM_TX_DMA; i++) {
> 		if (aup->tx_db_inuse[i])
> 			au1000_ReleaseDB(aup, aup->tx_db_inuse[i]);
> 	}
>      ...
> 	dma_free_coherent(&pdev->dev, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
> 			  aup->vaddr, aup->dma_addr);
> err_vaddr:
> 	free_netdev(dev);
>      ...
> }
> 
> The second is au1000_remove(), which runs the same release loops and then
> calls dma_free_coherent() and free_netdev(dev).
> 
> So nothing ever walks or pops the list that the old code corrupted. The
> lost descriptors and cycles in the commit message would not cause a leak,
> a hang or a wrong DMA buffer.
> 
> Could the commit message say that there is no runtime impact, and could
> the Fixes: tag be dropped so this does not go to stable and the net tree as
> a functional fix? Another option is to remove the au1000_ReleaseDB() calls
> from the teardown paths, since they have no effect.
> 

Agreed. The free list is never consumed after au1000_ReleaseDB() runs, 
so the incorrect linking has no runtime impact. I’ll drop this patch 
from the fixes series and leave removal of the redundant teardown 
bookkeeping for separate cleanup.

pw-bot: cr
-- 
Florian
