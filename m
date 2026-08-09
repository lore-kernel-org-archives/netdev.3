Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3DF175A72;
	Sun,  9 Aug 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299498; cv=none; b=J4n65QP8fpU2yuoYig9WRxNy0p7IIbTeHroA9lfTarkUElaDRXf9KRCul/uY5kX2+ex94ts2VBDEjP/2BqgT9vXdzONj0UKPCdDYQmw3zoNjLh33MX7jcywNytzUFM1mTnyhaIdymTYLVraFNPr2tOVw8EKjEoZYEmWiEuDPJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299498; c=relaxed/simple;
	bh=xV+6tYVfOqbogQVlN5gaRWH20RfNA9LytNQ+i8Bgzc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qV2ZSxe5aBfP+fXA1Iz9jAd9EWTyFBg9xuBedNNVg5L5AmruFaOeOyuD5cRULOxJE9qxE5OmkwxY9fxuPYGVHjbmGj2cEfqfaHnaObinxkGZHlMxiXPBtxLPxR53N2sPbasShsReK7rjyY4RjCCs1xKtET1SmScWGsBl5198prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vlu5y6tX; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=L7EfFiAB; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vlu5y6tX";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="L7EfFiAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786299495;
	bh=xV+6tYVfOqbogQVlN5gaRWH20RfNA9LytNQ+i8Bgzc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vlu5y6tXj9AHtbkAiZo7oCBOIURSi3ggJWdSIQf9eb5Wxkl82jMQPybWNI4Yfd0Ud
	 uUsZ6AvBRVi3l+gSZIlKYkE/vtkwousVj+anKxiau/1zK4xDGkYWeRNAwETt1xCcd7
	 IOG+psSKR4O6Z0kl5x62rcwFuBKREL3h3AuUX7NYQjtz3K10RDt62JzgA7QXfxTqI2
	 wuXMcYcFB6vLGkLKRYwF8LdRPyH0rTkkVpCoL98yA1pG14GkZ0ahmcmix9gePzk4X3
	 IKHCk/MUfQcGHUXiaJvJPsk56PCyn6wf1/44bPjxKWtBxK9/T0MXeuaRRGdsoG3k/N
	 kfabUvd/1p0+A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 496164975C; Sun,  9 Aug 2026 18:18:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786299494;
	bh=xV+6tYVfOqbogQVlN5gaRWH20RfNA9LytNQ+i8Bgzc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L7EfFiAB3XnOfSb8ad1psvAMqFDW+FIS6A5LbjfihOU7fYLHeGFHi55nbKb00T30c
	 lsdpAohX/5RbS+gEKLMdcMibBwsOeW1EZXfmq0HzwPyUVxOm4DflAkmqTuvsvkBHhI
	 KGL13PydeStC8WuetWc1OyvW/7ptpBOlFvsTL1W3KXrQR5g6qUm4TnBBHlc/f6NxVf
	 sK3L9KOo0BRxCQpoDR6f5W+YfpkqJPfQHtDndnuipMPHh4Up8ooPOtHagraqACEg66
	 OFw/Hme1+fSqfVGG4KFHzmO8yLYEGlg1m3NkqjElvPE6rzf4J1vYb++lsSFMklcxNh
	 WjQJaREB+t/5g==
Received: from [IPV6:2003:c6:9f06:3400:fea5:65ce:776d:88e8] (p200300c69f063400fea565ce776d88e8.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:fea5:65ce:776d:88e8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 239A349753;
	Sun,  9 Aug 2026 18:18:14 +0000 (UTC)
Message-ID: <f5bb129b-ca61-401e-a76e-cb2a55cd9077@birger-koblitz.de>
Date: Sun, 9 Aug 2026 20:18:12 +0200
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
 <6c165b0d-5e24-4b01-8057-1bef9fac851b@birger-koblitz.de>
 <67e2bfa6-438d-4ec2-addd-6a1c1959ec0a@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <67e2bfa6-438d-4ec2-addd-6a1c1959ec0a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/2026 17:28, Andrew Lunn wrote:
>> I'll fix that in v7.
> 
> Great.
> 
>> I would like to give Jianhui time to test v6, first,
>> tough. There were definitely bugs regarding suspend/resume and the MAC configuration
>> introduced in v4/v5, that I would like to be sure have been fixed.
> 
> No rush. It is getting close to the v7.3 merge window, you probably
> won't make it, so you have around 8 weeks to make the v7.4 merge
> window.
> 
Thanks for the heads-up, Andrew!

The issue Jianhui found is indeed a bug in the firmware of the controllers
and we will probably need his workaround to fix it. But maybe there are other
options, we will use the time to investigate further and test.

Birger
