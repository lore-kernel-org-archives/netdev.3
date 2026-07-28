Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA63D522C;
	Tue, 28 Jul 2026 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237828; cv=none; b=WkTXYP4K4UtvOeK4dUzTeuBe68UuxgDqfGcZrW+ydeWjhh6f9AJfceAj9osYrJ29jdYsKVYYe5FYlsyMU1IpqPJfmBgXg4fU6rHGwhSu80K2Mf4VGHhe5WYpvSpcWoc9rVD3z31nar5Koc523N401fdjhkgdU7fkOIiiuOHVVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237828; c=relaxed/simple;
	bh=kcOA4VzVFwyGls2ne7eCc8Jyywupeg2XGSK6/zrDECo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiIExZAdVE7AqLsV0LAijF3ghXngV5FQxGot5D2BIw1ZvMwkAblY6jhYzEWVSJsn3e0S12v1bs7wqXZK1FZy2KKwA7Ma1hUzdssiiAhl8/oIHiq91Mtk/BRq2pF5qosiy2g03Ek9KL+fjwEl4K08Oou49texlslStHPb1N0IKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.30776|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.046873-0.00114969-0.951977;FP=13539818089933233491|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iXTLX6l_1785237814;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iXTLX6l_1785237814 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 19:23:35 +0800
Message-ID: <27ce555a-bb36-4263-a7d2-abe62cab92a4@motor-comm.com>
Date: Tue, 28 Jul 2026 19:23:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260723102112.1155723-1-kyle.switch@motor-comm.com>
 <20260727183853.14a543a2@kernel.org>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <20260727183853.14a543a2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/26 09:38, Jakub Kicinski wrote:
> On Thu, 23 Jul 2026 18:21:12 +0800 Kyle Switch wrote:
>> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
>> 2.5G/1000M/100M/10M speed.
> 
> Does not apply, please rebase on net-next/main and repost.

Ans: i will rebase and repost, thank you.
