Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76392AE76
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458832; cv=none; b=BXcxOaiF4gwN+P1RhoibiVI08ZOq88VlMlgLlAtsdsmwfYAd4Huj/CfvIt40sR+8Nf7cl+h9TDqczAiLuS7JCsCX+n1OVFJFm9eyR1f7z+n/g4gS9krLzcPtx0PO/a1j08WSUsS8uYvmY0DCL5Y6v74hNx6A2mezW0TGDsWrqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458832; c=relaxed/simple;
	bh=qGj0iqsYf6LO427haWm88855mpWkyRYG9g3zPuwY2Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzX7O6QLpMY4BpbsZE2jm6rUeJdy22S4RSvcmPccSD9cRaRFwwSEXl8EMJDF4vjUEbjZ+umojtkoRczLNxjupi2e9tVJInUsmn7eJXWDeBFNPbgNiqNiKl7JbXTKysJsCJT530awC+QeqHIrcb/jcW3azOFzWygjKzQFpHiKnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tc3iXSeK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebq4TSs5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc3iXSeK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebq4TSs5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789458829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJIAeyon3wbikzwzpPksiOeXqT2jqUB2p5F7HwQmi1U=;
	b=Tc3iXSeKDIufMvysz8YhSkQwBHIZxRNnaQo/YoW3sHp06cHpP4gI6hqTElz0s0qQizFZ3b
	Rtpf1bOxLSC2nYN3by4vwwd7Fr7pS7uYMoHAnOblMtseuRrXogws9GfsGTmimBcpq6Ofr6
	0YP3cskMyZXDvHlLKm/L3iIvDpJgW4Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-3N8SWyolNrurq7e9p9kHJg-1; Tue, 15 Sep 2026 03:53:48 -0400
X-MC-Unique: 3N8SWyolNrurq7e9p9kHJg-1
X-Mimecast-MFC-AGG-ID: 3N8SWyolNrurq7e9p9kHJg_1789458827
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c25edb54d22so186770666b.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789458827; x=1790063627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJIAeyon3wbikzwzpPksiOeXqT2jqUB2p5F7HwQmi1U=;
        b=ebq4TSs5c4fZyKCRwr1Gg7SrpZSHMv6+5ezCYb4oG/1gTBvy3mX43/PjWuWAWKFpLG
         P12wwml6DACq+d7nv3zKkqbZHvVAw0CJfx6zYGa0n5GrwNJDeIZq8ZU9BXZePX3USCHD
         lnjQ80UFLrQO4y05in//PqJQUQTJaXcFp93O30CJETpg5bKo0yHtSlkuwKEnzNR9nV/w
         g9FoH8gpF4SkHysntLYiwRUkQn0lJDZN19/csrOEQ1VD/O1Ve8Tsmzz8oUSC9SwlyT8B
         1B5JusS7W6fgPEnGdSO3f5d77cLc2arVCqahV5M4KS34e/N6JWIzY/D25x5Fc0wC3QMq
         IwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789458827; x=1790063627;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJIAeyon3wbikzwzpPksiOeXqT2jqUB2p5F7HwQmi1U=;
        b=UUGpCYsVX+J5e1puUTYeUeUYpBO4kUQT754lvaMlO8zd1aMchgLjtBqGzMSw9VlPIp
         xO+aQ5U4BUbo6GqjcU2RBM2vSyN4AkurkONXrErY/k1Dn7VzCQLRD35ucMWaFmfc92Ik
         JGWGE7xLSW3oKzElSYhAA0nwRWjxLQZRXyK3D14uzFvIwZwimTNpevGF+2+XJNVWBRPM
         PtUpKsxKZipjsdUNDJ3bfT27FfixDnaDXajauMKGKX0/6e55P91GSQ1ytwDILn5YgZOj
         y9wsF1hZfzzMUC4jZ1YkfRTrRVlvQQ9FP/UeXrSHNcXEU5rHch1YUTAv86juL8KjQGDE
         Rlhw==
X-Forwarded-Encrypted: i=1; AKwUvByoKCSyZqqCcVBKrINF7LrDwCdgouMH3U9SApM66zmIs7q1HZ7mVLaPMcHbkCeM5kur7A6Zi4o=@vger.kernel.org
X-Gm-Message-State: AFuF++lyiBACLtXVFZEpVmLk9KNase1KwhkXIEcpypsPmmL2ybaETko3
	FIvo7wW1UoYhk4PKpcvnoI0j8fLD44k0JRQ7QC5XogNP4l+9N/ANCPxed65AGtlqDGx7Gdotnh/
	Je4xFP/2ew+GKCyhaLaVbcOyVa1ZtgZBgsH10d5lfYToIAYBtZnBq0ggGHg==
X-Gm-Gg: AYBFou0UOfhqJhTjf6SFODfrm10KmKjFqA3YfjF7jlLwcNqI3lchmY/+NO/3B4jz2Kv
	oC5735CcqddM46qYt2chrDXUIrY45faute1q5xMYrez8efJLdtvygOM2w0v1U48L4rWoroYQOGu
	XrJ4+pW3o8jnSlPgrIwFB6daAnQD6K7p7tBq8NEX+EJAGS3DBlGQa+lQql5LNvbVYIdmLw57n1F
	487U//vKimpzMGFHZPhwm1pPJhgUe1pspgUuHQnbkwT2E/qk7lQ3ooZtMhrJC9rNowW7QvC3WXL
	+n6ckx2FvPfjuUpRdjLcCPH+s44ack9OQOHrGjsOFaI3HeGtniXl6Ctv6C8Env4mCcvOzFqmcaW
	GHZdUqIJ++UNQGX9J+a0e7cgpKtpJB5IOdELz76PngHBaugGmJeL5iWqqRksSdfc2+yv6/GG7Xg
	==
X-Received: by 2002:a17:906:478f:b0:c29:3e59:fd03 with SMTP id a640c23a62f3a-c29b872551bmr734228866b.18.1789458826947;
        Tue, 15 Sep 2026 00:53:46 -0700 (PDT)
X-Received: by 2002:a17:906:478f:b0:c29:3e59:fd03 with SMTP id a640c23a62f3a-c29b872551bmr734222566b.18.1789458826418;
        Tue, 15 Sep 2026 00:53:46 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296614323csm535287766b.59.2026.09.15.00.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 00:53:45 -0700 (PDT)
Message-ID: <b22f3b29-dd7f-4c9d-a975-a3753d41efce@redhat.com>
Date: Tue, 15 Sep 2026 09:53:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/6] vxlan: vnifilter: use
 list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
To: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com
Cc: davem@davemloft.net, horms@kernel.org, kuniyu@google.com,
 idosch@nvidia.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260911062200.231316-2-edumazet@google.com>
 <20260915020009.886579-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260915020009.886579-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 4:00 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
> 
> This switches the vg->vni_list walk in vxlan_vnifilter_dump_dev() to
> list_for_each_entry_rcu(), clears the saved VNI offset on the early
> return paths, and adds cb->args[2] to track the ifindex of the device
> currently being dumped so the VNI offset is reset when the device
> changes.
> 
>> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
>> index dd94085e08865..0a18c32902da0 100644
>> --- a/drivers/net/vxlan/vxlan_vnifilter.c
>> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
>> @@ -333,22 +333,34 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>>  				    struct sk_buff *skb,
>>  				    struct netlink_callback *cb)
>>  {
>> -	struct vxlan_vni_node *tmp, *v, *vbegin = NULL, *vend = NULL;
>> +	struct vxlan_vni_node *v, *vbegin = NULL, *vend = NULL;
>>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>>  	struct tunnel_msg *new_tmsg, *tmsg;
>> -	int idx = 0, s_idx = cb->args[1];
>>  	struct vxlan_vni_group *vg;
>>  	struct nlmsghdr *nlh;
>> +	int idx = 0, s_idx;
>>  	bool dump_stats;
>>  	int err = 0;
>>  
>> -	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
>> +	if (cb->args[2] != dev->ifindex) {
>> +		cb->args[1] = 0;
>> +		cb->args[2] = dev->ifindex;
>> +	}
>> +	s_idx = cb->args[1];
> 
> [Severity: High]
> The commit message says the ifindex tracking handles the case where
> "devices are added or removed between dump calls, ordinal device indexes
> can shift".  Can this new check actually observe that case?

I think this is the only comment possibly actionable. AFAICS addressing
sashiko comments for good would require a significant refactor switching to
ifindex based index. That in turn feels slightly overkill.

Possibly implementing a nl_dump_check_consistent() check would make sense?

/P

