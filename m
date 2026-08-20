Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B051F936;
	Thu, 20 Aug 2026 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787188387; cv=none; b=YW4S5miAFPhOb7AGIPSj2Logr+BsjgA4gEC9CI3+GeRE30u9/chPlWUuO1bgG/3T+s206ZXTXYd6CxWjC2NHW17zjnAIftoVywLe9GzaztbX39BKVzH0Gjp5rP90dE6w/7nZWbF4BN61niJUvd0H77nQo+LRiOtlUv6apBCFDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787188387; c=relaxed/simple;
	bh=alycrwax1ApRbZrvEFCeq25/JjBjS7ORwUa1Ul0jusU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQ02eVVQ9dz7EG4s/oyBRf0jl43vL5DAhp7LxNF7DuHOZ6l85Dmk8jS40CEZmZkbi6B17sza1U+Z7ZQLc8wp139Yi42kZGojg9cyvPSSzTRGkRkpbOvutWyGpm+xoOMylgr0pZl6jNkF1YeGmTDJnqYcGnTV8gKxxTItx9bQVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4059632|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0437227-0.0013014-0.954976;FP=18300229563451494223|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iroNJgg_1787188358;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iroNJgg_1787188358 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 20 Aug 2026 09:12:58 +0800
Message-ID: <6327f6c2-65f8-45d6-b890-0f371ba8e36b@motor-comm.com>
Date: Thu, 20 Aug 2026 09:12:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260817110626.510277-1-kyle.switch@motor-comm.com>
 <20260817083748.05f798ba@kernel.org>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <20260817083748.05f798ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/17/26 23:37, Jakub Kicinski wrote:
> On Mon, 17 Aug 2026 19:06:26 +0800 Kyle Switch wrote:
>> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
>> motorcomm driver, using the phy_package helpers for the shared top
>> extended register space.
>> It also adds a new exported phylib helper,genphy_c45_template_testmode(),
>> plus two new definitions in the MDIO uAPI header.
> ## Form letter - net-next-closed
>
> The merge window for v7.3 has started, and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We will only consider applying net-next patches which were posted
> before the announcement:
>
> https://lore.kernel.org/20260816155953.072d73da@kernel.org
>
> Fixes are obviously welcome at any time. net-next patches may be sent
> for review and discussion only with an RFC tag.
>
> Please repost when net-next reopens.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
Ans: OK.
