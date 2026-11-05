Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917716;
	b=KrWHy/i0nnqF0gli3iFlSowEXj/b7vvgVnPlW8Zjmt54E5GKsCraWQh1Pa19+BpVv3fr
	 fF712chwf4UkM6Yr8hVWdAPdyW6PHzJZvkq3IeZRWOG3JYuXQDrWr5g6pyreMzZqfzXQV
	 Eq0gvGHErKB5AqAPfol+b+yAlat/GS7m9BXRJq/MhL2k8XFjUkfgdek6efllgRWrBee/6
	 8iL4HiAsyNnESBLnBe7lI77dnx4lk0RhXBmTmCtkvEXJ+uAzt2cnJ5OVQJ/qTdS5JzIQ5
	 mUHI2dx5+7mgjTnK+zyxPa+nRbfjRgvlnkSr5EZr3XC4tgXHb8V23fwSP6tK4CyJvXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917716;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=teFZI5ZT0tF3baaZ5GsOyIljCJ7tSwWYOvxyzPD92zg=;
	b=hPxFREOAXJ2JWW+77XWdJwAf25tpPS2eYGF8s275uzqdUAEwi5rxcq5lAa8X6NRq0Njl
	 OcqfJFCXejgXQvhWMdTu0athwuwP+dfZDYfjevCs1Klv4LTGgQYbuHxipP0C9/Gtlrxbj
	 0W62d6GXd5NLGlPOjC6rqYo1QIbgwnkWWvCAjjbj9Ohms8ulJ/xOEwGOrQlzJKoP480IW
	 eFr5gCoSriGzM6znc3nj+BaKOD4Oip8TbLUMQftaOsluq+gC1IuWo9XjBd6iPh9V7HMd1
	 wjX2BIXKqPg7k17Hs+nNEkJYOG7wLsVgGPm1c+/w9m9AUeSGdSmU6zK1MNPcdl23Odg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k7n7M399;
	arc=none smtp.remote-ip=95.215.58.250
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2C606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D2C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k7n7M399
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RMLKgoqWLv73HkP/fp6tsjHhZlyH0aziusIjVEhYzLc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793917714; v=1; x=1794522514;
 b=k7n7M399r7CdMfhJhF/pQNTZZqYvtpZ5ydqHsfEf5gRKfF0w1BwoyoTUp8hvxCpvWS/4D3Rf
 i1fTkZZUMvgSHD0rDEzCJjgyyMjFBfe+ITXArBI7XdY9xiOjdkRFyAR52IKEFBXRgiCAvjQwjzK
 AoklpAN/HvcQSj5OTb4mFcLY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8774a739f2d0ed26;
	Thu, 05 Nov 2026 22:28:33 +0000
X-Mizu-Trace-ID: 8774a739f2d0ed26
X-Migadu-Flow: FLOW_OUT
Message-ID: <6c36ec6d-5bc8-4ac3-8ad0-79eac7873b67@linux.dev>
Date: Thu, 5 Nov 2026 23:28:31 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
To: Breno Leitao <leitao@debian.org>, Ali Tariq <alitariq45892@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Chukun Pan <amadeus@jmu.edu.cn>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Tomas Hlavacek <tmshlvck@gmail.com>, Muhammad Bilal <meatuni001@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <auyG7hGJtMzV0Gbi@gmail.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <auyG7hGJtMzV0Gbi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2026 13:40, Breno Leitao wrote:
> On Thu, Nov 05, 2026 at 05:34:37PM +0500, Ali Tariq wrote:
>> The emac_resume() calls the emac_open() and emac_suspend() calls
>> emac_stop() functions directly without holding the lock through
>> rtnl_lock(). These functions rely on phy_disconnect() which reads pointer
>> with rtnl_dereference(). But since no lock is being held,
>> rtnl_dereference throws a suspicious RCU usage on
>> Orange Pi RV2 (SpacemiT K1) warning when lockdep is enabled.
>>
>> WARNING: suspicious RCU usage
>> drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() usage!
>> Call Trace:
>> phy_detach_internal+0x490/0x5f2
>> phy_disconnect+0x90/0xc0
>> emac_stop+0x114/0x626
>> emac_suspend+0xac/0x126
>> platform_pm_suspend+0x72/0xe4
>>
>> Hold RTNL lock before emac_open() and emac_stop() with rtnl_lock() and
>> release the lock when functions return with rtnl_unlock().
> 
> This would work, but I am wondering if it would be possible to call rtnl
> inside the _open function, when dealing with the PHY? in other words,
> shrink the time rtnl is held.

+1, especially in emac_open() rtnl is needed only in error path case
