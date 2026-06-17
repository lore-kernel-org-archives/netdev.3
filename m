Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1646B5;
	Wed, 17 Jun 2026 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663851; cv=none; b=QjykA0tN6De6gZyOtLmw/DX/Cp2um8qR7WZ3Y1m9+/YUn6FxG6NQi8t1G093KTkBq9/h2hnviBw4N/eKgYx7ZQHrE6Ll4QUq4wyRZkBMSSEaquDfd3wH3OhPQjob3OvGJopkosig2/Huz5k92YEFs50apUem0WhcpGv0NDBj2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663851; c=relaxed/simple;
	bh=ptoxcdDdOwV3Xx6iPB2mZtZA6yZbX9Dc0KBuPuyHeOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8DcI+Nyrv/4DC3pTW66k5+XdpD88D96+m+d4Jh+8X/Cx6rdyn3WZ6xNVxfxEQBluUs2OT9QWV9R2ICJAPlEwxAh5NsSGoQJozu0S9c3mbutBfnGsc3KfwScWaBlnGNeT5V0iHxBPh7LYSD3tMSF88T5kT5DNCAPHC5PT1o9jSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437074|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.148617-0.00322267-0.848161;FP=18253967789187112720|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.i-FAxEl_1781663826;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.i-FAxEl_1781663826 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 10:37:08 +0800
Message-ID: <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>
Date: Wed, 17 Jun 2026 10:37:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, de.ge@motor-comm.com
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/16/26 02:55, David Yang wrote:
> On Mon, Jun 15, 2026 at 7:12 PM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>>
>> Add yt92xx dsa driver supports yt921x and yt922x switch series.
>> To support more switch series in the future (e.g., yt923x), the most common configurations are abstracted into switch operation interfaces, due to yt921x and yt922x share similar register layouts and operational logic.
> 
> You are blindly plugging existing code into your SDK, without sorting
> out register operations (for example in set_mac_eee and
> port_change_mtu).
> 
> Do not post code you don't understand. Ask if you are not sure.

Ans: Thank you for your suggestion. I will recheck the code logic again in the future.

> 
>> +#define CMM_PARAM_CHK(expr, err_code)    \
>> +       do {                             \
>> +               if ((u32)(expr)) {       \
>> +                       return err_code; \
>> +               }                        \
>> +       } while (0)
>> +
>> +#define CMM_ERR_CHK(op, ret)           \
>> +       do {                           \
>> +               ret = (op);            \
>> +               if (ret != CMM_ERR_OK) \
>> +                       return ret;    \
>> +       } while (0)
> 
> Do not use macros like this.

Ans: Acknowledged, i will consider how to optimize them in the future.

> 
>> +#define GET_FIELD(value, low_bit, width) \
>> +       (((value) >> (low_bit)) & ((1U << (width)) - 1))
>> +#define CLR_FIELD(value, low_bit, width) \
>> +       ((value) & (~(((1U << (width)) - 1) << (low_bit))))
>> +
>> +#define HAL_FIELD_SET(low_bit, width, entry, data)                    \
>> +       do {                                                          \
>> +               *(entry) &= (~(((1UL << (width)) - 1) << (low_bit))); \
>> +               *(entry) |= ((data) << (low_bit));                    \
>> +       } while (0)
>> +
>> +#define HAL_FIELD_GET(low_bit, width, entry, pdata) \
>> +       (*(pdata) = (((*(entry)) >> (low_bit)) & ((1UL << (width)) - 1)))
> 
> FIELD_PREP() and FIELD_GET().
> 
>> +/*
>> + * Macro Definition
>> + */
>> +#ifndef NULL
>> +#define NULL 0
>> +#endif
>> +
>> +#ifndef FALSE
>> +#define FALSE 0
>> +#endif
>> +
>> +#ifndef TRUE
>> +#define TRUE 1
>> +#endif
> 
> Nonsense.

Ans: Acknowledge, will be fixed later.

> 
>> +       /* Print chipid here since we are interested in lower 16 bits */
>> +       dev_info(dev,
>> +                "Motorcomm %s ethernet switch.\n",
>> +                info->name);
> 
> Stop copy-n-paste.

Ans: Sry for this, i will recheck the code to make sure each line of comments and code
meaningful again.

> 
> Please, start with a minimal patch that only marks functions which use
> different registers/procedures and makes them virtual, and implement
> them for yt922x in the future.
> 
>> +       {
>> +               .compatible = "motorcomm,yt9215,8bytes",
>> +               .data = &yt92xx_chip_info[YT9215_8B],
>> +       },
> 
> Do not change devicetree compatible strings.

Ans: agreed, this will be fixed later.

> 
>> --- a/include/uapi/linux/if_ether.h
>> +++ b/include/uapi/linux/if_ether.h
>> @@ -118,7 +118,7 @@
>>  #define ETH_P_QINQ1    0x9100          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
>>  #define ETH_P_QINQ2    0x9200          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
>>  #define ETH_P_QINQ3    0x9300          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
>> -#define ETH_P_YT921X   0x9988          /* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>> +#define ETH_P_YT92XX   0x9988          /* Motorcomm YT92xx DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>>  #define ETH_P_EDSA     0xDADA          /* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>>  #define ETH_P_DSA_8021Q        0xDADB          /* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>>  #define ETH_P_DSA_A5PSW        0xE001          /* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
> 
> UAPI stands for User-space API. Do not change it unless there is a
> very very good reason.
> 

Ans: The default tpid both yt921x and yt922x is 0x9988. I have modified this to 
allow for simultaneous use in both yt922x and yt921x scenarios.

>> +/* To define the from cpu tag format 8 bytes:
>> + *
>> + * 0 1 2 3 4 5 6 7 | 0 1 2 3 4 5 6 7
>> + *|<----------TPID 0x9988---------->|
>> + *|<--RESERVE-->|<-----DST PORT---->|
>> + *|-|<---------RESERVE------------->|
>> + *|<------------------------------->|
>> + */
>> +#define YT922X_TAG_FORMAT2_NAME "yt922x-8b"
>> +#define YT922X_FORMAT2_TAG_LEN                  8
>> +#define YT922X_PKT_TYPE          GENMASK(15, 14)
>> +#define YT922X_8B_CPUTAG_PKT_FROM_CPU      0x1
>> +#define YT922X_8B_CPUTAG_SRC_PORT          GENMASK(6, 2)
>> +#define YT922X_8B_CPUTAG_DST_PORTMASK      GENMASK(8, 0)
>> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0      BIT(15)
>> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0_EN      0x1
>> +#define YT922X_8B_CPUTAG_FORCE_DST         BIT(9)
>> +#define YT922X_8B_CPUTAG_FORCE_DST_EN      0x1
> 
> If yt922x tag format shares no common with yt921x, make a new tag driver.

Ans: thank you for your suggestion, we will consider whether to create a new driver in the new file.

> 
>> +static struct dsa_tag_driver *dsa_tag_driver_array[] = {
>> +       &DSA_TAG_DRIVER_NAME(yt921x_netdev_ops),
>> +       &DSA_TAG_DRIVER_NAME(yt922x_4b_netdev_ops),
>> +       &DSA_TAG_DRIVER_NAME(yt922x_8b_netdev_ops),
>> +};
> 
> If both are supported by the chip and 4b does nothing more than 8b
> does, do not bother with it.

Ans: 4b and 8b dsa tag may have different application scenarios. from my opinion,
     1. 4b dsa tag can save 4 bytes of payload
     2. 8b dsa tag carry more package info.

