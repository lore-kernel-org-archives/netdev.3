Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA12C11E7;
	Sun,  2 Aug 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687707; cv=none; b=pFhnBv76USM1nExJrpAsmzG6bKPGjqU9A1u4bzoEDmd8fyxQCsAisQBF8qzZRK2jSTW6MLZJvLyz2uyP4BP5SQ7cxnTi8DnlGOIPk8SO4FrBIGNWWKmAkIuPxXoilFNql3nqTr66DALw41DTBGckVgWnnZesVI0TRKuLA2AJ5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687707; c=relaxed/simple;
	bh=vVEK0GSJaoCwG2Za91HLPjZg7UQMCEGU0esr8mYEJlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzHdChx3VJ4wVhJIj06CELEIAqJXNBneQ+KxhcTo9bq39GyWOPfJg6gZfnThkc+HEG2gtaVyl37bWrJvCghey6O/CBawHqpFB2IyBXNFyar89xE+S+d0EIUooPSV4i+KH2WOLoB3BPVk9j0D16ViS/W3uCIFSC1JlyxM5ygDV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zCp8iZn0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zCp8iZn0; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zCp8iZn0";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zCp8iZn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687703;
	bh=vVEK0GSJaoCwG2Za91HLPjZg7UQMCEGU0esr8mYEJlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zCp8iZn0wruZA6QRDOppLwGkeu//9jFlOqR7wh1waBXbIepnFq42DTx8iq+0X42QJ
	 cSn4RcvEiTZuM9/TlSEp514GH07138fX5oDFFnTdRDatr9k4Oao9n/TrzFM3H3OeM/
	 k5QqnB6oq+ZXrzUYfpGQ5TbL7P8Yi3fKK/ZeAza6bnswmu1O8+Lrd3tGR4QCA+F4Kl
	 NGraYj5+yqo8B1odw+gBeMtbYSoeXuwusBgSbF8XPB01wMiiTWR5SQ6rcWlsfu+mKY
	 8itYeGYgpfVrBuLg8s+rx94ratBIcxX4XSngvYXXPXhKhqTGgfmbdvJZ6CjzNek8As
	 K9FfX80nC03xw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id F10F14964E; Sun,  2 Aug 2026 16:21:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687703;
	bh=vVEK0GSJaoCwG2Za91HLPjZg7UQMCEGU0esr8mYEJlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zCp8iZn0wruZA6QRDOppLwGkeu//9jFlOqR7wh1waBXbIepnFq42DTx8iq+0X42QJ
	 cSn4RcvEiTZuM9/TlSEp514GH07138fX5oDFFnTdRDatr9k4Oao9n/TrzFM3H3OeM/
	 k5QqnB6oq+ZXrzUYfpGQ5TbL7P8Yi3fKK/ZeAza6bnswmu1O8+Lrd3tGR4QCA+F4Kl
	 NGraYj5+yqo8B1odw+gBeMtbYSoeXuwusBgSbF8XPB01wMiiTWR5SQ6rcWlsfu+mKY
	 8itYeGYgpfVrBuLg8s+rx94ratBIcxX4XSngvYXXPXhKhqTGgfmbdvJZ6CjzNek8As
	 K9FfX80nC03xw==
Received: from [192.168.1.146] (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E838F4949C;
	Sun,  2 Aug 2026 16:21:42 +0000 (UTC)
Message-ID: <7786144d-0c65-4ad0-a489-ae3656c42aa6@birger-koblitz.de>
Date: Sun, 2 Aug 2026 18:21:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 10/12] ax88179_178a: update driver information
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-10-2cf1f71b1dd2@birger-koblitz.de>
 <158887d9-50ee-40b3-a801-4ac98428c723@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <158887d9-50ee-40b3-a801-4ac98428c723@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2026 21:45, Andrew Lunn wrote:
>> -config USB_NET_AX88179_178A
>> -	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
>> +config USB_NET_AX88179
>> +	tristate "ASIX AX88179/179A/178A USB 3.0/2.0 to Gigabit Ethernet"
>>   	depends on USB_USBNET
>> +	select PHYLINK
> 
> It is possible 0-day might complain about the earlier patches, the
> build failing because PHYLINK is not selected. You might need this
> change in an earlier patch?
Build works, but nevertheless I moved the select PHYLINK to commit where the
dependency is introduced.

> 
>> +	select AX88796B_PHY
>>   	select CRC32
>>   	select PHYLIB
> 
> I don't remember the logic, but it could be PHYLINK selects PHYLIB, so
> you can remove it here.
PHYLINK selects PHYLIB so only PHYLIB is needed. Fixed in v5.

