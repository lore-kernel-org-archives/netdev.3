Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B293364059;
	Thu, 27 Aug 2026 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832029; cv=none; b=eQcoEux4sW39mrpdY08uKbwL2BubZvfwSU9RM7bc99uSP8NJFIDCWDWLYVHjqmNoJUKNPQCYJLxFrKLXoAUYljx15JRXxIxj4yhybnJcELlxD0wk6g8fqoZt2GBCckFNIL8S/3ME9QIXqx7GrLRVZvxkp3zonZfS6ChbQLavzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832029; c=relaxed/simple;
	bh=0A56trFj6J5konV9Y3shHgoQU8d0EbnJfG+xPjR0fIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qW0kh27G6hzv1389hb39Vr8nRBIs0ODISI8kvpaJcuzHXvnae6cL0aokfVlYyG73WB41ChGWrgsf3M4lD6X2eCMS25vsmPMMPSjDs17kesTBGZGQJ1JNVzLV/Blzb1+ZRrCuW989QeEjzKdCLIuDz3B89He9fRg1TOYTu96tByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08164567|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.084389-0.000296656-0.915314;FP=7742681021160765058|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.izQFyu0_1787832015;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.izQFyu0_1787832015 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 20:00:16 +0800
Message-ID: <0c8024bc-c444-42ea-83fc-88446c8c560e@motor-comm.com>
Date: Thu, 27 Aug 2026 20:00:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/2] net: dsa: Add support for Motorcomm
 YT922x
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
 <20260825061610.3116673-3-kyle.switch@motor-comm.com>
 <55523ac4-023b-4ed8-8519-293c778044a4@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <55523ac4-023b-4ed8-8519-293c778044a4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/26/26 20:43, Andrew Lunn wrote:
> On Wed, Aug 26, 2026 at 05:08:02PM +0800, Kyle Switch wrote:
>> Motorcomm YT922x is a series of ethernet switches including:
>>
>>   - YT9224: 4 * 2.5G UTPs and 2 serdes interface
>>
>> This patch just add basic func for a working DSA switch.
> I asked you to break this patch up. I want to see lots of little
> patches, each with a good commit messages, each obviously correct.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> says you can have a patch series of up to 15 patches.
>
>>   static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
>>   {
>>   	struct yt921x_priv *priv = mbus->priv;
>> +	int max_ports;
>>   	u16 val;
>>   	int res;
>>   
>> -	if (port >= YT921X_PORT_NUM)
>> +	max_ports = priv->series_info->ports;
>> +	if (port >= max_ports)
>>   		return U16_MAX;
> What did i say about this in my last review? This would make a good,
> simple patch, changing all YT921X_PORT_NUM to priv->series_info->ports.
>
> You first need a simple patch which adds struct yt92xx_series and
> yt92xx_series_table[] with very minimal contents, only mode and name,
> for the existing device. And add the code to do the lookup and
> associate it to priv.
>
> Then you can have a patch which adds .ports, and changes all
> YT921X_PORT_NUM to priv->series_info->ports.
>
> Then you can add .num_lag_ids and change all those references.
>
> Then you can add .ageing_time_FOO and change all those references.
>
> Slowly make the existing code more generic by adding to struct
> yt92xx_series.
>
>      Andrew

Ans: We intend to split this patch into smaller functional pieces and submit
them as separate commits.
I would also like to seek your advice on a design question.
For the yt92xx_series_info table, the maveall reference design invokes
chip_detect() inside probe() to perform the matching lookup.
However, in the existing yt921x DSA driver, chip_detect() is called within
dsa_setup() instead.

We are considering two possible approaches:
1. Keep the code as-is and relocate the initialization of certain
dsa_switch structure parameters into dsa_setup().
2. Refactor by moving chip_detect() into probe() to align with
the reference design.

Which of these two approaches would you lean toward,
and what are your considerations?

> ---
> pw-bot: cr
