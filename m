Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701042D77F5;
	Thu, 20 Aug 2026 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787189645; cv=none; b=lsuWhO0pRY9DqPIYGNh1n+cjf9eO3sC1PYG93aU2wCokG+gvduGc6t7gPiylwR6FunpfsR6WqXer5THNhtXpGJtRYXNRn7qDnTZYPCvWj3+3yE01UnbV7mcSoK2wubF7EdbckfcYOoTtq2wJ6Mx+Vm+auYDqId1dTMxMtcoOjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787189645; c=relaxed/simple;
	bh=tdEE7CVTAhzB13nC+gkc70b10U2AegvaozZf0DBRzWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhaaiqigPYnOja7VLEP4dFevqLwunyFUVPLQDQsTgYariTqaNpE7HzMNs8SrgaHr2bFIXOvmZwV3QP++17eC8Rd1vEYRICv300Ysa9ukDFcLjETp35ROCjQMQMgw7VmaN7RM2QNUkJFPOLCR1QZ1u86Q31dvrtANn/A+NBU0aTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08150841|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.514139-0.00817239-0.477689;FP=16967221402307563280|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.irl.nAE_1787189623;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.irl.nAE_1787189623 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 20 Aug 2026 09:33:45 +0800
Message-ID: <9baf7703-3e31-413d-b95f-5175ab79c1c8@motor-comm.com>
Date: Thu, 20 Aug 2026 09:33:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net:dsa:yt922x: Add support for Motorcomm
 YT922x
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260813104137.55550-1-kyle.switch@motor-comm.com>
 <CAAXyoMP=-YXbdgCWXRbPqmQXwPuRegHSDvDm9_+hhmf9ev2CAQ@mail.gmail.com>
 <f324481e-d49c-4d6d-b5fd-8a0296f82a15@motor-comm.com>
 <944f80c0-5b0b-46ce-8e22-304b683dda60@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <944f80c0-5b0b-46ce-8e22-304b683dda60@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/17/26 21:12, Andrew Lunn wrote:
> On Mon, Aug 17, 2026 at 06:40:02PM +0800, Kyle Switch wrote:
>> On 8/17/26 05:17, David Yang wrote:
>>> On Fri, Aug 14, 2026 at 9:50 AM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>>>
>>>> @@ -148,10 +148,15 @@ static const struct yt921x_info yt921x_infos[] = {
>>>>                   YT921X_PORT_MASK_INT0_n(8),
>>>>                   YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
>>>>           },
>>>> +       {
>>>> +               "YT9224", YT9224_MAJOR, 0, 0,
>>>> +               0x1f1,
>>>> +               0x0,
>>>> +       },
>>> Why plain magic numbers here, despite what the above entries shows?
>> Ans: will fixed done in patch v2.
>>>>           {}
>>>>    };
>>>>
>>>> -#define YT921X_NAME    "yt921x"
>>>> +#define YT92XX_NAME    "yt92xx"
>>> This changed the module name which may affect end users. While I have
>>> no objection to this, subsystem maintainers may have different
>>> opinions.
>> Ans: This is used to indicate support for both YT921X and YT922X.
> It is pretty common for newer generations of devices to be mostly
> backwards compatible, with older generations. The driver does not
> change name in Linux it causes too much pointless churn. Please just
> get the names correct in the struct phy_driver.
Ans: The modifications in the next version V2 will retain the previous 
naming.
>>>> +       res = yt921x_intif_read(priv, addr, 0x0, &data);
>>>> +       if (res)
>>>> +               return res;
>>>> +       data |= 1 << 15;
>>>> +       res = yt921x_intif_write(priv, addr, 0x0, data);
>>>> +       if (res)
>>>> +               return res;
>>> Numerous magic numbers. On YT9215, same finetunes are not required for
>>> a usable port. If you cannot name it, drop it if it is not mandatory.
>> Ans: Some patches are mandatory
> If they are mandatory, why are they needed at all? Why are they not in
> the firmware. Seems like a poor hardware/firmware design to me.

Ans: In this application scenario, there is no firmware, and the eFuse

         may not be able to support so many registers.

>
>> while others are for performance optimization.
> For these, it would be good to fully document them, because board
> designers might want to optimze them in other ways.
>
>>>> -static void yt921x_mdio_remove(struct mdio_device *mdiodev)
>>>> +static void yt92xx_mdio_remove(struct mdio_device *mdiodev)
>>> Unnecessary renaming.
> And taking this to its logical conclusion...
>
> In a few years time you want to rename to yt9xxx.  And a few years
> after that, rename to ytxxxx.

Ans: Considering that the Motorcomm switch series currently all

         start with '92', and there will be driver work for other series 
in the future,

         the name was modified to 'yt92xx'. However, since it is 
uncertain whether

        there will be 'yt9xxx' in the future, the name has been reverted 
to the

        existing one for now.

>
>      Andrew
