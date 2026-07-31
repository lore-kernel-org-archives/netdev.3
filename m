Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7B3DEFF3
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492345; cv=pass; b=d9ycE7Ukede7NOv0ANaEo2GxUeyyZakrG6+xWyJ0B/9exwp/vuBGdjZ3EUe9QPTwe+E++rMauS7Yn5V6CBeBZe394B1Li8O6vvMcdkBfbdZIFTJ1YhFNKBMzjVoAQQEQtbHbtqfgKc5JYYT+9ze2EYlgf+Zjo1IyPMwomhSF9gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492345; c=relaxed/simple;
	bh=0CuqD7jt0HdVg6PDjWSiv0dLdkF9omhY0jFBOqSru/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bz/MLWuY7lslZPVemXh6K8lUhRSTkO+MbakQE2ne3ynnATohPPILP+2D/JBHFyu3ZVDJN1rwa5bxHnPJ51ue5OXE9xOSPFE+VF1HmKU62Xf9uoncmqhdm4REyMjqxQxYkdPyciYCAKU60UQXjMbS9TwsuNda8hzt1UZgvwp2Dd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xtw1wd6h; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xtw1wd6h"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-446f87b6de1so499876fac.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785492330; cv=none;
        d=google.com; s=arc-20260327;
        b=r3pVIH7LBaJCrVIfGyGgiAe1RXZd6dyxf4ozY71z+QY+xwHp9RyY5QgPMffWjW45Zg
         dIOwNIlMLqee+c+LglbtAr5K6w8xWQUvKcS+39qvJDx1BKf40vAXKCIEzfSE26oqu6j0
         4hJGStbzxqQSypsfQip3zzPZOOMREUEA9DiTyHwkZKJNwdaTOGqCmUwd05R1JC6IhFHC
         9H0y+cuxo4sGIYpLC2WNxd8vgbxAFcImW4Mn8EJWo/kkDUtcBvKgRrdm8LyQDZugFTDk
         OM4MUsGlYavV+f3wXlvitlvxO8xm/QAFifAmWxtr+lud7QieF08R2gxQXqpEZMQuHHgz
         j/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=apxky0PDlzP73VOyUuezKm8vZikLqeFxDlMTo8vJy+c=;
        fh=YP5TxM9OpBsgQqz/wyNSxbgFzqTcFyPU9XfcTLxaM2Y=;
        b=NKO2owXZ4dYW875yNi0DV9rZYTQGFD0UaAmFOPQ4UwK+hXdrEzVw+EfEWeFEhrzcso
         4uLOUI2DkQJKCcNxIJb2zsHDnNXr1LoQHOx3mCgqTwr7ClGyajwksZE4ewAQN8NeoX4w
         Hjdm+axw4zmRvM+l8olvSOb1BoOJxCm6Ww5bj5+SrpjecWN5nXsImtISFkUTL4AGLXKd
         Hhau4LHmkklinkfmLt1o5d/GWpYwdkWVHYVgp4kOpHOGkxuan7q67zk+ad1N2II3BfLM
         ROpxm3GpXL3xBzOx2GOFxFvs07BiE0dUI7XssxJaEh7LiC517Uf1GNYEZCkXchPJRIPG
         c6Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785492330; x=1786097130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=apxky0PDlzP73VOyUuezKm8vZikLqeFxDlMTo8vJy+c=;
        b=Xtw1wd6hkFnW4lSm4sJMLGF7aNbG/yng/em8jfmzzb/kMT0aDtRiRkfk4IhT9HZZfi
         7c6q4oP5iG05Ep6s9KMfwj/hyma3bJMDZxI88uLyYonAvtfXGFMt1npe0CeUZ177bJIa
         KwR8l5iZY5obTBdxusj8zhMRzg0MShXRYlpEzk4K1cg19AFNbNVvPyhjEbrqxok0JVl3
         GcSQy32+JK9Dgm2g7hoDHpKeaxPcTnz5cN4rrVjjlQc2iqxJVE0aRNV9CYT/LQKXrE/9
         B/JfFQ/w9ztsD/gT0INZu6ZaGlDz9RKLRrvG0CJ9eOf8z/bm6nlEuI3MWOE3PPuXz4US
         mXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785492330; x=1786097130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=apxky0PDlzP73VOyUuezKm8vZikLqeFxDlMTo8vJy+c=;
        b=KkmL9A4moF9pQi7TYfFyYGLGYRclFqqMToKhco4/BapHXRXAKVrKJntmWwpK0P1myq
         xjLcxYz0SUAwIDniuMg6zCCW6Rq3fqPIq2hqM+Y8ntnTSbcPOZLu6KOywHskC8btK1AT
         c7Ejeoj5sd/s+4Ei2P7Hkixi4pSxcQlkFJeIBWg91hhVdMDX8ecJu6maKXJjOBOkiG5k
         QRWtW7s04ZL/8azO5b8pOUSne5AnlBiGoV+PIfI0+EoY9udLWht9oAkk0LKhdjXBWPwh
         298/GD5/9zPnv+AerGOlOFi68ZrhVO2+E5lRLxsXawRBhPdG84ljMmz7vBDd+aTv3iU4
         /S5A==
X-Forwarded-Encrypted: i=1; AHgh+RrBfzUg5GWKC7PVC+jYKGO1RTRWXV/uekPBg5SyzjRbdhlxUE2F7c50GohE6tACkrZovmIln6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHybzFOJwRFE4o2zj3JOKhKJmzTJ7QN5vSqTgtqyo1oyMH2Bm
	cQTY6Ol9QuNA4pLMaJdyP8qSb+ZvrHdXgeoTTKuc3iIY3mFLgLN72gxAWd1qu++jXncHKd++cW3
	iOtQZ8w8B0+OGQdAdaLWhkVnBoYNWwfxPT5BalMjw
X-Gm-Gg: AR+sD119Zl/dyNZSDTm4ZPHLQCyeFIn+G6RHYk54kdJiqfX1lebZP32z+gPrqkkN2dD
	ihpirsffb3tcIS4UK1x0Vv2vUmflNx+dHOFdPJfcMZbs4Djjyxxr5gQbdj/cTaVTnytbsgFYb01
	M6id0pphqSMSI9d6f9xrWDLU3CD+/GhlI9nR+wSeXMVg0ONQkvKmWff0c0cXFg6KhomwzSCTi5Q
	gEiiB70v2tyo/D3V2YAqwRCakWF9UUSS83R6WvwbCD9MH+k8hjqNDHyuNmJtuAp/iNInahHnlFV
	QjiCjVezIt/5FtsLZ0InJj9ZtUhxe/TOhEa9Qq/RpY8TlOv7067MAIt5Up3VAW75RxLeLDUSKLY
	wRkI82P8FNTmqJxdl2tARyAwR8fSzm1W70T/SZ4XSj0VVK86IWKSqwG1mNksipMG/MAvW0vsJc5
	AUZxIuquP/kAkq
X-Received: by 2002:a05:6808:3023:b0:48a:ddd4:d36f with SMTP id
 5614622812f47-4ae4c42efbemr1339060b6e.8.1785492329774; Fri, 31 Jul 2026
 03:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6c4cb6.77639fcc.3d4fd0.0021.GAE@google.com>
In-Reply-To: <6a6c4cb6.77639fcc.3d4fd0.0021.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 31 Jul 2026 12:05:18 +0200
X-Gm-Features: AUfX_mwgsI_Fcfph-ij3sCJvBRiqP-uGhSy1se2zfFMMbPJoOpaPv3e2s1EsBXs
Message-ID: <CANp29Y6-ZrGVQqndAvkqZ01o9i2H6SVZteHiqH9WXAU1OqSfCw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in xfrm_send_migrate_state
To: syzbot <syzbot+b9e97485773456b16a4a@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz dup: WARNING: suspicious RCU usage in xfrm_nlmsg_multicast


On Fri, Jul 31, 2026 at 9:20=E2=80=AFAM syzbot
<syzbot+b9e97485773456b16a4a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    365f9c7a6b81 Merge branches 'for-next/core' and 'for-next=
/..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1486363258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D72c97575381ce=
c47
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db9e97485773456b=
16a4a
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e25=
5-1~exp1~20260613092250.77), Debian LLD 22.1.8
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12863632580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11b0e49e58000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eafe0adb7386/dis=
k-365f9c7a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/29422d607579/vmlinu=
x-365f9c7a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/98ca955a8b54/I=
mage-365f9c7a.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b9e97485773456b16a4a@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: suspicious RCU usage
> syzkaller #0 Not tainted
> -----------------------------
> net/xfrm/xfrm_user.c:1630 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> 1 lock held by syz.0.17/4942:
>  #0: ffff0000d8a19c50 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_n=
etlink_rcv+0x70/0x9c net/xfrm/xfrm_user.c:3928
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 4942 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/02/2026
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
>  __dump_stack+0x30/0x40 lib/dump_stack.c:94
>  dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
>  dump_stack+0x1c/0x28 lib/dump_stack.c:129
>  lockdep_rcu_suspicious+0x168/0x26c kernel/locking/lockdep.c:6876
>  xfrm_nlmsg_multicast net/xfrm/xfrm_user.c:1630 [inline]
>  xfrm_send_migrate_state+0x6b0/0x958 net/xfrm/xfrm_user.c:3340
>  xfrm_do_migrate_state+0x1114/0x1728 net/xfrm/xfrm_user.c:3507
>  xfrm_user_rcv_msg+0x4e0/0x950 net/xfrm/xfrm_user.c:3907
>  netlink_rcv_skb+0x238/0x414 net/netlink/af_netlink.c:2556
>  xfrm_netlink_rcv+0x80/0x9c net/xfrm/xfrm_user.c:3929
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x600/0x7f8 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x648/0x948 net/netlink/af_netlink.c:1900
>  sock_sendmsg_nosec net/socket.c:775 [inline]
>  __sock_sendmsg+0xc8/0x17c net/socket.c:790
>  ____sys_sendmsg+0x3d0/0x6c8 net/socket.c:2684
>  ___sys_sendmsg+0x198/0x224 net/socket.c:2738
>  __sys_sendmsg+0x158/0x204 net/socket.c:2770
>  __do_sys_sendmsg net/socket.c:2775 [inline]
>  __se_sys_sendmsg net/socket.c:2773 [inline]
>  __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2773
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
>  do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
>  el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
>  el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
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
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/6a6c4cb6.77639fcc.3d4fd0.0021.GAE%40google.com.
