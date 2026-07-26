Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0611FF1B5;
	Sun, 26 Jul 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785036284; cv=none; b=LPEdcNENfwipoE98cgQd9k4hydN3xfHIpu5WkIcRB0JD7w0IjX4FY/EOyC0j9H+oLYB2krTKcofdn1vScU/1LD2xBVOQiDUu6p6rofZd2jm45RDqtl8caUealG75/JEoe23igNAGmVptP/bBkQgdEsQsbCANakxMrNGAhNRs1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785036284; c=relaxed/simple;
	bh=atBVWkixzHctNx6p2JfDsYHkgTibKRLnHg7sSvX7AsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1sULCBiorDNNxmdeVbmpmc7ZLGj6W1IQHjaT8SNVu1i3ZAeDWxhq1F4VyTQBoL4Alc5rUf6wfq8qDu9OXxPPmUCSTaMWUd/Z+YlqFCcWTss936ncwG54Fhcy/wceYZ1KxGkZ0ewUsR263UHC2gWMsr1eLHfy9F7lNv57mwUNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=PASS;BC=0.1509772|-1;BR=01201311R681ee;CH=green;DM=|CONTINUE|false|;DS=SPAM|spam_education_ad|0.901916-0.00468777-0.0933958;FP=16995275296565988992|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iVPgVvc_1785036256;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iVPgVvc_1785036256 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 11:24:20 +0800
Message-ID: <638fda5b-ee2c-4f3c-94b6-37d689d48721@motor-comm.com>
Date: Sun, 26 Jul 2026 11:24:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260721114810.660718-1-kyle.switch@motor-comm.com>
 <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
 <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
 <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
 <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
 <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
 <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>
 <87a4548f-ef0d-4ddc-9e87-155786cd5e31@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <87a4548f-ef0d-4ddc-9e87-155786cd5e31@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/26 21:18, Andrew Lunn wrote:
>> Ans: It is different from the m88e1111 PHY, which may support UTP, fiber, 
>>      or combo mode. However, the PHY8824 is only used with UTPs, and 
>>      its structure is as follows, which includes UTP0, UTP1,UTP2,UTP3 and USXGMII.
>>
>>      RJ45 <----> UTP0 <------>
>>      RJ45 <----> UTP1 <------>   USXGMII  <----->  USXGMII(the side of MAC)
>>      RJ45 <----> UTP2 <------>
>>      RJ45 <----> UTP3 <------>
>>
>>      It is similar to phy8821 driver in motorcomm.c, with the difference 
>>      being that one has one UTP port and phy8824 has four UTP ports.
>>      YT8824_RSSR_FIBER_SPACE is used to access USXGMII reg space, Perhaps it 
>>      would be more accurate to call it YT8824_RSSR_USXGMII_SPACE or 
>>      YT8824_RSSR_SERDES_SPACE.
> 
> O.K, that completely changes my understanding of this device. Yes,
> YT8824_RSSR_FIBER_SPACE should change name. And i would include this
> diagram in the driver, and indicate how YT8824_RSSR_*_SPACE map to
> this.
> 
> For the locking, look thought all the code which is touching the
> USXGMII side and see if it can be moved into probe().
> 

Ans: It may not be possible to completely move the code which touch the USXGMII side
     into the probe() function. The initialization configuration aimed at optimizing 
     the performance of the USXGMII side may be moved into the probe(). However, for the 
     soft reset of UTP, it is necessary to configure MII_BMCR registers in USXGMII side.

> 	Andrew
