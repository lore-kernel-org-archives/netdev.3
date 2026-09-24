Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC549F118
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265224; cv=none; b=lweX7EaQceB3d6HG5dAejrO7LjBXFADOzfRSYonu6Z0eagC0X1QurC0DjVypmL9HLCmQJIKAFvoYKjfdPTMJYEzLVnMH5o4s/E1sj3iJtAer/6NbaQ+O8hP7u0WjaZzFVVWpOyrcZhx+QGQwsTXvwNSsdElGBpYcugPtbKwwQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265224; c=relaxed/simple;
	bh=PTtBSYSDUfZf5VfFZFH3g0z4gsBQKJpsJZVGEifIlPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW5jCVSovtqYVSnfm5mz6sa2N+vbYL4nDDpBYdWqwFi7tWaH7Jw4dl1dPUJ0XMlSDuWwsjqtz6KbWqfS/7Yxji8TsDmtdD42RMJ0E83oPEt5F9xtGc4k4cY139TMxnthcMi2nIi1KIjIu06fa6OkIfv0HqwBZelXtKO0gq29uEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/KSWcC6; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/KSWcC6"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2df8e123f51so593105ad.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265222; x=1790870022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rngzbyMdRPKF/+JAIf1xnAWkOMWjk5i2fkv3wkWqySE=;
        b=b/KSWcC6JhTvWwDjO5wK4u7SEpCqX5M1pYJHQrxfeXdC2DFprOAPWC1blLjGzamgV0
         pc0DCbK+9/Bgz/8tVCRnDxADWaKFcW1lZkY4dTNP72t2Xo5JiJFu7aOKiVVVw0ukA7es
         mRoY3rTReQysUywv0x7l8nbzwHFoqkvT9Zq8IswvYwdRQRF5eNwnp/DbZV2dEAUHhXWJ
         VzVNKGmXtRJoSifKaVezS6yJ0caasCMPbqDsYN0mwhqaZW2rFl0k/+DiMLkhDYp5oQ75
         cPQMhZiyg//wW9xYwq/h6y0LFmOeJj66Ja9ioB1LdO6EB3LAL5dZIYeqliY+nuMqkehy
         omng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265222; x=1790870022;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rngzbyMdRPKF/+JAIf1xnAWkOMWjk5i2fkv3wkWqySE=;
        b=XCdQvADg0uPXyZf541dO9DGpFgxW6qWbqCJN4nuLlOtnzRvm7IZiKIqnTWZLX0cXNu
         SPvo/TyDDNU29VK9JutpkLDJ98WM5VbLHjwuCbmCidbko/UtsWqS0hM6Po7VHPdf2gYr
         F4abWkqB4xgA4fZ1w31TnBMp0dmBIploEllDmSDhTX+wHKWImvqfqfv5Bkbw6IQN6psF
         BFBX+pRF3gPIE25EW+jWtlXcwST0wgBCwy4Igv1L9LNsnvSTl8jv9zimkxtTeKmbvogv
         vAONXtdZFQW3QGFrHtY9dwjbAI+sQeei/kNAAaNfsZQ6kaZRSfWppxJU8xkXUvasjR0J
         /inA==
X-Forwarded-Encrypted: i=1; AKwUvBz+NTdUdDF69UDaJ28tAE6MNZGtsQRVGHi81BaQLQkQwEtDSlpMtIydejzz2CZdyrX/R74igDM=@vger.kernel.org
X-Gm-Message-State: AFuF++mRpvBF0A7A4kVyxKREVK+jUWleDNWbHX5uUEYjSyr6I9J0A+lt
	G/Etol3lf13OhJBVtQ36INQoyER5jNt28CS9IaBD8O2hvxIt3UFTW3tk
X-Gm-Gg: AYBFou2zqBNlD+Jou+Mz7smgZbsuF5WYA0a8XYYEIYDa6HaLiBOkFleXIW9oqbLX0Jq
	aomwMrdhEfaDqxpUUyNFOMF/9GNNsd+V0fi76LM4lznSXGVvIV2adKSDWmE7zC55iAukRflYQS9
	SY5rwgZar7RYCCIrcAq1RYXEeWj+5VuGtaO+3v6iVCk2AB6/joDgfmMFPIqblKj2kpLbgXEDXi6
	vUJD9avMeBu5JN/Am1szKXZ+EoU1Ugo2o+VcFqAyi7TCemGPkKSmMr4z8U4cZkGkzhhjyQU56k0
	Q9MabRk6VfR/c4ZYRzkIXkf+AnQZ9GMS2RROKLci4gO+zs477SIrqNQYLv74DnFsgZZXfPvHZTV
	qcj5E7Ity94mmOMrTSuB7hZdKAa1e7mt8JsDodOanorQuEJgNm7nS+KyU1ZQk9p/3aso4V58y1C
	MstFTJY4mmZKdX87ixOiMg83Ibbr5rzUW5446eKskJtsb5sx23uhVU7otCaVXLOByW
X-Received: by 2002:a05:6a21:e8c:b0:3da:1e7b:ea27 with SMTP id adf61e73a8af0-3de0e74f4e5mr2877184637.21.1790265217375;
        Thu, 24 Sep 2026 08:53:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3f2d0esm3126843a12.22.2026.09.24.08.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:53:36 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:53:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 1/2] net: use a single lockdep class for the
 netdev instance lock
Message-ID: <arVHVi-UhnclHEt2@devvm7509.cco0.facebook.com>
References: <20260923223545.3815583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923223545.3815583-1-kuba@kernel.org>

On 09/23, Jakub Kicinski wrote:
> netdev_lockdep_set_classes() puts dev->lock in a separate lockdep class,
> by type (netkit vs dummy etc), with the intent of keeping the instance
> locks of individual devices as independent from each other as possible.
> In practice it does the opposite. lockdep only calls the cmp_fn for locks
> of the same class, so netdev_lock_cmp_fn() never gets a say when devices
> from different classes are nested. Instead lockdep records a dependency
> between the classes, and reports a circular locking problem as soon as
> the nesting happens the other way round, e.g. when devices are unregistered
> in a batch.
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   7.3.0-rc3+ #26 Not tainted
>   ------------------------------------------------------
>   kworker/u256:1/326 is trying to acquire lock:
>   ff110000104fce28 (&dev_instance_lock_key#6){+.+.}-{4:4}, at:
>   unregister_netdevice_many_notify+0x1141/0x1c30
> 
>   but task is already holding lock:
>   ff110000127f2e28 (&dev_instance_lock_key#7){+.+.}-{4:4}, at:
>   unregister_netdevice_many_notify+0x1141/0x1c30
> 
>   -> #1 (&dev_instance_lock_key#7){+.+.}-{4:4}:
>          __lock_acquire+0x767/0xd60
>          lock_acquire.part.0+0xd0/0x260
>          __mutex_lock+0x17d/0x1f20
>          unregister_netdevice_many_notify+0x1141/0x1c30
>          default_device_exit_batch+0x3ee/0x520
>          ops_undo_list+0x2cc/0x8a0
>          cleanup_net+0x442/0x9c0
>          process_one_work+0x951/0x1ab0
>          worker_thread+0x5a6/0xd10
>          kthread+0x339/0x430
>          ret_from_fork+0x4a4/0x6f0
>          ret_from_fork_asm+0x1a/0x30
> 
>   -> #0 (&dev_instance_lock_key#6){+.+.}-{4:4}:
>          check_prev_add+0xeb/0xe60
>          validate_chain+0x598/0x900
>          __lock_acquire+0x767/0xd60
>          lock_acquire.part.0+0xd0/0x260
>          __mutex_lock+0x17d/0x1f20
>          unregister_netdevice_many_notify+0x1141/0x1c30
>          default_device_exit_batch+0x3ee/0x520
>          ops_undo_list+0x2cc/0x8a0
>          cleanup_net+0x442/0x9c0
>          process_one_work+0x951/0x1ab0
>          worker_thread+0x5a6/0xd10
>          kthread+0x339/0x430
>          ret_from_fork+0x4a4/0x6f0
>          ret_from_fork_asm+0x1a/0x30
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&dev_instance_lock_key#7);
>                                  lock(&dev_instance_lock_key#6);
>                                  lock(&dev_instance_lock_key#7);
>     lock(&dev_instance_lock_key#6);
> 
>    *** DEADLOCK ***
> 
>   locks held by kworker/u256:1/326: 6, last CPU#6:
>    #0: ff11000001c2b540 ((wq_completion)netns){+.+.}-{0:0}, at:
>   process_one_work+0x117c/0x1ab0
>    #1: ffa0000001a3fd18 (net_cleanup_work){+.+.}-{0:0}, at:
>   process_one_work+0x8ce/0x1ab0
>    #2: ffffffff98f53288 (pernet_ops_rwsem){++++}-{4:4}, at:
>   cleanup_net+0xc1/0x9c0
>    #3: ffffffff98f6ede0 (rtnl_mutex){+.+.}-{4:4}, at:
>   default_device_exit_batch+0x92/0x520
>    #4: ff1100001321ae28 (&dev_instance_lock_key#7){+.+.}-{4:4}, at:
>   unregister_netdevice_many_notify+0x1141/0x1c30
> 
> Keep all instance locks in the class from mutex_init() and let
> the cmp_fn run. It allows nesting under rtnl_lock, which covers
> the most common case.
> 
> The cmp function itself also its address gets compared by lockdep
> so it can't be a static inline (that'd give each device type it's
> own cmp_fn).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
