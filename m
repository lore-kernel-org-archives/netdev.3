Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11103189F30
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621700; cv=pass; b=smdONX6KpBaIM5+qd9uQw8EFqW6pPBpc3nwjOBTXEpV2REHD5BAEBwXIwxvdPAN1cCmjiiAAW816HJVLrJmByCEbm4hqBaPSMcwkXap7GEKyDw0tfkQRaUSlr3OKTUCvanCrRkNYzS9OYyeorBisnT+DdkEQcOLhEumWD5tO2N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621700; c=relaxed/simple;
	bh=GvV59eBdxld56I5X31PLktQWXaHT7jhzZAMQSrPqyMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mijviCfMkel/vYsSWWXkJiHpnPbC8k2T83QxrTNLowyiQLYOOESOIh/H4UTMjA1rqY6vZBXhBU9TmDOV6O8avKTyowN7zyY1ncDz+rsW8dMw9GGQ6gRpp2vGPSBLRVBZcdnRXADuwhxzzQTjiK6BhIjluDFo17LLCRqnn0r48hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=XmSFbrZN; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="XmSFbrZN"
ARC-Seal: i=1; a=rsa-sha256; t=1771621684; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WCdWoPVFjKs6rdyWza9Md79mpgZpn1ly/UoY9JEPrJWagEsI5olPec6uwZzBqXHiL3+3k1yxwumvTcpO9Y3ezPX8OrsRyBNHSLPvBchGJUzodRG5iDD6P6UEW18XtPc2o8yPYX4yRpU6y1f3kQY4WoLSA+urscC9FJf1f6gg55E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771621684; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bGM+gCacbYuXeZf8ZH1UL2Z8qZZrsQn7OOOvmqoIJqA=; 
	b=JB1JFlmQhsJx5Ir4w1ZtUDhGb0wgbtkhIb25jT7WWfuv1tEU1XN0zJe+GaCR1BxJaEJUT0H4IIPyUcbgbrxcjJfpgvdPT+nE+YGTX/BaRARU5BdYMgcZWjn/pGvfErqPNcU+dxWRO2Hnd6HfHwvhHapPQqyvxaAi9gHD2Q/NtOk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771621684;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bGM+gCacbYuXeZf8ZH1UL2Z8qZZrsQn7OOOvmqoIJqA=;
	b=XmSFbrZNoHcQaShZ8p1nDjkHaEbWBDTXyE0S90o/+D3YCrOzJkWBYUo49+Wog47+
	xxSalltZmr9YhH2xx3tgcWcmJM0K5apQWZj0uEGBdP0y9LtPjIDZMo9/BMnPI9ooV5z
	VmjjzrBDyM+VX38cgnBV5lTsonCZn87ruoXbQvXYrrbctdpift77K32FeU2UlJUD5Rw
	SmZwyCP0pmD4VGE/zl7/NzuNnLQ2GY96u3hyWIFt+yIhwvlJymiXxZIJIiFI5TySDMQ
	Gt2Rp+PRcrdQ6x/9CA8FZUfiDpc7soSzE3LQNczIL+RQZbhOwlfPCSSo/VxWGQpqD2u
	GAbv13hdww==
Received: by mx.zohomail.com with SMTPS id 1771621680245463.21299397499763;
	Fri, 20 Feb 2026 13:08:00 -0800 (PST)
Message-ID: <ba6f7455-154f-4f9e-ac26-b3276fe3d01a@machnikowski.net>
Date: Fri, 20 Feb 2026 22:07:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] netdevsim: Implement basic ptp support
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org, milena.olech@intel.com,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20260219140530.2148-1-maciek@machnikowski.net>
 <20260219140530.2148-3-maciek@machnikowski.net>
 <20260219124222.211385c5@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260219124222.211385c5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 19/02/2026 21:42, Jakub Kicinski wrote:
> On Thu, 19 Feb 2026 15:05:30 +0100 Maciek Machnikowski wrote:
>> +	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
>> +	if (gen_tx_tstamp) {
>> +		ptp_info = mock_phc_get_ptp_info(ns->phc);
>> +
>> +		/* Create a copy of tx skb to keep the tx reference */
>> +		skb_orig = skb;
>> +		skb = skb_copy(skb_orig, GFP_ATOMIC);
>> +		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
>> +
>> +		/* Timestamp as late as possible */
>> +		if (ptp_info)
>> +			ptp_info->gettime64(ptp_info, &tx_ts);
>> +	}
> 
> Like Andrew said we need a test in tree. But Vadim has been promising me
> a timestamping test for a while, so adding him here. You can probably
> work together (unless you already have such a test).
> 
> When you respin - note that mock_phc takes a spin lock without _bh
> around its internals. It needs to be changed to _bh() if we call
> it form the xmit path.
> 

Sure! Will resubmit with a basic ptp functional test and work on
extending it with Vadim.
