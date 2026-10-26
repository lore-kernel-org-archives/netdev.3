Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046824;
	b=0d0U3bx4d4JWdF5I4+sNhmwXr31gXCU0hSgaODyG377NZSoyuNTGf3V1FvOxAQebstRS
	 eLNkkdI0JmZ9Si6u1ZQIjHoP5cIpYn7nwOmPHXOYabYJ4QLk3az6rbFEgtUvtci6BSOHr
	 hAy6ZT44pS1LurUaSTKbtnrNAhxdvCE+kDR65+j4h7I8jMfHBCDVbKDtb66r/AUyq+78f
	 9jXJ2oGkPGXSQCGfAI3fArbsb4TunuX6IzZtPWjShW7XGDG+bDA/wBAMT13/77bQCM6j/
	 j9XPqJyWoAflMjjJ8r59N/pFLXklAMLdtJ34CXQmbPrX8LWTYfeQEJdsOpLvDIwyTlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046824;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=3uByF+XBf20d4oPmX+C+Bemtcg+uCCfvs+3UVHavAY0=;
	b=KFXhm32hART1/uYUuHEaEXZisStsrFC7f6ucQ5wvUjpeWh4TN9gyeSJznihayqRsc3rw
	 djD/d6jzkUV3hBH4A+gn9nQion0KL7KHVmDOmtUqVCyQ2Ik4JXoiEEjlT5A+Cebjadz+b
	 JA71iuUmhjq5qAMXZOC5dL6Dp3WKzRnuResRpNkvq+V6IjMAWyrjVlvI44Zu8JFlqsFnY
	 SpWNten+M5Ur5nV8Y9tFcReLCXFDTLDGRCkcYuWQQm3T1z1M05Koavdxvu8qztK40q1BB
	 LpFaWcXnvBHmtNQCmhmOLiZQOK9ut6UZXAi5VEt4KS0KZZCEOH5qm/W6QwCYENR/9Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31A606A322
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 20:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F31A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5384e381fbbso3388661b6e.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 13:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046824; x=1793651624;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3uByF+XBf20d4oPmX+C+Bemtcg+uCCfvs+3UVHavAY0=;
        b=vJ07PsWQNy80bvIY2wZGhuEkggXgWOYNN+9sYys5P3h1bEB6Q+eDoOrnxMizxy3b1l
         P31QERfSi82JSWVoEzYdoqgN9rKkYwR4JyDK6sF1Snw2GdwTABfEpLQ/YO6OmtGMbNTj
         KWsrTa7LmVVJKwvdhB8yQtZNhCkSTiHNF3NCKHSb/e/jUvptbHLqp7zM/0qhjhpiwzx2
         HjJe2Rw2IIq6mT41gXpXpFES+2kPfHiHeZWSqsy7Z3IKvlG3pyiSS5grVAyeShBNXkaR
         9iFJ+FLUpR86p1n237M+8nRirXFCRjyw0mo1W5XF+xSzRMymbtfaaqzcDtovG3qBil+w
         2Cjw==
X-Forwarded-Encrypted: i=1; AKwUvBwfYTAxUSXm/t1rAnRWxxNqrn1SIbfpiLjmy07sv5Su95vrpl3rkmVP2YkvsKVdPXw3SvNiP0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC1VLPB5FRgmse1/L6NzF1m5RrtDjfUYHsCz/7ZthqpeFQudRE
	3cyrNKHVWQoK9mSdjF3dfXpx7X+EW8tof9mg9NnCelQyfl+r3j1tt0DOKaYFBQC3rH3l6djEo6d
	2gkdp24T/NjAfrKaZkA9//FJBSFmD1idmn8sdi94XO4u+vCudvq0gtvGRLIQ=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:48db:b0:55c:844:98b3 with SMTP id
 5614622812f47-55c08449eecmr3673448b6e.50.1793046823825; Mon, 26 Oct 2026
 13:33:43 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:33:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adfb927.3a3d6196.2ecadf.0022.GAE@google.com>
Subject: [syzbot] Monthly net report (Oct 2026)
From: syzbot <syzbot+list402b67683d6a416b29ea@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 7 new issues were detected and 6 were fixed.
In total, 58 issues are still open and 1801 have already been fixed.
There are also 34 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1034    No    INFO: task hung in netdev_run_todo (4)
                   https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<2>  917     Yes   INFO: task hung in tun_chr_close (5)
                   https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
<3>  644     Yes   WARNING in inet_sock_destruct (6)
                   https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
<4>  554     Yes   INFO: task hung in nsim_destroy (4)
                   https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
<5>  520     No    possible deadlock in __ipv6_dev_mc_inc
                   https://syzkaller.appspot.com/bug?extid=afbcf622635e98bf40d2
<6>  203     Yes   BUG: Bad page state in skb_pp_cow_data
                   https://syzkaller.appspot.com/bug?extid=ff145014d6b0ce64a173
<7>  45      Yes   UBSAN: array-index-out-of-bounds in llc_conn_state_process (2)
                   https://syzkaller.appspot.com/bug?extid=628f93722c08dc5aabe0
<8>  40      Yes   WARNING: suspicious RCU usage in phy_detach
                   https://syzkaller.appspot.com/bug?extid=694b49f41098a5df4fd7
<9>  29      Yes   WARNING in dev_shutdown (7)
                   https://syzkaller.appspot.com/bug?extid=c9ecf60a8adb7629821e
<10> 25      Yes   INFO: task hung in inet6_rtm_deladdr (3)
                   https://syzkaller.appspot.com/bug?extid=55141a0ffa0d17f01c71

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
