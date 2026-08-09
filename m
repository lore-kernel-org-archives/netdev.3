Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3A1CAA6D
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786240781; cv=pass; b=MSDBdF/UEOBxMPcN2d6KqnP9KsAWUY9RZXHmBoHEVy7XSMMJSsfYPw+ivGH/KYmadZiCZtDcUfyNJB8S+j7/ahk30Q/pT3+gdR3wFjev8Nprwq7BZtgXT5Ye3S5lX0/C7frNlwG0HIragh4yQnYVehwaEIpMg3SlG6owtodk6Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786240781; c=relaxed/simple;
	bh=kIqVmrvVdZRLNrOSDN9SzGRpZqGSMFqCWsXRY2r/NVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSp7bibVuSfXuN2uKil7Yqn9ye6NTRb6lbgvsjk1ACcYj65RIhYTIFswdmxtJbnYx7Z1QSS06F+q5I6e6DYsR8BcMHYGAZ1OQ4lPZ+Pbjm+nY+EEyYAvgsPuGxkLEYKskQrZGMSgkgodIMZFmTJJzRfkx1AZlbJaYyiQhRqeWOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUPKFmY+; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUPKFmY+"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0117dda13so713276e87.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 18:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786240778; cv=none;
        d=google.com; s=arc-20260327;
        b=Pt+ZUhhUQbymcmWICW3Xst68rYeroD5ypvNhFDr7HKk5LLEoadGgvpmWoYMBfqBpTi
         grnK3UVz62FYhuFiD5dWHTJsTLAc5FCpOFFwfR1K0MtHH0XDiL5qUZg1G7DOlA11fbrE
         SpK3icBTgUzVC/jPt94vAr699IUn/2KMPDzeNrEgDC6mDDQ9UWD0c3AXVKjk4zgKczk/
         enAASamSvQSB0BYCL3i9arX7bcuUBQFqQXw7khoXFMaoM8ByDh1zveSBc01uCIxIRD2h
         Bn5+lFEuodc/SADB9sk5VLsPXVrjRWtgLBbg8AX5HV/jAncqzMDdV6tbc006SSnk8rha
         0lBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Otr2FHJsBUO7mYkrS6VDsbNY9mXc3sYL8eeT6XQSYk=;
        fh=tkcSJum5lut1UkqCnFjwZfl3m0xAew+TYxegQw6jujc=;
        b=MA/bCbfJeqhFaMxgTskkLO3Sb5p98SgUfZRZ6SyK/3JpmZrV1J2kCDZXKEAGaVhZfq
         1tNGbJl3lLz782rGPW6Sf6OmG/hTD8aF8UA/zg3YTFx+Zg5N9SIMB/Smz68sc7+Dohsp
         dikhA1abTmrphwWyzOFHHRdDBGx6x2kB91dWWdhZywNjyUdhbl3AIKyFcN4a3MQVYuD9
         CKb33UAfDnD4/evVxdJU/D9wts+N0X+5pih81wi9zZETEsidn/F8aTwDUzdtTOCWNVo5
         aNZcyyjTcfReDheoCo0Kn0/1jZ7gEi42fIJAEPFVnSt5wwvGA+4ENENf4Qsb7BioAuyN
         pSug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786240778; x=1786845578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Otr2FHJsBUO7mYkrS6VDsbNY9mXc3sYL8eeT6XQSYk=;
        b=YUPKFmY+h7NdYm18p3fJRZUkYL1SW3TxQoTZo91+RkZcwr7hG84y4dZqW55rYUCrF6
         Yfrwf9LwiXJGvdMk+Y6+r6dpTXyyc8Futwy3HMcQ7/SnVQqmvrtuNtZc1YQvrFL9idY2
         biGzmbxM6JJ6tTyIHjX5TehtKdlmbjzqJaby95J8zdPzRtbb0Ef0nhb50zTrtT4jYNSM
         7hX6rMHMDupOFBmoDI4sObSd+Zg2v8mR2XUGeCdG/DN1o+9UNfWXAmw5fsU79jh8FjGp
         +El0QdhOfRxAAhFGL55zQrsZ8K/hZe2Ha3ZY9Xd60b1yX4h0bGVtL3m6T8aupuLgjGNt
         Bsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786240778; x=1786845578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Otr2FHJsBUO7mYkrS6VDsbNY9mXc3sYL8eeT6XQSYk=;
        b=gfwMJuboXeh9b4JXz7Y4qaAVuoEb4NkMLQ6Bkc636smc0KZU50Ey61DCgk7jRvTJq/
         EQ9TqRuCOK4X5Sh/4mPnZBTt+x4YYafb6PLcYMiaQv/OoY5CMOm+tQK6giFFeq4s95JS
         fzgjcC/Gxa7nJ6Vcb9UUARkhiNzzgDWT8+Xp9CcmdXMllNr4G3RUhyBAdG5moNYEFUFo
         LNK2+pYI/SxznR8l9tBkPXgbGUuxnKZThcR22bexipqPogYfI2VBo3SkASbK/OqZTWfy
         /LSCorL377nbopFVZda8HjDb+XVYAs4miXZq16XB+UkPVKfVVmZdBsPaDpFt2/aUTYBQ
         1bHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3ETfMcXMxJsybdqbNk9QFHIwmvuLpbhDqOXdT5F8F+Zg7zuKhS5sdBRLfEyHHtsYuKdgf8QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFeHTdHrHaI+hVPKUaTm6gPklP5P0FAEBCDGbmCV+cKhyKYwX
	Lpp7pGkx1+mpMq6KeK/1xYhHypI21aVES+CRMJ5UYePPN/XUNVsGSDEyfMJ1jbKLaPVB3RQtUE0
	GIcY0gANTsXnOZ1E7ZyHKwlW0O3ci4oF+fxL2cVc=
X-Gm-Gg: AR+sD12n0gHere/VC7/D1SkWESZvSqqS1Av/AsSVNa5eT4G/UdAFcEzj/7JX4QOJ/6D
	9X+Xl9G0y7f9F3KOo3vwoyt0YNN5ebsbUTba0U5QvZAkNE35jnAdK9bsJCcaeceZFIDjttqhh69
	ihVnICk8Pi2805zz5KxFvaEpIR692OsalkgePKcdRAhG9DyUuuLmpsFjrWNyzBNRel6G88BERXL
	ZBDtF8E0mv7pWoWS5IagqOvUInhSSEvsigKy8P3bHwxiFutG0UchsCZwWrlJiKpVuCwYXpmD0A7
	2Jtrkm5FYBE15Ji+1yGvs/E+OC8bbNUoFc1fEdWqcACuVJGQiYMJ/VYPFIODS+6D6ad3xxSYJnY
	yj6LwIbmQvjCKUg/2D619721Lk2tk+wHy+qE2yOBYuNtBWLDTYjUh5b5jFlmFvwjppL/Q
X-Received: by 2002:a05:6512:63d9:b0:5ae:bd53:70f6 with SMTP id
 2adb3069b0e04-5b30b728fe6mr953966e87.4.1786240777438; Sat, 08 Aug 2026
 18:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com> <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
In-Reply-To: <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 9 Aug 2026 09:58:59 +0800
X-Gm-Features: AUfX_mw2hOvXm3HivoBHHj3dh6qW0W8vQs98iT6Hdz5JCrBFrQAyMKJ7VhUsGxc
Message-ID: <CAL+tcoByBOaeZMyMGr_=9sPZtfNHVVZA4iVzG6ioP-_QHneWOQ@mail.gmail.com>
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

#syz test

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
