Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5963348452
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150301; cv=none; b=YcSY81hdbOk3YYeTLGg3qtgLCkxZ0EUHyBy2ypCbukx8+nflIIrP2PQ98KU2QNc8gR8b5tN4qP105PpJBku5qtcGrcnjMBNFWA+0vAdcX/2lGHAlp7COhACBY6OVixauq8KgKU1mOQ9tP3tuFRiX27Ks+H8hknDb/bstn7wT5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150301; c=relaxed/simple;
	bh=SfE7ty4TkXsSlVVH9Ai/KCBLN6KBzP06jcDej2glciQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqvqBLcz76cEgj3o+MUfkQtOMiAeyKq4BcMKYx4hAmI7X1dLx/u6jH+lqpfLSUyog2y1+WOfiLWI0iT+teVoi/NtOmCQrZimA/paoP+sotWszj/TcqEAyGizv5LfiB0mWlPQtGrO8KW7Yr8QYynG8kqYEqY3m1MesURcGvunGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0TodAKX; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0TodAKX"
Message-ID: <6511ab18-250b-436a-a11c-f50e78334666@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778150297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpI1/WK04V2Kme2O38dmAV6glQ7zCtBfEYYnw24SZEM=;
	b=E0TodAKX7voo0lLIQQ5c3GOsjc9FCrxnNwkm4KY8FjJ43plUOYvfxvj2lEP8zc3CvIfN+4
	VB6FbEqBS4SvvmWX6sae+4C1w5L1p7bU0ygA9GbWnduKWwxXxJKM8I6l/dou6c3KBhLBjN
	Ww7MxcBepwt1HUUf97ssUpA0K0vV+Do=
Date: Thu, 7 May 2026 11:38:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ena: PHC: Check return code before setting
 timestamp output
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
References: <20260507003518.22554-1-akiyano@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260507003518.22554-1-akiyano@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/05/2026 01:35, Arthur Kiyanovski wrote:
> ena_phc_gettimex64() is setting the output parameter regardless
> of whether ena_com_phc_get_timestamp() succeeded or failed.
> 
> When ena_com_phc_get_timestamp() returns an error, the timestamp
> parameter may contain uninitialized stack memory (e.g., when PHC is
> disabled or in blocked state) or invalid hardware values. Passing
> these to userspace via the PTP ioctl is both a security issue
> (information leak) and a correctness bug.
> 
> Fix by checking the return code after releasing the lock and only
> setting the output timestamp on success.
> 
> Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_phc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
> index 7867e893fd15..c2a3ff1ef645 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_phc.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
> @@ -46,9 +46,12 @@ static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
>   
>   	spin_unlock_irqrestore(&phc_info->lock, flags);
>   
> +	if (rc)
> +		return rc;
> +
>   	*ts = ns_to_timespec64(timestamp_nsec);
>   
> -	return rc;
> +	return 0;
>   }

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Just an observation while reviewing - the idea of taking 2 spinlocks
while reading timestamp doesn't look great and can potentially be
CPU-expensive. Please, consider refactoring into RCU-style...
