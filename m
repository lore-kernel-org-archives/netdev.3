Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680440;
	b=aU6wGeBZ5Yz1Z9IZtp7OkN506L3WxoS7BOY9zrbavEAOMWKWTYOBcvCcin7d6HLQwKIQ
	 3UEC4dHz3Z7JP1mgRkHtt7lHRe2UknGpnY14aV7SbSpJPbTLFO8+lNpIscPoRlJ+GX25h
	 Ezy6qL8ZQ/q62ORX9S2m7F+Uk0iYqDhBB2hFtrE9ulsdPHGhNhiA1jcS1X4NMe+eLLdJw
	 CqIF5d/d5dKmmZir9cC4DtBH6BeQhnBaYBWODx50SPGVs9V6mNToNMa6phZMnKfwRQ/md
	 +DH5rDoF87/ZAhPJo5omQxC7Ym3r2KLUgN1Rp2mVVVDSz7owD7PnhoqsOmQyANlOdeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680440;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=4tPs4mp2bvwQdRd4sbq6CaL9zCSxrf0L6Yrn8je4uH4=;
	b=d1m+8PZi/5Lhwl2X8aRyxTY1887u87O40lV+UkCPc8vq+DXmEjTNfRg2a2TdsfV31KKd
	 W/nPDHfbjOxK6tY+vv0PptSS210Y7NoFxv0KDfwyLAsGRhOSIyNBWxPLlJRnqka1OzjpH
	 uYLZ5Bj6GhodcWJGLEenGBEfduq1aHC5krMJS9qZ6xngM7WHZaOG5vwlepo2AjFTVqzWI
	 BFxnUyZbSgZlGrU2e0X88764TMwQTQEcIVgdDdmKCn/iVPoPUltExoaDnTVJR5FpAq8yV
	 /om9vH/KkxMDZmkxsQelLoMPkZ3+fITvYCrvi0N/c0o0pSyp/FmOoA74Db65ro9/GGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BC606A32C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D51BC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b597558c4cso5629824b6e.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 20:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680439; x=1794285239;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tPs4mp2bvwQdRd4sbq6CaL9zCSxrf0L6Yrn8je4uH4=;
        b=WK3yk61djE+KyTsrOXhV9MRX9FY7qiab0DNLEWucCMg7YuYtCP6pgjqmRt0Mu2+4We
         RF/S94ioI3gBA5QQQP8J/E/Csl1zRWulVHWoOQWGlU2zzMzVijTCsplksomg1GkK0Zvu
         LVugKugv1aPK5IjabUz+AdcHe6CvBoLbof0PgagyqilHy0C38wlqvJsq9x6Mp7gVV7FH
         T84xsUdZeY2wi6OWrXRoFNNNjznv6xTQlWwebFJfATIYjxwE8SBaZoQ0uGyS3+buVpnh
         N0eQEMmHKCzSV2FvU+aGsHSUsltDE+9SIvCy5YNZD/Fp8lF6Bt8yOVMZNMCM9+mQIqmK
         5iPw==
X-Forwarded-Encrypted: i=1; AKwUvBzbqCmXdqoXlapvVmq12eC71ifY6+sKySkt9CAIzr4SS2d5Px4m/zkTJX1DfIYivTwpK0dF/nA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhP3IVtBA4t45KsV1AbhpuSNlw9pIuKPHt7IM7aMIQGubzeVgz
	arhBPsHt4i0N9dySzB1xmUpitzI6vd1L1UCcEUBQeSf3ygCvKCm9gW+IJ15HmpUP3Xzn/aKoi0U
	fra7dNFyoYFOlLbBHL0vc5yshL233xojP5hCFQdYW5dEf4WpfEiffTwurpIU=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1910:b0:4dc:1374:99ae with SMTP id
 5614622812f47-5640e033037mr9173554b6e.56.1793680438963; Mon, 02 Nov 2026
 20:33:58 -0800 (PST)
Date: Mon, 02 Nov 2026 20:33:58 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae96436.abb90550.19e2c9.0002.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Nov 2026)
From: syzbot <syzbot+list484d79b18bdec1b120a0@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 1 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 200 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 151     Yes   INFO: rcu detected stall in rescuer_thread (2)
                  https://syzkaller.appspot.com/bug?extid=d5f7a5097c24c7c2dbbb
<2> 7       Yes   INFO: task hung in nf_tables_valid_genid (3)
                  https://syzkaller.appspot.com/bug?extid=83439cb981624bd8d068
<3> 199     Yes   INFO: rcu detected stall in br_handle_frame (6)
                  https://syzkaller.appspot.com/bug?extid=f8850bc3986562f79619
<4> 132     Yes   INFO: task hung in nfnetlink_rcv_msg (5)
                  https://syzkaller.appspot.com/bug?extid=c4b20b80ee6a7a2f5012
<5> 98      No    WARNING in nf_conntrack_cleanup_net_list (2)
                  https://syzkaller.appspot.com/bug?extid=122256c3e2bf6ec9f928

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
