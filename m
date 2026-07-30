Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9643F8CB
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420657; cv=none; b=tEx3S/CLoQ/nbudPfPBWkgWw4i4+Jo5W5m7d5cHROvnDKt2alyZXmP6LYLqsn+CwqV306wegeTT0SpqR7H5t7PXQ8sSSq8l9DIZmipQVaC5DVQ3fQpmsK1vpMN10L40TnUD6wEfOUrDpJ97ok3IlQjCEfYyZ6FEpaYe7xtOPueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420657; c=relaxed/simple;
	bh=aQogbV84RggRrahqa76pG6F9nLqQpRnpdC2ipK4Ws5Q=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SueIPG0gTOXY3qAXfStbxmGT6f2iyuVs9UcyEINN+RfB+FtEiL3SySgEAFV94Ki2l2GiodQ2yJ0Adcv4eJy3E9KIS9mkpdvoagBWrsvjbwk8wQj+ZF18lu9QAoZxhFhlCjbE5iCrjYxqJ1D46q1GUQUclh04AHgmHa+bN2V2fLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMNm8fQV; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMNm8fQV"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6611669cd16so3110434d50.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785420652; x=1786025452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bmzab8yfcbEljQ732UQImSrkFQV/YXpU+sklxb6eMX8=;
        b=AMNm8fQVg3kAnzbVLZUq1yaWKETwrHyKZNhgQ46p3gGKTnuaik7Ct2IhpE24HL58EO
         2snqAhCVwnrTfrXXavptPFigZoLRwgSqcozSCanpnYX9Vu0KrWXzsBeZ+w11dp6HdeGU
         KTSKuLKewd8nWcD+yaM7a/GcVtSUdzjgKn+yFmlzQKf+Q4PcmpsiaCnwR9BYMPjeYPrb
         PZ0EpT8ZZargwmDqKsHjujvzaJd+Z+gnlFmDSQtdUQGYYCmfMgBFk1R20YXlnA1vq8ic
         5imNLR7QmzbrtoMkm2t0cWtgbMDDCRpldlWjVMUwwSkVmJatjve11576o4EASyoo2Vbf
         Enyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420652; x=1786025452;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmzab8yfcbEljQ732UQImSrkFQV/YXpU+sklxb6eMX8=;
        b=arct/Z1ZLGrEUXNj+u5bpB70QSynMX0u1Oe7bR4GLthIbMtm0jiPpF4D0Gr5SiNsu8
         2EMLZMhYfpR7om/EeyJUirSPIXhGozY/1AJsJQPM7Zx3KqwbXjA+j+jgcHKqLIeNoASc
         8PfWBcfaw+e1wppKgArDezI2i8Xfn9wDrlXecmxh60VDd+SdRRv+ZZ84/D1ky+lHYeFh
         kWgKc67CVzd0UN0dRFqwzl11vZ64U01C/R+oxZrbGs1EF1Ba5IgzHv/zdLySU2ygxQx9
         7rjtqkRbOaelQolSVYfnbX5zshfeMmE7JtzEpPvrIP8j0sArTjYEiMMtqDxHCfIagVY2
         KsMA==
X-Forwarded-Encrypted: i=1; AHgh+RrMIfzF9/mDJk47JidF7RYfz/P8LgCSSSeMqhZFcQUxJQqBVo+8z4WSyTHfKqefEtuyQj7SSW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIQ9P+/C/VyaDZ0lKUXKcUaVFaeOxOxK+OjpgvUJAsE5vYxPz
	rbkZiMcgPFiTJtm7XeFiGrxi1XEFPAyr27RC7GUfGRNOF8JUDvNU5Qio
X-Gm-Gg: AR+sD11BHWWNkhAGLcZvyBRFsvbkaXG2Hu1t9TVAja3JYbBYZDr0MUMXgc+uEAHeKW2
	Tu6W06VEZNaD+DN06MrGsShcIn0OqGxahUFsBmlRbmgMjSCa0R8X3cv3dZWvd3qkz5JqgKDOp+B
	nybGJnQbw6+6ugcT7Weut0bhdkZY9KiXPqJCswtAjbzfEnnZCXO8k0OU3x+IDe6uZ1ukzsRvC1Z
	wx8O47fLxYLn54Y8VSmCVygm+Wf0ulpuu80cAo24Mv64pKWJT9mEGE/yU5nBLEAd5fab097nnms
	u4GuMQpmYnX9loT5GSB9E0+OgwxXRIvbJFNLxfuIyPtF9G9WrBnY+UE/EEpFhAytnAN/TljrrRQ
	Z1N4kav12ZXTXWgSiSLVjcyRFV+77Wql1oRO1AQ+tsAUVneEDx4Np33uGM+6Pbnnrs0yEI98f3e
	XP5jmobaEElU09ILBM0+i/ydjHe16at0zYjL0LbM55ysR2dDQK7ggL5yRRg1lNqtQz721Ye1WJD
	Hu4rlmkfFFK3CnshWNf1qA24e7f4jxWTjr1/Q==
X-Received: by 2002:a05:690e:dc1:b0:664:f064:f663 with SMTP id 956f58d0204a3-6692f4d47e9mr2059658d50.28.1785420651979;
        Thu, 30 Jul 2026 07:10:51 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c6e9bc7sm1337186d50.1.2026.07.30.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:10:50 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:10:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 syzbot <syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com>, 
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
Message-ID: <willemdebruijn.kernel.35c8c21f85396@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1cc6c160b4b5d@gmail.com>
References: <6a6a966c.86abc875.e5c3d.0054.GAE@google.com>
 <willemdebruijn.kernel.1cc6c160b4b5d@gmail.com>
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

Willem de Bruijn wrote:
> syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    04026c998c24 net/rds: use krealloc_array() for iovector gr..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=163a6499580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f592a4e0cc86da
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ce13c07d96d04716eaa2
> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/4f82b6352d02/disk-04026c99.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/9b29e52c71b2/vmlinux-04026c99.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/0b1e84e828d6/bzImage-04026c99.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > len >= 65536u
> > WARNING: ./include/linux/udp.h:49 at udp_set_len_short include/linux/udp.h:49 [inline], CPU#0: syz.4.4430/24120
> > WARNING: ./include/linux/udp.h:49 at udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375, CPU#0: syz.4.4430/24120
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 24120 Comm: syz.4.4430 Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
> > RIP: 0010:udp_set_len_short include/linux/udp.h:49 [inline]
> > RIP: 0010:udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375
> > Code: 42 0f b6 04 38 84 c0 0f 85 37 06 00 00 41 0f b7 1e e9 60 f3 ff ff e8 04 c3 43 f7 90 0f 0b 90 e9 02 f4 ff ff e8 f6 c2 43 f7 90 <0f> 0b 90 e9 e9 f4 ff ff e8 e8 c2 43 f7 90 0f 0b 90 e9 94 f5 ff ff
> > RSP: 0018:ffffc9000e0a74c8 EFLAGS: 00010287
> > RAX: ffffffff8a833e8a RBX: ffff8880355e4a00 RCX: 0000000000080000
> > RDX: ffffc900100ca000 RSI: 00000000000049e3 RDI: 00000000000049e4
> > RBP: 000000000000244c R08: ffff888049ed5d00 R09: 0000000000000003
> > R10: 000000000000000b R11: 0000000000000002 R12: dffffc0000000000
> > R13: ffff888027cb0c80 R14: 0000000000010000 R15: ffff8880355e4a02
> > FS:  00007f2d4a07b6c0(0000) GS:ffff888124f54000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000010000 CR3: 0000000029d28000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  udp_v6_push_pending_frames+0xa2/0x140 net/ipv6/udp.c:1451
> >  udpv6_sendmsg+0xfa0/0x2610 net/ipv6/udp.c:1740
> >  sock_sendmsg_nosec+0x90/0x180 net/socket.c:775
> >  __sock_sendmsg net/socket.c:790 [inline]
> >  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
> >  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
> >  __sys_sendmmsg+0x273/0x4d0 net/socket.c:2827
> >  __do_sys_sendmmsg net/socket.c:2854 [inline]
> >  __se_sys_sendmmsg net/socket.c:2851 [inline]
> >  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2851
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f2d4919de99
> 
> Interesting trigger of the recently added DEBUG_NET_WARN_ON_ONCE in
> udp_set_len_short called in udp_v6_send_skb.
> 
> No reproducer yet, so probably not very actionable at this point.
> A mostly straightforward looking ipv6 udp sendmsg path.

Actually, this may just be a valid UDP_SEGMENT skb with max payload:

    IP6_MAX_MTU (0xFFFF + sizeof(struct ipv6hdr))

This is what __ip6_append_data checks on egress

    mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;

Not sure whether UDP_SEGMENT can legitimately build even larger
BIG-TCP variants of UDP_SEGMENT skbs at this point too today.
