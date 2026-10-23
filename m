Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765824;
	b=IAw6b/oM9QQOw1o/iZgNEBzlop8ATYTku6KT/sXnXT0rGB4GmLVQC39rJqBpEHOuFHIj
	 NupaK4OXKKZgr/Kz8JRIofngBJXTnlWVQGEiLjTjxoIko1uYumXvX6iGKsv34MZbLiGHQ
	 DnZ2RGZ46GmIGGLZ7eLWN9wEDMkj40Br/y7Tf7my4x7fAr8sOFOHXLUNwGoK1of3ScAtN
	 CD18Nq8OnIXn/PJ08mUTC1yqmXySfAIhFHQt6ZzWg+8+8AOxo0HcmebC7VZMgVEzl38fO
	 JOZrHl8bBNjOWxdAFEBVhMDpKWogq6eBZFWP6OXnATcBQZOvmXgMnZmcp/bxdFS971A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765824;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q19RkNdvdKZfvvzc83oRnTfA/45ChJc0dIPYMhstJII=;
	b=YmaW4iuu5I0xXQPP30traqRVoWgsh2mPPRSFvw59cD1XxrcYv6V9qi/1px8s0+OkkHYM
	 lRE2M+xnqMuLqPlmarGT2WyePqyZ0mCP06vo5F3fu5jGn2dsPf9MH+dOl2SBg+aymHAEa
	 Kp99J4WH/QQJlgoUWuh4bAdts0AB284oSrCme2ifyg9oN5ktUbcegPbcex7swnOyxNijY
	 j1H5+TVn10T/0yS2aKYHCUD8VFYmH2m9DC1NtRM0PRPSGb69q2GSJ68cLlZvhkXAkXZBJ
	 QYizsAReKk4LngH+wuYatg968i8ZJDRMFsoFwrW7RSCnaEjX14JRz8hD7TJPaNZErng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k3pjAgHg;
	arc=none smtp.remote-ip=95.215.58.214
Received: from mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19955606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19955606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k3pjAgHg
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QkcatS4DUjgzNkAwRB16tzNFXXT1nPzIZUkqpGpZ14s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792765821; v=1; x=1793370621;
 b=k3pjAgHgYsLIRxQBcdFSer+LE5OnuGJ3OE5BOl84/3/RIHVIYsitCwGCmxV6HltaC/xYc0v8
 WbajW2iIx8mHJvzF5hJB/k5no1yfZ3XY2a8pmfKtQOg9KYHFIaaSBSxyDGAJpxHegpx0Ly5B9tI
 fUmS/izzsyfyDh16XE3i5Ej4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e015806712496f69;
	Fri, 23 Oct 2026 14:30:20 +0000
X-Mizu-Trace-ID: e015806712496f69
X-Migadu-Flow: FLOW_OUT
Message-ID: <50b46cec-9f95-42dd-8e97-5555897df4c3@linux.dev>
Date: Fri, 23 Oct 2026 22:30:03 +0800
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
Subject: Re: [PATCH net 5/5] net: restrict message_cost and message_burst to
 non-negative values
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Joel Granados <joel.granados@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-6-jiayuan.chen@linux.dev> <attQGnJGhzTPFsMd@hobbes>
 <27876dee-435f-4ea7-afed-69f8366e1c62@suse.de>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <27876dee-435f-4ea7-afed-69f8366e1c62@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/23/26 8:55 PM, Fernando Fernandez Mancera wrote:
[...]
>>>   #ifdef CONFIG_BPF_JIT
>>>   static int proc_dointvec_minmax_bpf_enable(const struct ctl_table 
>>> *table, int write,
>>>                          void *buffer, size_t *lenp,
>>> @@ -544,14 +560,15 @@ static struct ctl_table net_core_table[] = {
>>>           .data        = &net_ratelimit_state.interval,
>>>           .maxlen        = sizeof(int),
>>>           .mode        = 0644,
>>> -        .proc_handler    = proc_dointvec_jiffies,
>>> +        .proc_handler    = proc_do_message_cost,
>>>       },
>>>       {
>>>           .procname    = "message_burst",
>>>           .data        = &net_ratelimit_state.burst,
>>>           .maxlen        = sizeof(int),
>>>           .mode        = 0644,
>>> -        .proc_handler    = proc_dointvec,
>>> +        .proc_handler    = proc_dointvec_minmax,
>>> +        .extra1        = SYSCTL_ZERO,
>>>       },
>>>   #ifdef CONFIG_RPS
>>>       {
>>> -- 
>>> 2.43.0
>>>
>>
>> I would prefer something like this [1] (not tested and not compiled).
>> This is more in line with the patterns inside the jiffies.c file. I put
>> SYSCTL_ZERO there, but I have a doubt if you actually need SYSCTL_ONE.
>>

Thanks Joel and Fernando, good to hear this.

I actually had almost the same proc_dointvec_jiffies_minmax() locally at 
first,

but then thought "this touches sysctl core, better not" and went with 
the local handler
instead.

Glad I was wrong about that :)


>> If the interval variable can be zero, then leave it as SYSCTL_ZERO, but
>> if it cant be zero and can be one the use SYSCTL_ONE
>>
>
> FWIW, I also like this solution and indeed we can convert other users 
> in the future.
>
> About SYSCTL_ZERO, I believe it is the right choice. AFAIU, it just 
> disables limiting.
>

Agreed on SYSCTL_ZERO. interval == 0 is the documented "never limit"
case in ___ratelimit(), so it has to stay allowed.


> Thanks,
> Fernando.
>
