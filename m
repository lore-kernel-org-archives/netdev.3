Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7863AAF57;
	Tue,  1 Sep 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253525; cv=none; b=tA6Nfm5TMSQQVy5wijSRTR70wLdP3hQ5nJOf8xH7MuGQ8/egDP5mEyt6cQMvcqWZPUbv63idnDULW6abPyMIYqTlsEIIMLD9mtQUC7+S35HRHWO+dd2kguE00Wh0L68RsaYTwbu82L3npemBpJldViMWoxO/U1dn45nSVY9aCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253525; c=relaxed/simple;
	bh=Vg4cyF1+d9e+J9NUaFGqRHksw/LB1Ux2jcR/L7iyFkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sadLLGFuUmYZ9oVGKh2SJ/krbnCCRoZ/QxxcU+Lq7+zwQTKIf9IFnDVqD8D4p8xXD19qiyyLqK/QKBtctK8gUAJS3xqJq3Q42vN2cvJDN2CmU+Vjen4fTksnCikO9P95IGAwiAGHold4TcyfwJYvNmX+tJFAxXSNXK4FYu08RUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eJcvPQIc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eJcvPQIc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA9FB1A1925;
	Tue,  1 Sep 2026 09:05:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA94C6053C;
	Tue,  1 Sep 2026 09:05:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 196BE11C79250;
	Tue,  1 Sep 2026 11:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788253519; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GJuoWYQzDE1NRtCyW1LcfgF9O6bpX8to9ln1fn3ixIc=;
	b=eJcvPQIc8DGkcHhHoXhV1UzWfmBDlgzHp9/jTqCqe21bTmqgyBkFg7hq0V17idFcuc3ylq
	tYkYzAzaDvVxhe3hniX6FwBMU7WL8ZKUm3SdhBjZYNuYhPi5g11gPca17rViw+Rf2eaDLF
	JvKViPoBLhHKMr6Fo1EGBavxqpeGAJjTEaw4NSvpUYZgs2VbHGqA4wz08gscIHeeMe1tZc
	NDSrVuDX1xThOCioQxK1wngqAq2OedyhyoMtZuHGA3QyRw0/wDCmPTlVH4YlZi2+w1Giu6
	CkGQXpOO2FI7xCRLjqYDb1RmAO15Xu1IywWDolfrgHxz/gkA3asWBvCaJcFS8A==
Message-ID: <e4050d49-29cc-4fc7-aec5-53c8dd9dbc97@bootlin.com>
Date: Tue, 1 Sep 2026 11:05:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add UltraRISC DP1000 GMAC
 support
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>
 <49620860-9bd5-48fb-bbaf-55da377e9018@bootlin.com>
 <178825152454.3900827.17398212265347300430.b4-reply@b4>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <178825152454.3900827.17398212265347300430.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/1/26 10:32, Jia Wang wrote:
> On 2026-09-01 09:29 +0200, Maxime Chevallier wrote:
>> Hello,
>>
>> On 9/1/26 03:27, Jia Wang wrote:
>>> The DP1000 GMAC integration provides fixed TX and RX RGMII clock delays
>>> that cannot be disabled. For boards without PCB delays, "rgmii-id"
>>> describes the link, but passing that mode unchanged to the PHY would enable
>>> a second set of delays.
>>>
>>> Use phy_fix_phy_mode_for_mac_delays() to translate "rgmii-id" to "rgmii"
>>> before attaching the PHY. Reject other RGMII modes because the fixed MAC
>>> delays cannot be combined with them without duplicating or omitting a
>>> delay.
[...]
> 
> Thanks. I enabled CONFIG_STMMAC_SELFTESTS and ran the test on the Milk-V
> Titan with the new glue driver:
> 
>  1. MAC Loopback                 0
>  2. MMC Counters                 0
>  3. EEE                          -95
>  4. Hash Filter MC               0
>  5. Perfect Filter UC            -95
>  6. MC Filter                    -95
>  7. UC Filter                    -95
>  8. Flow Control                 0
>  9. RSS                          -95
> 10. VLAN Filtering               -110
> 11. VLAN Filtering (perf)        -110
> 12. Double VLAN Filter           -110
> 13. Double VLAN Filter (perf)    -110
> 14. Flexible RX Parser           -95
> 15. SA Insertion (desc)          0
> 16. SA Replacement (desc)        0
> 17. SA Insertion (reg)           0
> 18. SA Replacement (reg)         0
> 19. VLAN TX Insertion            -110
> 20. SVLAN TX Insertion           -110
> 21. L3 DA Filtering              -95
> 22. L3 SA Filtering              -95
> 23. L4 DA TCP Filtering          -95
> 24. L4 SA TCP Filtering          -95
> 25. L4 DA UDP Filtering          -95
> 26. L4 SA UDP Filtering          -95
> 27. ARP Offload                  -110
> 28. Jumbo Frame                  0
> 29. Multichannel Jumbo           -95
> 30. Split Header                 0
> 31. TBS (ETF Scheduler)          -95

Awesome, that's pretty-much what I expected, nothing too bad stands out :)

Code itself looks good, no obvious error, so

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
