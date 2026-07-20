Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDE21D3F5
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530476; cv=none; b=q0hczYqfG27ViBKQ8oYlc+ceIwh5c3y+yN8VDdpSdWOQOl8GKCBJm7NYS3PHCQJ1JXH8uPWGRD0/P0PdGGbybbWj/y8gw686wnOjj3a+jq9l768c6K9ximpSqLSDMypqCFzu6oF8kO0OKXuWtgqBemSbGckDMwnvE1Yj7yzUwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530476; c=relaxed/simple;
	bh=z3bbyhhhzQUxDfoECqZtOhTOVMYr6T9kQ00wdus9LjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUlT9YiaZmtP4ZNTvsLzVUvoRBp09S4a/ou7f447wjFM3cCmkn+oo9pgwyyyCw4ZJiDmWlWEquGP/V1xR3lAoFv7005bWthK8ndIidjI0dAoW5g8MuluZQFtM3N8kVo+ZLJdW4nu2qT07RUwVv0F6NazyhylrJWlxNSyMvLD8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+wOWkAW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+wOWkAW"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845c92bc464so5620188b3a.2
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784530474; x=1785135274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pduYoUwdDsokgxOFp/drM7GxSBVCnkImfvtB1gPwtRk=;
        b=H+wOWkAWkV5o5mWdXfOq6YUJ8MoTE7hk+I8ojy/mPfK7D7bmk6QIMXnfY+bhiAcUwr
         HtxHQcqYAsFHqknTvVpGHO5ao6Jg0o/w2TgX+EA3bXqhp5zgf+CjJ0Hn8h1uXFYEtwv7
         /ES4JImUsElWbOLF3nbhHU3pjGxOrxeZglCDNTCJ3Lfv7SlWIwhe8sHNwiQ2si7Po1Es
         HNuqp3QW3IrKKn29zyGmDuweEjpt9A+c/ESb4NQ5NLkmTZXS/YCUnYjTB/5ayP4nEjGi
         llc1kYar3i7+zI8NBq0y0HE/tC7InL1axfbla+9bzfdhp9+cmTtddeVWzCT+3giftacU
         gu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784530474; x=1785135274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pduYoUwdDsokgxOFp/drM7GxSBVCnkImfvtB1gPwtRk=;
        b=q82UQqRtNnB3jYnwyosiu1V1/hJ5cBs1iKmuCpL1zc11y2QtYC9ATZK+nU+MLm8QBG
         FyqnXz/vIgsuhPRka3DNBitWRYf8SqlAJtvVaPwZWH/PVN61/KJBVbWqF4m6qZ6GW6KN
         qz9dYajQDLo5d3GHF5cA0e1IPkpMvw3PxoRJ+9YsGRW1AVp1lKpD1ntT9qjQCpMQ4veh
         zSCmZEIW3CimOwL9dktcRpQN1SXxn7Nl2VC2CGev/1sbaBlpyswu7ZBNNGZMW0cfp0R7
         0/duaBNKOI0KYRdm+KC3HS0X62XhTKI4j/OflJjoSXkB+uDov8bGuurbkbIsD+6E01aQ
         uqIQ==
X-Gm-Message-State: AOJu0YwIVXlDYfMJsWlJW0iqcPPMOAOhZfl6mO3QMSA+V6rZJF40YKwy
	bCz3ZhsM5mJpPNeA15SqPhBab1Ba5cK1jVqEKMFGtzCAsK950VVaOU8+
X-Gm-Gg: AfdE7cngdRNs9IY66L8IkDqr02FZPiSFiBpqEQDiBDpxZvEWiITRwXtdjXnzmJn3eN/
	sBU09HnsP5qyeVjFms3wBavo8mLM1ilfRiw2Ild9Xa7/e8LuNZyaFfUsIPjWBFXisG+BSMDpnxM
	ly1TgNVOd6QqwUFLZiKMQ8YpsESkO5HfINzFHA0peSIqRs+PVSrGTT6Y7X2wdwXYGq3q9oAPd/Y
	2G4PhHqcY4ccKdL/gJWASqACtXTF6g2TNqIh1ANYXIQKbuPE4cmFfsO3ZyvXszKaiScRCSaH2EA
	4qMkfb11ZlEKFfEjUinoq2MJzLe7FRco+5V+v+VGJlSYJNtGGDleUvW9PL70sZ8JTL61i8dGMq8
	r3PJX9+bugj1fYnuvbAjySTX8jDK1oW2gz8dvb7RJEZsN4MHHlEaBl/nORbPSxrZ6NYGTTmMKXL
	+Y7Edmq8LX53eh3SXX7V3KnYb+AUxB2ycrgkf/6gOKAMi+LP+nrPV7+SEQl0s=
X-Received: by 2002:a05:6a00:228f:b0:845:3fe5:cddd with SMTP id d2e1a72fcca58-84c29501125mr13089871b3a.36.1784530474395;
        Sun, 19 Jul 2026 23:54:34 -0700 (PDT)
Received: from [192.168.4.59] (c-73-93-246-205.hsd1.ca.comcast.net. [73.93.246.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af7acf4sm5057772b3a.51.2026.07.19.23.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 23:54:34 -0700 (PDT)
Message-ID: <0c037f98-f219-4851-9a06-e83b25ca0f7e@gmail.com>
Date: Sun, 19 Jul 2026 23:54:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] openvswitch: Fix CT limit teardown use-after-free
To: Andrew Lunn <andrew@lunn.ch>, Ren Wei <enjou1224z@gmail.com>,
 xuyuqiabc@gmail.com
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, pshelar@ovn.org,
 yihung.wei@gmail.com, tonanli66@gmail.com, xuyuqiabc@gmail.com
References: <cover.1784355642.git.xuyuqiabc@gmail.com>
 <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>
 <c357f846-d42c-4b98-acc9-46b751818dca@lunn.ch>
Content-Language: en-US
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <c357f846-d42c-4b98-acc9-46b751818dca@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/19/26 19:52, Andrew Lunn wrote:
> On Mon, Jul 20, 2026 at 10:14:16AM +0800, Ren Wei wrote:
>> From: Yuqi Xu <xuyuqiabc@gmail.com>
>>
>> Packet processing uses CT limit state under RCU, while netns teardown
>> frees that state under ovs_mutex. The CT limit pointer was neither removed
>> from readers nor protected by a grace period, allowing packet processing to
>> dereference the freed state.
>>
>> Replace the pointer before freeing the CT limit state. Wait for in-flight
>> RCU readers before freeing its contents. Serialize CT limit netlink
>> operations with teardown for the full lifetime of their state accesses.
>>
>> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
>> Cc: stable@vger.kernel.org
>> Reported-by: Vega <vega@nebusec.ai>
> Is Vega a person?

Hi Andrew,

Thank you very much for your review!
For context, we had previously understood that using the tool name in
the Reported-by tag was acceptable, based on examples such as
Reported-by: AutonomousCodeSecurity@microsoft.com and Reported-by:
Anthropic.

https://lore.kernel.org/all/20260630171016.11c02dec@kernel.org/

Of course, we’re happy to adjust it if a different format is preferred.

>> Assisted-by: Codex:GPT-5.4
>> Co-developed-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
>> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> Please take a look at
> https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> and the sections that follow. What is listed here does not follow the
> rules.
>
>> @@ -932,11 +932,15 @@ static int ovs_ct_check_limit(struct net *net,
>>  			      const struct sk_buff *skb,
>>  			      const struct ovs_conntrack_info *info)
>>  {
>> +	const struct ovs_ct_limit_info *ct_limit_info;
>>  	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>> -	const struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
>>  	u32 per_zone_limit, connections;
>>  	u32 conncount_key;
> Reverse Christmas tree. The lines should be sorted longest to
> shortest. Yes, it was already wrong, but you can actually fix it here.
>     Andrew
>
> ---
> pw-bot: cr
