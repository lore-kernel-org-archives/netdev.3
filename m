Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFF3AD50D;
	Fri, 24 Jul 2026 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878763; cv=none; b=ahEZXIX8VRu4sW+1FVIlEUMTBoWlvk7ORqh6qcAhymi2XOlmxlV5oaLtO/Vle6oURpuvgignpO5ZdeSxMHJvrOFL2OhNGGhtnutJdyUl+s2muV0cis5PEfYuZxqGQMIUEpjbyPFp/OtqnepQe6YJzbjwy2Go2IgEwzpkSkoiuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878763; c=relaxed/simple;
	bh=YQ6Sbu58GLHEk412iXQ5TrU2ee0c9JrXPDHJA2PNTps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl8nKEZx3xdZojZ7C0lNqhyOjc/smz7LHaMdUl7iLV58j55hIHA2ZfHYrDalWr4D+jzGNHwNt+/1l4EXmIjCl/PN6HMzVggljOQFMtGc55SHO0eDvtSq8HVvYOOjQaZrlX3IQyGIFiPSkZ/zjYvvmUvKb3Az9tejXgx26qdGzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WqDzSEbK; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fstjeH78; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WqDzSEbK";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fstjeH78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878392;
	bh=YQ6Sbu58GLHEk412iXQ5TrU2ee0c9JrXPDHJA2PNTps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WqDzSEbKp6BpOX6/g5TX9UgymgjUuMv6jjYrBFGTzqwGpsXME+tB7ZXVzjnHa2/kj
	 4h8ndSaT5fLt9I108DCxZThWARFChLX8Ls1iCeale3eXn85zM87uZgEEbhy1cy0lPf
	 MP5uoLoT3iArspPeak47fJ3lMVkPFtUxlnY21KJXysToBL4v74MPq+D852mBYc9glE
	 wNa+wegh9UVQvORSAoITYCAqPCM2mBYx8NunYW2AdLL+AoX/qz244j8ZTxd+4zaYEO
	 DvYYQuRnh0NnSOCWtdI17mtlUY+TWo76Aa5kt6eFd31o7x0HGY1QTfPlvGVHFQJDQJ
	 SXzXY5j4NIHVw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0F6DE492B0; Fri, 24 Jul 2026 07:33:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878391;
	bh=YQ6Sbu58GLHEk412iXQ5TrU2ee0c9JrXPDHJA2PNTps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fstjeH78kCG3qzuaMw1IPImMCBIkQ1TMRchyJLvsJGMs00YsHsfY98bzTtZmjfOOM
	 c7fwtXNmZRfh4uyIVYLw20HmnUMrp7Ogp+ta/0oROcQOZHjdOsMZK98NcrJWC3V3Qd
	 TN0BZmtUkQUEgmELCL5DCpWvd9l4mOTPyCuscDTivzNYLFUZdb0CK8Fny3cx57fBgY
	 7HzPW+S7kT83DRryk6m0djPDSje+m1tSxtD/3JQW9o8Sxi8EqF8RhHtC8YslJ/wdaW
	 PQ2Iz3qscHIdfT86RNwj4NIRHwcN80nzZfZGObipImfm8Xl/6FOaQz9IQqDh7PHKPQ
	 Jiht1XbXG+Oxg==
Received: from [IPV6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf] (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0FB8048EDF;
	Fri, 24 Jul 2026 07:33:11 +0000 (UTC)
Message-ID: <b09ee224-db0b-4f44-80fa-eb350e4baba2@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:33:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/12] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
 <20260708-ax88179a-v2-2-0800fedb2e16@birger-koblitz.de>
 <1f858852-8e8e-4cff-bbdc-eb6751f44ca5@lunn.ch>
 <de0bfcdc-01d4-4683-97e1-16c0466023ef@birger-koblitz.de>
 <713954ed-6d7f-4de2-9d2e-3d0af0f2db1c@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <713954ed-6d7f-4de2-9d2e-3d0af0f2db1c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 17:42, Andrew Lunn wrote:
>> A comment on phylink and USB-Ethernet NICs, though. Grepping for phylink
>> in drivers/net/usb shows only 2 drivers that use phylink: asix_devices (the
>> antiquated one using the 772A-PHYs) and lan789xx, which is also rather old.
>> There are more than 30 drivers there, so that makes < 7% phylink usage vs 93% mii.
> 
> Most USB dongles are old. There might be new variant, but generally,
> that only means adding new VID:PID to a table and they work.
> 
> phylink becomes interesting is with speeds > 1G and enabling more
> features of the PHY, like EEE. Because mii is so old, it only supports
> speeds up to 1G. It also requires that PHY stick to the 802.3 C22
> registers, and don't really have an vendor registers. There is no
> concept of a PHY driver for mii, so there is nowhere to put per PHY
> code.
> 
> For a totally new USB-ethernet driver, i would strongly push back on
> mii and want to see phylink. For the existing drivers, there is little
> i can do, i don't have the hardware. Converting to phylink would
> however be a good project for a newbie, if they have the hardware, and
> what to really learn something, rather than all the AI driven
> theoretical bug fix patches we are getting at the moment.
> 
> You are in the space in between. It is not a fully new driver, but you
> are doing speeds > 1G. And you are looking at lots of features and
> need vendor registers, so per PHY code.
I will submit a new set of patches as v3, which will be based on using
phylink. I added the phy drivers to ax88796b.c, which already has the drivers
for the older chips such as the AX88772A, keeping the tradition that the
ASIX PHYs are called like the controllers they are included in (the ax88796b
like the 772A is actually an Ethernet controller according to the datasheet).

Using phylink makes the separation between MAC and PHY much cleaner, but
I have to say that it was not that easy to switch to phylink, as many things
no longer are done directly but rely on configuration magic that often fails,
for example when MMD devices are not correctly reported to be present by the PHY.
I have trouble to understand why an RTLN-lock needs to be held over many ms
to send the half a dozen configuration URBs to configure EEE, but maybe I am
just frustrated because I had to debug locking issues that froze my development
machine...

One thing I was not able to figure out is whether it is possible to make phylink
listen to callbacks when the link-change interrupt URBs arrive. The solution now
relies on phylink polling the controller for the link status, which prevents the
USB bus from going to sleep. This solution is also used by the other USB-Ethernet
drivers using phylink.

> 
> I have another idea to throw out there, and it might be a bad idea. I
> will let you think about it. Split the current driver into two. Make a
> library out of all the code handling packets. Leave the mii code in
> the actual driver. Then add a new driver, making use of the library
> for moving packets around, but using phylink for PHY management. You
> can add the new VID:PID to this new driver. This has the advantage of
> reducing the risk of regressing the old devices you don't have. Also,
> we can put out a request for test, see if anybody has the older
> hardware, and ask them to try testing with the VID:PID added to the
> new driver. We might be able to slowly migrate them to the phylink
> driver.
> 
I looked into that. ASIX changes the format of their RX and TX packets basically
with every major firmware release. The older 179 chips use 32 bit values in the
packet headers, the 179A use 64 bit, so those fixup routines cannot be re-used and
put into a library. What is being re-used is the framework of of how the
controllers are configured and react to events, so I would like to keep the code
together in the hope that the 179 hardware can also be convert like the rest of
to use phylink.

>> Looking into the Realtek PHY driver code, what is done there appears to duplicate
>> the code in r8152.
> 
> And other reason to use the Linux PHY driver, no code duplication. And
> there might be some freebies, like cable testing just works, it is
> possible to control the LEDs, etc.

Personally, I think it would be great to push these drivers to use phylink and also
use usbnet. But for that one needs to figure out how to make phylink also react
to USB-linkchange URBs and usbnet also needs support for multiple RX/TX queues.

Birger
