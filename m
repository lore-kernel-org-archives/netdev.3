Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC225484238;
	Tue, 22 Sep 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070146; cv=none; b=LtEE4m/3jP2+SYkcdI17vAmKcj8+N7Ygtg97eD2Ofn4SkmLbSBZvFfPbsyddH0QP5uu3mAQ/bg4JXqGiEoZro9w9qzS9KgrB6FZpP9GlnnyewTSV4XP4ictp0V7Hb8Bz0T378pca1z/YUpr68jspKkzTzN+B0BQ3bvPxy1dEhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070146; c=relaxed/simple;
	bh=H/NrgvNClj6wBlgawoNNMnsjThtL+9kw8aZIyG79y2E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oU2DGvDvpvqB2b8T+8T8FzkRnr6X/9nQgh1lDD8O2LEM/acT3j3KlkrfdVsorSOpcLVNhXrTSasYcEOemtwUjgW8NRzMw+gT4YcaUVOg/X6J6dJSFFdeazxTjO0kuXruM9YQw0Xp4n3A3c5QbqsEVZvCm3oNRX4gjRFIgzv8UwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=KaOq30Ph; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="KaOq30Ph"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B266A3808;
	Tue, 22 Sep 2026 11:42:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790070141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LrzjnjDphGpx2w2Ic+lkX+fgz/hAGKPf8FCBoZpWHK4=;
	b=KaOq30PhyeO9q9o4QnnPkYmtCrasMZEUgrvKas/xb/U5S9wQNoj78el5yUdzsu1TWcjjRb
	cZIEBZETtqOFLoU1wSaNpoaXWoZJB4Xo8K7CoBI80awbde+xe1P0UPx0pH1Qj6s2vAKlv5
	j4qJRr+VhC1ND8a1b1JjfVWyBihBUMjRTC7jpuoqrSsJY5zuBPn/gzKXK37P/WwOiSkrNB
	dKqYxXzNVhSNEhi18zRoAcA1FT8ihTw94A9j47WQNgXH+oKdgkWJdYHxvFJYVaeyaYtU1C
	g52V+A6M6L5BoF1mzJSPHkH11y1/FVK07qgJdxiB9EfkAw86IggGPzaGxSVHVw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 11:42:18 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 11/12] net: systemport: Update TDMA queue mapping
 dynamically on changeupper
In-Reply-To: <20260921231305.394773-12-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-12-florian.fainelli@broadcom.com>
Message-ID: <9ee2259a5c39534db83122ceb3d4b610@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 22.9.2026 01:13, Florian Fainelli wrote:
> When DSA upper devices are dynamically attached or detached while the
> master SYSTEMPORT interface is already up and running 
> (netif_running()),
> bcm_sysport_map_queues() and bcm_sysport_unmap_queues() updated the
> internal software mappings but did not update the 
> TDMA_DESC_RING_MAPPING
> hardware registers, because programming was previously deferred until
> bcm_sysport_init_tx_ring().
> 
> Update TDMA_DESC_RING_MAPPING registers immediately if netif_running()
> is true during map_queues and unmap_queues.
> 
> Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier 
> to detect DSA presence")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index dd5a7c9dd90f..e5bb7fa84fda 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c

> [...]

> @@ -2390,6 +2399,14 @@ static int bcm_sysport_unmap_queues(struct 
> net_device *dev,
>  		qp = ring->switch_queue;
>  		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
>  			priv->ring_map[qp + port * num_tx_queues] = NULL;
> +
> +		if (netif_running(dev)) {
> +			reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(q));
> +			reg &= ~(RING_QID_MASK |
> +				 RING_PORT_ID_MASK << RING_PORT_ID_SHIFT);
> +			reg |= RING_IGNORE_STATUS;
> +			tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(q));
> +		}

RING_IGNORE_STATUS is never cleared in init_tx_rings(), so

     echo <sf2-node> > /sys/bus/platform/drivers/brcm-sf2/unbind
     ip link set eth0 down
     echo <sf2-node> > /sys/bus/platform/drivers/brcm-sf2/bind
     ip link set eth0 up

keeps the bit set from unmap. Clear it in init_tx_ring() too?

> [...]

Thanks,
Nicolai
