Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD525FA29;
	Mon, 28 Sep 2026 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570933; cv=none; b=nM0omELiwK0ROS61hrAKvSYRVp7a6cwVZAIxg+iLLzn7wIF0pT0lFZ7AK3UcrfKl6vvs99PkL2ek551znoLiV5+sJS3J98ksJHQgyQSTPJTT6erPZKLStQxIWHq3IEGEdDFtu22C5bQ7gfavSlo1FEdsf08lPJ0YKfycOGN6tNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570933; c=relaxed/simple;
	bh=5DZZ9Su9VvGcnq3MXH2Wv339t9SbJJGS+JqvplMj8J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HghC3YYILD+TOprudXKVDcJSlxCceZ7O5Fdrq2p076XxNgZRoAv9x5q/iYrmf5he94JeYo24QYZmVa41NwxEAFovdriSTLLrLo+nb3BB/KtMggdLIj5xovzfcTB4LJMzP7SkJNqql+B0MHn5fAuPKbBeuay8+gD97wTs8kPe1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=UgWiZqXO; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pMJfWL9f; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="UgWiZqXO";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pMJfWL9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790570930;
	bh=5DZZ9Su9VvGcnq3MXH2Wv339t9SbJJGS+JqvplMj8J4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UgWiZqXOZx2TCnZduFZmfxvg5iBYl2cqDgrcuQifxeNLUf//5TOO5uCLRpxzppqx5
	 LDKGiqOG2fXlfFu7hfb6gM6ZkSxKnc64kxZGdgeJ6Rh8EFRvARuPNDNtomY9w483iQ
	 kH4Sy4+8eJv19rjdKlUMLYI7SSezzFKFwp6pvS78TNAXcFyW8Ko8U4Ecqu7qedXvAV
	 mCM8j9lUXZaZuuGKcee2ONPK3WTWgzOqk7d6VXjOj+ok33alCVg2zG9DIuyfjgn+GE
	 89+SPI1BsutusmaUGVcwhHe9oE0GkENwo/qc3iwOPNFzy4WN6+CVtr/YnyQt1va6ic
	 axj//Ov9Np5xQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7A428421D2; Mon, 28 Sep 2026 04:48:50 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790570929;
	bh=5DZZ9Su9VvGcnq3MXH2Wv339t9SbJJGS+JqvplMj8J4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pMJfWL9fAvx34TjiKBBYk1OjSKCP3/KUSICmJYl13D26c9TUy5kaCzx21FV0/ImTB
	 ClD3Wneki0KMYlqRdb6ryPPrHEet4riRV9m2maFuWAtUJxY1ga9SSBU91+1Wv/DQdn
	 eWv8d3pZZLCXXxT6SUaOQISNgtEyfnq7wSnUhZ1s2ub3JEzjik8wka58/8T2+Ueu1W
	 IHKCaLPmbgHQuYVHqYRHjbjS1OyQPG7UlufMixw7D5nPkyuvfPdB9zMIjzTBBZv6YV
	 IF1dwqN1uLUE1Ywk1oIoxOfIhjZVTzKLYAEeDT9B7t0Mny2kIk6Rz/tfqxXGGMp18D
	 t2Ghf/dfXZ0kg==
Received: from [192.168.2.51] (p5dd1e959.dip0.t-ipconnect.de [93.209.233.89])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5848F3F52D;
	Mon, 28 Sep 2026 04:48:49 +0000 (UTC)
Message-ID: <21485f2f-b446-4a38-86c3-dc8d73260a0d@birger-koblitz.de>
Date: Mon, 28 Sep 2026 06:48:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/15] phylink: Add phylink_mac_interrupt
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-1-60c04c9924a2@birger-koblitz.de>
 <178968029017.22033.2874254681410388676@kernel.org>
 <17164abd-05ec-4b6b-bc51-a017cc87047b@birger-koblitz.de>
 <bb4043d1-e89e-430b-8f68-e64fc2b0d11a@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <bb4043d1-e89e-430b-8f68-e64fc2b0d11a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

On 27/09/2026 4:18 pm, Andrew Lunn wrote:
> On Sun, Sep 27, 2026 at 11:03:17AM +0200, Birger Koblitz wrote:
>>
>>
>> On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential
>>> issue(s) to consider:
>>>
>>> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>>>
>>> - [Medium] `phylink_mac_interrupt()`
>>>     (drivers/net/phy/phylink.c:1621-1628) reads `pl->phydev` with no…
>>
>> This does not look like an actual problem, as the interrupt is not really an
>> IRQ, it is a call from the MAC layer, calling phy_mac_interrupt(phy) did the
>> same in the past.
> 
> We need to be a little bit careful here. phy_mac_interrupt(phy) can be
> called in interrupt context. It does not perform any blocking
> operations, it just queues up the work to handle the actual event.
> 
> Here it is used in interrupt context.
> https://elixir.bootlin.com/linux/v7.2.8/source/drivers/net/ethernet/broadcom/asp2/bcmasp.c#L81
> 
> I would expect the phylink equivalent to be the same.
> 
> Since we are in interrupt context we cannot take a mutex. But do we
> need to worry about phydev disappearing? I don't think so. In
> practice, ignoring unbind via sysfs, the only way for a PHY to
> disappear is for an SFP module to be hot unplugged. But SPF don't
> support interrupts, so there should be no need to use
> phylink_mac_interrupt().
> 
> It might be worth adding some comments here?
Thanks for the reference, I understand this better, now. My suggestion 
would be to add a comment as part of the function description:
This function may be called in interrupt context, and therefore cannot 
take a mutex. However, it is safe to assume that the reference to phy 
does not disappear during the call, as only an SFP module may be 
unplugged to make a PHY disappear. SFP modules however do not support 
interrupts.

Birger
