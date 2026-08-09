Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB431474CC
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786255460; cv=pass; b=Qg+rL/NKoGwtzxehao+fgdwBsuwm46uqZ21PgvS2rOYTJ3S3YKv4KHVrbabvwmCcYFBZSWj2qmx5x1ko13K9JSP4gPPT/+eh8EJKdt/mX1273zc4tBdzIhQQCydv8zyam+PBlLw2G4xD2dgrKF255SAWtaxmh0+fuIOWuYKoM00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786255460; c=relaxed/simple;
	bh=dWf4nXYq7rZrGZlPAy7sOiaNo63xaEFBvczUleUZ57c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkmRKxNF+cFyHEZPy6ZdnvpbVsiLvm72UCECGQpgmVpO+n+Kom1vq8cTrRdiJRNZmWllBbDSra4ywNuZ1wHyTvhkC6uYLym58YA9EkUkMmJFSzS2nJ4X1XtK3B5FZlVo5U1BS7+uNwHh8gMXIvX6yC6FnZBylwuoSU1c8+TaYKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Toz4LZ; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Toz4LZ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so5290421fa.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 23:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786255456; cv=none;
        d=google.com; s=arc-20260327;
        b=p0E98NO8Mbrj4wasNVj5wQeKJj4EqbHr6sOhBldGOb7ajXoDiCwJbNxvbU7tptgb6U
         3jZE5frTjbsllFws6hVoE5e0RgIW6mwWACq4V/mGWrw8FEFSZnn/7G2m9Ay1I4polJbN
         Kj1CgBUYF6T/8F8fU5T60uo4SWtJjjhybJZSbdhSKnPdS5tsSf4dqFkDAWD8Fm6Jj34Y
         9xQddV7ClY4Y/ZBQH+qHiXBfQ0mVOGKepeEHe0oU8XrFenq9RcsflVvxN8wMoMHXROJ2
         js4V1Q1hwvcmT/y8l7glkzkcWJJdmVUhp71948bkhM6Emp8g3l85VTPm4T1BHh09j7sk
         ituw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=48gEic5nmrktJFBcaxPGjH7wfpbVNA6zefyN0tCSfak=;
        fh=z6d/Jlboz7n9zLl46p3ZlILjPO9cP2Aw3kXdfZH3RNo=;
        b=iq/Lyi+alXHwuchPmbWH5QXY8FanKE8sFN6EMqgtBPY7+350o1v0/BGnmKCxtvkEjt
         jqc9mWaFl/yDi7ftMRZmDTlWEx+hrKEfRrChEJ+ZJSIFbzOwjCD54/tRtL5lZSevYNjn
         OqEDFWHSQdBIifYNQW4NgQj8A2NAW+aHzfFLRQWXTNcDvk6hKrTrbjpNxpz0TKLrwEGT
         DiOmb6LErkGPEyaR5B2ki2VcHWe6iK/6uGzNDSlFLtgAcdF2TA25iXypcB0iqejL+s0/
         +6UkbpAYDYQXt8uVEy3jrWIvXqecfe7ZCcUsF0TYQtDusVQvBbAwL7euFMn2dZ2miclc
         ffnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786255456; x=1786860256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=48gEic5nmrktJFBcaxPGjH7wfpbVNA6zefyN0tCSfak=;
        b=Z8Toz4LZWhm22N/B0qm0a91ygBrZk/fow3G7JrWHB8KJV9GeqZ5Gx21IqKhgXlN1kI
         7VUUMkBnguBhTZvwlV13VIVbJEqNAYgOHXO7L/U+HgDJ9QCoIXejEB/Yqti29C93np3e
         T2ytiINhNL97UQbQYIkpOXvSJMOKVm+XohCe2FO++jOPCbi8gJRBvqoZSuC6juf6vho/
         grjvFG2Xh+IqaMHaC4gmZiM1ACdbwjkNJavzQKSFrGM2HvDmHtR9Y4d7QTTioFl/yw4B
         qYpZHX5Qc6gHnmU6B6HftOBLHrQNiGoUmNVapTeRqex6T3hn0indH0x8d61raz2YuJCC
         9P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786255456; x=1786860256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48gEic5nmrktJFBcaxPGjH7wfpbVNA6zefyN0tCSfak=;
        b=og20xBz6VX99mF7U7sdmj/+hfr6obWT5OoSRou07SO1SdKJxap/QkhJI/ZGHuJ78+5
         hN6dAHGGuzO/V/0Rb3/pbbVC4n/FGHbuyr+OKuXKJzdEcu7U8jo7U373AMiPQzxEXzF3
         Koy701iXylKGhwfAJp3GyKeFB5n1AUO4xVQzrKejr4OdmjJktNiTVfA93PtWKQr70Tkp
         YbBqyexebDj3fQjN7KwTx6sNAavBuEsQSSBoUa8km8ecnvrT8cn6w+M+KfOFlgej9OZZ
         gUl5Id7fpfpnj5ggsJOo1OA5YBjY6OJwrCVorYUiV6ZVFDildyVNHalLKRB7HBV+/VPU
         Y2tg==
X-Forwarded-Encrypted: i=1; AHgh+RqGp6KF+dIuwwmjQbVaZInck7Gq4xZVD5znWcLhBP840JwyDVqzN40/asuPa93wxd2X9WBL7/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubtwZIfFtwx+Cs0ec/dbK6EoOPxCdTsxS70OhYUusZC+0HgRT
	1BNb4R5v0Bgslf+M4EPcWZgRKfVmIK19Bmm2cvTL/uTp3fZzs/XoW07iln+j0KvWPdkuqoZgtgi
	+fsGpS2GetJQHxsS6z4yCRKsWs1EP/QaKEZvXkZQ=
X-Gm-Gg: AR+sD12/GpKE3JDOlqmlrAduF+Lw9fdLoonbkWPTXCxydLUUqx13RdbyFBPxoSCISQn
	Zrn6xKU7xwTC+cqUeRh3lXkM3CNG82H0M/FfKM+QR4zDJ1ZuaCMdaKgkyVyFI4JC41UZtQ+Py9d
	aqTg0K5lRyCq/Gd0IQz//xCuJe1xFYb+pNX0TdmqD3v6PhxO6UazOn04StYJQTgD8cDzqMlZDGv
	bi7BM5dQFpmvwz4lK8ntLB27cNV/yUkTv2UwOQ0NmybCjDZM2tsYeJ10F26JKC1beKnHe3kRl1v
	J4zNQ3w8hVngvnYfkL7mJZKrwaVKmoACwWITaGYJVBcdmDeo18B5y2n3aUqQ3grSZH3m6jRLbdu
	hDwba3to2+O3aeFUg/bfkJfC5A4mh9HrBIXi+BI67c06kPr0IbRLjU+uxoWg=
X-Received: by 2002:a2e:bc25:0:b0:39f:2320:d4f9 with SMTP id
 38308e7fff4ca-39fbb229e4bmr37455661fa.26.1786255455781; Sat, 08 Aug 2026
 23:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com> <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
In-Reply-To: <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 9 Aug 2026 14:03:37 +0800
X-Gm-Features: AUfX_myhdDANchmSyK0o5sFKqBlyUzKYkGlCrKi3dgyer56ehxsFdtKp_MCfouA
Message-ID: <CAL+tcoAR9WTmrFiM0GtWhtvgWX467vAD9fRRJ-Hds9Q346EB=w@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in ipgre_xmit (2)
To: syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 1:05=E2=80=AFAM syzbot
<syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.=
k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D178fb64958000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e38b15c29e6a=
1d9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f639=
94eec
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e25=
5-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1617be32580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11d113b958000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4949138dcfef/dis=
k-848acc8f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/31cc6fbe5b8a/vmlinu=
x-848acc8f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/433919ca6520/b=
zImage-848acc8f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> len > ((int)(~0U >> 1))
> WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason include/li=
nux/skbuff.h:2864 [inline], CPU#1: syz-executor147/5638
> WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reason in=
clude/linux/skbuff.h:3265 [inline], CPU#1: syz-executor147/5638
> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull_reason inclu=
de/net/ip_tunnels.h:481 [inline], CPU#1: syz-executor147/5638
> WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull include/net/=
ip_tunnels.h:486 [inline], CPU#1: syz-executor147/5638
> WARNING: ./include/linux/skbuff.h:2864 at ipgre_xmit+0x958/0xcd0 net/ipv4=
/ip_gre.c:658, CPU#1: syz-executor147/5638
> Modules linked in:
> CPU: 1 UID: 0 PID: 5638 Comm: syz-executor147 Not tainted syzkaller #0 PR=
EEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/24/2026
> RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
> RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inlin=
e]
> RIP: 0010:pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline]
> RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline]
> RIP: 0010:ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
> Code: 48 3b 84 24 80 00 00 00 0f 85 3b 01 00 00 31 c0 48 8d 65 d8 5b 41 5=
c 41 5d 41 5e 41 5f 5d e9 3f 1a 78 01 cc e8 09 f5 6a f7 90 <0f> 0b 90 e9 08=
 f8 ff ff 44 89 ff 44 89 e6 e8 b5 f6 6a f7 45 39 e7
> RSP: 0018:ffffc900039af5e0 EFLAGS: 00010293
> RAX: ffffffff8a5c1d67 RBX: 0000000000000000 RCX: ffff888079535d00
> RDX: 0000000000000000 RSI: 00000000ffffff40 RDI: 0000000000000000
> RBP: ffffc900039af6b0 R08: ffff888079535d00 R09: 0000000000000002
> R10: 0000000000004888 R11: ffffffff8a5c1410 R12: ffff88807ecbc000
> R13: dffffc0000000000 R14: ffff88807b7f2780 R15: 00000000ffffff40
> FS:  0000555590a0a400(0000) GS:ffff88812504b000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055704428ded0 CR3: 00000000788f2000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5409 [inline]
>  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
>  __xsk_generic_xmit net/xdp/xsk.c:1253 [inline]
>  xsk_generic_xmit+0x2759/0x47b0 net/xdp/xsk.c:1309
>  __xsk_sendmsg net/xdp/xsk.c:1363 [inline]
>  xsk_sendmsg+0x482/0x810 net/xdp/xsk.c:1373
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
> RIP: 0033:0x7fc137b1b409
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffc9ef46d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc137b1b409
> RDX: 0000000000000040 RSI: 0000200000000700 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000080000000 R09: 0000000080000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
>  </TASK>
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>

Please try this one instead. I'm not sure if the previous patch has
the index problem...

But the following patch can be applied in my tree.

#syz test
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4b6..aa0d397d569e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1028,6 +1028,7 @@ static struct sk_buff
*xsk_build_skb_zerocopy(struct xdp_sock *xs,
  return ERR_PTR(err);

  skb_reserve(skb, hr);
+ skb_reset_network_header(skb);
  if (desc->options & XDP_TX_METADATA) {
  err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);
  if (unlikely(err)) {
@@ -1112,6 +1113,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,

  skb_reserve(skb, hr);
  skb_put(skb, len);
+ skb_reset_network_header(skb);

  err =3D skb_store_bits(skb, 0, buffer, len);
  if (unlikely(err))
--=20
2.43.5
