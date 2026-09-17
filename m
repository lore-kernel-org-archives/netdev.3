Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD4595740
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654204; cv=none; b=kO96z3GRNZ2wPeC9aZQvro7U2mj1cYWJx7fBGe9sQ6yOiVNt8RmJHI/dGefbEuR4+Wezhm/ekkxKt22skP0QDmVo7LXZNYqq4rb5avIYWy1cqD2ON/yXHlqQ9sN2/tcKblU2KsLzO0A6iKptjb9bUyQ3ta8KWZQt/6aKOrAOUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654204; c=relaxed/simple;
	bh=j8COZdqiLv/WW2hv05JO0I6ITBYjGwAy5SbXukZzWVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzZUdMBS8dD8+Oqotvhbh044SG/LelzwVCD0vJTqEnQzvv9CSYsQSPjxbZ6rmYowwiZTJUuT/NvELa0rg+g2cjnabKGdDO6wpzrh0+UEtSrOiyR7X8h+Bi+xOyWb4CoucOgFnjs7tjXOy5Br0yz/wUh1C0hfyRm0eZSMtQPTTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rMawkcKJ; arc=none smtp.client-ip=91.218.175.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rMawkcKJ"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j8COZdqiLv/WW2hv05JO0I6ITBYjGwAy5SbXukZzWVI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789654181; v=1; x=1790258981;
 b=rMawkcKJRvODysJZDvCLFpDFbhQ4r0K8Gb1cXDcQbzTe+0EsxQyFcl50FtpJA7MbwWeMwXIU
 nxExlIJM6Ss89tIT6WUgbwmfxDu1SmS5bf/g2bhTxkwrgOVljaNd7rB4mKcvkDuhrNUA+e/ODg1
 SplUKpxBY7bAJWzv638/czec=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id afde411d107651f6;
	Thu, 17 Sep 2026 14:09:41 +0000
X-Mizu-Trace-ID: afde411d107651f6
X-Migadu-Flow: FLOW_OUT
Message-ID: <e70bcac1-7970-4d79-b210-bf31193aee3c@linux.dev>
Date: Thu, 17 Sep 2026 22:09:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: preserve timestamps across receive queue
 collapse
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 kuniyu@google.com
References: <20260917132742.87117-1-kerneljasonxing@gmail.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260917132742.87117-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/17 21:27, Jason Xing 写道:
> When tcp_collapse() rebuilds skbs under memory pressure, the copy
> process doesn't include the right tstamp and hwtstamp from the
> old skb. And memcpy(nskb->cb, skb->cb, ...) copies has_rxtstamp,
> but nskb->tstamp and hwtstamps are left at zero, so
> tcp_recv_timestamp() ends up emitting no cmsg at all.
> 
> In net timestamping case, if such an skb happens to be the last
> one consumed in a recvmsg() call, the application receives no RX
> timestamp for that call.
> 
> Fix this by copying both tstamp and hwtstamp to the new skb right
> after the initialization.
> 
> Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP recvmsg")
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang
