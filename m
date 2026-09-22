Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D545C6E1;
	Tue, 22 Sep 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068670; cv=none; b=StuCrmXzW9OycvMKuKnmPMmcjgIPRu918n85Vh583+n2njiUzE8QiSDr/eVmKSBJxSJkHu+0cOmv6FJhYD8+FLCSwu2PMQIKLN7XW7SJ+3r3t5OegWgK2BgwbMPOHV2HJwV9nc73E7sE2ERHtMC21Tfl5EVxhpwLaUHxKOU3qFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068670; c=relaxed/simple;
	bh=H87Lb3XTMZZWB+Vhsj+gWSLAorO4qD6yFRN0vdGl6ZA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=exTIhhkFJlKJBhHpAxgRTdc8lSG8dCJwWYQSkZ2p9hCoo0s/UGXlCh1mnw8sUgiJsjPdp2B+bCHVg/9SR8s/mDAvuHLDVzcMS/RVkGkySn9AvyJ93oULMNFJEZeOYgRA1xOnXvjZCX2S5sFobL+e3Sejs4F4Mq/wQcHFjsi8MFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=0V8zPwT7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="0V8zPwT7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01C2EA02D4;
	Tue, 22 Sep 2026 11:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790068664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mEMUGsXWMu6me45Tt9gXUyFdAtqIBQMDg1NztzEGnKw=;
	b=0V8zPwT7YjufRFyXEz8X0EzQw3LSggG4VHK0JAeWZWC2i9CQw4Uzcg6T+TB+IRyZKaaspN
	8LoVXzLQW57ltIJ8AUlsk5wnd4u0eGpStbgTVus14F4NV34xpGOfKHTuP7Z2yby4i2KZvS
	ip3Xoxk6S4f+p1NltelsOQu5/XXbfFP2JKbRC3kaeYjULfrG7uTW1ZCpkmH9cnS9M8nWKJ
	X1DlLbN5WGbvEJaFyjL99jCRtWfA5zRdQKDj7r12kOo3QvXY1JdpEyUXKY5F7zKsnThJWD
	YSM/NH9l5iothO501ohJVh/+MpRA20A4dG9KojjhG3Mx6TPlSATeRVDTSNTuXg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 11:17:42 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 08/12] net: systemport: Fix out-of-bounds array
 accesses in DSA queue mapping
In-Reply-To: <20260921231305.394773-9-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-9-florian.fainelli@broadcom.com>
Message-ID: <298e25518323e05b6daf9e12d7302ae8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 22.9.2026 01:13, Florian Fainelli wrote:
> The priv->ring_map array has a fixed size of (DSA_MAX_PORTS * 8). In
> bcm_sysport_select_queue(), bcm_sysport_map_queues(), and
> bcm_sysport_unmap_queues(), indices calculated as
> (qp + port * num_tx_queues) were accessed without checking against
> ARRAY_SIZE(priv->ring_map). If unusual port or queue configurations are
> encountered, this could lead to out-of-bounds array accesses.
> 
> Additionally, on SYSTEMPORT Lite, netif_set_real_num_tx_queues() was
> called with slave_dev->num_tx_queues / 2, which could evaluate to 0 if
> slave_dev->num_tx_queues is 1, causing netif_set_real_num_tx_queues() 
> to
> fail with -EINVAL.
> 
> Fix these by clamping the real number of queues to at least 1 and 
> adding
> bounds checks on priv->ring_map.
> 
> Fixes: d156576362c0 ("net: systemport: Establish lower/upper queue 
> mapping")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 95cead1df160..130545cce045 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c

> [...]

> @@ -2352,7 +2356,8 @@ static int bcm_sysport_map_queues(struct 
> net_device *dev,
>  		ring->switch_queue = qp;
>  		ring->switch_port = port;
>  		ring->inspect = true;
> -		priv->ring_map[qp + port * num_tx_queues] = ring;
> +		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
> +			priv->ring_map[qp + port * num_tx_queues] = ring;

Out of range rings would still have inspect = true but no ring_map
entry, so select_queue() can never pick them.

Bail out before marking the ring?

> [...]

Thanks,
Nicolai
