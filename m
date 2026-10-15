Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658333264D1
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061262; cv=none; b=uSGqs2Qb/6WlPQ9mfQ23nvTgEW8OF2hGTy4kNkVGrOTMv8h+f8QMARgwvfJb0dtAUqV25V0cXRr4HVuJQwo1ZPfFndThWTc+KzFsSpbFHpRnoBwxMose2Ixt/v8uiWfJvaxWMXprMRTEu2ozvTo1gJ8oxlNrtmoHPxX+zN5vujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061262; c=relaxed/simple;
	bh=HK/VKSZ9I1yE6VDmueS5K2eeeMr+BnuxKv2J2PDLOzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4dCGiO8HceXri269nJAuUlJieF5dy2yXf3lw2BPU4/ifXf61FUcO0mwPg40/nbE/kAIgi/yWwHgi/OfWKGumAHr1yoGP47Tm02xf9FJf3acRnGLlBmo7Hm5PCGYy57EyHbuSrEcWsxYNeP1v8SSAAYvVQw3A1vVLb13yHkmSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ts/FrOQ1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxsOFw6L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts/FrOQ1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxsOFw6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792061259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9hzkWLgr2h8+XXGOMdqXKN0tQBywnbSugVvavE02rY=;
	b=Ts/FrOQ1Uj02bIFxVdYAc15NE6cW/wy/mQQc+tj+nDU16w7PSAE1DKsRXTbU+0agXyLcu6
	Tj2F6NDYXeKwsgLtJqgHu3TWfputstnUAGj8xa8TkUgT8OMQbN+u2BFBiQvfUy9iG5irSW
	YCR+x6opy8waDymhr3DaOoLt6Ny0J3s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-3WQ5NX0SN4m2dQpBA8WiKA-1; Thu, 15 Oct 2026 10:47:32 +0000
X-MC-Unique: 3WQ5NX0SN4m2dQpBA8WiKA-1
X-Mimecast-MFC-AGG-ID: 3WQ5NX0SN4m2dQpBA8WiKA_1792061251
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so13605845e9.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792061251; x=1792666051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9hzkWLgr2h8+XXGOMdqXKN0tQBywnbSugVvavE02rY=;
        b=FxsOFw6LTmOuLRfVkFuli90HdHEtvCbRYx+i2Vy41/kswZ9REWuYvaK2elSsXXQJyM
         e4KxMpnKB74aCRApqjmUjUVQW+uXL6A+3d3axFRCldN4ENkqc1EBpDyshpM1gFc/PsvH
         6UPCLS9vj+jZICcJ++moVMWA8in3OM65JpzbiIw1DLPimoljkrd3j+8IoE4G8IXSlzmG
         UnIvDXMxOfPbXLuIKD2cr7NgtrCK837Z147/Y2Ks3FvcVfWzjWIW9Q1mTrJ3x9/7EaTc
         uINvmt9B5IR0n5xhuWhLMAmF6etYOUplWAualIBE4uKDlUsZ7h4lw+rXXjzZs/tUvbux
         ug1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061251; x=1792666051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9hzkWLgr2h8+XXGOMdqXKN0tQBywnbSugVvavE02rY=;
        b=v9V0pv+g29/BiPZxSIACqkzKmtOL12QoaSNogtQYvjEm1lR2gUlhOe7b/jbu9218Ze
         HNZ0uKklcHpKmmgxVnSO+ZjMhslMoCRGsV/dtEqKp9Z4zRgy3fmCjmyUj2DTrhlXmhza
         Whr0Vg0DUrAXUuyP/LzyQuz43Q0cpMRT42ffNLQvjgRXQPsXa8RcpSASijk9lPZpFa47
         +zNOO7I1fDScKQNUJ8P7rZShveUp/SUVmCepuMe0XnCexlE/95K/UJwG9fn5UFgCZldm
         Mc3IcPmliFO9bAAqFWJbVI4k4c+O+HwCociZqCJV+4Li5erdmL5+jV1UOnd2Srnj0wts
         S14g==
X-Forwarded-Encrypted: i=1; AKwUvBwF3d1hNhKEgNa5dd2tK+q54OryyUjX52aFLAaPE/dHvfXTGJgJ8PiBtd98oc2yjPJ6F819jIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXMpYJbvTkXWlhU2mKVTa2u9hJuUXr++9Fu8HlG+wyf2q+0PAv
	iFa11+jOEvdGKBzovZVBoLlqdJy/jenab4MXvzTHSCRyO49eQsRL2/jz3eT1LhzlIuSiEIkHsn1
	75iiyQte+03UcYoJdJykuw6x0Bjpv2GqYckMcf8+mQ4Gv1RzIdYOnooADfw==
X-Gm-Gg: AYBFou1YLZa2xcUg0Iy7w0xA3ZrKkDmTk0UszTooi5CQaY7Pzx7XH3UeT352RczcOL/
	Q9oEYzX+xTnX5KPLwZWvX3ErKtAFj4hkBXLF60nb1XihKy0Ni6YGdbJAl3HpZoilm989USek+Jz
	ZbLFjltFO7lFab4aac5KSSidUMiECIjtEAJO9Q6pw0qA6Kp26zTSO32enWuMFrm+vD+Db6cLsOJ
	phjlh9NosybxD9GaSjh8xamdKGnmX313B71xU7N5mZ8wnI+9nZP/PW/J5UAfFAe+wPX1eulqxm4
	zs4NI0bYF7usNZtBFWM2eRLy5LpMSevz4RUsLwncUJ6bZ6nUSz3oY7O0a1vSNsMUgmIh2QBqF5e
	yXUW9JGv5mm/fstZ4oaMMziDVveM/aV38MBdzOSLtm2cZz5dm6JLmFYRZOxwuictWophrZ6CAnw
	==
X-Received: by 2002:a05:600c:1e0f:b0:4a1:7b87:8d34 with SMTP id 5b1f17b1804b1-4a18e4b46e1mr384264505e9.21.1792061250920;
        Thu, 15 Oct 2026 03:47:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1e0f:b0:4a1:7b87:8d34 with SMTP id 5b1f17b1804b1-4a18e4b46e1mr384264005e9.21.1792061250509;
        Thu, 15 Oct 2026 03:47:30 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1beb77054sm39793815e9.1.2026.10.15.03.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 03:47:30 -0700 (PDT)
Message-ID: <852c9fb6-6217-440a-968c-b5ab3e22dbc8@redhat.com>
Date: Thu, 15 Oct 2026 12:47:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] calipso: update payload_len when removing the
 CALIPSO option
To: Paul Moore <paul@paul-moore.com>, sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org,
 Joas Antonio dos Santos <joasantonio108@gmail.com>,
 network dev <netdev@vger.kernel.org>
References: <179147329205.58079.5847298721173675285@gmail.com>
 <sashiko-outbox-165773@kernel.org>
 <CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/26 16:02, Paul Moore wrote:
> On Fri, Oct 9, 2026 at 11:32 AM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] ipv6: calipso_skbuff_delattr corrupts MAC header on bridged packets
>> --
>>
>> commit 9797bee2d14350b4afedb726df3172b004b7badd
>> Author: Joas Antonio dos Santos <joasantonio108@gmail.com>
>>
>> calipso: update payload_len when removing the CALIPSO option
>>
>> This commit updates calipso_skbuff_delattr() to adjust the IPv6 payload
>> length after removing a CALIPSO option. The patch prevents forwarded packets
>> from being dropped as truncated by subtracting the removed length, while
>> leaving BIG TCP packets unchanged.
>>
>>> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
>>> index c6a34334e657e..5a42db4f87472 100644
>>> --- a/net/ipv6/calipso.c
>>> +++ b/net/ipv6/calipso.c
>>> @@ -1428,6 +1428,10 @@ static int calipso_skbuff_delattr(struct sk_buff *skb)
>>>                skb_pull(skb, delta);
>>>                memmove((char *)ip6_hdr + delta, ip6_hdr, size);
>>>                skb_reset_network_header(skb);
>>
>> [Severity: High]
>> When a bridged IPv6 packet with a CALIPSO option is forwarded, br_netfilter
>> feeds it to the NF_INET_FORWARD hook where SELinux may call
>> calipso_skbuff_delattr() in net/ipv6/calipso.c. Does shifting the IPv6 header
>> forward by delta bytes here without repositioning the MAC header create a gap
>> that corrupts the MAC header on bridged packets?
> 
> I haven't chased down the bridging code to confirm if the problem
> identified by Sashiko is true, but I do think that in the bridging
> case we don't want to change the label on the packet as we might do in
> the routing case (depending on the runtime config).
> 
> This would need to be tested, but I believe we could simply add a
> nf_bridge_info_exists() check to selinux_ip_forward() prior to calling
> into selinux_netlbl_skbuff_setsid().  We would need to add dummy
> nf_bridge_info_exists() when CONFIG_BRIDGE_NETFILTER=n to
> netfilter_bridge.h but I can't imagine the netdev folks being opposed
> to such a change; I'm sure they will let us know either way.
The above looks like a pre-exiting issue, the patch itself looks
correct, right?

/P

