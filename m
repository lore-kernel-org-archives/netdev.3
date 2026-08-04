Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D53F6C50
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854033; cv=none; b=k2ShC/qG1eH7s6kxPMOZL3hroVI6uymDEZIyrslaDRoXPo5++FlOz1M161kYG36Qz9/zC+YaDaoazTcwgS8Tho+N8GL62W0yW8icDFJJOrtVJTke0EJeWcusJ+r6OXotSp/KjzjEFY5lLC4Es5niV6yDp/h5OKlGYDiJAbqi5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854033; c=relaxed/simple;
	bh=q6nFZ1R6gzXut+K/+tnOlHI88I/nj/Df9nXi6+JJ8e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8Kv5CKDxU2cLjZoZ+VuV1TunUMyEAViX7Lqpa8NzLjqrrvL9Hltgb4MNo6HOdBmXNBBJsKYElIoxPIl7VDbVysp9ib6WNMyfdoiaTYKI4w5Fw61ClGHt9jqaNJlyyRZip9RXGEuiMo51zsIni+BU9z3F1ky7HDFTpq98SRVTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwBcZbFY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qiNhL1md; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwBcZbFY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qiNhL1md"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785854019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMR8kYlXa1CTxfv23QQO2kULReZbJe35SSbkC/BppCQ=;
	b=EwBcZbFYgasCAGTHT/cc9l4bWy5p3iU8fM8GH73UOwcpgJU+90e4t4leMCTLhaICoUoCkY
	/MMy5NNQiJqFYce39Q1zD3aHvvSlQ9VU++ulcSY3xpM1Vj5q86ccxnOlJgA1bHYEI6bWWl
	OhqWHPTiVFU/BRIoQj0YBg6JRfegpmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Hg_97tsQOhuGU4ZaPept0g-1; Tue, 04 Aug 2026 10:33:38 -0400
X-MC-Unique: Hg_97tsQOhuGU4ZaPept0g-1
X-Mimecast-MFC-AGG-ID: Hg_97tsQOhuGU4ZaPept0g_1785854017
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496b61bd846so27881115e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785854017; x=1786458817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sMR8kYlXa1CTxfv23QQO2kULReZbJe35SSbkC/BppCQ=;
        b=qiNhL1mdYWBpSxiSJo2PiVO2pjTqdQhqUZalBMspe76dltCOwROb6m7b4bUJwBogL5
         7aNKrCbVolqtvBEsZ2Ei5eSQufZdNar3cJgO86B60+FJMp4B9UpfIGenrnI/oGD7fJ4z
         DPULb7WQlspQa6MSBxrDAHx5Iq8aCsoO0NoL+snyawI177uEDAwmMrFW3CmdomT3lxHv
         Jkjbwy4f3KnK7zBGj2pWwkQRzIIV8UPiT5e9GPtwrjKGFOm3MLkZS4C502Y2AgGvI8Dz
         1gNLWYr5pONySRcXqRmDYSEG+gXRwm1yFYDzNdEvI82o/qMgBqh2u312fnUnO8lDJhkF
         j70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854017; x=1786458817;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sMR8kYlXa1CTxfv23QQO2kULReZbJe35SSbkC/BppCQ=;
        b=T4AZicCrfSvCEBvNnSywEqjH66D+RGIM3TvMFr89q2AI+FrBK/Eih5vHclYHwQxO4c
         uRXweZG/SCh5So/Q3mThwoRhzfJcd2uqDxyeKv+x6rwYVmnSE8c6Fgf7CmsM4MGcXGFQ
         SDmUVrLBffZX08OJQUHrQodPicqFXJ2FORWQj1/bAK2kCQz0/sw4vCkTQTAEXJXpHLZA
         cErhj+lfMe371JN0tyybynN2WEitdLxeOdhhzHHKiyKxn0nZUZVHq0pQllQVR623s4/Q
         +nGRtMMCOHUgClt9e1LhT6E07Ca+FyKW0CucIp2Z2bJEUGvRWm6Ej5oPfsk7Rk7WiLZh
         XnLg==
X-Forwarded-Encrypted: i=1; AHgh+RpR6VkRzeUDL27YvXSo0u8jJIsnNvzkWD9x0c/1mgVpHLkkgsh7we7N8x8tT2mB26e9bJT6/pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbfj43xYBr/RC55pIbG2RXZcStWF7GX7wMZK7rqbXZn5tzYMF
	UqElAQfoqEJF4GmNj6Kb+FmtZrMPdGU9nwdA6qLPunfJo4c+bXXI9P/Rh6ggihSeiHPcSSLroho
	8syo2C0SQZXwLVM2C8CnEPSCyghYNYdQJjfiYL3sCaSa9FLKAbA45aGxO5VA9h4CMJA==
X-Gm-Gg: AR+sD13tT/Y9MlLO//ak5U7JtOYKGVyvzsJD3yBYeTmHy9gqAW2d0Q21oLHB2ABfV2+
	PrZ26Cf7mFXXIl6nbdmsGiUr7fGzx1ru685455RK+znVtOwThyqGJk+OvLQB54J6GEpAcEWzaql
	stCkYwXh4qfXYCBbBQ696DWRWKZGAdrNR5j8tBevlvW8wC4yE8RowWWbE5EpOLu7xkuxrQMbhRP
	iLWeJzGehtZZ/lW0THCceviNIImb426s+V2oTEfc68l9jODUmqTZ/MRUnGUQbCwrTD+RJIzG4tQ
	DKWXGG4OqG7ELQh+v/q4oWhRg9vKwtpbSxVOkK8J6qrV2HMibZx1gn5S7JKoal6jvGJR0/+QdbE
	pscOc3I9EYT39IABuIxtCNYTN/Hkz586Xc8IquV3X46m5fviFMLWX/OaN1C9eMx6aSGuVIDUS1u
	o=
X-Received: by 2002:a05:600c:5395:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4980c66c751mr434202875e9.4.1785854016751;
        Tue, 04 Aug 2026 07:33:36 -0700 (PDT)
X-Received: by 2002:a05:600c:5395:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4980c66c751mr434201535e9.4.1785854016281;
        Tue, 04 Aug 2026 07:33:36 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a100e14sm91151965e9.14.2026.08.04.07.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 07:33:35 -0700 (PDT)
Message-ID: <c74a0579-dc37-4f3b-8dba-8380223b361c@redhat.com>
Date: Tue, 4 Aug 2026 16:33:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdevsim: fix deadlock in nsim_bus_dev_max_vfs_write()
To: syzbot <syzbot@kernel.org>, syzkaller-bugs@googlegroups.com,
 Slawomir Stepien <sst@poczta.fm>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
References: <b7bf56ea-7522-4163-acd5-aaa69ad03b3a@mail.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <b7bf56ea-7522-4163-acd5-aaa69ad03b3a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 11:55 AM, syzbot wrote:
> From: Slawomir Stepien <sst@poczta.fm>
> 
> There is an ABBA deadlock between the devlink instance lock and the debugfs
> active file reference mechanism.
> 
> When a device is being removed (e.g., via nsim_drv_remove()), the driver
> acquires the devlink instance lock and then calls
> debugfs_remove_recursive(). This function blocks waiting for all active
> file operations on the debugfs files to complete.
> 
> Concurrently, if a user writes to the "max_vfs" debugfs file, the VFS layer
> acquires an active reference to the file. The write handler,
> nsim_bus_dev_max_vfs_write(), then attempts to acquire the devlink instance
> lock, which is already held by the removal task.
> 
> This creates a circular dependency resulting in a deadlock:
> 
> INFO: task blocked for more than 143 seconds.
> Call Trace:
>  wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
>  __debugfs_file_removed fs/debugfs/inode.c:751 [inline]
>  remove_one+0x2df/0x3b0 fs/debugfs/inode.c:758
>  __simple_recursive_removal+0x215/0x520 fs/libfs.c:623
>  debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:781
>  nsim_dev_debugfs_exit drivers/net/netdevsim/dev.c:372 [inline]
>  nsim_drv_remove+0xc0/0x170 drivers/net/netdevsim/dev.c:1803
> 
> INFO: task blocked for more than 143 seconds.
> Call Trace:
>  __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
>  nsim_bus_dev_max_vfs_write+0x229/0x3d0 drivers/net/netdevsim/dev.c:276
>  full_proxy_write+0x127/0x1f0 fs/debugfs/file.c:388
>  vfs_write+0x296/0xba0 fs/read_write.c:685
> 
> To fix this, use devl_trylock() in nsim_bus_dev_max_vfs_write() instead of
> devl_lock(). If the lock cannot be acquired, return -EBUSY. This aborts the
> write operation, releases the debugfs active file reference, and allows the
> pending debugfs_remove_recursive() to proceed.
> 
> Assisted-by: Gemini:gemini-3.5-flash Gemini:gemini-3.1-pro-preview syzbot
> Reported-by: syzbot+3147c5de186107ffc7a1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3147c5de186107ffc7a1
> Link: https://syzkaller.appspot.com/ai_job?id=fcdda182-bebf-49ab-ada0-d4d2e814ebf7
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> 
> ---
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index aed9ad5f1..421cd7327 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -273,7 +273,11 @@ static ssize_t nsim_bus_dev_max_vfs_write(struct file *file,
>  		return -ENOMEM;
>  
>  	nsim_dev = file->private_data;
> -	devl_lock(priv_to_devlink(nsim_dev));
> +	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
> +		ret = -EBUSY;

I think this should return restart_syscall(). This kind of schema is
calling for trouble, but for netdevsim should be okish.

/P

