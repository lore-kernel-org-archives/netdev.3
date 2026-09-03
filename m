Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AE46EF61
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435384; cv=none; b=DqE0zoHF1Qh4woOKTEaN+UdsadHAaT6HZs171KYDHk3DY+scUhsEf8CGCTBmR2kvRMXtRz00wn+G3e4DXpJ++nSzrw2W4Z1FM0YovwFigLNp7h85PLuLdUuyaUTijSHzDIMTBxDujWaPTT9ayR7TLzR25KAQs5QK3Qlh2+ooMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435384; c=relaxed/simple;
	bh=LJpMKj/XnEihoZ0YF7ai7Quioco7albx4xNT6cV563k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=owK8AYhO/48MVgs1E75+yjhs952w+FQNuThqWHnKnlPqmdLANU6Wgq+AtL8wLwvqmHsKqpfi32LfnfWkIco5qrY1EzyKnqZ6B9yJqpn+owB3YUdvvQD2fzQ8pYhlOd6N8XHYl+swe2tlsgul7gciIt2DsTmNVSFfTk37tUAzlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so4785815e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 04:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788435373; x=1789040173;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWw0DEZCWb3L47F1PExZyGmmWa6+/YdXupfpB49QAn4=;
        b=EO6UiYjdrAwvX9yyx1qOahsRr2kzVUqG66K1uM4pHELdwsyCntGT0in2cDyK425SVf
         pyGWOVzePktcBr97f0Ta2GocNZldoI/ATUcz73HjepNOm/hcbpEeEiNLIM4Jg5OJ1F8A
         36x/l7oD3UaWyqu4ev5YD/psZGy2tJ6zviSQJ6eSOgZL+TObNviOGfdh0XYAQdgQhZBJ
         xoJYTHygSQbUz5+IHfZ/inSfe/M3z/CrsvflkOJnroG47sybub6t3LlFbW6DXf+lGn8K
         A34Svkvl13NpXGIBom9grXGCc+WHkWvkAfGb6gXOYVEB1KwncpQAtuvIW4wz1leYz/AC
         2lsw==
X-Forwarded-Encrypted: i=1; AKwUvBybh1qMYM4XoagnADwEP/bEqXRzKWDECP7qVSp1RpJJffB1JRnDloQEZkmU+ixfTjZRNWe9afI=@vger.kernel.org
X-Gm-Message-State: AFuF++nUUCvICJm6dT7x5ZVkwksP6xdrU8v0OxgJQrTo3SdyQlldJZUp
	QMDfkQEEEJP8nMuCO9JThHkJ+ayPsCeWhrK65ymnF08tasHIby4LVUdf
X-Gm-Gg: AYBFou2eKxj7O2CPGV83uwosyl0basAbIgJn9GbyYB7ZphFXDSO3tw0rrxt6FDXhZFB
	Qk8GgputLefR6BE5kmjP7tXu9W9afjC8PNXDJYIfmKBR0JwCkJyxcjwIBrX380kifHjYQBSrMpm
	oNi5E7aNO+dH2hxnSwbswsMSI9+XUyVgALMq7x7cngpnAEkQTvGMeaIElD/w1VudrKAfGq35PJ9
	mmwv1xjzm1Scgegqq5wzfLgub3zaaW+iPPvrFZqXGJoJ3HPUDCbJGYOQ5ysi89sObnxdeB5N/tF
	NZxpdSVuAwDHKlwmn5M2vqruj7GUnOw5v+1QEg6SSjDCX5oFeGXdzuNL3WLSwZTqcHSUvKrQhtW
	GYuWaSUG21XGJALGNJDYiBnlbxD/26jdlfMuTtUlEnEnjeQKbpR6UwK395cu4PbsTq90IJySsh5
	SBVAPrM50y2+K75LPYxp1oN9LvqweofoPqsmMJQj7OplAxHCuIcj2UfG0k1+ucGL9m0Q4VBv76I
	epsvvdvdGLaRw==
X-Received: by 2002:a05:600c:a402:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cee22422dmr100668035e9.9.1788435372633;
        Thu, 03 Sep 2026 04:36:12 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d5d12sm63346745e9.5.2026.09.03.04.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 04:36:12 -0700 (PDT)
Message-ID: <866d33bf-cb36-4900-a05f-481c4ec6043b@ovn.org>
Date: Thu, 3 Sep 2026 13:36:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [openvswitch?] INFO: task hung in ovs_dp_masks_rebalance
 (8)
To: syzbot <syzbot+75ce0a9129024fa8cbf6@syzkaller.appspotmail.com>,
 aconole@redhat.com, davem@davemloft.net, dev@openvswitch.org,
 echaudro@redhat.com, edumazet@google.com, horms@kernel.org,
 i.maximets@ovn.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <6a97d3aa.e163c37b.143a1.0007.GAE@google.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <6a97d3aa.e163c37b.143a1.0007.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 9:43 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a23cbb05744b Merge tag 'timers-urgent-2026-08-30' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1107a379580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
> dashboard link: https://syzkaller.appspot.com/bug?extid=75ce0a9129024fa8cbf6
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eed599d932fb/disk-a23cbb05.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/74e8c268c325/vmlinux-a23cbb05.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/aa91aebf1baf/bzImage-a23cbb05.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+75ce0a9129024fa8cbf6@syzkaller.appspotmail.com
> 
> INFO: task kworker/0:0:9 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:0     state:D stack:22128 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00080000
> Workqueue: events ovs_dp_masks_rebalance
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5520 [inline]
>  __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
>  __schedule_loop kernel/sched/core.c:7347 [inline]
>  schedule+0x164/0x2b0 kernel/sched/core.c:7362
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
>  __mutex_lock_common kernel/locking/mutex.c:726 [inline]
>  __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
>  ovs_lock net/openvswitch/datapath.c:108 [inline]
>  ovs_dp_masks_rebalance+0x2f/0xe0 net/openvswitch/datapath.c:2602
>  process_one_work kernel/workqueue.c:3387 [inline]
>  process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
>  kthread+0x38b/0x480 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> INFO: task kworker/u8:1:13 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u8:1    state:D stack:22376 pid:13    tgid:13    ppid:2      task_flags:0x4208060 flags:0x00080000
> Workqueue: ipv6_addrconf addrconf_verify_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5520 [inline]
>  __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
>  __schedule_loop kernel/sched/core.c:7347 [inline]
>  schedule+0x164/0x2b0 kernel/sched/core.c:7362
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
>  __mutex_lock_common kernel/locking/mutex.c:726 [inline]
>  __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
>  rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
>  addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4770
>  process_one_work kernel/workqueue.c:3387 [inline]
>  process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
>  kthread+0x38b/0x480 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> INFO: task kworker/u8:2:27 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u8:2    state:D stack:23808 pid:27    tgid:27    ppid:2      task_flags:0x4208060 flags:0x00080000
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5520 [inline]
>  __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
>  __schedule_loop kernel/sched/core.c:7347 [inline]
>  schedule+0x164/0x2b0 kernel/sched/core.c:7362
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
>  __mutex_lock_common kernel/locking/mutex.c:726 [inline]
>  __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
>  ops_exit_rtnl_list net/core/net_namespace.c:173 [inline]
>  ops_undo_list+0x28e/0x8d0 net/core/net_namespace.c:249
>  cleanup_net+0x572/0x810 net/core/net_namespace.c:706
>  process_one_work kernel/workqueue.c:3387 [inline]
>  process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
>  kthread+0x38b/0x480 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> INFO: task kworker/1:1:31 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:1     state:D stack:22232 pid:31    tgid:31    ppid:2      task_flags:0x4208060 flags:0x00080000
> Workqueue: events ovs_dp_masks_rebalance
While this report points to ovs_dp_masks_rebalance, it seems like this job
is just a victim of something else getting stuck in the system.  My guess
is that something is holding rtnl blocking one of the OVS operations that
is also holding ovs_mutex and blcoks the rebalancing job from taking it.
But there is no enough information in this report to say what is actually
happening.  We'd need stack traces from all cores.

In the meantime, the patch I posted yesterday would actually reduce the
chance for ovs_dp_masks_rebalance to be flagged as a victim here, so maybe
we'll learn more in future reports:
  https://lore.kernel.org/r/20260902203200.1416026-1-i.maximets@ovn.org

Best regards, Ilya Maximets.
