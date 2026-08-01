Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855963B6361;
	Sat,  1 Aug 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785556359; cv=none; b=RTFsxW5YLF0prhA/3fWESOwcq8tU6QEx0bBs7Davy0Q6L6FZwins0oDEqcDn8DvJMKaRvu49FSlFKdsjDfxTtCsq+MIXohT945Th2QklH4WW3+qG2i37YBns3t9gmhyhPNAHNeeb+7KeV8cuTe6r9ovuYrKPE9p5cuMzN8GvRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785556359; c=relaxed/simple;
	bh=YKO6tBHtflyXnuygFXrt5i6jeYnXcytgothyFemBrqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIcst3KCQmYUPKM+5NQ2ta72mSOkfpuolTeIxiDj7FqJAGZAQQjbSc4UESt3i5OjqEoUggg0J+zgVvgC9c3fR+Ua7LPTVyKZrSjMYvb6uPjxNjUxPSKoKzUzFvkkfDd7+Mjlo9v9znNe0VDDgOQ+soiZKh6cD60QL7EdGUWRPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2571354|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.024018-0.00187039-0.974112;FP=7779716363265822576|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iaxtLza_1785556337;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iaxtLza_1785556337 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 01 Aug 2026 11:52:21 +0800
Message-ID: <59e09b03-5143-4f00-a1e9-c435adc84c82@motor-comm.com>
Date: Sat, 1 Aug 2026 11:52:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260728112105.2668014-1-kyle.switch@motor-comm.com>
 <20260730153527.34135188@kernel.org>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <20260730153527.34135188@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/31/26 06:35, Jakub Kicinski wrote:
> On Tue, 28 Jul 2026 19:21:05 +0800 Kyle Switch wrote:
>> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
>> 2.5G/1000M/100M/10M speed
> 
> Missing some kdoc returns:
> 
> Warning: drivers/net/phy/phy-c45.c:1293 No description found for return value of 'genphy_c45_template_testmode'
> Warning: drivers/net/phy/phy-c45.c:1293 No description found for return value of 'genphy_c45_template_testmode'
> 
> Plus at a glance you also added stray semicolons after functions?
> 
> Last but not least, Sashiko/Gemini has 10 complaints, please check
> these before working on v8:
> 
> https://sashiko.dev/#/patchset/20260728112105.2668014-1-kyle.switch@motor-comm.com

Ans: fix done in v8. add missing kdoc returns descriptions and fix the complaints. Thank you.
