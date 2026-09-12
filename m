Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA936A36A
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789207051; cv=none; b=ExzN6uzuDUsLAXm05yiIP10svR7tfwmb1AtSVbXvVUaq19AYobkWhh+nOZ5JCajf0f/uLYBRN+23aVDEkY0Pl4QBrU2GhDohm8vqMZFasS8vYTx0/qRz9s0G1Ii0jd7ZBX9WGNKUEliDst/2QYQxI8r8UlhQmUmR4HoItCCfIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789207051; c=relaxed/simple;
	bh=NcL2t4U0J67ladaMFpTFwW8J5ilpYMEUMS0EnRZHJH8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iIx8g2U2WtHHBETRomenAhxfqR19uz0DNbFsaWi1MQikXOYuS9SMmTfiMun13YPgYAbXOMf87aBsDVYYRsEZ13RIOvKwZL0PW0g2rhJ7cT15s6ldZydDpMYl3qXWoBfhvNj5Qb89BArqt/K18pMYftTUXvZo7Pld6Q28htJUD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6aafac56856so658802eaf.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 02:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789207048; x=1789811848;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr7k9fPnPXJBD2pXtyqUMHoj0Mm8KCdYxV9N6i9J7sQ=;
        b=WKcoby0YYERo8gUl/UFwrhrH0D+L0AvHh755/kuFRfL9RODc+rGQjFHz8XSkSRwYFe
         rw5VqC+14OZ68uE+Hx4aOVCNgnBaZQvvA32OTuxtcvg3Wa0nlHHoiuqZLOnU0qVYgdFO
         B7VlZaYnz0xOeTefh2aw62lKt2K0KhnO/6BLe9MiZEwcG3TFNYbiamSVN36wh9OIFJ1/
         5IPpQZUfTOuPCW+vV2ZddXhPIipQuN2LLhPzERF9UUnDo1j85ZyZrpols7Ouam3WABAj
         M65wq6COYg67b5LOzz3GJPDF3rNFATwl14QPu/nn+BwAgBwW+XCjaBHmxOf4wnd4kV0Y
         9qxA==
X-Forwarded-Encrypted: i=1; AKwUvBzwePjxQj4XQOiZDHm1gX3q5cdXqTGb1zRNOJQUGX3hRm8r4fyqeRAqamm51tfAhZy4vP8mOio=@vger.kernel.org
X-Gm-Message-State: AFuF++kz/uzTmN3G5XYkGDs2gX+Mqc9Rp2ZRrKNVyezf0dvPUMpU2zPT
	CnV6bwsZOuoNGXFTKXLPApGI62OkT5xkBsMoRoIhxLTa9f7p/00xcxTP6xDT/rtdArwKTqnwLB2
	aUbpsy8vG6PDai8asQ4Qo9wqpV1I6NEj4HuKTegzCQvxzfF0G6XkKX1XwYMQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:5615:b0:6b1:61b8:7ed5 with SMTP id
 006d021491bc7-6c0b9e5071bmr7319025eaf.1.1789207048508; Sat, 12 Sep 2026
 02:57:28 -0700 (PDT)
Date: Sat, 12 Sep 2026 02:57:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa52208.f81106d8.2ab401.002a.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in ieee80211_register_hw (8)
From: syzbot <syzbot+c92af8613ad38696ff09@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6f157f39d181 Merge branch 'remove-comma-after-sentinel-ent..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104ae601580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba53f227359c9d59
dashboard link: https://syzkaller.appspot.com/bug?extid=c92af8613ad38696ff09
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101bf105580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f30b26c34a47/disk-6f157f39.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46a0f6146076/vmlinux-6f157f39.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b4fc3fe5ab8/bzImage-6f157f39.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c92af8613ad38696ff09@syzkaller.appspotmail.com

INFO: task syz-executor:5765 blocked for more than 158 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22416 pid:5765  tgid:5765  ppid:5759   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 ieee80211_register_hw+0x3881/0x4a50 net/mac80211/main.c:1560
 mac80211_hwsim_new_radio+0x3258/0x56b0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:6138
 hwsim_new_radio_nl+0xd8b/0xf90 drivers/net/wireless/virtual/mac80211_hwsim_main.c:6957
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
