Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA74C8FEB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656626; cv=none; b=ph+KdKqcwf1GKIFoqGNf2tvhbyg4MA75nOfzYftTHtBGP63jLT8CaFjdHyo+7uuMv703mPl7FSmLKCIfsb77rscwXGIbm02AroeWUU7i8iY0PVAj8P2G0H86pZxp03vmn9hfQHkX12TuIX9FHkhSLvHYTzTaQBz/TiaO0hukEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656626; c=relaxed/simple;
	bh=Tn46f7oT2oXMsZhrMWCjRUOKDbKTRZwzTpF6O08Qjmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4BK8QLx1Uq52761X7ZnoCy77q0uwFFBb0WPJEmOJW4g1Z7HgyKJQ3+kRvFevpp3mucrrPqFQPYwH66WaG5i5YUdT0+64GqF2gkyKtIkrUQd3a1v91oTpTlj1hjCRq1oftejNIy3n2eDnlshWZ/mdz/UGbveXitQVwRU48M2Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vpn4zRpU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vpn4zRpU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 61782C58470;
	Fri,  5 Jun 2026 10:50:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9237E5FED1;
	Fri,  5 Jun 2026 10:50:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEE2E106A20FD;
	Fri,  5 Jun 2026 12:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780656615; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+nOY3W2L3VteDfAdwfnzKZgeh7JFLl7CeGAntoZOhWU=;
	b=vpn4zRpUDXc7wnhalcjLHM6UMh3KrBZDfovtVa9U3V+t5K+m8HzOPRSrDUAe5rc2AviO3k
	dXSdf8QdqoE66xdBcbFsbyIW3MUOkp5JNaxAIi/d6eOmm9FS6iuCz87+HThMHnTFkYblqU
	pZPkiCrZEYidZpbffOqWF05oOXesJ9sKjPsgEXudDpUDqGNvMRiMHG4tzxis9FXB7a4mUB
	AwoJf6uTvZ1l1Myy7YcVoQ2e5Xg9/8OR4l9PeNfWQzFfX7SVDLGEqIaZVufRqmQANjgsXi
	oZCdt79e1pSETkSSuvFHnY4RrwaqjR0n2Oj6x6ckCINVWUaGQT+G7Dd+qadGPA==
Message-ID: <f90bad35-72b8-4f03-aea3-54387dd376a0@bootlin.com>
Date: Fri, 5 Jun 2026 12:50:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
To: Javen <javen_xu@realsil.com.cn>, Andrew Lunn <andrew@lunn.ch>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
 <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
 <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
 <7c35fa5bb5f24afdb42e2d45a4e559c3@realsil.com.cn>
 <bac05b34-9c16-4c18-9e6e-a8ccee86f0d3@bootlin.com>
 <c088522c19624f11beb179a71a11d9c1@realsil.com.cn>
 <bf3c29cb-334c-4d2c-b9d7-61bf04779fe2@lunn.ch>
 <b98e02778a6742a1a831ef57c3da2070@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <b98e02778a6742a1a831ef57c3da2070@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/5/26 11:43, Javen wrote:
> 
> Hi,
> 
>>> You are exactly right. The PHY doesn't actually exist; what we have is
>>> an internal PCS.
>>
>> ...
>>
>>> I actually tried to migrate it to
>>> phylink before. However, the current driver codebase is deeply coupled
>>> with tp->phydev in many places. Decoupling it may introduce bugs for
>>> numerous existing devices. Therefore, I want to try to expose the
>>> internal PCS as a dummy PHY device.
>>
>> Architecturally, you are going down a dead end. You really should be using
>> phylink.
>>
>> I don't see anything too scary with tp->phydev in the driver. Are there parts
>> you think are going to be a problem with phylink?
>>
>>      Andrew
> 
> Thanks for your suggestion.
> 
>  Since I am not very familiar with phylink,  so I may have been too conservative about the migration. I have prepared a version using phylink and will submit it for review.
> 
> Any comments or suggestions would be very helpful.

We can help reviewing this, indeed :)

You should be able to follow the porting guide here :

https://docs.kernel.org/networking/sfp-phylink.html

It was updated not too long ago :)

Maxime

> 
> Thanks,
> BRs,
> Javen

