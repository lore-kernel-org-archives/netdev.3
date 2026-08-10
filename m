Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC2330301
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786327289; cv=none; b=nAoUgsNWfAx9DVUkFRObGcRoPoEpOm5n651zwJx20+0TXVmMpX1rDlH4BBx4HQ//kkmB5donC4fT2IDNDTL1KsaF4w1iYZgt22RQI6G/TIVswtLLf4bmbra+lTQwuMjoMcFiFI1H0AGIbt+nljNM3VO8WHqDMJWlMoNdPjlCsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786327289; c=relaxed/simple;
	bh=Tv0zLmDeyTEBTC/Bsc9TLlppJY9tcTDER5w6lsnWK/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdfrdQLni+o2UYsMNiTIuIdVvHQUVk824e0xCMz0ByGufe/n65pOeeMLvnu6XYURclFi55z53MC6j3gVIkSLQJ+H/cuyu3Dv4wEoTPLp5sDfMWOjzukQ9GesbzwbOiF9YeuSvxd1WNICiHpGnI2RYxPFV9roXnMSTI9rs65zrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OR97nI7d; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OR97nI7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=kHWJYk34ETFXOP89G8WuVgapFZS/H61rmp20OjWEYlY=;
	b=OR97nI7dS2iXMGnjgR7Er9BsNkd4mWeP2GyBVkVTXH3/8uHIAHzX5zcSFSLaQ7
	QmBfxJwyxrkp6JJWxJ93jMpKqBTHYXYk8O8CWqt7Ct2bwoNcEiRe/CvzMNoerTy3
	lAc/QHNIA5EvbDg5Tv3We5ZW8t6ddT4dYbFpDgm3nLg78=
Received: from [10.42.20.136] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCXfXrRMHlqQXuUNA--.59973S2;
	Mon, 10 Aug 2026 10:00:50 +0800 (CST)
Message-ID: <09030f3e-811c-48a8-ad9c-6bf9432e73e4@163.com>
Date: Mon, 10 Aug 2026 10:00:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tap: fix incorrect variable used for USO check in
 set_offload()
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, kuba@kernel.org,
 jasowangio@gmail.com, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>,
 Willem de Bruijn <willemb@google.com>
References: <20260807070914.112698-1-clementwei90@163.com>
 <willemdebruijn.kernel.2e2d53367799a@gmail.com>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <willemdebruijn.kernel.2e2d53367799a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCXfXrRMHlqQXuUNA--.59973S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF45ZF45ur45JFWrAF47Jwb_yoW5Xry3pa
	1UAa12yr4vqryjka1UAw10qrW5Xws8Ja9rGF4qya4Fvr98WF40kFWS9a10qa4qg3yUWFy2
	vFy2vFy3A3Z8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfnY7UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-hQ6pWp5MNS-YgAA3f

Willem de Bruijn wrote:
> Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> The USO features in set_offload() incorrectly uses feature_mask and
>> features argument.
>>
>> The USO feature was written to the local features variable instead of
>> feature_mask. All other offload bits (TSO, TSO_ECN) are stored in
>> feature_mask which becomes tap->tap_features and is used by
>> tap_handle_frame() for GSO segmentation. Without NETIF_F_GSO_UDP_L4
>> in tap->tap_features, making USO on tap effectively non-functional.
>>
>> Keeping the USO handling inside the TUN_F_CSUM block avoids enabling
>> GRO/LRO when userspace requests USO without CSUM.
>>
>> Fixes: 399e0827642f ("driver/net/tun: Added features for USO.")
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Substantially changed patch, please don't keep Reviewed-by tags across
> non-trivial changes. That said, I do agree, so adding it again.
> 
>> ---
>> v2: Fix more incorrect variable in USO check.
>>     https://lore.kernel.org/netdev/20260806163949.2807698-1-kuba@kernel.org/
>> v1: https://lore.kernel.org/netdev/20260805072121.117472-1-clementwei90@163.com/
>> ---
>>  drivers/net/tap.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 5d2d34d24ce8..d4ca2fee538b 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -883,7 +883,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
>>  
>>  		/* TODO: for now USO4 and USO6 should work simultaneously */
>>  		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
>> -			features |= NETIF_F_GSO_UDP_L4;
>> +			feature_mask |= NETIF_F_GSO_UDP_L4;
> 
> Drivers/net/tun seems to have this same issue.
> 
> Do you want to take a look or shall I?
> 
Hi,
I have check the code in drivers/net/tun.c.
In tun.c, the tun's all offload bits go into features argument and
I think tun.c does not have this issue.
> 
>>  	}
>>  
>>  	/* tun/tap driver inverts the usage for TSO offloads, where
>> @@ -894,8 +894,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
>>  	 * When user space turns off TSO, we turn off GSO/LRO so that
>>  	 * user-space will not receive TSO frames.
>>  	 */
>> -	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
>> -	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
>> +	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4))
>>  		features |= RX_OFFLOADS;
>>  	else
>>  		features &= ~RX_OFFLOADS;

