Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC531F9B5
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784953956; cv=none; b=IxGfzUAokOwiIOtgOAfem73rgLTIbu164StS+kaQqgd8qBGsaXJprPfzDGSlMxdhSj8R52nWQ3Kw6zylThjUr73JT8m5awpmjeh4wT10yK/KEV84JN00DZktPkB6DMfGg9Nsi3uD/L9pz2n0dSkEI4d19HH4vWOQunjT8pu7RZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784953956; c=relaxed/simple;
	bh=igNrTDpw8PBBFJJDyfe4FfZOrENX0SJANQ7zcfjEM6w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LqwMLgZ/yG7Yuo4U4werF3owRyC6jUGEa20kRQO1HhlojpojV5zN/gBetr5eSDGXOZszI/WzBuXwvWTd1o5g2Ar1763bybJ4Ntyesf3nxqPS+QOFEgusQp0fsqGURBKhrUhmHoYZ5BxflKB26tdhMRD6m2rZ3biFL7sPqQyyo+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-495f637105eso1646599b6e.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784953953; x=1785558753;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Plormjw2Vm2jMwqYIVzAIp8M/kSlnS9HvnvLg7IUXtk=;
        b=LBK7z1ymEAElwqBOFRwY+FbL8hkLPzFHzhPHrs4cE+ldFfUkV5rK0Supj+IYz8IOuP
         c4s2o/brBtI8zioiPSQUk21aYwug93ctZclA6iMbU3b7Y2O2K9uunDPgT32ZGP4qQkTu
         sGwjxkayuyxAOvZ983PM/bylAz6fxiI7EBFXSHRMT0IddxEWK6szvU6w2xFVylmJ3nkQ
         a2oHtC2LU87DPNboQT96SXHxkjE3Gs1RLCyawqGEHqC1f29w6DTVd9zkW4vt5kq30qdP
         0KDylTW5mUvgc2cxZLDNNCCJbQ7wQH5O0Gc6BlVXqqwZkUYBzQgAk91A2KFuL3avSYIL
         3fZw==
X-Forwarded-Encrypted: i=1; AHgh+RpncD/C8FwAlt6rxWn0/YqDlfcWk/iDXCyJR/qeTFdDZ1DTtzvsJ1mYW16cRRBjfvSavjrlsew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasxVii+DDtBd3Oy3YpguQXSmxLJLPj5ITgsjCsyUpmt78Z09P
	SeMFOagORQgQlMK/Vs9dXQGSBB7PgiZaQ8/EEtehRivEtQatjbxdLhfCLwoh2uxpec+eXmL8bXo
	Rak0SDXI5cn4TBSvBlqzbRt2BNeQwior6UnLtVK6O7ktJwiobJH+UxT0KwEE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198e:b0:492:3ed0:9073 with SMTP id
 5614622812f47-4ab69f33230mr1328274b6e.4.1784953953702; Fri, 24 Jul 2026
 21:32:33 -0700 (PDT)
Date: Fri, 24 Jul 2026 21:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a643c61.a2ea2cc8.fbad6.0011.GAE@google.com>
Subject: [syzbot] Monthly net report (Jul 2026)
From: syzbot <syzbot+list5e1151440ec5d571ba68@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 2 new issues were detected and 7 were fixed.
In total, 56 issues are still open and 1759 have already been fixed.
There are also 29 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4131    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<2>  937     No    INFO: task hung in netdev_run_todo (4)
                   https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<3>  690     Yes   INFO: task hung in tun_chr_close (5)
                   https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
<4>  639     Yes   WARNING in inet_sock_destruct (6)
                   https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
<5>  491     No    possible deadlock in __ipv6_dev_mc_inc
                   https://syzkaller.appspot.com/bug?extid=afbcf622635e98bf40d2
<6>  447     Yes   INFO: task hung in nsim_destroy (4)
                   https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
<7>  165     Yes   INFO: rcu detected stall in sys_unshare (9)
                   https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
<8>  116     Yes   KASAN: use-after-free Read in qdisc_pkt_len_segs_init
                   https://syzkaller.appspot.com/bug?extid=83181a31faf9455499c5
<9>  91      Yes   INFO: rcu detected stall in rescuer_thread (2)
                   https://syzkaller.appspot.com/bug?extid=d5f7a5097c24c7c2dbbb
<10> 1366    Yes   possible deadlock in hsr_dev_xmit (2)
                   https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
