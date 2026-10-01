Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC83AE71C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856451; cv=none; b=sX4374Q7grX/re70psI6kZ3+D0jLzqdgbYbUjK1dURtCPGABP+DGK/s22smWZSCHFkELaZUzvui30lfs7iX84WzMU2kZpuD4FCVRp1SOBiewq5JbgnyVrH73JXCr8/JLPHDwfpVGzYfRtlE7dtNOyzX7Wh6BjbbKQydaqw+wzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856451; c=relaxed/simple;
	bh=THUYFu6sAj7ZsQg03U1SBfX/R1UfJ52AW7mFtCGdIQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHtlgf+WfqUg4gDweDm0zzEonKopR9Z24VzxRibFiZr5hMiyIM6SeO/BJtX5Ke3GBscoCekVCnjxrB2ZNsVEJnLzvFPvtsY25fUBE0tr5FDEkhjNz+jqfluxaNj0a+BjFR84gkip5GjcoldusnM3GbqYlTs4/T+JJRmCevIKslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AJ5l0ETI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AJ5l0ETI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso39207385e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790856443; x=1791461243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xuEUyonZ+x3J1OyEqFQIWsDxR3lMvEKhljQtywXlu4c=;
        b=AJ5l0ETIDAC7P4Ry4s8Bgj6cgSmCqAe2dwfVhaBtNlMCc7auz4TJBDAG7+/uqkQJJ/
         8cu0Ny3Yc1nXBimkm9qZoGwYq529ITyDent9FNKv8C2Jcf0NWZ0W4203/oAVIHUtiYPp
         5MDuxxNFnbz9fj0wxs3yJB37fM1nd+2Ql7KNjUL8znUR+HYnRbJwjfNCQik575O9oiPx
         ShLMGKOk9eQyGQIPVU5L1R/maTdKfTGpkL6bhYd2bq03sTGMUAeXaRgu6ydFGCKjSh2z
         p3iSyzLDrHiqCAydYJUu159GPjKXRYB24hfz7Lpi8O0YEBBO5l7bAvYiXVEQYfcZGo+s
         o2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856443; x=1791461243;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuEUyonZ+x3J1OyEqFQIWsDxR3lMvEKhljQtywXlu4c=;
        b=MY+Dvzn5xQLxdZVQxc3GrSoWal7I8JuAg8pC8LQ+QJIkGxanxXUOb/Nm0Y5wHElbRq
         Nm8fFhDSXVn94SPxn5VXYCVQXBRKGpUxHHx9UDw7vyHNv4CODydXacfk9i0aR+Hq0xRu
         8Z8xWbgtLHzZBgfN5liLMHFkwtc4ys4utAer7kpcF8YkTMrdJi0Rb5OD4o4q3o2ciYu2
         oKkL3SzXJL/ekHauq98MakP3KoS1nPVb2e2gFWEu7Kl+fZyan/X/rtiHzsbgA2cnBBEL
         uCjm1B7THxFzNY2Zkl4rad14mSu44Bix1YWXuFKOojlgimjCHP5zrovbt4+rDxfJikl0
         wLjg==
X-Gm-Message-State: AFuF++nMPw/2+3EZ6+xcjaeSMR/wbGObyflwnbSQLBGxDtvvxFUyxcKV
	nHyoIpxxpLCOLw6eXZlblAFHwbYrZQM4gBrN/eMSRZ9Ar3iDBkkvcnpEaw6vbpnOv2U=
X-Gm-Gg: AYBFou0Fg4R764+mK5vBCsyezbDg0eoY+jHP2DaCxArKAuNmD2J/rcTArW7tv8FHmrg
	Ynu+J/oi7ddf8cMCpDDWbmhNpOle6haso7NH3UCxZyjjGV097DgOQdU97B8HgBJlF47DtveFW3z
	5Q+AjvEXkqvrFi+DYYJqHNI/48CL/YzRj3q4frdIhZuF2shFOL2K973BFDgWhFDM2YUCi5wErT2
	PkGemfTWG4D/WqZNCMC52EhrhmwJEHJFBvicAUrF0blo1Yj2DFOM0OXOmvS5S9bAEHfaIJOPuH3
	B61dptcMwDIiroy8zQ6McZFEh/NPELzQZs1qTdEmxC35YMZn4quf58881ITbxBFIkvTLGSWCKTB
	A80TNYspy75l5ywdcKOP28U3P7dPWhuh+HtWQ3Y+BzUE/43ebK+fK8lMpf7x1/SgKqmmkFnXGog
	tPySBR0onTXX0XvRw8ktOJwbL4F0MRZ0DBlSuKyQM1jMtxJrfD/95/H2Kkj/24OzPDjW5Ivd4Vx
	zecdGYKt2pdLQzbm3lg+O1s2+2bzlAd9qtBNfM=
X-Received: by 2002:a05:600c:a02:b0:4a0:1efa:c748 with SMTP id 5b1f17b1804b1-4a01efad866mr43064615e9.15.1790856443256;
        Thu, 01 Oct 2026 05:07:23 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa137basm61069715e9.1.2026.10.01.05.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:07:22 -0700 (PDT)
Message-ID: <f529d8a9-a4ab-4398-8754-d6c7528133c7@blackwall.org>
Date: Thu, 1 Oct 2026 15:07:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers before
 freeing port VLANs
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260930071411.2786201-9-razor@blackwall.org>
 <179085595119.434549.4421493167752460988@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179085595119.434549.4421493167752460988@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/10/2026 14:59, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] nbp_vlan_delete() in net/bridge/br_vlan.c now calls
>    synchronize_net() for every port-VLAN it deletes.
> - [Low] br_fdb_cleanup_by_dst() in net/bridge/br_fdb.c reads f->dst once
>    into `dst`.
> 
> --
> 

I already answered, but here it is again:

> net: bridge: vlan: quiesce readers before freeing port VLANs
> 
> This patch prepares for fdb entries caching port-VLAN pointers. A port
> VLAN is now unpublished, a grace period passes, and only then are the fdb
> references purged or rewritten and the VLAN freed. During port teardown
> the whole VLAN group is unpublished first, so all VLANs share one grace
> period.
> 
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 7c68b540b3580..307f9c12914ef 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -883,7 +883,9 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
>>
>>   	spin_lock_bh(&br->hash_lock);
>>   	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
>> -		if (br_fdb_dst_port(f) != p)
>> +		struct net_bridge_dst dst = br_fdb_dst_read(f);
>> +
>> +		if (br_dst_port(dst) != p)
>>   			continue;
>>
> 
> [ ... ]
> 
>> +			     !test_bit(BR_FDB_OFFLOADED, &f->flags))) {
>> +				/* The entry outlives the VLAN, so it must fall
>> +				 * back to the raw port destination
>> +				 */
>> +				if (vlan && br_dst_vlan(dst) == vlan)
>> +					br_fdb_dst_write(f,
>> +							 br_port_to_dst(p));
> 
> [Severity: Low]
> Can this unconditional write lose a concurrent roam?
> 
> dst is read once at the top of the loop. br_fdb_update() roams entries by
> writing fdb->dst under RCU only, without br->hash_lock:
> 
> br_fdb_update()
>      br_fdb_dst_write(fdb, br_port_to_dst(source));
> 
> If a roam lands between br_fdb_dst_read() and this br_fdb_dst_write(), the
> new port would be overwritten with p.
> 
> This branch can't be reached at this commit. Every br_fdb_dst_write()
> caller stores br_port_to_dst(), so br_dst_vlan(dst) is always NULL here.
> 
> Later in the series, "net: bridge: fdb: cache port VLANs in learned
> entries" replaces this with br_fdb_dst_replace(f, dst, br_port_to_dst(p)).
> That is a cmpxchg against the snapshot, so a concurrent roam is kept.
> 
> Would it make sense to use the conditional replace here from the start?
> 

- No, we're fine with the roam race, it is normal. Trying to change these races
   requires much more work and isn't worth it at the moment.

>>   				continue;
>> +			}
>> +		}
> 
> [ ... ]
> 
>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index 8a914e249767a..0675f74cf1b99 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -1406,23 +1406,32 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
>>   	v = br_vlan_find(vg, vid);
>>   	if (!v)
>>   		return -ENOENT;
>> -	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>>   	__vlan_unpublish(vg, v);
>> +	synchronize_net();
> 
> [Severity: Medium]
> Does this add one expedited grace period for each port VLAN deleted, all
> while RTNL is held?
> 
> Every caller of nbp_vlan_delete() holds RTNL, so synchronize_net() always
> goes through synchronize_rcu_expedited(). Range requests are processed one
> VID at a time under a single RTNL hold:
> 
> br_process_vlan_info()
>      for (v = (*vinfo_last)->vid; v <= vinfo_curr->vid; v++) {
>          br_vlan_info()
>              nbp_vlan_delete(p, vinfo->vid)
>                  synchronize_net()
> 
> So a request like "bridge vlan del dev swp1 vid 1-4094" could run up to
> 4094 expedited grace periods back to back with RTNL held. The
> cond_resched() in that loop doesn't drop RTNL.
> 
> The per-port loops in br_vlan_disable_default_pvid() and
> __br_vlan_set_default_pvid() also now take one grace period per bridge
> port. That includes the error unwind loop in __br_vlan_set_default_pvid().
> 
> Before this patch, nbp_vlan_delete() waited for no grace period at all,
> because __vlan_del() only queues call_rcu().
> 
> The commit message only describes batching for port teardown:
> 
>    "This lets all VLANs share one grace period."
> 
> Could range deletion be batched the same way? For example, unpublish the
> whole range, wait once, then clean the fdbs and free the VLANs.
> 
> At this commit, no fdb writer stores a VLAN dst yet. That starts with "net:
> bridge: fdb: cache port VLANs in learned entries". The per-VLAN
> synchronize_net() is still unchanged at the end of the series, in "net:
> bridge: fdb: avoid VLAN lookups in unicast forwarding".
> 

- Yes, they can be batched and I had them batched initially but when I ran my tests I didn't
   notice any problems deleting a full VLAN range. It took 79ms on my host to delete 4k VLANs.
   As I've stated in my cover letter - the complexity is not worth it, so I dropped that patch.

   (from my previous reply)

>> +	/* Traffic may still use v through cached fdb dsts until they are
>> +	 * cleaned below. This is acceptable during vlan deletion. Above we
>> +	 * drain the readers that could republish the dst before cleaning it
>> +	 */
>> +	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>>   	__vlan_del(vg, v);
>>
>>   	return 0;
>>   }
> 
> [ ... ]
> 

