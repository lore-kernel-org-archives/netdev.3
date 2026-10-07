Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326942B324
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360881; cv=none; b=gfO7v88I7QqRQDt7uy1pbzVDAWaY0GRNoaWjRU4dNp7lPwklXbfW2QbPz+r4smqhsAa3j8fdGxZkrQCYnTt1Mh81MqzhvIqftwFZnND+/Nd+j7IHyE1DiWETm/vn89r8PA8l6B1d7klzpoSKv4wA3gYBj/ZrqN1JVEO5QewXdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360881; c=relaxed/simple;
	bh=SSkjGtZQquYOJbt5UgkbrEOq3tFVjx9yvdjFW56bpGY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Do9QY61tXJs+AqpnB973pVHLpEfXFO+tjIcX1nHeTyn75M4xyZ8N0R1KCRSQh5fkB5KzXo0EeROkP65r83x/IVkNkzdDCDg1lyUFW47RtLS3CZZQwg3RI6Ns++2Mo6wrC2/gkr/MrUe/9VSohOX+HzspSD+6J4N31+NUe7FU9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=PmpbSbDy; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="PmpbSbDy"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E662A0E2B;
	Wed,  7 Oct 2026 10:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791360873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GD7LuJmQFmVQO4dMUP/Ii4eVCRRdR6Rje5Rl55oH2qU=;
	b=PmpbSbDy+Qa3RiMHAFpsnsBWuJPLI3sC2b+/6YYYNoKahOgTkKEsxadT0p8nUcmJY8Yl07
	PAXn1lMvd+eFQ5jQz3waV4zSifUNZivZQlUvbThVAIHheUTZZiFVmJ/tDxjP1VcgHAzsVB
	nSPBxCLJr4nFB/9J5zk6pwGJORxL/dq5nuh45tt4iDKdvp69xPXQsz72dFEH6LF714MH3g
	x+pM2xt7gCirme9GMpJyZYAtQPr+7nuG/2OC+bk5SsGG7Gf+zSgIyTPXPpoBVRIm7aL+wG
	T2amCJXzrs006OA5rSMfgW4+jFqVm1UV2YUw8276w1YzgnxLw/8CFSuIDUgQdg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 10:14:33 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sebastien Royen <sebastien.royen@armadeus.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: microchip: fix KSZ8765 fiber detection
In-Reply-To: <20261007080557.15719-1-sebastien.royen@armadeus.com>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
 <20261007080557.15719-1-sebastien.royen@armadeus.com>
Message-ID: <61a356fb9601b9ab7a8e67a07d4ad2b2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sébastien

On 7.10.2026 10:05, Sebastien Royen wrote:
> The KSZ8765 is similar to the KSZ8795 but has two fiber ports.
> 
> KSZ8_PORT_STATUS_0 is used to detect fiber mode. It is currently
> defined as 0x08, which is the Global Control 6 MIB Control register
> and has bit 7 defined as Flush Counter.
> 
> Set KSZ8_PORT_STATUS_0 to 0x18, which is the Port 1 Status 0 register
> where bit 7 is the Fiber Mode bit.
> 
> Fixes: 91a98917a883 ("net: dsa: microchip: move switch chip_id 
> detection to ksz_common")
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Sebastien Royen <sebastien.royen@armadeus.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.h 
> b/drivers/net/dsa/microchip/ksz_common.h
> index cbe98494578c..f6104f714a8d 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -853,7 +853,7 @@ static inline bool ksz_is_sgmii_port(struct 
> ksz_device *dev, int port)
>  #define KSZ88_FAMILY_ID			0x88
>  #define KSZ8895_FAMILY_ID		0x95
> 
> -#define KSZ8_PORT_STATUS_0		0x08
> +#define KSZ8_PORT_STATUS_0		0x18
>  #define KSZ8_PORT_FIBER_MODE		BIT(7)
> 
>  #define SW_CHIP_ID_M			GENMASK(7, 4)

Please do not send new versions in response to the earlier version, but 
send it
like you would send a new patch (with the usual v2 ... prefix).

For more details please have a look at the netdev contribution docs [1]

[1] 
https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Thanks,
Nicolai
