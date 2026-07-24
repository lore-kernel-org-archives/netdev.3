Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671F3CF20E;
	Fri, 24 Jul 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912859; cv=none; b=DHKvJ4hT8CsadFFyGndMbjJ7qvDaL+nHj6pw2Vo+zkG4/uKDdFgmJZVgJ2/rd7kELt6QcJu5NinqOmIeBPIt7VuP71tz3AkNgarp/yM6nx/FpI+7QpGgytvmSil2OacmlNtELQ9mXFkVy/hy7SJ3QLqvhHObX5e8X6BrJmOTtP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912859; c=relaxed/simple;
	bh=eQGsqM9nrWrPXWfMZGCS2L2scXsr2jOohofd+xR2PKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJwpErcPAx+OqbyMs0m95+tuZM185jwSQFMQSYICDNznIteHFdjQPGj02VHPiWmcU6qphN7eFOv4mS3WLEcUQVOkW3SojOj9JjwFIr+TCQdTrzN46dbg4QuzSWBFzbeVrxbQj0lx7vzW6lr1DDnUqpT19LKTMGH7EsiwhwMLsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rCBMg+cZ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=OY4ZvnIi; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rCBMg+cZ";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="OY4ZvnIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784912852;
	bh=eQGsqM9nrWrPXWfMZGCS2L2scXsr2jOohofd+xR2PKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rCBMg+cZcGIJSbkdUEomGwFGllJlNbtqg5g7ueitC83GeXjYG3I0QJTNUnJl8yqkA
	 uR9NHicqo6UjPnWD0BVWGZpAxGOCOSz6ZvJG+wEPEpNq3tBCb4txD7rGYewYICUR1D
	 NMiUw7Ld0KyCGanzQCcgovz7C4Ft1x8gX7JnaYUfOUxAjV+WsYYXm2K1BcsyFD4aCr
	 m4SgI0nd8QPYxrgUq2EMYluhn7ZYTjwtprUez2WYNnuKUWfoOBdAOkWT1fgSKqObhQ
	 Pm86vMd9bB2V0ejXsU7I5Fw8wXSSGPNJijEr4VcJQJDcfAvSBC+Kai+mUEo/oRqRFr
	 OPwyE+8WfEohw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2147049451; Fri, 24 Jul 2026 17:07:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784912849;
	bh=eQGsqM9nrWrPXWfMZGCS2L2scXsr2jOohofd+xR2PKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OY4ZvnIi9LQ5PouP2Lo2hSN3EBg3Al88r71mGsqHriN0RXlbC0uT3hoP/FUYoB+1+
	 ar0jKUGQyv7iSSOxaci9yzYlYMZNFL4kRb66kcaLcUwOIRUoX9R4FV+Okuekenk/1u
	 IZkOjJ07YBfpzwYI7RH9EDROosaDH7ux/nEUpBQjLTpUWluAOh2Abc8whpM25AgBQ/
	 tX4fYQQZI5v8izROMF+qPay/SnZdyOIBuq/SSad8tG+mSh+dKCGz3db+NAR0vOzvtH
	 dfJUhfB51ZGhFREOLsofDwnddJBGLwx1NrOXq+Ath9mLIN/JuZqHFdho7pPmJqvnye
	 xt3slt30msCDg==
Received: from [IPV6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258] (p200300c69f1c3c0011126ccacd9ab258.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8B01D49369;
	Fri, 24 Jul 2026 17:07:29 +0000 (UTC)
Message-ID: <7a83bba0-2c70-458d-babc-e54581a2e158@birger-koblitz.de>
Date: Fri, 24 Jul 2026 19:07:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/13] ax88179_178a: Use MMD accessor
 functions for AX88179A
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>
 <6cbd0d83-9802-4e02-ba1b-4cf76cb51659@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <6cbd0d83-9802-4e02-ba1b-4cf76cb51659@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/26 18:44, Andrew Lunn wrote:
> On Fri, Jul 24, 2026 at 09:36:46AM +0200, Birger Koblitz wrote:
>> The AX88179A uses a much simpler Clause-45 MMD access interface,
>> which are made available through ax_read_mmd() and ax_write_mmd(),
>> which in turn call the chips' respective implementation.
>>
>> Make use of these functions for stract MMD read/write operations.
>>
>> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
>> ---
>>   drivers/net/usb/ax88179_178a.c | 39 +++++++++++----------------------------
>>   1 file changed, 11 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
>> index b90a75a11024c58192bdb4a9436636bc9312148c..b7837c7a89f9b5ee520ef1ae91bbc7619d1a12bd 100644
>> --- a/drivers/net/usb/ax88179_178a.c
>> +++ b/drivers/net/usb/ax88179_178a.c
>> @@ -985,22 +985,19 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
>>   	int val;
>>   
>>   	/* Get Supported EEE */
>> -	val = ax88179_phy_read_mmd_indirect(dev, MDIO_PCS_EEE_ABLE,
>> -					    MDIO_MMD_PCS);
>> +	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
> 
> All these look to be standard EEE registers. phylib should be handling
> this for you. Put a printk in genphy_c45_read_eee_cap1() and make sure
> it is being called.
> 
> Basically, anything which is part of 802.3 clause 22 or clause 45
> should have helpers in phylib, and in most cases, phylib itself will
> take care of it. A MAC driver touching the PHY is generally a bad
> design, a layer violation. So any driver using phylink or phylib, all
> direct access to the PHY needs to be removed.
> 
This is again the existing code targeting the AX179, I just used the
new MMD accessor functions that target both architectures. I cannot convert
that with any confidence that it will work without having those devices.
One would need to write PHY drivers and use phylink to make the mess
go away.

Birger


