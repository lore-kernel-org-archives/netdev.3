Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62B37A4AF;
	Fri,  8 May 2026 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226672; cv=none; b=aVC4svE8up5e00FY3bPYN0bNWB7o+r59Z6dFki0oX3FEWPCateEcpj4BG1c8Je8HLJ0aqC8WhJdh8SU0LUy39MqUQ6MwwkujhllssYcPptirfB7UiVxCrtz07I3sHEXV8cjUaty/m9AgcCOPw4GOA8L0srwFsYS7DrYCu6ySKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226672; c=relaxed/simple;
	bh=ywr9BYG0SsUCA8Xw3Ma+dyznX1/GjYIJ9T7zinYMS58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKXCmgrhngWmMB6hZZkQddWw9/6GVzZ19zuWgZ5mOdHxHDarMF14ipy5je6xly/M78IfWfbEtYkkvcckY0x5F89cola0oaAdwNa3AqclMjZkgSR/1ywT2BHkK+2gEaGurfzNztbwr5TFFVGIFpD9d8Rw6hLvYd8BpjsK6WOXoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D43C2BCB0;
	Fri,  8 May 2026 07:51:07 +0000 (UTC)
Message-ID: <f5158347-3c9f-4c29-bb2f-4beaaca3cd20@tuxon.dev>
Date: Fri, 8 May 2026 10:51:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: change maintainers for macb Ethernet driver
To: nicolas.ferre@microchip.com, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, netdev@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260507120444.9733-1-nicolas.ferre@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260507120444.9733-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/7/26 15:04, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> I would like to hand over the macb maintenance to Théo, as I'm unable to
> keep up with the recent flow of patches for this driver. After speaking
> with Claudiu, he indicated that he is in the same position as me.
> To help with this work, Conor has agreed to act as a reviewer.
> 
> I was given responsibility for this driver years ago, and I'm glad to
> see it continue with talented developers.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37b105a443dd..ad60104f30a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4181,8 +4181,8 @@ F:	include/uapi/linux/sonet.h
>   F:	net/atm/
>   
>   ATMEL MACB ETHERNET DRIVER
> -M:	Nicolas Ferre <nicolas.ferre@microchip.com>
> -M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Théo Lebrun <theo.lebrun@bootlin.com>
> +R:	Conor Dooley <conor.dooley@microchip.com>
>   S:	Maintained
>   F:	drivers/net/ethernet/cadence/
>   

