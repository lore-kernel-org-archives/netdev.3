Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F7448BA1;
	Thu,  6 Aug 2026 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044867; cv=none; b=NN0NIeTQu/Fr7DhAk2AMgZfBSO0r4bTQPbkXdaIHRdIkXBy6p1YmvMn1MrZdsbhB286wXlHX88F7tamcszOaJkjnal4KtEE6H/YWlUVrPtw1y+J2FF9YjTGpzGt8sHSpH2JzTM2xaAXXw1uaKKPUHHCtUS7QndVrtGVc2bD50a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044867; c=relaxed/simple;
	bh=VydPWl4Nqka+FiRyx/P1LllrkvwwwKvI2K25NeiVBBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNM3QrlTPxytg/xIDLPhGh0Rvn5U/xCkete6R8IjvR/59lJgd6Yn/qmpCZsT2x/3GdJrVUyWyJ8zdi8Pzhkct0akG6YN3s5PWqmP72sxKoy3QqBYbcBZedyNZkRBZAGK6tkP9OfTnkeGf9JQziyf6ZdiygkzBKqec9rt4w0ebTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=opM0JMM/; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=mEovw9/i; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="opM0JMM/";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="mEovw9/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044864;
	bh=VydPWl4Nqka+FiRyx/P1LllrkvwwwKvI2K25NeiVBBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=opM0JMM/Lf/Ug3NIXpfyeJUwDkhVkDh1MQrAeqyD+j4/oLtyev603tXGl8waQ4ZVQ
	 cau7Bo068ZZEd5J1bzx6DRwbolMojpMcrMvBLc6ZbMh9TfFmMDWEkhRv3gAryxVYU3
	 XeUvrOy6eK/rvtTcVBXhB0U5JQ/hQ5Xo0mHpJ7BFLRGB6Jt3ejyDKV5tpJ5GKnx6ot
	 Ibozjc6szVDbwOiBMHqQdHkxiFIaEOuRUTRvQwxjrs/507WH8K4yuHH/4hVn1jpMwF
	 KUuRgBX0U4pfgXgxZ/JzZ4jXMHt/6fsee0LCmauHjKTVrENpMrTZuGvnc5/FUOCr32
	 BJTtTBN5WBUww==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 395D9496F2; Thu,  6 Aug 2026 19:34:24 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044863;
	bh=VydPWl4Nqka+FiRyx/P1LllrkvwwwKvI2K25NeiVBBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mEovw9/iq/Egz/RlWCtxtJ2TGCIjqVEbHmJy2WxVH8fdH9QFaeVBGZCwj9jZwT2G3
	 EjOs5Gd6EZNj5lcmvsb2X1MX8K14V2rLIFaRW+k9LpxG45nraiX6zV6ToY2sExfBs3
	 /3JHSjKpkiok8cWjSijuyOQz1rNIupNddzsT+kfx10uCzWDj/1bGTkWUdaE+cO4sdn
	 7a1F5+wAG8KoagexBTa40H6qctz7GXPdecEks+QTZwhtttW3qGedYJBrseB/crX58c
	 GoxWO8OtrN7c1BUsxcCestA//idFLu2eSWG4tZy9Rf2RXp83IRpSSt+s5vG9wUa7N4
	 rZW1HbJaVuqRw==
Received: from [10.30.1.58] (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C87AA496F2;
	Thu,  6 Aug 2026 19:34:22 +0000 (UTC)
Message-ID: <d54e7f90-2e74-498f-8794-5704f8193151@birger-koblitz.de>
Date: Thu, 6 Aug 2026 21:34:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>
 <d7d319c8-9404-43fa-ab44-755c9e612c19@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <d7d319c8-9404-43fa-ab44-755c9e612c19@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2026 23:36, Andrew Lunn wrote:
>> +static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
>> +{
>> +	struct ax88179_data *ax179_data = dev->driver_priv;
>> +	const struct ax_bulkin_settings *bulkin_data;
>> +	int index = 0;
>> +
>> +	switch (ax179_data->speed) {
> 
> What is setting ->speed?
A leftover from before refactoring, sorry!
Fixed in v6.

> 
>> +static void ax88179a_mac_link_up(struct phylink_config *config,
>> +				 struct phy_device *phy,
>> +				 unsigned int phy_mode, phy_interface_t interface,
>> +				 int speed, int duplex,
>> +				 bool tx_pause, bool rx_pause)
>> +{
> 
> It should be coming from there, but i don't see any code setting it.
> 
>> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
>> +	ax88179a_bulkin_config(dev, link_sts);
> 
> It might be better to pass speed as a parameter.
> 
> I would probably play with ethtool and set the advertised speeds to
> only include slower speeds, like 10Half, and make sure the link works
> correctly.
Indeed. The speed now comes now from phylink. I tested all speeds (including
unsupported ones) and the mac_link_up() implementationn now works
as expected, including after suspend/resume.

Birger


