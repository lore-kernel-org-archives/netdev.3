Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774747DF8B;
	Wed, 22 Jul 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706275; cv=none; b=GrBv8QlCyAlYIvBbN7pCiVyQY9LtpWk/2zg2IR6IMtgHo43CWQUxRMFhOhjCuQFLnVOV4upv34McuBgwgIOlnczWcl+OwwPHYZcH2ZTZdKwGCTCa9yxar3e66F0Vstc6yW3qZ7rLT0TrCAHsqca/xk5AEUTchSJ1zGEeDx9FYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706275; c=relaxed/simple;
	bh=l2d/YxJM2QlX7cYReQI+txkUbgfMASfxQ0rcaiMaSl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ag/21FYud3C9Zzfq1tBO7IWxg0364+eSEjYE+Kfw5NI+BgmGNERdwADVxuht9rpSNAoKn1VUpHY9+yd2t9Y+tSNPqQNeFQJVEgPyXrGVUF+qGhr3Ee88Z25QDrW31DmCozmysinvQnOx5EtqiO0e1/zr362e9zoCJ4s6ZKOBfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1150682|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0721865-0.00110899-0.926704;FP=14915656950386581371|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iRupOPu_1784706254;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iRupOPu_1784706254 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 22 Jul 2026 15:44:17 +0800
Message-ID: <ed9e5a3a-21b9-44cd-8fe5-4857be269886@motor-comm.com>
Date: Wed, 22 Jul 2026 15:44:14 +0800
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
 <038431aa-5aaa-4c9c-87dc-bb0c0a1ed847@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <038431aa-5aaa-4c9c-87dc-bb0c0a1ed847@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/26 21:27, Andrew Lunn wrote:
>> +#define YT8824_UTP_TEMPLATE_MODE_CTRL		(0x84)
>> +#define YT8824_UTP_TEMPLATE_MODE_MASK		GENMASK(15, 13)
>> +#define YT8824_UTP_TEMPLATE_TEST_MODE1		BIT(13)
> 
> Is this MultiGBASE-T test mode register (Register 1.132)?
> 
> The test mode control is not a single bit, but three bits. So you
> should not be using BIT(13).
> 
> Since this is a standard part of C45, please add a helper to phy-c45.c
> 
> Another thing i want to take a look at is the locking. It is pretty
> ugly having to use so many __ functions, and not being able to use the
> helpers. I want to see if we can avoid this.
> 
>     Andrew
> 

Ans: yes, it is standard MultiGBASE-T test mode register.

     I will add a helper similar to genphy_c45_template_test_mode() in
     phy-c45.c in patch v6.
     
     I have a question and would appreciate your advice.As previously discussed,
     for phy8824, the page select register is in top extend reg space shared by
     four PHYS in one phy-package. Within a functional ops in phy8824 driver, 
     it is necessary to take a bus lock at the beginning and unlock the bus 
     at the end of the function, that is why many __functions are needed.For the 
     same issue, when calling genphy_c45_template_test_mode() within phy8824 ops, 
     it is also necessary to ensure that the operation within 
     genphy_c45_template_test_mode() is a __function, which is inconsistent with 
     other interfaces in phy-c45.c.
     Could you give me some suggestions on this issue?

> ---
> pw-bot: cr
