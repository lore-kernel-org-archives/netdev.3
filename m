Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2F4A8A38
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010487; cv=none; b=acMXNQHvX1vPISRXXKQ7Z743prFMeXrUy5iXe/1Gp0RhSdME4hQJC+3quyZPiizGRrr2VTnx0MiHoJedag9Qv9PcWAmGyH742taTCXnqKi10xGkQ/775ulXB7ROjlF6HEreW6dm4dSgCB2BZKqYolWMh2qNiRRo3vfTo8PEJX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010487; c=relaxed/simple;
	bh=zFcnL1EzRK+Duttihfsteq8F8gFYjg8xrl905BDOzIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMiikOMPRLVQ5zTG7vb6dXLgr9hbIIn/8vWHDxkUdL+0COCkU156jNw6q6gA2thLwr7DOf1kraWMjov9vWzdOAasPmqOZWfOzev1LELYPKW8Rm49Y5S+5pfrDsYFr+jKl9c2qY9FNWiT0tEeh9VaiaTO+viTTAW7bded8Lmc5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=OhQELcln; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="OhQELcln"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so480342085a.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792010484; x=1792615284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5O8SfMWx+gaxiOolN8z++f+zcMy7D3lElBjnymAbOc=;
        b=OhQELclnr1s673ANjuoNI5uekmQ8J64nluxnyWQg/NYJepe+JF+qEHXBxlPDaSIHFm
         GODAhzPFmUnepFtE1qSsidqoP/5Xv5BDOGc20MylGAdlKsHxCOhciiDZVrx8a+nYMe7M
         W7TgtcFqMsqSpltlPfvFFVlJQmmbIkiZqGv2f7/Mn5cjP+HqGC/iuu499YvMf3tD2LBx
         Ol4IGtUHQIxKugCjqKnaOc5OpcU/D61ign7UM8/bK4TuuNcXWgeoPfnHJF9bDj0iw3ho
         nsOof5hdhECzAFlbX5sCUWgebyeo9z8XaFVtMn5kISvVyg7kokkFmTwaWWAs3mwoAYhm
         RIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010484; x=1792615284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5O8SfMWx+gaxiOolN8z++f+zcMy7D3lElBjnymAbOc=;
        b=ON4elHY/NHnheFKrHErG51rCMYBhYKLXqazFKZOEVH0OvK2wVGSL0nfTKYm8ZdZAZw
         UquefYDCRczPVMygjngmZF7fzx0hXJb123Fa/r9usDUNkX1z0Uzz+81E/i+6NzzjnspS
         zqpxg6yOdy7WxQ3BrBmSiglYoVhHmYZ/Y4Tvb34wDLpPrs24fSwRoVMDIdgR2SM7uDEm
         2It4g0TKnFjdqjDmmyuUTqde7K+O9Tv0rcG1uNiqRs4HerLzM6sb3+oH++QS7Aoid4FF
         QjrwX4YogDoGh5gCRJroFgcx57l7920p4uMQZ1mOw/0vKJot7mjA4CiB9ffbeDET+Vmt
         E1Mg==
X-Forwarded-Encrypted: i=1; AKwUvBzl8Hwdqte24MxDix0XAgo3TDPvqVquFSxK+o6ZCVhSgPpu4Tjtpptp+25ERXojnG1qwQUqr9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWLlFY02+cVW3CZ+WWn3teKxyAMhn+w2m/V58CBW7ZPKS6u8kF
	jjArftTqAY0GMOdAIxQd3/57N61oXaweLeiyhney21/sAQ1nrGatol4pTGu1IGEa7SY=
X-Gm-Gg: AYBFou0qElf11dtUN5HZHBDGrYeJstT8Vdd53U1pNsVIax9hsL+P4iNlRI6ovkGE5HM
	OBHHlLrJ8bybdHtZ+e77kpFgNC+kSX12V69W/9SLIwParIP/ysQt+5uKI2ZfuOTrNeoFXw5uWIj
	uCiCw8fJPRW8p/xPzGy9wfcWxZao+IOQngOofJL6E8cphXtuNC0oJ/y33m71Xh0V1E5WG7R8Tft
	zpkIxWmfb1sGfRfS2FCsTS8jI2pUS01UVi28ty2peqTzDDdQZ4vTO/6QEWZ0bi26w6YaIrfiTui
	mOgzxjGLflSab1g/Ru40uGLpXwRwGHhsSPn8EG/LDZfn66ZpuZEhPBb389WgzJjnZcRUosit6Tu
	bpKDU8vTEvyOyloQU1p3rbPLb7tGgCu1pUxVWFVECdpxQkiC0xOR7HyNQ2H2xU+xNeYi0R/ND10
	QJ4pedoZE6VK0YwODNNMbRdSviQlLF03Po9KoeYYQW8GFc9dgyBjEH5RZnSufeZbpmqnIGF5o=
X-Received: by 2002:a05:620a:46a5:b0:93c:6534:d04d with SMTP id af79cd13be357-93ebd223d68mr2763397785a.35.1792010483847;
        Wed, 14 Oct 2026 13:41:23 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef4f4986dsm587339885a.2.2026.10.14.13.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 13:41:22 -0700 (PDT)
Message-ID: <4c0d9a12-6236-4bc5-949c-62a092edb0bc@riscstar.com>
Date: Wed, 14 Oct 2026 15:41:20 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: qcom: qca808x: Add regulator
 management
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Daniel Thompson <daniel@riscstar.com>, donggeunyoo.kernel@gmail.com,
 ansuelsmth@gmail.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261014172300.292324-1-elder@riscstar.com>
 <44a96544-5ed8-4bdc-8757-d7413e221f40@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <44a96544-5ed8-4bdc-8757-d7413e221f40@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/26 12:36 PM, Andrew Lunn wrote:
> On Wed, Oct 14, 2026 at 12:22:59PM -0500, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> QCA8081 appears in embedded board designs paired with GPIO controlled
>> regulators for its power rails. Add logic to allow these regulators to
>> be turned on during a probe.
>>
>> In order to avoid the complexity of tracking state for suspend with and
>> without WoL we take a tremendously simple "always-on" approach to
>> regulator management, essentially relying on BMCR_PDOWN to conserve
>> power when the phy device exists.
>>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Co-developed-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/net/phy/qcom/qca808x.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
>> index bab26e4c61408..6e2bd753257d9 100644
>> --- a/drivers/net/phy/qcom/qca808x.c
>> +++ b/drivers/net/phy/qcom/qca808x.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   
>>   #include <linux/phy.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <linux/module.h>
>>   
>>   #include "qcom.h"
>> @@ -181,15 +182,44 @@ static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
>>   		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
>>   }
>>   
>> +static int qca808x_power_on(struct phy_device *phydev)
>> +{
>> +#ifdef CONFIG_OF
> 
> Does this need to be conditional? It seems like
> devm_regulator_get_enable_optional() should return ENODEV, which you
> already handle.
> 
> Making code this like conditional makes build testing less useful,
> more combinations which need testing.

This is a really good point.

> Another option is
> 
> 	if (IS_ENABLED(CONFIG_OF)) {
> 
> 
> 	}
> 
> That at least compiles the code, and then the optimizier throws it
> away when it sees  if (0) { }

Yes I like doing it this way better.  I'll modify it
to be similar to this for v2, which I'll plan to send
tomorrow.

Thanks a lot.

					-Alex

> 
>       Andrew

