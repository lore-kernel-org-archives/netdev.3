Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54D32E12E
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600860; cv=none; b=DqPK58/lSjBf5AeOC29QXwCDdbWm0as0UXag5QKSfYfvhXtz1YwgcoDYDwqy/ZZ8aw8rVwwgm5BseHUt4xNGsuktvFpLh4gu66aE3TDgIWICd+Ikyy2Riqsv5aN3e5s/ePMIt7oJOUIUkak1sD2HrkLFsQZ1JA6OatiUITY9rKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600860; c=relaxed/simple;
	bh=v6Q47YLktRY+V2MCW9UGDjT53Ag9+rLJrNs0cKMNxm8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nL+kUEldKBgNBBBPEXx6fXc0nfHslDwMWso5ZC/yNLxzumAauoG8UmMem1m/oRCO057LNXbgYdMS7Pj/0CDMeqaeQh3fGvI/pPceqSy6hhhEnPaTCLp1sAhxAKydGxquBGcwyF8Ffo4RP+SBJY7G7y76MphBQzRPvfy5JXsP35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so1291941b6e.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600857; x=1788205657;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2K9XH4FWtMdmA3NTxpUS7TtOHEjFGVnzKTgFWMmUGLY=;
        b=MyIlzy+cFT46ypBFwhxwNQCBcZnFTtzDWxKswgf8t90pWWjw1AkTOTT3sexDHHOD/s
         lx8vmUw5ahrNNA3G3V6GWZk5u2BM3h0VBL2TNZwmKsN6+n/RENfJaFTkv5apVUd6tX0p
         hEISmwXJongVv8E7+92Na8kd/iYa0GQkcGX2NzG44HHN7aftQzcgDNS+JcQUSg9YuR66
         PcFI+Y7z8MUA0mDcrJwyOoltSWOWKQktz9FKuHW/PPUcLfpS+BzAThEcVXJbDn5q81gF
         VlyCGunANV8P6Edz9m8XLB07GgryVFbS9jCELYf0t3i2WIWFC/gdBu8t/Co+h8RUsC0I
         xXCg==
X-Forwarded-Encrypted: i=1; AHgh+RqzNnuKGbrRyf8UJ2bcd+VjyPbA8vrifBZtvHTUB3u1y9SjyItZEetgo7Wj3Z7o6e4TDaLkiFE=@vger.kernel.org
X-Gm-Message-State: AFuF++keLr+jtgT3f4WMo15zt26umrrySgOU/3JbQvnI9E1rr2HdV+ku
	VkZKvp5YvDEbum+OaIpgvXwYw2YTld07X0uAoNgUJfHg6kazOZy4gurl1r9npVfnTwcv/CWdj06
	LJJ1RqEwdccDcAQnYzz+G780ehbu5j0u081jC6w6dJRR04KhNkNx2ioZvapc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6809:289:20b0:4b3:1e40:640b with SMTP id
 5614622812f47-4b31e4068ffmr11239161b6e.6.1787600856868; Mon, 24 Aug 2026
 12:47:36 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:47:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8c9fd8.dbb3a75c.7844.000b.GAE@google.com>
Subject: [syzbot] [net?] [nfs?] BUG: stack guard page was hit in inet_stream_connect
From: syzbot <syzbot+c9834a0c0215e6d8697a@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, anna@kernel.org, cel@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jlayton@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neil@brown.name, 
	netdev@vger.kernel.org, okorniev@redhat.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d58772d8520c Merge tag 'regmap-fix-v7.2-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14733132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a233ed2ce9a8096
dashboard link: https://syzkaller.appspot.com/bug?extid=c9834a0c0215e6d8697a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f51079580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c92c6580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d58772d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4e864f7b043/vmlinux-d58772d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f485f29307dc/bzImage-d58772d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9834a0c0215e6d8697a@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc900062a7ff8 (stack is ffffc900062a8000..ffffc900062b0000)
Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5926 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:svc_tcp_state_change+0x8/0x350 net/sunrpc/svcsock.c:911
Code: 90 90 f3 0f 1e fa e8 27 63 3a f7 90 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 <41> 54 55 53 48 89 fb e8 fc 62 3a f7 48 8d bb a8 04 00 00 48 b8 00
RSP: 0018:ffffc900062a8000 EFLAGS: 00010246
RAX: ffffffff8acf6c90 RBX: ffff88804bcda700 RCX: ffffffff8a23004b
RDX: 1ffff110046ce059 RSI: ffffffff8acf6cdb RDI: ffff88804bcda700
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888023670000
R13: 0000000000000002 R14: ffff88804bcda700 R15: ffff888050125a40
FS:  0000000000000000(0000) GS:ffff888096cf3000(0063) knlGS:0000000057414480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc900062a7ff8 CR3: 0000000052f7a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 svc_tcp_state_change+0x81/0x350 net/sunrpc/svcsock.c:917
 tcp_done+0x1da/0x360 net/ipv4/tcp.c:5100
 tcp_done_with_error+0x57/0xd0 net/ipv4/tcp_input.c:4877
 tcp_reset+0x13b/0x310 net/ipv4/tcp_input.c:4909
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6903 [inline]
 tcp_rcv_state_process+0x20c5/0x7190 net/ipv4/tcp_input.c:7197
 tcp_v4_do_rcv+0x691/0x1260 net/ipv4/tcp_ipv4.c:1876
 sk_backlog_rcv include/net/sock.h:1190 [inline]
 __release_sock+0x35a/0x440 net/core/sock.c:3260
 release_sock+0x1e5/0x280 net/core/sock.c:3859
 inet_wait_for_connect net/ipv4/af_inet.c:616 [inline]
 __inet_stream_connect+0x5c7/0xfa0 net/ipv4/af_inet.c:710
 inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:755
 __sys_connect_file+0x141/0x1a0 net/socket.c:2135
 __sys_connect+0x141/0x170 net/socket.c:2154
 __do_sys_connect net/socket.c:2160 [inline]
 __se_sys_connect net/socket.c:2157 [inline]
 __ia32_sys_connect+0x71/0xb0 net/socket.c:2157
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf705efec
Code: Unable to access opcode bytes at 0xf705efc2.
RSP: 002b:00000000ff81576c EFLAGS: 00000296 ORIG_RAX: 000000000000016a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:svc_tcp_state_change+0x8/0x350 net/sunrpc/svcsock.c:911
Code: 90 90 f3 0f 1e fa e8 27 63 3a f7 90 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 <41> 54 55 53 48 89 fb e8 fc 62 3a f7 48 8d bb a8 04 00 00 48 b8 00
RSP: 0018:ffffc900062a8000 EFLAGS: 00010246
RAX: ffffffff8acf6c90 RBX: ffff88804bcda700 RCX: ffffffff8a23004b
RDX: 1ffff110046ce059 RSI: ffffffff8acf6cdb RDI: ffff88804bcda700
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888023670000
R13: 0000000000000002 R14: ffff88804bcda700 R15: ffff888050125a40
FS:  0000000000000000(0000) GS:ffff888096cf3000(0063) knlGS:0000000057414480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f705f000 CR3: 0000000052f7a000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	f3 0f 1e fa          	endbr64
   6:	e8 27 63 3a f7       	call   0xf73a6332
   b:	90                   	nop
   c:	0f 0b                	ud2
   e:	0f 1f 40 00          	nopl   0x0(%rax)
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	f3 0f 1e fa          	endbr64
  26:	41 56                	push   %r14
  28:	41 55                	push   %r13
* 2a:	41 54                	push   %r12 <-- trapping instruction
  2c:	55                   	push   %rbp
  2d:	53                   	push   %rbx
  2e:	48 89 fb             	mov    %rdi,%rbx
  31:	e8 fc 62 3a f7       	call   0xf73a6332
  36:	48 8d bb a8 04 00 00 	lea    0x4a8(%rbx),%rdi
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


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
