Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961910;
	b=nkOwxxaHuV7W+BogLTHUZjLZbYmVd1VssrK8z3i6K2QHg10Wa7WIV1h7g5ysCiPImn7R
	 pDWp2lPUI2rsRSkbfWzihl3XoimURpsbo7AKA5AUFiCtx2VrFaCazmkLbMktwZ+jXVyVZ
	 JwX3UIuynKYzo6v7QPy1yLIsPzsmlKhFL+imZ1ZpkreCOl8JluQ0En0Q+kKs5Anw1eKZV
	 xR0MLMXurrZmltp8Ogb901A/uVhXK9Bo6nr6SFEOQS7D5M+/nrNDO59svkMQAaDl60nXt
	 KppWkwx/GiTbWo6u51XVxu7YrOgqTF7LDPECY0kT/SFVzlUwtlc8R5FPnXBqP/ROBKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mK5Jdfitjwy2qBnVXmB5t+/eIsoKS4R4I1jh8e8KWtg=;
	b=wDY7ydytFh5+UOudHEUUGEr8XvnyroOEio/Cf6hPkWw073oQNgZ4EMMpmKXbHWpQzBLm
	 kkT9UvhzDBQC8C3iJyaK3mgpHJeG7U+Kqsun0LiNZDX/ALIDigFkAD/gDkNvg2aSVDQeH
	 ws4AamQCTvru3pnkHdODPY1COuPDON0t4DP4tnkeAIAGDT3d0LNdAFDWNPxGMW7Pm3SQS
	 Mw2l17PAfexaMrWGFGmMSme1STmkjEYTvyeFNX8WvMcsW0v1MSLk9kUtRsvBnMWyVZIKQ
	 89UbMs57MTVdSLNCRFbnYgSBVI9bS3j5Hynq4OHAJW4UTa3l83LLaq012OnK5rI4aHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IFP2w+V4;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459E606A32F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B459E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IFP2w+V4
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ea19bc317dso4211815ad.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793961909; x=1794566709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mK5Jdfitjwy2qBnVXmB5t+/eIsoKS4R4I1jh8e8KWtg=;
        b=IFP2w+V4jns0t4yYEy5GFCJrNcp9y71ad7pD++ZnOBHlKQctT+UyUxQcBDU8YViV9j
         X4tmcb9ziENv/Bh7ir1qwdPfx9lTPXVZuB80HluQdBaN1r6aUl/6w4yYW5XjHJ9rw39y
         ZRtowgsbzWkN9mCY6/oSPlcbeOQU0AHomUMjfv2CiGDrDjRPqoNTdI8FaYoLTYdFP2Ak
         pzJAb/tt1X8tiZPYDImwjmPM8LkuYnshYIk8EgHCP/brvCh88/KWcua0BvQfMUeVsvjE
         MtXSiqoew+qkr9lx3NZ/laHEBoEW7mzhGQXLEPzy+D2GXEERDkhEcjQxUoJilQsctZex
         rlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961909; x=1794566709;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mK5Jdfitjwy2qBnVXmB5t+/eIsoKS4R4I1jh8e8KWtg=;
        b=IsPJvBiXUhu544WB54QgphnG+gTVk629EwJPJPufIXfT85fefaYkDnbyJ2v4LkhB2v
         p9gmvdlNENXvb8Zem1dujqOmOHF4nGdiJmR0I357kpRsHlltyWcRdAQqx7NkQdE2xJVq
         CbKKMg/B3v3ZsxEKoxXA03pEr8XAd9bmbhPdZpSua5JLGJYyKdA5M2VhZfgSHlUFsSrJ
         G6S+AY7bDv7S5DlHA7nDqK9MQS8wLD+TOVQzGvmy92DXbjvqYSo+0KUACA/Vl2nHw8Dq
         SOiRu/ITbc73iqzwx40kEONZ/zmPKLYmcp4ZicoB2U3oSNTiIFOPfiIdheTAIb7O+Rd3
         jj4w==
X-Forwarded-Encrypted: i=1; AL+hErGf8MuachRdReKnn9luepfb1QYxAs6cFNEOT32fWD7PkYpboothZyH9FjTPYno7NjZC5XAjJHc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7NP3PLKhhGlbMsunqT+9jeUtclne09M5mAM7TLZPtLsrVe//j
	IUiTlV49dW9EihtXjXG6Rfw2DLyE2fVrRXnNLNIO5cCUv7P+fXIlRVSM
X-Gm-Gg: AYBFou0kYVf+HjHjBPzTStVEoBjUSQsoVcsoKrNVvBUHKsYPUVFCi7+LwZc5c/9WN1J
	yz4MBT6sLn/FHKGZKGkSgOozirEhKyXhInimuKUffT4Zj9BsdDBKQ3z3U+sJ0uuwo0/sntsbLan
	M0WWjTBnqzU+8YX3T/rK1hsUchoPfn6H3OdtuLO0MMytwLYgFz0lx25lyh8jTbIuIqHmRxzMjs0
	X72UI6nWzSTPb06opiWodS1qLZuLv1sUK7rmk/CLNJown0/6dtmUVTF532CnZu4rJySw1kU6+ek
	CmxeuMN7KvpaJVbKVkiL2+Eup8IfuzPTimuZSZWMDsIq7JnbbgZ7CBVf9Yv/iinkouSD1Z2R8Au
	IozAmOxE0EoW9hs4Tp2u4CADHTIa8REGOpnfIEiAidfCicRaoEwVug6QpZfh0GSNqt/2GAWP9J+
	7nlPL4eeNw9nGuvcraTAYOB3vYoZJDBv6bKrEzIWJJ02VxGhclG9ifD/sqtlo3EuzgVXjiZ8Rlq
	ws50fcm++fE4llPsnodow5pHm8MuDP6RHSR8JhMKRP3AGbZy8YMFC3p8x5F3Lcx7Fgm5a7RN7A1
	752V825NWYOAIQFaKGZltMoW2yfjvfhn7iwAIDaEfu5ayHFxn51XiA44sUQ=
X-Received: by 2002:a17:902:da87:b0:2ed:205e:eabc with SMTP id d9443c01a7336-2ed41bbd3d4mr26889285ad.32.1793961908564;
        Fri, 06 Nov 2026 02:45:08 -0800 (PST)
Received: from [192.168.100.182] ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d8915esm4095755ad.67.2026.11.06.02.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:45:06 -0800 (PST)
Message-ID: <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
Date: Fri, 6 Nov 2026 15:44:50 +0500
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
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Chukun Pan <amadeus@jmu.edu.cn>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Tomas Hlavacek <tmshlvck@gmail.com>, Muhammad Bilal <meatuni001@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 2:43 PM, Troy Mitchell wrote:
> On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
>> @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>>   		return 0;
>>   	}
>>   
>> +	rtnl_lock();
>>   	emac_stop(ndev);
>> +	rtnl_unlock();
>>   
>>   	clk_disable_unprepare(priv->bus_clk);
>>   	netif_device_detach(ndev);
> This can deadlock. emac_stop() -> emac_down() calls
> cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
> emac_tx_timeout_task() starts with rtnl_lock().
> 

Thanks Troy, that makes sense.

For the deadlock, I think the correct function to call is rtnl_trylock() 
inside the emac_tx_timeout_task(), which would return if the lock is 
already held and will hold the lock if it is not.

What are your thoughts on this? Does a v2 changing rtnl_lock() to 
rtnl_trylock() inside emac_tx_timeout_task() make sense?

Regards,
Ali
