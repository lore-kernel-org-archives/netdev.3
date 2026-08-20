Received: from mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F240D59E
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220365; cv=none; b=YBzCLdofKbMUNcemyLXFNDailcbMZgEy6qnA2Ulc1bc6Qh+/ansgdKl74pT8Vu0uB61xPvuu8RwYMuESwbrWPVwlMC4wUVhZEQi9wXDFCl0YqQkaSr1K70PvqP/gb0UpH+QnWDhrz0x2YKrBm5TRx3HYWR3VQPztnkb/xLPHbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220365; c=relaxed/simple;
	bh=eAyt6VIZv/2tKjgXGnbhPQAHwlEf+EAM3k+VmQVwsEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw7Kk7jjNdk30xbHYYR2feOgJZ39gByaYx6FQsO0BQaAlfka606Mb/A/UhYEGpeVkZr7hat+AbPThYoYRFMSOunVl3sNM+mpB7ojIrPJGevanZh/EK5GG4DkxntstgfOx6yJaRld/cFPz+D3yxz6Wyb4reUlVCD+Ww/N+n6fyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KLASX0nf; arc=none smtp.client-ip=95.215.58.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KLASX0nf"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eAyt6VIZv/2tKjgXGnbhPQAHwlEf+EAM3k+VmQVwsEU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787220358; v=1; x=1787825158;
 b=KLASX0nfggvhRQkGISQWwv/lEFJ1amzK24NE2QwbERAufWnoLzMwkiJze2hTYikt88Y2j8CY
 jPf5WZGqxGRpu8gqEtWgC9TWRRQmsSGOVs0tNjyleDuCEKBCn6uIZbYnSYI8gN0hYcSKcNOHxSF
 qMTEL62xmM4xvHKXq0rXXlxM=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id a208d8c5b0986be4;
	Thu, 20 Aug 2026 10:05:58 +0000
X-Mizu-Trace-ID: a208d8c5b0986be4
X-Migadu-Flow: FLOW_OUT
Message-ID: <e1f3d995-3192-45e7-b084-1db89a53d1e6@linux.dev>
Date: Thu, 20 Aug 2026 18:05:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/5] net: phy: split phy_probe() error paths
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-2-xuanqiang.luo@linux.dev>
 <f1fb446a-eb3f-40c7-baaa-62ae961cd28a@lunn.ch>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <f1fb446a-eb3f-40c7-baaa-62ae961cd28a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/19 21:35, Andrew Lunn 写道:
> On Wed, Aug 19, 2026 at 02:02:32PM +0800, Xuanqiang Luo wrote:
>> -out:
>> +out_unreg_led_triggers:
>> +	if (!phydev->is_on_sfp_module)
>> +		phy_led_triggers_unregister(phydev);
>> +
>> +out_sfp_release:
>>   	sfp_bus_del_upstream(phydev->sfp_bus);
>>   	phydev->sfp_bus = NULL;
>>   
>>   	phy_cleanup_ports(phydev);
>>   
>> -	if (!phydev->is_on_sfp_module)
>> -		phy_led_triggers_unregister(phydev);
>> -
> It would be nice to mention this reorder in the commit message. The
> commit message is about "Why?". Explain why the order has been
> changed.
> 	
>      Andrew

Sure, I'll explain it in more detail in the next revision.

Thanks,
Xuanqiang

