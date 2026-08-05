Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB73E7BCA;
	Wed,  5 Aug 2026 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917472; cv=none; b=UxCREktt9rVISQxyKyFoYPULRQWc1aJoHRTqzfMCQPooiiEOdB3xARZYsVVvrBTFZhHQrfTfiizguJfj4NS/l53ujsGdKJCBRPEQHrCCl7oKI1/rDtbg2pUnGtaW/7lvnp555xJuSc9aXCA+tZCfkArKCfTuj/BRjHAXn/zeaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917472; c=relaxed/simple;
	bh=rrU1s+zDghOhH665uk7eL35sdrgzsPOig61V8C7Lpbo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gTbV5niI87mol2nDjJmNSmkg03biqbmIkCiPeAYWkuy9V7RCZEAg15pp9ZpKjq5TzKYtCleRbWvwX4xymUMA5f7/cNX1qWpNEbOQar4q9LWnPBMQxB/eGvDrQdbsExj2lsH1OYqzDcQCc9Y2Hf3rppXZehMc22/Ja2WsIzs/2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0CXzBpZD; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0CXzBpZD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qEqX55MaqESVFehSeAtRnVelt/Z1706Sl8W1BhUZkCw=;
	b=0CXzBpZDxvRPu6EjWYd/K3nEglzrVlWI7NR6286EgJMPyyY1TpLa511tQ364DzVn0mHUBp9WI
	PZtxRpqqfly2HAJrhc/uIwQcs2jFvp/gn1YuoTjyxlQQzUmAIgQ1KKuNTE0j+udQn+PXSJKIaM+
	cyqiXNXE6gvn7B90xNUHRlE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hFNCP73KDzpT0b;
	Wed,  5 Aug 2026 16:01:21 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 931D64058C;
	Wed,  5 Aug 2026 16:10:51 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 16:10:50 +0800
Message-ID: <aee6650c-4117-4bf4-9f4d-b14ab5f5c15a@huawei.com>
Date: Wed, 5 Aug 2026 16:10:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20260731111507.2355601-1-shaojijie@huawei.com>
 <CAHS8izPpwz=swSXJZhnVFvTeu43WBhtRv7PmC_OQ0XzG8no8bQ@mail.gmail.com>
 <20260804191628.762ec7eb@kernel.org>
 <CAHS8izMVqidVkiVHNWZMqP4Eoi5N_M3Wv1Cnn4jjxHf3=cWNQA@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAHS8izMVqidVkiVHNWZMqP4Eoi5N_M3Wv1Cnn4jjxHf3=cWNQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/8/5 11:50, Mina Almasry wrote:
> On Tue, Aug 4, 2026 at 7:16 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Fri, 31 Jul 2026 10:37:58 -0700 Mina Almasry wrote:
>>>> +       __page_pool_unmap_netmem_dma(pool, netmem);
>>>>          page_pool_set_dma_addr_netmem(netmem, 0);
>>>> +       if (likely(PP_DMA_INDEX_BITS))
>>>> +               netmem_set_dma_index(netmem, 0);
>>> I now notice that maybe another cleanup we could have done is open
>>> code __page_pool_unmap_netmem_dma() in this function to cut down 1
>>> helper, and just have the scrub function call
>>> __page_pool_release_netmem_dma() to reduce some code. But this is more
>>> than fine too I think, especially since this is a fix the stable trees
>>> are going to want I guess.
>> Not sure this is a good idea? scrub is trying to touch just the DMA
>> mapping, right? It shouldn't try to update the page itself because
>> it has no reference to the page, the page may get freed in parallel.
>> Hopefully DMA unmap on a freed page is legal..
> Scrub actually frees the page in the loop in
> page_pool_empty_ring(pool), so it's not true AFAIU that it 'shouldn't
> try to update the page'.
>
> My mental model (roughly) is that the pp has a ref and that single
> last ref can be dropped in the page_pool_destroy() path or the
> page_pool_put_netmem() path, but the ref can't be dropped twice and
> the same goes for dma unmapping.
>
> Now that i look closer at the code I have no idea why we didn't 'just'
> put the dma-unmapping inside of page_pool_return_netmem(). That code
> path is already common between scrub() and put_netmem() and does the
> synchronization between these 2 paths.
>
> When I have time I'll take a look to see if an LLM can find a better
> way to do this.

Hi Mina,

Thanks for the Reviewed-by.

I'll send v5 shortly addressing Jakub's requests. The deeper
restructure you're musing about seems orthogonal to this fix,
so let's discuss it separately.

Thanks,
Jijie Shao


