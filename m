Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457957EDB7
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969883; cv=pass; b=B2884ZVbOmTF1+Jtm22BPFwzDOL1H90QfI+fOuI8YoVnSLaUfUbRtE5e4O/bgsHCdodg2C603Xfeixw7L8WqWhjV0Nm31Nj2yXMWPEkH1cEWnBFDFBlm95Y1H0lGqJV6FqIvJIsOVl8LuG736w05i96CkZo2YjALKWf7DTGdMfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969883; c=relaxed/simple;
	bh=nGn7Z3t4ZbhWTD8r/y6YkwRq4GQunXuzolHgLynNEiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIqD6iaBf+XO8f3ssBWVvrKSdnsdNeQbap2iNkL/JOOwwH7+uA59uWY6h2JdOUqTCQDEkHtct8VXZwTQN8YT+seZ7mkI3CtjbGBHbS1X6NQmkjvDDqOBM0YUkOGpUz3TE56a0pYhJS1I6l7/i0DxWSd3/rvHfTcoZg4JUu/Yyn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QulSSDW3; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QulSSDW3"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7fccba9c675so11711a34.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788969877; cv=none;
        d=google.com; s=arc-20260327;
        b=CU14RdsKg7QHlR0kDJRhObAxQLEjTqMrM5SFMspjQ1tCy0xY2H6fvhzk9PJV/0r2dW
         k0UfgsJfF2+bV6cKb5lVndpB0l5soCRm14Q6MULXdN1OwX6BCYQJtIz4n9c+xVD5ZvgV
         3wT2HeuDy5SlPp/qmUkAp88LS17sGGyIxwyjlQjqshiZ4Ftc3Yqck3Hf1gzuqY/t4SIq
         4fm2qMpQLJ4xKPV+0cZ5fTrYdGkFMRYtD0scFP5E5qxyof1JaCOTbycG+5QCYTmiRqYt
         qfAY5Z8KB8zxgW7eavlOKUxqxNy77/THScZcvrbRbFFwlA71VC7JNgkO5CRUjo3JuKME
         NBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pn35Zv80suBYT8EilnQ7EI/ZY6LMkIOpiVZoLSb4gFE=;
        fh=EeypelltzFumqLA5Zeb/YKFbVTkjcICc3/1LlYb4MBA=;
        b=tAv1CEk1jlnt4wuWoieKxBHoQNTrI5dsuCFly5JsnTecthYD6xN8Gnq7MMB6vBwMSS
         rIRUfjkCTEKfW8LLIWQIyBC8qIu9snF10nKAq/46iiTLeYZa6fhrmWLjlxZe6165OZse
         pES7tzEy3rATkuxq8oXb0FLVXELd55L/6Pl/6vFpOTYCYkUpKhCldW3zwsIS9aomSDxh
         xLjmEiXk1FIHef4VlxxNSuw8dOtiUTRn45kJVtqee5aYEdUcfZ92aW88ZH/mpvKMHPQJ
         kM3qnCiGpKBlCZ4DsJSL+5dSpBRbNTJGZIrfTJaxUJu/pe5qcfhV6a7qdH9yPerkK4IX
         wugw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788969876; x=1789574676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pn35Zv80suBYT8EilnQ7EI/ZY6LMkIOpiVZoLSb4gFE=;
        b=QulSSDW3owE7U2hDGkSdmGFueobrQ73U3xrlcUOwwtheC/npjl182qWlrTgD8H3c3x
         x50CO21c5iyDL7pmVuQIHsx3gws5cmFXvhsGVo06/7JUfzgG0uYJ4JBGrclXH9aYnSf+
         Va+JFr5k1gEJSai9tUcXwLDNygTAgDRWrWWIxXl+XqzwAKjbeTvINfHkPL1QAMlOktAt
         fOyd8N1eOpWFcGNCyNPOpxFsCRboFl6FUIe1rrMzX+1imnAcoTdxDAgQ5R7QPbRaljWD
         jQ2/n3xEjTfHPbpEzhsUTwos/qrBA7V9sEnsmpWPJ+Fo1D252Lk05TRaED1LKiVZu0Zj
         M6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969876; x=1789574676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pn35Zv80suBYT8EilnQ7EI/ZY6LMkIOpiVZoLSb4gFE=;
        b=aW7KXzRb8plQCXQWx6G6ltxzsO431K4BEUTl8O5MH8J5lQvvBxqJjhm5u3sYDH+VOZ
         mm4WYoL79ytyFeigA6np67bEp2C/+9bnQghvUTB08ybXP0lYF4WblMK+nhJPDVWL51SS
         hUUnl5A1Bt6a/iHSY7xUuFGJSHE2hqNHuAnmHlHBz2tzNc8CG1eRBL7Oj8RwfTPhgLG3
         P/nJ7K1bI1r3nF5YtyDavZda50cRbNNoHat58dJtlAa2XfadtEPId6hbf/hs8ktbXbdL
         t5mUvjMymzhtWa1UFq3xjcSjVCzHRxeSwAw5voilNNXwTbnNomiBIhyqHzHo2x1YH0Ko
         KaQw==
X-Forwarded-Encrypted: i=1; AKwUvBxP3F7gN9oDoKkLMG9KsVZPCQhXcYLS2krIK/pYl9opAYD14EsJB83B9YZ/vRMV5lofoB7VMVY=@vger.kernel.org
X-Gm-Message-State: AFuF++mZIe8droEy0XK5MrtU3J+ycVeYIm1OlZg/yvQ7Za6QJQF6vE/3
	xLax/jAmHP1a6/49OBNAcznspEzmzlxxzi5pe940juI12Lq1/sNmPzNeZNniOvAiTpn4eFO6eJM
	juqtaQ0gBoLcAuuJ6ai6ruIUd5OuZfqxylv4/hvE/VSq9ddLa2XfTnHfuNIA=
X-Gm-Gg: AYBFou04wmO9sa3BVV7ZmWwWHp0V6mAXLYG4uS+7+3HyzIO4k075/HzyMNm25CspedO
	P0HpIj1eZEYr0EHog3h3lLF0qE/iJIF+YTJQoiId/TW6gYpbuof287XIXoEOFncvBgpBJJugUHr
	Bal2VkgD+C2GcKJjO5W+SJv3wZVVvts1ukhyQaJNYpVWZn3RvG3HGsLUL4AZPmkJODxpAVe3O39
	9+/71nfovIwJ4da/BrrT+cp3NItGTAscEkjU03iYMeplgNZ/IlDFEDtaWlVTSLbH934heSeM/wC
	WmnK+F0TNwLhihUxQDmIXf7yy2vPvUI8wiWc+/mlZCn9Cl1XLqEL0zNqFp5saWJwFnlzWnCS9oY
	iB+QphSUR7A3Hrx3UxVOa+4W1XJQunWAVrLu7uymmCXpFXChKA26bx1jfgSDAy1WLKa8r3vZCAI
	hp0Vng8K0sCUjFnRJUpAA=
X-Received: by 2002:a05:6830:1303:b0:7f9:5a3:c243 with SMTP id
 46e09a7af769-7f905a3c495mr12608437a34.26.1788969875996; Wed, 09 Sep 2026
 09:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a73bd79.6851e1c7.236b5a.0003.GAE@google.com>
In-Reply-To: <6a73bd79.6851e1c7.236b5a.0003.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 9 Sep 2026 18:04:24 +0200
X-Gm-Features: AcwNN1WEL9mmmb28wbdDNKmhZqM-XxgrA8b0qFly8A6ocEiOqFliEfjU9BYITWo
Message-ID: <CANp29Y5x0qQVcw8TaZ=xCL-=kXoghCuXk9WxqjArVM4goNjWAQ@mail.gmail.com>
Subject: Re: [syzbot] [ath10k?] WARNING in ath10k_pci_probe
To: syzbot <syzbot+5c061dd050f2b84b2e1b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz invalid

See the discussion at
https://lore.kernel.org/all/6a88012e.dbb3a75c.13dd47.0007.GAE@google.com/T/

On Thu, Aug 6, 2026 at 12:47=E2=80=AFAM syzbot
<syzbot+5c061dd050f2b84b2e1b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.=
k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16cd13b958000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcb17729fb04b1=
e3a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5c061dd050f2b84=
b2e1b
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e25=
5-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15b24bb9580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1061acc658000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/375d27e96ecb/dis=
k-848acc8f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4ba19a656b9d/vmlinu=
x-848acc8f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7c2a17aaee7c/b=
zImage-848acc8f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5c061dd050f2b84b2e1b@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> 1
> WARNING: drivers/net/wireless/ath/ath10k/pci.c:3597 at ath10k_pci_probe+0=
x6e2/0x1c60 drivers/net/wireless/ath/ath10k/pci.c:3597, CPU#0: kworker/0:2/=
198
> Modules linked in:
> CPU: 0 UID: 0 PID: 198 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT=
_{RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/24/2026
> Workqueue: sync_wq local_pci_probe_callback
> RIP: 0010:ath10k_pci_probe+0x6e2/0x1c60 drivers/net/wireless/ath/ath10k/p=
ci.c:3597
> Code: 35 fb 45 85 ff 74 50 e8 dc 12 35 fb 48 8b 7c 24 18 48 c7 c6 80 2d 0=
7 8c 31 d2 44 89 f9 e8 26 a7 9c fa eb 7f e8 bf 12 35 fb 90 <0f> 0b 90 41 bf=
 a1 ff ff ff e9 7b 01 00 00 e8 ab 12 35 fb 4c 89 ef
> RSP: 0018:ffffc90003aa7980 EFLAGS: 00010293
> RAX: ffffffff8690c681 RBX: 00000000ffffffff RCX: ffff88802039dd00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90003aa7ab0 R08: ffff88802039dd00 R09: 0000000000000009
> R10: 0000000000000100 R11: 00000000000011ac R12: ffffffff8bcd1d44
> R13: ffffc90003aa7a40 R14: 1ffffffff179a3a8 R15: ffff888021ad8000
> FS:  0000000000000000(0000) GS:ffff888125c3e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000000 CR3: 000000003b198000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  local_pci_probe drivers/pci/pci-driver.c:332 [inline]
>  local_pci_probe_callback+0x120/0x1e0 drivers/pci/pci-driver.c:361
>  process_one_work kernel/workqueue.c:3322 [inline]
>  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/6a73bd79.6851e1c7.236b5a.0003.GAE%40google.com.
