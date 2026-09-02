Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1A418343
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386727; cv=none; b=CNk7UBgSEksov2F/EsV6a2ENOLIQe8ORdDjb3Fxgebhnl7Unkqyw1Gtmfxqu6Kg45Ypxk5RFt2BLx+lcTOkjKEcnaOFMKZcG62j/DMv2bqAEpBMzoZJSE3mOtOOHhF+iFPtzEXHCQd4R76Xrg1W4b+q87rrpWt6UzYV2CSUc6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386727; c=relaxed/simple;
	bh=WrNsgg1LDugEtKCJojlK1pSJgViIdBqsDBJpxyfRqe0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nxj84e3JSWrxASmvLonMGZ5USbrAmR0/ty77HqhbilK9Rm1fQKI8GMKP03lSWE1CUzfaCEDmqmAPG8CD4JuWVT5ZLK7ByZl0an7fGNV29oEibKnP4s9w4Jir499gJTyDUgS3h94rymb0klPWnvM7+Z1n9NOJH0r+fgsFfNvK16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b139665345so1292109eaf.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788386722; x=1788991522;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LfKD6ngQRTKOJI4e0mUBdk+l6HtVu+CazLqp1wl6LGY=;
        b=pIf06m6Px/ZSBUFqY2biOdqOKKdTiODDLXbbTLEQpXqadMriAIDnJ7sA+Oxh4Y8oxA
         HORsahko2fsnE9CKzZOAftZmaUTVkguCse8mGJyuAYm+Yk1jsnq5iCUpOYww5Ir8HhAc
         7Dtql9AkghGavFKPTklROOxCeQjOAws7klH5L6M6qrE4ljRDnXL7W257AOTlGoTWYpqV
         pyEBwMpRaIJ7Xm6N/ZrtzB+WdPhtm70GeCh1Bj1AZ+GSCaWrQNfIsFzPTuVafUNG5lp4
         dzNAq8cEuvttAvd96zIbmN2Jy8hxrIXOW/L9bxU+jUzE07yzrzeOHmGoDrbuqm9TJhZ9
         Qw0A==
X-Forwarded-Encrypted: i=1; AHgh+RpDCxaJq69EDreeLZpZLcNV2sfx+2AqJ5hH/TNhAPV7knwnGs8/wfWGok3J2tHLUOWv4FF/pfg=@vger.kernel.org
X-Gm-Message-State: AFuF++n0XktDGWQvFBdC23vMtgLX7SuAd2mGRswEHv8eRXdlyGToZHYT
	UFgdvrnOdkYw+CgtHbzF82oHdB6qPNaQtYvHwN4tg5yAbCJEdX2v4cyviGqod99wkAOQvhp9Eqa
	/NhjZiKBw/AAWK9V3w12olJo1rlZMeEmbRCmj9Fs9t/0ZT8ap75098JtAO7k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:199a:b0:6b3:619f:25ce with SMTP id
 006d021491bc7-6b47eed806amr6317636eaf.30.1788386722094; Wed, 02 Sep 2026
 15:05:22 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:05:22 -0700
In-Reply-To: <20260902055802.3724915-1-4ncienth@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a989da2.2e567484.299ffc.0001.GAE@google.com>
Subject: [syzbot ci] Re: ip: validate options before echoing them
From: syzbot ci <syzbot+cid466e4e888be6037@syzkaller.appspotmail.com>
To: 4ncienth@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] ip: validate options before echoing them
https://lore.kernel.org/all/20260902055802.3724915-1-4ncienth@gmail.com
* [PATCH net v3] ip: validate options before echoing them

and found the following issue:
WARNING in __ip_options_echo

Full report is available here:
https://ci.syzbot.org/series/58d17295-c695-49b2-826d-b0fe305808e9

***

WARNING in __ip_options_echo

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      70f3995830d3f1e79faa14eb0605914f778feca9
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/9a250d6c-0a45-4565-bbc0-cac6bc3e42ee/config
syz repro: https://ci.syzbot.org/findings/5fa937c9-0c72-4a82-8221-cd01d8dc83d5/syz_repro

------------[ cut here ]------------
len > ((int)(~0U >> 1))
WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason include/linux/skbuff.h:2864 [inline], CPU#1: syz.0.17/5791
WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reason include/linux/skbuff.h:3294 [inline], CPU#1: syz.0.17/5791
WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull include/linux/skbuff.h:3299 [inline], CPU#1: syz.0.17/5791
WARNING: ./include/linux/skbuff.h:2864 at __ip_options_echo+0x10e4/0x1870 net/ipv4/ip_options.c:115, CPU#1: syz.0.17/5791
Modules linked in:
CPU: 1 UID: 0 PID: 5791 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3294 [inline]
RIP: 0010:pskb_network_may_pull include/linux/skbuff.h:3299 [inline]
RIP: 0010:__ip_options_echo+0x10e4/0x1870 net/ipv4/ip_options.c:115
Code: 00 00 00 fc ff df 43 0f b6 04 3c 84 c0 0f 85 64 07 00 00 41 88 1e 4c 8b 64 24 10 41 83 c4 04 e9 a7 fe ff ff e8 7d 13 84 f7 90 <0f> 0b 90 e9 35 f1 ff ff 44 89 e7 44 89 f6 e8 79 15 84 f7 45 39 f4
RSP: 0018:ffffc90004efef40 EFLAGS: 00010293
RAX: ffffffff8a43a023 RBX: ffff8881b89a6b58 RCX: ffff888111125a00
RDX: 0000000000000000 RSI: 00000000fffffff8 RDI: 0000000000000000
RBP: ffffc90004eff070 R08: ffffc90004eff2c7 R09: 0000000000000000
R10: ffffc90004eff2b8 R11: fffff520009dfe59 R12: 00000000fffffff8
R13: ffff8881b89a6a80 R14: ffff8881b89a6b00 R15: 000000000000001c
FS:  00007f39f8af86c0(0000) GS:ffff8882a8cdf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f39f8af7ff8 CR3: 0000000112830000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ip_options_echo include/net/ip.h:798 [inline]
 icmp_reply+0x2da/0xc90 net/ipv4/icmp.c:429
 icmp_timestamp+0x246/0x370 net/ipv4/icmp.c:1430
 icmp_rcv+0xd33/0x1290 net/ipv4/icmp.c:1543
 ip_protocol_deliver_rcu+0x2dc/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:325
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:325
 __netif_receive_skb_one_core net/core/dev.c:6264 [inline]
 __netif_receive_skb net/core/dev.c:6377 [inline]
 netif_receive_skb_internal net/core/dev.c:6463 [inline]
 netif_receive_skb+0x45b/0xbf0 net/core/dev.c:6522
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1571
 tun_get_user+0x2be0/0x44d0 drivers/net/tun.c:2045
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2091
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f39f7b5e98e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f39f8af7fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f39f8af86c0 RCX: 00007f39f7b5e98e
RDX: 000000000000003e RSI: 0000200000000780 RDI: 00000000000000c8
RBP: 00007f39f7c35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f39f7e26038 R14: 00007f39f7e25fa0 R15: 00007fff66b2b028
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
