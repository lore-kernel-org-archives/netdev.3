Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840C24CEEA
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371267; cv=none; b=V0IIClFL1yMAral6w2h2Jw9WUqxF5QNxLkont1J5TZtLMtO6Yf8Av9sVvNMg8ui876u/Q+PeWi+Vk7k1A00/8/UPQYeEU0mBrK144aly9clI/+hqZIlM4bwxEk4nSPOqqiDOKDZ2gkkiG7O/J5tKi3Ue032CStMc3jXNMawaTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371267; c=relaxed/simple;
	bh=GNJpm7UipZKsLqGbcfp/Di7PVldLUWQjenpnWyM4sCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0yDYYhJeLlC8rhjXsKzeDTzjJsXkoGUFf6+ANWZyoeSKAFx20JrddDQ1dJOQ2PbGVbjmAoh6ETUcEUpNINy/DWmsIXeNn634pGE6zROOPD1QZxNzwsLQPIFVUhcXYmMhmVclnenBPoW2J1pKPXaW7ouucHaB/wumsUq32foC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=njkmDsA5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="njkmDsA5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C1206C5CD4A;
	Thu, 25 Jun 2026 07:07:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73EA05FF03;
	Thu, 25 Jun 2026 07:07:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82406106C84DD;
	Thu, 25 Jun 2026 09:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782371261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HKhlYO1rWwC1+kuhbZdMLAovIe+I8+auK56i6UqdxkU=;
	b=njkmDsA57+ghNCGe6eKbMng2cExlwQSFlMa2v9ma8N9ihXXLAquwJMSQW1SeP2sWl3dijT
	9penFFUrSGsFD+fdJMrDAQAr7oxudkV38rDxir3nKfhqI9chafzMDZq2d0XMA8MEr2K3OR
	ePw7YOSo/d5AqTz6rkcqcb8j54f/pm+Vv36B24KppvdfKyaR5ePLF3xLgGvMq3ZDG48brq
	YqV6EmqQUCSDa1QJf4MUAHOWyGk4Uou3HOi2qTGGO2U4bTSwJUEQ2+LEFUCqA2FjUeLQLy
	DaMXHvArxM0vlYr/QyB8PjiYwXipakxHWoZZl8iZa3JeOQQu3+PCBdP5wKPKLQ==
Message-ID: <2a92fd9d-42b3-4564-b784-ec504d4d82b8@bootlin.com>
Date: Thu, 25 Jun 2026 09:07:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: fix missed le32_to_cpu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260622143707.497198-1-ben.dooks@codethink.co.uk>
 <b375d36c-112e-4662-b538-fd10fa927ecc@bootlin.com>
 <20260624192205.4485cd61@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260624192205.4485cd61@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/25/26 04:22, Jakub Kicinski wrote:
> On Mon, 22 Jun 2026 19:51:39 +0200 Maxime Chevallier wrote:
>> Hi Ben,
>>
>> On 6/22/26 16:37, Ben Dooks wrote:
>>> The print in ndesc_display_ring() sends the des2 and des3
>>> to the pr_info() without passing them through the relevant
>>> conversion to cpu order.
>>>
>>> Fix the (prototype) sparse warnings by using le32_to_cpu():
>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorrect type in argument 6 (different base types)
>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected unsigned int
>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restricted __le32 [usertype] des2
>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17: warning: incorrect type in argument 7 (different base types)
>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    expected unsigned int
>>> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:258:17:    got restricted __le32 [usertype] des3
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>  
>>
>> I agree on the principle, but this isn't a fix so this'll have to wait
>> until net-next re-opens :)
> 
> Humpf, why are we not seeing this on x86 allmodconfig ? 🤔️
> 
> $ make C=1 W=1 drivers/net/ethernet/stmicro/stmmac/norm_desc.o 
>   DESCEND objtool
>   CC [M]  drivers/net/ethernet/stmicro/stmmac/norm_desc.o
>   CHECK   drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> $

Heh good point indeed !
  
>>> Fix the (prototype) sparse warnings by using le32_to_cpu():

Ben, what's this "prototype" sparse ? a custom tool of yours that
you used to find that ?

Maxime


