Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDED381E9C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503128; cv=pass; b=Jekd/3EZVMyFyPRBOUankeaKnKmTejNVLALFw5j52irpDKgklIcM12562DjRoWnyM+6WSUh9H44DgLswSNusfecYlML59qPRi9/d9zfLJUcTT32G/migeME0tqkaM+1A07bxA1ZD9L3VN+qm/ySe9Ei5qOhUW639kMLhaJT4Ru8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503128; c=relaxed/simple;
	bh=Hb0oTZyNs2XNF8FYvwdiByW6WbpnUx0y3XGgr92vMsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/YHTS8wntsZak+dMfz17SSQ1Orl2B06pWWWjEmP7OOsmwM+PqcOGGBqtwbS1Fc3SQa0OLDOXOdY81OgkTCrUsdUNUdUr8q7BPr2ubOhrUAA17RZumzZRj4HuUlev+W+qgKPGsQho76kOFPoee4UiNPs318C+/gZDN8yqwkoa/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqYofKhZ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqYofKhZ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aec6360133so370875e87.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786503125; cv=none;
        d=google.com; s=arc-20260327;
        b=PHRsXyFyYKJS1NgueQ1IQWO8unDRiTfSEZulEbhMyJeoSbouTUs9KZeN6xTygDvy+b
         bS5X1qgZz9cCWwLuHU1jC9hUc2lhMUTQYmXKf43qwkkX4WGxIZIN9gZta8z1kv7l74j6
         A62qofTibp1e/0gIoZXFiyeoLfRYRn08hmYO5v1fvBI3Y+mhf67jhw7d+Zr9yT6MyEyr
         IxEUJ0Es7tZ8tYMyXRAZ71WLLweIA7soOIOdxR/dDtp0yJTg9Q+Nku5UeZFj0poeYGy4
         tq2GYHzfqddDJ6HRAo2p76Vwyc952u2mM29tjjwPrm2sqDLVYWf4LvCNa0Lg1fUWvFlI
         DFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XSzC2/gCgnszKPTbShHtlIGN1+pKUMruFRT6YmrOrr8=;
        fh=FQGI6CJqlAVbU4+Vh/Cx9lsafOgDsCkRyeXekW6bcQI=;
        b=rX+tgyb8gF3eJrAn1K1V3oS5Bmyn6XO+tRhDdIRtBnfBtfOrrdWO/yLGX7RDcCUMgE
         0/lc2ZN3Bs7A8/XcK3QtO6qTnPImNdMDwNR+ad0OUtAE+msz1Lu8T2PobEJatXE4tFNE
         i5wX13gqu5gl5a7ZOH53sxKl9AuQW0LZRHexOqO+uACt56ajg6t0cTHHALnz2rvUCWUJ
         dDg03p9fSNCFbQczFy4NazWF0Q0M7yGkqaAVrMx8s3L45rK/5IRAXQTAEnMcPzas+Vg+
         YmoEAkwHiV7U6YyOyvDOnu5M5P0uGj44pm8JNSw30PE3/rcfz/h0oLVvZp627SUtGuze
         T3Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786503125; x=1787107925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XSzC2/gCgnszKPTbShHtlIGN1+pKUMruFRT6YmrOrr8=;
        b=SqYofKhZQLDpjK7C99XDAAPY3dZhsG4Ax8bSQnhBksiebSK49pAFjvcfgixzB1DudY
         vogc9ITiEhgwH99cIJOOWTMczkYxAHCs1vmgNK+8LXrDYh2ekvw+Rxieop5/VNf4Wec/
         JYuMjjs+jO81Gw+mSBe17LfBANEOTBb6T7Hx2TcZtsS+Eil1EcIwQrDjBTFwFbx1Gi9e
         CFJqlOfZP9IZkkgDbAMAXYiSMVb2YH4oxYAe5US03lma9s3mbog+S2qimYJNN3/5kD+F
         45TCH5Nd5qeSb2xujfCjxEvqnmMBT7rXX2IwfI0iWJW9ZxP2Z0cjbOn8XWCoNQcvJxJt
         zBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786503125; x=1787107925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSzC2/gCgnszKPTbShHtlIGN1+pKUMruFRT6YmrOrr8=;
        b=lmdE4PLkKaKQrFzljD4m9ehSuIWrJg1Z3d6cOvu+Avgv4JwFqD3q7SlSTtZOhjg3xr
         VdX1hfcvcvCYzlxn3h73Cot6X+n5ayKZ+RJLveeHTDENqqxVCnvvoMhhFd+Ix6L/F49V
         FBbsGbhyjW6rTy1rB/h5FzgHGnbBE2xgzKOZbxgvAQnDAgT9+jGyHCjP5R0e6DlVg1Yy
         Hy6pcx8CHbIXRAnJ01GPzgRyMQYWt0e6lJ1GDv0VRIEJl1ScaWmTDTo7oE87nIPeBXpS
         G313HrVkTT8Y2PDl55sAT0N/Ug5v+KNdYq2KXHsmXcdFsvHW9qQiJoQAXKltNIGx7++Q
         YyfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSkCEeAcsHV3o+O+sCcF/mX/0+NxSuH5jNspug9OygRfpfWHGwQJYl/9b+Y0Xb29sNg3HyQkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRl4Xzv/9Soyefq9+JTBBlYYxCDOgCEgGwWZCt/JlxV43QzoHK
	lOyztOhCTyITAGEpSYZ9LEATY1YW1oZQrBvLJ1hqwyL+9z6+lK+yC8vRdjuQhXLDKktjumidzIu
	km5zd2GXuI3UiTbUpn2b1gCeni+0lICw=
X-Gm-Gg: AR+sD12vxR4afPgw82MtTzMAM4TVniy4fFogpfu7zyhTPXlTjJi+if2cpQ3u1OoOOSO
	A0zGYXaGtE2Ynjp/W00LETkb+25i5qWrJnA2f+c2PS2UfUaW8e5NLAOTyV8KM36DmGhM7EooVWO
	szw/vBY8jLuQ6pKxD4VvOcT/Leur+Zigl6vE2Po1h/O4P/A5WQnoCZ853mqp2vFEC/LIVb+z/IB
	pQbRJpr721K4Fd9yp6tSmkG+Uos5o8vExhz8ARKdn+rPm/YnWutCd8XwOWoLjHs/VJkc57qqe56
	RzChrQFVIfFp8BZiZCABGqvxn17RAlBd4kQJIH01akia6qnAC/dpOIeX+GOvv740crUcT7xjBNZ
	n1cE/ISCQiJFf+LheWne653DnI2P6jZ2xnGPpgzHChtyckrNDgqeLFqhgptJ/TVfw
X-Received: by 2002:a05:6512:1384:b0:5b1:537b:de9b with SMTP id
 2adb3069b0e04-5b44e2ee1f6mr254351e87.19.1786503124448; Tue, 11 Aug 2026
 19:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com> <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
 <CAL+tcoAR9WTmrFiM0GtWhtvgWX467vAD9fRRJ-Hds9Q346EB=w@mail.gmail.com>
 <94a00de5-6293-42bd-b7bc-5370ea16a3e3@redhat.com> <CAL+tcoDxLv8N+6n6NUkN6r-GtNvT4bWYCpZo1XkBjr2a_Qz+gg@mail.gmail.com>
 <21d4d5ed-572f-4e82-818f-78b50155390f@redhat.com>
In-Reply-To: <21d4d5ed-572f-4e82-818f-78b50155390f@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Aug 2026 10:51:25 +0800
X-Gm-Features: AUfX_mzo6Ofm1XvORKS3lY3MllzkgWFiYv6a06XdFwhBu1ssQ_vWz1Xus8QPYJQ
Message-ID: <CAL+tcoC-O6JjWOPi5wC+2R648avj64YYzQi9o2GVZGhzKvZjJg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in ipgre_xmit (2)
To: Paolo Abeni <pabeni@redhat.com>
Cc: syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/11/26 3:13 PM, Jason Xing wrote:
> > On Mon, Aug 10, 2026 at 6:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 8/9/26 8:03 AM, Jason Xing wrote:
> >>> On Wed, Aug 5, 2026 at 1:05=E2=80=AFAM syzbot
> >>> <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com> wrote:
> >>>>
> >>>> syzbot has found a reproducer for the following issue on:
> >>>>
> >>>> HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git:/=
/git.k..
> >>>> git tree:       upstream
> >>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D178fb649=
580000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e38b15c=
29e6a1d9
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c=
9f63994eec
> >>>> compiler:       Debian clang version 22.1.8 (++20260613092233+e80bed=
a6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> >>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1617be=
32580000
> >>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11d113b9=
580000
> >>>>
> >>>> Downloadable assets:
> >>>> disk image: https://storage.googleapis.com/syzbot-assets/4949138dcfe=
f/disk-848acc8f.raw.xz
> >>>> vmlinux: https://storage.googleapis.com/syzbot-assets/31cc6fbe5b8a/v=
mlinux-848acc8f.xz
> >>>> kernel image: https://storage.googleapis.com/syzbot-assets/433919ca6=
520/bzImage-848acc8f.xz
> >>>>
> >>>> IMPORTANT: if you fix the issue, please add the following tag to the=
 commit:
> >>>> Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
> >>>>
> >>>> ------------[ cut here ]------------
> >>>> len > ((int)(~0U >> 1))
> >>>> WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason inclu=
de/linux/skbuff.h:2864 [inline], CPU#1: syz-executor147/5638
> >>>> WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reas=
on include/linux/skbuff.h:3265 [inline], CPU#1: syz-executor147/5638
> >>>> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull_reason =
include/net/ip_tunnels.h:481 [inline], CPU#1: syz-executor147/5638
> >>>> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull include=
/net/ip_tunnels.h:486 [inline], CPU#1: syz-executor147/5638
> >>>> WARNING: ./include/linux/skbuff.h:2864 at ipgre_xmit+0x958/0xcd0 net=
/ipv4/ip_gre.c:658, CPU#1: syz-executor147/5638
> >>>> Modules linked in:
> >>>> CPU: 1 UID: 0 PID: 5638 Comm: syz-executor147 Not tainted syzkaller =
#0 PREEMPT(full)
> >>>> Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 07/24/2026
> >>>> RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
> >>>> RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3265 [=
inline]
> >>>> RIP: 0010:pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [in=
line]
> >>>> RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline]
> >>>> RIP: 0010:ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
> >>>> Code: 48 3b 84 24 80 00 00 00 0f 85 3b 01 00 00 31 c0 48 8d 65 d8 5b=
 41 5c 41 5d 41 5e 41 5f 5d e9 3f 1a 78 01 cc e8 09 f5 6a f7 90 <0f> 0b 90 =
e9 08 f8 ff ff 44 89 ff 44 89 e6 e8 b5 f6 6a f7 45 39 e7
> >>>> RSP: 0018:ffffc900039af5e0 EFLAGS: 00010293
> >>>> RAX: ffffffff8a5c1d67 RBX: 0000000000000000 RCX: ffff888079535d00
> >>>> RDX: 0000000000000000 RSI: 00000000ffffff40 RDI: 0000000000000000
> >>>> RBP: ffffc900039af6b0 R08: ffff888079535d00 R09: 0000000000000002
> >>>> R10: 0000000000004888 R11: ffffffff8a5c1410 R12: ffff88807ecbc000
> >>>> R13: dffffc0000000000 R14: ffff88807b7f2780 R15: 00000000ffffff40
> >>>> FS:  0000555590a0a400(0000) GS:ffff88812504b000(0000) knlGS:00000000=
00000000
> >>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> CR2: 000055704428ded0 CR3: 00000000788f2000 CR4: 00000000003526f0
> >>>> Call Trace:
> >>>>  <TASK>
> >>>>  __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
> >>>>  netdev_start_xmit include/linux/netdevice.h:5409 [inline]
> >>>>  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
> >>>>  __xsk_generic_xmit net/xdp/xsk.c:1253 [inline]
> >>>>  xsk_generic_xmit+0x2759/0x47b0 net/xdp/xsk.c:1309
> >>>>  __xsk_sendmsg net/xdp/xsk.c:1363 [inline]
> >>>>  xsk_sendmsg+0x482/0x810 net/xdp/xsk.c:1373
> >>>>  sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
> >>>>  __sock_sendmsg net/socket.c:790 [inline]
> >>>>  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
> >>>>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
> >>>>  __sys_sendmsg net/socket.c:2770 [inline]
> >>>>  __do_sys_sendmsg net/socket.c:2775 [inline]
> >>>>  __se_sys_sendmsg net/socket.c:2773 [inline]
> >>>>  __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
> >>>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>>>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
> >>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>> RIP: 0033:0x7fc137b1b409
> >>>> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48=
 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> >>>> RSP: 002b:00007fffc9ef46d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000=
2e
> >>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc137b1b409
> >>>> RDX: 0000000000000040 RSI: 0000200000000700 RDI: 0000000000000003
> >>>> RBP: 0000000000000000 R08: 0000000080000000 R09: 0000000080000000
> >>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >>>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
> >>>>  </TASK>
> >>>>
> >>>>
> >>>> ---
> >>>> If you want syzbot to run the reproducer, reply with:
> >>>> #syz test: git://repo/address.git branch-or-commit-hash
> >>>> If you attach or paste a git patch, syzbot will apply it before test=
ing.
> >>>>
> >>>
> >>> Please try this one instead. I'm not sure if the previous patch has
> >>> the index problem...
> >>>
> >>> But the following patch can be applied in my tree.
> >>>
> >>> #syz test
> >>
> >> Please, do not cc the netdev ML for syzbot test patches. They may foul
> >> PW and the KCI.
> >
> > I see. Sorry for that.
> >
> > But one more thing I have to ask is why the second attempt failed
> > since I see no output from syzbot.
> ? I read:
>
> """
> failed to apply patch:
> error: corrupt patch at line 6
> """

That was from the first attempt.

>
> in last message from syzbot, and a similar one in reply to the previous
> attempt. You can use git format/git send-email even for syzbot tests, to
> avoid this kind of problems

I see, let me try this. Thanks!

>
> /P
>
