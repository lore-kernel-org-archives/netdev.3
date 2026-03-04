Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65488388E56
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612033; cv=none; b=r0+vGFSm3IX51ijh3xhV/vmXedNDTWPAmN8FQAc4uqeIZOLmJPZ75Tuq4/Ug1Lt9MFFdVu4+zWkGLTynFcpnoervcTSNFUl3uX1WWHMa8q17Dfw18yVKnpRI3luWbejHu/N6At99q2GXnhQLHuALC0FATSZCXUqIAg3wgdE9i/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612033; c=relaxed/simple;
	bh=8fyynA1zoCoHsFnSa5d9GZ2QPHwVFu1AM0rLyexFNPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9zts37y33YGNLUrDODIRMpOt37W5UJcJFuf0tXfHkNBiDOiDvxBLp4p6FlTzIX45Hd+3NdmnstUAGYcDYah+WIYw2QMtZNzPbxhqdMo1P1cWlI8XUQTUMHFE/RSblVFlUg0Wcu7Rk3rRq9kgWOmN/Ftca5fdy5IN6R5FMY6Lkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OgITzNd0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OgITzNd0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 97201C40FBD;
	Wed,  4 Mar 2026 08:14:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70B275FF5C;
	Wed,  4 Mar 2026 08:13:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C855103696E4;
	Wed,  4 Mar 2026 09:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772612028; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HgahueLoF92Rz/Qj3uWYdmBNalgEsd50AYedYO7W2rs=;
	b=OgITzNd0JynVw7oohVTFUPQFhANIyeOcBncPsj1rkzxgpHyo+g4L/NbySYT+KdOa6pokqW
	6+iA6T7HRph59L1x2nKRh9GK5sFg3ZZo3FPA1VNqddpOvPB305HUFpZCbfpPXs9vNeF7Fp
	GkOkLb77oK9Q+VjZrhm5RSQFXD7zzTOy9GwdE4xAGv0tYImY5MTVjvnMU0sdgg0CT+6eDN
	+nu5JPP9bGCvxtr69Jl3Kv5PCupsm80G4z//OA+o8zbp5PhbdezTAAEoZY0w5t8+Qli3kr
	LQ9CvyuQNPBzyFkWNqaxyizhqa/lnakzZw8UhRe25Ca/Ddaz7mM50IZjKacAhw==
Message-ID: <f4effa86-3a99-4d5a-8442-bdc52a6139d9@bootlin.com>
Date: Wed, 4 Mar 2026 09:13:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
 <20260226-ksz8463-ptp-v5-1-1bc24fb9627d@bootlin.com>
 <20260228141630.15b4292d@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260228141630.15b4292d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 2/28/26 11:16 PM, Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 17:41:48 +0100 Bastien Curutchet (Schneider
> Electric) wrote:
>>   	/* Read interrupt status register */
>> -	ret = ksz_read8(dev, kirq->reg_status, &data);
>> +	ret = ksz_read16(dev, kirq->reg_status, &data);
>>   	if (ret)
>>   		goto out;
> 
> I think you promised to extend this comment to indicate that the
> over-read is safe?
> 
> https://lore.kernel.org/netdev/c9cb204b-e079-4f5b-b670-dcce14101390@bootlin.com/
> 

You're right, I forgot about this one, sorry about that.

> Also could you go thru the series and check for cases where the lines
> are unnecessarily long? In netdev we still prefer 80 chars.
> Not a hard requirement, of course, sometimes wrapping hurts readability.
> But plenty of examples in here of this which could be trivially wrapped:
> 
> WARNING: line length of 96 exceeds 80 columns
> #166: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1138:
> +static int ksz8463_ptp_port_irq_setup(struct ksz_irq *ptpirq, struct ksz_port *port, int hw_irq)
> 
> WARNING: line length of 82 exceeds 80 columns
> #207: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1179:
> +	ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);
> 
> WARNING: line length of 86 exceeds 80 columns
> #218: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1190:
> +	ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev), ptpirq->nirqs,
> 
> WARNING: line length of 83 exceeds 80 columns
> #219: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1191:
> +						  &ksz_ptp_irq_domain_ops, ptpirq);
> 
> ... etc..

Sure I'll take a look at it.



Best regards,
Bastien
