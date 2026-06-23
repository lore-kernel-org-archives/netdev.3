Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66D3A4539
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246750; cv=none; b=QT6mMJj/bYnPSpkHGFV56G5SViRdYQpw+sMh26HwGycLDGyf4raw4CSU5GHfRPvZkK3gubwCFYrcYjUzVeHZAfFJQ9icqTixhAXBYc3TYJ4S2BXQfZ2babIfVU7+Wb9dUSxckgNIiGXr+PsLEb8DotTFTiirxZJ4xua+mpkYNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246750; c=relaxed/simple;
	bh=4uGzuH+YLKHx3Pe7eT8jQOF49p+UFV7PGd1poNJur2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eVKeyg0OyP+QUWvhFt1ZRqgAggQfEB6E2ibK7um/PN88Pvhr2nMcnWMPYcZWgTRDBE8uCzCuOBnvftBhZya35etpn/U9K8nx17tqL9YuBJhlGMV24AX8SNVByXZ7J3og7IhQ0TjGaqMjIs4HR6L49RyxZ+baEWJkM91dozmGEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48651d7d505so411857b6e.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246749; x=1782851549;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QE3Fkd6EZeeRlA1amqgDlpy/1Dkbg+0qWNiUAEYQ6N4=;
        b=SMW5FZHrrNlhEktBPJfgxxhX+vZVC0K4z2EwaYJQ6j0iuKf9eSWFT742quibKKSjnU
         zN3e++OrmZ0Lfuf+OaILgYywo+JerTL9Mh0HYRb4BRNyPZRL3fFh6oCAFny2uYkWhu/Z
         GBAtdsdNs3NN4HTXs52Ls8iD4uvIgMRjo9VEycIqX4Gpl65ReemeIxwEZOaidkzmCyou
         eHRInz/G/j5HJkdOhBY11/iYfRD51vVmZdbBolC0exLNJc52qERaTaNRCTMdGIZ+QFx3
         j2DhXB4kjBJwlVpR42W4yTQck05uY7xmaBMDS75I1mZV2DZHs1SMDoc3jeL6CB4RfC6s
         yP9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9JljsKOvWXi+sBYFV6JFE2Sn/rUd+8LaD/tjiKGBxj/X32jkeiVwfkDYbYYnaCyv6/2TIm4Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7IT4i8KIlho+HyZ/uDcOy3Uk1tJ//1eCjE835oH4L2dnBmWJB
	pFPJLPR6cLLJryJx/nE5rEz6Xgn/jyvtuuh43EXkyl1ZHJ/QLzVRh7ySEJ0s3H8YViknCoWZx+x
	O0Uwm13vyGxVqcRA+NQxvZZH46p2Csr2RjuK0yQvki642AVwOUSIXZIXpk0A=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a13:b0:490:660f:5979 with SMTP id
 5614622812f47-49079493371mr245188b6e.32.1782246748717; Tue, 23 Jun 2026
 13:32:28 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:32:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3aed5c.b0c80a11.da7f.0005.GAE@google.com>
Subject: [syzbot] Monthly net report (Jun 2026)
From: syzbot <syzbot+list22a3a73a6e2d7e751aad@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 5 new issues were detected and 15 were fixed.
In total, 59 issues are still open and 1748 have already been fixed.
There are also 30 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8753    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  2480    Yes   unregister_netdevice: waiting for DEV to become free (9)
                   https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
<3>  686     Yes   INFO: task hung in tun_chr_close (5)
                   https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
<4>  456     Yes   WARNING in inet_sock_destruct (6)
                   https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
<5>  447     No    possible deadlock in __ipv6_dev_mc_inc
                   https://syzkaller.appspot.com/bug?extid=afbcf622635e98bf40d2
<6>  443     Yes   INFO: task hung in nsim_destroy (4)
                   https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
<7>  150     No    possible deadlock in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=9bb8bd77f3966641f298
<8>  83      Yes   KASAN: use-after-free Read in qdisc_pkt_len_segs_init
                   https://syzkaller.appspot.com/bug?extid=83181a31faf9455499c5
<9>  67      Yes   INFO: rcu detected stall in rescuer_thread (2)
                   https://syzkaller.appspot.com/bug?extid=d5f7a5097c24c7c2dbbb
<10> 3       Yes   memory leak in __vsock_create (2)
                   https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
