Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBF38655F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257088; cv=none; b=VAbiYLSAjaxrd48n8umPxMoG+wWs6xZlfz0qcnYfGysXRUXh1yAt8DijGwbnOmtHneBbdKKdUluiyTIUx12QUXT5JZ4r7bwtf9sTW/Q1X+FId0jRm4FfKAEpsgY5cAwKsYb3P5at4YjRPW9lxo/QBIVFxv0AqtQw6vaN3wJRD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257088; c=relaxed/simple;
	bh=fj77qGHID4lKwG1dct2LL8Fo1sBr36LBHbO2qhPD5gQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SmOfHpgl0BxPZJy47JtuWG4ofcVYHiczS9nGnhi5vcOtlgeF8OHPYlpYrWSPFrlqEJwT3qv6o1h0MSZfaesjRSkJ7X/mO3DteaOqCEg0hpuJq8Wctinlec4/xLLYgazJ6eWojYOhvDK8DAczaDIKpkPIOoTHXUDC+hlcQ8HTHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67dec1314b5so5253871eaf.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 02:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774257086; x=1774861886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRj71m+Ztl8dWYbmnqswmpA98jKwc37SXTwiO8A5RnU=;
        b=Egr2hD5kAxvnrkyC6jRz5y+9+uqjvVwoOU4RIimn31uVNt8YXwBVq6CvDdEq/VFpvw
         PGlov5bH4OqIZY/jAYWWaOfMzexW1xpCQWooy88/zSrTMb/phNANKE0QPduVBwIE4mhX
         Nkj2Ac9d++H8BU2mScr4+Bs9Qr5psnrDqV7m1PthGe7NKD7l5GCxadHqBJPJpgsb7hqr
         v2MtgmOm+sgSFZI8LKRhxmEbFwFLibnTlm5MX5DK3gilLpRa1QM3Cq/ng3mG5p2FCEpB
         9BNKJOcRyxkCDgQKXAWiRk2BkDnI6j2xmCADA8hctALpqhgxK41wmTntLFJ0U4TqjQ01
         DgPg==
X-Forwarded-Encrypted: i=1; AJvYcCWks9xcE+YzCzsukbIAGyx5OaE1OM8JGqBsNRauNBhsN8CpC7BlhrBlxgbKFvTl+dS5LJNFKNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznoHKTKMRBMEnrZp7nqRxSYVGBURYd3958M3sFqRnGM+7gECEg
	1m5AVbk2+51eRdjDI3bdT/HCNL/GpY1oEpeNO6FP9CyE6qpdwTSsAAr9ma3pKdQlcROysvQlHOB
	T66VCnSAq79TUdPkklZw0opKOW8d24WIZTvvGQ49p74s5uH6L/XtPy6DTfKU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:818e:b0:661:13eb:6ce4 with SMTP id
 006d021491bc7-67c22eca2d4mr9304809eaf.21.1774257086459; Mon, 23 Mar 2026
 02:11:26 -0700 (PDT)
Date: Mon, 23 Mar 2026 02:11:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c103be.050a0220.3bf4de.0096.GAE@google.com>
Subject: [syzbot] Monthly net report (Mar 2026)
From: syzbot <syzbot+list481eec3748b6b7b5a470@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 5 new issues were detected and 12 were fixed.
In total, 86 issues are still open and 1711 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8474    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  3481    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<3>  2911    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<4>  2768    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<5>  2101    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<6>  1995    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<7>  1650    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<8>  1201    Yes   possible deadlock in hsr_dev_xmit (2)
                   https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
<9>  626     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<10> 609     Yes   INFO: task hung in switchdev_deferred_process_work (3)
                   https://syzkaller.appspot.com/bug?extid=d6bbe0f5705cb8a5aa2b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
