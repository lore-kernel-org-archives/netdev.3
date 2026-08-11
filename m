Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71220E023
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418219; cv=pass; b=gmkyTfKrnVo01CjywhG7PBZqK788Mli1WLhOyJODQ1dOS3OpUNb4w2sVifkuWgJl3+Z/Ga/PRPy+PUTcr2fKQE5+jcHRsBUuH3PixVnpWPHz2RO9dqpd4OdJBC0IKER0C0V7dferP6R7kWypEs115KAplOniLHT1Vbklwkrxnkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418219; c=relaxed/simple;
	bh=fSn4+qZXJWOSnTSzsut14FweNZqvedbTAdgT1zHI+A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfUrCzUgHyGVC94sP4+J8sF8W71QGegxWCcCeB6U2dZ1PX2tTaViL4XPiGf0mPwA+/XlL0fsPT7sCytn3/O22zB6vk2UqBpL9C77aZkIci+FcwZJYKRwRhknuYOz5H97rVWPQoODtHrg6+z0aXguR3t7Gl3VAiG8+fOrZRVyTaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOWxdc95; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOWxdc95"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1942659a12.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 20:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786418217; cv=none;
        d=google.com; s=arc-20260327;
        b=WSmBjroyMNykssx1PXijhRwZG7Q99aQulrTywZKXdZMY/ll9U2CxwuhmAyX/7ROCSS
         wgTlGZBj8AmahJ/bJ3gYyXXW8YV1+zD1p88wejaxDE6D/Re12S6OcdGUz9jvZSPDj9op
         9v4xeRd7KiahPRb7sA7viIZBAwqxEFJl83Gl4LDLC4KEZpiwvM1jkFBpSHOanz6cozpV
         Y7G/UV4k1D9l5WvBcuvijICpmUlL+tFD4g15UFo99sUt9ZqmrhDDIq6CpCl84z00+omC
         aeTuK1b4sJyrUOAo+lkVmrSPt2OW4632hFzrV5eBGrq2hgAkPY3NwaKUm/LeQst5iMQF
         WIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xOJZvj5pv4jJZceQoaCVyfBtSwk5xdxotriU/V+vmJg=;
        fh=B53BfxsDhesLPv+Is8xOlRAS8fupRSkufhiOGAlsubE=;
        b=VJ8h+CYZttC8GGTHXu7RvtspWvhSq4pdTxEN4TJk5eNTjjrMz/IZwXI100MfYyBBIB
         s4g7h4rhrEfZeALcfWK8fCzFIxNWc7y00ZWHQX3QCv9KmiOMLYKcS0B/rl8JeKDQOd6n
         HRiV/PdS18RIWzNnJD4HHZQ1a4boCTmm/5Aom+l6steQd19k544CPEIx/JOZ/7Sk3PMf
         fvRgf05ufs2jjR1V5NAh46UpuLE4IPv96OTVQjdd2gI/5Y5bcYPRPupNHXja4PvqdRib
         Ug/Fv/tPvDuyGVPcKHCYcPvFGOK2QOOhjmF5SK1yhypVprYkG46tCABQjNiwoMhmda3O
         FbtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786418217; x=1787023017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xOJZvj5pv4jJZceQoaCVyfBtSwk5xdxotriU/V+vmJg=;
        b=JOWxdc957NNlbcFHl6k810s+3CVQxf5WULNvJ6qusmfmOHG6CUvXolPlQnFOBKwu91
         JCSIbk2RLTs5+nhB/iv7jr9VySr1X6k75oyiyY82Jc9MsPMzFjJMevZu77I3uV+gOe4O
         NaCxCVx/30O2bRNO48Tgx010paeW8HFZjmXuoF7/x80xsLUxoto04Zi3XTPq8pK0stLb
         4ijcayLMIsOAocCXn0/TqAJQVrvh7/toJh84iLrrbKxrSMdXe1YmCL5/DDQDvhwNdm0O
         Cb0inp8W/DpYn6sgdNWN2rRRSPvG8s36fO1O7UndhZTpb+K6YSNIwrPQeyDjh3TQumuW
         sUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786418217; x=1787023017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xOJZvj5pv4jJZceQoaCVyfBtSwk5xdxotriU/V+vmJg=;
        b=Emmx7/QZBcCKBTMupSzP/lUgDEbAWob9yirtci21JSjl21ruqkrdilpDzjsTAAQcDO
         U80v2NnIFgCPm7W2UxKD9hvjqUJrUoHV6Bn6elMDrMg/L0NVmWd3//jGOPAbg4ZZZ5U/
         054EEJdmNlgSwXyt/hQLjfr242iIC81thOg4V5y40RPqjoUE9uglFHwaUBuB7pm02Zpw
         Edb51kPp+hhD1qglPhX4/SJoKZw1I70GZvsP2wrs4HfWziruvn0CmwIoRDs+9vwE6sIj
         Q1DHkvt9Rc9vhsB6uilL61xnonoUvCmBO36gHnumc6Pr+scNDDSUTyZj+9v249OodVAq
         KmUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQTtOta4fH7dQ5tYT4JbkggVyuh5UOQJcecRAi0PdVdNqKRSrMwbqWDkVkyii71CeiBRRc1vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdw0PyqV4JIe5K6jpxF5ZC7dENtE85PhRRBNTA7kcMcakjIowA
	SRsE55e21PrcyAMFqe9JQAcjlyu3KNz2kO2Gtu4A2MAruJIS826wzypuZmv/U/iLOIBYU4Deoa7
	n+fQyIU/jvoyvR0l0om07QSDNH7gOC8LqZyyU3hmablJrRx5aaLSSCsGS7G8=
X-Gm-Gg: AR+sD10/avIBpfekoAKKhaUi9IlnN+an1SRTOjCgASRo/bFxCGyIm+kE154kSIOUK/a
	GLwCjq/b8LEF+uVKRkdsWAqv+vcmVepfj02mpKIBlB2JWguiDEbuGu4WE5KJGryeVT7BEn/83I/
	gQNXu6fn1KB94C03X9eIbp/sKaUUnxLYPqRrf7krRHwnNKnDIKARY4aemAiC3jKMAPp9CNipSZe
	nFLwrbjYLHcRyOZlDWrO/vIOhWDlXaM9VPW7nDrkyvtbMRDm4Tfh0YpjZWp+agsSL7HZqPKC+gc
	ctftVbDDCeuF3a7cilqKmw3II5g/GYKudx2Ob0NrD95E11I9vpDGVy/u9C/UdTZGQ/8IUzC33t8
	a2fqbdhwezIyq97cHi1zktijWypk2TCIX2GStlRFJTAkGaVteWDUYArRHOndukgCzI3a2ZXUrfB
	LTRiyg8d2hseIT9g==
X-Received: by 2002:a05:6a20:94ce:b0:3c3:69d0:c57c with SMTP id
 adf61e73a8af0-3cc2bb3da18mr662728637.32.1786418216527; Mon, 10 Aug 2026
 20:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a7a6bc6.01d0871a.3a0d52.00b4.GAE@google.com>
In-Reply-To: <6a7a6bc6.01d0871a.3a0d52.00b4.GAE@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 10 Aug 2026 20:16:44 -0700
X-Gm-Features: AUfX_mwHN76DGA0O5potqhSJTV3YOqHLQBM67Jk1OqJrjEhwkthxeX1GYwNSoEU
Message-ID: <CAAVpQUDeJXVS0s13a4KETWoDYC5W_J9TYP=i=gYi2=dGUxeg2g@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in __virt_to_phys (6)
To: syzbot <syzbot+204eda57286574703583@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:24=E2=80=AFPM syzbot
<syzbot+204eda57286574703583@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7235a3e71949 Merge branch 'for-next/core' into for-kernel=
ci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D134277b958000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dccf4bea59f670=
07
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D204eda572865747=
03583
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e25=
5-1~exp1~20260613092250.77), Debian LLD 22.1.8
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fd45635beaae/dis=
k-7235a3e7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d7d2e6507223/vmlinu=
x-7235a3e7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b5b5d8de4cea/I=
mage-7235a3e7.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+204eda57286574703583@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> virt_to_phys used for non-linear address: 00000000b1de4396 (0x17ffffe7910=
01021)
> WARNING: arch/arm64/mm/physaddr.c:15 at __virt_to_phys+0xe8/0x130 arch/ar=
m64/mm/physaddr.c:12, CPU#0: dhcpcd/4400
> Modules linked in:
> CPU: 0 UID: 100 PID: 4400 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/02/2026
> pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
> pc : __virt_to_phys+0xe8/0x130 arch/arm64/mm/physaddr.c:12
> lr : __virt_to_phys+0xe8/0x130 arch/arm64/mm/physaddr.c:12
> sp : ffff8000997e72b0
> x29: ffff8000997e72b0 x28: ffff800088b0b6a0 x27: ffff0000c7228000
> x26: 17ffffe791001021 x25: 0000000000000204 x24: ffffc1ffc0000000
> x23: ffff80008869e000 x22: 000f600000000000 x21: 000000000000002d
> x20: 180fffe791001021 x19: 17ffffe791001021 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000002 x9 : b196a926009aaa00
> x8 : b196a926009aaa00 x7 : ffff80008048e080 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000802f8070
> x2 : 0000000100000000 x1 : ffff0000c7228000 x0 : 0000000000000000
> Call trace:
>  __virt_to_phys+0xe8/0x130 arch/arm64/mm/physaddr.c:12 (P)
>  virt_to_phys arch/arm64/include/asm/memory.h:369 [inline]
>  virt_to_pfn arch/arm64/include/asm/memory.h:383 [inline]
>  virt_to_slab mm/slab.h:193 [inline]
>  qlink_to_cache mm/kasan/quarantine.c:131 [inline]
>  qlist_free_all+0x58/0x120 mm/kasan/quarantine.c:176

It seems something (UAF? OOB-write?) corrupted KASAN metadata,
not an issue in AF_UNIX.


>  kasan_quarantine_reduce+0x118/0x124 mm/kasan/quarantine.c:286
>  __kasan_kmalloc+0x2c/0xb4 mm/kasan/common.c:406
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __do_kmalloc_node mm/slub.c:5334 [inline]
>  __kmalloc_node_track_caller_noprof+0x434/0x6d4 mm/slub.c:5471
>  kmalloc_reserve+0x118/0x214 net/core/skbuff.c:637
>  __alloc_skb+0x230/0x610 net/core/skbuff.c:715
>  alloc_skb include/linux/skbuff.h:1384 [inline]
>  alloc_skb_with_frags+0xb8/0x690 net/core/skbuff.c:6769
>  sock_alloc_send_pskb+0x740/0x850 net/core/sock.c:3013
>  unix_dgram_sendmsg+0x434/0x1078 net/unix/af_unix.c:2136
>  unix_seqpacket_sendmsg+0x108/0x1d0 net/unix/af_unix.c:2537
>  sock_sendmsg_nosec net/socket.c:775 [inline]
>  __sock_sendmsg+0xc8/0x17c net/socket.c:790
>  sock_write_iter+0x220/0x310 net/socket.c:1241
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x51c/0xa0c fs/read_write.c:687
>  ksys_write+0x12c/0x228 fs/read_write.c:739
>  __do_sys_write fs/read_write.c:750 [inline]
>  __se_sys_write fs/read_write.c:747 [inline]
>  __arm64_sys_write+0x84/0x98 fs/read_write.c:747
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
>  do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
>  el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
>  el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
> irq event stamp: 345484
> hardirqs last  enabled at (345483): [<ffff800080491644>] vprintk_store+0x=
924/0xb94 kernel/printk/printk.c:2385
> hardirqs last disabled at (345484): [<ffff8000868e6198>] el1_brk64+0x20/0=
x54 arch/arm64/kernel/entry-common.c:425
> softirqs last  enabled at (343926): [<ffff800084c14ca8>] __alloc_skb+0x1c=
0/0x610 net/core/skbuff.c:698
> softirqs last disabled at (343924): [<ffff800084c14c90>] local_bh_disable=
 include/linux/bottom_half.h:20 [inline]
> softirqs last disabled at (343924): [<ffff800084c14c90>] __alloc_skb+0x1a=
8/0x610 net/core/skbuff.c:697
> ---[ end trace 0000000000000000 ]---
> Unable to handle kernel paging request at virtual address 005fffff638e004=
8
> Mem abort info:
>   ESR =3D 0x0000000096000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0
> [005fffff638e0048] address between user and kernel address ranges
> Internal error: Oops: 0000000096000004 [#1]  SMP
> Modules linked in:
> CPU: 0 UID: 100 PID: 4400 Comm: dhcpcd Tainted: G        W           syzk=
aller #0 PREEMPT
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/02/2026
> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
> pc : _compound_head include/linux/page-flags.h:226 [inline]
> pc : page_slab mm/slab.h:159 [inline]
> pc : virt_to_slab mm/slab.h:193 [inline]
> pc : qlink_to_cache mm/kasan/quarantine.c:131 [inline]
> pc : qlist_free_all+0x68/0x120 mm/kasan/quarantine.c:176
> lr : virt_to_phys arch/arm64/include/asm/memory.h:369 [inline]
> lr : virt_to_pfn arch/arm64/include/asm/memory.h:383 [inline]
> lr : virt_to_slab mm/slab.h:193 [inline]
> lr : qlink_to_cache mm/kasan/quarantine.c:131 [inline]
> lr : qlist_free_all+0x58/0x120 mm/kasan/quarantine.c:176
> sp : ffff8000997e72e0
> x29: ffff8000997e72e0 x28: ffff800088b0b6a0 x27: ffff0000c7228000
> x26: 17ffffe791001021 x25: 0000000000000204 x24: ffffc1ffc0000000
> x23: ffff80008869e000 x22: 17ffffe791001021 x21: ffffff1000040000
> x20: 0000000000000000 x19: ffff8000997e7330 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000002 x9 : 0000000000000000
> x8 : 005fffff638e0040 x7 : ffff80008048e080 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000802f8070
> x2 : 0000000100000000 x1 : ffff0000c7228000 x0 : 18007fe923801021
> Call trace:
>  virt_to_slab mm/slab.h:193 [inline] (P)
>  qlink_to_cache mm/kasan/quarantine.c:131 [inline] (P)
>  qlist_free_all+0x68/0x120 mm/kasan/quarantine.c:176 (P)
>  kasan_quarantine_reduce+0x118/0x124 mm/kasan/quarantine.c:286
>  __kasan_kmalloc+0x2c/0xb4 mm/kasan/common.c:406
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __do_kmalloc_node mm/slub.c:5334 [inline]
>  __kmalloc_node_track_caller_noprof+0x434/0x6d4 mm/slub.c:5471
>  kmalloc_reserve+0x118/0x214 net/core/skbuff.c:637
>  __alloc_skb+0x230/0x610 net/core/skbuff.c:715
>  alloc_skb include/linux/skbuff.h:1384 [inline]
>  alloc_skb_with_frags+0xb8/0x690 net/core/skbuff.c:6769
>  sock_alloc_send_pskb+0x740/0x850 net/core/sock.c:3013
>  unix_dgram_sendmsg+0x434/0x1078 net/unix/af_unix.c:2136
>  unix_seqpacket_sendmsg+0x108/0x1d0 net/unix/af_unix.c:2537
>  sock_sendmsg_nosec net/socket.c:775 [inline]
>  __sock_sendmsg+0xc8/0x17c net/socket.c:790
>  sock_write_iter+0x220/0x310 net/socket.c:1241
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x51c/0xa0c fs/read_write.c:687
>  ksys_write+0x12c/0x228 fs/read_write.c:739
>  __do_sys_write fs/read_write.c:750 [inline]
>  __se_sys_write fs/read_write.c:747 [inline]
>  __arm64_sys_write+0x84/0x98 fs/read_write.c:747
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
>  do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
>  el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
>  el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
> Code: d346fc08 927acd08 cb151908 8b180108 (f9400509)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   d346fc08        lsr     x8, x0, #6
>    4:   927acd08        and     x8, x8, #0x3ffffffffffffc0
>    8:   cb151908        sub     x8, x8, x21, lsl #6
>    c:   8b180108        add     x8, x8, x24
> * 10:   f9400509        ldr     x9, [x8, #8] <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
