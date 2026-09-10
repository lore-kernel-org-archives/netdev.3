Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B045D92C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037777; cv=none; b=BJxp4aVjLT+VWHxbdZhzPogZ/DPDds+B5X7c91Mp6s7x5kV23wN4S08ar9UHXv8xKylV5un3bbT1gBx1FzfAh1uzK15FExGkIHEINFFcAxoGRNBt9/fScSZqVRRlv/wO+U5rVclak25gTQj5HV5jL2p6HLUd4ato/dkNb9eDpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037777; c=relaxed/simple;
	bh=RZzN/VrGO/Lcn9qkFcksdPvlKhl+S3I4NUmDeoONm8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxj+zvqEKN62395JFo5Kz6lEaUENO4N/h3JK+MynMWdSm2V54c1iiuyHhnj34KTsVfAb+ItbRsa21lvLmZjTPLcdCVJ1VcdvzrdexDCBbr9QtZZPCOvKcEMdV2LdNEayDdrIXHDrMPXyvZDtW+5U5ebYlCLRnZo6rCRRrB59wxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERxovQ/Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXNlOfKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERxovQ/Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXNlOfKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789037768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+kS+43ImV+1fkCyHmKwfuzV6agDs57MtzRJAv0xXyM=;
	b=ERxovQ/YeCVqi08hEgT9+Ya5BjcY03p/OQNujhIgb0PBVUEA7LO2yDsMxBZpFJOhJURZrn
	hTrkzstr3OR78+aBQsTE9jNSidS3qa9+wSJmp2PC/1F6ceo1F5HiZLHCwNl9+LdLq4Ueb4
	lefBfGZDHzl6A/L1WqkG4xIKaJHhSww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-VQkHT6X-MaiNCce2QSoHmg-1; Thu, 10 Sep 2026 06:56:07 -0400
X-MC-Unique: VQkHT6X-MaiNCce2QSoHmg-1
X-Mimecast-MFC-AGG-ID: VQkHT6X-MaiNCce2QSoHmg_1789037766
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso47973215e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789037766; x=1789642566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+kS+43ImV+1fkCyHmKwfuzV6agDs57MtzRJAv0xXyM=;
        b=PXNlOfKUaYExOxWNtY1ZMuZPi8BLheCZIWYhnWWH5JLYwjlHACBf1RhSfMCLb7bz3b
         yjhZdqh1rUsTUH+pVZn3OXezBTT4ul9nru3zeGG76YKfKxkiNBzMmvGebnnqFDyBin8l
         TxjNynGh5jAPWmCsucs18F0p+chM6THZ3rqXPLR0241PQXLFq5JZvDugvPKr2sKpwg+5
         4UrtnkEwFjcl6MD0/crQrZHlLj7ZNdrd7Qc7ZWiy8mcULU5ffga/vIikvym+F1frGYrn
         ULOQX5WiD8SE+75N7oOUWTOnm630E3bh/5uJQHFBqzqFe/XvcvbKN8nF9CPBbzfUlqo8
         ROFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789037766; x=1789642566;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+kS+43ImV+1fkCyHmKwfuzV6agDs57MtzRJAv0xXyM=;
        b=bd0Z8EM/X+2e7lsznuHHWnJ2TgeuQ7BHuH6AVweXbghM/yLEJBooeMt6P2xX9ZOW2s
         q5gtwMhiBPGDU6aqofGMZsjKzy2EvQGcpPXZ15wtt3QBRze++aCgSmF+ILL+XvQ/Jwpm
         ewVYiw3vXj9Q/GmREHHgkWN0OTsl8Ea6PDkHDFW4oJfaBidPPKyN+6Q2u6UtRc3YA9Xy
         9crrDITSYl/woXuN3nh4zxRsG5ZKc0VWHBPBn2hCpoX0UEXGdW771t0tmdm87MudaCGK
         wvWhyb7Q3ewgVHySGqWpSCXmxyKMoF9UckKWuT1dsiGp7axNJL/0E72lWfozZItu+Rd5
         QBdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSvjYBsTWykg3JIdHS0MG2sou/0fmOqswT29lVaOjJfRFx5qxArrQ9L9TXjU7Utq0bQTI+dC8=@vger.kernel.org
X-Gm-Message-State: AFuF++nbWlB3jpOhIpYw4KyvVTcSqbMsW358c81b9smEg4d1E3aCvEDh
	vkMmlo0Fmg68Lt/NlKdBI+tqQOHpMCJrvUPMIM5luXyrF0gOYdcb8VKwfUh9jjdQCELxhZUl4ph
	73H5Upb+4cZGWk4Yv0kBYoN8xVZpQJtX56QwkPWmoPz4zWFRL7Wzh+T/aOA==
X-Gm-Gg: AYBFou3qHrKZMRq2c2gBwXHMjQl5aH+JU+fes9iXxG5Gl/Zr5nyvnn+yIhmLRG+rIqz
	w/V7j52uBRUgrNF3auh2c5VKWTLQfYvreyYGjnabC4FLxcFjG5QfPBFQhAh831Wy79QJFqISwlK
	S7HTSejP6iJVkzujM0ujajB9w9x6s5HNzJU+UEy39AeflBjhsru4hBI2KbQE7MuFq++3YzpvC6I
	2FCZSau/GHCfIGq3zDHSRKVgTmH58wGW9QJ97b1gmH9RIyOW6op7xypjqCqDdYIH4A5zB4rt3LU
	pP2AUAH6KshHaahoZWSfWSjF7SOzW5PLVmQjizcPkTsnWMoHbRZnaJFQpNWoDWiwBzfzdemgz3z
	GuQ3FBgfsjjZQSCyMZcvrKOd6ilbD0iFt0WDvN36vpdd4SVL7NLFBJCJd2Uc9uT+fVffKiJN1MA
	==
X-Received: by 2002:a05:6000:2311:b0:485:b027:a79b with SMTP id ffacd0b85a97d-485c23ade14mr6287048f8f.21.1789037766070;
        Thu, 10 Sep 2026 03:56:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2311:b0:485:b027:a79b with SMTP id ffacd0b85a97d-485c23ade14mr6287022f8f.21.1789037765706;
        Thu, 10 Sep 2026 03:56:05 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm44784660f8f.9.2026.09.10.03.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:56:05 -0700 (PDT)
Message-ID: <bb5eeef9-a78d-44c2-a8f5-2cddd274d3ab@redhat.com>
Date: Thu, 10 Sep 2026 12:56:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vlan: fix vlan name truncation
To: Janis Edvarts Lacis <janislacis06@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, linux-kernel@vger.kernel.org
References: <20260904210024.263220-1-janislacis06@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260904210024.263220-1-janislacis06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 11:00 PM, Janis Edvarts Lacis wrote:
> register_vlan_device() from net/8021q/vlan.c sets name based on a field
> name_type from struct vlan_net. If name_type is VLAN_NAME_TYPE_RAW_PLUS_VID
> or VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD, register_vlan_device() sets vlan
> device's name to the actual net_device's name and adds vid at the end of
> this name separated by a dot.
> 
> Network interface's name is limited to at most 16 characters, including NUL.
> Therefore, if the real_dev->name is long enough, then adding the vid
> at the end of this name can lead to the result exceeding 16 bytes which
> leads to a truncated name for the vlan device created in register_vlan_device().
> 
> This patch fixes the issue by returning -ENAMETOOLONG from
> register_vlan_device() if the newly created name does not fit in 16
> bytes.

I'm sorry, but I don't think we can accept this patch: this change an
user-space visible behavior: even if a strange one, existing applications
and/or setups may relay on it and they will be broken by this change.

/P

