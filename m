Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510F3905EF;
	Tue, 11 Aug 2026 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786412041; cv=none; b=TVTDX2Cb9pLBxhiwMmH6C8oGNo8zZf5kbBKz9C4yYicNEQBBb92ZwcxuM2YxKjar5gbPYSXSMtAxUVJ57JywAUfdT7WELjcUQggbmbZoVjFRGuc2nzQfzRI5x/VW3pFV97z9OOL9UKwP8JKdms1Oq7i/mzRnPV4nBl/di4ilKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786412041; c=relaxed/simple;
	bh=cx+dghINrqzqnmKmxlWwuHzktHIXFYYDzEYg7vUCn2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfAAuD0tFLAxAOx9F0O8nam5tHVn1mp5ix4XAjkUITseMy1ofUJ/iFdkgATRHdqVz4GHwYUIgr0NbypZ5CmBhLDD9F2OZYsUAHvEVNZPSWWZLIYsIInl/bYmWQqDrF76FuHKq/UpZhNwQY8MvFX3M5bceIauCv44xyooU9q6o8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b17c7f78952411f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d7860fb8-09f1-4175-8369-4a85802bac96,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d072583e4b61755fd164900d5335b3fd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b17c7f78952411f1aa26b74ffac11d73-20260811
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 687498474; Tue, 11 Aug 2026 09:33:45 +0800
Message-ID: <4f91fe40-f52b-4939-9ad4-101091f31f30@kylinos.cn>
Date: Tue, 11 Aug 2026 09:33:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: calxeda: xgmac: Fix use-after-free in xgmac_remove
 due to race condition
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e556148b7a938f83f8470bb3bde5b856eb9ba271.1785809990.git.xiaopei01@kylinos.cn>
 <20260810144359.6e609a22@kernel.org>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <20260810144359.6e609a22@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/11 05:43, Jakub Kicinski 写道:
> On Tue,  4 Aug 2026 10:21:26 +0800 Pei Xiao wrote:
>> In xgmac_probe, &priv->tx_timeout_work is bound with
>> xgmac_tx_timeout_work, and xgmac_interrupt and xgmac_tx_timeout can
>> both schedule this work on system_wq.
> 
> AI reviewer reports that this can add a deadlock.
> 
> Looks like we're trading one bug for another.
> 
> If you don't have access to this HW or ability to test your patches
> in general - please don't try to send such superficial fixes.
Sorry for making noise. Does this issue exist, and does it need to be
fixed? If it needs to be fixed, I'd like to learn how it ends up being fixed

Pei.
Thanks.
