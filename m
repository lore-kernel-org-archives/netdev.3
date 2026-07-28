Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89696466B06
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251002; cv=none; b=Mp6hbAaThLnsCWrx0V9QZ2FEBPg5kvzHxOgW4/J8CFUBWxpIKm2GuVvgjw2b1VCnGR0oTFWZOMvTI1TMAT9bQ6pTDNjGfoMiFv7tah0653+tt+I61uhKKIOu4unurjI4+TmM3O/L4cGn1BNIKk6k4pho53k40D00ye43DYSl85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251002; c=relaxed/simple;
	bh=sP+Bfg3GZ6XfV+AEpyNR+YCa8+llRTUeXNAHhiqmgJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1KLeEU7X+wKjtmbpeW5stCQz2F+hxGK/VVfFuqu3apQEPB+wFOn223YbRx0598N3bdHRoC/kNxn3JDWHFaOAvdZvMDSS7ALrZ3An7uvTUfZAYx7nFQ+0Bl3BMgSCKSTM9M3aeuR+Ukknrpq0W5lVuB5D8+pBlT+24DQWmjcjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso15818705e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250999; x=1785855799;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=geCVxd9r8Q3Jpd9kN5SNQitcv8qXZDbPPiW9I3M9/Fc=;
        b=Lmizhk5VLI3rpH19jVjnWnrDMmB4L1ne1YzD2PC22ZKnhc/EFL0UlnKPuG/zFyhQpg
         3cQu3sCsl8FVXkpIQZYWDD5GblDc36qW8VhAjcoAZNv+7Ng79nnYv622Dw1K1ImlGO2l
         boiCaPkDwBj5eK33vsu1Fp+5AVLxxa6ypeJdos3U9szMlMNvT0bLa6chx9jSVAZnOWkv
         HaAJf0ZBly9TH+r9JLBq2wsodZOCJLMewKAladXcpKKpVO4LAV8A5hpMUWsaX59PUJ2S
         TEUG3l9xvf2KHWdzdaSzO5wKC3OL/5l9smBTWEkthIWigKApJsuumAaWBjFk4si0gn9I
         KtEw==
X-Forwarded-Encrypted: i=1; AHgh+Rrj03Tron7Hlf48EXf5NByr8iF7g5oRa0JmxiOaYkZ84wtpFQsc39p/JxbXd9KzvT4uVTsG164=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJr8CiHFrE88kBpIQwCZR+veOu+ijD2fLtR1VZLWVYdxzWe7Jn
	Glqis1B7jXyv8cRmPqMO7IjWF7Cf+hzDTlAs5d13hXREGO5D45gQyRkFukAozN5S
X-Gm-Gg: AR+sD11bQevS12bwGqikqruC8Bf5QGVZT8iXgDwvb8U6RfqVkMQU8LXl6QAGVPyZx6K
	Ya3uRCS4/E6uO3y3Ivw2VXflNF7oTMcIZomJa+KvKNDOGWlD4hVbDPglEbHdEY2Y1OIgJKHLmP5
	/fUgFezw4ILiGEN6G7YD+0wNh2B+gMzbX87DIdMWOLY/NceWdiLmKc0bwE2n4LFhIk0Ev0XTeRV
	2zr47ntVSeTV71IGPJ/G0Ez+osderk4JDq7GGCqpaOMG8jrM8ikMhwUB2Wf9iwloUAUNKIT7Iug
	HZIJ+VCviz8S9C6Cm+KmU7Dc3aCh8dUwcWR58U72UUBQhs2ZHX2m4pHW9ndCmf6t68p9PRz+8HP
	4vkwO7kuiUFdS23YUQdKBIL7OutqVrb4C5eUZ83UeAyBL2l32DmfAYGYEHbsuQ/8dbxmMxSAslT
	XZcJKiOL4ZomYAFtAZsdli1ojkyjaSI5kiHkaip9ltixw07LPXmg==
X-Received: by 2002:a05:600c:a42:b0:493:b4cf:d37f with SMTP id 5b1f17b1804b1-496c655ae85mr32002035e9.16.1785250998447;
        Tue, 28 Jul 2026 08:03:18 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45b1c2asm86104045e9.5.2026.07.28.08.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 08:03:17 -0700 (PDT)
Message-ID: <a56fe38b-5fc8-4845-8d68-d199d753dcee@ovn.org>
Date: Tue, 28 Jul 2026 17:03:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] net: openvswitch: fix stack exhaustion from unaccounted
 clone_execute() recursion
To: Aaron Conole <aconole@redhat.com>, alexyoung0@163.com
Cc: echaudro@redhat.com, i.maximets@ovn.org, security@kernel.org,
 dev@openvswitch.org, netdev@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, horms@kernel.org, edumazet@google.com, davem@davemloft.net
References: <178521875706.803907.3226960398667307795@163.com>
 <f7twlufw4js.fsf@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <f7twlufw4js.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 4:51 PM, Aaron Conole wrote:
> Hi Yang,
> 
> yang zhuorao <alexyoung0@163.com> writes:
> 
>> clone_execute() only increments and decrements exec_level when
>> clone_flow_key is true.  When clone_flow_key is false the optimized
>> path reuses the original flow key and calls do_execute_actions()
>> directly without updating the recursion counter, making those layers
>> invisible to the OVS_RECURSION_LIMIT check in ovs_execute_actions().
>>
>> A single action tree allows up to OVS_COPY_ACTIONS_MAX_DEPTH (16)
>> nested clone actions.  When the innermost clone contains a RECIRC
>> that selects another flow with its own 16-layer validation budget,
>> multiple trees of unaccounted recursion can be stacked.  The deferred
>> action threshold (OVS_DEFERRED_ACTION_THRESHOLD =
>> OVS_RECURSION_LIMIT - 2 = 3) allows three synchronous recirc levels
>> before clone_key() forces deferral, yielding 3 x 16 = 48 layers of
>> synchronous, unaccounted clone recursion.
>>
>> Per-layer stack usage is approximately 296 bytes (from disassembly:
>> do_execute_actions() allocates 0x98 bytes, clone_execute() allocates
>> 0x20 bytes, plus saved registers and return address).  48 layers
>> consume ~14,208 bytes before recirc, flow lookup, Netlink, and base
>> call frames, exceeding the 16 KiB x86_64 task stack and hitting the
>> guard page.
>>
>> An unprivileged user can trigger this from a private user/net
>> namespace (clone(CLONE_NEWUSER | CLONE_NEWNET)) by installing three
>> flow rules each with 16 nested clone actions linked by RECIRC, then
>> injecting a single packet via OVS_PACKET_CMD_EXECUTE.  The result is
>> a kernel panic:
>>
>>     BUG: TASK stack guard page was hit ...
>>     CPU: 0 UID: 1000 PID: 85 ... 7.2.0-rc5+
>>     RIP: 0010:clone_execute+0x5a/0x2c0 [openvswitch]
>>     [do_execute_actions / clone_execute alternating repeatedly]
>>     Kernel panic - not syncing: Fatal exception in interrupt
>>
>> Fix this by unconditionally incrementing exec_level for all
>> synchronous clone recursion edges and checking OVS_RECURSION_LIMIT
>> before calling do_execute_actions().  When the limit is exceeded the
>> packet is dropped and -ENETDOWN is returned, consistent with the
>> existing handling in ovs_execute_actions().
>>
>> Tested on Linux 7.2.0-rc5+ (mainline HEAD 62cc90241548), x86_64,
>> CONFIG_VMAP_STACK=y, CONFIG_OPENVSWITCH=m, isolated QEMU guest.
>> Confirmed that the PoC (./poc_clone_overflow 2 16 3, run as UID 1000)
>> no longer triggers a panic with this patch applied.
>>
>> Fixes: b233504033db ("openvswitch: kernel datapath clone action")
>> Cc: stable@vger.kernel.org
>> Reported-by: yang zhuorao <alexyoung0@163.com>
>> Signed-off-by: yang zhuorao <alexyoung0@163.com>
>> ---
>> Reproducer (C, single file, available upon request):
>>
>>     gcc -O2 -Wall -o poc_clone_overflow poc_clone_overflow.c
>>     ./poc_clone_overflow 2 16 3   # as unprivileged user
>>
>> The PoC creates a private user/net namespace, installs three flows
>> each with 16 nested clone actions linked by RECIRC, and injects a
>> triggering packet.  Prerequisites: CONFIG_OPENVSWITCH=m/y loaded,
>> unprivileged user namespace creation allowed.
>>
>> Verified unfixed in Linus mainline (62cc90241548), net (97ac08560d23),
>> and net-next (a50eba1e778a) as of 2026-07-27.
>>
>>  net/openvswitch/actions.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> --
> 
> General - please remember to CC the netdev maintainers as well.
> 
> [...]
> 
>> @@ -1497,14 +1497,19 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
>>  	if (clone) {
>>  		int err = 0;
>>  		if (actions) { /* Sample action */
>> -			if (clone_flow_key)
>> -				__this_cpu_inc(ovs_pcpu_storage->exec_level);
>> +			__this_cpu_inc(ovs_pcpu_storage->exec_level);
>> +
>> +			if (unlikely(__this_cpu_read(ovs_pcpu_storage->exec_level) >
>> +				     OVS_RECURSION_LIMIT)) {
>> +				__this_cpu_dec(ovs_pcpu_storage->exec_level);
>> +				ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
>> +				return -ENETDOWN;
>> +			}
> 
> There is an existing check for recursion in ovs_execute_actions() and in
> there we have a log before dropping:
> 
> 	net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
> 			     ovs_dp_name(dp));
> 
> We should have a similar log here so we're not silently dropping.  But,
> since we now have two places where this check occurs (and it's
> complicated because of how deferred actions is processed), maybe it's
> better to have a function that does the management:
> 
>   static int ovs_exec_level_enter(struct datapath *dp, struct sk_buff *skb) {
>   	int level;
> 
>   	level = __this_cpu_inc_return(ovs_pcpu_storage->exec_level);
>   	if (unlikely(level > OVS_RECURSION_LIMIT)) {
>   		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
>   				     ovs_dp_name(dp));
>   		ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
>   		return -ENETDOWN;
>   	}
>   	return 0;
>   }
> 
>   static void ovs_exec_level_exit(void) {
>   	__this_cpu_dec(ovs_pcpu_storage->exec_level);
>   }
> 
> Then just put the enter/exit calls in the clone_execute() and
> ovs_execute_actions() spaces.  That way if we need to adjust this limit
> in the future, it's consolidated to just one place.
> 


There is a different issue here though.  The exec_level is used as a
counter for the flow keys during the clone.  And if we increment it
unconditionally while not allocating new keys, we'll ran out of key
slots much faster without actually using them.  This will lead to
much more actions to be deferred and packets dropped in the end.
There is already a mismatch here as ovs_execute_actions() increments
the level without allocating the key, but doing so also for non-recirc
cases would significantly amplify the problem.

We likely need to decouple the recursion level couter from the slot
index in the keys array.  Though they still should stay related as
we should start deferring when we approach recursion limit even if
we still have some free slots for key clones.

Best regards, Ilya Maximets.
