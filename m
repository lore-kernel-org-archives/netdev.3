Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208E3AE195
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243826; cv=none; b=U82NO23nlRpsh5/+P5WlrhddDtAIH9vz3tHLx5gmABt/Q9E5zdZM9HCv5oVsGozb/kqQjd3adCvz5vcAcGuu+NnfmvsLtP8Ya/lR+15nK+uhjzQaepTx43FLAPqcOM+BzYu4ViCdtapgkKbIDLjWqMHc5Y/64xd3Hxf8T2WGTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243826; c=relaxed/simple;
	bh=ezlL/05hTjc59M9JMSnCcVjSLETeIAlX4JiGnhjw1w4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hC223TYNnRtQ0s0XqvU6R/ENmZ8AD0SZGqKloRdFBfxPUQzl7RwH9Ua8+nVv7rDonzsB3yzeXLbWz6nBe9dH2P+k+FjCPEMQeLfhmVuan8DqZM+zKTKC8oXW30/2u9OmN4hoHcdKeq0YbvqeM/69Af1ZFZm/Fic+U47t3CbwCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7f66624aa21so412406a34.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789243824; x=1789848624;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NC5wIFrOLxpILKOliVtJmVWh7MhmLTBGqFSlaBXK+qg=;
        b=tXL15Gxz8q/5PeaxtGCeTBoMXeSZ1U5R5wABeV8C/fD65hNjRJR9SQN2Z9OfVLGvU4
         vAS8Cu9NY5yUR5oKjtOBH1bK8apqeM6cLeGxGNrUspGG6MmBoYQb4Jxy13JDglVFnkYx
         rXSz2sJQfxEwXSqguoy8QNdBmkTXJyxRmXr+Qv+E886871QNoL2YYRCWvF++tfmEFmhF
         bn71KEzU8L7Ngu8+ghnP6nY4DJpfeugq69NeLzcClzj7TZTkkXW2cIZTucr3X8gQo4ZX
         uxf8zlnIEXPJSsIPPCOaepFqh9XkzYBWIGZXIfs1Gc5bwGhMGbuQxgm1QTJtLa57w2lL
         3/og==
X-Forwarded-Encrypted: i=1; AKwUvByvkVC6QY5szWs/dMqxZaOL10TcBbmjUiLdZiEspNLgdkoFJf5cPkX6uWD3THBDGpI8XgwclqM=@vger.kernel.org
X-Gm-Message-State: AFuF++lMDfNUgXdtnEoZJTGq4u4W8xMwxBPe6DTdzM+h8JDWbYFSiMAQ
	QFA+XfkJ1LJ+b5Ne//VNPvpu483B2ZIPDYOCJ1ApMc5uwXXISuozDGY14AsHUl6BBCyqddioa3M
	dpqGXmKBVUs+Ck7cqlWw1zsuVDBd7FdGhWpdjLbCIt7hu4l0QifUXLnQNM9k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d04:b0:6c1:f832:9b6a with SMTP id
 006d021491bc7-6c24e671d43mr2171106eaf.33.1789243824191; Sat, 12 Sep 2026
 13:10:24 -0700 (PDT)
Date: Sat, 12 Sep 2026 13:10:24 -0700
In-Reply-To: <6a8b254b.91706f20.16b6e3.02c9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa5b1b0.f81106d8.2ab401.002f.GAE@google.com>
Subject: Re: [syzbot] [wireless?] memory leak in ieee80211_mesh_csa_beacon
From: syzbot <syzbot+f5752cd6b94fe38be666@syzkaller.appspotmail.com>
To: johannes.berg@intel.com, johannes@sipsolutions.net, kartikey406@gmail.com, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, nico.escande@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5225b8eec4c9 mailmap: update entry for Jens Axboe
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1172e9f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=736c81750115a056
dashboard link: https://syzkaller.appspot.com/bug?extid=f5752cd6b94fe38be666
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a9b615580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d870c9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12d5d066d792/disk-5225b8ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9bb3f95e482/vmlinux-5225b8ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84ee8de2ba4a/bzImage-5225b8ee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5752cd6b94fe38be666@syzkaller.appspotmail.com

2026/09/12 20:09:52 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888107ffb800 (size 1024):
  comm "syz.0.18", pid 5913, jiffies 4294943824
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d8 23 48 14 81 88 ff ff 00 00 00 00 00 00 00 00  .#H.............
  backtrace (crc f81fd0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4696 [inline]
    slab_alloc_node mm/slub.c:4996 [inline]
    __kmalloc_cache_noprof+0x38f/0x420 mm/slub.c:5559
    _kmalloc_noprof include/linux/slab.h:991 [inline]
    ieee80211_mesh_csa_beacon+0x2e/0x100 net/mac80211/mesh.c:1547
    ieee80211_set_csa_beacon net/mac80211/cfg.c:4674 [inline]
    __ieee80211_channel_switch+0xb22/0xed0 net/mac80211/cfg.c:4795
    rdev_channel_switch net/wireless/rdev-ops.h:1168 [inline]
    nl80211_channel_switch+0x39b/0x780 net/wireless/nl80211.c:12388
    genl_family_rcv_msg_doit+0x12e/0x1a0 net/netlink/genetlink.c:1114
    genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
    genl_rcv_msg+0x302/0x440 net/netlink/genetlink.c:1209
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2556
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
    netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
    netlink_unicast+0x38f/0x4e0 net/netlink/af_netlink.c:1345
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1900
    sock_sendmsg_nosec net/socket.c:800 [inline]
    __sock_sendmsg net/socket.c:815 [inline]
    ____sys_sendmsg+0x54a/0x580 net/socket.c:2713
    ___sys_sendmsg+0x101/0x140 net/socket.c:2767
    __sys_sendmsg+0xcd/0x140 net/socket.c:2799
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888107ff8400 (size 1024):
  comm "syz.0.19", pid 5915, jiffies 4294943825
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d8 23 48 14 81 88 ff ff 00 00 00 00 00 00 00 00  .#H.............
  backtrace (crc f81fd0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4696 [inline]
    slab_alloc_node mm/slub.c:4996 [inline]
    __kmalloc_cache_noprof+0x38f/0x420 mm/slub.c:5559
    _kmalloc_noprof include/linux/slab.h:991 [inline]
    ieee80211_mesh_csa_beacon+0x2e/0x100 net/mac80211/mesh.c:1547
    ieee80211_set_csa_beacon net/mac80211/cfg.c:4674 [inline]
    __ieee80211_channel_switch+0xb22/0xed0 net/mac80211/cfg.c:4795
    rdev_channel_switch net/wireless/rdev-ops.h:1168 [inline]
    nl80211_channel_switch+0x39b/0x780 net/wireless/nl80211.c:12388
    genl_family_rcv_msg_doit+0x12e/0x1a0 net/netlink/genetlink.c:1114
    genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
    genl_rcv_msg+0x302/0x440 net/netlink/genetlink.c:1209
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2556
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
    netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
    netlink_unicast+0x38f/0x4e0 net/netlink/af_netlink.c:1345
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1900
    sock_sendmsg_nosec net/socket.c:800 [inline]
    __sock_sendmsg net/socket.c:815 [inline]
    ____sys_sendmsg+0x54a/0x580 net/socket.c:2713
    ___sys_sendmsg+0x101/0x140 net/socket.c:2767
    __sys_sendmsg+0xcd/0x140 net/socket.c:2799
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
