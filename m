Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779196;
	b=sEHXh7lMgnSUr86mBDf4HkKEmhBdkgHuvql7a8nOF+2qT8sjtI7nwPf6nZA9HhrPBBv5
	 mQFAApSuvVm9W77wstRXaPRBIhcw95IiIXDQ04Ixx5F3RwzWa+9Wt81Lgq51DsoV0aNQ7
	 FQou3AFzpocY5s24rlVD3bOnDkRuBQuVxxqMPZazCPWBj3hiTnTKrvu4nSsvHLW28x3xp
	 S1c0IvW3AabTRVIC3viVvm4A8W5WSO5++2//w1QOn3OOQqLxhb1fHcKtaERjny7qzLMpC
	 yxwbbeYjtdLL6tLp9PJ2hpeB6RRPf8aHLkZ9Ezb+O638sE+ZTNVru0QbWyerwpTEHmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779196;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
	b=08AEPB+l2LVfGw/8fHPb/F5vmBT+AuzH8xRN9a9yt1dbPMXLOIzLvAMsop+RyVu9oZ8k
	 93z8NJOfqW7bBokzLx8hrUQru+u7dpc7SBX8F+WoRIJmSfDWh80bSUb7sduDlJk/BAsF1
	 okgNVgxEykz1sUoXX/YbthKLMiCeLq8uOGoxFVxF0ylQMHXG8i1VkYoaqE337O5m5Pcgn
	 Ck1RkW+mRwoAcCswws4IQHwGpfhnpMSaLu/GrhSVujejeiS1LSUqe13vq/ia6pEJn3bsj
	 I0gQfxW7r3BBBCuhXvDWLAK3wCmGbbul0vcQ/5bCG9DmQwiDKCKJKFP32PW8imrRKWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=emuVAJiL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lJ9pI+Wq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B27606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B27606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=emuVAJiL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lJ9pI+Wq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793779194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
	b=emuVAJiLuoVUmeQF+KbraSCMMk70jP6aOR48HAejWhnx1HOE091fr84Qzzd2HLeie9WkLx
	q99yMFn/wlpLQVFalXCwoscTeecQDc1FB8pXg+52Lt1nup87Zi92zZ1pioH3xqlWKOYxSP
	ATjGkzshdAoOO36Wp4r86V5nyvezpVs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-iiTOZbyRMrWMpHNk_QBLMw-1; Wed, 04 Nov 2026 02:59:53 -0500
X-MC-Unique: iiTOZbyRMrWMpHNk_QBLMw-1
X-Mimecast-MFC-AGG-ID: iiTOZbyRMrWMpHNk_QBLMw_1793779192
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e17d30a79so266356f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793779192; x=1794383992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
        b=lJ9pI+WqL7ENyNnr5t3T0zNlG/tVhXquMfqele0iakChOwrXCf4jgI+IdPTUpVdfyB
         4MGUOB+SNgdqmQ9dYKsHxnwxe91E21AOBMwFDyxuqM71NZJT7eGNq0NUx7BwslSUTf7b
         7UFdPly5PUn6VXbIAvmkLisrXB8MS8MUkd8CGjfcdruc5vPg2Nwkm82cOXpJwYN+6eKc
         SCWKP25hDnzDNAuS2MYDMFn85c7fLrNNNIZ1vjqWsMSqrwlB4HuVDkv9gvbEIVQlTxVl
         2igz1L+34KSvsobyPczXeTs2d6Bxt+to3tsTRSiifSkVULvPMvvqehzw/FJUHN1zsvOB
         6QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779192; x=1794383992;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yiChu8vq+edNPq126HUtF4j2CY5fLpw6fU/VctFSVc=;
        b=hlFwlvxYUxEZTkqEXUhb6Y9PR+Xdk+HD8EQ1ZVs8Zf6XDiRvLI4dGRUJwmH6hy1Ckc
         r6UcP0HVUoPCt5Qk9GxwbrSUAR11X4XRLiMaRhHPB17n/NAtS6ZmkouUpOxUCRPaDzzO
         oNeic1QoTOxTIHMznlKo7yUZoiGWT9hyDSzqqEaUVBi8aifBxvktjkjnTpGG6FVu3awC
         GVe3M8MY7t5UnCUNwsBUbhJ4jG5PZNF0BTcu2JIYhlwdJYJViya/xbcDUuDQ70QK9AJe
         y2a0kTEge35pa5OoJzNtKQ2kGLu3Z8bnbV8vEw+kjJwSxsBYYPH7lKmfZDpMjt262wmi
         11ow==
X-Forwarded-Encrypted: i=1; AKwUvBxmHSdHfXM6m6jS2lK62F9/yUZRNxOVOEb9JNc58DDOmiW8cK8fqlTPFSIJXLusUhp8LFGIWPQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mg5QYRZidewqyQ44ASM1EFSHkRmWTndhpbbBS82G+2+RBLTC3
	8zwEPv22Gq/nOwHYMGjZuZQIxehKVIHDOtRqDOyPwMnrploGo4Fa6MKnKIomQJEH4BAc6ZoZJOR
	lkDY7C2I2/PvNfLgq2PAUjtjeq3FNCnNUwFrc1ZacZnzFQURZw7ZkEmunaA==
X-Gm-Gg: AYBFou3wCdkA0PIcJSiDVkKFlFlrDp58JBrtl/zmTp7RsMwO+R5ycaJs/BpLp3S/fjB
	RbYvliu+VK+u9Y4KCZRvPH9K09d+zWCaX/ewLTrP899vmEpdSSEm7BxIGxUONBf8+5c2DIKGP7H
	UDVWNBvpnMMeJ8kY2PFptg1mGvAS5mRflB0p9gtIPQ434X4uFLu55MYhEVCbjQHHgTE2PSDq0Nd
	lK7VfmhAjaAVb8w8QFKiIs/CO9KbPN7CWATC9SIybGh4ozzZc6vCEmx0fjug/8Ddaw9bVlMPUdI
	6U7fg7/Gc6OPt9DQ67sda/ImswT8QW4u97oFiKSghjqOHCQgufc71tq9y2Qmf7mfSr5Bm9rk1+c
	up05xBZU3L738vAsOK5FWY/RIWM6/CWliWGb4K+ProwxcMd1EYNmhG/RjTCee97eY18D0glaWoI
	vRsZnX5aClZcjMDPHT5xz6hTo2lQbEXxhEsBfmvzBCYwg=
X-Received: by 2002:a05:600c:1f93:b0:4a3:2f35:38b6 with SMTP id 5b1f17b1804b1-4ac180f1e69mr337279645e9.24.1793779192283;
        Tue, 03 Nov 2026 23:59:52 -0800 (PST)
X-Received: by 2002:a05:600c:1f93:b0:4a3:2f35:38b6 with SMTP id 5b1f17b1804b1-4ac180f1e69mr337279325e9.24.1793779191790;
        Tue, 03 Nov 2026 23:59:51 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b452cd020csm29683995e9.4.2026.11.03.23.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 23:59:51 -0800 (PST)
Message-ID: <7f8bd24d-7538-423d-b2a9-f5b0eae99d41@redhat.com>
Date: Wed, 4 Nov 2026 08:59:50 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
To: Hyunwoo Kim <imv4bel@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, martin.lau@linux.dev,
 john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net,
 jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
References: <20261029214219.1035176-1-imv4bel@gmail.com>
 <20261029214219.1035176-3-imv4bel@gmail.com>
 <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
 <auqJOj7RVCWn7Ucl@v4bel>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <auqJOj7RVCWn7Ucl@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/26 02:24, Hyunwoo Kim wrote:
> On Tue, Nov 03, 2026 at 03:49:40PM +0100, Eric Dumazet wrote:
>> Le jeu. 29 oct. 2026 à 22:42, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
>>>
>>> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
>>> of refcount_t"), default builds implemented refcount_inc_not_zero() using
>>> atomic_add_unless(), which provided full memory ordering on success. The
>>> commit removed that ordering on weakly ordered architectures, allowing
>>> accesses after a successful reference acquisition to be reordered before
>>> it.
>>>
>>> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
>>> lookups and in inet_twsk_purge(), where the socket is validated again
>>> after taking a reference.
>>>
>>> bpf_sk_assign() can receive a socket pointer obtained through BTF
>>> without a reference. Use acquire ordering when it takes its own reference
>>> for a refcounted socket.
>>>
>>> Use refcount_set_release() when setting refcounts in the SYN cookie,
>>> TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
>>> TIME_WAIT smp_wmb(), which separately orders the refcount store before
>>> ehash publication.
>>>
>>> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
>>> Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
>>> ---
>>
>> Lack of links to prior versions is rather annoying.
> 
> Is the cover letter alone insufficient?
> 
> Should the changelog be in each patch?

Ideally the cover letter should include a very quick/short overview of the
changes, and a per patch changelog should include a more detailed list
(no entry added when the patch is unmodified).

Thanks,

/P

