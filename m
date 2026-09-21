Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5614A2A4D
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999066; cv=none; b=ATvL8ixwitcBH+U+1oHve2rBWDAO3VLeP5+yJszghuHOgThVI44SudDOC8GQzhMXQKhoY2FvhVKLE4m1B7lovTCC7lNT8fxLFJMQTnmJMogDwwbJRpCO5pqd/J7PhwjEm6RHLwB6wIrxDUCe0iGuZrZX85KgBC+0aiX7g1V7daA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999066; c=relaxed/simple;
	bh=Tb+naUYdOEbqWhCgBQoqJYUsxvDutMO2RLyfrlwQ7pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWqysa8SkhxpVkYc3474q+XgKdYzrruWc5ooGvOsWaWqraHnRNxnZEoQq1K1D5z4otO59E4sX6fyDea0tdwMzGtwPdK158XASUpyB8qxD4ZJpCg9CHKCNxjxDpQcncWFUYgaOH/B+8Nh7XQcJcoxhIX9JlwZ9JmC3cXeAk81oEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=alr+a4ZJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="alr+a4ZJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so20813895e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789999063; x=1790603863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bv3nJ81FTi9YRl87roXZd095J9UesWmHL2qfxaLM+IU=;
        b=alr+a4ZJm7psgofrCNQzxU3d4HzkKQjHXipg2M9VZw9373uzEvxgj3RrTySJcbHmys
         DJn8AFijVGKICCkS+zk7oKaPkyeaIXj1BfAyROgQNwxInK3pd8LIQ95PvXVlZHZ33X0X
         h2s9hXOVr2AAL+HcoL3M35jzXBIBd50vPhjtO0N7cU/qZgsXC78Sr7Z57CLR5skJLCsQ
         QjxyoNtrd4EeFKxzLoe0MtwnZDY9Kjx6lvXia9/8RoWeoC4sbE3k+e7BLHIxkzWdqJIi
         T7AiryfnuiRPjKi+fJJLFTZdXBKU+vNVdZXj3DXiq7QCaNFRA0AWdjYG4mx6DfMdQaTz
         axTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999063; x=1790603863;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bv3nJ81FTi9YRl87roXZd095J9UesWmHL2qfxaLM+IU=;
        b=jU1BADZ1Y16sw7wKR4EdYH161miUhpH7dTA3Q1ToL5VQMYlDxiMXidnP3RI/1ybije
         kV+USngw4VYPDlpfYM7N4UDrOLJhzzr63gY1qGevE1TsRyzBX8/6fbHw5NRfGsIuZvIE
         eDw6d6ZVqYsG6MJ5D9DULGS0IqCBmXJMVvUavjKdfSkueUH25MKN93jjBgbywRi1X42G
         RxUEUoKQ25HJozw+8Li5CZskMiVWZUP9DKwkXcou3ed3w2VJQ/zfUsNr4HiXp2FcOsyt
         yh17fK+IndRKybM/0TOLvTBYUC2piMLlaL2naLbhGy//WXJBnpR2PAobFLY3PjD1ySH0
         vncA==
X-Gm-Message-State: AFuF++nOXwlkexLyEYHq87tJCTKMqWfoCydP9ka4NW07x9WYIl0mbJ21
	0PRJpvMakrU1I4Iujayaqbb57fr+mQwrolKfM4KuSz3p3sI3EKP5gZ2Jz7IfFz/GX5U=
X-Gm-Gg: AYBFou1FLmOahmMefDKtbMlOHbvkuK2U+N/mqmI+ULVlqjoer8n74jzXEqcD1B7cnkO
	wmO+7fyjrJnMG3ysbzM8IYw5dqkBTQcienPdG9E8+nF9xSja1FweLuT8FV8f37ClXv5O3B8kOxZ
	IcHVNLvOQCHlkJhDQIUX+0QZIspB6iAuY61oQ7VeuhTLTuW5wrs+sfujClXEvo+P0CmMjLgLkE6
	qrrNCHAmM8Uiqfi/6lcM8Y/0qMceV7hNFjRGvPGcWudXH/v1N9USvzqNFJenxFxG3dAhqoZSWjv
	/6xoKdSbrpDbXTabGQDgPYC3SvvqNf50D+qwV7HnsByJmtcDzG3ZCKmfV07VfFoG/LjRZ7cybSg
	RaGFGuKxwsh4kYOBxUo4gKWYdH+emPn/PC+QucdhBfM6B4gycEqOPjTQ1+o33hHql4Ppsnu5iKd
	DxQG70k+qlDa2sgTfjT8tDA6GYYFowwSmg9LVAXJ92VXZVOVF348wOZm1aPOxJ+u6/Vxbt22u0x
	xie1yxhTI/N9r+NJvXOlKGGuFMAxg==
X-Received: by 2002:a05:600c:81c5:b0:49d:1a02:4797 with SMTP id 5b1f17b1804b1-49fc5737cd1mr132113045e9.17.1789999062539;
        Mon, 21 Sep 2026 06:57:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm619266685e9.4.2026.09.21.06.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:57:42 -0700 (PDT)
Message-ID: <3d92300f-a3bc-420e-b94d-f59d7b928229@blackwall.org>
Date: Mon, 21 Sep 2026 16:57:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] net: bridge: vlan: broadcast fwding path
 optimizations
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260918152950.1938259-1-razor@blackwall.org>
 <20260921134458.GA2199421@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260921134458.GA2199421@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 16:44, Ido Schimmel wrote:
> On Fri, Sep 18, 2026 at 06:29:41PM +0300, Nikolay Aleksandrov wrote:
>> Hi,
>> This patch-set is the first step to removing unnecessary VLAN hash lookups
>> from the bridge fast-path and also provides additional broadcast path
>> optimization by considering only the port-VLANs that actually participate
>> in the VLAN instead of all bridge ports. Combined these changes bring
>> considerable improvements[1] and open the path to do the same for the most
>> common fdb forwarding path. As expected the pathological cases have the
>> largest gain, e.g. if we have 1 client / VM facing port and 1 upstream port
>> only participating in a VLAN with many other bridge ports, we consider only
>> those 2 when broadcasting in that VLAN.
>>
>> For up to 8 ports we only use the port-VLAN list as the array doesn't make
>> much of a difference and is unnecessary. Note that the array is rebuilt on
>> every member add or delete when >8 members, I tested that and could do
>> 2000 VLAN add/delete with 64 port-VLAN members / sec on my test VM.
>> If it ever becomes a problem we can optimize it further, for the time
>> being I prefer it is simpler.
> 
> Very nice!
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 

Thank you!

> A couple of nits that you can handle later (or not):
> 
> 1. Patch #3:
> 
> __vlan_delete_pvid(vg, rtnl_dereference(vg->pvid));
> 
> Can be simplified to:
> 
> RCU_INIT_POINTER(vg->pvid, NULL);
> 
> 2. Patch #7:
> 
> Initially I thought that 'fwd.vlan' is never set, but then I realized
> that in the only place where this field is actually set it's called
> 'dst.vlan', which is a bit confusing given that in the context of the
> bridge driver 'dst' is usually an FDB entry. I would probably rename it
> to 'fwd' to be consistent with the rest of the code.

Ack, I will deal with these in a follow-up, I have another set that removes
the two egress vlan hash lookups for standard unicast fdb path and will add
these as cleanups to it.

Cheers,
  Nik

