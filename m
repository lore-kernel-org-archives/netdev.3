Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC293A9624;
	Tue, 21 Jul 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634476; cv=none; b=MSh2ZNWjAwJAdy6pTn0uJnmXN/LqcASoTIAQ/r+p0lxWv4oj0sTn/9YKSY0MTako8sLGsxKiPo2uzfnf9p1QqAv4g/Acz1zP0zeUbnCK5uMZVi4dwSy6a76gv1d5T6SrL5fqvC26ZVu3El95Oj2+fbjytLY84fQ/0moUxTergLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634476; c=relaxed/simple;
	bh=L32HEm02gVF7ShcP+ZfBczXOS2ka/iG45HHXwutcFME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knlknXH7mWU3SWu9gsyCVPW9U5Ljf8FDp43DzkLf9GfyuiLfPdmSoqyRplDCpkygdqnNZwvvDDd1P3/25bk68wxVI0Imz4z5jJrvzdUg0RfUpCznPyhatjM6m7kb34xRMWLdnvVfhgXhM3ECMXc0TIv7OQmNs7oQKquBAvsu+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2134279|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.102994-0.00897745-0.888029;FP=17217071092951213143|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iR3ycKt_1784634463;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iR3ycKt_1784634463 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 21 Jul 2026 19:47:44 +0800
Message-ID: <ae2384a7-1fb5-4a58-87f2-ee81ed5e6d47@motor-comm.com>
Date: Tue, 21 Jul 2026 19:47:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260720091133.2438175-1-kyle.switch@motor-comm.com>
 <cafd8d43-7f76-44d8-a579-670d911f9b91@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <cafd8d43-7f76-44d8-a579-670d911f9b91@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/20/26 21:48, Andrew Lunn wrote:
> On Mon, Jul 20, 2026 at 05:11:33PM +0800, Kyle Switch wrote:
>> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
>> 2.5G/1000M/100M/10M speed.
> 
> So this is better, however still not correct.
> 
>> -		/* Enable WOL feature */
>> -		mask = YTPHY_WCR_PULSE_WIDTH_MASK | YTPHY_WCR_INTR_SEL;
>> -		val = YTPHY_WCR_ENABLE | YTPHY_WCR_INTR_SEL;
>> -		val |= YTPHY_WCR_TYPE_PULSE | YTPHY_WCR_PULSE_WIDTH_672MS;
>> -		ret = ytphy_modify_ext(phydev, YTPHY_WOL_CONFIG_REG, mask, val);
>> +		/* Enable WOL feature */
>> +		mask = YTPHY_WCR_PULSE_WIDTH_MASK | YTPHY_WCR_INTR_SEL;
>> +		val = YTPHY_WCR_ENABLE | YTPHY_WCR_INTR_SEL;
>> +		val |= YTPHY_WCR_TYPE_PULSE | YTPHY_WCR_PULSE_WIDTH_672MS;
>> +		ret = ytphy_modify_ext(phydev, YTPHY_WOL_CONFIG_REG, mask, val);
> 
> Look at these lines. What changed?
> 
> As a reviewer, i review diffs. Changes like this are just a waste of
> my time. Please review your own diffs, look for issues like this,
> solve them. I won't give comments on the actual code until these
> problems are gone.
> 

Ans: sorry, the diffs issue is fixed done in patch v5.

>     Andrew
> 
> ---
> pw-bot: cr
