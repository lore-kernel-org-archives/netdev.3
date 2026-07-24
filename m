Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398F311969
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896501; cv=none; b=CDcFpPRGM5XeGq7cnHH2lsmCRm8Pz4ilVAosRaZDJNwFAlvoBlG6ws7ID/SwPQHeAfBBjbiLcqTi/fJYIEel/PU6jALVa/qtKz97giUewUrvKS1SnF1SfwlKK54wBPs3IEvZwBHLCGu00c35g5dLzujMGhGwBF1SLd0MGJsR8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896501; c=relaxed/simple;
	bh=0bzieDLWFf9b/fJba5INCeNnZRpOgAiZxaxQmCuRncs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mVboq1XVmDJmtA03mfz9+eieX9/JRtFDycujBHm63eF5X9I5sb65ZZEF+r4CSSphoiKGARCucS2QdQ4LNNMyvf5PojGAAmJ1+m9uZlTFpmXicDah1HvLL7LrnRFUEqWYm0szvYpiS1YtUWvOeDiUn4lFysA1fFj5YSz5MK7l+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49579f38cdbso864535e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 05:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896498; x=1785501298;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HshsXu2TBpfbHWoo35zhht1bkIl85XgLoEfkPwp3Fvs=;
        b=MrgTCPkKci7SAB+VIneX5L1VpOKVv9T/Ry9oX1muqGRPLxi1GU9jxTcQK4PdltJ8Hf
         jJG0leQP2S10BHTqaHNTHZ3qx9NYYFKOiLXA8uT76dSnPu5XhjuY3qN/M6ukN56+52JM
         O61ZmxEEShy9Q4433lAtaoTM7EOXTRS3xTptA8Pe9HYKUikNohSjCkX/vKE3ZVbqicr3
         ThuEHDMTs62gI6houQH1uvfVP1O1J8KrghPX18y/An3WAqLAlLfcpd7Ct2SNC0IrPw5v
         h5KFH9Ov0VpmeN12x1fs09tl+ciZGVRDJspws5rzdORvIEcf5elDdRtQYMVOC9RqrQpB
         Bs3A==
X-Forwarded-Encrypted: i=1; AHgh+RrFFOlINvibm/sIUBAg7aERnPXSsAVf622jywzZFL5g8PefWDaQkQhQaH5T0VSj9qDqBpnwSLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKSGBYXKqRAxj6VWLv6vikMPFeO4nJaGZ9xTNhVVBQfjnNSql
	JJ6x0jtYWfB2kzI6zdmxkJntixnCUBUNHWnEuDlnSzgR2HKaGAtwinnY
X-Gm-Gg: AR+sD114rUI+SdRFyvM1vEK2r5nq5SJmTMSZZjaBBofoN5v1bYeCfPuEy8s4WQ1JtQV
	ogrKPGViiy3EiZY30kd4YAm68yHKJ9fSPqt2uSaV4NYKoe9LFEvjVtduJ4BYSA8Jy1Mf4SUYaVx
	ecsMDt25kEgwLvdmCJ7gZnEaMTLuyQDE3uhpOl1qt9CvdVf4cJyxFmF222GvSbvz2cYuF7RnCjl
	s/NsjZ6i9oDh2eWMtIMc7I62NuOuzVoCaBcqZfFb66HqqOauY5jjO3m+DwnS5miSxCOZx4Cdm/J
	iW8gK43xSfygWNZvp7Vb47ekvsgbeMvLtmr/17sYEBMlTwU9HSPnqzUPy62kxK7+5yrPFbfv4zM
	+cVwWRFW5TIMB376Kw/oTFQZDodXpxPRmUtLJddGYObkAcT8XDIhomaQw6R34YO7u7B7lruPa/6
	iFkI0eZ8kKPpw/40oEvz1iUcbuFvs9Y/jNBjXOyUI=
X-Received: by 2002:a05:600c:4652:b0:495:4056:9473 with SMTP id 5b1f17b1804b1-49573d08826mr50668635e9.28.1784896497229;
        Fri, 24 Jul 2026 05:34:57 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bff4784sm46669205e9.4.2026.07.24.05.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 05:34:56 -0700 (PDT)
Message-ID: <efa2ca7b-ee6c-4758-832a-727c7c417c04@ovn.org>
Date: Fri, 24 Jul 2026 14:34:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, aconole@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com
Subject: Re: [PATCH net v3] net/openvswitch: check Ethernet header length in
 key_extract()
To: Eelco Chaudron <echaudro@redhat.com>,
 "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
References: <20260723233757.96356-1-blbllhy@gmail.com>
 <8082BACD-66E4-4C6C-ADA6-92231F1ECF39@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <8082BACD-66E4-4C6C-ADA6-92231F1ECF39@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 12:12 PM, Eelco Chaudron wrote:
> 
> 
> On 24 Jul 2026, at 1:37, Cen Zhang (Microsoft) wrote:
> 
>> When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
>> ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
>> it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
>> key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
>> of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
>> for MAC addresses and parse_ethertype() pulls 2 more, either of which
>> triggers a kernel BUG in __skb_pull() when the linear area is too small.
>>
>>   kernel BUG at include/linux/skbuff.h:2848!
>>   RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
>>   ovs_flow_key_extract+0x419/0xa70
>>   ovs_vport_receive+0x222/0x390
>>   netdev_frame_hook+0x3e0/0x630
>>   tun_get_user+0x2d0c/0x38e0
>>
>> Fixed by adding checks in key_extract() before pulling the Ethernet
>> header.
>>
>> Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
>> Reported-by: AutonomousCodeSecurity@microsoft.com
>> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> 
> Hi Cen,
> 
> Thanks for the new revision.
> 
> The doc comment for key_extract() also needs updating.  It currently
> states:
> 
>   * The caller must ensure that skb->len >= ETH_HLEN.
> 
> The comment should be removed or replaced with a note that the
> function returns -EINVAL when the frame is too short to contain an
> Ethernet header.
> 
> One more comment below.
> 
> Cheers,
> 
> Eelco
> 
>> ---
>> v3: Use check_header() per review, fix format issue.
>> v2: Moved the check into key_extract() per Ilya Maximets.
>> Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.com
>>
>>  net/openvswitch/flow.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
>> index 66366982f604..fc4002353e17 100644
>> --- a/net/openvswitch/flow.c
>> +++ b/net/openvswitch/flow.c
>> @@ -911,6 +911,7 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
>>  static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
>>  {
>>  	struct ethhdr *eth;
>> +	int err;
> 
> Since err is only used in the else block, it should be scoped there:
> 
> 	} else {
> 		int err = check_header(skb, ETH_HLEN);
> 
> 		if (unlikely(err))
> 			return err;

The 'eth' is also only used in the 'else' block, but defined at the top.
It doesn't matter where, but I think, we should keep them together.

> 
>>
>>  	/* Flags are always used as part of stats */
>>  	key->tp.flags = 0;
>> @@ -926,6 +927,10 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
>>  		skb_reset_network_header(skb);
>>  		key->eth.type = skb->protocol;
>>  	} else {
>> +		err = check_header(skb, ETH_HLEN);
>> +		if (unlikely(err))
>> +			return err;
>> +
>>  		eth = eth_hdr(skb);
>>  		ether_addr_copy(key->eth.src, eth->h_source);
>>  		ether_addr_copy(key->eth.dst, eth->h_dest);
>> -- 
>> 2.53.0
> 

