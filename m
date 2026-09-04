Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6E483BC7
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525212; cv=none; b=FFsSj2asFkAMC4eA2rG40ZFeZON7gd8KEr/IltaA7gfXxudw/ixqDfnbi93/RmIdrR6ZQ2jemueomrDef333l2pQGGAudy7KtFjEsUE9JwaBCuKXuYJQ3UfLrr2AqD9rkRrcTGRR79GhzfhLDaj8X838KeUUs1vpn+g9dMjdojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525212; c=relaxed/simple;
	bh=6cA1R47l+Ut13D53OwKl+8LCdv93Kf20QST4XLhE0hY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ec69dHpLKcGZErU0ZoGkMTj69kgsG54Qe242ogXmYjV96MlN3jAWK7xlbM4rFYZXybgHdSUbj0oSp2MjJoPC5cksXx1wBSxsxLrWB6u/bRX5a//bsuPOwCFIObhEiIYhhzQ+CNRFm9Um2f236w2OsiQVkyme8abgs0eUNczojKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7f8931a803cso860063a34.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 05:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525209; x=1789130009;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3T8K8b+Fm5nAYe7BSndD85TDCM1WtUxVuFoRmZ9hwlo=;
        b=qj/aeA3LttLnjjw9E52VuPQvK2ZHY5LcgHHoWVnaN8M+O+6mOKtNAgxqezE9i3ztiv
         +7ADco4vLmC74RM9hRQxPTxIZTuo6BYnptryK4ja51h7d7ejv2plWoDgw6iSeYX/gQTY
         /xhdJOD19VEXLWv/I0OOevPD5rdkxkW9o3s9OLl6WiTY+X6cl8ygt2lZSp/RlbUM0Sjn
         dF4cf+d0wAish/+STm61J43wA+zFQQvb1ZEaidNaBqqd1CSeiksB7ftQ57WLXHkEcCej
         CV0fpNgV7A0kZF93hwywX0UqMYjIi+M8H8K1fdT6mlbH5IoTskpuEfB9bsN80fS1brEO
         SvfQ==
X-Forwarded-Encrypted: i=1; AKwUvBykYfHkrdXCaPT8cK9IxlX0HQnAFaUWm3MCfCZgd2LaHXUPGTtB7YeltgwJXMG079UHxhtpLkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kkyGujk1jMr3kVWXBU2OuncPdHPQZbUbivZcHviqJn3S+IyQ9p
	DF1TWY4ANTnV0dAvb2mxdROBxCkcRSeoWZPM2+xT0MOJ37e31/Av/52Aiz5lEiobRSPIotk6+f+
	tu5HMW06KYtpeNcc4EmUuJog9FMZzYahnmFyFrV491didDb+hfho1yeENcBY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:810a:b0:6b7:46e9:96fc with SMTP id
 006d021491bc7-6b746e9a31cmr2346901eaf.44.1788525209411; Fri, 04 Sep 2026
 05:33:29 -0700 (PDT)
Date: Fri, 04 Sep 2026 05:33:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9aba99.efa90033.8a9e.0004.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Sep 2026)
From: syzbot <syzbot+list297c04812c0701bce1d8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 1 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 183 have already been fixed.
There are also 22 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6988    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<2>  1394    Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<3>  732     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<4>  355     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                   https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
<5>  102     Yes   WARNING in cfg80211_scan_done
                   https://syzkaller.appspot.com/bug?extid=189dcafc06865d38178d
<6>  51      Yes   WARNING: ODEBUG bug in ieee80211_led_exit (2)
                   https://syzkaller.appspot.com/bug?extid=e84ecca6d1fa09a9b3d9
<7>  44      Yes   INFO: task hung in nl80211_pre_doit (3)
                   https://syzkaller.appspot.com/bug?extid=da14e8c0ada830335981
<8>  20      Yes   WARNING in __cfg80211_bss_update (2)
                   https://syzkaller.appspot.com/bug?extid=1a797e1c81be78a2ace7
<9>  16      Yes   INFO: task hung in cfg80211_event_work (4)
                   https://syzkaller.appspot.com/bug?extid=5506b2556159a1ab6923
<10> 6       Yes   WARNING in __carl9170_tx_process_status
                   https://syzkaller.appspot.com/bug?extid=381102a7292a374fe8a7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
