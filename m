Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441354949F1
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353504; cv=none; b=bZqin+BRJi9rD38e29U+mOyTyWI/Dy1Y9R5e8tPKjdLXI6kpZxskk/KNUaGhrYpV/jpsL514rr7B2xuTnuPpBpfJvOazbXzer2eEtmtFHaydUa+ur2eCVLIEpCV01M5lpqnJQR6EdjXga446qrWmPzC1ItECyYFFUP9xhxyiVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353504; c=relaxed/simple;
	bh=Gg+4rRp/Qi2XDpyS1c2FX4MhFGl1KgseWlnE4lP3Yj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFtjsvpuedf4ZVoLDWq+QaDl8alFXMqccBiPMPLAeW1cgKqBXkqEjoC3Vz/TvJcMK53nsDEPVG847NcQMb3dRoGTLHUBq1i5PJaP3k2T1bi/fMpG0O0Um1XcNqVE94ksEl68PMB+ZEfYXmsxYMs48PHVdPNizOezR/Iap1iOE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Lm0XRLOX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Lm0XRLOX"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482e067e908so927809f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788353498; x=1788958298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/ZcwH8ZRW0EEjJcn1cLNCRw5OdPHU7AFoMVmArvcNw=;
        b=Lm0XRLOXi7DGcNnCDK5xt3OcfEBKXJod1U3MBtsaFA+RhV9slTUEf3yMpxyyok9ao5
         AkNrExNivvRRxDPjMJgPS8OvmhbDz84UIiYb1iNFoTGIFdP4/NnuoJojRtb582d9Leyd
         FxTjRFQgHo+P9xBtR6Hucvgwmn9Tv9RVmGegDqbL+Tb2akkm97hqVfiaKkf8js4BFIyx
         cipdB9e2PPUWnh9IWLMHhoQubvqBQwMl9Q+a1V4OGPcZJW4r7X0ZHcIFXRcqlkXVefxo
         cLJaedoJK9zlOF8sayeTknYQ9ohURpjwB2hIRKelXjCtzvaKrFFi8RqPNvWRYXIFaCbn
         ZBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353498; x=1788958298;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/ZcwH8ZRW0EEjJcn1cLNCRw5OdPHU7AFoMVmArvcNw=;
        b=hyV2tK0qp8DFJleKkRL60HZLV2fMjQkOgTgMtKrPGyiMfTRdz8GKLJOPtVbfLzWzmM
         yizZc18XqCMOiWg3xkuT8J6vU5Ln6lA6IvKxCrW8HLHxNyLi3gLGgdoJpXT2xrYIlFiR
         HUkIR8ekONryrOc4n2dnQ+YTbYUVM8TqkHV7UmUNQ2fZf936y/D1YRQ2oN5ZCBItxy92
         nVtegpkY6BFq1nBnIMUiOaA6PW2YF+6K8Rx7SXFyvDsvlwzXkdklI58KCTKzeNMrhU9r
         N5Iue6vhK0hWwj4Q03phlF2KuabfEAJS9qsKI/x30SULjFiWLGvSRZzyt0N3vMfXviEl
         +WaA==
X-Gm-Message-State: AFuF++kgVV4o4VW1Vzc25SDcwEueXbfwLhy7rLz8YQlRcYfFi/YfCQZS
	ASu0ZetxJeJDHFSh5iZxdz1GNXlI8v+aJIaiCRkWCUxT9xIdyr8mHwxvyfDrzINjDrU=
X-Gm-Gg: AYBFou0eSYqc3lnLdpEm+sUW5ka2F8+ze3fVy36QLv9B1vyXhFikwK1vyoaIga8EHO5
	6MhJAiI+s8ivGswEwhOJ4Rd2tSdMjS1ioh9LUMSGWwrdYUZt/A5TrMxk3xCODIC43O/iSJfgISA
	xAGUM6SWnTpakiAWcjNysTx+q9QMSpS4Dzkn0TRG5H7EtWkawPaetBkhxGo4/SiJGNlYRkUaHUc
	sVsByP7r4BQ0CKGf6Lf6z02mM5AfNCPUI7YPIVuNr6NHuZicgkJ3sFZpFT+skDf/ri5dSjWthwB
	UBcyJxoz0cOwDBkxcD1wV6mB6luKx5hfmqoI/nxDSRqoYmZpFRH/26ud9e3UfPzzI/YmQFViSYi
	SmBZf9R8tSIfyTAF2LnIzc+MC7dR5IrQE1xaQ8YMSVX5UlWbMqFtwO/6eWIQMXtJX2JUwk8jz0f
	lpMdsM3nbQd46CdU+uvSg5B/NSSLx5WakZYSrPgKGC1PXcNlMQPz9ClnG/KUkP6XE23GOhWT3md
	5WXErDL43thN7cp0wk=
X-Received: by 2002:a05:6000:310b:b0:482:e4bc:51b3 with SMTP id ffacd0b85a97d-48488deb735mr7314605f8f.1.1788353497400;
        Wed, 02 Sep 2026 05:51:37 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7f8f9sm6318171f8f.9.2026.09.02.05.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:51:36 -0700 (PDT)
Message-ID: <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
Date: Wed, 2 Sep 2026 15:51:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu
 walk of mglist
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <178835300671.3394541.1735736223580358438@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>    performs the entire per-port mglist walk, including one…
> 
> --
> 
> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
> 
> The patch converts the mglist walk in br_multicast_list_adjacent() from an
> RCU walk to one done under the bridge's multicast_lock, since mglist was
> never converted to RCU.  It also makes the function return -ENOMEM on
> allocation failure and documents that in the kdoc.
> 
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
> 
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index 3ef5d8bbf552e..97686984de6d5 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
> 
> [ ... ]
> 
>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>   		if (!port->dev || port->dev == dev)
>>   			continue;
>>   
>> -		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>> +		spin_lock_bh(&br->multicast_lock);
>> +		hlist_for_each_entry(group, &port->mglist, mglist) {
>>   			entry = kmalloc_obj(*entry, GFP_ATOMIC);
>> -			if (!entry)
>> +			if (!entry) {
>> +				spin_unlock_bh(&br->multicast_lock);
>> +				count = -ENOMEM;
>>   				goto unlock;
>> +			}
>>   
>>   			entry->addr = group->key.addr;
>>   			list_add(&entry->list, br_ip_list);
>>   			count++;
>>   		}
>> +		spin_unlock_bh(&br->multicast_lock);
>>   	}
> 
> [Severity: Medium]
> How long can this critical section get?  The whole per-port mglist walk,
> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
> br->multicast_lock held and bottom halves disabled.
> 
> The number of allocations inside the section equals the length of
> port->mglist, which is only bounded by br->hash_max in
> br_multicast_new_group():
> 
> net/bridge/br_multicast.c:br_multicast_new_group() {
> 	...
> 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
> 	...
> }
> 
> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
> any u32 without validation via netlink
> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
> 
> While the lock is held, every other CPU that needs br->multicast_lock spins
> for it, including the br_multicast_rcv() receive path, the group and query
> expiry timers and br_multicast_port_group_rexmit().  Before this change the
> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
> not block bridge multicast processing.
> 
> The caller is periodic, so this is not a one-off:
> 
> batadv_mcast_mla_update()
>    __batadv_mcast_mla_update()
>      batadv_mcast_mla_bridge_get()
>        br_multicast_list_adjacent()
> 
> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
> workqueue.
> 
> Would it be preferable to bound the section, for example by pre-allocating
> the entries outside the lock, or by dropping and re-taking the lock in
> batches, rather than holding a bh-disabling spinlock across up to hash_max
> slab allocations?
> 

Oh please, enough with this shit. This is taking way too much time for a function
that is largely useless.

I will just convert it properly to RCU in -net and be done with this.

