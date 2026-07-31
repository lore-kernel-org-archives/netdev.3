Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569730C177;
	Fri, 31 Jul 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514173; cv=none; b=tz5RMLjdiOxHJLT9Uw85uDezbTBEJYe33hJMucaM09tBioc4A0S8wjq46IjTLelB/YBdAmgn9SSdnykaZmR7VZd4lItgKeCK/YClEb1nKZK3ybezSiN2rMm5FjiBirrehvNHilspnXJBA+QBS6Aor7cRxy6pbC85mbMikWyi4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514173; c=relaxed/simple;
	bh=2hF8N3dHWkNDyZDXgUVfrl9lgZLjPCjbxNm99szpqwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+ViSWiJJlWQ4nLXbNol23+hvgUXxaDIWJU7Na1dZcXQPo7tUXKOcrnsjaF9/Y6UZEpPuZuL1CsJzdZQAAkZa1p0dL4ewxF+dMBFcFckL1gJWi2U6VYryIIAmbLat0n36jOIvFumd12q/6W2El8Y/dJBV7cXjnuWckGYddfdgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iTMWBD9g; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iTMWBD9g; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iTMWBD9g";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iTMWBD9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514169;
	bh=2hF8N3dHWkNDyZDXgUVfrl9lgZLjPCjbxNm99szpqwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iTMWBD9g0c1Jgo9opnydfw2HgM9UXEualSZnkXrItWbwMGEnuSUaaqVyBz9EQZyu5
	 lzOY0xurNDqb3UoXGt7xsCwUJN0gNCY3i5YnaMSN9HaUoHzJAVjDPBAcjVX1aejkcE
	 LIpULiiMunnfIwiXW5242/paV4dhyasNcP5NuyTl3NcO9vr8g/giwXB1F2wNwOoTSC
	 eRRsl24DQ1xYdFywFoj2vxz4pTnhHPOcCFMO5BcQYmzfib7C2appx2Tz32sXARkDZU
	 dkUcTSl4zaoiIBAo0bdI3wjtGCeChnsjJpGsOcGYdLeUnlisLBAlsPzPLoP3lb3MFE
	 aiC7otQDaqwIg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C7EDE494F4; Fri, 31 Jul 2026 16:09:29 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514169;
	bh=2hF8N3dHWkNDyZDXgUVfrl9lgZLjPCjbxNm99szpqwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iTMWBD9g0c1Jgo9opnydfw2HgM9UXEualSZnkXrItWbwMGEnuSUaaqVyBz9EQZyu5
	 lzOY0xurNDqb3UoXGt7xsCwUJN0gNCY3i5YnaMSN9HaUoHzJAVjDPBAcjVX1aejkcE
	 LIpULiiMunnfIwiXW5242/paV4dhyasNcP5NuyTl3NcO9vr8g/giwXB1F2wNwOoTSC
	 eRRsl24DQ1xYdFywFoj2vxz4pTnhHPOcCFMO5BcQYmzfib7C2appx2Tz32sXARkDZU
	 dkUcTSl4zaoiIBAo0bdI3wjtGCeChnsjJpGsOcGYdLeUnlisLBAlsPzPLoP3lb3MFE
	 aiC7otQDaqwIg==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id BF4F9494ED;
	Fri, 31 Jul 2026 16:09:28 +0000 (UTC)
Message-ID: <8246f850-23db-4673-a6b6-626b5cad236b@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:09:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/13] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-2-bdde4f905883@birger-koblitz.de>
 <20384ea2-dbb4-4794-9f77-662e3b476ba2@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20384ea2-dbb4-4794-9f77-662e3b476ba2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2026 18:37, Andrew Lunn wrote:
>> +static void ax88179a_mac_link_up(struct phylink_config *config,
>> +				 struct phy_device *phy,
>> +				 unsigned int phy_mode, phy_interface_t interface,
>> +				 int speed, int duplex,
>> +				 bool tx_pause, bool rx_pause)
>> +{
> 
> I don't see you doing anything with tx_pause and rx_pause.
> 
Fixed in v4 by configuring MAC-mode accordingly.

Birger
