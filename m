Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B984BC004;
	Wed,  1 Jul 2026 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927909; cv=none; b=Lf4MV9NNQjHCAwCWgxoqS2BMakeP97KEOhiVCpHT3Mop5Apts08ttCqrPJM3NtN/sRIU8jEMW7lMER88EPgsD321XAqk2BPRz49QQ+n0Gyy2s2uDzydgb8T4WN5VAlHLBvUY7eb/xDfth3rKaojqMiuZX2hrwJ/5YkPFOaGET5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927909; c=relaxed/simple;
	bh=yu1OYVNjeWpEKBxU8r3a1PqbcvhsLJ/S+dNG+ulBYsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvE32snCnFCZOEBzMZRdc9v3qcr/bIMLOvEvj62Hu1JgWg/NuBwe9vaOQUim0pbakHxfOGyY3VQRxJ2O9I/b+OYJleT4jNZe3si2rlge3gZdV/74f4wXvZe1GFpA9Yj2Sy6Ot+JI7Nm9z7WxHSYMnC0nJ6A9MZ9B8XEbIkeHQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=H33Sk6em; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=nVfWw/CU; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="H33Sk6em";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="nVfWw/CU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782927905;
	bh=yu1OYVNjeWpEKBxU8r3a1PqbcvhsLJ/S+dNG+ulBYsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H33Sk6emHWn8Vh38nhpdRzjjOfLJuZBaAxjJxzop/PFRdFmBMPhPKy2KH4lHVRSWM
	 B7tLHVM8Cp0nknRVm9uTx4QjLCBJdJXUAukjqQQ5JQzETn0EyTTmqK0bqAKRDjShcB
	 BsmQiYmygkyovSnHuofOcxiqzFv3UKFU6WuFoRJ+QOPr+ev6Wm9sxnFp+T8pcU4Nl+
	 zx4ErWv1chpruhA0dyCyqLI3JFus1zx1QtpaVR2H6MpjVHg9qYeDbdIt/Ru5SF77Rx
	 7Bn8tpJDEom1ntTBAYSb0eOKu3+ZDuEtyc4ue45Slry2OFFuwZQjXllBp9D8UdBN+y
	 pyLU8SqON2rGg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3B55649365; Wed,  1 Jul 2026 17:45:05 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782927904;
	bh=yu1OYVNjeWpEKBxU8r3a1PqbcvhsLJ/S+dNG+ulBYsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVfWw/CU4h2efX6UOz2BltPdT2bco0XEMXHVXy3eBd7W1GUv4L7Ff676IhnB4xg5B
	 /YRWM+0Bi8XUm6I57WmzIJsq9yoiHvF2oxzpTPc6XgQrKOiNCL/SO0997NDwdLuB+O
	 1GTC/vqxkZ1pEhdoNdnPZzokIwCTu6ka3Oj7W0P7yI9YqW/QeScIzsJmJlcFkSNwAO
	 fXa9RAAzOnE94EGCXB4KTU6vhHbl0HaV4P+pGHU0RidnEk8LvGLgm2jJuzUs1JkL4m
	 JexlNkEg4TG8cviQca3x25ArEW2DE6opt6x6CvErVONaQT6JfK8fbn1eziGiE8kUdd
	 ckXk6y2C8mrTw==
Received: from [IPV6:2003:c6:9f1c:3c00::1c8] (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5093449353;
	Wed,  1 Jul 2026 17:45:04 +0000 (UTC)
Message-ID: <3cc16d45-7b6d-4fb0-8a7b-d6b4d53ab036@birger-koblitz.de>
Date: Wed, 1 Jul 2026 19:45:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause parameter
 configuration
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
 <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
 <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Thanks for these numbers.
> 
>> Renkforce AX88179A: ID1 7c9f, ID2 7061
>> Delock AX88279  ID1 03a2, ID2 a411
> 
> air_en8811h.c:#define EN8811H_PHY_ID		0x03a2a411
> 
>> UGreen AX88772D ID1 e65b, ID2 2c61
>> TP-Link AX88179A ID1 e65b, ID2 2c61
> 
> The two ID registers contain part of an OUI, but it has some bits
> missing. So it is not so easy to look it up.
> 
> However, anything using the MII framework basically assumes a very
> simple PHY and only looks at the 802.3 defined registers. So the
> genphy generic PHY driver might be sufficient for when there is not a
> specific driver. At lot depends on how much extra code there is
> accessing the PHY registers in the driver.
I also found
#define PHY_ID_ASIX_AX88772A         0x003b1861
Which has the same ending as the AX88179A at least. So hopefully these
IDs are stable across firmware versions.
So, I will give phylink a try and send a new patch version out. I am a
bit worried because the PHYs are real divas, getting them to survive
a suspend/resume cycle was a bit like herding fleas: get one of them
to survive a cycle made another one come out completely dead back from
resume, and in need of unplug/plug. So that took a lot of
experimentation to get right. The out-of-tree driver by ASIX is of
little help, because it implements a complete USB device and is not
using usbnet.

Birger
