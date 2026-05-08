Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BB36C9EE
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232522; cv=none; b=HuIs4lVnWmHshJOtCVBTT/uOD/u4ixm6GEDvqH/Rgu/7tMkUTMX/IH0HwoaYqRpsflgg3s/roQY7qI1B9LtFAPS4DIMDog3P3FvoYXqWWY3wGl63RFehVI8gkyeTPj9rnVcvIvW4t4Eh+aEYTCO1M+3RxIoppZ6usZPlO2nJTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232522; c=relaxed/simple;
	bh=a/7MP5KgFHbcO1EOLTaNUbNZhO9UjZJbmPG24V98Ts0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFrX2V1AeOnyOW0Yhr5o6LfOf0KGu9yVT1N4rKs2omDHXhK9BdbXP09JUa4L9X+O6dj9I3F4jQXM0q6FCAmfcuEb0O4lLsGUytyE6dd3itHRjgTM8idjRNybMgK72mEitCDFHm/WGB1CyE7jMw8a6Sttig8Ya76+i4FmE5IidI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=syba9Nwx; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="syba9Nwx"
Message-ID: <33d3f804-2877-490e-b59f-5464e51bbf74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778232508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYZcQhqYYzE659oIBhM3F6WkTOSlrt+goCsH4UGC31I=;
	b=syba9NwxIH6kg/aJEm6IgB5V+6hCCchQOcFO/Nt0wV2iRFYqTxBanApdRpKLF0WFFUs3TH
	+2k8zTpRQnAgWSdsbgaPeD3BNG6fs0QkCTrI5yg22GtVwoBuF8cuXZhkPyrp5juER9Be9z
	L+/xKGqaDNd5Mf3qz5NgQXVRSKvoR8k=
Date: Fri, 8 May 2026 10:28:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ena: PHC: Fix potential use-after-free in
 get_timestamp
To: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 David Woodhouse <dwmw@amazon.com>, Yonatan Sarna <ysarna@amazon.com>,
 Zorik Machulsky <zorik@amazon.com>, Alexander Matushevsky
 <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>,
 Matt Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>,
 Nafea Bshara <nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>,
 Netanel Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
 Benjamin Herrenschmidt <benh@amazon.com>, Noam Dagan <ndagan@amazon.com>,
 David Arinzon <darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>,
 Ofir Tabachnik <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 stable@vger.kernel.org
References: <20260508062126.7273-1-akiyano@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260508062126.7273-1-akiyano@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2026 07:21, Arthur Kiyanovski wrote:
> Move the phc->active check and resp pointer assignment to after
> acquiring the spinlock. Previously, phc->active was checked without
> holding the lock, and resp was cached from ena_dev->phc.virt_addr
> before the lock was acquired.
> 
> If ena_com_phc_destroy() runs between the lockless active check and
> the lock acquisition, it sets active=false, releases the lock, frees
> the DMA memory, and sets virt_addr=NULL. The get_timestamp path would
> then read a NULL virt_addr and dereference it.
> 
> With both the active check and the pointer read under the lock,
> destroy cannot free the memory while get_timestamp is using it.
> 
> Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_com.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index e67b592..8c86789 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -1782,20 +1782,23 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
>   
>   int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
>   {
> -	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
>   	const ktime_t zero_system_time = ktime_set(0, 0);
>   	struct ena_com_phc_info *phc = &ena_dev->phc;
> +	volatile struct ena_admin_phc_resp *resp;
>   	ktime_t expire_time;
>   	ktime_t block_time;
>   	unsigned long flags = 0;
>   	int ret = 0;
>   
> +	spin_lock_irqsave(&phc->lock, flags);
> +
>   	if (!phc->active) {
> +		spin_unlock_irqrestore(&phc->lock, flags);
>   		netdev_err(ena_dev->net_device, "PHC feature is not active in the device\n");
>   		return -EOPNOTSUPP;
>   	}
>   
> -	spin_lock_irqsave(&phc->lock, flags);
> +	resp = ena_dev->phc.virt_addr;
>   
>   	/* Check if PHC is in blocked state */
>   	if (unlikely(ktime_compare(phc->system_time, zero_system_time))) {

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
