Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66652D2A3;
	Tue, 22 Sep 2026 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066489; cv=none; b=A49HRFXXyV+4IIZfo00cf7Aeniu45fuK3FOujfPFrmylh0+LOlDRm+KM/+/odZIMJjW9Mduhb19IIXCUXUgG1JSdEdPJFJFWXzdUmJBZwOnjdCIJHm4FsrHYlM9loeUJ3X5ZIgPi9VMEALjbkEprEXCSD7DMnStgbpGDQZdYKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066489; c=relaxed/simple;
	bh=BK0XwOiWXwIp1j8ZPBp30Li+pc3o2R450wv3Nk4qoWc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GkPJe8BDkR5Ds2J/jI/ir4CElMvxfcPercpXBXfSkx2EC3PEqJM0/J/pDhkrAWEKkCDOV5tRZB7cKUZPtv91bfX+0TJH7X+lFwPU9Sw0IvXcObuLumwnYKKFU+PQTrQ51zj9WnzeS1rK+td3BLedRLr0vKOScP7KwbgP9V8J9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=msUvPUsf; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="msUvPUsf"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E6A7A3808;
	Tue, 22 Sep 2026 10:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790066485; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SQfMx+6SRA7JboPCCNSaNL2gErrhtLmpZN2xmVoX0oI=;
	b=msUvPUsfcLBFDp3T+SrLBhw6xQI79Q9DYtZkac7N5NTM5hZLYSW+xEvJDSqcJ5fxYZYmWx
	FCttwV1KoArAkL4J22lKUUokS9pM4ejmq6ZA6JYrzv0nV4CzVjpI9jSBDd/OBlk4leSrle
	n0NDDn6++LHWjI491pl2rEz9InEDogpukSkjX3SmSsGmgXFjwR2GaCRnrOF4R09h5Gp9S3
	P6q/kuCHdTYfT7ZoA5ONhZM1xXZ2uzYt30sH5Cn+KYOHTgJUltx+3PiTIS12i4Q7YKj3Om
	h9+IQYqGx/9iWivzXOho5GkC2hPuPjhGclZFUEa/UYnlVxbVWgIZVuRLwOtGMw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:41:25 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 10/12] net: systemport: Fix unbalanced Wake-on-LAN
 clock disable in resume
In-Reply-To: <20260921231305.394773-11-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-11-florian.fainelli@broadcom.com>
Message-ID: <8b7ab297016ecb541c4baa764ca85214@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:13, Florian Fainelli wrote:
> In bcm_sysport_suspend(), the Wake-on-LAN clock (priv->wol_clk) is only
> prepared and enabled if both device_may_wakeup(d) and priv->wolopts are
> true.
> 
> In bcm_sysport_resume(), however, clk_disable_unprepare(priv->wol_clk)
> was called whenever priv->wolopts was non-zero, regardless of
> device_may_wakeup(d). If the system entered suspend with Wake-on-LAN
> disabled at the device level (e.g., via sysfs wakeup control), this
> resulted in an unbalanced clk_disable_unprepare() call on resume.
> 
> Fix this by mirroring the suspend check in bcm_sysport_resume().
> 
> Fixes: 6328a126896e ("net: systemport: Manage Wake-on-LAN clock")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 384423b312ca..dd5a7c9dd90f 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2803,7 +2803,7 @@ static int __maybe_unused 
> bcm_sysport_resume(struct device *d)
>  		return ret;
>  	}
> 
> -	if (priv->wolopts)
> +	if (device_may_wakeup(d) && priv->wolopts)
>  		clk_disable_unprepare(priv->wol_clk);
> 
>  	umac_reset(priv);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
