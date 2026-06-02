Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E83FBB55
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422602; cv=none; b=I7U/7fWN93zv/ZPdYzKhZNSGgIN6QlExBJZxsGM7Wp7OsiV003SnP0NA1XR/Wk/SVdeItyucEVvyewWv0V+rP/TV1G8SZvXMriwPMQc8GsIPVfw7HRoIqBI8a/DFESWeZXIm+RCQ0U1cJb3Cpg2xcAtNoLsP1X1BlYxV00wmLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422602; c=relaxed/simple;
	bh=ApVVkBNFSBGlEWor8BTyR76u4OfBM15XCH253h06Hxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LICkdTU2lEvjF29xxGa5TAUKjckSL14WTeJWQIXamlbVVPH5RmQQxcM0xd5lkAEx1eDhUROVpFwfzuvXArS2BXMCGKiVoBnIRKrkzJEaRyFy376jUcxhmaxlPZDcCSZGbfwRVQd3GOpxk+Q64yzrdfd72AYiDOzhaZEH26ZFcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC83wCUx; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC83wCUx"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bf02708e8fso41972805ad.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780422600; x=1781027400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkXupQZv2n7CPQXQp8Ed5AJ80vuEq4N2QBtHfZYmiU8=;
        b=dC83wCUxCOpqBCruNKjnCAgq7GQ5xlNKqDDqbcwGrEVmesfVl5ANMIQeKohHFMpYxM
         xsqiSiGSappnAvngqr0ft4gFAuyg5uPnGIly7ZhCQ/rbbARDuhySV4TGckYjmGMY2BEO
         7UsI72McNXH7aDLc18ImLdqRR3smxXRthsZniTcqcpYxXzPUxdPc+cYS6QUMo0dhOrj9
         xOb3BQI5AmsGGnGA3yyDfeFmFpGy7cgJbOYUs8mONEfRmHgb+kRwwAEdDSbNpyXNgOH3
         eTxmuOxVGf2ZG2Ch+bijMLfYCnm6I9ew178/wFn7HJla6dt4Sr592gLUrkmQNI/00Y7U
         oG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422600; x=1781027400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkXupQZv2n7CPQXQp8Ed5AJ80vuEq4N2QBtHfZYmiU8=;
        b=B0V0K7pk7sQNaYdN2g7XDzZrQzNmBVY/OteKmr3hcK6ESR9bqvdhAlxJ3bGYAYo4By
         g8OptsTWSrNL50OEPKLoURs47107yxxFHGTtQ8cq7rolVf3Be0OJR2Sb0uvAeWVnbUUk
         afwqf1HoZe9gBLq1NlhU6MWFplsgVcd5GY4fk8ZNJ4pVosWK6IU57SEzaJdJnF10PeyA
         CaVs75KfbnEv75Zk2MSlYaVC7KiG85gR1Ke91uNx5DN5kVI4b96vwk3p8AsED68upu0H
         /WQo6LOk0cPcEMBR1UklYwmVDqBJoW7f6HU5ZQLyqqmzfzq2FOVXRSTNbv13S2go2eTX
         T0CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6UWnVQKEKNSHakDyr4jiZVdAR7HV8pICHKZA9Hq3rEzxX1+p3MCSJ2BJRCeN0wE6EgHppmq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Kbhd7jJ+SeU2PNYDiB7/AU5WAnb5ZWfyTxAJRE1QCGHvPTbd
	PrwH+0Am033Q6x9VNPSQ8+bpZbaewTg8dMrH1Tw3+sZKjBKC7kMnmivy
X-Gm-Gg: Acq92OEnIEHgLh0YIzjrJ02jb6enIt1g7lUT5HhuCc+kbw6gfvc8Fmxnap8tf+ejLY5
	MT7/Qe95IHh05kb8FEzqoTTJiQ/tVLp9qnLjl9ct6piH00jpCxS2wKEesMnRoWp35loKuogsrwV
	KIWgP/cB/o4+zNh+g4sFgp3IKqYMOq5vHApSxDUEKUaIG84zPCcfwTm7EayMT/6rujmZnQWbgav
	FQOEQ+J4IyqIbSBInxjMqxy8zK3aenVnZsOyElLQCk0sOIG3iSLjoRtKuFe1VOgFN3USQxfrDMh
	KBSGg7dlNXiMSINlUTWfUSvtRD5WeOycSeEhjTbp8dQT0V9p5nu66yCedvAwtsckAifvH853iP6
	GEwKE46D4L5fBIypkLncKOreylgeqYDPTam6w8EdiMIoYVCdX8ernspJ+ey5I/6gVHICGVArbnq
	d50SByo5G3/KOjs6QhWMJNhfykx08udK0iwqsgsw==
X-Received: by 2002:a17:903:390c:b0:2c0:c625:4001 with SMTP id d9443c01a7336-2c0c6254226mr132537235ad.39.1780422599949;
        Tue, 02 Jun 2026 10:49:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:11::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c26bcesm140044455ad.65.2026.06.02.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:49:59 -0700 (PDT)
Date: Tue, 2 Jun 2026 10:49:49 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	stfomichev@gmail.com, kuba@kernel.org, kernel-team@meta.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: bnxt_en: suspicious RCU usage in bnxt_fw_reset_task() qdisc path
 in 7.1-rc6
Message-ID: <ah8XMZs42IWAJEwU@devvm7509.cco0.facebook.com>
References: <ah726OtFX-Qw3U-R@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ah726OtFX-Qw3U-R@gmail.com>

On 06/02, Breno Leitao wrote:
> I am hitting a "suspicious RCU usage" lockdep splat from bnxt_en
> during a firmware reset on v7.1-rc6 (e43ffb69e043) with PROVE_RCU
> and PROVE_LOCKING enabled.
> 
> The firmware reset path re-opens the device from bnxt_fw_reset_task()
> holding only the netdev instance lock (&dev->lock).  bnxt_open() ->
> __bnxt_open_nic() -> bnxt_set_real_num_queues() ->
> netif_set_real_num_tx_queues() then walks the qdisc tree in
> dev_qdisc_change_real_num_tx(), which still dereferences dev->qdisc
> with rtnl_dereference() and therefore expects rtnl_lock to be held:
> 
>   void dev_qdisc_change_real_num_tx(struct net_device *dev,
>                                     unsigned int new_real_tx)
>   {
>         struct Qdisc *qdisc = rtnl_dereference(dev->qdisc);
>         ...
>   }
> 
> Since only the instance lock is held in this path, lockdep complains.
> 
> Splat
> -----
> 
>   =============================
>   WARNING: suspicious RCU usage
>   7.1.0 #1 Tainted: G            E
>   -----------------------------
>   net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected() usage!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   3 locks held by kworker/u208:1/13:
>    #0: ((wq_completion)bnxt_pf_wq){+.+.}-{0:0}, at: process_scheduled_works+0x8f7/0x13b0
>    #1: ((work_completion)(&(&bp->fw_reset_task)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x917/0x13b0
>    #2: (&dev->lock){+.+.}-{4:4}, at: bnxt_fw_reset_task+0x7ed/0x1e80
>   stack backtrace:
>   CPU: 38 UID: 0 PID: 13 Comm: kworker/u208:1 Tainted: G            E
>   Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1, BIOS Y3DL405 11/21/2025
>   Workqueue: bnxt_pf_wq bnxt_fw_reset_task
>    <TASK>
>    dump_stack_lvl+0x69/0xa0
>    lockdep_rcu_suspicious+0x13f/0x1d0
>    dev_qdisc_change_real_num_tx+0x54/0xe0
>    netif_set_real_num_tx_queues+0x4ed/0xa80
>    __bnxt_open_nic+0x9cb/0x3490
>    ? bnxt_hwrm_if_change+0x4fd/0x620
>    bnxt_open+0x1cb/0x370
>    bnxt_fw_reset_task+0x80d/0x1e80
>    process_scheduled_works+0x9c1/0x13b0
>    worker_thread+0x90d/0xd20
>    kthread+0x320/0x3f0
>    ret_from_fork+0x2b6/0xb00
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
> 
> Bisect / analysis
> -----------------
> 
> This looks like a regression from:
> 
>   850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
>                   bnxt_open() path"")
> 
> That revert dropped rtnl_lock() from the bnxt_open() paths and left
> bnxt_fw_reset_task() holding only the instance lock around bnxt_open().
> 
> I can send a patch restoring rtnl_lock() around the bnxt_open() call in
> bnxt_fw_reset_task() (re-taking rtnl before the instance lock, matching the
> pre-revert code), but I wanted to report it first to make sure I am in the
> right direction.
>
> Please let me know how you would like to proceed.

I hope (but need to verify) that at this point most of the paths that assign
qdisc are under ops lock as well. So the alternative might be to use
netdev_ops_lock_dereference from Jakub's recent
https://lore.kernel.org/netdev/20260528231637.251822-1-kuba@kernel.org/t/#m3de56e1d53f86b2c1b12ca29d1617dd6635e78cb
