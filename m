Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9C30C158
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185247; cv=pass; b=gAgbIBfC8hcjEosX1g5rGOj4Pjkg9aHfwTmJJUImpE5ObRoUQU1W92i5qo9tHwSeLtmc5eBhE8R95rlJeM9SO414itioHCZD4FIhELkEOZwO1P86xCG7J6omRSMR86x9JArwthc/ayhh+vIGqZEVEXMd2+aF5SYMz7SmYyRdpSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185247; c=relaxed/simple;
	bh=8/nhIiPW6L/LIG/3NLUdBz9uVpdEilvbDxKPKdDSaR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW32RmM9AvXNG8Mb/A/N7pcksfvw0k8xYxkqQhWwTNsz+7XGGfogKkaOO8NmSdukA6SNxX3ZBlheDXBBFGWDk4DoxO9MUPpIu1CzcIUTHO2BvzYfSixWATyeivRJEQRni3K1c/HUtuXJgx/8bTcHdgg6vVCCMRcGu+725DJbQJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5tjLrah; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5tjLrah"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5176096116fso87978971cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781185245; cv=none;
        d=google.com; s=arc-20240605;
        b=MbO3mizVNvaC5E6R6AyNSoDPDLpL7OtIYQ0T+6l4j8OxK1aw9UTp3mWATTgciwII3d
         RkQW3nmaR7lZhg5bHTJhQ3P4PUcSyjkqYOaUkafL5HlE4wL0ZlUH5xk1kvyltzorvuyH
         xhv3QAAH+WlVKeGCLzNZQxM9uhVBs5RDnQf9h//+84EWm4CDq+UrcCFTCcdVQnG9GdUD
         qXKNVW98rN90ZhVpKBYFNB48odrGC0hJkRECmdX9+0qfdO9Ts06qcfIXETrRSI7+aSY1
         fPHUwtg189Phwbqr2vQueF0ojurw0BE05/9MTh7ro2SfaN8hFFdyTbtg2Fv8Zv7MwSP7
         mO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cqtg2xqdiaa0WZHMk+DQoKDtNgEP1pNocs3pK0ENJpY=;
        fh=ItALUqYFjFCLSoq8Dt7XfuWuNv2ZIyOXl9gKFLiIyUM=;
        b=FCgNrgAGtGPaM4OzhSnG7mjoGou6LSZpi+fGQ3fl8tXNLq9/S3mjhM+2s8eQnWhGlb
         H/TicMjRNSxKu+L57C/Q/js9rhjmln/MiXqxDPAsb2sWu/3936S0YJTTl3S8roWjmmLH
         Q5fTCyfWwqycqBaTVjRBaLbyJDaiILxn4kWdXAq4x3S7WrCkq1Ax3WWnFeN9A4HyHRZD
         JI4uq7ZG52NQCXBAL+ZGx1k36xiW4yfg6ri6Iuz8TQJIOTbbyIx7Bx+eZr5aRJug5S/9
         MCK+GXta6ozrNKds1KJteI3C1ZJ/ebgIZ8qFLdy1gsK2qLy85G0eBxTOo5b4Oe333FV2
         MHNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781185245; x=1781790045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqtg2xqdiaa0WZHMk+DQoKDtNgEP1pNocs3pK0ENJpY=;
        b=R5tjLrahrtVn6oluUgyAaSuxubtiRF5PM5KHNmlKpiFTU4qgIXMbl0o/2hVE0efZQI
         oiOlrPO/tf+oEtqovR/Fs32HDpFRwwRAXrbtyH5DN3KN0VrEHR+mJkBXFEfAsDKgG9IR
         EQpgDgeqpaIjlf/PBnOTGNNSK8Nd7dz419wxL6qMba2o5HBkDTLVdfs18VnEQcfoTbCI
         Zu5x583FRYPbSNZx9PWvDmhcp1WUwn67zPwOpLd6OfURFiKXpaGw1lnWIc96nZc32TvD
         6EHTGsl0OS3BmnxhFTWTpoFJAyu8ovnfPCdePzHnirJmGurWfMpelV/h77pgitk0H6sf
         v8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781185245; x=1781790045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cqtg2xqdiaa0WZHMk+DQoKDtNgEP1pNocs3pK0ENJpY=;
        b=ZkW/y99g8vJFkR9H86OTMLimUkvjCbuQnZMasiiy0Pb25wrsE5BvpGezSZ949mTVcr
         hnrlApnaTyQqUcAM9arb65BmXzzToB7Dq779925M6KyQaZ05K6qB9X8NAUf/jw8tuGVv
         66RHYcQnzDY/k1yFg9J4AmT/MaD25o2571f1v8tf9jvLQIilabzd4R5x+bVxQH5Z+Csw
         +9fYmi6pbTswY9/2Eqp+DoEOqzYTXmVOJhriBd6TvOfKXUv2pqpdyftKxSI9V/4tV6W6
         Dv/203mlaKPQCyWpu1nIPSnhiHY9XGP0lubGHtg14jIlNWR64oL9rQ3VA6cS5bNIxjzE
         W4Jg==
X-Forwarded-Encrypted: i=1; AFNElJ8ez2yuVwKqy2TALHs8p7cURupIXkWHM8PIVS16ggi1h9MQkEpqhyIcCUmIA+ZyDzJfUsdy84E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvrkA7A6zxzD8xdnQEUSG0bZVTp9EfHsD2DMmj8oOWNk2uI3T
	7b/LZQEoGEQysUayxH6EC44uNupcOoeL92l9emljvwq3jEjp8+vIIXibpAEHnyeUIUub53WuwyW
	119qHRUfHsKpyPKFl3LtUDCyj7Lyu2nLvN6RUX8E0
X-Gm-Gg: Acq92OEAMB6TTVO93prKpxucFEpSQcFJKwjfWsr9cWwEQ+lpEahcu6gN4N3TkJ5W6Vo
	06J1YmWpKtsDqKAfjPfMbxv3LsbszN+yH53CiVHd+ynCvahLw6oXj9illdcu0W4Ik0oAJ+QgcgK
	fAKbDuHZYQGnaOdjV8pCbT12GIqAQU+/XuJn9pAXnj+w8UKVnsIbDIt8z0hs7mC1XxhRIE+tRBW
	KEwzriy1Y3tDKViLC1Emmc1lGbErRr5dTbx9wb0BaM0HPdDTEbFMdvd3atPB0sxasbdEIPeqWRh
	FQQ9gJnk+wv/pvdZCgSZ9hDkQVuC+SPmjFByCA/gDwEyUuG1SVEreOZHBr/BefvxDcy19MWyHq+
	q4GM3u5jRZgZOCeoEaNkuTQE3neOmDg==
X-Received: by 2002:a05:622a:2592:b0:517:89d0:b8a9 with SMTP id
 d75a77b69052e-517edcca0b8mr46262981cf.9.1781185244564; Thu, 11 Jun 2026
 06:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609161305.3186102-1-edumazet@google.com>
In-Reply-To: <20260609161305.3186102-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 06:40:33 -0700
X-Gm-Features: AVVi8CcnBSjeqs0s9mQiKImvKXKuL9WHoh6zmnPVJyFxkYNo-xqMKR6BiKd7arM
Message-ID: <CANn89i+Ou5w706HALEBmNtzOS7PujNyTeXu066Fi-9Fu7Q0m=g@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: watchdog: fix refcount tracking races
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com, 
	syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 9:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Blamed commit converted the untracked dev_hold()/dev_put() calls
> in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
> (which were later renamed/interfaced to netdev_hold() and netdev_put()).
>
> By introducing dev->watchdog_dev_tracker to store the
> reference tracking information without adding synchronization
> between netdev_watchdog_up() and dev_watchdog(), it enabled the
> race condition where this pointer could be overwritten or freed
> concurrently, leading to the list corruption crash syzbot reported:
>
> list_del corruption, ffff888114a18c00->next is NULL
>  kernel BUG at lib/list_debug.c:52 !
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 91 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT=
(lazy)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/09/2026
> Workqueue: events_unbound linkwatch_event
>  RIP: 0010:__list_del_entry_valid_or_report.cold+0x22/0x2a lib/list_debug=
.c:52
> Call Trace:
>  <TASK>
>   __list_del_entry_valid include/linux/list.h:132 [inline]
>   __list_del_entry include/linux/list.h:246 [inline]
>   list_move_tail include/linux/list.h:341 [inline]
>   ref_tracker_free+0x1a7/0x6c0 lib/ref_tracker.c:329
>   netdev_tracker_free include/linux/netdevice.h:4491 [inline]
>   netdev_put include/linux/netdevice.h:4508 [inline]
>   netdev_put include/linux/netdevice.h:4504 [inline]
>   netdev_watchdog_down net/sched/sch_generic.c:600 [inline]
>   dev_deactivate_many+0x28c/0xfe0 net/sched/sch_generic.c:1363
>   dev_deactivate+0x109/0x1d0 net/sched/sch_generic.c:1397
>   linkwatch_do_dev net/core/link_watch.c:184 [inline]
>   linkwatch_do_dev+0xd3/0x120 net/core/link_watch.c:166
>   __linkwatch_run_queue+0x3a5/0x810 net/core/link_watch.c:240
>   linkwatch_event+0x8f/0xc0 net/core/link_watch.c:314
>   process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
>   process_scheduled_works kernel/workqueue.c:3397 [inline]
>   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
>   kthread+0x370/0x450 kernel/kthread.c:436
>   ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245


It seems sashiko found issues, I will have to use a dedicated lock,
and a separate boolean.

pw-bot: cr
