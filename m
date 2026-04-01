Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2C370D45
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041597; cv=none; b=cBQMKVIvWVADtkNHs4OPYj16pkBT6WveY9k8gzlhP6civNqX65GkJ98aSy35D1MOeFuO96nZ0pPbCwNKniliilh5LVyXX6NQz0AxcxgH0qGvF2Fhj5OeLXJKsAye6E++XxhBN6b5asStK0eArSisbkmH0asBiDbDb5qRpl5Q8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041597; c=relaxed/simple;
	bh=ZMAVDkfKodmA36ywztYn3Yg2OWzYzcbZ1CIxh8pCemI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eenZ9au7/+peMW4PFosigixNq+pGcFbYusb2Dm4iMmlixljR3ecbyRVfbuT7sAtCpvi5iRjoDQ+xatfksIXQrQJXlwDUmHSw+PAhdnknZ4rpUgGdl3sTvYckQ/l50rGHeddc6dvZ1ky0vhPN5UqN8jCIxAk210I5ecj8lvnz+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4E6uhMaF; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4E6uhMaF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lTuYl9lY7WAGJRWTaYZvIR3+9UOUW7hH5fzJ2pPN5do=;
	b=4E6uhMaFfIsQvBLZgR9VQzZzlX7hZqh4r83xc8nJKggVLK9gDcT3eYV++ychOGWEz1T4RDu9G
	I5rUac/IpQV+sohcLbazREcnoBKyGl1TVWun46ytI892okyY8GKA+fKI9ScoQqBUTVT8xmW2iK+
	uL43t48N0Iv/1iKyiNVjYvU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fm28C2yhnzcZyl;
	Wed,  1 Apr 2026 19:00:27 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F4644056D;
	Wed,  1 Apr 2026 19:06:32 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 1 Apr 2026 19:06:31 +0800
Message-ID: <8667fb30-1e67-4bf0-a0f6-e03b88245e4b@huawei.com>
Date: Wed, 1 Apr 2026 19:06:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: cortina: Fix SKB leak
To: Linus Walleij <linusw@kernel.org>
CC: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
	<mirq-linux@rere.qmqm.pl>, <netdev@vger.kernel.org>, Andreas
 Haarmann-Thiemann <eitschman@nebelreich.de>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
References: <20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi,Linus

On 3/30/2026 2:00 PM, Linus Walleij wrote:
> From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
> 
> Under sustained RX load (e.g. large file transfers over the network), the
> device freezes completely and requires a hard power cycle. No kernel panic
> or oops is produced; the system simply stops responding.
> 
> In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
> gmac_get_queue_page() returns NULL for the second page of a multi-page
> fragment, the driver logs an error and continues — but does not free the
> in-progress skb that was already being assembled via napi_build_skb() /
> napi_get_frags():
> 
>     gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
>     if (!gpage) {
>         dev_err(geth->dev, "could not find mapping\n");
>         /* BUG: skb leaked here */
>         port->stats.rx_dropped++;
>        continue;
>     }
> 
> This path is distinct from the similar block in gmac_cleanup_rxq(), which
> correctly only logs "could not find page" without an skb in flight.
> 
> Each occurrence of this error path leaks one skb. Under sustained traffic
> the leak exhausts kernel memory, causing the observed lockup.
> 
> Free the in-progress skb via napi_free_frags() before continuing, matching
> the pattern already used elsewhere in the driver.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 4824232f4890..723d90d5fdf3 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1491,6 +1491,10 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
>  		if (!gpage) {
>  			dev_err(geth->dev, "could not find mapping\n");
> +			if (skb) {
> +				napi_free_frags(&port->napi);
> +				skb = NULL;

Quick question out of curiosity.

In the fix at gmac_rx(), when gmac_get_queue_page() fails for the second
page of a multi-page fragment, the SKB is freed via napi_free_frags().
However, I noticed that port->stats.rx_dropped++ is not incremented here.

Comparing with the similar code path, when a stale SKB is found at SOF_BIT,
both napi_free_frags() and rx_dropped++ are called. Would it make sense to
add the drop counter here for consistency, or is there a reason to omit it.

Thanks for your time,
Li Xiasong

> +			}
>  			continue;
>  		}
>  		page = gpage->page;
> 
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260330-gemini-ethernet-fix-604c28c53da1
> 
> Best regards,
