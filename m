Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097337BE8E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486676; cv=none; b=OmSeIlzQGyDJfDmdcfGurkcJ5LbIaQz3J7Mc7YlOpUPZ6ixSznl8qJNG28VE379VgLqGumzfQb4mEpO3z1EtUOItB7uTDtsL7pTbfFbbD1m2F6HVbvChDF1eCZ1+PYFDYq+2kW81qqmud87xLE5MUh6UU9MUJzdNUdyiz1OpDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486676; c=relaxed/simple;
	bh=MFI73bLJzYuC3bslZx/bwltYUGd/9Km+EomyS/QsF6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bx4f5vAwROTcBfH+ouXbueUuRlDRYidC+aLsz/DHRLrze3hCNKt/TrN4nJtFAcvxX3T2T/r3s4ZsUTg58uvXojOd47+pPSHPY9bQC/QKTcSH63v9ASdQZev499xgsJsEW5rtJyTF1F/zeZKWoCGCpEacVzcthm4kxo0JER6PK7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sYnEyek+; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sYnEyek+"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-351775aa1c0so1812092eec.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791486674; x=1792091474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nShr7nk4H6rZOzPK1tKDbu27hRY+4XFOH8yhDaWQWyM=;
        b=sYnEyek+TRmHxzqqEBt20pXRpW6MO3qFYPBvZLUI+uXtzegKNqFWihSrQj2pq4x9aU
         eMqB3m3qubnJ2nY5dQwDpzjXxJEM6Nv9W6HwdW6ijEXQk/+xkhe20KFmryzPMOT7u8TA
         rlvOmIPm07YU/2qJtDPHp+InLtUGuWypYsXn7vIKBHnEPnrCMpq6KPG7W2Tk56/aKvJp
         OHSb1ovmY6rTMFfDWLbo7JGCDimlKhJd/Zh0DPq2rcTT/qAuLzzWHzbjk1KZnimQ374A
         5A+ji3/KCYJqqstR4lcHw8mXNW4eTQs5LlblTCY7SAyHlpkkJupR/D1piSuzFAywpnwO
         2Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486674; x=1792091474;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nShr7nk4H6rZOzPK1tKDbu27hRY+4XFOH8yhDaWQWyM=;
        b=YxdeqO/5CV2dfZVXT6ntkHWR/O2SlnYMdxBFBGZEitt8h1sAd9oa8jcA+0N8fs0SzX
         tYGSD3RtZLicE//1ysvcc3a2AM68EfJa4Ukxf/WQt4dO2WM1spmc7lBJVekdESH/90AJ
         BjVLe59/KbjE7fNYSj6FnMXgwe98MZxUTQSjEhCyJZihlJr2b4veSKPV5UhqcpnwASp5
         16NXKXQgD7zvfXzHg3i8tVDODc1mdJc+TMqYf9Bl2oJt0rOF8AF9lP50PGM0Hol95N0M
         79f6iiRVmwKx6YXUKFhIQ6NCRTZENi2h6vVzsef3eK00nm24yDIim8BlsgOnxveWKFK6
         ieXA==
X-Forwarded-Encrypted: i=1; AKwUvBxkKe3uZm/ofgbQTwl4IX8yoFhK8YwWzoVWFMc0zNNCWD8ebF40mGRUd1gNiXnlUyHdqy8ZZUM=@vger.kernel.org
X-Gm-Message-State: AFuF++n4MMvPtd9r0qdeTRC/h5R3haqrJif/pi74dF6ccFS2xdG2MCnG
	C0rc2ERqDUgxXNEjyqtrDULxQaNwyLaluvYDgXr4uVoG+7qTg7qHCjwLcEBj83MmnPBGcSgTpPj
	mEYSntkQ=
X-Gm-Gg: AYBFou0TDB+ZwQzvHw5Jt0wmjcq4xwiiE206Sec4fKYC4E5eyJuXZ2e8R6f19IKH3tp
	KAwHaVbwlAzdkCYzNesLwQYXcc4qRIYfIo7kTh5cATFCQXIVz/V9AGrFiJsOOJ0LJ4GAuPAHOmB
	owRtg5AyH6u0yIiPcJNo0oZMWen+HBaCm65FNuppNn9asGFpgBv4mcYnUXINFFCB1OYWc2vrFd1
	5wVMoy/axfIJXBjOSnep1ZrPjQGOJCar6R+wEqZ4sozJDUbG4lb0rCW3qaLw/UJGLf1q4lL3gGa
	Zq9nOu0do4zdGJoOwTiO52iAM3Nk3gJKgMUpBnt/wnzCqSymJqwLfEO9j9QBkBJGMQUncdhYiHo
	5JaCQg0Hu1qZRk6fZPPtZYmsNflpb6h1Van1P54IzJNvtvR5YILZF7Ye4tffmQJrlJAbHQz0/c+
	VX857/NYQAIw8NcP21LDh+nFREekQxOVFio9TegDen3SV5vhCcZ4Bs6Ilj5oY9jGuo0n8NEuIyz
	Q8zDMhFA3qbgdqbZYfb0OauUc6Fyan0FGk0o1YlsSpZKs/xSN9KZtm6mg==
X-Received: by 2002:a05:7301:9c87:b0:353:5d25:1de7 with SMTP id 5a478bee46e88-3535d252333mr1169990eec.33.1791486673390;
        Thu, 08 Oct 2026 12:11:13 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cad9e53sm21393eec.22.2026.10.08.12.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 12:11:12 -0700 (PDT)
Message-ID: <3b9d9c06-c6e8-4166-87d9-c7c220ad0b58@kernel.dk>
Date: Thu, 8 Oct 2026 13:11:11 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: do not charge user provided SQ/CQ rings to
 RLIMIT_MEMLOCK
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <b5a33433-b0b9-4231-9998-23e2a2202091@kernel.dk>
 <20261008170611.1285778-1-hengyul@cs.unc.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261008170611.1285778-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 11:06 AM, Hengyu Liang wrote:
> This goes on top of io_uring-7.3 (c746673517c6), as discussed in [2].
> 
> Tested on that branch as a user without CAP_IPC_LOCK and the default
> 8 MiB limit:
> 
>                                                   before  after
>   program above                                       21     64
>   the same with io_uring_queue_init()                 64     64
>   30 processes x 142 NO_MMAP rings of 64 entries       7     30
> 
> The last row is what 30 PostgreSQL 18 clusters with default settings
> create. The number is how many of them got all their rings.
> 
> The per-user locked_vm count stays balanced over ring create, close and
> resize. Provided buffer rings and IORING_REGISTER_MEM_REGION regions on
> user memory are charged as before. Every liburing test gives the same
> result with and without the patch.
> 
> Not changed here: provided buffer rings on user memory, which is what
> io_uring_setup_buf_ring() registers, were not charged in v6.13 either
> (64 of 64 rings of 32768 entries then, 16 now). I can send a patch for
> those as well if you want them handled the same way.

Honestly, after taking a closer look at this, I think we're better off
with your original patch and one on top for pbuf rings. Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=io_uring-7.3

for the top 2 commits. If you can re-test one more time, that'd be
great...

-- 
Jens Axboe
