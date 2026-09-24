Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB234F24A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249122; cv=none; b=K9rcEKPZzOkKPd/bUnxkGty8IbduISA2H92EdzM9VdZPVJcwmclbSnrKS3JAx7763kE8ezQznWxIsbEvNyjxho9Qtx8Vnb5witDrOpeTh2SI/8FYAtLlJgi6t98gKGHtAHyHi4DrWbmt2qqnbQDArQ0oJuIcekX/Z/wBSJaxbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249122; c=relaxed/simple;
	bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cvAPL+Ieyo6rBrck9MfIVe9CH0ZAb1q4INPB5Y8lUn/i8JZygJthGPftupWq5ayGySLgmdnKnoL3BUwwC35Q4t19kGfKusxFI4Elhggy15co7o9BVU+Rk8xj4YXOeThk/gpinUDNr5e21eRcVYRqhTHIFLRcz7xeTZXVEiEVGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XL8zW9L+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDU2gHmR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL8zW9L+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDU2gHmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790249119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
	b=XL8zW9L+uIKMySj5q0u23kdR2442mOCrUQFPYRpI5l6Zi/lb6q4RqqnPiQiNXUMRMMFYjd
	xzzmsq+nL3f/4j1RdsXbY3S63u0KhLsTCPk3xLp8P3928muaaFKsBAtAsXys+DWEOCLp0u
	GoqW7uL8/lIGMKozLU6VGVKTYEsfic0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-jMv_ItKNPQWnJON4-cA9Iw-1; Thu, 24 Sep 2026 07:25:18 -0400
X-MC-Unique: jMv_ItKNPQWnJON4-cA9Iw-1
X-Mimecast-MFC-AGG-ID: jMv_ItKNPQWnJON4-cA9Iw_1790249117
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso18605875e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790249117; x=1790853917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
        b=eDU2gHmRFI+JR2kzQ7NM3f0T3x35ypYqSTB4Ll+Vttl30vIKpIKmzdQ4wBqEKp9SRG
         d/4r5u3+oA4miQtNSmWhip/eBjk/JoA+48OR4i5HLROMASXYhBkcXfxKVKgTQcNHIDET
         2dXqRhbELCOBtE2Bf4JCLReFNdl0ZXPiICoVc4bjlt78NiNIkX1egWkBr2cQx95n6RkZ
         5JNLixPYoV4p5ZCvDoywtxX1zdni7rf3o9GXqaJyzWbHYdA5Ijq9K+AIL3SJTLcSpUWw
         QDKSez1eYVN3a0rXsRzt41WzX8KAODwVPMunBkipzlVqdS/GXPfo3LP8E7si0gRtZuOk
         baHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249117; x=1790853917;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
        b=RczqJwxq+HkM9BFzpACYgLZche2eAJoNwE6o8Q4hOQfrgBX3b3F2SOqSfK2f1vofv1
         fnkuUgjyUCP+TWzkaIjpDkeJpGrHOi38UYvxY11Khx7ReQJfBWpDbIstzp19gBCJ6ccG
         l8rB7Ef/vc/lOiIEoYdPFKoXTp3uI43S9nnnWdlYcEUOAu0BjhkGBkOAOmHbHISmFQrU
         tQA5tJGHqDcXYyCuEB3aBF5ppcPs9nqKtqbawQNUPA9UG4Cm6bce77l8cnSwuTjMwVkx
         TjHFeqtGFIujTSYpdDbKxYHwjXPkLXMoxe24DIJK3fWszJb5l9LCneuk9wFtAmpik8wl
         TTDg==
X-Forwarded-Encrypted: i=1; AKwUvByRtenX9OEWAShsvq+yjFIxzDT77UFAcjzCb7WdGf0HUMZ9F6BGGC5Rj770A5iK+EKDWGTlR6s=@vger.kernel.org
X-Gm-Message-State: AFuF++leTdszJGGuO9ia28cscmp7PDahtig41A39Cutk8WBD3oDHK48F
	chnDMQxiP1lIJ1WC40feYhWZPZZtsA7F7mD6Or3RpZwKTmpJl9sS4O2OW21JdB4uS8MFtt6mbCi
	UZAzJ18Jw/U1HnFIdt3MNS77JAx5ccN9y/G4xzlwp97aDgNcRMQnVn/gdxg==
X-Gm-Gg: AYBFou1wJB462Y/z4UcB1a/mTMbYRTzkgjozP6BOKkcX3hBVfJ+ha2MM2B/iuhtPY5e
	TLGvi4HsI7tVAtXKLtXDjkcaetuN7nxscWAYwhN1qtmb59iXSmK+aBV9V5DSzZaZn6VvFSPM5Tx
	2ofY91ucG9viA+wBCu2gleQw0qbCqeMEzbiCcOUWJFFpBMqWmMPengYp9N/uNSAJ1L4KO6NM81J
	VcOEwGoIv0mPd3bw05zHdcU5nNpEMVfTfLLl0zClfZYxNXx+ELxmik42vgFVTR+HrCnpQJ11XyZ
	VJOIcVFeVh4/iNXNEh+IOMeQBzpgpzYKH7PG0rtrS6YvmXDaQI1+LmGvbgH27v0vloItJKqBvNq
	jm5aIkk8ZXRENdEsFPcg8i4H9vZogiqJj1asDx1hdXnsq9wGEcNTHw3NwEzxFgxzKnc5u69f5dA
	==
X-Received: by 2002:a05:600c:3b8b:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49fe66c301dmr40127525e9.3.1790249117062;
        Thu, 24 Sep 2026 04:25:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8b:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49fe66c301dmr40126835e9.3.1790249116588;
        Thu, 24 Sep 2026 04:25:16 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c16dsm90528915e9.3.2026.09.24.04.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 04:25:15 -0700 (PDT)
Message-ID: <b5e4e86b-356b-4ec8-b6c9-e5ef6a3b2d50@redhat.com>
Date: Thu, 24 Sep 2026 13:25:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-09-18 (i40e)
From: Paolo Abeni <pabeni@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: maciej.fijalkowski@intel.com, zhaochenguang@kylinos.cn,
 magnus.karlsson@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, horms@kernel.org,
 kerneljasonxing@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
 <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
Content-Language: en-US
In-Reply-To: <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/26 13:23, Paolo Abeni wrote:
> On 9/18/26 23:24, Tony Nguyen wrote:
>> Maciej fixes various issues with VSI setup, cleanup, and rebuild paths.
>> Notably, keeping q_vector allocation synchronized with channel-count
>> changes to prevent threaded NAPI reconfiguration failures.
>>
>> Chenguang Zhao fixes AF_XDP multi-buffer handling by correctly copying
>> and attaching fragments and cleaning up on allocation failure.
>>
>> The following are changes since commit 46bc52d13594848023e681860df8700c8db14354:
>>    ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
>> and are available in the git repository at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE
> It looks like clashiko has found a few serious regressions, worth a respin.
I almost forgot: please note that the current expectation is for you to
address the clashiko comments on the ML.

/P

