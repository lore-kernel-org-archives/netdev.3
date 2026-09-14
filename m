Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EB38F928
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372644; cv=none; b=pTTOg6LeL3/Z/9pIeinvAO6CLlF5DX30jWyqiFLN8+hgM7EtYxA7G2t2dkNKX0tbu2Qb9+JRfF+i3/1m3zBaA0A5b5hlFsUZ3Km7Y7+PN/zL4pGLxH/B/RG0RqrsDp98JuP2baIPJ5WcXIg+RJ5NqFaAqsgeubd5zFQDXoTXWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372644; c=relaxed/simple;
	bh=fk/KCNGIGqU5wDmfahQyXniObJrM97UDdoYWTGTMtkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahniq1PFu/aixrGlk7xqGo5J549wCr+nn7S9CxNmDviUJOm2/U3ZXlWa+4DGw+QHSAH9lrqOPcM0sgmODIGDON/m0j/Zq9Vw6PcfykRT6+Zg3aS/ohXmR+HPf3lBW9fDHzfKT0dVYENRtpsqgEHtvs81O8H8m2YSq8YsPT1xkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=U340yHsn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="U340yHsn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d05d51553so24664395e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789372641; x=1789977441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ov1XGcV6x2Ewxc2p28aGPDAphWY7SIsit3j0snwG5Lo=;
        b=U340yHsnhNOQeTtmfoJrlhkrsV3oXfbvy0mxMRFsinpyyaYQvQ8nvnsxPqOXO5YQpq
         qmLrpwg5PZoZxmBvf1ncnM/XI+eARsZOzlus58mLwMl9vhnlJvM/NKPWGUu8wcXKOUzP
         7PJCyIvPZ8ahDBmYRktYSMVXxS8RiO09t/Q4CXimeEAj0fasyRvfQp7mRtuQxWdzmFJ2
         YQFpTEFYr71aIdnhSY9pB/GVO/EHtw9jjIx3VKMknBb9gQyQXsNhgWUKkAybfZ34iA9s
         KDlbsI190fqyMAz5Qdb4xktnv/HSizCX+2zwPtup1/hszYewIGO4ysVFWQSoyWdFSf6l
         9g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372641; x=1789977441;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ov1XGcV6x2Ewxc2p28aGPDAphWY7SIsit3j0snwG5Lo=;
        b=TUPoWK4NZN/iFw75Kae3B84neSCeOHn4LYC8Y9QZQITVIvuKTq6+5BxA62tjxl+FF6
         W87gau5+1zt899YBjYMpU1PBAuNAqBLx+EvFreaOTXCqHvpWjVu7nyFVgs7UFSC2pb6o
         u7D2Mh+HMQz/HxBbiLdKXiaiAuUjySRNya8Cr39Q5ity+EBDjKCgeso5+1fhgkDyzsUv
         mzsvChjk34tEG1Wgl9ffm3qj9JLsBAWi17OILbWFoBV/1YYfdumEhmgP3jdcAfVfY5zR
         4TlJHgii69oE5rXNouNi5Us3hANKDbqktl8Ku1ZeLS/ZR8Jza2uBpIqgmr7HgktNTJAR
         9Iqg==
X-Gm-Message-State: AFuF++mmC32PchEKID50KbtK2ir4Muu/ioupCEdAtKbKNDxOcQ5A9x0A
	Sj1RXOoAKWa+/UYw83ihmmfQNM9Ai/wkv/o1SU/tBg++n93ZZ7Ls5zwDPVkcCsLDyVE=
X-Gm-Gg: AYBFou0jyLf9vypADnLUjXfeXN+8a3zAvlCrOv7vXG31hTzCFA0qaOKPURmx5Bfe0XX
	9uYElNuf4HA9qpaw1eLxkbBb7hHWfFyUYf+UKId2svMGbSeWLlukxVX7DdzFgl2qiGg9E5e83Hv
	IJD13u05wkYKVN5hW5iIi0AG5zjZyy3QtUoi8zWs6V2APlQuZZXu5h8vqzavOIp+W/tx05gZ+aU
	akTM6jo6zxci8vEq2lAGIbf2FFY3E8vAkVvsA4RDs9vD0RgfyZYQir1OpCoCW+dqSoYak46hr3P
	hdohYpvkU1RQyKDwKDDa4ue1X5G0jXnjn73/dj2M+PJ7OWAGHMdT0iGqlHK+V9s7N3Aoe0AbsrT
	7fG3Z0/UhbYwa+Fy/m/GbKax5bwD3r0frUh32/DZSCKxXESxIKhXieBQciCCUkUgIs+9SFaXXKT
	DyayMQ7mzx4pk6fKRWu/WZBf5KHsdPq4PnmjnRY8f+d3SfI+jkFfHpQDzzwmqsjhevAcKNB3BCL
	nh1wF8kyS6ZDOXp2o+jY+FiffY4+3Q=
X-Received: by 2002:a05:600c:3586:b0:49e:747e:c00e with SMTP id 5b1f17b1804b1-49e7a64e729mr17751295e9.9.1789372640697;
        Mon, 14 Sep 2026 00:57:20 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm25193528f8f.2.2026.09.14.00.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 00:57:20 -0700 (PDT)
Message-ID: <3c85a4c1-b7d7-4027-9a37-7f9c05c8a2e6@blackwall.org>
Date: Mon, 14 Sep 2026 10:57:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: vlan: fix leaks on switchdev
 deletion errors
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, petrm@mellanox.com,
 vladimir.oltean@nxp.com, bridge@lists.linux.dev
References: <20260911100645.1360386-1-razor@blackwall.org>
 <20260911100645.1360386-2-razor@blackwall.org>
 <20260914075459.GA179479@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260914075459.GA179479@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/09/2026 10:54, Ido Schimmel wrote:
> On Fri, Sep 11, 2026 at 01:06:44PM +0300, Nikolay Aleksandrov wrote:
>> __vlan_del() stops the software deletion when the switchdev operation
>> fails which is ok for an explicit VLAN deletion because the VLAN remains
>> configured but not ok when its VLAN group is being destroyed and everything
>> is being freed. __vlan_flush() always destroys the VLAN group after walking
>> it regardless of individual deletion errors, so aborting the software vlan
>> delete leaks the VLAN object's memory (and potentially its master VLAN, due
>> to references).
>>
>> Allow teardown callers to finish the software deletion while preserving
>> error for reporting. Save the VLAN id before deleting because the VLAN
>> object can already be freed (queued for freeing by call_rcu).
> 
> I think we should only log an error instead of aborting the operation.
> 
> It's not really valid for a driver to refuse VLAN deletion and it's
> inconsistent with the 8021q deletion path (i.e., __vlan_vid_del() ->
> vlan_vid_del()) which doesn't abort the operation.
> 
> Also, by the time the switchdev deletion fails, the affected FDB entries
> were already flushed and the PVID was already cleared, so the state is
> inconsistent.
> 

Ack, sounds good. I'll just report the error instead of failing the delete.
That makes it even easier and drops the need for the second patch. :)

Cheers,
  Nik

