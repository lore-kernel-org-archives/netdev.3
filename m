Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123C1A2C04
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643060; cv=none; b=YAX/eaCP90LGHmeSATwTckhCngLFZgo3zJxMAopLeQB0D1vse+7RFSPnHbEs43EEgcwyo7myBtvGwIRJ0O+uerh1i4/ofSZo54PGnyHwTSNkA8OwsB0/Ez0G5cV29n1XF4E3jMn5r3fk6czB9Rvc0g/7uaCFaMXVglaJ+SV+VVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643060; c=relaxed/simple;
	bh=zZL53EEjw9D1RZgfinpAjxAnatcoOrPLnw/a2JQ7lgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ug4OzgfSyB7j0F7CI4ej7CjF1gE47Oqy+DGpvVG8xUbVt2P710aCPIMc8YcPqgmo1/sKXJj26/OwC+ADSETnhliFJ1RXvyBnGfDBopeM3OrelgzlFuKU0VCzV2zv+Ag4Fq0h1ssdkqyesIzNyTYu07qW8U7+HTRegTra1y7DemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SQr5z2yb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SQr5z2yb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so1526990f8f.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788643057; x=1789247857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY+HihG4agfNBeK2I6zqAOhhokWdRfXRGsAmqq96xZI=;
        b=SQr5z2ybOYoKYJvMWeDBhe7zBKXgrg7dWgqbnxYoL2cjCLcu6WT9RjqX0SSw2sApgi
         cTTpEzFykQxkkvE7yVnUFPnWEZN5v6QG2/p2nNZfq/7EGstta4ohcdUWt1tx1G/BDbl7
         fU2Zwl6xpgjzvqJYPsXnEJF8Xa1JDWp4JeGV+GjAdw24JEf10siQfSOOQv7g2Titvm/U
         f7VjNwwp4UHmqO59Hjz6/sken2OIv+S/eu+2w1d1G40qNXjFAeEOWZQpu5RM4nXTn+2h
         iJ/JUwLd6ctLisKT53IOUKomM967bAsGSOv2y/2CbMj4QIOtz79dXxcq00V30fMpVla/
         idaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643057; x=1789247857;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY+HihG4agfNBeK2I6zqAOhhokWdRfXRGsAmqq96xZI=;
        b=iAxwMPTYd/D7nPH252bWWoTy/V/kCJCH9thVJPIn1TdgPEEGAlAuuAdq5dtI/7Ud43
         QvyuIRs2xaabLttV+uZBAOeTWp1PLlh1tvx/vasp26Saua/Y9eJFl6aixN9cS1BsEgW1
         X8byq+SekZnG3kcYhFoPhSgwykYr2SXXstgbaX7oMGzBN8Yp+zEL6Ya90IvtLFfk1gNk
         ewUIOgmldcsPmomHqlofkHVGqf9hdJlRyTwV1fbPMyc50qQc63v3AvSTdMBK8W0wEEW6
         EMPKYvQz01BeTGrtKYgL7Gna4lE5iiWuNk3+NgdeWJPrueAabxhHw07WN+AVGwk2NJJm
         aOGQ==
X-Gm-Message-State: AFuF++m7dhv2u98JIb32ffUpDpialDIBzNd+IMz94a5ze3eFCG1f38wV
	wGhGdXIgZqv5A/vBoe1e8eoXqp/BFcE5iYp+1sRpcPaYqeGTnNEBHOgoKNJF9Z0iIhQ=
X-Gm-Gg: AYBFou1bVPK7w4is4ynFSEpS5Cb5E9tL0nDi71yzSHLGjbSfRVcI8UQAuydNfOjf/uh
	VBFwNnaDZNrXzdHBTdCOIbAairu3neBY4m8r7eL0qWoXymn4YGusQBxcftYep63Ysr74ae4p3c0
	XR6/UQVpXuMN+gDs4XOnHT9kA3sG0Ik6tewKkrA80Bb/mCuhiQQdkPpqVdCqxIutsrjC5ErTsTN
	8LaSDcmvD52ulr0h0anF0fXJg360zn3dLTHbZQ07t1pr+t4sK+59jWrE6ppzerCDEoNUt6OABlY
	0czmzqlNpAuIge+3mU0iwqaqlVhcHONW11E49FxB+dHELVVrv2hANmrsxW7Sd7qu4asJc5W6yd0
	AY6/pX0N3gDHh9pc3OdevsG8CDssom3h8+nlhxdJHBTZYSqzfa3R8NdPoGwx9IIcEYSiKGdlXuo
	pNQwWmVV2VQuGTOgNdUrANHiF+Pr1jJpvniP3ads37IZbJhy9NFXjoW0fvLp64C0GPzQUTwN0jw
	+i+LbRhlM40R9hrbIQ=
X-Received: by 2002:a05:6000:26d3:b0:482:a8b1:aa6d with SMTP id ffacd0b85a97d-48587091389mr16889952f8f.10.1788643056177;
        Sat, 05 Sep 2026 14:17:36 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm17665272f8f.33.2026.09.05.14.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 14:17:35 -0700 (PDT)
Message-ID: <ac7e3f4e-7a0f-410f-afb2-9bf65549cbdf@blackwall.org>
Date: Sun, 6 Sep 2026 00:17:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/9] net: bridge: vlan: drop legacy memory
 barriers
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260903143138.1574598-2-razor@blackwall.org>
 <178864007675.219967.6069320085194764242@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <178864007675.219967.6069320085194764242@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2026 23:27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)
> 
> - [Medium] Writer-side publish ordering removed: in `__vlan_add()`
>    (net/bridge/br_vlan.c) a new VLAN is made visible to RCU readers…
> 
> Pre-existing issues:
> - [Low] Concern (retained for policy combination, but validated as
>    resolved within this series): after this patch `vg->pvid` is read and…
> 

I don't think there's anything wrong with the patch, I've answered below.

> --
> 
> net: bridge: vlan: drop legacy memory barriers
> 
> This removes the smp_wmb() calls from __vlan_add_pvid() and
> __vlan_delete_pvid() and the smp_rmb() from br_get_pvid(), on the grounds
> that the pvid is written under lock and read under rcu in the fast-path.
> A couple of questions about the write side below.
> 
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index d337b1cfb980..5b2c22ad669e 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -1687,7 +1687,6 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
>>   	if (!vg)
>>   		return 0;
>>   
>> -	smp_rmb();
>>   	return vg->pvid;
>>   }
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but with the barriers gone
> vg->pvid is left as a plain C access on both sides: br_get_pvid() does
> "return vg->pvid;", and the writers in br_vlan.c do "vg->pvid = v->vid;"
> and "vg->pvid = 0;". There is also a direct read outside the helper in
> br_mst_vlan_set_state():
> 
> net/bridge/br_mst.c:br_mst_vlan_set_state() {
> 	...
> 	if (v->vid == vg->pvid)
> 	...
> }
> 
> The sibling field in the same struct is only touched through accessors
> that mark the access:
> 
> net/bridge/br_private.h {
> 	static inline void br_vlan_set_pvid_state(struct net_bridge_vlan_group *vg,
> 						  u8 state)
> 	{
> 		WRITE_ONCE(vg->pvid_state, state);
> 	}
> }
> 
> The follow-up patches in this series do address this - "net: bridge: vlan:
> annotate lockless pvid use" converts br_get_pvid() to READ_ONCE() and both
> writers to WRITE_ONCE(), and "net: bridge: mst: use br_get_pvid helper"
> converts the br_mst.c read - so this only applies to the intermediate tree
> state at this commit. Would it be simpler to fold the annotation into this
> patch so no intermediate state has an unmarked pvid access?
> 

This is not the point of the change here and it isn't relevant at all.

>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index 1e0e436629ec..2ae6ffb23399 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -40,7 +40,6 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
>>   	if (vg->pvid == v->vid)
>>   		return;
>>   
>> -	smp_wmb();
>>   	br_vlan_set_pvid_state(vg, v->state);
>>   	vg->pvid = v->vid;
>>   }
> 
> [Severity: Medium]
> The commit message says "nothing to commit prior to changing it".  Is that
> accurate for the add path?  In __vlan_add() the vlan is published to rcu
> readers first, and the pvid store happens after that:
> 
> net/bridge/br_vlan.c:__vlan_add() {
> 	...
> 	/* set the state before publishing */
> 	br_vlan_init_state(v);
> 
> 	err = rhashtable_lookup_insert_fast(&vg->vlan_hash, &v->vnode,
> 					    br_vlan_rht_params);
> 	if (err)
> 		goto out_fdb_insert;
> 
> 	__vlan_add_list(v);
> 	__vlan_flags_commit(v, flags);	/* -> __vlan_add_pvid() */
> 	...
> }
> 
> So the removed smp_wmb() sat between the rhashtable insert / list add and
> the vg->pvid store.  On a weakly ordered architecture, can a fast-path
> reader observe the new vg->pvid before the matching net_bridge_vlan is
> visible in vg->vlan_hash?  The rhashtable bucket store has release
> semantics for the insert itself, but nothing orders the later plain pvid
> store after it, and the WRITE_ONCE() added by the next patch in the series
> does not provide store-store ordering either.
> 
> If that can happen, the reader in __allowed_ingress() picks up the new pvid
> and then fails the lookup:
> 
> net/bridge/br_vlan.c:__allowed_ingress() {
> 	...
> 	v = br_vlan_find(vg, *vid);
> 	if (!v || !br_vlan_should_use(v))
> 		goto drop;
> 	...
> }
> 
> which would drop untagged/priority-tagged frames for the length of the
> window (this lookup is reached when BROPT_MCAST_VLAN_SNOOPING_ENABLED or
> BROPT_VLAN_STATS_ENABLED is set), triggered by something like
> "bridge vlan add dev <port> vid N pvid untagged" for a new vlan while
> untagged traffic is received on that port.
> 
> For the read side the analysis looks fine: the smp_rmb() in br_get_pvid()
> preceded the pvid load, so it never ordered the pvid load against the
> following hash lookup - that direction comes from the address dependency
> into the bucket computation.
> 
> If the write-side ordering is still wanted without a fence in the
> fast-path, would smp_store_release(&vg->pvid, v->vid) here be the right
> replacement?
> 

This synchronization window is acceptable, we might drop a few packets. The write barrier
here keeping it shorter was really an accident, the barriers predate my conversion of
the vlan code to rhashtable when bitmaps were used and needed the sync.

