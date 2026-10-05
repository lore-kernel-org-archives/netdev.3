Received: from mail1.kuutio.org (mail1.kuutio.org [65.108.50.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B576488DBE;
	Mon,  5 Oct 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.50.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221273; cv=none; b=WCObDj2eJplRYvbRlGEAw+s9MeKt3L18cw0M6iJMmHvUasAwYipYsFLd73H3Y0dVpdvuN5pacll6kPDV0FgH5o1UKCPTbn/7lnweEXQw7oXKUoaXn81gIvvBaAe7ieGUo7LxxAqCdxwVCGyvj78DO9RgLdBUYM3wwdpsUubJ4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221273; c=relaxed/simple;
	bh=Tk1X2e/P8UtD/GAN6M/X9DdTPSSkTNPKiW5lzDUX3t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aENwYIFwt+ipsCUqqYhKLG3Xw3K46NdSAgEphbHn6Ptrd4azccn+vJQjvCZPVROhSvrIa04qALhpt2fUFOUdhPIPariV9nSt/27fXE9qMggUT/qIrSCxiYLFYe3+7RwIO2o4tlsfb/OPMDX9rfPgNbsqA5MKlQD9prrjKgIaXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=65.108.50.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail1.kuutio.org [127.0.0.1])
	by mail1.kuutio.org (Postfix) with ESMTP id 6F2411FD9F;
	Mon,  5 Oct 2026 17:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id ENcVWQQ26Olu; Mon,  5 Oct 2026 17:27:46 +0000 (UTC)
Received: from [IPV6:2001:99a:adc:6a00::8be] (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail1.kuutio.org (Postfix) with ESMTPSA id BA7F81FD92;
	Mon,  5 Oct 2026 17:27:46 +0000 (UTC)
Message-ID: <44329318-f6ae-4387-9393-a9f8e50fdf8d@lemmela.net>
Date: Mon, 5 Oct 2026 20:27:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: realtek: fix RTL8224 package address
 selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Damien Dejean <dam.dejean@gmail.com>, Manuel Stocker <mensi@mensi.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261004204637.721148-1-oskari@lemmela.net>
 <0cda40ae-b468-430c-8de9-10fdde8e2beb@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Oskari_Lemmel=C3=A4?= <oskari@lemmela.net>
In-Reply-To: <0cda40ae-b468-430c-8de9-10fdde8e2beb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 17:00, Andrew Lunn wrote:
>>
>> Fixes: 330296ea9e15 ("net: phy: realtek: add RTL8224 pair order support")
> 
> I suggest this gets merged to net-next. It never worked, so it is not
> a regression. This patch just extends the current implementation to be
> more generic.

Thanks for the review and clarification. I'll prepare v2 against
net-next, remove the Fixes tag, and update the commit message to
describe this as extending support to unaligned PHY packages.

> And now you are looking at DT properties, you need a DT binding
> document.

I'll include the RTL8224 PHY package binding documentation as a
separate patch in the series.

Regards,
Oskari

> 
>      Andrew
> 
> ---
> pw-bot: cr

