Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199030;
	b=JIJple5MKEFuTMt1Pxk5O533RzQaEjoS43X7dfS6+2yTsCJnwIX+jjeNrmt58BY2NtIe
	 Kwk7nHw9hDHWDv0kpiUBbaIEo2pxLQ2Ebhp+e3XsEiYPEGTT5C/ZHlH/GtM0c6hOXTMB4
	 l73mgDouU3N7Et4U8hgcyyapXSJ9NaSZHag/EVFntgFOHkNqcz2KEn2lfHC84AqQlzeA0
	 U7CbQUSCWNW0okc5UKva0VA7HfTrpRAQ+KDtKdt9rVdOC+HqRjwRVvFLwzjZvmjeUO+Om
	 AdYBoBW8SfKxbd5l7RwXNOAeGlek2+4UoG9Jm+DrE5bL6t11cIN3/SkMx81NbaXzwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199030;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=znXIT2Q+xpYTpHdwKPmA4jz6YR4BPArNsNj4UZeCH/4=;
	b=4jyh8kLBcIZ7Kqgamh34LIWScYjMfLH1Jz1Na0J/qgA1v3DC/3LzmF8HnWpmsxtWxAjs
	 II0SZJ7igPXX1Rz77jYbEPDI2Ayz6ekdAuvSHtaXIOYBOYWNhQd1ZszarzxwQtE/+EzMC
	 4QT71xhlyybpJCPd1iaV2Jy1CjfpRTxvsTmGIghY5mNWjrdjwG1NK7hEvAKtASPerXUE0
	 p4t/zd6gh7vmYnLy6rLQrvq5XXgI408s6JBKnNk84RaOEnaqYNFvZ7+eF1VcXC7kII3qE
	 PGo5Zn58EweyVKPKVFvla2HLAWZHwXy7isajIBFpBHxx+CvkZYSC4b7lm0Nqvi+ukaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOJyYo1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74847606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOJyYo1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1C81F01825;
	Wed, 28 Oct 2026 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199030;
	bh=znXIT2Q+xpYTpHdwKPmA4jz6YR4BPArNsNj4UZeCH/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mOJyYo1f8wkSapvZVbAeFZLtOqhjB/Bddw54csGuAMLZ17nBvtLQJA1dvU/0g1Drd
	 B14EAH7t/n4nPTwusfBT4z1Y9e5skT0sXWGh76sfwv47zXRTsYDwzFEHXsvg3LbEsW
	 tqlBzXv9Vp6ZE125Yl0+jxuDRAmS0xJtlyf/rXF1uZLDRHH569YPWMJqU7KtdYsD3x
	 8JV7RuSr8gC9qLEY4le2MofZficENCzgrXHKRKgPI4BfAzqA3UAQx/FEj7WIAlmQRU
	 qGlvUrJ7qoIK5NNoH6ZOcSpQM2l0CXmp5NqPQqsZlrFXlyxxgp1rjNETRbLW75KEry
	 W8l4DmYcMkCeg==
Message-ID: <b0e685c9-ad2e-4414-b59d-9dff7b0bfaa3@kernel.org>
Date: Wed, 28 Oct 2026 08:50:29 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: l3mdev: Set OIF flag only when an L3 master exists
Content-Language: en-US
To: Daniel Machon <daniel.machon@microchip.com>, Haon KIM <akrn112@naver.com>
Cc: netdev@vger.kernel.org
References: <20261024175746.2341-1-akrn112@naver.com>
 <20261026083005.edngrb7gs52ouhm6@DEN-DL-M70577>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261026083005.edngrb7gs52ouhm6@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/26 2:30 AM, Daniel Machon wrote:
> Hi Haon,
> 
>> l3mdev_master_ifindex_rcu() may return 0 when the device is not
>> associated with an L3 master. In that case, l3mdev_update_flow()
>> currently sets FLOWI_FLAG_L3MDEV_OIF even though flowi_l3mdev
>> remains 0.
>>
>> Set FLOWI_FLAG_L3MDEV_OIF only when a non-zero L3 master ifindex
>> is returned, keeping the flag consistent with flowi_l3mdev.
>>
>> Signed-off-by: Haon KIM <akrn112@naver.com>
>> ---
>>  net/l3mdev/l3mdev.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
>> index 5432a5f2dfc8..92b48d6a4301 100644
>> --- a/net/l3mdev/l3mdev.c
>> +++ b/net/l3mdev/l3mdev.c
>> @@ -279,7 +279,8 @@ void l3mdev_update_flow(struct net *net, struct flowi *fl)
>>  		if (dev) {
>>  			if (!fl->flowi_l3mdev) {
>>  				fl->flowi_l3mdev = l3mdev_master_ifindex_rcu(dev);
>> -				fl->flowi_flags |= FLOWI_FLAG_L3MDEV_OIF;
>> +				if (fl->flowi_l3mdev)
>> +					fl->flowi_flags |= FLOWI_FLAG_L3MDEV_OIF;
> 
> Looking at the readers of this flag, it does not look like this does much, so if
> anything this is a no-functional clean-up for net-next, I guess. The commit
> description could be more specific about this. Also, the target tree is missing.
> 

Example of a failing use case?
