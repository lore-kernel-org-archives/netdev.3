Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B863BBFBD
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359254; cv=none; b=gEMET3FbkJFhe+xA36jrj3UtRpol+0QmIt7L5SxeitAjt6tlTlKwz3shAEnbsAWVWWnhOv74CAVOsHheGFinc5hpuRfntxnaKahzj5mEuZB7A+cfDsRKhOX99ywRfbCijf9P347D/fCu8Oxnt7W1brhlHbXNeiZrJ7xwswrmCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359254; c=relaxed/simple;
	bh=kZEjGd26MsL766/iGbJtwfZ7R34vLJUKqbysB7dXWic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvNOSSdr6tAU7NpDyWTS6Ea/nTK6AwZTVPrLx+dwn1hUpGP2kSh89EvF4oerfpcOz1WQUIA8luWTmXaPqL3jIHZZZgTi+7s5GrfA/QO96gc4DBpWUnHqgw/Lfb59IB1sG2CQXH9veEwIKIDNLzs6LlQtYBORbr4r0tfD8AQl6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TO/T5dxm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/mP77hL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO/T5dxm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/mP77hL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786359251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NjvFbhL7Df+92uixUJZIK1YUsyLV9HZLMltNjEc1hEs=;
	b=TO/T5dxmiV2R66bZRd5zjyZxT5gfmOrKVqcibGP73GLIig+b9Q6SQQL6etlL0NtQxXLPBR
	cM7tqiFf9MQ0vpH1obgGT4Mm6JwlpsCweyV8xM6iUGtpqzOTsBv1TUhKenCdXrSrKo3IUv
	z4nrnj8v8TT/VuqoYhhMcW66s55xUeQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-sNelKzoVPFmv-fR6BD1Dyw-1; Mon, 10 Aug 2026 06:54:00 -0400
X-MC-Unique: sNelKzoVPFmv-fR6BD1Dyw-1
X-Mimecast-MFC-AGG-ID: sNelKzoVPFmv-fR6BD1Dyw_1786359239
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47485fde05aso1027908f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786359239; x=1786964039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjvFbhL7Df+92uixUJZIK1YUsyLV9HZLMltNjEc1hEs=;
        b=d/mP77hLunTorte0SwxwHtTaF6Bsmcf4tJd1pHXeOgIrm9TE/hyNAua+4kTi6huOx9
         uQFSIrTboBkhBXV8XJRS0HNns13XTQfs7l4C2xNYNNDZijOtyH0bOh7WHXoYOfiMZyyz
         rMcZ6ryscrT89zYx9vvXmXd7E7Z5kHtaawEdpZjA9g1EKwwiyYT1BC4TYty1h2DYpUUJ
         0yRwy1zNJlOwbTcNzbLLUC2y7XPXd3FQQfaOy5QvIArqNaHdBrpjEDJgVbBGG+cKBTUF
         Xbu2cBAuHHQ/tzRKhakzg4WbbzjnbElnVFPrQhgbH2DtE3USMfJhxB844IGy4fLN87pq
         msFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786359239; x=1786964039;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjvFbhL7Df+92uixUJZIK1YUsyLV9HZLMltNjEc1hEs=;
        b=SQ4TqL27Ki4qz5zc0iUbL6miHz+gsmz7nc91AjjNyDcfUoiATD6FfV9+an5und9vCM
         CpAvwvT25IX3Pg0fPLuRoHqq/zfGBBBbulGUx7fUeT2PjuEH0lo4f6GO6c9QEBRi2us/
         uWvKLgYbUjw0cQCH18DPSJ64sXbI8xqp37BIo3pj02F3kcTNjdHnOmJ3PKVIvk/IuFuU
         8iJ/tEUN/s+N6yhCo0aqIduS/pV5doBwFbxUAVPcm16Yz5r+ouAhMAhHWjWO/73S46Gb
         Xe4e8QQWeAEKBq8f6eir3gpEx178fa6OyULMwobFZEoXqNG43Qy3e+FAezw6GJq05+nr
         m4Yw==
X-Forwarded-Encrypted: i=1; AHgh+Rqu4tgjWDLNUquyIBIAAmJ81+ru5dmv0TABUrWp6wiSG0HK/21+9FWvqml1mFbLWiAZ5/pNy2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1G8MRh8KitDsr7IsR5mvTUc9HTB1lYjiIgVvn61qiG9NBgqJ
	fwRaOy2lHZWx7mU37Xs4yast/i/OUARnmRJL4oPA9cPlq6tJ0im9ETUrhxLo4/FQ2OlgAInFo2x
	L7KfFOQcEdRF5r4Lbcmh04jSJsRbWysqWIXKzCPPnKueTIoCMLfFxncmn8w==
X-Gm-Gg: AR+sD12xLMVtAAr0Vt00TlNVlRT/gtXuvsLRa53xnCWjzNj0Y2/6YIjt6kPqz9F6Iwq
	Tfk/jnKxxnPe7oxzFMgB+HJcUIvL+BSZTrCL8YT56STNaDyIuZeT3ovTCjDIHBB6QOVO3B66aUY
	gtEteO2uI1IoUliDHmwL4izucRyV7lx4ceJ3iEzpMF/gF6/CQeYBMCICs9oZJKTpouTHKU8PYpi
	+QRJ5eKb54ryymVJT+Pif7usQV4Z7DRvBcECJpkjnPNip/5f6zHsSL271iNCo4UF6UuffU9+vj/
	pQjUyWbC87sOBrhHiTRzWHUiAfGw7Q5VGYbh/lgEUM0yhcslVm8Go9NXJu5Fj7YLowZBwD9qfN+
	f+cXXDtyNT69eHyOyhktnx1HXs/Xp8WhaG0/0OlzFKVdmebnYCJ8jJ3wjUbh+zcZG0AZnrn8ZBE
	k=
X-Received: by 2002:a05:6000:461b:b0:480:268:8f04 with SMTP id ffacd0b85a97d-481455de89bmr1609434f8f.11.1786359238982;
        Mon, 10 Aug 2026 03:53:58 -0700 (PDT)
X-Received: by 2002:a05:6000:461b:b0:480:268:8f04 with SMTP id ffacd0b85a97d-481455de89bmr1609364f8f.11.1786359238441;
        Mon, 10 Aug 2026 03:53:58 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145966sm31724597f8f.5.2026.08.10.03.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 03:53:57 -0700 (PDT)
Message-ID: <94a00de5-6293-42bd-b7bc-5370ea16a3e3@redhat.com>
Date: Mon, 10 Aug 2026 12:53:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in ipgre_xmit (2)
To: Jason Xing <kerneljasonxing@gmail.com>,
 syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com>
 <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
 <CAL+tcoAR9WTmrFiM0GtWhtvgWX467vAD9fRRJ-Hds9Q346EB=w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoAR9WTmrFiM0GtWhtvgWX467vAD9fRRJ-Hds9Q346EB=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/9/26 8:03 AM, Jason Xing wrote:
> On Wed, Aug 5, 2026 at 1:05 AM syzbot
> <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=178fb649580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
>> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1617be32580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d113b9580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/4949138dcfef/disk-848acc8f.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/31cc6fbe5b8a/vmlinux-848acc8f.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/433919ca6520/bzImage-848acc8f.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> len > ((int)(~0U >> 1))
>> WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason include/linux/skbuff.h:2864 [inline], CPU#1: syz-executor147/5638
>> WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inline], CPU#1: syz-executor147/5638
>> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline], CPU#1: syz-executor147/5638
>> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline], CPU#1: syz-executor147/5638
>> WARNING: ./include/linux/skbuff.h:2864 at ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658, CPU#1: syz-executor147/5638
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 5638 Comm: syz-executor147 Not tainted syzkaller #0 PREEMPT(full)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
>> RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
>> RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inline]
>> RIP: 0010:pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline]
>> RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline]
>> RIP: 0010:ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
>> Code: 48 3b 84 24 80 00 00 00 0f 85 3b 01 00 00 31 c0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3f 1a 78 01 cc e8 09 f5 6a f7 90 <0f> 0b 90 e9 08 f8 ff ff 44 89 ff 44 89 e6 e8 b5 f6 6a f7 45 39 e7
>> RSP: 0018:ffffc900039af5e0 EFLAGS: 00010293
>> RAX: ffffffff8a5c1d67 RBX: 0000000000000000 RCX: ffff888079535d00
>> RDX: 0000000000000000 RSI: 00000000ffffff40 RDI: 0000000000000000
>> RBP: ffffc900039af6b0 R08: ffff888079535d00 R09: 0000000000000002
>> R10: 0000000000004888 R11: ffffffff8a5c1410 R12: ffff88807ecbc000
>> R13: dffffc0000000000 R14: ffff88807b7f2780 R15: 00000000ffffff40
>> FS:  0000555590a0a400(0000) GS:ffff88812504b000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055704428ded0 CR3: 00000000788f2000 CR4: 00000000003526f0
>> Call Trace:
>>  <TASK>
>>  __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
>>  netdev_start_xmit include/linux/netdevice.h:5409 [inline]
>>  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
>>  __xsk_generic_xmit net/xdp/xsk.c:1253 [inline]
>>  xsk_generic_xmit+0x2759/0x47b0 net/xdp/xsk.c:1309
>>  __xsk_sendmsg net/xdp/xsk.c:1363 [inline]
>>  xsk_sendmsg+0x482/0x810 net/xdp/xsk.c:1373
>>  sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
>>  __sock_sendmsg net/socket.c:790 [inline]
>>  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
>>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
>>  __sys_sendmsg net/socket.c:2770 [inline]
>>  __do_sys_sendmsg net/socket.c:2775 [inline]
>>  __se_sys_sendmsg net/socket.c:2773 [inline]
>>  __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fc137b1b409
>> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fffc9ef46d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc137b1b409
>> RDX: 0000000000000040 RSI: 0000200000000700 RDI: 0000000000000003
>> RBP: 0000000000000000 R08: 0000000080000000 R09: 0000000080000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
>>  </TASK>
>>
>>
>> ---
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
> 
> Please try this one instead. I'm not sure if the previous patch has
> the index problem...
> 
> But the following patch can be applied in my tree.
> 
> #syz test

Please, do not cc the netdev ML for syzbot test patches. They may foul
PW and the KCI.

Thanks,

Paolo

