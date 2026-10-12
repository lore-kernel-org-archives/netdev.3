Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76A48CD41
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808909; cv=pass; b=XNHS0Y7p56csYZNbOTOVFzGgLpzbK1eN8mJsoZtxCjdkPJyfeH6IH99bNL9I41Y4IzCk5CEFy71OMb+sJ7uPItO2a7UmOPfKp++MThFj9lrn1KwzOEHh8dUbMF+m8JIfcGa8yIKCKnTsCnLSu1eUZyeeHFIsGSvvekJPWvWIwKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808909; c=relaxed/simple;
	bh=ivqNPVXL7OqIZDuLsVmeCbMqASDvzUWEXRb/AaR+vTE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=azGAcDOrQVQrwSBwU2PnNDb1MyClUyV4pg/pJ1a9DHl6U86ngZo5f91AqX8dwUQ2+7LtgFrS4/1QnNEn1CzsHOXXkX6A3nz68A+k1HrjeenYPZfO3ts3Nrqj99krO4eUtadV4ml3+dvkfNsqeE9HI/DCH0ooH2cfkQQtf1/o/oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=p/VJQl4B; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bsosk5bD; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="p/VJQl4B";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bsosk5bD"
ARC-Seal: i=1; a=rsa-sha256; t=1791808889; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lyPn5Ydtz2Ahq52hdova4GmiTobJm3d2g1eTqtOodtw8T3SzF0JeIcoqVRGo5MC3VK
    GUKKN8zF1kQpwb3xXnGQaJxl96HvOypKAJX/kS1xzWzlkDJ9KDT65zeMpUDzym93YXIs
    6RfCCzs8i6mLu4qoPNY/B5189AwvC69NET/IGiz1v7/ORLYJOshKj5NFFcB+0McQ+I8s
    0VR8iXRE3F42FWBuAdgKpUzqXWI+4CqRasCLAGwO9Y3svvsU0ivWxaBIRxMqwy8kZaBc
    4n6KWRKSrJa6E/4O43zBufBjamtDnpUFihCJIuqK3oFgEr0UAEJbyyZP3GQFJyMCzplY
    EJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791808889;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=StUrXaRC7D4BdiUXCth7tTCik81EUIu96LhGMmEPtfY=;
    b=Ni4W7c3Dxn0Pzv8w8UBF5TlbuP7j99uSIwNNQtGTjdISFpbLGFXl3T6QHZkiyKda6D
    jvIU6osfdNyivW6z7APgVPLq2T+8ghHwo06j8AxWCHx/O2cSEDqDqRP23+A6f538cnZl
    MC2tgl8TxgdJg+XhVWLcVrObKxp2tC/ktNvCSc0OlPiy3lpfAZchVQyKwuCGai8WzH1w
    NIBXBEjx10dsCsS46hbT5NwVf96KgLLepb75memoG5K8kc68aCWZihWhX95ILR65j8Ks
    Bm1KtUoNxwIEANu+G4optK/kYolpsmDmXjJtRkHInxpsEGRK9fADYiyFW3YVF2Gp8WHO
    GzKg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791808889;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=StUrXaRC7D4BdiUXCth7tTCik81EUIu96LhGMmEPtfY=;
    b=p/VJQl4B1V/3FIsnwQECK3+t8pvlGvwS22JFz5CaTwxjc30/8L5MEKNkXnrP4Y4bv+
    PCC4ueqjcn8BKb/iqN5gmzJC4oBZxoQ/7qzfaaAf4eZa8mEdCoDdjCItsly5YhBvv77L
    BytPU+HbEF18NLK7e3fYOBU2yPUdPUOGwZAWGI4LmceYpZSfsGHo+IwIQWc9omjpxrTk
    pqBiq4WKgr7uBGVijNi2Uu9uB7rSnpy842E7tsSX6cz73CtLQBUWEm8VNffj0Ka5lU1x
    NSNs1CS1sYW1x8CmtP/xP2nRxwxfqo73HDhmK84tNN4EEFOBTtUVUv/n+aGNJLr0X6q3
    VRJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791808889;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=StUrXaRC7D4BdiUXCth7tTCik81EUIu96LhGMmEPtfY=;
    b=bsosk5bD+gOhiKk5ib8o7uPEe2AyVDfGzlJcJsIUbIGsDNjWc32rxow2UbNpUwVh1r
    qwyaK77mgmu4kWnMmsAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a29CCfSfWD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Oct 2026 14:41:28 +0200 (CEST)
Message-ID: <3050c887-a9cb-491d-816c-0d7b6384923c@hartkopp.net>
Date: Mon, 12 Oct 2026 14:41:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Hangbin Liu <hangbin.liu@linux.dev>, Jiale Yao <yaojiale02@163.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
 Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh <jv@jvosburgh.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aswin Karuvally <aswin@linux.ibm.com>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net> <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net> <aoVzaHfKWG-_OJOY@fedora>
 <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
 <9e3e44ac-8725-4372-af4b-e5092c8a3810@hartkopp.net> <aoet6aHyJI5lGNOX@fedora>
 <6001bd73-ef68-4820-8371-a22775fb820a@hartkopp.net>
Content-Language: en-US
In-Reply-To: <6001bd73-ef68-4820-8371-a22775fb820a@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21.08.26 13:17, Oliver Hartkopp wrote:
> On 21.08.26 03:46, Hangbin Liu wrote:
> 
>>> This caused a problem on CAN devices that were not created by the CAN 
>>> driver
>>> infrastructure (creating proper ml_priv content). When TUN/TAP set the
>>> dev->type of an ethernet device to ARPHRD_CAN the CAN ml_priv is NULL 
>>> (not
>>> initialized).
>>
>> I don't know why a user change the tun/tap dev->type to CAN. Can they 
>> work
>> together? If it's a miss config, I think we can just leave it since we 
>> already
>> block CAN slave.
> 
> Correct. We currently block ARPHRD_CAN in bond_main.c
> 
>>> Not sure if collecting a bunch of ARPHRD values is the right approach or
>>> whether team/bonding should check required features and settings 
>>> (like IFF
>>> flags, e.g. IFF_ARP or specific address length)?
>>
>> Bond supports none arp devices. It also supports infiniband devices. 
>> So we
>> can't check it with IFF_ARP or address length.
>>
>>  From my perspective, we can keep the existing check as it only causes 
>> issues
>> with CAN devices. We can work out a better solution if more incompatible
>> devices are found under bond/team.
> 
> I've checked some whitelisting ideas for bond and team which did not 
> really work and turned out to be risky.
> 
> In the end the V2 patch from Jiale Yao testing for ARPHRD_CAN and 
> ARPHRD_IEEE802154 / ARPHRD_IEEE802154_MONITOR (suggested by Gemini/ 
> Jakub) seems to be the best idea!
> 
> https://lore.kernel.org/netdev/20260728151240.89434-1-yaojiale02@163.com/

What happened to this patch above?

I still can't see anything of it in net-next.

Best regards,
Oliver

> 
> ARPHRD_IEEE802154 / ARPHRD_IEEE802154_MONITOR do similar things like the 
> CAN dev->ml_priv approach but with dev->ieee802154_ptr :-/
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index feaa75fbf8fc..d8c46105fc8b 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1224,6 +1224,17 @@ static int team_port_add(struct team *team, 
> struct net_device *port_dev,
>           return -EINVAL;
>       }
> 
> +        if (port_dev->type == ARPHRD_CAN ||
> +            port_dev->type == ARPHRD_IEEE802154 ||
> +            port_dev->type == ARPHRD_IEEE802154_MONITOR) {
> +            NL_SET_ERR_MSG(extack,
> +                       "CAN and IEEE 802.15.4 devices can't be added as 
> a team port");
> +            netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These 
> device types can't be added as a team port\n",
> +                   portname);
> +            return -EINVAL;
> +        }
> +    }
> +
> 
> And for the same reason the same checks for ARPHRD_IEEE802154 / 
> ARPHRD_IEEE802154_MONITOR need to be added in bond_main.c where 
> currently only ARPHRD_CAN is blocked.
> 
> And I would suggest to have two separate patches for team/bond and not 
> create a common function for now. Also to provide proper Fixes tags.
> 
> @Jiale Yao: Would you like to pick up the bond patch too, so that your 
> team V2 patch together with the new bond patch will solve this entire 
> issue?
> 
> Finally this will fix these three users of "ml_priv"-style non-ethernet 
> device types.
> 
> The general discussion about the ml_priv usage in
> 
> - qeth
> - ctcm
> - cxgb2
> - i596
> - wilc1000
> 
> gets relaxed after drilling down the shown critical cases. The use of 
> ml_priv is simply legacy code and we can make some cleanups/enhancements 
> there without pressure.
> 
> Best regards,
> Oliver
> 

