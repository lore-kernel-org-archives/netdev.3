Received: from mail-qk2-f1.google.com (mail-qk2-f1.google.com [74.125.230.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDD3A1A22
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024288; cv=none; b=E0Icq+1am8BTHfHpqovH/sZdJAEXfT9VRiOmOOCu4JEV7xHQ+ytOEWYkqKaJXEChHie95iyP6sz1QQh017QCn0+w/uvazCz4rI8j3yU4M58kTjz4BnKjRIPARLRGNSjL59LjWWkN7b28y/D7XJWk+pxzUc9Hd84YdOLTvNsYiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024288; c=relaxed/simple;
	bh=wyE2OwvgbcPMdWuh2/RGAwHsFHMYx45fIQap4ZKGB40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgEnhvriuVJUnB+SIcTFm8KsPHir3B8q5xpT7g+XOzRVrS0IaTdTHOC/Jz2OD1iCoWDLOIXCoiptCh3+WnuhoaFDgn+rIxIQiHyjz699BJTvEaTISYPewlsBFY19mXlP5XhnRvzUYltc5ujgssLdjH6nP9Ony6ZlxFBUyZuhR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=tpWge6TY; arc=none smtp.client-ip=74.125.230.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="tpWge6TY"
Received: by mail-qk2-f1.google.com with SMTP id d75a77b69052e-51c1e8e50f4so4819841cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786024285; x=1786629085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3y/EEB9p9InBKNoa8h4sTdX9gn9fYoSNLXw9IdUUuIU=;
        b=tpWge6TY+dSO1wILVKpkV8Q0atmxxoJiDmO246UMdlwVsXW6a3X5sh67utM3olmIAk
         ckB/hEYz02noNtlac7IDgjTbAvkcj4THNb3CBWe4Mg5sNt/E0BTg2lO9BgeRAK1D9EE1
         FqqXqhoV2tnB8RZGNuChM9PSd12HLmgX2h6fEWnQoZX9Dla07CDViba4uhIAr6W3SpTO
         rNPR8g572NPDbdjp+wgQZyyrtc5rucytWL0jlMjBOy2yvboXsNRt3sUXxmqoSUJxJzZp
         4R1xy6UHbAWy7wiiWjpdbjpbAxroli84ItiZzSTGVo8FsLO9FoaIuNYqRtjhmGyVMe+A
         u57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024285; x=1786629085;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3y/EEB9p9InBKNoa8h4sTdX9gn9fYoSNLXw9IdUUuIU=;
        b=P61dUmbZN9M+Yzr19WefZWljy9/e9VpaEdvdxXP/qfYN7aRnKxEe8fEnEUAXH5zj39
         9BT3f0m/iUdQmykaVumZ8NVfuF/c7zcks1sr6ELp4eEpQqC2AB9+xBGVT0sPMcDmzQKL
         VkSLchVyMDrjvqVdigsJtB2H9YZ6OvQEtN1iZqPit8PaD0WRKlWM92mmrW4l8jYRb/e3
         Irmd+0pJYIfJvsvO8fEH+hcHnx/xziXoCMd5Mdapmo1qsgik2A0GmRoHlUY8CEfUY+k9
         lF9MiPlgFObd4Bcod283WbjF90bEqoL/NjKxoWufAJFdgsp+DtKjLz7hiTvgn+65rwna
         387A==
X-Forwarded-Encrypted: i=1; AHgh+Rr1QlzyqjAiV839c0NOuxk0WZrwxP7Ci4gh2c7eoa8vALjOzVUBIKcp3zg/SvlAOz42sW9nQgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAA6ni/9mu2xJyi0ctvqSamt5mCvKQtjxYNfy7fER077kWOxL
	tvtU3suYHsyLlrL2aiBtWhmXNsCNeWrKoDwXJVdoib1fFJiFZXZb357yWbD/kXrSXsM=
X-Gm-Gg: AR+sD13QDoP/sRskttv9s3zvZ/hXVDtDEt4xRZ0BprWiCda/tvtibNH+lHJNO0XWXpQ
	fzkicSU85+nNs8rXYgRDjmzXiKaVLKHyKdUUQDPp8sgcrgOApDH5H+PQ3RoGivWcEczwoMp38bW
	qrv3ElEHUAokvntHgBtN2GeMEPcygNSfVBoSAjpeCEGIchpe1bat2uS4Z8K91w6RsPM0IvTL/+t
	A3pCrvGnwHANbp147egV7u63DGmwarZW9VF1hjmRudjoSAKFQwict0RjMyIhfmCA6It3gPdF3j/
	3IqZmHR5lSUW3ia5WChUXSTbLoeZ2tDFPa+cX1nGYOYsn7s2PBmQbofqROkifR8kFvPNQbPscTD
	9Nl7bQxlm0Ra3sx6B/uFIV92Cfc1mzoSzB6eSQyE0d+Vwpg6fNvzf4PxauHKu1SMEzJ9qgeweOb
	O4QkdtLPLTtXCWcTjvSTxCXvKVhMUxIsp27amqV/aNKwWXmr2un0GRkiUoidZ1YZ3Vs1UqslDXD
	CZ0sDKLJ7h6UVh+c3BDnkZCBSv9iXPakO0DKbQAEZQscC2ADsYW7K6uuj6Rj0Gw/qFujkjuuKHG
	td+Cc2L1ArWtLYh0
X-Received: by 2002:ac8:5e0c:0:b0:528:3b9b:4f54 with SMTP id d75a77b69052e-52ce5f447d1mr141571101cf.8.1786024284897;
        Thu, 06 Aug 2026 06:51:24 -0700 (PDT)
Received: from ?IPV6:2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b? ([2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffbef5dsm52465976d6.18.2026.08.06.06.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 06:51:24 -0700 (PDT)
Message-ID: <511377bc-7703-410a-8982-3050ad27c066@kernel.dk>
Date: Thu, 6 Aug 2026 07:51:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.2 1/1] io_uring/zcrx: fail non-qops netdevs
 early
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org
References: <23ae94da6725cac660652781b3533a20d0a1ad34.1786016493.git.asml.silence@gmail.com>
 <178601764913.2132084.3867669701970816639.b4-ty@b4>
 <20260806064958.1b9ae431@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260806064958.1b9ae431@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 7:49 AM, Jakub Kicinski wrote:
> On Thu, 06 Aug 2026 06:00:49 -0600 Jens Axboe wrote:
>> On Thu, 06 Aug 2026 12:42:33 +0100, Pavel Begunkov wrote:
>>> netdev_get_by_index_lock() might return a netdev that doesn't have qops
>>> and also relies on rtnl. We're going to reject it later when opening a
>>> queue, but netdev_queue_get_dma_dev() warns before that. Reject non-qops
>>> netdevs earlier for now.
>>>
>>> RTNL: assertion failed at ./include/net/netdev_lock.h (72)
>>> WARNING: ./include/net/netdev_lock.h:72 at netdev_assert_locked_ops_compat
>>>     include/net/netdev_lock.h:72 [inline]
>>> WARNING: ./include/net/netdev_lock.h:72 at netdev_queue_get_dma_dev+0x52e/0x660
>>>     net/core/netdev_queues.c:43,
>>> RIP: 0010:netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline]
>>> RIP: 0010:netdev_queue_get_dma_dev+0x53a/0x660 net/core/netdev_queues.c:43
>>> Call Trace:
>>>  <TASK>
>>>  zcrx_register_netdev io_uring/zcrx.c:831 [inline]
>>>  io_register_zcrx+0xe94/0x1d30 io_uring/zcrx.c:983
>>>  __io_uring_register io_uring/register.c:942 [inline]
>>>  __do_sys_io_uring_register+0x1193/0x1bc0 io_uring/register.c:1040
>>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> [...]  
>>
>> Applied, thanks!
>>
>> [1/1] io_uring/zcrx: fail non-qops netdevs early
>>       commit: cf7aa48151deb629022a8b0c61c139dbfa579933
> 
> I asked for a different fix :/
> 
> https://lore.kernel.org/all/20260805165817.7e1fc367@kernel.org/
> 
> Outside subsystems should not be poking at random fields and making
> guesses. The assert is simply wrong and should be changed.
> 
> Jens, can you drop this please?

Sure, dropped.

-- 
Jens Axboe

