Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260504749DF
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721715; cv=pass; b=auAalPdetweqo9iZaR2yA/ej5NObqIHVnPp961JARcyClTXosW2oxal+5dn8Bsw56TvvI/MvGj4r9AX7CYzXVgzWvkm8rn8QnTLN4RVw/UYT/XLZkh9qDF+uudxfAkxlehgkYx0ERTGyx8YTJDm9+uxsgjQa4+Pm+lwzdza5Qbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721715; c=relaxed/simple;
	bh=+0wNqqj/JIDcsFuk6D3YE5ioxaNPoO+WsxELPU0Opyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDHSZccc858fO9uQbPn5SRFscEP7y0+qt6WV8P2GPuJxe4RqG5nO2aFuXD/8mllaW5Xw2Cbp20kVUvd3I+k0hMJUtp5yXGkW0QWzndHT1LmkRrye6SiIeh50qIbJ3l3uEvGl6pRyamedpjW9jGcsK1Y++Vl0vP7swruy5Q6asWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FP5LXP8v; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FP5LXP8v"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-934974844ffso78365885a.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721713; cv=none;
        d=google.com; s=arc-20260327;
        b=i+mzYHn3XAXmIo9j2dj2YIQrmq9hrXd/Iyw5fPrRfMPsWiCIAVetCPt2CYsqm2X02H
         1EPR+8vUlDfxvcPq4bXiOZG3iUiGmL7ZoWs6Ho+efn84VBxCcRqv3XA67PWGjvLgLRkM
         mxwH+zpvFTbKj/KMAvCmgivAV0enSbPMCNp5vHZkT01y5wk+deYpJiwaAYzPy1Hj22FW
         te5rezIPFhkX4SiGNrwu/baLzeOvoNsQBfP1Fg6cC5uH7MeGuZft0iaVY9L0ax9rB8V3
         K5QhNeZxHY6XD+X4PU2d2y9TVk3qELbJlI69KlKYG8Z1nxwvIVhygFPwyNPGg7LuCFiI
         8lRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bqy4lGSpn4jhtngPysVT6s38YSwFuWf4nbxApd1XVRk=;
        fh=mmUAdMXTSuw+ZDZAQwOxHWbqlwKzkneQAf6DLBxiQ34=;
        b=J0Bfx4em3z44ER2Vu2Acy8kZhFT6/bmiQpZHpfAXNryWf5SYpiYVxWOptvHcYQjjYG
         lVI1Egw+XsUNxkYz9QVs+AkHSFjQtoLb1mKh3Kxvx5RlSgHlb6Ni2Kn9JznUNjP/1XR3
         fwn5lt3QTuEcsXOtL1zzVrL6qPPe+3cUxcjUGSkd4jg6KZSqlZ2ajXiqpcHQ4ypob4x6
         pOfA+Ts+B1KXsquf1i9da4j/A1LdjpSXilmDqzBU5Cf+SZFMjWPIpIYihW/A/x13FODi
         +FFMbXRYAASQLBLbSKdIsAMe0hNhTpqgRre0f8GNus51HDL8e44ckJ3vOdOB44uZFqk7
         xqJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786721713; x=1787326513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bqy4lGSpn4jhtngPysVT6s38YSwFuWf4nbxApd1XVRk=;
        b=FP5LXP8veqyZPfpkvQanuHOQuGspIyMMpDNp8uUtI83vVH9XhmterkPqX6acVkZ68P
         /iOb0npapyeWafmafXyOZ+LIYneJPjtfFKSCypE7Y1jCuQMxjec1/BUg7yd7+UB0w0vI
         U/XE+o4MHFYd/BROBIkULr+hDoz279X35GZMIYZ9BvGP+fh4cF9RtRcPjxyIuotdWhS2
         2vqx9OU9YuZqEzd+I74k3TeDT0NBMNJvNIktpjcmfp1ZbJ2Cq1TRC1Mkwyjs+pynmMH3
         QXhZAvxCqEAss9X0hICyTSC1f/b/YySjQnMaVRIvXrHJrhVtsJAYAw52lpx3iwgNYgIc
         6hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721713; x=1787326513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bqy4lGSpn4jhtngPysVT6s38YSwFuWf4nbxApd1XVRk=;
        b=Qh/edAClDzo+NnrKEs8A8+27ZkwSEUNkpRLmYxK9F8vcpggeCzN+0LGtPwR6hhxA8B
         fFKsVQaY02laXGnBVgvx8l48D4Yathg2PzhdEglbyPt07hVIVTJhqAg77D1i3bj/DZMG
         XWfie7JCu6gkObKAljIXRRKDRjsBOyhqucsxRgZ0wYNt6FrnCo40eFmtNu9Kg8SiSkFL
         KaKwzJ+7J5q+R2IvYWnaRtx2zX0VqiesfQ/B60wL4QwpnbsO+4btxvmIs2g6R9VuzV5K
         3WXs5c00gi2o2WZOeas01Zr0vrcyNUegIHQgx+7BevmGJ7hRD+LYBaxXNsqVwpQM5Cx0
         21yQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr51fY71oKG64R7r+DU13c1+SoHJmVhMpYJa7AVAsKNdkJsEhtG88bX7DbXTHwfJ+Drubj+IiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYi0I8wSEsLDqW9x0d+kZbl9K75vzZjaZKdpu4ckjrCe79b9l
	YcgmA8d7AO+Bn8jiQXKGlvwWSMabqomGthUkVnTDy0ierZa0E2YwisQo5VPC5zfLoh5cydZnk5K
	bEbkLouUgJj7J0Ndl5PWdPvjCXPs1ba1qyfy7/WQFjI/Maz5nXd3FmeClamI=
X-Gm-Gg: AR+sD12y2TbwbCMQc+scq7D5lk4Ro3tn1b8B495Jf709/5rrs2naZnHkWEeK3NGczBV
	FaaCI4AAQ0P21I8OMKf4CEvKEMWn2qn3QORJKUv5/SYS7ILLM1USjtcLBgQhlmD/LtIzcdRYVYb
	11aRUYWEjSjv4CoTJbqt4aw5cmNPF/PrS3/Xly7uEtZStinD6uB0XlmoCMQpa3AbnykAGvErKdm
	j8KkqaE4dYTmfGpWj5YTvF5RcHFt7DpQyDlxE9/2BKdc5J7IFSq/peEPLXqAOeTusY1C0nf4cJd
	51lgN+zOEZrw4X6Wleadf1PP+Bxg70uIWAJWbuFFucbIlwZ7A4JU3DFzggyR5qDGE+ar4R1xYrm
	1vtPEtdIFgbLn/6OKNw8sb6MIlMsKwMM4MLFhxQ39hThwpQYHsxBKzqSkRySdfunpyB6EEL5cJc
	+zyKmF5NxKDvnYQ++m7CX8K0ftfxc=
X-Received: by 2002:a05:620a:4413:b0:936:78c8:e286 with SMTP id
 af79cd13be357-936d234d4ecmr626427585a.25.1786721712063; Fri, 14 Aug 2026
 08:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a7f3555.dbb3a75c.20434b.0005.GAE@google.com>
In-Reply-To: <6a7f3555.dbb3a75c.20434b.0005.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Aug 2026 17:35:00 +0200
X-Gm-Features: AUfX_mxeJ5jR4As8df4k6YPfAtE1vRsRqBiFCyeCAXM2Z2qMGMVMVhFoXHfqnlQ
Message-ID: <CANn89iLye45x8mhXm5-rcttmCqjDKEEXR70o9jJeFy0kOp0zbQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in rtmsg_ifinfo_build_skb
To: syzbot <syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:33=E2=80=AFPM syzbot
<syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    02dc699f83d0 Merge tag 'kbuild-fixes-7.2-1' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17320db958000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D145fa60d73086=
782
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df2f6312ad1b5a0b=
fe316
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for D=
ebian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12d0e5b9580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16f9cc9e58000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-02dc699f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/faf03a1fb300/vmlinu=
x-02dc699f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a48e50ceca1d/b=
zImage-02dc699f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> err =3D=3D -EMSGSIZE
> WARNING: net/core/rtnetlink.c:4538 at rtmsg_ifinfo_build_skb+0x1c1/0x260 =
net/core/rtnetlink.c:4538, CPU#1: syz.0.17/5924
> Modules linked in:
> CPU: 1 UID: 0 PID: 5924 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:rtmsg_ifinfo_build_skb+0x1c1/0x260 net/core/rtnetlink.c:4538
> Code: ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 8=
5 80 00 00 00 45 8b 76 08 e9 3c ff ff ff e8 40 d7 73 f8 90 <0f> 0b 90 ba 02=
 00 00 00 48 89 ee 31 ff bb a6 ff ff ff e8 d8 8f f0
> RSP: 0018:ffffc90004266df0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 00000000ffffffa6 RCX: ffffffff89968a40
> RDX: ffff888034e5a540 RSI: ffffffff89968aa0 RDI: ffff888034e5a540
> RBP: ffff88803d24db80 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000ffffffa6 R11: 0000000000000000 R12: 0000000000000002
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880578ce108
> FS:  000055558858a500(0000) GS:ffff8880d5ed8000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000001140 CR3: 0000000036c7c000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  rtmsg_ifinfo_event net/core/rtnetlink.c:4566 [inline]
>  rtmsg_ifinfo_event net/core/rtnetlink.c:4556 [inline]
>  rtnetlink_event+0x137/0x1f0 net/core/rtnetlink.c:7136
>  notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
>  call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
>  call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
>  call_netdevice_notifiers net/core/dev.c:2302 [inline]
>  netdev_features_change net/core/dev.c:1590 [inline]
>  netdev_update_features net/core/dev.c:11108 [inline]
>  netdev_update_features net/core/dev.c:11105 [inline]
>  netif_disable_lro+0x3e9/0x660 net/core/dev.c:1831
>  inetdev_init+0x371/0x570 net/ipv4/devinet.c:284
>  inetdev_event+0x7fa/0x17f0 net/ipv4/devinet.c:1590
>  notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
>  call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
>  call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
>  call_netdevice_notifiers net/core/dev.c:2302 [inline]
>  register_netdevice+0x1998/0x25a0 net/core/dev.c:11484
>  macsec_newlink+0x4fb/0x1c50 drivers/net/macsec.c:4221
>  rtnl_newlink_create net/core/rtnetlink.c:3913 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:4044 [inline]
>  rtnl_newlink+0x1499/0x2380 net/core/rtnetlink.c:4159
>  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:7076
>  netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
>  sock_sendmsg_nosec net/socket.c:775 [inline]
>  __sock_sendmsg net/socket.c:790 [inline]
>  ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
>  ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
>  __sys_sendmsg+0x160/0x210 net/socket.c:2770
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbf0c99e019
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffe9eca118 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fbf0cc25fa0 RCX: 00007fbf0c99e019
> RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000005
> RBP: 00007fbf0ca3500c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fbf0cc25fac R14: 00007fbf0cc25fa0 R15: 00007fbf0cc25fa0
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

#syz test

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ee0e2eb7dbc61c1affe4b0203337f2fdaeaa031c..0844f551d3be696bad72a8322fa=
4ea1bf9ccf105
100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4402,7 +4402,7 @@ static int macsec_fill_info(struct sk_buff *skb,
                csid =3D secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 :
MACSEC_CIPHER_ID_GCM_AES_256;
                break;
        default:
-               goto nla_put_failure;
+               return 0;
        }

        if (nla_put_sci(skb, IFLA_MACSEC_SCI, secy->sci,
