Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3337CD59
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141260; cv=none; b=e1EueSWEMT92Us5zmqS6xMabyZFQx/dmGimEsRddg96tGGR3IGmkgVU94aJyzrX83HCVskmkjCXj+7LqH9TvkpyualVVVWE4UrOPZ1rcMumsUDRWio93BCpNKsdZ7BkX9YQ3pP4s0tV3v2xgqwMdBviN8DbiMEw3RLGqhKtrT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141260; c=relaxed/simple;
	bh=A1BSbcFq/o7twSIA61gFCNhCNIuZD3864SdBe5UB7Xc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FbEr7CqBVRKSmCbsTh23jr4mDkUf4aPvNbeOs+oqwf0VOlglZc5KSxxQD6hwMiXQJXlhl6IeHdsO9uy32sLPpGQpOXLjwGfWVuy/MFUl4ObJ0KKN/RaFDqE/sLv7C75aAbJQrvGWFgjzmdFp9VHtqiHHUoaNusBHnlxqggLc2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e9dee2f7b5so1465112a34.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 05:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787141257; x=1787746057;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBqP4hzWqlcD5XduxSoz3ubi2vBU150XG1dXZ14qzas=;
        b=gXR4wsOwQ+bxPDaxVIUsjcPeOPfzmDqEtmsyeZhyHyEzP+ZkNF9PC3ICL/SpsMFOOb
         K8qMCUbi4e/Vky2tSmk8dYSniF5co61q6LGCyQM+jc5VEmN0q55FtMzYH1tYTyy24lqT
         hE8hHYrTbHtGCR/09g9FP/yDmJgEzGtgdyRwdByVg6lHTuGQvWjBnMW+0wBAkgWrVHLQ
         nS2MsghSFnQCJSHr219qMSs07xnRy2KwTczoad/XhWMuwE04AQF/jf3Q3QN82atFwGjr
         uVjLgRJ5MuD7BpPl/TChW3N+VcoNjk02/Ve1WilpFcF2zrVsoM5N+6pvL+w0PZY7yIXG
         JBiA==
X-Forwarded-Encrypted: i=1; AHgh+RodGfE/WSj5WDwtfQ91fRKoIjW/qTjHJPFy5iBdkB3eWxTEBhF3HUF5RrJS3q7pw4t/z0FPRoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtqp+jcTM20bKpgYPWwPrAiEUWncvB8ouAophOcwXZXy4eqqpv
	orc+Xdcg81dvpvvZwuzvRBSQ08PNN7gaerucS2fW4m15/o6iF23TSmx8FHOvfd8DOkhVefHTfA1
	hx0aUWu3mungEO5yQxfDoyhYjAsq0z0mBIHhzX5EaB56UxQNYU6NqLB6B+wE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c91:b0:6aa:e854:d05d with SMTP id
 006d021491bc7-6b13c2d60ebmr2645032eaf.3.1787141257279; Wed, 19 Aug 2026
 05:07:37 -0700 (PDT)
Date: Wed, 19 Aug 2026 05:07:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a859c89.f7a79266.2f965f.003e.GAE@google.com>
Subject: [syzbot] [wireguard?] KCSAN: data-race in wg_packet_encrypt_worker / wg_packet_encrypt_worker
From: syzbot <syzbot+75273239c9ffd7dc304f@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f23d56f17fd Merge tag 'linux_kselftest-next-7.3-rc1' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c9b679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e688dbf432017c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=75273239c9ffd7dc304f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a243b05cdc37/disk-0f23d56f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3af864b2bf56/vmlinux-0f23d56f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c3f9cd19ac5/bzImage-0f23d56f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75273239c9ffd7dc304f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in wg_packet_encrypt_worker / wg_packet_encrypt_worker

read to 0xffff88811ac90080 of 4 bytes by task 3410 on cpu 0:
 wg_cpumask_choose_online drivers/net/wireguard/queueing.h:107 [inline]
 wg_queue_enqueue_per_peer_tx drivers/net/wireguard/queueing.h:183 [inline]
 wg_packet_encrypt_worker+0x9f5/0xe90 drivers/net/wireguard/send.c:305
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

write to 0xffff88811ac90080 of 4 bytes by task 15243 on cpu 1:
 wg_cpumask_choose_online drivers/net/wireguard/queueing.h:110 [inline]
 wg_queue_enqueue_per_peer_tx drivers/net/wireguard/queueing.h:183 [inline]
 wg_packet_encrypt_worker+0xcca/0xe90 drivers/net/wireguard/send.c:305
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

value changed: 0x00000002 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 15243 Comm: kworker/1:19 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: wg-crypt-wg0 wg_packet_encrypt_worker
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
