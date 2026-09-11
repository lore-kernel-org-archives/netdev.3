Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151A42EEA3;
	Fri, 11 Sep 2026 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112038; cv=none; b=RoKYhX0kWLvByDOqv6NDTHotViFP6FPhPWEdSb7i4LaLkzn7gDXiXdG+X228WqqeWK/NqCbiaZxQ5ifY3mXG2MKe4mE7J/wynIVnPEBsdBWQuaCPQUpFujwekf3QDn+td9L8g6+Nfx6UoHV06S3IgUUMoankxUtYq8zVauhIxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112038; c=relaxed/simple;
	bh=TkVzHPFpPgH50bX6nKV2RFkHqUxJzUUnFkdJ7sP34WE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PKl8wiw3d21HwqvPbCoNkgjSrx1LX+lW95PSpVm+oh0lim2pF96onUXbI27Z7c15n1PIPLswqYg6Qt3Hdj3RMGiHCbYPUuKhlbBzbT1oGKfzchpQ6cm1jWDXVv7rmvSX18OFljSs/H6lk/72iZL7Q0enTfAXsR+bC2MJx6/MmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=qOCRGx2D; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="qOCRGx2D"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64F98A0580;
	Fri, 11 Sep 2026 09:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789112029; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CAtppEZ9aj3HrQWPynhETYHoffVkjhVOafGCQyLac7Y=;
	b=qOCRGx2DXN1NswiqSZpKMRclb0OnU6NvkxJIrHkTz+ZQdT0jjx4b/kpna1Phfc22IM1hF2
	UkX7NidsUQzoSi0sH8ASJBwC9fdHG84qFyD0I+8aIEHcNLwhYJF2kT736hYavJtqWdaOo5
	htREIMqW0a7k2sqKS4NGG2xCjDUZ1SztLuZU6q+O2rwsGYX7b/lnmMjDQVP3Srgn7fdtQ1
	h58c0mTDgeHzUQuKqY8zy7RK55l2O0NFdpyQWTnc3wMExjvI6VETVMSc9l2KOHpdL/D7w0
	4nqai+R2I5Npk5XkSKHadbVDgsY6rgA/dWnwx5lH7LE5THiw+ETbZdH0jaxeyw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 09:33:42 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Javen <javen_xu@realsil.com.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, =?UTF-8?Q?=E9=A1=BE=E6=99=93?=
 =?UTF-8?Q?=E5=86=9B?= <freddy_gu@realsil.com.cn>,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1] net: phy: realtek: improve firmware write
 speed
In-Reply-To: <52ca9b2eddf24d5088124f1274d8cb17@realsil.com.cn>
References: <20260910024927.1644-1-javen_xu@realsil.com.cn>
 <06862775-e6cb-425c-9118-d2571e8ab222@lunn.ch>
 <52ca9b2eddf24d5088124f1274d8cb17@realsil.com.cn>
Message-ID: <1e621cbb34e8077a76fb44b72c8c44fc@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen

On 11.9.2026 07:51, Javen wrote:
>> 
>> On Thu, Sep 10, 2026 at 10:49:26AM +0800, javen wrote:
>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>> 
>>> Firmware execution routine unconditionally uses phy_modify_mmd() for
>>> all OP_WRITE entries which introduces an unnecessary read transaction
>>> when updating an entire 16-bit register. So we optimize this by
>>> checking bitmask boundaries. Use phy_write_mmd() directly to speed up
>>> firmware loading process.
>> 
>> For optimisations, it is normal to include some benchmark numbers to 
>> show
>> how big a change it made. Is the added complexity worth the change?
>> 
> 
> I traced the actual MDC/MDIO hardware transactions during firmware 
> loading process. Here are the benchmark numbers:
> 
> - Unpatched : about 28,000 MDIO transactions.
> - Patched: about 9,600 MDIO transactions.
> 
> This results in a 65% reduction in MDIO traffic.

Can you please add these numbers to the commit?

The patch itself looks fine and also compiles cleanly on my machine.
So with the number added, I'd be happy to R-b.

> 
> Thanks,
> Javen
> 
>>        Andrew

Thanks,
Nicolai
