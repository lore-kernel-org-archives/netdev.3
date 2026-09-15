Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3663F4829
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464065; cv=none; b=kn6UEEsSCo1QbdyxD4zuUb5vVxibvW5L1PJTKIa7aQ48cz0BHZb2InQkup7O63NBdOfClAtDCjQhBL/84ZsiE0WbuDkSU7JYh3nP86v8vHJaD4R64kK6AZtIRjK3cEYnu+RS4mqJCi7jWntY8JcAMw4gHIduwvUawB/MLo1U4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464065; c=relaxed/simple;
	bh=3JERJOW8NvI7jxzKDrIZBJvbmcJdPUg3yxaOoEqAl8M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i4XpRNucLAbmuopT4klak8NjdGvGPxddNKp5+aVVYubP8AzyoIwgRe06VSxvTmYuzfh5VzvK72HaAVMfdW5h17A0PbeXrBBtvVwDxUW3yw9X/6JuJV7eISRA/wWaEisBnZ84G6LD5w5eayBbJMPsT0Gq83H1fE2lzmlxLPxH1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BG7APGM4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=phQ0PPJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG7APGM4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="phQ0PPJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789464061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YmgWeZb9WIxkVGIbQ22hqC4WC9PSRrkbzM3BRDC+jk=;
	b=BG7APGM4GXrvH1t6acyUqUJTY85kJS9zWqrrkV+aOlER9iDkD8+v3rNgPHuZxuCCRjcRiA
	loxjnv5DjCfVGKq3SXupAH0sSJfBjH8VX2UxYBb5tboWYaY4fBZOYmYWhOJH7WdN+h4b2n
	xJ3LUy1T8mRzXlA9SImIDvMIgW2Bt6M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-E0qu8u1wP-mqb5g859hRag-1; Tue, 15 Sep 2026 05:20:59 -0400
X-MC-Unique: E0qu8u1wP-mqb5g859hRag-1
X-Mimecast-MFC-AGG-ID: E0qu8u1wP-mqb5g859hRag_1789464059
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c293743f5cdso465847266b.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789464058; x=1790068858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YmgWeZb9WIxkVGIbQ22hqC4WC9PSRrkbzM3BRDC+jk=;
        b=phQ0PPJBKKadnnFO9sxyWyG+9vpc5SNh2pk3PwGZEDvvou+v9sSiKdVmxdmnp7HEFS
         4JewO3A5hEFvmPHaX+BP+rSiTDgTPcz3wCrzwRY8ln3x5kdXgIaCpBDmmfLgVd90dM9P
         slIt4+uLnc5SRWx201H9PY6V+S+LsYuPxYBJkeJgHej6LWSldtb44zJf53/wUbPwKh1K
         zBx0hcr4sMlrcv0zPCan49rP+O/ey9M+jQIpu3VeymhvfprbTvuP4MhopAWMEYGVb/Vb
         3Yf+zfLgCLgovhnhZpzEPR1n0Q7gx5WKd71Lxf7Ed1Qk9y6geowdJTQms/Nn+hcXO3za
         D7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789464058; x=1790068858;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YmgWeZb9WIxkVGIbQ22hqC4WC9PSRrkbzM3BRDC+jk=;
        b=TsdTNH0JCOKFyjHtQskjLLgny8k3NtPExnknYjpyMtQkKvELHxxiGvfE8SVS/p/Q/w
         aG2KIixZ4l+dQ2zyiAywkuPvYPGUIBIA98OcJRCT8fJQ14uc7VopBqGAW/adZqryA/I+
         MoJTI1rai+7wNA+5OYUW/s5sNKZZLuFyRsqs+R9UJRnGpfrawFRj7rtexBgBjXL6987n
         XXDVwnvxv/f6hWZhOZYATzStpscft8+RcpjbBwsoV8C4evNHfE7qxET5rq0qojA6xcGB
         HkCzAJ3c7rdx7ihpXVAnM9PO4Ryy80dYvDsbIV/kBgm9SlvKmomB9WPe9YromUKaEVef
         zxKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMycjn93n/5219QRkvcAr0Ici/e7Lh3XxsFqE8p5LrIXNmAp0olE9nhSb0n3LWmFWg6+2IwhI=@vger.kernel.org
X-Gm-Message-State: AFuF++n9yAlnkYyGM45cfUPF+5WTqY2ps9sfSZcVygZTJ5FIQjWotwmI
	ogtm6FkePXGJrZqZHvOdlVd3NsCK6P4GcN596oWJiTU2c2kbcXhR1OQn3SMqyl5C9GqVCqyjMtT
	mbsPoFikujpuwEcd0Kq8AvHPlqmgu8o3/9lDHShWeHWO7fcZm///cUKOBhA==
X-Gm-Gg: AYBFou1ZNFkDE+U7+TmgoECYOZKb4Ixw4+tfzjc430L5FaOJ7m3qeMsq1eeQZJdwqU0
	YwRvgQrjISD08iX+ogL+F+VTL6ZDfRTgqHaQR4PiNSPW0ZB7QMBeg7ly9NZQewKNrZqq/KIiFxz
	PVHF5J32j7s8GxuHEgHPymh1DD0ASb7g72DQz5YcrtpBCse/kHm2uCyrbeqScpZj8lAPCzVbVS2
	wbBkgWmOdXUg+c90WWrGRCR0wYPyo3vKXlPGYp7xSpxFsvDGstkO0vs5BE+GFxH2dpiJM8moUTd
	iGDv5Y0ET9/OXOpVuKhGwBgVPxnnb2noPB2/FSORjufXViTTsvKHQw3roZB2ymeKFklt+rXvXOT
	Ml6z0D7H9BilF5R0JjG9Vl3zFBuvWe6mbZ4rfbFUp0Sck1i6TCGMfeFpZtzqu5sQBjP54yE4mbw
	==
X-Received: by 2002:a17:907:94d3:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c29d78c8fc1mr22307966b.24.1789464058546;
        Tue, 15 Sep 2026 02:20:58 -0700 (PDT)
X-Received: by 2002:a17:907:94d3:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c29d78c8fc1mr22305966b.24.1789464058107;
        Tue, 15 Sep 2026 02:20:58 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296608dc91sm541960866b.39.2026.09.15.02.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 02:20:57 -0700 (PDT)
Message-ID: <7a67cc6c-9b3d-4332-b9a9-f63d959d5e58@redhat.com>
Date: Tue, 15 Sep 2026 11:20:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/1] ip6_tunnel: snapshot encap in xmit
From: Paolo Abeni <pabeni@redhat.com>
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, tom@herbertland.com,
 vega@nebusec.ai, petalzu987@gmail.com
References: <cover.1788778433.git.petalzu987@gmail.com>
 <ca20d8addc2d6b01cac83ed9661e465c47e9b94c.1788778433.git.petalzu987@gmail.com>
 <e651fe9e-2d84-4320-99a1-6fddcfc00889@redhat.com>
Content-Language: en-US
In-Reply-To: <e651fe9e-2d84-4320-99a1-6fddcfc00889@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 11:20 AM, Paolo Abeni wrote:
> On 9/9/26 9:01 PM, Ren Wei wrote:
>> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
>> index 7c9aadfe8fe3..ab217ddbeb20 100644
>> --- a/include/net/ip_tunnels.h
>> +++ b/include/net/ip_tunnels.h
>> @@ -522,6 +522,16 @@ skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
>>  	return SKB_NOT_DROPPED_YET;
>>  }
>>  
>> +static inline void
>> +ip_tunnel_encap_snapshot(struct ip_tunnel_encap *dst,
>> +			 const struct ip_tunnel_encap *src)
>> +{
>> +	dst->type = READ_ONCE(src->type);
>> +	dst->flags = READ_ONCE(src->flags);
>> +	dst->sport = READ_ONCE(src->sport);
>> +	dst->dport = READ_ONCE(src->dport);
> 
> The above can still race with ip6_tnl_encap_setup() giving inconsistent
> results. As noted by Eric in v4 the solution would be convering the encap
> to RCU. I think that the additional dereference would be actually faster
> than the extra memory copy.
whoops... I almost forgot: I think such work should target net-next with
not fixes tag.

/P

