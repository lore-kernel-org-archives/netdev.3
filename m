Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080036EAA1
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635861; cv=none; b=K2RWxfT2OpmT6eRUCPpRmO8JI56aJrQxPVYZvxyuQZzVbTRs9EXFbR+ghp8yOlSXFZQnHl6R3RrqAVruhyFLal+5NmPwBzwHCe1Ac9VvoUrf9kALHFSwQRolkBbay09UT6OlC3dEOIu6ekJAhLZ0D2zlHpbxTf1QdDG0TSswpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635861; c=relaxed/simple;
	bh=7mw6hzhmMA6+zvleY6HwC0fCZS1N/GYXUSctzjVG1I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kYkoZcvnitxprYOyFOqnSpTcH5JthEbUgV5R3Zp3Y7a6Npt8LN9BKZ8CXLepMT7I+sL4WjqXiIAIh/IICyeAw4PWNAhkr/WbpEYQNLzXhfKlZduiqSyNzugfcSoCgNZ/K5xcSgjaNheKvK//9KG0x7biSa58IRbQzee/ynyKLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tlkmCccK; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tlkmCccK"
Message-ID: <24606a3d-b8b6-4e34-845f-8a76e9d13154@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770635849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6qyBvdf+nbbCyjziWKf9s6xwNWCgzO9Nlu2QRf453Y=;
	b=tlkmCccKJ90IYg3qb5c8e3E/xW3RWAPOBB10G50KEApL0J6Jtkz2N6wKLHSO1FXiHRr6p2
	BBagCTI5sQbYocva552MnBE+T7RPszQNJNGk8SWyW+W/gU5Js5UVrWbv2vtzTq/ZFNEvjh
	fvRTEaDtnWoigjLQ8ovNXnIC3PXBXzs=
Date: Mon, 9 Feb 2026 11:17:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] ppp: don't store tx skb in the fastpath
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260209021134.21194-1-dqfext@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260209021134.21194-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/02/2026 02:11, Qingfang Deng wrote:
> Currently, ppp->xmit_pending is used in ppp_send_frame() to pass a skb
> to ppp_push(), and holds the skb when a PPP channel cannot immediately
> transmit it. This state is redundant because the transmit queue
> (ppp->file.xq) can already handle the backlog. Furthermore, during
> normal operation, an skb is queued in file.xq only to be immediately
> dequeued, causing unnecessary overhead.
> 
> Refactor the transmit path to avoid stashing the skb when possible:
> - Remove ppp->xmit_pending.
> - Rename ppp_send_frame() to ppp_prepare_tx_skb(), and don't call
>    ppp_push() in it. It returns 1 if the skb is consumed
>    (dropped/handled) or 0 if it can be passed to ppp_push().
> - Update ppp_push() to accept the skb. It returns 1 if the skb is
>    consumed, or 0 if the channel is busy.
> - Optimize __ppp_xmit_process():
>    - Fastpath: If the queue is empty, attempt to send the skb directly
>      via ppp_push(). If busy, queue it.
>    - Slowpath: If the queue is not empty, or fastpath failed, process
>      the backlog in file.xq. Split dequeueing loop into a separate
>      function ppp_xmit_flush() so ppp_channel_push() uses that directly
>      instead of passing a NULL skb to __ppp_xmit_process().
> 
> This simplifies the states and reduces locking in the fastpath.

Quite insteresting optimization. Did you measure the improvements? Like
pps over PPP interface, or the length of backlog at some ppp rate?


