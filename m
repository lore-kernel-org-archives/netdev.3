Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939632;
	b=LpYhtWn9alIfloWI6CWVC6O8A+rj8bV0iDLr3G7fM9NWnTgYVMdVM2NvrNFGhnf8mO3s
	 61sZ6dArmH7hn+JSkQ2BtLCGTUrZhHK+4gvQa1udCN9PtdEWjZYpk3hvqajs3N4XAk29P
	 qDvmACz/54KjvWueNObwW9trJ6FWOyZer/6fxf6oT0hUjHLutzQH/gQb51be1VZnbNPe6
	 qs2n7WZBrmpDkCRWzhazWTX7JKSBVIUXDrP7Il9zSNE/+AOeAdtrTd6xVoZjWuThjuFHK
	 ay0c+IHTUoV0SZp33qsk4H+LvvDItSrIrHOiNKg/rs79WWWGt7eNsG6yd6ZTHIb3CqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939632;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=UjmvlMxMfsOJ2MipGoWSWM8HIKzXWVlbjvE93f4mWOI=;
	b=4g4bRdr/xyZ8V9ArPNj5X7gYkwJ9bfk3eod9CnUfGGH6iHgPnKY3AGrDcfxm5nXnwL1B
	 MHZwlK6YTn3Vk2goEJPCszFAnGt3DWDx0oK2TjKig4wK9BqwUMtGDla5uZl792TWqFX2i
	 XhUScNR2W8xiEr0ACIW1kmWp8LNtkcMNJ/MIEW0I8bI5wfIcrzhTskaz6WeRDMaOOHovV
	 dgfAsWsXVbwc3vPL3CWHg2MSTa7/batKzeV5OjQC8jNki0eYqWQO9yi61XcY18PsVx0gQ
	 WFhI+5Tew0DUrzZBq8e065tfkRozFncLSQ1ARDsATPsQ8SqOy+VmghRKJGauGngEKxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D24606D814
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 04:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D24606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-847e2926d94so535637a34.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 20:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939631; x=1794544431;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjmvlMxMfsOJ2MipGoWSWM8HIKzXWVlbjvE93f4mWOI=;
        b=bdVipnyt6LE2Nn0j3g4kqFqQQNG/yJO0EENMa5AnqrxXzulvtKnnd7JlpJmtwobXvp
         2w5UBQsydjmoIMWzDK6IRiahqwhNOKLGHEQH4apPqUfH6ne7K0ASM4wfh1Yd1e/EzPxA
         iYSq2JfiwqA7qkR7V/CG9PFEfCF3yG3yVp7EmKZPYgVXp7sCdifgsjxyVoKSOFFKBhex
         GQhbPtijHBHygaN9Z4EKv4INkWOGQsOL2AMLLJuZprxfZmyo5ALRu7TPyxifTlUl+cV8
         H/t9eilt3AqDOJBJe0I2FTWSoXA0LL0KL5Vvho2bq0jBz9UWC1b8d2UXzVYW7RO+Ii0B
         as/w==
X-Forwarded-Encrypted: i=1; AKwUvBz4aVMi5i4FewbC8uN0LbBKeRifr5TZ0F5X1oMk+JhA2EqzHMepnCaE0Y/H+pCZhDPujqeik+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ss9F/yXW9AVGNHmAamsieWDWlWrBJE1sJ9UpYrszIn+qefaOQ
	vUAbnaEuM5a9WnGDFCwL5oq9wGu8dXQEKhO9koUFwZ+MtS+4Q4XCl0FQiPB6VPqXGehDafKfpR6
	/OwJy58+id7Hf/JxL/jLkEUqhn2v1O+0AidgAFSeKLDqvYhwlX5G2+qTey38=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1828:b0:4dd:18c7:5448 with SMTP id
 5614622812f47-567e16d6313mr1093975b6e.56.1793939631120; Thu, 05 Nov 2026
 20:33:51 -0800 (PST)
Date: Thu, 05 Nov 2026 20:33:51 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aed58af.02d3f859.2829d1.0007.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Nov 2026)
From: syzbot <syzbot+listd640a374c372365da528@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 1 were fixed.
In total, 16 issues are still open and 219 have already been fixed.
There are also 7 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2134    Yes   INFO: task hung in reg_process_self_managed_hints
                  https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<2> 1236    Yes   INFO: task hung in crda_timeout_work (8)
                  https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<3> 365     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                  https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
<4> 63      Yes   INFO: task hung in nl80211_pre_doit (3)
                  https://syzkaller.appspot.com/bug?extid=da14e8c0ada830335981
<5> 24      No    BUG: workqueue lockup in reg_todo
                  https://syzkaller.appspot.com/bug?extid=b733a65a200ab7aa2cbe
<6> 22      Yes   INFO: task hung in cfg80211_event_work (4)
                  https://syzkaller.appspot.com/bug?extid=5506b2556159a1ab6923
<7> 103     Yes   INFO: rcu detected stall in cfg80211_wiphy_work (2)
                  https://syzkaller.appspot.com/bug?extid=858514d213c2ff9b671e
<8> 4       Yes   INFO: task hung in wiphy_register (2)
                  https://syzkaller.appspot.com/bug?extid=e79f3349c93df8969402
<9> 4       No    WARNING in cfg80211_cac_event
                  https://syzkaller.appspot.com/bug?extid=3df76a08d929e91e5327

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
