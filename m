Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DE50B429;
	Tue, 22 Sep 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070479; cv=none; b=fCra2BEIW1XGe1xml+xHDxbKGYP5p/VfVcaGJP2AMWWjwiPdt46v9db0RIewC/JXP4kR4vhJiP+JShepkJbsIHg+YybiBEwfy/ZToJSmPGSupyCsep+h4f1K5sbBtHaJKJAtRkj2TCXo6yixiC+pGJs6Fb8gNAKU/vyUPJDi+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070479; c=relaxed/simple;
	bh=fpwLyeud8slxDNFfMPt4fH1RoTxc6zyHHuy5KD2xz/M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OlDVsM1ctck2Yhz5KdX6bvsshZb65aNZrl0rscn5pL2LKG7ia4EDWRO5PScF2hiLqW4uK89NcgQCmCxRV0Kcm56ln4S/geTf4P/vLy4dR5IuNOmfB/qhYs3SBJ7+aKWyfPqgSRbrt6vsIFvBrAidnyX2eNjaYNFpXApObijusdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lmX4ESpr; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lmX4ESpr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10FB2A4A18;
	Tue, 22 Sep 2026 11:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790070474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iavK7jlVR53wJLl9dAXyNsjZSHduAokv0Z9wuS8R5hc=;
	b=lmX4ESprTgkNASV8goNwJt3cY7eUyRQ+VUzTctY6YpkPVBf28JGVbPRCwew43Ozp+VemIg
	Cf7p3TzZuDk7zgluPYXQDvOqkuaVGVXi1Zv5B39MkHdKV9Wqc8YFt/4/pSZZGUV/lczvoY
	6YIwYLva8RavTo9VwDXrNzPy2WcZRW1Z13HVgatKMUI2QKshyK0nNDJNp4PvKjzIGyTExI
	RvAcFOJUpyT3RYNSexWyN2YUCm7DG4A/EPmSmIMY2Mm2zOlpOruXqr0b0lEmGFaNgDujuT
	EUM02+91xfyrq3jg07Bcx6W7V7iYecvgEb9bphe+mvFvltxmpfM8FG2iNHCdRQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 11:47:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 12/12] net: systemport: Complete resource teardown
 even on DMA disable timeout
In-Reply-To: <20260921231305.394773-13-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-13-florian.fainelli@broadcom.com>
Message-ID: <8496008859d5a584dd3f958055abbbb2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 22.9.2026 01:13, Florian Fainelli wrote:
> In bcm_sysport_stop(), if tdma_enable_set() or rdma_enable_set() timed
> out, the function returned early with an error code. However, 
> ndo_stop()
> callers in the networking core ignore error returns, leaving the
> software ring structures allocated, interrupts registered, PHY
> connected, and clock enabled. If the interface was subsequently brought
> up again, request_irq() and PHY connection would fail or leak.
> 
> Ensure all software ring teardown, interrupt freeing, PHY
> disconnection, and clock disabling steps are executed regardless of DMA
> disable timeouts.
> 
> Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet 
> MAC driver")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index e5bb7fa84fda..2b064da4eb7c 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2088,19 +2088,15 @@ static int bcm_sysport_stop(struct net_device 
> *dev)
>  	umac_enable_set(priv, CMD_RX_EN, 0);
> 
>  	ret = tdma_enable_set(priv, 0);
> -	if (ret) {
> +	if (ret)
>  		netdev_err(dev, "timeout disabling TDMA\n");
> -		return ret;
> -	}
> 
>  	/* Wait for a maximum packet size to be drained */
>  	usleep_range(2000, 3000);
> 
>  	ret = rdma_enable_set(priv, 0);
> -	if (ret) {
> +	if (ret)
>  		netdev_err(dev, "timeout disabling RDMA\n");
> -		return ret;
> -	}

If TDMA or RDMA don't stop, the rings get freed while the hardware may
still use them. Maybe topctrl_flush() before freeing?

The same pattern would probably apply to bcm_sysport_suspend().

> [...]

Thanks,
Nicolai
