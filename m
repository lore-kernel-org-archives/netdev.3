Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4098336885;
	Fri, 10 Apr 2026 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806198; cv=none; b=k8CG1rd00k7TFr61qdFTZeiyuJuddVJ9Wrw1RoeGhUnky20fKlwATWcwj5Zj5tyF6fdckYGnXfV16LG5K064yjl4HShzj3pTKNw8nhTZ/L/ACem2omJEt42v3jJUUq+fc0SMjfB9hBBmz4LagCVu2//zXg49c2jKtrtCz1vBUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806198; c=relaxed/simple;
	bh=i48Bci7Nfm0cvpcgSAZkHH9I0sMj47/FkxK4q4U3vok=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rluJg55vwq5RB4okUujMcZvCzwIyfWXEz3TBrhG5MmWOmfkgSmwkBSkUt09QDS5efsxOpPF9IP27WAj8VkbaeM9R8g6yhAva+pKGim7MX+yhJnTYwH0Fs6wrUKqySUz+pX5JS1vosGk1cA/vlma9zkoBr2oiFHMKwnqC8Cvk2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Hv8yHe5F; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Hv8yHe5F"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A1AFA587F;
	Fri, 10 Apr 2026 09:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775806181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YtArXjAlVNTSTOqs/mKwKdVSbYPg8yz2YgEB/frxvCE=;
	b=Hv8yHe5FEueYQJUkvHsUieInqTNNq9HgW0Eq16wzMQTAqxOHi0e53DrGsEgT6gyQ3267hi
	q1W4NrUPhAI54YaryLGePvBVo68LW+5LoDRof2OiirTzb9cvT7bRDzO4zM0Au1VvHdrKme
	5IGeXAiADeynwKmsDTr16naaqSty/f4Tn5m7bGgYPTV7S7alP5XV4iCpSEhiPOCzWOBkNz
	UJ+fntUGB6fCESlgNF8YAeFSbwlhJDh9SolSE8Xvyc7JbJvq6RPhTbKQGbIGdiKaDKsnqA
	K3iodo6QH65nJyxlAZVfWv8uh8vxwEd2D3I23QI//7hahHUo+9Hd5tHLdC3uyA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 Apr 2026 09:29:39 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui
 <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
In-Reply-To: <1665242a-2298-4e76-9618-effdb88c2ad4@nabladev.com>
References: <20260408162535.98108-1-marex@nabladev.com>
 <6391ee36b7d9c66d33c734650ebfb7fe@tipi-net.de>
 <1665242a-2298-4e76-9618-effdb88c2ad4@nabladev.com>
Message-ID: <18b34c8823dd2bcf06c2aff29404c25d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 9.4.2026 17:26, Marek Vasut wrote:
> On 4/9/26 8:52 AM, Nicolai Buchwitz wrote:
> 
> Hello Nicolai,
> 
>>> @@ -408,7 +426,9 @@ static int ks8851_net_open(struct net_device 
>>> *dev)
>>>      unsigned long flags;
>>>      int ret;
>>> 
>>> -    ret = request_threaded_irq(dev->irq, NULL, ks8851_irq,
>>> +    ret = request_threaded_irq(dev->irq, NULL,
>>> +                   ks->no_bh_in_irq_handler ?
>>> +                   ks8851_irq_nobh : ks8851_irq,
>> 
>> This works, but wouldn't it be simpler to put the BH disable
>> into the PAR lock/unlock directly?
>> 
>>    static void ks8851_lock_par(...)
>>    {
>>        local_bh_disable();
>>        spin_lock_irqsave(&ksp->lock, *flags);
>>    }
>> 
>>    static void ks8851_unlock_par(...)
>>    {
>>        spin_unlock_irqrestore(&ksp->lock, *flags);
>>        local_bh_enable();
>>    }
>> 
>> No flag, no wrapper, no conditional in request_threaded_irq.
>> And it protects all PAR lock/unlock callsites, not just the
>> IRQ handler.
> That is exactly why I wrapped the IRQ handler, because the BH should be 
> disabled ONLY around the IRQ handler, not around the other call sites.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
