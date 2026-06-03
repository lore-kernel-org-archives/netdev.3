Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718B3822BF;
	Wed,  3 Jun 2026 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490318; cv=none; b=Ct4tTirO7awiBxWwZJlxrk2m0H9IFIhWJe4F36B3gKaTfPo6Gisy2cNUHONOvmZYH/vIhh+8WG14PdnKVikW54qK0A7+/4BVYtX9pwlnWVVXDuKFXV21P6pDatcrzNL9LR7R3MNEMHi5hAZ1G/Kn2PayHHdcrtIUOUIr9pamPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490318; c=relaxed/simple;
	bh=5bHY+YsG81BuUciaVcOihnktaS+mMEov8Z9m1VmG5tM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QInKu+7k5yjsVItlNKzRyOTHMFGScL15l66sm7EHvHFkh0bROVY9daI4QEYeA7/wXVSDJSCz155+tCwRZgztVZPB9vQHtvLCBguG+72dPSG/iNu0pOkAbdEjikVPV8pCKbMyVE6cWSIIVhps4HIiFmyI4NcO6hw2LoK0CpFntCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=4TUT6F0o; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="4TUT6F0o"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AD80A4B67;
	Wed,  3 Jun 2026 14:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780490305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Tf3KQrOIjUOndWRSBGC/XP+UavWomwz4e/A9aZNsvIw=;
	b=4TUT6F0oPv45gBoIAMbrgEca6FtGBA1DogkhXKxwFFuVFh6+0u+8PXEZ8we5OQqQEt6vAf
	nreL11Z58YicFsSi9yQ3ycZVYCKdr6itJPR0irEgk47fbm8Ig5h8MPrYPWMn3V0R6b9dcG
	CLd41kHNAezfXYjHMgLLhpLSyiwsNXX9PdzJBp+2DQbrp2qU/zUkWGvbOoElEm/9SFvZFV
	InvaEjX4yNsnM9KGCduJjTJ6yUs0bolqK2TYucs6kM4qnFWBv6H3wpwoY8kVOLO/5fVmsA
	3FmTOU4X6KcFpS18nX5STz6x02hnDqhlhED9dqzQLUccpQ2FhfLc4FszuG3zyw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 03 Jun 2026 14:38:22 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij
 <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: realtek: Use %pM format
 specifier for MAC addresses
In-Reply-To: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
References: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
Message-ID: <db861659b03b355cb3860231e54176d8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3.6.2026 13:20, Andy Shevchenko wrote:
> Convert to %pM instead of using custom code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c 
> b/drivers/net/dsa/realtek/rtl8366rb.c
> index d96ae72b0a5c..103039fe3086 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -573,8 +573,7 @@ static int rtl8366rb_set_addr(struct realtek_priv 
> *priv)
> 
>  	eth_random_addr(addr);
> 
> -	dev_info(priv->dev, "set MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
> -		 addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
> +	dev_info(priv->dev, "set MAC: %pM\n", addr);
>  	val = addr[0] << 8 | addr[1];
>  	ret = regmap_write(priv->map, RTL8366RB_SMAR0, val);
>  	if (ret)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
