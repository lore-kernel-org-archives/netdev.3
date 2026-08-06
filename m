Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F623E33D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004024; cv=none; b=VjeJyga31exYJpVM1ecUS1sSXxJaxJnfNT+HXe1exkIf/L/9bmVEsyLn3QtGMgpOYFR+f6HuwTrynjux2DjJChAIINbs4SK/7bw5my0k4BINO9UC5Ks3cgTVzd2vfUDfWtI5eu5IDr8UuNiGHYE4+FIsh0S4IH6k6Opc8/k3Q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004024; c=relaxed/simple;
	bh=bm65wC0PLoIo1iyqUaJeVzTC/N9DniXFI6OfLOEIWI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUr5fDBEcVIuENLrfvfglhMmjgHE5F1PksELGarfHNn3AwwPnpjC7Hh82hiUuRydQOlkAcgZkK6YCeMc80o5Wcpx9pQVAbMVQbaxyFQbE/7RjgmQkid7fjnqttF6zDcIUcLFq4CHOKUhelnWgPLhrpv8WfnaKBp1PhSrzhTtnuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GQljd1hm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GQljd1hm"
Message-ID: <8358b477-5dad-40cf-949b-bac905253be6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786004020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j38I8UgjX5qPi/tuT2GRVw0qDuX6UzxPBBfuOYDWeYQ=;
	b=GQljd1hm0TFzGwrvsIBXRzAzaF//J7d0EnhjMWYtpzI08Lph7chdhKtdChXl8Gts59mFdl
	8trB2Q07h7fTARhomN8WFqss69BdGexDbVD2Ksawr56qhMPALLXYN+jEYxFICyomXtZxjs
	0z85DHUAAs4GJOQ0XD9PUB4ZHpNLkhE=
Date: Thu, 6 Aug 2026 16:13:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: mvneta_bm: fix gen_pool_free address for BPPI
To: Andrew Lunn <andrew@lunn.ch>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260805061438.955717-1-chenguang.zhao@linux.dev>
 <8a46fda8-79a7-44c6-b4ef-2ca66c4dc3c0@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <8a46fda8-79a7-44c6-b4ef-2ca66c4dc3c0@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/8/5 21:12, Andrew Lunn 写道:
> On Wed, Aug 05, 2026 at 02:14:38PM +0800, Chenguang Zhao wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> gen_pool_free() expects the virtual address returned by
>> gen_pool_dma_alloc(), not the physical address. Passing phys can miss
>> the chunk and trigger BUG() on remove or probe rollback.
>>
>> Fixes: dc35a10f68d3 ("net: mvneta: bm: add support for hardware buffer management")
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> ---
>>  drivers/net/ethernet/marvell/mvneta_bm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
>> index 6bb380494919..2a114a69a0ab 100644
>> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
>> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c
>> @@ -389,7 +389,7 @@ static int mvneta_bm_get_sram(struct device_node *dn,
>>  
>>  static void mvneta_bm_put_sram(struct mvneta_bm *priv)
>>  {
>> -	gen_pool_free(priv->bppi_pool, priv->bppi_phys_addr,
>> +	gen_pool_free(priv->bppi_pool, (unsigned long)priv->bppi_virt_addr,
> The cast is ugly, but it also seems correct. However, can the API be
> improved. If the intention is
>
> gen_pool_free(priv->bppi_pool,
>               gen_pool_dma_alloc(priv->bppi_pool,
>                                  MVNETA_BM_BPPI_SIZE,
>                                  &priv->bppi_phys_addr),
>               MVNETA_BM_BPPI_SIZE);
>
> maybe gen_pool_free() should be changed to take a void *?
>
>       Andrew
Thanks for the suggestion.

The cast is indeed a bit ugly, but several other drivers free memory from
gen_pool_dma_alloc() in the same way today. Changing gen_pool_free()
itself to take a void * would touch quite a few call sites, including
ones that use genalloc for non-pointer cookies, so that may be a larger
change than we want for this fix.

If we do want to improve the API, perhaps a small helper would be enough,
for example:

static inline void gen_pool_dma_free(struct gen_pool *pool, void *vaddr,
                    size_t size)
{
    gen_pool_free(pool, (unsigned long)vaddr, size);
}

Does that sound reasonable to you? I'm happy to keep this bugfix as-is

for now, or follow up with such a helper if preferred.

Chenguang

