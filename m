Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D24DAFBD;
	Fri, 18 Sep 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729095; cv=none; b=J9xjXiFafc3I34LLU4jwPHbgnSZjO+0jj2gm33bjiJCtl8phOiEAhb/xyl3TYutJFprlxTY+ssz5/Y1yQqP+KqUiPP3s3tvQ3E85cT1QHdVbSis1WLArgyzF+tl4cnQHbsZ+9eJjYfECeFTjhohiB1jFCj52E1VT5dq8GUcVv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729095; c=relaxed/simple;
	bh=B0uBxqEaUhsKhXHsmjabxELUlEyZk4RyHLgcvfGW7+k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pBU+0j4nuaiu0mD5W1/jqAAe7qZsa/pijQKP2+aDx4g7WjwNBG/q8nsoz9u/QzxYYpJtQQT665uRHDGhXgfWlITG5ZnXSGrC+UMIwpFwMSKwX/JX2bk8tPyZ3CKOE9gV8W18ALZjvGEDPLRGwjfjnZFnc5o+ZLjBgQmqdihrcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=s2EHhi5S; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="s2EHhi5S"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5145A9002;
	Fri, 18 Sep 2026 12:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789729073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fIJFLBN3RmDaM9t5gQobFaKnJjoalt7iRSzoTab2m5g=;
	b=s2EHhi5Scz+i+R/r5c1fIMI0WKQHgBlxftx+7kKPfQyX5ILt+cMBU4Dn4xrJsH8e4fAVt7
	w0YBNGoy0dx5tlsRHTChSeLA+gL+ZowKAb+QlUtKT5X4Lq74h4oaMgiJ/NXfq34k6GXosR
	xqc3EU3O1irdIvY27gKIwG1yka91Jp4U/z+vo8F6mFZf31umilcahi3wLa1VEOlAoi/fQW
	hEuAQH8DvrglFtpCGQMMOeRqqFfl28J+A69/KTMQA3NQuDuEwgUSA6+8F4p6TR2bnfSVy8
	KAqKERSgu26WDI0Lcr9LwAUowm9mMQ+ovd8Q8KbeayV8i0lBcr7XYOj2VpQtOQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 12:57:51 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/8] net: bcmgenet: acquire ring lock with BH disabled
 in bcmgenet_dump_tx_queue
In-Reply-To: <20260918000732.276506-6-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-6-florian.fainelli@broadcom.com>
Message-ID: <f00892b2a993b3cd333f54660c53632c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 18.9.2026 02:07, Florian Fainelli wrote:
> bcmgenet_dump_tx_queue() is called from bcmgenet_timeout() in process 
> or
> timer context and acquires ring->lock using spin_lock(). If a softirq
> such as TX NAPI (bcmgenet_tx_poll()) fires on the same CPU while the 
> lock
> is held, it will deadlock trying to acquire ring->lock.

AFAIU bcmgenet_timeout() only runs from dev_watchdog(), so BH is already
disabled and no deadlock?

> 
> Use spin_lock_bh() and spin_unlock_bh() in bcmgenet_dump_tx_queue(),
> matching bcmgenet_tx_reclaim().
> 
> Fixes: 13ea657806cf ("net: bcmgenet: improve TX timeout")
> Assisted-by: LLM
> Co-authored-by: Cursor <cursoragent@cursor.com>
> Change-Id: I0c4c6392590b2d16abd44f75d3f6974f3e1b874b
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index ef155a170fa6..799da63e3a4e 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3508,14 +3508,14 @@ static void bcmgenet_dump_tx_queue(struct 
> bcmgenet_tx_ring *ring)
> 
>  	txq = netdev_get_tx_queue(priv->dev, ring->index);
> 
> -	spin_lock(&ring->lock);
> +	spin_lock_bh(&ring->lock);
>  	intsts = ~bcmgenet_intrl2_1_readl(priv, INTRL2_CPU_MASK_STATUS);
>  	intmsk = 1 << ring->index;
>  	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, 
> TDMA_CONS_INDEX);
>  	p_index = bcmgenet_tdma_ring_readl(priv, ring->index, 
> TDMA_PROD_INDEX);
>  	txq_stopped = netif_tx_queue_stopped(txq);
>  	free_bds = ring->free_bds;
> -	spin_unlock(&ring->lock);
> +	spin_unlock_bh(&ring->lock);
> 
>  	netif_err(priv, tx_err, priv->dev, "Ring %d queue %d status 
> summary\n"
>  		  "TX queue status: %s, interrupts: %s\n"

Regards,
Nicolai
