Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E440429CD7
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454051; cv=pass; b=DNKBW5wSOgiCCo2j+dkAH5CmpqZ1ce8CBldLgDHBPHA8E9+9rNQcQWTLeaaQpZzK3l9h60l7YNbb3xVooHHrxGkCJ3FjJUQVBI+roS2eZ+G6fs9OoPX05PPBQx+e1bBUMQtJEkxGz5VNiUezIpLwwsUOHYxNvvltwe93jZ+36WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454051; c=relaxed/simple;
	bh=+wJhGGE6Ofr87YiUX/g/lcp4cYHEHnNXr0BqFqEUYh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOVnCXYudy87zTefPUtMoxDX529H00GMUXLiMUhOPwaKeSGjLdRWv6BiSzofDftUfefAHgFQZRa3Coi6B2Dzo3I0e0G37sXDUZLgLjNaBFXZvvXIET/XLfkxMh9i257R0I9+sIlThS8kJVYDEv43itIKuAz0115UsXDPmFwFrM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnpo5m0W; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnpo5m0W"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so2725898e87.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786454048; cv=none;
        d=google.com; s=arc-20260327;
        b=A9TzIqaI479g0tWWTpYLu8eVYuKFNd7+l8tU1K9y4F60R7g0VuKAVfJ1aqYSF9piwk
         C8628ciUuY+9ioCAI0gXgJeaSaSNJMmjnfOajEcSY5SokgSQ1uyH4oQPPIhn1XLNEk+C
         oRd0gC5rS3L2v2StWqcchoZnWwLtUiEZVtZyeXNWAmthXccul4Vuh7E0Cf/Xl/7O032+
         TmbCdQlUZtYLEyglHZgkiG8sERcKLgRNDW8Azn5FebISa/h4ZrRFCZIXQDNsj2dGq4EM
         +/ZY8CmtCG0MlKGdsVQrVM9dHWlRXn4pTKGgUrfJH8JHPzVp3mqofzL2wTR0zVA4itXq
         7PWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qMZQy1cvjS9sDCMZqNdS45Zs+G7/v1+q5pSxvhTnHT0=;
        fh=vfmZnaG98N+WAA/1LuYob3M4xfAsPTCQ8+1FPwzkoEI=;
        b=lL2+NKZPUlqcKo8S9fH//CNyiQ6zh38CzopaxJqnFt2P75U7+7xay/aAT6KuHGJnfi
         TZu/ow+db6+qdFObgWPQO0zJc7gab7BATYORVjYylEEhHMXlBLDqDXvaCnvdREDneVxq
         OKboixq5OGmuFJjimU7Y8uCmrBkaJvDuwO4gv3jVeBj8FluTvq26JlmkBTET9+k9yI4c
         tlR/cnm6tTheziIo+N9dy66/EEY6CoFUv7ctvOXsV2xjow9+sWGZdh+LV64lSNzLK07k
         wjgm8zkgj6mzmuodVexRAarl65Zvb/uobog745EqITEq0lN4sWoCRdE+V4zDHyqUpeAG
         CfHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454048; x=1787058848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qMZQy1cvjS9sDCMZqNdS45Zs+G7/v1+q5pSxvhTnHT0=;
        b=Qnpo5m0WRu/KtBxV426PeVULXSKLv9+UCDNf6IEXndnpeCG/nKV02wCVe19is3P8cc
         KRHwNlUV+BgjiksUtRkIWPaypjgAn8W8yywm0J6+3TDQtWwhQl/84pocXNgZDLOWMGHG
         8ctlQuW7FRRmxYhNMNrKObCqecoTymEz7kPiQAr0RDoeeyJE0Tf+0pQpB95R/QaZTni1
         CiyCQoPXrJmfX75I5y3xMT3cEyBJL29AVIqxcSqfelCuDkwzyk6mdjYsTyL4dhWYpbmJ
         poHQ3HOpSQZvHB/amA0dtS71RQuHb9UiuaE43rz7q2rpi1/4Ap3G7FijNoMhFZfcwJGM
         crGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454048; x=1787058848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMZQy1cvjS9sDCMZqNdS45Zs+G7/v1+q5pSxvhTnHT0=;
        b=nA4m+8edp1F3enNcMydPyELoSzLkJZrf1G2B7oQzcziX+F4QSqpgDs3M36mdQQpwZ6
         RFPLQ6pYzfboxeAAm6lP/hl3gDztzle9BU8cpA4pqe0Mv36HKueY1icoR35VwjUKoR6k
         vSLNF2Ou6bkg2OiR5Bgagz3z05sXafaXUfmr/bx526hkqDEa108nfK3n2PUbp/v8o2Q7
         6cwduAN76mIIU4r7cC1JIvtrqch+sz2Rgn2d2iniopS2k2ar+8cuv9IX6qxxWUYkqF5S
         Uej0/3t4R6PjSaZOAUScOJW4UXFOJ67VP7VG1DSEomH+azIf3aAReIM9kyThVKdtm0Mw
         YAQg==
X-Forwarded-Encrypted: i=1; AHgh+RrpbDZtrr8b782Gcc+mz8AVbwPXAiPlDPGfbwd1vLqKy8vDctx5WZcLWtnGlCT6qsF+PY6aDUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWYmXUF0oOhc2xd0hcPaldpvOSiwBlvc8NVa/73GRCfFWopiE
	zPzCkSX9ctX4Bs8DYaQs2ZpoaaafxUmMMoM2txvgF7q5bO/wmVjTQCeOELm6DLwfWF6M2IxZH5O
	NxDfaNlosFHAtxgijgTKiu125/U6oc/mk+g23HT0=
X-Gm-Gg: AR+sD13B0JNp/mmCbbQ8XnLzuEdLuQk7lyCkgH4F08sJ+Ou0XWju7p702C13ckk/qO0
	oB56w35W9a4OQS5QSDOpL/nLFo4jCbJtzGYnS9Mq520oDy0kuZmp/9Yhu0TzOxZ9F3ArG7lCslf
	fwwpG1I9+YcmLlYL1Eal+RWfYxsvq2xLoErUficuGBAoLsU5SkUmsNssTdp2JWDuWt6kpGaMBy6
	tBJcsxa4IWQGeYAfrMVzkw9pal7x54rXpINf9x5fEGIZ9XwglsU4dEyD7+I4LcuP1D9qXtrtY7/
	doUEhIqzcdHrZLOCoZq4mXd1aqReo1o7EfadsURua/cn05gxvp9A+CF99Xrc+L9DxD9aTdn96rt
	gvUYhP7MiaoU4zNuKpjL1tR7fUgmWT42zLO4io8RyOqgpVH970Q5HZpkPhw==
X-Received: by 2002:a05:6512:1281:b0:5b2:a21a:10e7 with SMTP id
 2adb3069b0e04-5b448643942mr461840e87.25.1786454047217; Tue, 11 Aug 2026
 06:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com> <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
 <CAL+tcoAR9WTmrFiM0GtWhtvgWX467vAD9fRRJ-Hds9Q346EB=w@mail.gmail.com> <94a00de5-6293-42bd-b7bc-5370ea16a3e3@redhat.com>
In-Reply-To: <94a00de5-6293-42bd-b7bc-5370ea16a3e3@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Aug 2026 21:13:29 +0800
X-Gm-Features: AUfX_myGMzHA9Hi_AWQ8r1y_fryVCTGg3618rmo8LiH5atw4KoNQvmtjlJAGpP4
Message-ID: <CAL+tcoDxLv8N+6n6NUkN6r-GtNvT4bWYCpZo1XkBjr2a_Qz+gg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in ipgre_xmit (2)
To: Paolo Abeni <pabeni@redhat.com>
Cc: syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 6:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/9/26 8:03 AM, Jason Xing wrote:
> > On Wed, Aug 5, 2026 at 1:05=E2=80=AFAM syzbot
> > <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com> wrote:
> >>
> >> syzbot has found a reproducer for the following issue on:
> >>
> >> HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://g=
it.k..
> >> git tree:       upstream
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D178fb64958=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e38b15c29=
e6a1d9
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f=
63994eec
> >> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6=
e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1617be32=
580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11d113b958=
0000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/4949138dcfef/=
disk-848acc8f.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/31cc6fbe5b8a/vml=
inux-848acc8f.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/433919ca652=
0/bzImage-848acc8f.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
> >>
> >> ------------[ cut here ]------------
> >> len > ((int)(~0U >> 1))
> >> WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason include=
/linux/skbuff.h:2864 [inline], CPU#1: syz-executor147/5638
> >> WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reason=
 include/linux/skbuff.h:3265 [inline], CPU#1: syz-executor147/5638
> >> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull_reason in=
clude/net/ip_tunnels.h:481 [inline], CPU#1: syz-executor147/5638
> >> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull include/n=
et/ip_tunnels.h:486 [inline], CPU#1: syz-executor147/5638
> >> WARNING: ./include/linux/skbuff.h:2864 at ipgre_xmit+0x958/0xcd0 net/i=
pv4/ip_gre.c:658, CPU#1: syz-executor147/5638
> >> Modules linked in:
> >> CPU: 1 UID: 0 PID: 5638 Comm: syz-executor147 Not tainted syzkaller #0=
 PREEMPT(full)
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 07/24/2026
> >> RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
> >> RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3265 [in=
line]
> >> RIP: 0010:pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inli=
ne]
> >> RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline]
> >> RIP: 0010:ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
> >> Code: 48 3b 84 24 80 00 00 00 0f 85 3b 01 00 00 31 c0 48 8d 65 d8 5b 4=
1 5c 41 5d 41 5e 41 5f 5d e9 3f 1a 78 01 cc e8 09 f5 6a f7 90 <0f> 0b 90 e9=
 08 f8 ff ff 44 89 ff 44 89 e6 e8 b5 f6 6a f7 45 39 e7
> >> RSP: 0018:ffffc900039af5e0 EFLAGS: 00010293
> >> RAX: ffffffff8a5c1d67 RBX: 0000000000000000 RCX: ffff888079535d00
> >> RDX: 0000000000000000 RSI: 00000000ffffff40 RDI: 0000000000000000
> >> RBP: ffffc900039af6b0 R08: ffff888079535d00 R09: 0000000000000002
> >> R10: 0000000000004888 R11: ffffffff8a5c1410 R12: ffff88807ecbc000
> >> R13: dffffc0000000000 R14: ffff88807b7f2780 R15: 00000000ffffff40
> >> FS:  0000555590a0a400(0000) GS:ffff88812504b000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 000055704428ded0 CR3: 00000000788f2000 CR4: 00000000003526f0
> >> Call Trace:
> >>  <TASK>
> >>  __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
> >>  netdev_start_xmit include/linux/netdevice.h:5409 [inline]
> >>  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
> >>  __xsk_generic_xmit net/xdp/xsk.c:1253 [inline]
> >>  xsk_generic_xmit+0x2759/0x47b0 net/xdp/xsk.c:1309
> >>  __xsk_sendmsg net/xdp/xsk.c:1363 [inline]
> >>  xsk_sendmsg+0x482/0x810 net/xdp/xsk.c:1373
> >>  sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
> >>  __sock_sendmsg net/socket.c:790 [inline]
> >>  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
> >>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
> >>  __sys_sendmsg net/socket.c:2770 [inline]
> >>  __do_sys_sendmsg net/socket.c:2775 [inline]
> >>  __se_sys_sendmsg net/socket.c:2773 [inline]
> >>  __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
> >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> RIP: 0033:0x7fc137b1b409
> >> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 8=
9 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0=
 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007fffc9ef46d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> >> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc137b1b409
> >> RDX: 0000000000000040 RSI: 0000200000000700 RDI: 0000000000000003
> >> RBP: 0000000000000000 R08: 0000000080000000 R09: 0000000080000000
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
> >>  </TASK>
> >>
> >>
> >> ---
> >> If you want syzbot to run the reproducer, reply with:
> >> #syz test: git://repo/address.git branch-or-commit-hash
> >> If you attach or paste a git patch, syzbot will apply it before testin=
g.
> >>
> >
> > Please try this one instead. I'm not sure if the previous patch has
> > the index problem...
> >
> > But the following patch can be applied in my tree.
> >
> > #syz test
>
> Please, do not cc the netdev ML for syzbot test patches. They may foul
> PW and the KCI.

I see. Sorry for that.

But one more thing I have to ask is why the second attempt failed
since I see no output from syzbot.

Thanks,
Jason
