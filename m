Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5332ED43
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326101; cv=none; b=P3QmTMa3DWh5gn0Z1BIeSBHOMWC+eiF+Yd/IBxRMqEefdC+11A77ThANdw5l88vhyQ6vILAEABB7ThQc0uo6h+ptiFyRZYmrlZTp1IioXkbTm4y/RlYK3VlqtwF1qrF2eWC8+1EKII8g+FGnGnDvOf1aDns6Ka2IpUnhS/wtMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326101; c=relaxed/simple;
	bh=f9Sn65bMDeQFADkZz2X3ALt7rkOgQHXefFnV6ZTP2iU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rwomy34UXPKISVEvanewO2DfpV+7dNG6XpSCvXNVTzcdHc+kAih4f1ZyCfHWS7w8g5jGbv/RJLdiWBbzz48eM0kG6KPVdvlW8M/efyTO+bxwWVdeAtNi+CYfO/27eWvleFGoKfzgDJFbxMMdJAGzP+Kfyue4TlVVXbwVjKmBdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-40ef793e45eso9882077fac.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 03:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771326097; x=1771930897;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49KmW+xMN4yjOJq5KWsrgNTbzky5ua/zIOKn1y7eBTg=;
        b=sBjSBHPYqwXkhDed5li02lrHZF1/X04huTO/YMbM+ppy9BKtfPQZU6OHTUCWIgzObn
         OlyUmuM0byOELQ/qNfCWEGB35ot6mx5nJfcRbPa0oZTCAmUaDb6Vo7fjWQjmqgy6EWUZ
         i7R6WbVSgEZHO1nmYDanL3YwTrB4FvOjiQfTpxLmzc1OPJzogH8Q9dgnYc0RRyivm0fc
         ynm0OqNeXTJmUiLTdHMaWVICB8l+uqTElPuk3/emr172Mnxl1DORZoJg8XhwA4tX7EkA
         bgXgglwvc3RZvbEMUiVqMt3Lshu4CnzVyw0FUKilMzMoCR0rZKkfZNb/salQqa5IwHKy
         qTjA==
X-Forwarded-Encrypted: i=1; AJvYcCVH3j/y7fpdDiutoU9uv4IjjYjIUmuURx1KoODm2oStwGInbnChK5UiS+4ZPEoJOwYs898y9CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhdw2K7CrzkwStHTkBXvGudaDOvzoqJ/ByB7JV76y+qpPdL60k
	vmOFs5PeDsafTx4cX1ggQE2iqMYGm/H6NRoONuZl5dP4Z326p/zykTl9ih8za3wENM+8stOBll4
	CazSHEiY5CEHsOdyqIY5ciIBw7v3DgofAlb2zOrZC70q0MN5ZP/eepJ9EBgk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:180e:b0:663:a6e:49a1 with SMTP id
 006d021491bc7-67766ad5dfcmr5634892eaf.14.1771326097053; Tue, 17 Feb 2026
 03:01:37 -0800 (PST)
Date: Tue, 17 Feb 2026 03:01:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69944a91.a70a0220.2c38d7.00fc.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_radiotap_iterator_next
From: syzbot <syzbot+b09c1af8764c0097bb19@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ca4ee40bf13d Partly revert "drm/hyperv: Remove reference t..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175d1b3a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b4f2aab682301f1
dashboard link: https://syzkaller.appspot.com/bug?extid=b09c1af8764c0097bb19
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f321eee08a1/disk-ca4ee40b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e93195c44eb5/vmlinux-ca4ee40b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3f7091036e0/bzImage-ca4ee40b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b09c1af8764c0097bb19@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_radiotap_iterator_next+0x11f8/0x1620 net/wireless/radiotap.c:317
 ieee80211_radiotap_iterator_next+0x11f8/0x1620 net/wireless/radiotap.c:317
 ieee80211_parse_tx_radiotap+0x4bb/0x2160 net/mac80211/tx.c:2122
 ieee80211_monitor_start_xmit+0x125e/0x1750 net/mac80211/tx.c:2451
 __netdev_start_xmit include/linux/netdevice.h:5275 [inline]
 netdev_start_xmit include/linux/netdevice.h:5284 [inline]
 xmit_one net/core/dev.c:3864 [inline]
 dev_hard_start_xmit+0x24e/0xad0 net/core/dev.c:3880
 __dev_queue_xmit+0x35e0/0x5a50 net/core/dev.c:4829
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3077 [inline]
 packet_sendmsg+0x91d9/0xa320 net/packet/af_packet.c:3109
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0xa77/0xb90 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __ia32_sys_sendto+0x12f/0x200 net/socket.c:2209
 ia32_sys_call+0x372f/0x4360 arch/x86/include/generated/asm/syscalls_32.h:370
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x17f/0x3f0 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was stored to memory at:
 ieee80211_radiotap_iterator_next+0x14c8/0x1620 net/wireless/radiotap.c:251
 ieee80211_parse_tx_radiotap+0x4bb/0x2160 net/mac80211/tx.c:2122
 ieee80211_monitor_start_xmit+0x125e/0x1750 net/mac80211/tx.c:2451
 __netdev_start_xmit include/linux/netdevice.h:5275 [inline]
 netdev_start_xmit include/linux/netdevice.h:5284 [inline]
 xmit_one net/core/dev.c:3864 [inline]
 dev_hard_start_xmit+0x24e/0xad0 net/core/dev.c:3880
 __dev_queue_xmit+0x35e0/0x5a50 net/core/dev.c:4829
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3077 [inline]
 packet_sendmsg+0x91d9/0xa320 net/packet/af_packet.c:3109
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0xa77/0xb90 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __ia32_sys_sendto+0x12f/0x200 net/socket.c:2209
 ia32_sys_call+0x372f/0x4360 arch/x86/include/generated/asm/syscalls_32.h:370
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x17f/0x3f0 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable iterator created at:
 ieee80211_parse_tx_radiotap+0xc4/0x2160 net/mac80211/tx.c:2093
 ieee80211_monitor_start_xmit+0x125e/0x1750 net/mac80211/tx.c:2451

CPU: 1 UID: 0 PID: 12634 Comm: syz.4.1919 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
=====================================================


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
