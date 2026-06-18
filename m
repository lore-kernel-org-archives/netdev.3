Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561593B42FD;
	Thu, 18 Jun 2026 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776418; cv=none; b=TnjU89Q1f6BlJFiFqelii8NunWgsM6htI0eb3kDrKtTG+S/GaqAmvb37bv2QdIyXYXd/AaIgtgckL5rHbkj+AU/Mhh3iUNz3Dkg6uugp5EqCFYrIdkos97Qtk7KS4ccc9bA9BQapMKqhrLEL4osEEeGhFqUQ6K+EZD21eAHvF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776418; c=relaxed/simple;
	bh=Vz/dZjKUZasnqNd9KQqcENehbg4ztlKMtSEgakO/fgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3JgzLBL72z20ysE2rnBwaFtlTFZippANaGnUdvGDEZsEi6WTgkxr/hAoeqkbnLV1faL8gNZpEWxXh1fQNEBOrgcXj8QzxMrzZiRwoxeyMaSH0Ueh4ycanEvvKRaPz+dI5pTmzFwF7NlbmUXoDNjVt+HAuz70LnE+sKaAlK3u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437288|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00822537-1.90833e-05-0.991756;FP=17138197129658605076|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.i.dsHQ6_1781776400;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.i.dsHQ6_1781776400 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:53:26 +0800
Message-ID: <39b79f5b-3e13-4620-83ba-b2ef991acca9@motor-comm.com>
Date: Thu, 18 Jun 2026 17:53:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, de.ge@motor-comm.com
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
 <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>
 <a689a734-bfd2-4e8f-85dd-9ae210b3161a@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <a689a734-bfd2-4e8f-85dd-9ae210b3161a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/17/26 17:07, Andrew Lunn wrote:
>>>> +#define CMM_PARAM_CHK(expr, err_code)    \
>>>> +       do {                             \
>>>> +               if ((u32)(expr)) {       \
>>>> +                       return err_code; \
>>>> +               }                        \
>>>> +       } while (0)
>>>> +
>>>> +#define CMM_ERR_CHK(op, ret)           \
>>>> +       do {                           \
>>>> +               ret = (op);            \
>>>> +               if (ret != CMM_ERR_OK) \
>>>> +                       return ret;    \
>>>> +       } while (0)
>>>
>>> Do not use macros like this.
>>
>> Ans: Acknowledged, i will consider how to optimize them in the future.
> 
> It is not about optimization. Hiding a return statement in a macro is
> very bad style. It will lead to locking bugs, and resource leaks,
> because nobody knows the return is there.
> 

Ans: This issue will be fixed before the next patch is sent.

>>>> +/*
>>>> + * Macro Definition
>>>> + */
>>>> +#ifndef NULL
>>>> +#define NULL 0
>>>> +#endif
>>>> +
>>>> +#ifndef FALSE
>>>> +#define FALSE 0
>>>> +#endif
>>>> +
>>>> +#ifndef TRUE
>>>> +#define TRUE 1
>>>> +#endif
>>>
>>> Nonsense.
>>
>> Ans: Acknowledge, will be fixed later.
> 
> No. They will be fixed now.
> 

Ans: This issue will be fixed before the next patch is sent.

>>>> +       /* Print chipid here since we are interested in lower 16 bits */
>>>> +       dev_info(dev,
>>>> +                "Motorcomm %s ethernet switch.\n",
>>>> +                info->name);
>>>
>>> Stop copy-n-paste.
>>
>> Ans: Sry for this, i will recheck the code to make sure each line of comments and code
>> meaningful again.
> 
> Also, consider the comments. Do the comments add anything useful which
> is not already obvious from the code. Comments should be about "Why?".
> 
>>>> --- a/include/uapi/linux/if_ether.h
>>>> +++ b/include/uapi/linux/if_ether.h
>>>> @@ -118,7 +118,7 @@
>>>>  #define ETH_P_QINQ1    0x9100          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>>  #define ETH_P_QINQ2    0x9200          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>>  #define ETH_P_QINQ3    0x9300          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>> -#define ETH_P_YT921X   0x9988          /* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>> +#define ETH_P_YT92XX   0x9988          /* Motorcomm YT92xx DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>>  #define ETH_P_EDSA     0xDADA          /* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>>  #define ETH_P_DSA_8021Q        0xDADB          /* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>>  #define ETH_P_DSA_A5PSW        0xE001          /* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
>>>
>>> UAPI stands for User-space API. Do not change it unless there is a
>>> very very good reason.
>>>
>>
>> Ans: The default tpid both yt921x and yt922x is 0x9988. I have modified this to 
>> allow for simultaneous use in both yt922x and yt921x scenarios.
> 
> As pointed out, this is UAPI. Any changes to this file need a good
> explanation how it does not change the user API. Do this break
> backwards compatibility with user space applications? Maybe tcpdump or
> wireshark has a dissector which expects ETH_P_YT921X and you have just
> broken it?
> 

Ans:Now I have a better understanding of the role of the UAPI representative. 
If a new dsa driver is added in the subsequent patch, consider adding one instead of modifying the original content.

>>>> +#define YT922X_TAG_FORMAT2_NAME "yt922x-8b"
>>>> +#define YT922X_FORMAT2_TAG_LEN                  8
>>>> +#define YT922X_PKT_TYPE          GENMASK(15, 14)
>>>> +#define YT922X_8B_CPUTAG_PKT_FROM_CPU      0x1
>>>> +#define YT922X_8B_CPUTAG_SRC_PORT          GENMASK(6, 2)
>>>> +#define YT922X_8B_CPUTAG_DST_PORTMASK      GENMASK(8, 0)
>>>> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0      BIT(15)
>>>> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0_EN      0x1
>>>> +#define YT922X_8B_CPUTAG_FORCE_DST         BIT(9)
>>>> +#define YT922X_8B_CPUTAG_FORCE_DST_EN      0x1
>>>
>>> If yt922x tag format shares no common with yt921x, make a new tag driver.
>>
>> Ans: thank you for your suggestion, we will consider whether to create a new driver in the new file.
> 
> When you look at other tag drivers, you will also notice some drivers
> implement two taggers in one file. So consider this if there is any
> shared code.
> 

Ans: ok, the tag driver will refer to the methods of other existing tag drivers.

>>>> +static struct dsa_tag_driver *dsa_tag_driver_array[] = {
>>>> +       &DSA_TAG_DRIVER_NAME(yt921x_netdev_ops),
>>>> +       &DSA_TAG_DRIVER_NAME(yt922x_4b_netdev_ops),
>>>> +       &DSA_TAG_DRIVER_NAME(yt922x_8b_netdev_ops),
>>>> +};
>>>
>>> If both are supported by the chip and 4b does nothing more than 8b
>>> does, do not bother with it.
>>
>> Ans: 4b and 8b dsa tag may have different application scenarios. from my opinion,
>>      1. 4b dsa tag can save 4 bytes of payload
>>      2. 8b dsa tag carry more package info.
> 
> How do you plan to swap between the different formats?
> 
> The user perspective is that the machine has a collection of interface
> which are used just as normal, using Linux tools likes like
> iproute2. If the user enables a feature which requires the 8b tag
> format, will you change the format from the DSA driver? And swap back
> to the 4 byte format when the feature is no longer needed?
> 

Ans: After considering your and David's comments and suggestion, we will broken this patch into lots of
small patches which just include 8bytes tag driver for now.
If the 4bytes tag driver scenario is required later, we will use "change_tag_protocol" mechanism from DSA driver.

As you mentioned "One thing i need to point out. Linux has a long tradition of not
replacing existing code with a new implementation. You take the existing code and step by step improve it. " in another mail before.
I want to explain the patch in more detail.

Step 1. We do not attempt to remove the existing driver implementation, and don't change the behavior of existing software,
we will retain the implementation of the existing driver software layer, but encapsulate the use of hardware operations into 
functional interfaces. The advantage of this is that it is easy to maintain and easy to support other motorcomm switch series.

for example: vlan add ops in dsa driver:

Existing code:

yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
{
 u64 mask64;
 u64 ctrl64;

 mask64 = YT921X_VLAN_CTRL_PORTn(port) |
   YT921X_VLAN_CTRL_PORTS(priv->cpu_ports_mask);
 ctrl64 = mask64;

 mask64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
 if (untagged)
  ctrl64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);

 return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
     mask64, ctrl64);
}

after patch:

yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
{
 struct yt_port_mask member;
 struct yt_port_mask untag;

 member.portsbits[0] = BIT(port) | priv->cpu_ports_mask;
 if (untagged)
  untag.portbits[0] = BIT(port);

  return yt_vlan_port_set(priv->unit, vid, member, untag);  // Here we use encapsulated interfaces to complete the hardware configuration. 
							     // We can ignore the differences between different motorcomm series, which will be reflected in driver/net/dsa/motorocmm/switch/yt_vlan. c
}

Step 2. if Step 1 is accepted, later, the plan may be to replace the hardware configuration involved in the existing dsa driver 
with the encapsulated interface step by step according to the functional module such as vlan, mirror, lag, etc. Finally, upload the yt922x dsa driver.

> 	Andrew
