Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520E4DA553
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613701; cv=none; b=opCZC4aXZjPPfu3WOuh62WIwXkYrB7VzaB49XDW07wXEYYNnicyIXiwaTirEMZAaejFxRQpe8w30tGvGMGsIh/dj5m9J6sHeXgKD1j2nbBnxrW8Q5Abi7SX+jJJXHtKQdJZD86lJQF7UMiWvjvZpN8nuOUFWZcerX9Is52Kqsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613701; c=relaxed/simple;
	bh=5xjS2f3/Ql/zj8ath/ALn7U8wETF/xkittUAewAGmP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPHXKcPntgOzNbnYpc+C3n4UdggUJ9CSWWJVWTDTt83p+zxxeY8A2lS6ZDJvPrPLPo+sp1S5CXRF2a2Y0Ffbzb4B049FGW1t64XjCTzskpcA/qvaS00vK1X2aMb8AabMxl7A/947HB1vR+ALbXGuRpJ3xMCLgDSTAc/SrbxZffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVTyKfls; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVTyKfls"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-39b2ad83680so845871a91.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790613699; x=1791218499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=trSxlf1BSWiJzh/bTSEFX6dAtAgylQzvG1STXJmAgcg=;
        b=TVTyKflsvZq43J4fxS5V8QWUvl1alrxaAmc7w+9ARK9BMHvgu0b1kcRtaymoxiUFw9
         PDJecbMwL2XwTTLf0SGQhviVZO3LAJPe/gZ3/HwPnhPixQItC0/k/zhef/Y1YXqgMt5Q
         ZRIlnfuZucD4n9tdwwrKR0hUacwkosvYVGOi/gY+IY/WQt3w79I69krwzkZLofsnqzMb
         9rGnfU8zK4x4ZslpUnrwpLkakjeaUDuCdRuxcKuuqjK+9O3bTV9604HeUa3809TaJgLj
         wRnMmcT35IS7mefXt/c515Gtb7aBQC80a1bg6x6jZTmqLaE4yjHIED0kYvOFflOF0yjV
         78jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613699; x=1791218499;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trSxlf1BSWiJzh/bTSEFX6dAtAgylQzvG1STXJmAgcg=;
        b=shoCjyx5cVkwdxdCnZTxBh+5spUEMksln606jHRBLaD2vCCBerRMYpl4WXs11P8d3R
         bZ/PwWaq/ppqi7yX6HzyhvvAbj6f1zSL+9vwm5HGo88Zsz9vSECyDJLC8z/x8ayMTHfq
         j8B7MU6BtbDokH3MehEgAJhr0auYDaBOK5UmVaY+KKKADOBBRv94efUX389l0MARZ7Zv
         UD6AS2+0+juLkyAiTtgOq3tN5reieEmA5LA2CfqNIQdj1l7OAu1GwuUJ4v9CL54F4zWZ
         5ZGuw/Xkl8ysJR80e8VVL6jJTJNJCtEZkhXpvxyymxv92viVsPA3OJgVbFM/2FH3yO8y
         yyTw==
X-Forwarded-Encrypted: i=1; AKwUvBwPuvQ9YWIGFq0Uq6wnfAbVA9uXHwhaTmVQUfnHZqi64ipVw6LV/Xm/dmxky6ui1z+c8q/IS0g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjWxNR0miPLs3/1jDIbqorb1fYVEuVIKAAegg9VZxUbt6F713z
	MCDtCS/0sPK/mCw15XRkPhj9AWcyw0mrTBoplKuD+CGiSs39ExxKG6ck
X-Gm-Gg: AYBFou0WzyHCb3HIjCLPG7V3/MNfTo5OPGBBX8hA7yUvLn41tM1G2h+ypBFENuz1ESD
	ozgSjF2t0uOQZN3iVKUpKUjmGeqLSbmJzLYgEW+bBhwOqhgJkmYdmF5WC6gJxuvasjUQjID5e8L
	BnpMB7KXNPR0g7F/TMRkSnY74Ny3/EmK/w8MTl/d+HKfJxt5dRucd5tLjkNZDmHvYMMR9ZZ+eSR
	dNPBNSrGJKT0T4+tjdYNfYfx42rlLAWLLpE9tfPSeZf08n3DrdUCRlAfnmXMHZkR7Adfn1ttfUV
	Wwx/Hv/sC3BrNNjEYTzXfCSf/DhKml0eZmWa/ch2uniGyRCHmujMl9rCUxZ9+s8jRktLBcQ4VJF
	QLPBXcW63XWI3nsO4T//P/UZ6Lc9fwNnqhPA/lxY/U2pb196SFlZOI26J37MbFV4ALgEfYAXqAg
	OepKXMUFM/DzS3abpL6VnX8rtDf8sbl6LyOB91VUo46aHF8AOlKdPfhq3uYURx/lffFA==
X-Received: by 2002:a17:90b:4c49:b0:3a4:7023:785c with SMTP id 98e67ed59e1d1-3a470238194mr1302548a91.48.1790613698942;
        Mon, 28 Sep 2026 09:41:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986ee2f7sm274741a91.16.2026.09.28.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:41:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 09:40:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: use two lockdep classes for the
 netdev instance lock
Message-ID: <arqYlL4mPX0A0gyA@devvm7509.cco0.facebook.com>
References: <20260926041832.1649675-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926041832.1649675-1-kuba@kernel.org>

On 09/25, Jakub Kicinski wrote:
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
> We can't put all devices in the same class, that'd be too permissive.
> netdev_nl_queue_create_doit() and netdev_nl_bind_tx_doit() lock
> a virtual device (netkit) before a physical device, without rtnl_lock.
> We can never allow locking in the opposite order even under rtnl_lock.
> cmp_fn cannot enforce this sort of rule: lockdep keys its chain cache on
> the sequence of lock classes, so with a single class both orders hash
> to the same chain and only whichever happens first is validated.
> 
> netdev_lock_cmp_fn() itself has another source of false-negatives.
> lockdep calls it from within __lock_acquire(), with the recursion counter
> already raised, so lock_is_held_type() always returns LOCK_STATE_UNKNOWN,
> which means lockdep_rtnl_is_held() always returns true / held.
> Use rtnl_is_locked(), which looks at the mutex directly and does
> work from that context. We may still miss a bad case if some other
> process is holding the lock, not us, but that's better than the
> 100% false negative rate of lockdep_rtnl_is_held().
> 
> One last thing, lockdep compares the address of the cmp function,
> so it can't be a static inline - that would work similarly to having
> separate classes, again. Move it to a source file.
> 
> Tested by nesting two instance locks from a module, one scenario per boot
> since the first splat turns debug_locks off:
> 
>   first       second      rtnl      reported
>   -----------------------------------------------------------
>   virt->virt              no        recursive locking
>   virt->virt              yes       -
>   virt->phys              no        -
>   virt->phys              yes       -
>   phys->virt              no        - (records the edge)
>   phys->virt              yes       - (records the edge)
>   phys->phys              no        recursive locking
>   phys->phys              yes       -
>   virt->phys  phys->virt  no, no    circular dependency
>   virt->phys  phys->virt  no, yes   circular dependency
>   virt->phys  phys->virt  yes, no   circular dependency
>   virt->phys  phys->virt  yes, yes  circular dependency
>   phys->virt  virt->phys  no, no    circular dependency
>   phys->virt  virt->phys  yes, yes  circular dependency
>   virt->virt  virt->virt  yes, no   recursive locking
>   phys->phys  phys->phys  yes, no   recursive locking
> 
> (netkit and dummy stood in for the virtual devices, virtio_net and
> netdevsim for the physical ones.)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
