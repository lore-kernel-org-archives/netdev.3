Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A52EF67A;
	Wed, 17 Jun 2026 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781664100; cv=none; b=XI0T+JO4EPZere4AV758wBZBQ6GqJ4vvGwwECKtn7Kw1eh8GsQRSMlhLwb3VEQlnZGUmTlEYYujLimt1I94xiOIRpzqFIuTwk/KIXM/cza4Z9255Tlilghcybho1uFG9tg09lFdDEj9rhOSuflzEpA8AjUCODkHfJAZ7IjbeqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781664100; c=relaxed/simple;
	bh=RCEaZstgGigHVXUhy5obX9wbxQ/70GfZufDSzHa8hPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl1NvAG3xBTye9FXDY0czTAvp5Peje6VId6mSoyda7/KUw3Fz5w7yjr1YxGB1vaRfvSSUeflOPKf3IVvunR0ITNF4wTgd7i0t2gQPQhDY5Idinu+/q8czkg0xFuM46aaF9sTeOVHNgwm4g+tXNsZ9ClkEEG+AOYnxc4eXBNFjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1270697|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0316465-0.000470398-0.967883;FP=11662652842634243728|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.i-EXH0W_1781664085;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.i-EXH0W_1781664085 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 10:41:29 +0800
Message-ID: <89ca7f16-4528-4dfa-8b08-3eb7a0a65057@motor-comm.com>
Date: Wed, 17 Jun 2026 10:41:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Julian Braha <julianbraha@gmail.com>, mmyangfl@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, de.ge@motor-comm.com
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <eeacfa0d-9303-407f-8e8a-ecc95d1ab1c8@gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <eeacfa0d-9303-407f-8e8a-ecc95d1ab1c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/15/26 23:01, Julian Braha wrote:
> Hi Kyle,
> 
> On 6/15/26 12:12, Kyle Switch wrote:
> 
>> diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
>> new file mode 100644
>> index 000000000000..f40d75e2a3f2
>> --- /dev/null
>> +++ b/drivers/net/dsa/motorcomm/Kconfig
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config MOTORCOMM
>> +	tristate "Motorcomm YT92XX switch family support"
>> +	depends on NET_DSA
>> +	select FIXED_PHY
>> +	help
>> +	  This driver adds support for Motorcomm switch chips. It supports
>> +	  YT921X and YT922X switch.
>> +
>> +choice
>> +	prompt "Motorcomm switch series selection"
>> +	depends on MOTORCOMM
>> +
>> +config MOTORCOMM_YT921X
>> +	bool "Motorcomm YT921X series."
>> +
>> +config MOTORCOMM_YT922X
>> +	bool "Motorcomm YT922X series."
>> +endchoice
>> +
>> +config NET_DSA_MOTORCOMM
>> +	tristate "Motorcomm YT92XX switch DSA driver"
>> +	depends on MOTORCOMM
>> +	depends on (MOTORCOMM_YT921X || MOTORCOMM_YT922X)
>> +	select NET_DSA_TAG_MOTORCOMM
>> +	select NET_IEEE8021Q_HELPERS if DCB
>> +	help
>> +	  Select to enable support for Motorcomm driver.
>> +
>> diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
> NET_DSA_MOTORCOMM already depends on:
> (MOTORCOMM_YT921X || MOTORCOMM_YT922X)
> with both of those options depending on MOTORCOMM due to the 'choice'
> that they're in, so this additional dependency on MOTORCOMM is
> unnecessary.
> 
> You could also consider using a comment to document that this option is
> depended on indirectly.

Ans: agreed, i will fix this later.
> 
> - Julian Braha
