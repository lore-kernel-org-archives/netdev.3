Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9C2BE7AB
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960384; cv=none; b=IQFWP3vn8XpQfue70pVayK4jaGFh+LdjFHz6txqLrWQpOMGfp/B4FMerlMscND6goZxz3RRtjN4dPFo5+qrB7yvhUygyGW96i7y4jS50HjlZmlrv8WV6FKn5j8HDQpVZUCK3IYCfu0/1EV62Iz1cyqydDWOJgvpmYdVpkxgYNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960384; c=relaxed/simple;
	bh=kYwPJHefIcd3j/mUVBOTLl0dZ495s6fSJBX/6Kc2h1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emdMU5wdwwNg04UQ8bEJ2b1L9KEbfXR+xm8jruhomK8+R7USk0Veka/gREqZxBxpjeBhprqhzRQYC1qxQlV06olwoqEFZXn8ZMuEXMSL84Vj4LiUgGlLEULOL9fFuSS0DCKtfmzY1puxP4NTSoCk0eSqACq0oFYI6JYIVtht82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iFmxSval; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFmxSval"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kYwPJHefIcd3j/mUVBOTLl0dZ495s6fSJBX/6Kc2h1c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789960380; v=1; x=1790565180;
 b=iFmxSvalnUslZXL0kd8YNNoLzaBa6WM5AMIYEcBAU4SzYoaLQlJNiHmSGnlRf9Mmhd6NcGPK
 Tuxsv3uozIZFNuh+agf+QiU9WpUcxnNlgyf0fY9l5IAkuPyBuk/gdeiziuF09cQgnAsLsHNwgZp
 B/4FYyHB35Aii+KH0+CqwxYE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 47738e8af7178da5;
	Mon, 21 Sep 2026 03:13:00 +0000
X-Mizu-Trace-ID: 47738e8af7178da5
X-Migadu-Flow: FLOW_OUT
Message-ID: <8bfe6312-79c2-495f-a336-e96360c26998@linux.dev>
Date: Mon, 21 Sep 2026 11:12:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] ip_gre: Reject enabling collect metadata through
 changelink
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tgraf@suug.ch, pshelar@nicira.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260917095016.71937-1-xuanqiang.luo@linux.dev>
 <20260920102659.GA1897785@shredder>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260920102659.GA1897785@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/20 18:26, Ido Schimmel 写道:
> On Thu, Sep 17, 2026 at 05:50:16PM +0800, Xuanqiang Luo wrote:
>> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
>> index 82309efd417e0..7b1b0f17f60b9 100644
>> --- a/net/ipv4/ip_gre.c
>> +++ b/net/ipv4/ip_gre.c
>> @@ -1464,6 +1464,9 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>>   	if (!rtnl_dev_link_net_capable(dev, t->net))
>>   		return -EPERM;
>>   
>> +	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md)
>> +		return -EOPNOTSUPP;
>> +
>>   	err = ipgre_newlink_encap_setup(dev, data);
>>   	if (err)
>>   		return err;
>> @@ -1496,6 +1499,9 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>>   	if (!rtnl_dev_link_net_capable(dev, t->net))
>>   		return -EPERM;
>>   
>> +	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md)
>> +		return -EOPNOTSUPP;
> 
> Both functions have extack, so please add a rejection message to make it
> clear to user space. Something like:
> 
> "Enabling collect_md on an existing device is not supported"

Thanks for the suggestion!

I'll address this in v2.

> 
> Also, I assume you audited other tunnels and confirmed that they don't
> suffer from this problem?
> 

Yes, I checked the relevant paths in other tunnels and found no
similar issues.

Thanks,
Xuanqiang
