Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458418;
	b=DIAhR0YRdPE3ExstfKL134+SgoDpEDGPg76JNeH4Xbawke50Uo6N8J5gkdxqdE9oY+Ii
	 qkUiQlr9tTm2Tv3f2kcfZU9KxKL+HaSum5br1vArMlh5ObKL7EQxYmwmsnRGMvogDrVqC
	 Fmahi++wf+640f78I44Bc1YxP+ul8MF3anoYvM+jENFnd27uC9kYyKMhYfpQtoWEGI2gr
	 KDYVTXa3dGgc0PyKa8SGT4TGJfzygukZ7+QzkNKnHRFvcgBlQXVp4ExZNOGWPdfjtj204
	 ylQpvRcshjDT0L4LZ2t2KvEv9fR7fSW6TZoXBvAcNfV+Uoe+aCFJqDtQ8NC/TvXOasw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458418;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=a5707ZtPK1x4M0zTRO8ZywKW+TKQegCKo86almuTMp4=;
	b=h+WchI0n/mDYplXD5A/kXCo+eVXTICh+7VhPHaEIJ+820sIknIFgezhfBIzLrHbIFkte
	 I9SPsbXLhJTqr5wzvUSBuGR798alX3gsdGwJIiPRucrHTZLz2W8i6o66l1YTmpZPaq4Fd
	 3n9N5wo4AOzfZ4edxkc4uzv6D2Vu4ph9FU4sABN/aWHh08xbaZ3f6ALf7N0q8jwlaQc7x
	 oAerCebPBiVIcKM3Ojpm8PvpeJ3cKTp96dbwYVg1JarYIawgU8abJlQwLPaTRa8ZP1Y89
	 ZtPoPd3p14YV1l3bFWxPgNIODA5/cvow6v00mQoyTC4c0C6O4kekr+NqnrdlpBsv07w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HpfBlfGm;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5921606A319;
	Tue, 20 Oct 2026 01:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5921606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HpfBlfGm
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a5707ZtPK1x4M0zTRO8ZywKW+TKQegCKo86almuTMp4=;
	b=HpfBlfGm+bBlyXXZVWpRQ3WekMB83opo42jcpqmnqa3Yc6p77jd2U9O86oqxw8+gYGwJXu1Tn
	8yBLNX+wceANJSEg9eU04chros/QDSJSlvIpx906aLEIccVPtm3mIFn34ajeaKuXXlDqZweGTXs
	+g0j5AoAb+uwniitDzCHxww=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4j7vPl5f5Cz1T4GS;
	Tue, 20 Oct 2026 09:06:35 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D59B840579;
	Tue, 20 Oct 2026 09:06:41 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 20 Oct 2026 09:06:41 +0800
Message-ID: <7990b078-66fb-4960-b1f7-5a2928e2e2c8@huawei.com>
Date: Tue, 20 Oct 2026 09:06:40 +0800
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
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: hns3: fix use-after-free in debugfs read
 during reset/unload
To: Jakub Kicinski <kuba@kernel.org>
References: <20260915132434.1141742-1-shaojijie@huawei.com>
 <20260915132434.1141742-4-shaojijie@huawei.com>
 <20260919164737.57b74cd7@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260919164737.57b74cd7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/9/20 7:47, Jakub Kicinski wrote:
> On Tue, 15 Sep 2026 21:24:34 +0800 Jijie Shao wrote:
>> @@ -504,22 +524,16 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
>>   	struct hns3_enet_ring *ring;
>>   	u32 i;
>>   
>> -	if (!priv->ring) {
>> -		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
>> -		return -EFAULT;
>> -	}
>> +	guard(mutex)(&priv->ae_handle->dbg_mutex);
>> +	if (hns3_dbg_is_device_busy(priv))
>> +		return -EBUSY;
>>   
>>   	seq_puts(s, "QUEUE_ID  BD_NUM  BD_LEN  TAIL  HEAD  FBDNUM  ");
>>   	seq_puts(s, "PKTNUM     COPYBREAK  RING_EN  RX_RING_EN  BASE_ADDR\n");
> Quoting documentation:
>
>    Using device-managed and cleanup.h constructs
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
>    Netdev remains skeptical about promises of all "auto-cleanup" APIs,
>    including even ``devm_`` helpers, historically. They are not the preferred
>    style of implementation, merely an acceptable one.
>    
>    Use of ``guard()`` is discouraged within any function longer than 20 lines,
>    ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
>    still (weakly) preferred.
>    
>    Low level cleanup constructs (such as ``__free()``) can be used when building
>    APIs and helpers, especially scoped iterators. However, direct use of
>    ``__free()`` within networking core and drivers is discouraged.
>    Similar guidance applies to declaring variables mid-function.
>    
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Ok, thanks!
Jijie Shao


