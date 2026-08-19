Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374D4A33EA
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163375; cv=pass; b=P+D3OvkF3D1WWKGGDXWVr7VxP2DW2luXXUMeoWY3VGwvJaVbLbVWTpjnpNYyefpkAYJfsZlAgTpwVbh7Oy3oIiek6GwrT//WdL5yc4Lq8ElNr7icssjN07Eczo57ZKi78nFLvqiOxTMKRNiXdeDlCttVOPdV9ihFU97blENTDgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163375; c=relaxed/simple;
	bh=RHvtIXVLObXg2R4dIkl5iwaautUJ/oda7ODGFJ+9jsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgsDyTmy3R/rDyupJerY9UfV76/RFlkzOrT6e136zTJZkM8PcP1wgQ/kov3/Wln8SbhiLG9RVnFN8BqJXmfiLhUpY8mLkMvfSd6zCF8G7FxuVEb9HuB2wFNaVfPP+W2ovJ0yIK51gnQCS09tQWaPNejb1vp2MefMWJIKNB0Aaqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PCkxEHR2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sitWV7mQ; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PCkxEHR2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sitWV7mQ"
ARC-Seal: i=1; a=rsa-sha256; t=1787163343; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WDNz3eVYmJPImPTrmlqvzEWmbtPhWpssOdqyf8/kehfxuRZs3k16kvNq3dQ8vNvsyR
    B0VbCKtTk9qqoMu4t0hRftZgIySFirsv4e79lddGNcH3CJkhQknohDqUIiP82mQkPdvY
    MjPA/Dl18qb/mUhAYAzjKQtRJPrXMy6wCPw6LMny8oi7SV0e2xHKVzhri4iqYfKXncAY
    WY8ZRpPJPKD6rYg9kc25tyFiRB81u8Q1O5CPxlE1ftZWBo4oLfzJtVbWvEGGhbn3twmo
    Gus2aFgIbMJ6pOnBefKTjxV6VL99RtMrUSxIGj4tpT7g1YNx/Ow6xCMwpb4fEz0u/i3C
    /d8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787163343;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2rNnoD2U4jqwxhPp/3LdaUjoEqmrVR+dPO0eYLF0GIg=;
    b=sw+Q4kUXl/DQUBDO8OaCOOOwmTC4fKRYqeYovQJrVmr6fwyVnUIpCQIoIig9NLsc1y
    XX18nWoOqtlpupEZfQ4VDvBPb/MpMCZRsiEBJ1uL/E6WLPHj2chceTqIKY+T8KLcBvCt
    iLUrzvkbintc+4dxfv3ZUeJtmzCHhUaRXw6/ivTuJH6QcQM93Xzdjwl/WoFpjnJTgSoO
    EKFetgzum6W+JtWjPLuW25PAuA8V9ER+pBppSR5jo5S8tOXS3BeeOXDKEzs2QdrXU3DU
    BXS64YivpmEBv2Okm+vxROqeFHI6GPIBheyA1PlcSM5yFi7r60RGNPIMVR99dWaosvKY
    RAwQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787163343;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2rNnoD2U4jqwxhPp/3LdaUjoEqmrVR+dPO0eYLF0GIg=;
    b=PCkxEHR2dBXMklXVkanksTo9LrrJQV2ZDMkyGtyYZAgOGkz9LTBWkPhQQ7fsSElSjS
    urIkalcNMB/0kPlhZzrNCBoQE+tMB/z7gF18TkbDJdrTM0ShvzdUa6I21wddM/v3gFe9
    haL8Q77hhLR5UX0RkO3gxb3prUJ4HaimVMKQ0bpys8VSF2FaO0ugi+9uXa7QlNoP7HW5
    65zMCJTYG0PsZAaXbMgVg6F9lpXsuR7aWCqpkz796LMkft777IWMIZkRRY1jY2vgyGvv
    tehzRd0m8RV6sd9QrM454PTmhTPA17I/HAajK6PSf8sfRlD5+kLw5r/6oHstnfs7vZje
    SgTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787163343;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2rNnoD2U4jqwxhPp/3LdaUjoEqmrVR+dPO0eYLF0GIg=;
    b=sitWV7mQ3XY+Fy9FLC2UtsxipVjaQGp9WD+0in52XEUDbNhNo6xgS9Qbsn5YniOR50
    0lJGgGfkv7FrwDwKWmCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727JIFgMtZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 19 Aug 2026 20:15:42 +0200 (CEST)
Message-ID: <15ea29f5-7154-4bf9-baff-88f4b6477722@hartkopp.net>
Date: Wed, 19 Aug 2026 20:15:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
To: Hangbin Liu <hangbin.liu@linux.dev>, Jiale Yao <yaojiale02@163.com>,
 Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexandra Winter <wintera@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net> <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net> <aoVzaHfKWG-_OJOY@fedora>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aoVzaHfKWG-_OJOY@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hangbin, all,

thanks for your feedback!

In fact checking for dev->ml_priv != NULL seems to be too hard and would 
likely create some breaking setups.

I have sent a patch on the Linux-CAN ML that makes the CAN subsystem 
robust against alien ARPHRD_CAN interfaces that might be created by 
TUN/TAP via TUNSETLINK ioctl:

https://lore.kernel.org/linux-can/20260819160822.8256-1-socketcan@hartkopp.net/

The other question remains how to make bonding/team keep the fingers 
away from incompatible net devices.

The current black listing approach from Jiale Yao (using a unified 
helper as suggested by Jiri Pirko) seems to be the best way to go now:

https://lore.kernel.org/netdev/20260728151240.89434-1-yaojiale02@163.com/

+		if (port_dev->type == ARPHRD_CAN ||
+		    port_dev->type == ARPHRD_IEEE802154 ||
+		    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
+			NL_SET_ERR_MSG(extack,
+				       "CAN and IEEE 802.15.4 devices can't be added as a team port");
+			netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These device 
types can't be added as a team port\n",
+				   portname);
+			return -EINVAL;
+		}
+	}
+

There might be other dev->types (e.g. ARPHRD_ARCNET) or a future white 
list approach this unified helper could support. For either team and 
bonding!

@Jiale Yao: What would be a good name for such helper in 
include/linux/if_arp.h ?

dev_is_not_ether_compatible(const struct net_device *dev)
dev_is_ether_compatible(const struct net_device *dev)
dev_has_special_l2_proto(const struct net_device *dev)
dev_has_l2_proto(const struct net_device *dev)
dev_is_pure_packet_bus(const struct net_device *dev)

or something like this?

Best regards,
Oliver

ps. independently of these two patches I would suggest to implement 
proper user assignments for ml_priv users using netdev_get_ml_priv() and 
netdev_set_ml_priv() as we have for CAN, e.g.

enum netdev_ml_priv_type {
	ML_PRIV_NONE,
	ML_PRIV_CAN,
	ML_PRIV_QETH,
	ML_PRIV_CXGB2,
	ML_PRIV_I82596,
}

On 19.08.26 11:12, Hangbin Liu wrote:
> Hi Oliver,
> On Tue, Aug 18, 2026 at 03:25:36PM +0200, Oliver Hartkopp wrote:
>> Hi Hangbin,
>>> Hi Oliver,
>>>
>>> Sashiko gives some feed back[1], would you please check it?
>>>
>>> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815153938.187073-1-socketcan%40hartkopp.net
>>>
>>
>> Unfortunately the AI bot review did not create a proper answer, so that I
>> would be able to answer in-line.
> 
> Thanks for your reply.
> 
>>
>> Sashiko says:
>>
>> "Is this test too broad for plain Ethernet slaves?
>> netdev_has_ml_priv() only looks at dev->ml_priv, not at dev->ml_priv_type,
>> so it matches any driver that stashes a private pointer there, including
>> ARPHRD_ETHER NICs that were never involved in the CAN crash."
>>
>> and later also points out potential problems that could arise with tun.
>>
>> Today only the CAN subsystem properly sets dev->ml_priv_type. Other users
>> simply grab dev->ml_priv for their needs (inkognito).
> 
> Yes
> 
>>
>> To me the question is whether bonding/teaming and now also tunneling code
>> takes care about the mid-layer private pointer dev->ml_priv?!?
> 
> AFAIK, no.
> 
>>
>> The fact that the issues have been found by syzbot for CAN devices might be
>> through to the fact that the virtual CAN interface (vcan) can be created by
>> netlink commands and can be easily used in test setups.
>>
>> So what would happen, if the same tests with bonding/teaming/tunneling would
>> be done with real hardware drivers as the mentioned "direct ml_priv writers
>> still in tree at this revision:
>>
>>    drivers/s390/net/qeth_core_main.c:qeth_alloc_netdev()
>>        dev->ml_priv = card;
>>    drivers/net/ethernet/chelsio/cxgb/cxgb2.c:init_one()
>>        netdev->ml_priv = adapter;
>>    drivers/net/wan/hdlc_fr.c:fr_add_pvc()
>>        dev->ml_priv = pvc;
>>
>> plus drivers/net/ethernet/i825xx/82596.c, drivers/s390/net/ctcm_main.c,
>> the libertas main.c/mesh.c paths and
>> drivers/net/wireless/microchip/wilc1000/netdev.c."
>>
>> ??
> 
> I'm not worry about cxgb2 or 82596, which are too old. But s390 qeth is
> still actively maintained (Cc the maintainers). Can we block them directly?
> 
>>
>> If bonding/teaming/tunneling might accidentally overwrite dev->ml_priv we
>> have to block all those devices. No matter if it is CAN or whatever ethernet
>> device.
> 
> How would bonding modify dev->ml_priv?
> 
>>
>> And this it what this patch aims for.
>>
>> So either the users were lucky so far or they never used
>> bonding/teaming/tunneling on these devices? I don't know.
>>
>> But it definitely looks like we should make a safe move to block all ml_priv
>> using devices.
>>
>> Most of the referenced drivers are 20+ years old! Only
>> drivers/net/wireless/microchip/wilc1000/netdev.c is about 11 years old and
>> moved from staging into mainline in 2020. The use of ml_priv is a left-over
>> from the former out out tree development. The wilc1000 drivers does not use
>> the existing infrastructure in the correct way. In all cases this wifi
>> driver and all the ancient ethernet drivers should (and can) be implemented
>> without using the ml_priv pointer today.
>>
>> When there are (unlikely) real users of those (ancient) drivers together
>> with bonding/teaming/tunneling those drivers should be changed in a way that
>> they do not need dev->ml_priv anymore.
> 
> No need to fix the ancient driver at present.
> 
> Thanks
> Hangbin
> 

