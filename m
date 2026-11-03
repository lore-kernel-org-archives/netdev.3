Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732194;
	b=IOMwqt7nmFfOZ/Hr3RnF15ZtcROw9UIj10ECGhX49BoZkWYlw2lUrGu+U6qhkZotZOJJ
	 vd1qkGdLRxwo8sOrlo9qwbCVgZcYA3m5H1wVXYxYzBHmNAWhkxl6ThQ4oEn/tWolVkRks
	 pBVZAivQOHsCFnEwW/Q+z4E6S5qqzs3TljtXeMd709s/UtMPCJ1rt9zTQJfSKzv0d+Mt1
	 dwEeSxZ0jxjvW7YvP8mcN8HViHnItyAxYACN4BOtHKDxDKhM04CnxbwpGKdxVwH9yXuE6
	 DhLmd2t4U+E6k6UCm3I6thYIsbpmelzkURhcOyDuSu8XpDC507mCalBkTBCfSkFRrHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PLO2xwfCocrBevVIKEHkd2tUmUVJORQjvzNZ7fJWYoM=;
	b=31P2CnwtIuAxzZJOik0eRpkoCKdBDKKXZoki8C99BH8rANlyL11GpJ7bYqO8JS+YoR7S
	 AJTZhTBKu+eEmPUKDC3kHz0kTFeubgDl9VaaNLFsVNVaeJBZeVqjsLsaDwsewh+8BMd2G
	 NNiCNl/HYM2YkwMi7/L7wUB5Ru5R4IlwRAZI3vcVdPxJUFbTyKkqZqE3ud0apKBHZxpxw
	 UwG9Bnsx7M96d5xQkRy1hAPeu13tPJRvf6k7uHPJXD5DziNpIJ6uKRk/pjdO8r589pfys
	 VwqC3sVeg959djoNyyhI9A3P7XKEiTwTMFN0WkNHDU8tzkhifwVnTD4DoWp4sqB0MEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n28IUoCz;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514B606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4514B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n28IUoCz
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso50447465e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732193; x=1794336993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLO2xwfCocrBevVIKEHkd2tUmUVJORQjvzNZ7fJWYoM=;
        b=n28IUoCztPkOlL+/CXAG4SBObTW9aBGn/U7mFufsMhv/WPJsvUzl/Y6EqWzrh/yGMW
         dYc1WEPIQTohl016wkl+7KVSesl3V4AGRbXYsfN0tYCwm8bz5o6U/URwCHKOX+FIX4T/
         GWlhtg0Q/00gYJvxUKYUM6E4FtU3NVKe9eu7j0f/NURbl1DXRbxXy9ztlVNXEoCbXUx9
         fOZSJJ8pFblx/PPGxTa2J8wGhNZ9s3lyNWlCo+odAyFRAie9E73Xw2s7OvCrHueVWmkO
         8XSVuuU2/Yef8nXN5srjPUpuxNQJnwF4UKGmSVNBoTiiSk5X8Y5fWD19N1i+grIMF9hm
         rRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732193; x=1794336993;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLO2xwfCocrBevVIKEHkd2tUmUVJORQjvzNZ7fJWYoM=;
        b=q5/hN5DpEd9Rq0TbypX/RdY6Fnr4dtd218UbV3Dyvedr9lEXqwCJkRt5IO3N0qyzAz
         Zid8WAxArKdW1vpH1TB5LLPpaAPfMtW1bQGii06Wl/PLXJOR7U8AcaKe5hujAqwZJO/y
         Kju+sOzmmahT/p1/0/14ccH4LfP7QSdx2Lc+Om0CI+Bb7YLVnajDysI5sN3534LLm7rQ
         wZf7q2p0KV44kGcrNkZcvu5EVKXIbdLtUQkVOsLcv14HbfzpeEVvc5x22/aD/KCoorGI
         IlnqpXHvVRlGPXj6uMvVW0BRXJZr3vhnAYO5fOge4bJviaw0bkfrE68nAHTjoh9DIaHI
         iZCg==
X-Forwarded-Encrypted: i=1; AKwUvBwhTTBmnbNtBpresg8KQoKuMKUwTaGqTdnQ5YqBWCCaWBxx8s7a0FKDuxln3ZfGMvso6+O5fdE=@vger.kernel.org
X-Gm-Message-State: APuU4Z//sNN4fvJuHQ3e4t4+9jTyyyadSC4/hE4NrT7yLxN2C12L9Fsk
	0t/E93/9sx8rZMnSeqCBD5OMOfPNU8jTBuefwAoEk5SQmC9bgDrpasOf
X-Gm-Gg: AYBFou0VwMUjywzqMzaUKODyQmxh8CSNSt4nL+Qq4+r/NWF32s0WyOi72gSkz0Y2ofG
	EyIAg5CEBVCtHkcax09eg+KsWAezZy08Nm33vImZNiXLHijyDTlq1S5ZMVrvnKdZTzOga/Gv63P
	ewmqnWm6ThuN1CCVcBlw3jkhafph1HdB0pEgNFA3C0DaWrkk3MbYod4tASBghSt73yE8/ArdimZ
	WLVbgQWBAMLfW+vp1C08L1N+6zs58F4Es1oCWosm+CuuIzrB1XgzEVpjFisn0MAlpPLXv3Em9cT
	lvJCz9o/B/XHGLgr1bDMQthPefil6izlMbvBnmbKh7uZpyXGLDKJFwLiZesxoyOcRsEQYp85xsf
	mYjIf8yU3rJUakUG0DdIl9cntQIuv1LoCIS02qll+Q2v+Q3vQOmBUtN++RX6B6scWG72cLcSyGc
	2e9tcwkXhh7TNV1ybQCW+8Hu+MjQlK0+wwNZCBzMkrGY1hRRaTSL5B8rH7HE+/Rq90GLlrxK1qW
	kxpjR88YSy54OOqs35V/KzfDec6Q1jNOK28DBTuwlzpxx5XWwlxX4nP14iZF9v3y/SU91I+VD9r
	IP807CS/BeZjKmaZenJkR2W/9t2WEgpw1Rk1WFSUqSOhkcVSghIYx2zWdR10TJuxF8XKIH2tfGg
	jrqLf6l9eyPykBdugkOi/aChj
X-Received: by 2002:a05:600c:628d:b0:4a1:e01e:1927 with SMTP id 5b1f17b1804b1-4ac17d16a1bmr319846245e9.5.1793732192587;
        Tue, 03 Nov 2026 10:56:32 -0800 (PST)
Received: from ?IPV6:2a12:26c0:4402:6300:8cdc:cc88:9490:1614? ([2a12:26c0:4402:6300:8cdc:cc88:9490:1614])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9bd5d9fsm76736105e9.15.2026.11.03.10.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:56:31 -0800 (PST)
Message-ID: <f909ccfb-0bad-4ad2-a5d7-d836f4bbc958@gmail.com>
Date: Tue, 3 Nov 2026 18:56:30 +0000
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
Subject: Re: [PATCH nf] netfilter: flowtable: do not clear the offload bit
 twice
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Sven Auhagen <sven.auhagen@voleatech.de>,
 Oz Shlomo <ozsh@nvidia.com>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103-flowtable-offload-bit-v1-1-20f5952c00a1@gmail.com>
 <aunoySCHzqwI1QIz@chamomile>
Content-Language: en-US, pt-PT
From: =?UTF-8?Q?Jo=C3=A3o_Silva?= <jgc3silva@gmail.com>
In-Reply-To: <aunoySCHzqwI1QIz@chamomile>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

The fix was LLM generated but I wouldn't say it's just "for correctness".
For some context, this issue was hit while developing hardware-offloaded 
flows for the RTL930x target in openwrt. There was a point in 
development where this was causing flows to pile up and eventually 
exhaust the TCAM of the PIE engine on the switch.

Thanks for considering.

João Silva


On 03/11/26 13:59, Pablo Neira Ayuso wrote:
> On Tue, Nov 03, 2026 at 09:52:56AM +0000, João Silva via B4 Relay wrote:
>> From: João Silva <jgc3silva@gmail.com>
>>
>> An expired hardware flow remains in the flowtable until its asynchronous
>> hardware deletion completes. Teardown clears IPS_OFFLOAD_BIT, so a packet
>> can create a replacement flow referencing the same conntrack entry while
>> the old flow is still waiting for deletion.
>>
>> The next GC pass calls flow_offload_teardown() on the expired old flow
>> again, clearing the replacement's offload bit. More packets can then
>> create additional flows for the same conntrack entry. A pending hardware
>> work item can also delay deletion and expose the same repeated teardown.
>>
>> Commit d2d31ea8cd80 ("netfilter: conntrack: fix erronous removal of
>> offload bit") closed this window for software flows by unlinking them in
>> the same GC pass and made the conntrack state fixup one-shot, but
>> hardware flows stay linked until NF_FLOW_HW_DEAD is set.
>>
>> Make clearing IPS_OFFLOAD_BIT part of the existing one-time teardown
>> transition, alongside the conntrack state fixup. Subsequent teardown calls
>> must not alter the offload state now owned by a replacement flow.
> Let's better target nf-next for this, this looks like LLM triggered
> for correctness.
>
> Thanks.
>
>> Fixes: e5eaac2beb54 ("netfilter: flowtable: fix TCP flow teardown")
>> Signed-off-by: João Silva <jgc3silva@gmail.com>
>> ---
>>   net/netfilter/nf_flow_table_core.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
>> index 0d72dc8ae47a..709b55b74cc7 100644
>> --- a/net/netfilter/nf_flow_table_core.c
>> +++ b/net/netfilter/nf_flow_table_core.c
>> @@ -398,9 +398,11 @@ static void flow_offload_del(struct nf_flowtable *flow_table,
>>   
>>   void flow_offload_teardown(struct flow_offload *flow)
>>   {
>> +	if (test_and_set_bit(NF_FLOW_TEARDOWN, &flow->flags))
>> +		return;
>> +
>>   	clear_bit(IPS_OFFLOAD_BIT, &flow->ct->status);
>> -	if (!test_and_set_bit(NF_FLOW_TEARDOWN, &flow->flags))
>> -		flow_offload_fixup_ct(flow);
>> +	flow_offload_fixup_ct(flow);
>>   }
>>   EXPORT_SYMBOL_GPL(flow_offload_teardown);
>>   
>>
>> ---
>> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
>> change-id: 20261103-flowtable-offload-bit-f15bfd1d38ed
>>
>> Best regards,
>> -- 
>> João Silva <jgc3silva@gmail.com>
>>
>>

