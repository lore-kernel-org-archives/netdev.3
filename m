Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2745BE3;
	Tue, 18 Aug 2026 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028706; cv=none; b=LwORGyKsdP9KCLUDg/+Xu1aFRYNkrexIFO3uamnHMQ2TWtSWLIupXEJu42mEANmA6JcHl2BsWv87WcCychYAvFgrRNftIV28FyBtY1sh0aawEtzxwRYygmWA9KF1N9nx9h7vh7TpueAj6yCY6yQVMU/l7103gRBQGX0AAkd/XgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028706; c=relaxed/simple;
	bh=VuGy5kLPtgm60zY3sLvALqHrRSs450ZmIGcsTFHJ4RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJpOfRlvoyW73zwpYLWPaFFegpGph6aD9HOWGKkTefS4YpehQt2cjZU1SpbkOFxz3XCyc3e93ZkRf6BWTbQzf01KJNbhgjwxmw2pc/PqlnSy8nTYRUBlgjLlouaHGGK8hu822HEUOuIr4jbAJNj7x0S+8fYYSAS9aWrWvx5o57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zTMz47nV; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=wmrRSKbr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zTMz47nV";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="wmrRSKbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1787028697;
	bh=VuGy5kLPtgm60zY3sLvALqHrRSs450ZmIGcsTFHJ4RM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zTMz47nVk7OuDgMLTbVEPxlljGi+BhNpnaw4TwBHDwEm56ww8POveALzUShzKgO2v
	 KjjuoUeyPKRBa0KtPw/E1XtmKlmLDYETYRmCAyAwXxKRcaO0JxubZUD59U/WS6xd3C
	 Z58WwWzgB6W9ZCcfm2ALMAgTtQgmxTr/GRLoGGL+7uxlh6K/HduWJVUboMFKnInHeZ
	 pNGjAoZCCtoYpZGeAom9gwFo7kG8anJ3Xh8fZr7WxQAHh/sFUp6EJLL7t7HCHFQVTN
	 5LHV4relF7hXI0SkPTMtxCmMVrmHYsHEAmkgn/dNH9rWDKBjcrTrrKhZCnd5sHO84i
	 ay0gaMHzk8PRw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5ABC049933; Tue, 18 Aug 2026 04:51:37 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1787028693;
	bh=VuGy5kLPtgm60zY3sLvALqHrRSs450ZmIGcsTFHJ4RM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wmrRSKbr1GClq3w6sFiTQnRYhp4Xip4Ees65vufGv7mEnCoWOCIaUpx47at5EXUoO
	 lPbZtg6vm7uN9+BLGwl9FFUHxWHym4qY7iuHoI002UwfETfZDXe+wt4aivqx0jmvz7
	 wKa4DwiwTda5V0/wPDOWGdWBe4o0iXZSNz79tuELEEF45IU8gl0IHTKWvonJxg6W5C
	 MD3tqpVLm4dMs6mIByav0MlCGHhOSIJ03qy84AIFUWgBuJi9kgLy9QIluLpo81vkil
	 0UacfEkYOh1YuCcOVNWmBCjkV5s1mDBpJz6/wPDmHm/VKwi5zMk/FsK91o7AFV6zpH
	 sHKiFX8REjv9A==
Received: from [IPV6:2003:c6:9f06:3400:a121:726d:74b1:1cd6] (p200300c69f063400a121726d74b11cd6.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:a121:726d:74b1:1cd6])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4F47E4992A;
	Tue, 18 Aug 2026 04:51:33 +0000 (UTC)
Message-ID: <e72d0d5e-6368-46eb-8247-a760046cb8c0@birger-koblitz.de>
Date: Tue, 18 Aug 2026 06:51:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 03/14] ax88179_178a: Split driver into library
 and device specific code
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
 <20260810-ax88179a-v7-3-da633191c129@birger-koblitz.de>
 <20260817152800.3dbe9f55@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260817152800.3dbe9f55@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

thanks for reviewing the code!
On 8/18/26 00:28, Jakub Kicinski wrote:
> On Mon, 10 Aug 2026 14:33:28 +0200 Birger Koblitz wrote:
>> +static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>> +			       u16 size, const void *data)
> 
> Local netdev convention is to still wrap at 80 chars.
> Anything beyond that is inviting laziness.
> 
>> +{
>> +	int ret;
>> +	int (*fn)(struct usbnet *dev, u8 cmd, u8 rtype, u16 val, u16 i, const void *d, u16 size);
>> +	struct ax88179_data *ax179_data = dev->driver_priv;
> 
> Local netdev convention - please sort the variable declaration lines
> longest to shortest
Both of the above and other occurrences will be fixed in v8. Sorry about those, I was
moving existing code and tried to minimally change it in order to allow blame to correctly
identify the original author of the code, while still making checkpatch happy.

I was not expecting a review while netdev was closed for patches, btw. Am I right
to assume that I should not send v8 during the merge window, or do you prefer the
next version to be submitted earlier while everyone still easily remembers what this
was about?

> 
>> +	if (!dev) {
>> +		netdev_err(dev->net, "No net device.\n");
>> +		return -ENODEV;
>> +	}
> 
> Is this a real check you need? It was a BUG() previously, so clearly
> it must never happen. Please don't add pointless defensive checks.
No, I did not see how BUG() was doing anything useful before, either, and just
wanted to preserve the logic of the existing code, while making checkpatch happy.
Will remove the 2 occurrences of this bit of code.

Birger
