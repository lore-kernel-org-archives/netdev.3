Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553564C33C0;
	Mon, 28 Sep 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602306; cv=none; b=q00D6aUWDMuXMtgUOYNEGvHLKzJwQJKd0dTxWRxkf7+GIiLRYQCf39T5WpLeJ0nu5ULq36Kzo6401iDFSc6qFtOCyDRwXe+j9rptkZxBqhyJesDkWXd3UyVtBtyclVAIefExFDqI86SicTz7qMRxlLKVp5OY/l2NKdihGMe4EWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602306; c=relaxed/simple;
	bh=Anp+d4iytFWmOtXv0rIR4DTLJrKXL5QPGp7XUZOBfGw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GPSHwNJLSx6fkvDz23Wjq8gXt3TJEKCo6gwvo5HpS0RB5HRD4RdyNa7wDEIJFFuFjyg8PprkOeTKLTZDLyzcc+Jx33HciEKcec8F78hN2zJinCLZy8p0+LHcVOguco988ZSFqyFl3MAiPB7er3Df3C6V1eVtAdxm50JJBor+19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=q5dLX0v5; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="q5dLX0v5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CF49A4AB3;
	Mon, 28 Sep 2026 15:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790602297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SJP6etaw9jl2gowaKw+escruuLCz6tvXBCsjd9MCEdI=;
	b=q5dLX0v5oLB5F2pq2fdieoerGlDmse0/dvqy7M0PfVpcnMvycHYy9JaIITlH6j53H6Tn+Y
	Fup5+lASq2hKch94304YIspXH0Ji7vQHVlv6LccP2hwNJrwD3+zxKA1drEz3Vp8yHg4DHy
	MtmpKOvwJtbJzrY80RCH3cAymGK7G+0d5BUHmB3uq3Pj02W27IvE6I9N0vSVhZz4WVTzlP
	IYtik7V4hDJbR/Pip6snh1CtYoZwXX1hh9M4DevmKdqgeROfioicPhv4b8iCCJT1c1nSSf
	XGR8R3SRSX/t4Lnt01byuBla9e4Mg7GPFw1nXRm0yeB7tUdgih4eK209YvnmFQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 15:31:35 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Justin Chen
 <justin.chen@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: complete Tx NAPI after one
 reclaim pass
In-Reply-To: <CANn89iK5RTtZLPAY+rJKCeUpLkCge+PFqfN-g_M184S9fyzSsg@mail.gmail.com>
References: <20260928121454.901306-1-nb@tipi-net.de>
 <CANn89iK5RTtZLPAY+rJKCeUpLkCge+PFqfN-g_M184S9fyzSsg@mail.gmail.com>
Message-ID: <d63f546d8a580cdec58d91ad06ecc26a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 28.9.2026 15:14, Eric Dumazet wrote:

> [...]

> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> As a follow-up, you can get rid of ring->lock in the TX
> fastpath altogether (it looks like a leftover from before TX reclaim
> was moved to NAPI in commit 4092e6acf5cb ("net: bcmgenet: use NAPI for
> Tx completion")).

Thanks Eric, makes sense. I'll sent a follow up along with some some 
other findings.

> bcmgenet_xmit() is already serialized by the netdev queue lock, and
> bcmgenet_tx_poll() by NAPI. To make them lockless with respect to each
> other:
> 
> 1. Drop ring->free_bds and compute available space from
>    (READ_ONCE(ring->prod_index) - READ_ONCE(ring->c_index)) & 
> DMA_C_INDEX_MASK.
> 2. Use the lockless queue stop/wake helpers from <net/pkt_sched.h>
>    (netif_txq_maybe_stop() and __netif_txq_completed_wake()).
> 3. Ensure proper memory barriers between populating tx_cb_ptr /
>    writing TDMA_PROD_INDEX in bcmgenet_xmit() and reading
>    TDMA_CONS_INDEX / freeing tx_cbs in __bcmgenet_tx_reclaim() (since
>    bcmgenet uses readl_relaxed/writel_relaxed).
> 4. Avoid sharing ring->stats64.syncp between bcmgenet_add_tsb()
>    (tx_dropped) and __bcmgenet_tx_reclaim(), and serialize
>    bcmgenet_timeout() with napi_disable() + __netif_tx_lock_bh().

The timeout path needs rework anyway. It currently resets the ring
while TDMA is still running, which it definitely shouldn't.

> [...]

Regards,
Nicolai
