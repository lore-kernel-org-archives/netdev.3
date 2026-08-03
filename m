Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3CDDCD
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718467; cv=pass; b=TTpuJH8miPEZvW1/Z61RT8lVWw1syIWP7d13CcjCFjyq9oOGCeraowI+4yyl+nTeuLmXAi8pr9SaDAi/v0wJMArj8iuoLO0YKNv25Yg1M7vhO0IlG1M/Ymgqx425t8W+SCiFmA97ePU5H3yZlzr3/VxqIGLQji9x4PzawRjCNyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718467; c=relaxed/simple;
	bh=Cl/9SDXR+ysjYiTWTqvXN36c0wmYDyvpCEoz+599mHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlQUvebYFHQ6kX1i76mmeTUDDSrgqZPPUwaEKI+OSGhUzE9unUTIBiTflFtr/q5qYD75efdFGxp1LwbyNkMjKWeJjWKYltBRqii5OA6DkgahbecTmqA7uzC2pLhv/RB2kRsiAYgcsMoDgg3WtLe5E1W2uN8jOQQBkj5CCZhP0Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEUUbZll; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEUUbZll"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39f1ac13687so18991341fa.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 17:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785718464; cv=none;
        d=google.com; s=arc-20260327;
        b=rBTr9r6TnDsfjoY90hEUVw6K7ZZIHrpqJGvfPDNMdwHxao40zonJPiOG56MPsWwJRx
         OlIB9gy0p3gyQywWcnvqbo/6CLlkLw9GF9PWS0etFljx1AXzW+K8UioZbTPqAGpWoITu
         YOdqlI7+6rOGjdBe1wCZiGoani6fVE5jl8DO1d3DnyuhtaaVPOrg86w+sQznUI+EE7bR
         +RcTIZZ5+2o8bGFp9RoaA75vTj2Jc7TbuXAs0+YcRDWrX/CmlYQS9L2BG71WdGw84Iry
         M5lUl0Djj9xj7WhocPDWst55Qp6pgDULnyk5nOpLZs8zub3iUYf4z3r0BhVI7K8D+gez
         buDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z2jXJWJb6SbJMaX56thk8HZJd59Gxv6BPpFYZqg5RcM=;
        fh=lngdXU97SqSOXszDRmobXIlkB7huzUfT7FaABPK8dPk=;
        b=rpKuHeSaCb5ge1q45uuBA1EJu9A8ZxFTdahaTkluXQX65u9vUksD9D2IM1vSCUv1HE
         HwlaUMmCmQUsn9GzlsrQuOPKCjQYlHGspUPR7Ojb1AtesoUOHvYQobDGQ2R7jIML1wrH
         8patQdG/yGF0BRc3Gk43BWOBYgRkSfdUVKvUseiqMGkhKeSW7rhXGDsekxNB/3swheLM
         GLO1izCoKxA+Ch40+I9IKr71DV0JZMfNN8ZSo7GXzbitXK8FqvZy6oObB+Vr2/pzXejo
         dGm8j9lTXlvRgnyGwwyMOx5+3McOU6m89La3G57iebNxTPP+f7OiNDnLMlQpo1lT6c9C
         Q17A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785718464; x=1786323264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z2jXJWJb6SbJMaX56thk8HZJd59Gxv6BPpFYZqg5RcM=;
        b=HEUUbZll4nZlRn14ONLmPb+YohkrcRrXr/TmnVl2qkZ5gJK+/PK3Nf/mN4lAtw51T8
         u4DiaVzAPImu0rOC/pp0fzE4QiURmw9eMry000k2+VkvIZJFz/tmYknaXPDkrNyu0Yd9
         kTmWcQaiODKrap0Hh5alLvOxNOUtw/juUYE30DyzX0KsX4p0p+uJlGAjznqRgVWVjAHE
         k+foKSrg8bm3A0hVlNmVSOVfsjBcaCYdxH7Hmk2RZDrQId5TjE0cbJzNmq0iGA4Mfudb
         Iv79tx51zISLM+s/79AOLGk8KuQdpOnn90C1qfqckgmjI8/vWlrjDzlyQOHHPIeYA8cQ
         objw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785718464; x=1786323264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2jXJWJb6SbJMaX56thk8HZJd59Gxv6BPpFYZqg5RcM=;
        b=VuU0vCogg5Bx7B7QzFFxrhzkwxgdiSZ/xCUK34ZgY9/HTszogwbVtu0txUjxowGZLr
         YBttakQBzGotRy5PGEg4M4yJ69W1sHNUOZOa2aVF1nXcpwCRpxM+u8s4I72sv93GMELy
         Fq6nmkoO23FNSz2MjfnRJO0YoPeXooHfeTwdOtn9fPHiL5Q3v1w32/til/W9v6ZrNHx1
         6Idm7qmOZUgZVTCjk/M2V79AOeDiSHh+sz6pb2V7C+1GsA987B+y7+H1nkKrWhvKTQuZ
         jiKyqmXNNB1F+AtU/1tWTeQ/Wq1ur8Orelcoqd6I1Y9Dy/pvtvbMlfigYSBFki9jJNH5
         MlXA==
X-Forwarded-Encrypted: i=1; AHgh+Rrdn2W/pn2mGPVxLKk71PhkoDYGalkcU1CXqnNRvxmRHBvxnVtaYAXjZjgETz5DAGoF31KTQjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbGEYGs0YRQCDjC+llljGUYdKGP7LnECm96hy9SHgco3F3xoX
	ecNI8+7kv4tFPKHp2ZMvKpCGqO0LHltsYQsEPRYcanvYAk9iJvGXqS3k8liLmk1JQkZOoyx20VA
	wNOnR08QlQZy1f5qTRzInRWJQkBFyGc4=
X-Gm-Gg: AR+sD10zV/93fAcgPrupUW0WvjIJf08ctjgHZruntWdMGiOvtICfVQLV7qmHSVeZE2u
	X4fkJfdREex5aCPVmq+fmGgjyeBdDmV0KJZdj6uomym0yNqO5KuiYiFemY2FLeqC5BNnU9NUiBN
	HIF/ZzoslrQfVGrfmmcACTHJgQW/C8ahxO9DEcnLPPNEcpqbc/nNgfQ71cFbNb4StK/SUb/4J3M
	QvGzhR4SsUOoS+zwzvNpC4jT0/KtKIEdtK2F2ArDoU0pecw4x20dz/HjMs9D15l86Qi4RIWLGoS
	Yvb6bSkybIqA73T2Llp6xsxdh1iVcnpL/mzd+RzdB/qciE+kxcZRxIao+84Jb8mX0LVrD+OwSyu
	6diKIc2xZW+GK38MA90QribcLTK8cpWFOa8WK3S85qTrwHgLnWFibmMu1Yg==
X-Received: by 2002:a2e:a801:0:b0:39b:4371:dbeb with SMTP id
 38308e7fff4ca-39f86457697mr16568411fa.36.1785718463325; Sun, 02 Aug 2026
 17:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com>
In-Reply-To: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Aug 2026 08:53:44 +0800
X-Gm-Features: AUfX_mx6sLoNypGbclO3rkosqFkVVJ3wA5Y_ZsuQm6s74xXl9avjRxEOiPdqqEc
Message-ID: <CAL+tcoAhr_E6d61K34f0CyVaVWRD5os3hdqv20bwHv7YTkd0Jg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in ipgre_xmit (2)
To: syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 2:50=E2=80=AFAM syzbot
<syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fc02acf6ac0c Merge tag 'platform-drivers-x86-v7.2-4' of g=
i..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1314d63258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc05be6c9b0d36=
cb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f639=
94eec
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e25=
5-1~exp1~20260613092250.77), Debian LLD 22.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-fc02acf6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a67a14a03b39/vmlinu=
x-fc02acf6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/328affe48b77/b=
zImage-fc02acf6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> len > ((int)(~0U >> 1))
> WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason include/li=
nux/skbuff.h:2864 [inline], CPU#0: syz.0.0/5325
> WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reason in=
clude/linux/skbuff.h:3265 [inline], CPU#0: syz.0.0/5325
> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull_reason inclu=
de/net/ip_tunnels.h:481 [inline], CPU#0: syz.0.0/5325
> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull include/net/=
ip_tunnels.h:486 [inline], CPU#0: syz.0.0/5325
> WARNING: ./include/linux/skbuff.h:2864 at ipgre_xmit+0x958/0xcd0 net/ipv4=
/ip_gre.c:658, CPU#0: syz.0.0/5325
> Modules linked in:
> CPU: 0 UID: 0 PID: 5325 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(fu=
ll)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
> RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inlin=
e]
> RIP: 0010:pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline]
> RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline]
> RIP: 0010:ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658

Ipgre is not the only one which is affected in this case. Essentially
all the affected xxx_xmit() calls pskb_inet_may_pull() that gets a
negative value when using skb_network_offset(). The result in this
case should be zero.

The commit 3914d88f7608 ("xsk: Respect device's headroom and tailroom
on generic xmit path") introduces skb_reserve() which makes 'skb->data
+=3D len;' and then result in the inconsistency in skb_network_offset().

The plan is to reset the header after skb_reserve:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index XXXXXXX..XXXXXXX 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1025,6 +1025,7 @@ static struct sk_buff
*xsk_build_skb_zerocopy(struct xdp_sock *xs,
  return ERR_PTR(err);

  skb_reserve(skb, hr);
+ skb_reset_network_header(skb);
  if (desc->options & XDP_TX_METADATA) {
  err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);
  if (unlikely(err)) {
@@ -1110,6 +1111,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,

  skb_reserve(skb, hr);
  skb_put(skb, len);
+ skb_reset_network_header(skb);

  err =3D skb_store_bits(skb, 0, buffer, len);
  if (unlikely(err))
--=20
2.39.5

As syzbot said, I cannot have a reproducer to test/verify it.

Thanks,
Jason

> Code: 48 3b 84 24 80 00 00 00 0f 85 3b 01 00 00 31 c0 48 8d 65 d8 5b 41 5=
c 41 5d 41 5e 41 5f 5d e9 3f e9 77 01 cc e8 e9 05 69 f7 90 <0f> 0b 90 e9 08=
 f8 ff ff 44 89 ff 44 89 e6 e8 95 07 69 f7 45 39 e7
> RSP: 0018:ffffc9000e4cf600 EFLAGS: 00010283
> RAX: ffffffff8a5e0e67 RBX: 0000000000000000 RCX: 0000000000100000
> RDX: ffffc9000eef2000 RSI: 00000000000000bb RDI: 00000000000000bc
> RBP: ffffc9000e4cf6d0 R08: ffff888035d20000 R09: 0000000000000002
> R10: 0000000000004888 R11: ffffffff8a5e0510 R12: ffff88801244e000
> R13: dffffc0000000000 R14: ffff888043f173c0 R15: 00000000ffffff40
> FS:  00007f99c17006c0(0000) GS:ffff88808c543000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f99c0a12a18 CR3: 0000000042b19000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5409 [inline]
>  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
>  __xsk_generic_xmit net/xdp/xsk.c:1079 [inline]
>  xsk_generic_xmit+0x277a/0x40a0 net/xdp/xsk.c:1120
>  __xsk_sendmsg net/xdp/xsk.c:1174 [inline]
>  xsk_sendmsg+0x482/0x810 net/xdp/xsk.c:1184
>  sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
>  __sock_sendmsg net/socket.c:790 [inline]
>  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
>  __sys_sendmsg net/socket.c:2770 [inline]
>  __do_sys_sendmsg net/socket.c:2775 [inline]
>  __se_sys_sendmsg net/socket.c:2773 [inline]
>  __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f99c079de99
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f99c16fffe8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f99c0a25fa0 RCX: 00007f99c079de99
> RDX: 0000000000000040 RSI: 0000200000000700 RDI: 0000000000000006
> RBP: 00007f99c0833eaf R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f99c0a26038 R14: 00007f99c0a25fa0 R15: 00007ffdd0e42b38
>  </TASK>
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
>
