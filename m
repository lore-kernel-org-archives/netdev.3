Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630C43E092
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661166; cv=none; b=PB4Et/+GbX78BSQoH+UEU6DqCdez4q47d6nW9GzUS1YV1SeacpNLKN9LK5Jha80AT/XSumvGKZ+HT3eczF/RyyBPoJ9TQmSbyClOFedTh+Tf3MF+zMoshpMZlCYHvd3ISMQybF2xNz424sU5zLivxinW6PweoiXioMcdqv2Via4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661166; c=relaxed/simple;
	bh=GsuhjXvEvgKKsoMT4Zb7JbWgSo1Q7J+qdUTL3ZMtEx8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M24k4PcyT7ZPrsHJbiLyGVnh0QEwT0dbbTC14qIfzJM7tZhUB2wljScxGVfGBxonw9JoQk19HBAQYxSmpgTncpWaGqdZhuUgDpguKliaeaGWmHSFwSKqYKPkSGta7fdGrMr1+R79xB7Qn0a5VAEm267khHGyrtytg+VPZSMRE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4afa222912eso3877915b6e.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 05:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661164; x=1788265964;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pgjm35CfSUvHB0XuQYogdQXr+1CSCB3SqYC2eCifbi0=;
        b=FHr8yNA1vuqvzEv+ThIINB5aZ2Z4Nix+oudtGMHkW2iOIJcEGETZYGhzcRbLTG+N94
         loKrmdbhMcCnZ7qtvzcxMPZKnlReZLPEEkvU4TTEK20nZLOc9YPh8Gix0mposSIeDuhX
         Odq3AbDqiWvGbQw7pjfDCLKsPaJIvjJVyH98UgLLFKDdNS+9OXzYc0DBQLKUebHJcAKv
         M/AEnL01YUiBx6jykBsPZpXVQczwJ233sjlY7/eJztczF8sD9xCvGQCtR8oBkI45Nm30
         8uz6YVWO1Z/GnfTSss82XxgBJE/0x7urD7JW8IEhPU2EcYGNpBvmuK2/ZPZaPsCvnB+m
         D4lg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9jPoT8uoxWPvb7Qhy5jYU8w/6OXygGgLeCGIh+OND0Qh8tKyaCikwkipo1h0isN+kT0oXVUs=@vger.kernel.org
X-Gm-Message-State: AFuF++mumtyDyN2+Z7uap/ZoyEJIS9tLGd1iQAbtpHbXPocogV30X+ya
	DuLB8LJk7LYjiz34XSuwbspW4oj34ZM+T50PAko6ErdTQMzJKVvA2fYiUiOAGA9jv2zcHsVg+Kq
	Sb/4s4vZ/pICWCRkALQYc5RQvRA4qJwvtk47x2micJoydEyX3Rtx4lopajBI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1994:b0:4b2:8e1c:5920 with SMTP id
 5614622812f47-4b309ac88e2mr26818798b6e.9.1787661163751; Tue, 25 Aug 2026
 05:32:43 -0700 (PDT)
Date: Tue, 25 Aug 2026 05:32:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8d8b6b.a5a502ce.31d34.0066.GAE@google.com>
Subject: [syzbot] Monthly net report (Aug 2026)
From: syzbot <syzbot+listd8012b43158f09bd0fcd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 16 new issues were detected and 9 were fixed.
In total, 61 issues are still open and 1772 have already been fixed.
There are also 33 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6308    Yes   unregister_netdevice: waiting for DEV to become free (9)
                   https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
<2>  4380    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<3>  703     Yes   INFO: task hung in tun_chr_close (5)
                   https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
<4>  501     No    possible deadlock in __ipv6_dev_mc_inc
                   https://syzkaller.appspot.com/bug?extid=afbcf622635e98bf40d2
<5>  454     Yes   INFO: task hung in nsim_destroy (4)
                   https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
<6>  28      Yes   WARNING in dev_shutdown (7)
                   https://syzkaller.appspot.com/bug?extid=c9ecf60a8adb7629821e
<7>  20      Yes   KASAN: slab-use-after-free Read in rxrpc_destroy_all_peers
                   https://syzkaller.appspot.com/bug?extid=c876adfab6362679008c
<8>  19      Yes   KASAN: slab-out-of-bounds Read in __dynamic_pr_debug
                   https://syzkaller.appspot.com/bug?extid=1e3df0852e82c21ca418
<9>  12      Yes   INFO: task hung in inet6_rtm_newaddr (2)
                   https://syzkaller.appspot.com/bug?extid=101224300649c3eb8af4
<10> 3       Yes   BUG: using smp_processor_id() in preemptible code in tx_complete
                   https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
