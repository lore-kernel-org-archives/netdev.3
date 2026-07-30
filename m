Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC381433BB2
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419608; cv=none; b=KmkxdMBPiNaQT44ix0zKEhL/Ov1uj5CTCWDDXFHbllo699aesRheKzGZoHimMBHQtdYUG6zs8haPQO2Th1yoIkY/UqHO8TPNxVlPuwfGeo7f7bS3tCgFzs4qqhQAB0HT6aoG4fEcNCdyyZXOWVvCusVGSSgw+JPJrNO7ei+zKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419608; c=relaxed/simple;
	bh=K95i2dycr1Y1y9y+ClkO0QRYJ0O3v/04py+y9K32lRw=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H1F+tCIx+HGNcOxHIiNDVBO43CRLS5tPm5gFqdFJzySsBCnhj2ehHYFSLBdBrgInLaCBYMDAAe/QsFgmI5pRWX4Tn0Lt0QIzOpU3WbsR57D4iZUco01EmaIGyCvOhKLhrheGoltSohu93QoAOZ0dDSJQoWvu2kwrbDWfqtMKwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0Z38qOJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0Z38qOJ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81f36179dd5so31533027b3.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419605; x=1786024405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mu6cNrR0W8flzZXRF2HaqMmIkY9quL2cGjJt6Hs8JDQ=;
        b=r0Z38qOJLeXH+WNiMb6z5XtpXY+xK0iHVRWHv/TfvOlQqLb4CBZ3nniX2FA29fsguc
         ul4Auq1QyJlE4MWB8PaayUVR+qhkg16CGaxA4c+dPbKMl69umAO6/i5MRZQPb/qvsvGv
         uLHPaDStSVOTxNNopuTFeNXEu6spmIks4qF616qM3ujZLqW9sSPM5BmqynankqyDp+ER
         Jb/BISPO5GjYkbJp43Puju8e8IiNeCTEaH81Cg2yvKT2Kfd5LNXx2uolZDJUZglEKjyd
         CGBeXDwP2jd7x2GUDLllT4nfaNXcN+YuxDd1D7ZJWs0bYxQHd/pEq2iQZRWZgb+1vv71
         zb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419605; x=1786024405;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu6cNrR0W8flzZXRF2HaqMmIkY9quL2cGjJt6Hs8JDQ=;
        b=YA7TnuZjTXhpwPmDGYCvcPY7YI6BtM9ExgRmpSxMikJm1D0Vg/L8iu48N5MrkcCQBq
         0oUdALnfBl94dyjwt7rZ+YbyYLrj5U9URS4V6obuga9wUG/sfLdJoYwtKMfSq9APVib7
         9Tm+QKcUbRgwf/MmEYajGWAs8fn09wsO4/zxHkwelIkDxtujOw1Yy330NPrr3V500Mug
         zwH7A1oi+Byfn79SE9UOjve8gdpQ92e8qI4eNOA3G0pmvC6AbyVSft4ucyhxotKXNmzO
         7GyYzMBZAJsjvZoIZXXOqKVrFuKHqsvxtQLurmtqNB+rzJ/SNaxgUAKZ9m99WDAiFGvE
         Zd1g==
X-Forwarded-Encrypted: i=1; AHgh+RpxABf2eP6LCQ4Nw+WupCvg71rm+l6Me96MtIRJDw1W3xv3K83H3jFXHpmP550/boT2LaEq4oA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BhSwFZWhE3nwn+LF40B/pJI+vwO6kykA1MMA5+KAkpPx58Zq
	S6/UbPoxFbW8nU+1lrZnEkodPjK+B4kVfoWncwyFDcELTJAUTWvzXmerEHtnkNfr
X-Gm-Gg: AR+sD12/PeKSYCZVj28Ykh35dH5SKAC+1MFpdfrF7Wc8QMKDdu1ISQixMiROsd1WdNY
	aIokkE1/TqpPfa4w49OIbfZvm5zTGac7FAdwDtMs0kZ+yyV6jhWSyod0ZpWbkV7yooTpD9jCW6y
	5v+Bc6kclAf7hAf+zg7byQIjUlA0SzHPoLg11wboUJhkv03+q3oBknpQakoAXDXOR1ZbmILMnCa
	bAIwIoqtVzmACRGXyAGnxq2I2LpxUKjflIMmQ8hnwA9tqRIf6n1caOPHeuzghPiBGAsWu1KES0b
	KsVgyzT07/KIpJFCc42M/o3AZ6vlH69FX2bigjBYqcPgoEQI3yjB4hwd3I8hQW0qUUhzNxnwP+H
	7iQeBw1c4ERKM0vr8ZOr1dFVxGp7z5rx7q5WXc8izGULYQBI4Ylf2YR3iWlzkid9pGU563fsooK
	e2RfVqdVFkKHVN5ROF6prWAeQb5KPCDvZtYdHHBSOFufDwaWj2SjsApJI4kjxhrKf6/c5aa1jce
	1PR8ZUBjbNN4bPejJ0NEWoLyN4MkuumaEHlakiurzuxsS0=
X-Received: by 2002:a05:690c:6d02:b0:80d:c2cc:f673 with SMTP id 00721157ae682-81fb89781cdmr18468717b3.20.1785419605542;
        Thu, 30 Jul 2026 06:53:25 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8ae4d56sm9981737b3.39.2026.07.30.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:53:24 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:53:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: syzbot <syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 syzkaller-bugs@googlegroups.com, 
 willemdebruijn.kernel@gmail.com, 
 alice.kernel@fastmail.im
Message-ID: <willemdebruijn.kernel.1cc6c160b4b5d@gmail.com>
In-Reply-To: <6a6a966c.86abc875.e5c3d.0054.GAE@google.com>
References: <6a6a966c.86abc875.e5c3d.0054.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in udp_v6_send_skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    04026c998c24 net/rds: use krealloc_array() for iovector gr..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=163a6499580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f592a4e0cc86da
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce13c07d96d04716eaa2
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4f82b6352d02/disk-04026c99.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9b29e52c71b2/vmlinux-04026c99.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0b1e84e828d6/bzImage-04026c99.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> len >= 65536u
> WARNING: ./include/linux/udp.h:49 at udp_set_len_short include/linux/udp.h:49 [inline], CPU#0: syz.4.4430/24120
> WARNING: ./include/linux/udp.h:49 at udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375, CPU#0: syz.4.4430/24120
> Modules linked in:
> CPU: 0 UID: 0 PID: 24120 Comm: syz.4.4430 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
> RIP: 0010:udp_set_len_short include/linux/udp.h:49 [inline]
> RIP: 0010:udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375
> Code: 42 0f b6 04 38 84 c0 0f 85 37 06 00 00 41 0f b7 1e e9 60 f3 ff ff e8 04 c3 43 f7 90 0f 0b 90 e9 02 f4 ff ff e8 f6 c2 43 f7 90 <0f> 0b 90 e9 e9 f4 ff ff e8 e8 c2 43 f7 90 0f 0b 90 e9 94 f5 ff ff
> RSP: 0018:ffffc9000e0a74c8 EFLAGS: 00010287
> RAX: ffffffff8a833e8a RBX: ffff8880355e4a00 RCX: 0000000000080000
> RDX: ffffc900100ca000 RSI: 00000000000049e3 RDI: 00000000000049e4
> RBP: 000000000000244c R08: ffff888049ed5d00 R09: 0000000000000003
> R10: 000000000000000b R11: 0000000000000002 R12: dffffc0000000000
> R13: ffff888027cb0c80 R14: 0000000000010000 R15: ffff8880355e4a02
> FS:  00007f2d4a07b6c0(0000) GS:ffff888124f54000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000010000 CR3: 0000000029d28000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  udp_v6_push_pending_frames+0xa2/0x140 net/ipv6/udp.c:1451
>  udpv6_sendmsg+0xfa0/0x2610 net/ipv6/udp.c:1740
>  sock_sendmsg_nosec+0x90/0x180 net/socket.c:775
>  __sock_sendmsg net/socket.c:790 [inline]
>  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
>  __sys_sendmmsg+0x273/0x4d0 net/socket.c:2827
>  __do_sys_sendmmsg net/socket.c:2854 [inline]
>  __se_sys_sendmmsg net/socket.c:2851 [inline]
>  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2851
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2d4919de99

Interesting trigger of the recently added DEBUG_NET_WARN_ON_ONCE in
udp_set_len_short called in udp_v6_send_skb.

No reproducer yet, so probably not very actionable at this point.
A mostly straightforward looking ipv6 udp sendmsg path.
