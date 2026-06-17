Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FD29AAFA;
	Wed, 17 Jun 2026 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661650; cv=none; b=Y3E9z9cAZMKs2VuTe5xW/d+wsc7dTPypjgvzt7MplGCIWom+u/ejqxQtm1s8VQsAakW5BIziITwxLdQrQ08krDCt69rmgtOp2QTT6qh9dilywtP6vyuQ5LrZpLWB38jkgLNKXHCBVfopt44fZe5m3CJexgsibpScqVEWOswaoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661650; c=relaxed/simple;
	bh=rCPhsZcrKw5TsOjAfX/d+Cp5oPcxTcO+6Nx2NEFoyN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOQpJ96Q2CtqINKAKFGYiyL+jjgdDrVRbZn92NTLSXWqxBw5F9LmWQVtFQ0wVRnmkb9l7l9EBv7qYdB/Z6BozGBIom2k9lNx+H9dUgViHKiVi5ZEusTLniIDvhjzHRexP4BAk5YV9LmKtBKjFIE/nhzXsD1D4w03sDfSY5wDt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08501174|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.283752-0.0045549-0.711693;FP=7057726590387724033|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.i-7sWza_1781661640;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.i-7sWza_1781661640 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 10:00:43 +0800
Message-ID: <adc1dc4b-1d9d-42e6-8983-f0a7c650a6cd@motor-comm.com>
Date: Wed, 17 Jun 2026 10:00:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: mmyangfl@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, de.ge@motor-comm.com
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <3f7bf73b-c8dc-451d-981f-5e5343291960@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <3f7bf73b-c8dc-451d-981f-5e5343291960@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/15/26 19:34, Andrew Lunn wrote:
> On Mon, Jun 15, 2026 at 07:12:35PM +0800, Kyle Switch wrote:
>> Add yt92xx dsa driver supports yt921x and yt922x switch series.
>> To support more switch series in the future (e.g., yt923x), the most common configurations are abstracted into switch operation interfaces, due to yt921x and yt922x share similar register layouts and operational logic.
>>
>> - Merge drivers/net/dsa/yt921x.c and the new yt922x support into a
>>   unified yt92xx.c driver.
>>
>> - Add support for yt922x, which can operate with either 4 bytes or
>>   8 bytes DSA tag.
>>
>> - Not change yt921x behaviour but use common switch apis
> 
> A 35K line patch is way too big. Please break this up into lots of
> small patches, each with good commit messages, which are obviously
> correct.
> 
Thank you for your reminding, this patch will submitted  in a series 
of small patches.
This patch mainly contains three contents:
1. Underlying function interface for different motorcomm switch series in 
the file driver/net/dsa/motorcomm/switch/.
2. Optimization existing yt921x dsa driver using common switch function apis.
3. New yt922x dsa driver.
Can you accept break this up into lots of small patch according to this logic?
if not, do you have any suggestion? thank you.

>     Andrew
> 
> ---
> pw-bot: cr
