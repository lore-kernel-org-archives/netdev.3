Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6C30566F;
	Mon, 20 Jul 2026 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537464; cv=none; b=pnwYx91gWCoJc4+Mn6vrNaP/OGj/oGQDbqilFwjz+jxhdi94s9rzjBRtTASkzTBV8m81pDJI0erytNXYSBjVefRdyYyPsMNYDuIaCYPC3qUdL7L3KofFFoF1FDE95p9ZiRKMN0ZTrefx5hhdgGnSisujA0PoFEswEOtP/fY9iJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537464; c=relaxed/simple;
	bh=IV38NQPivX+pwEdrZJkR29WonwCRC4QSYi6DUtVE6A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbDI5CNXz8nUyzoApdNse3zycjy3cDzICs+1ofzrJJ74HvXGJ1cYK0LkGFLCjsZIT6Xt3XR8SBden4C7l56ixqcRa0Hfmf0RLmEy9pfJzNU5CVFwUX8JlsRi+hQCDkTK9MlrF7DmOxWPhwQ+KQI/ptcbUbvVmqW+JUCBMn/RKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0823063|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0490074-0.000468963-0.950524;FP=16858052017944915779|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.iQ-lUL9_1784537116;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iQ-lUL9_1784537116 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 20 Jul 2026 16:45:19 +0800
Message-ID: <73339722-f283-4418-9d18-e80a1bd31efb@motor-comm.com>
Date: Mon, 20 Jul 2026 16:45:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Sae@motor-comm.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260717054807.1321374-1-kyle.switch@motor-comm.com>
 <6264d655-640e-47ec-9521-5e292bfeaba6@kernel.org>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <6264d655-640e-47ec-9521-5e292bfeaba6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/26 04:19, Krzysztof Kozlowski wrote:
> On 17/07/2026 07:48, Kyle Switch wrote:
>> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
>> 2.5G/1000M/100M/10M speed.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> 
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument, so you will
> not CC people just because they made one commit years ago). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 

Ans: Thank you for your support. The warning and error code formats 
will be fixed in the following patches according to this procedure.

>> ---
>>
>> changes in v3:
>> 1. Using common apis defined in phy_package.c to handle shared top
>> extend register space.
>> 2. Add dts demo in motorcomm,yt8xxx.yaml.
>> 3. Fix unnecessary redundant judgments.
>> 4. Fix BMCR registers operation using magic number.
>> 5. Rename funtion based on its approximate functionality.
>>
>> changes in v2:
>> 1. Remove duplicate code and replace it with existing api. 
>>
>>  .../bindings/net/motorcomm,yt8xxx.yaml        |   30 +
>>  drivers/net/phy/motorcomm.c                   | 1808 ++++++++++++++++-
>>  2 files changed, 1750 insertions(+), 88 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> index 26688e2302ea..e7592468f658 100644
>> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> @@ -149,3 +149,33 @@ examples:
>>              motorcomm,auto-sleep-disabled;
>>          };
>>      };
>> +  - |
>> +    mdio {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
> 
> I don't understand why you are doing this. Anyway, please read the
> documents I linked and maybe there is some explanation for that change.

Ans: the bind changes will be removed in patch v4, and updated in another
patch thread.

> 
> Best regards,
> Krzysztof
