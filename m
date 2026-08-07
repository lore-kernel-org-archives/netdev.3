Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA021D3F5;
	Fri,  7 Aug 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125937; cv=none; b=tff33IjKXjNvfwaXvI3Z0hNYvzJUAZNnOadCpZiQve9yD5PahzSpgfDxY0CMekWNpsCizbfL62DdGkF2r1m08myD7YquocNfKXWYuucYtUYvEqb/dZlfGcrlaQODFGj5PCLiz3SWzPghCGpR0A5HiSSWj7qobDvqNbYHVhcUD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125937; c=relaxed/simple;
	bh=b4EV+MsYLwvA/FOeeJADbj+V6zEll+ofBjEXtbCZWW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtie+ooui8wKlNUaZLi94qAdmGtaYS9h/PbBxiD6oock6PQZ5fu6zJ5tWqrUTxsxL3A69qWfHn7xfLbPYLC8Sex/eO8Xh2O6A8Rbz5/snGRCwVtL+14gDwjMafc/5XZwmvyX2VhrfrTsznCvztvZhv8sUhxlaEeIxOfdShT5pPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tgePFy6x; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=j0ivkmnQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tgePFy6x";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="j0ivkmnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786125933;
	bh=b4EV+MsYLwvA/FOeeJADbj+V6zEll+ofBjEXtbCZWW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tgePFy6x/DeBEvrAsztK0rRCjOHhB17Hw1ItG+p1790br12agKOhcGqAIa12PacJX
	 KM1CKa0fXLWlu53YVSOKzBucgDYY59pxhTeGVKnnVhQI9yrVuHwN4kF6UOyFNc4h1t
	 XUVMMTfsQJyu2Y1Pst+l2SHlhILHqWCNGGHcHIzBfb7VLkS2M8n+7/YiRw2nlC/dcD
	 43nIqgoqVxHYCz3mAFkMf17jXvDo7PPk1v4Z9ck++ZL45OmS7vfUCzlD2IFEojZdYp
	 2y3UzeUil4UpfIrPgUlDNNQTccQE5GGzWgKtQDu/V0S/aK/zqAW2YMCINToLIBAJPs
	 F/7gaGk3kYW+Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 61C0549712; Fri,  7 Aug 2026 18:05:33 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786125932;
	bh=b4EV+MsYLwvA/FOeeJADbj+V6zEll+ofBjEXtbCZWW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j0ivkmnQ7lPNzyWlU0Tb8u3Bm5pTbBzsITk5iflfPhCejuN4hV0CKarlUfdZQnngJ
	 yYkXMcaFZYQG4VX1XWCTINiaQePMOzpMv+yWlqj/pfeVZQzDFZlorRGZvWAjJPVPnw
	 9sjzR1ayU5fPb090WORMj/+SAr4hAtF/FtiHFpDyxe06Fpe5LLmkxPUYwC0qbeDHbV
	 vQYV63O37VYP2+WMVs1zDwR4JtfZvEjEupGqOWSOfYZehT80a9imitAthMP5nzjw3L
	 mJCyjkQjQZwEnSMwV0s6c1IYAggmdSVbIIOPen1Y9dqixYeAN4BvtqkDVg80DDU5sL
	 vjMSJotQaGpTw==
Received: from [IPV6:2003:c6:9f06:3400:7626:30f6:e920:d1d3] (p200300c69f063400762630f6e920d1d3.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:7626:30f6:e920:d1d3])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1236C49706;
	Fri,  7 Aug 2026 18:05:32 +0000 (UTC)
Message-ID: <6c165b0d-5e24-4b01-8057-1bef9fac851b@birger-koblitz.de>
Date: Fri, 7 Aug 2026 20:05:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
 <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
 <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>
 <f2a99d04-6d61-4cc2-814d-cfe1ef9b1395@lunn.ch>
 <7a91e550-ac70-4423-9aed-9f4406e71fe8@birger-koblitz.de>
 <527d31e5-1731-4925-bf7f-a567f3fb3774@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <527d31e5-1731-4925-bf7f-a567f3fb3774@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2026 15:14, Andrew Lunn wrote:
> On Fri, Aug 07, 2026 at 08:39:00AM +0200, Birger Koblitz wrote:
>>
>>
>> On 06/08/2026 23:16, Andrew Lunn wrote:
>>>>>> +static int asix_ax88279_config_aneg(struct phy_device *phydev)
>>>>>> +{
>>>>>> +	bool adv_2500;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (phydev->autoneg == AUTONEG_DISABLE) {
>>>>>> +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>
>>>>> Why is that? Now that phylink is driving the PHY, and reporting
>>>>> speeds, duplex etc, you should have everything you need to program the
>>>>> MAC when the link mode is forced.
>>>>>
>>>> I tried forcing the PHY speed in the past, and it does not work.
>>>> This is a limitation which is also acknowledged for the suspected underlying PHY
>>>> hardware Airoha EN8811H, see the head of air_en8811h.c
>>>
>>> How well does this unwind on error? Is phydev->autoneg put back to the
>>> old state to indicate autoneg is used?
>>>
>>> This is one of the areas where phylib/phylink is missing a bit of
>>> support infrastructure. We have a bit indicating the PHY support
>>> autoneg, ETHTOOL_LINK_MODE_Autoneg_BIT, but there is no bit
>>> ETHTOOL_LINK_MODE_Force_BIT, indicating the PHY supports forced
>>> mode. So the core cannot enforce this and reject it in
>>> ksettings_set().
>> The error is handled quite poorly:
>> $ sudo ethtool -s enx6c6e07090000 autoneg off speed 1000
>> $ ip a
>> shows link is down
>>
>> Kernel log:
>> [848763.836126] Asix Electronics AX88279 usb-004:045:03: Disabling autoneg is not supported
>> [848763.836134] ------------[ cut here ]------------
>> [848763.836137] _phy_start_aneg+0x0/0xa0: returned: -22
>> [848763.836142] WARNING: drivers/net/phy/phy.c:1352 at _phy_state_machine+0x100/0x310, CPU#8: kworker/8:1/534588
>> [848763.836146] Modules linked in: ax88179_178a cdc_mbim cdc_ncm ax88179(OE)
>> ax88796b(OE) cdc_ether phylink(OE) r8152 nfnetlink_queue nfnetlink_log
> 
> That is ugly.
> 
> Ideally, we want phylib/phylink to report EOPNOTSUPP in
> ksetting_set. However, as i said, we currently don't have a mechanism
> for the PHY to report forced link does not work.
> 
> So:
> 
> Please change EINVAL to EOPNOTSUPP.
I'll fix that in v7. I would like to give Jianhui time to test v6, first,
tough. There were definitely bugs regarding suspend/resume and the MAC configuration
introduced in v4/v5, that I would like to be sure have been fixed.

> 
> We accept your change as is.
> 
> But if you have time/energy, it would be nice to have some follow up
> patches in a new series which fixes this correctly, allow a PHY to
> indicate it does not support forced. The question is, how to actually
> do that. The BMSR has a bit `Auto-Negotiation Ability`. But there is
> no 'Forced Ability' indication. It is simply assumed all PHYs can do
> forced. All the bits we have in phydev->supported, are positive, the
> PHY can do something. There are no negative, the PHY cannot do
> something. So i think it would be wrong to add a negative.
> 
> What we do have is struct phy_driver flags, and currently
> 
> #define PHY_IS_INTERNAL		0x00000001
> #define PHY_RST_AFTER_CLK_EN	0x00000002
> #define PHY_POLL_CABLE_TEST	0x00000004
> #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
> #define MDIO_DEVICE_IS_PHY	0x80000000
> 
> So maybe add
> 
> #define PHY_BROKEN_FORCED	0x00000010
> 
> and look for that in ksettings_set() ?
I'll work on this right away.

I also would like to add another feature to phylink separately. All the USB
Ethernet controllers have a feature where the controller sends a USB Interrupt
URB to the host when the link state changes. It would be great if instead
of polling, this could be used to trigger a read_status() of the PHY instead
of polling it constantly over USB. This would work like the equivalent of the
PHY link state change interrupts. Basically, the host driver would, upon
receiving a link change interrupt URB trigger a similar code path in phylink
as a link change interrupt by a PHY triggers. Ideally, this could be something
that usbnet would help drivers to set up. Would that make sense?

Birger


