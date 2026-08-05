Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6C3EB0FA
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919869; cv=none; b=n57hx7o1mubZwrcCCobHIbtXkNiky5eqgd4dunZFdvpeL68hSt933dAX9pD877Qmyiactp2K4cAOjZnSSwhJNcMhz6eSlrwuvzfzRinoVJC71BNW2FIaFsK2wTFUXswxydR6OzBPOPlvz8P/rbmzKYkp0VD9WAI2GWahQSBllt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919869; c=relaxed/simple;
	bh=/vNz4l5mVBXMp/4PH3TwZUItUxW2xvaKbwVX+IlWgcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fu0pWx7+GWD0/iyo3+c9vRtiHcFmtj5z8R2rtZ0Wb68BB3bqlfmscvKhmUY/sNNmvuHOaqu5WVK9J+d5pg5cpCN0xAlpGM7t4z+zXw+TUW6buHqi9q+aDyOTYdJlUAXVJj6mQL7CjDxNiWXC7NgnVPmtgv2KODE9Haeztj8B3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha4k84BV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha4k84BV"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47fe377a217so448242f8f.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785919865; x=1786524665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekeQUweNW8T1ePcvlKq4eWssEHW2Oh8NqmSu+siabRQ=;
        b=ha4k84BVKbdb8JK+m2gkAi00KKrtVMHlsLNiun1gdR3NRcqO8f3T2ykQWn1L7/uK/n
         fWug3ynwxEve6F7SkhWHJH6AzxAm4AofvaTXIMUMHdXIESimRicp1a+AYWOogqx9mjOm
         TdqSDECzug0yTP0MorXcF+euJZU95j47gFu/rOWdhO7q5RVSF3KO+usJcrh1FBMRZ98B
         BbWIcF21lnF9c2iUuMAfJ84gOjZ3EhDs8IpSFbu4L3LM2oT4Py2Lcd2mS10wUq62/Jsq
         +QRO8wD4JiQnP02ptxMNsMV6K0gUhT6ecDCFYgScScNRezqVvJt/uwLP5YqzzZ3rTgfQ
         R1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919865; x=1786524665;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekeQUweNW8T1ePcvlKq4eWssEHW2Oh8NqmSu+siabRQ=;
        b=Py7kOO/YAwVyiiI7vguMQjc77FmO2dLy5cd1p5ChhzTKLYzJU1PViY1VkdPJck31p4
         1xQxfQ/GoTn6tgudTlsKOlXtml1hIN3GITI43k9iW8kdJ5ZTI2cIo7Qkwi13GbSfMg8e
         oL1Hjho4U3MCREzovURw1T3oZckbj/KOeSgcl/oxKScfb75LIxj3zKXDs0nCcSGut1Yr
         rhS1PdT5r/lSqWCsgE1LN3YUHSdHspqrx03Undn+A2IpitVkrHzEMQgMzEWEqnUwytph
         5McpELZETvCqtC8PQC+cdGIU75kNl8Zm2aToJuSZm45XvW8DsOIZF6XGs9yjWPpYNOQO
         POdQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMjW8gYGhIXW7hFmbF93OjonfXz2jEqJc6TQWSOcsUbiNIzGY3pckvMuEfW7EAwuTLZ3/iipU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqc7MRTPKGudN3sQqK3e3tVon0O205WtK74BD1tWtZnTFIHfVN
	3luk7EeS2lfc1rSaD1KMSvf/1bbYKbNX6/sg5BIvafrohjcAaQd0htzT
X-Gm-Gg: AR+sD10xpA0nsddV4iLkA1FqYBOrJThG4mA5Lhl5ELsdK/eHfj1Ye6/n7FEdD3F+4sd
	xN8GMnt7v96LY+XGuPTvt5utZLIunVf8FSCB7QrPNMHPgRtGUy26faZ0zYB9H6Ff6dDFrikyvXM
	9FB5Vz7131CV7p8aEfdacB/ELtqHaCLT5RaUuW5K9p5mEeBEmDOnAfFwpd6d2yFIA5fEiHAUI+1
	yUt7APC1mnGJFeLFlCBtIpQd0/kw0oGsQjxVrpUH+RVt5d/9BsJFxWwNxMt2mlCv9oxmTciw+il
	zmX5iLg8TjBhKqjQwgxg79rhTF+Z3/RbQeAEMWOCYCfuPY2+rPIMZaiKjouKIHcTlNS4eSsnpHP
	xtf4vgHInquHJQNXFf2CqWC8XqiK+gZOOAi+k/KUlgKQWCZVJoGKOuvtVl+vqG61o0Fxw5M0kdz
	6NUP1eBGUDC4JMOWcgzBLvcemJj2To8haNebgDLAC+yV9+UBUpa3EQQJUCPKSmxoStSB9Eg2OLx
	1iFbl6yG35LmatRjJg5cws+CZpV8iKkpHTdY9Su+zi+K62Zjft1bwCXe9g7IQFvJC8JDdzaNWGS
	JZuP79s7GOYboxFGjWVrtpuffWAu0ksXhITv4yhlQNdjNb3Q
X-Received: by 2002:a5d:5e08:0:b0:47f:8488:50f0 with SMTP id ffacd0b85a97d-47fec4e419emr8609795f8f.4.1785919865291;
        Wed, 05 Aug 2026 01:51:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232e40sm8347489f8f.19.2026.08.05.01.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 01:51:04 -0700 (PDT)
Message-ID: <0a419b0b-18d6-42a4-962d-301ddd9d4498@gmail.com>
Date: Wed, 5 Aug 2026 09:51:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in netdev_queue_get_dma_dev
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
 <20260804140006.0210f6ca@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260804140006.0210f6ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 22:00, Jakub Kicinski wrote:
> Hi Pavel, could you TAL?

It complains on not holding rtnl, so the netdev should be not
qops-enabled, and we acquire it with netdev_get_by_index_lock().
It's going to be rejected later, but not sure whether netdev->lock
protects its device and leasing logic well in this case.

As a quick fix, let's fail it early in zcrx if there is no qops.


> On Tue, 04 Aug 2026 07:32:44 -0700 syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    075b74841bd0 Linux 7.2-rc6
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=176a7db9580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a78926bdac2adb52dc0e
>> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16225db9580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bade32580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/1dc04730d019/disk-075b7484.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/d76da42271f4/vmlinux-075b7484.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/07b1cdbcbe45/bzImage-075b7484.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> RTNL: assertion failed at ./include/net/netdev_lock.h (72)
>> WARNING: ./include/net/netdev_lock.h:72 at netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline], CPU#1: syz-executor223/5620
>> WARNING: ./include/net/netdev_lock.h:72 at netdev_queue_get_dma_dev+0x52e/0x660 net/core/netdev_queues.c:43, CPU#1: syz-executor223/5620
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 5620 Comm: syz-executor223 Not tainted syzkaller #0 PREEMPT(full)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
>> RIP: 0010:netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline]
>> RIP: 0010:netdev_queue_get_dma_dev+0x53a/0x660 net/core/netdev_queues.c:43
>> Code: 89 c5 89 c6 e8 27 f7 68 f8 45 85 ed 0f 85 be fb ff ff e8 a9 fc 68 f8 48 8d 3d 12 0e 90 07 ba 48 00 00 00 48 c7 c6 a0 88 18 8d <67> 48 0f b9 3a e9 9c fb ff ff e8 87 fc 68 f8 48 8d bd 00 08 00 00
>> RSP: 0018:ffffc90003b47a80 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff888029874000 RCX: ffffffff89a16569
>> RDX: 0000000000000048 RSI: ffffffff8d1888a0 RDI: ffffffff91317390
>> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
>> R13: 0000000000000000 R14: ffff88807b3f2568 R15: ffffc90003b47be0
>> FS:  00005555885ac400(0000) GS:ffff888123ed8000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000200000001000 CR3: 000000006f8b6000 CR4: 00000000003526f0
>> Call Trace:
>>   <TASK>
>>   zcrx_register_netdev io_uring/zcrx.c:831 [inline]
>>   io_register_zcrx+0xe94/0x1d30 io_uring/zcrx.c:983
>>   __io_uring_register io_uring/register.c:942 [inline]
>>   __do_sys_io_uring_register+0x1193/0x1bc0 io_uring/register.c:1040
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fd0b54bbcb9
>> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffe25f0a7f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
>> RAX: ffffffffffffffda RBX: 00007ffe25f0a928 RCX: 00007fd0b54bbcb9
>> RDX: 0000200000000400 RSI: 0000000000000020 RDI: 0000000000000003
>> RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffe25f0a928
>> R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffe25f0a918
>> R13: 0000000000000002 R14: 00007fd0b554cca0 R15: 0000000000000002
>>   </TASK>
>> ----------------
>> Code disassembly (best guess):
>>     0:	89 c5                	mov    %eax,%ebp
>>     2:	89 c6                	mov    %eax,%esi
>>     4:	e8 27 f7 68 f8       	call   0xf868f730
>>     9:	45 85 ed             	test   %r13d,%r13d
>>     c:	0f 85 be fb ff ff    	jne    0xfffffbd0
>>    12:	e8 a9 fc 68 f8       	call   0xf868fcc0
>>    17:	48 8d 3d 12 0e 90 07 	lea    0x7900e12(%rip),%rdi        # 0x7900e30
>>    1e:	ba 48 00 00 00       	mov    $0x48,%edx
>>    23:	48 c7 c6 a0 88 18 8d 	mov    $0xffffffff8d1888a0,%rsi
>> * 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
>>    2f:	e9 9c fb ff ff       	jmp    0xfffffbd0
>>    34:	e8 87 fc 68 f8       	call   0xf868fcc0
>>    39:	48 8d bd 00 08 00 00 	lea    0x800(%rbp),%rdi
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
> 

-- 
Pavel Begunkov

