Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572943BF679
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474481; cv=none; b=rYmg9mWOXQ1XQOs4A7usZu7g2sFdFw6yCmmGE1fDtYCcswSm06VERJ2WfFmXmOaDuzaV0aZCv0G1a+y1zIb0Ke6m5Qf9IlaIPe9jYiEe/Tsa3faZ4Qph4Uy3uIgpqdGjGFT06aAwECdy+dsNvbyGNzwyVgQswUIcavvkyMpJ+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474481; c=relaxed/simple;
	bh=ThjschtgO5VzHniT0X3lzlpF3bl+1DAzVt/+7IWTpFk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZKIIPgMxTbVGQzoMTA0vTr09jhq+luTFl7xxn9Mu0Fb7+kXdsrFcR/s3Ap3oO+aW60nvficcoBkqbMPyvYEQpiWZXMZZ0uP7NKFznB2HRx5vUkbzH6ufhiV5VY4p4qvBgbED9OAZ5znv6s/oN3ceHmvxYYuY2/H2lSTnRUKcb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6b1b8f5a1d5so878512eaf.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789474478; x=1790079278;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9GvKUPLnOF2I98DABCDFpJhWscTY1pE+sJ+D8uGup9Y=;
        b=aPY4FezqUhY5U4Lqb+GtMtvLCBDSuDGGmC5PTvlDLme0zlKT5ponoHg0CoF1xkoyYc
         8HkkR9AXI7x1cVQ8LD0WZYRhA9XWLRg3/thI7fUCc9G9x0QsdH2gJkSDT50XIAjlMS/I
         IziFEmJqvZriv87+dBf/mZIH5JLriUAhkRAcuLOXkQEQ1VYoYS7oB5cbfuI31B2fLr8k
         k3JaxrNx45SuwBcCEu4O/3HP9mwJaywvx3E6XmeZbXbw+iLujfyBXic7KuUy+3bdg1Bo
         47Ulryy38em7qOoGlm9DCiXGxXRffBUeE9jAK2hJjs0aZZUrJCovhzMN7jApWM9/N3WT
         dbUw==
X-Forwarded-Encrypted: i=1; AKwUvByBRhuAfGOk5BFGIYUGktrITWCtvfRQeIu5E9eKkQEVCPO8OJ/x4SRgq8u+LUptnrid5yAc9ig=@vger.kernel.org
X-Gm-Message-State: AFuF++n5W3lQSEaTxesKiJlQVVvd/vGL8OT4KKtZPYo8xb8eall4LIzT
	9/N1/HReb++Hv4dLFWy6ArNBsmDwHMPNp4f9DJU1Sa/W4lTNCL9yKadP3MrzpFZhQFrg/cLWFxm
	UvGGFD2hVo204XekimrWha3Vsgyc5clms3MAQYj4KdS7AHdwsHT7NwqT38h8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca4:b0:6c2:c9ec:ee7 with SMTP id
 006d021491bc7-6c541b41a58mr4447153eaf.37.1789474478263; Tue, 15 Sep 2026
 05:14:38 -0700 (PDT)
Date: Tue, 15 Sep 2026 05:14:38 -0700
In-Reply-To: <6a00e81a.170a0220.1c0296.0218.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa936ae.f81106d8.2ab401.0065.GAE@google.com>
Subject: Re: [syzbot] [net?] unregister_netdevice: waiting for DEV to become
 free (9)
From: syzbot <syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	penguin-kernel@i-love.sakura.ne.jp, raoxu@uniontech.com, 
	syzkaller-bugs@googlegroups.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5445d6419962 arm64: Don't read GMID_EL1 when MTE is disabled
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1250428e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56ed23170c168d4c
dashboard link: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b32471580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d742d1580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8b70e3bd109/disk-5445d641.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5227e56ac93/vmlinux-5445d641.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54905f78be59/Image-5445d641.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com

unregister_netdevice: waiting for netdevsim2 to become free. Usage count = 2
ref_tracker: netdev@000000004118ac35 has 1/1 users at
     __netdev_tracker_alloc include/linux/netdevice.h:4528 [inline]
     netdev_tracker_alloc+0x68/0xb4 include/linux/netdevice.h:4540
     fib_create_info+0x15cc/0x2184 net/ipv4/fib_semantics.c:1524
     fib_table_insert+0xa4/0x12bc net/ipv4/fib_trie.c:1212
     fib_magic+0x26c/0x344 net/ipv4/fib_frontend.c:1147
     fib_add_ifaddr+0x114/0x500 net/ipv4/fib_frontend.c:1169
     fib_inetaddr_event+0x114/0x1c0 net/ipv4/fib_frontend.c:1483
     notifier_call_chain+0x1a4/0x624 kernel/notifier.c:85
     blocking_notifier_call_chain+0x70/0xa0 kernel/notifier.c:380
     __inet_insert_ifa+0x87c/0xa74 net/ipv4/devinet.c:566
     inet_rtm_newaddr+0xba4/0x1140 net/ipv4/devinet.c:1001
     rtnetlink_rcv_msg+0x66c/0x9bc net/core/rtnetlink.c:7132
     netlink_rcv_skb+0x238/0x414 net/netlink/af_netlink.c:2556
     rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:7159
     netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
     netlink_unicast+0x600/0x7f8 net/netlink/af_netlink.c:1345
     netlink_sendmsg+0x648/0x948 net/netlink/af_netlink.c:1900
     sock_sendmsg_nosec net/socket.c:800 [inline]
     __sock_sendmsg+0xc8/0x17c net/socket.c:815

netdevsim netdevsim2 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
