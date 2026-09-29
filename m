Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28003632;
	Tue, 29 Sep 2026 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642830; cv=none; b=tg2xscBkNRS8nsADIz34NOj2JKGQCLwMpGSb/hdE/1cgxrZ6ZsC05ETCmCzSirN5DErf6OmknbjtaCzVgkIbLG9r2H8oE6ivWVc6FW3qLl9hCoj9Kw7xljDMHtTFquM0SWepWe8+ZZsY6KZ+1asjPPDLQzKtxf0Q2Z6AHq/x2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642830; c=relaxed/simple;
	bh=yr7R0yAqqrRxcBqE3AxsER9xJKKPZMEBP1EWS2WVllQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9kQGabayHQTU4GNXejB6O+pCN4PMpfNqEsnpFi28FLYNvgxIzaEeoJUTQvIxH04LUQ522hIrybpPRd2720I4wvZmXg8hjX7JnuMYwSaaBlMUd3djC8K5JjOJUrVcE33B8nQDn8ZP5DeMxQW6qvaqvpI3CUDN3M2E7LrgXEyX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1717306|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.091997-0.0167288-0.891274;FP=16849052104064075120|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.jQih9rx_1790642818;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jQih9rx_1790642818 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 08:47:03 +0800
Message-ID: <b7065fa7-ffb9-4358-baa9-2aa48b0a2033@motor-comm.com>
Date: Tue, 29 Sep 2026 08:46:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 jie.han@motor-comm.com
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
 <20260924-vowed-roulette-abda42cec444@spud>
 <c78999ec-82c5-4719-9358-5dbded43ccdf@lunn.ch>
 <415c6c1c-f59e-41c7-9045-22f20408a7f2@motor-comm.com>
 <34fc057d-17e2-4693-971a-63898708545a@motor-comm.com>
 <648ae914-e116-4417-87c7-5726e63fc6d9@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <648ae914-e116-4417-87c7-5726e63fc6d9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/29/26 00:54, Andrew Lunn wrote:
>> What we're trying to express here is simply whether it's a phy8824 built
>> into the switch or
>>
>> a standalone phy8824. In both scenarios, there is one 10G serdes outputting
>> four UTPs,
>>
>> and the only difference is that some operations are slightly different, such
>> as soft reset,
> If it is a different PHY, it should have a different ID value in
> registers 2 and 3.

They are the same phy and have the same phyid, but for the phy built

into the switch, performance and issue fixes were made based on the phy8824.

>
>> power down, and power up. How should these two types be defined and
>> identified?
> More details needed. Why does it need a different soft reset? Why is
> power up/down different?

For the standalone phy8824 scenario, performing a soft reset on the UTP

requires an additional soft reset and isolation of the SerDes address space

to prevent intermittent packet loss after link-up.

However, the phy built into the switch does not require this step,

and the same applies to power down and power up.

In addition, there are differences in the initialization configuration,

so the driver distinguishes between "internal" and "external" phy.

>
> 	Andrew
