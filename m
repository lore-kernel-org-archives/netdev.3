Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C42522681;
	Tue, 22 Sep 2026 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066462; cv=none; b=sRZcypxs78vsjm8+ejJXvI1Uem2WyVmSceOwFXF6w/IrYej7TccZfNAPSgoBxa0+xRRXuvBLXldM4Elf1PTWzVt4HO5bI8dvm9Ej1giBR4h2AgrVtj2Mwx2Oy4MejSvajLNtvv06/vd5yGWycdyT8cyk+ekUm9jB4h7qOcLqF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066462; c=relaxed/simple;
	bh=T9HOtjRJUmiDe8Uzr5QX9e9Hghb4WaebMQY2bFxRzBE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fdCokAshaJwqqihkeo2A2njXjkzL3oVPcktP+enx/2vj/hGtRMAngdsD2Unj2fhj9haP5hgkTFG5InHiIZ1nBy/oT2z/K/JX/Ti2QIYS9tc2aiTO54fVauyid7BOp6jjBpds9hPbjBwnQqgIYHr/1XzsqE+Ba5NNU08+a2fQJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=swDuYubt; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="swDuYubt"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC0C3A3808;
	Tue, 22 Sep 2026 10:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790066458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pSFVOWKbeq37+jQRA4HEWxMWIrgEMkAuHMygiM20254=;
	b=swDuYubteAcQLktFrRlAFohbuNyxHyKBLJZW0HrpwiUeDAIP+jTu5uHlWNYzbQNMKnLtfW
	yOz3NvYdc6fvzVXhGhCXjcFp4ybifZjgWER2zZ66rOPHxRHHu6NA9Hw+iT39LjoeomN26Z
	zvUgPsQ7dkphb4te9oqEZEd//OYYVwNk1g0MT1rj75CdJFVuX12jkI6ILuTn6XI2iCv6XS
	oEaMRoAq+rQEjpDl9iLy7VXzVyexzz26XHv/LO2ZwBkbq1Bi04nTsPPxZ+7tJnVNKjwJyf
	r26lCXW3tnwDmSOK7axUPEx7zHfIrOvvT7bxWqEpQqtsg1NOcBJ94V2wsoV3aw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:40:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 09/12] net: systemport: Fix inverted error messages in
 bcm_sysport_stop()
In-Reply-To: <20260921231305.394773-10-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-10-florian.fainelli@broadcom.com>
Message-ID: <919b2a5abb813a7976a84c3001b6e724@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:13, Florian Fainelli wrote:
> In bcm_sysport_stop(), the error messages printed when 
> tdma_enable_set()
> and rdma_enable_set() time out were inverted: the failure of
> tdma_enable_set() logged 'timeout disabling RDMA' and the failure of
> rdma_enable_set() logged 'timeout disabling TDMA'.
> 
> Swap the error messages so they correctly describe the failing engine.
> 
> Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet 
> MAC driver")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 130545cce045..384423b312ca 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2089,7 +2089,7 @@ static int bcm_sysport_stop(struct net_device 
> *dev)
> 
>  	ret = tdma_enable_set(priv, 0);
>  	if (ret) {
> -		netdev_err(dev, "timeout disabling RDMA\n");
> +		netdev_err(dev, "timeout disabling TDMA\n");
>  		return ret;
>  	}
> 
> @@ -2098,7 +2098,7 @@ static int bcm_sysport_stop(struct net_device 
> *dev)
> 
>  	ret = rdma_enable_set(priv, 0);
>  	if (ret) {
> -		netdev_err(dev, "timeout disabling TDMA\n");
> +		netdev_err(dev, "timeout disabling RDMA\n");
>  		return ret;
>  	}

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
