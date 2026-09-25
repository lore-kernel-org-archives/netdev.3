Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F84734E2
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339620; cv=none; b=rafgpkecpI20hZu0VkzvOKuGEFFE6QWDLR02eCfy0G9Pw+J/ayu490naaYBuEMSsxHTnrOm4pWfTQ8VmB7Lm/FQmzEVo6WuXg02bnLk5QirWyV1xdjQBqxE7MJUz6mn29O8a0tlCZyCCa6g/+Q7FiLCfmjEcA9whyDsgXl5P/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339620; c=relaxed/simple;
	bh=WN3pSoYU9cdvre0ABEdZ7GvzLTz1/2Lz1LP6gItmKp8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WYSI9n0PNLI9LnXIChlVIvJB2SsfzEa1Hnuoclu0OnC2sA49cwC7Z3eqW8JftfChDgBfEFdfUVRpxcQX9oe+rrBQxCzRKmtTpTp/ZLCjCKOaWiIqYH1gOlaF/lLSgQJi9EIeCF4q6/iZ8H7NMTNiGghnjCUnu7hXRZC3VROpwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-482966c4f4fso3159541fac.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790339618; x=1790944418;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTvJAREw4fBrRmC0o4M4TAzqWax/qhWP2VADM3U9C68=;
        b=QmhgnKgvveyzq7i3MMDKAjfShS0XpxsnIZdzX6y6S9QH/5wADkzCTeHwb3S3FFjzRI
         Gr0Y4jYf+rUnxFR3YEIF8ekrEYyCXpAkepw+ucMCToS2vp3ukvcj1Ff2UVvrtcbB1oEn
         3lI+NtiLoDSlIsDlOIqf0H9GmSLA3v9p/nEYA5Mb9apm4lqSJ+J6UxcPS3wFj5Q6Uw2I
         bohjh3CHyatEu+WIQVp8pWlS1yfwkmYCROjvBNgClsqnPHzDBiO0Nq4fqgq1w2gtr2tO
         qMGgtgnTb4mhjhxeNxVudgYCUnVdeuzU0IMwEBUQilF+0Rs7pDJEVMJGBUOYHgjhKZNG
         7r2A==
X-Forwarded-Encrypted: i=1; AKwUvBzBrQjoiq3bKQdP4xQisRsh7IggSVGpwwmPECqegHYZylqMeslK3XgT6MyLWJwKKQ0rnjVNaV8=@vger.kernel.org
X-Gm-Message-State: AFuF++n2sMHbzYLzRHgC9/dAXKF+J4lb6OGatWribCRx5DACEC3sdWQX
	0FxZt7pMI5zc8Dl7BBuNRViVu3WsD7FZYohAxTWkqzFE47puR+Uojg1SQLIkTaQP+Z2f2KhVUq/
	AfG32aFRAtzxRCObkB3FKbefTsMMJQp///cpwqzwQA/+wRTOknbDcbgJ1UlU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124e:b0:4d6:9133:cfea with SMTP id
 5614622812f47-4d72d15df51mr4330904b6e.47.1790339618397; Fri, 25 Sep 2026
 05:33:38 -0700 (PDT)
Date: Fri, 25 Sep 2026 05:33:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab66a22.80e1c6cc.1e8e5f.0032.GAE@google.com>
Subject: [syzbot] Monthly net report (Sep 2026)
From: syzbot <syzbot+list9d8ba8e7238408167f9d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 7 new issues were detected and 15 were fixed.
In total, 56 issues are still open and 1793 have already been fixed.
There are also 30 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  816     Yes   INFO: task hung in tun_chr_close (5)
                   https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
<2>  641     Yes   WARNING in inet_sock_destruct (6)
                   https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
<3>  509     No    possible deadlock in __ipv6_dev_mc_inc
                   https://syzkaller.appspot.com/bug?extid=afbcf622635e98bf40d2
<4>  500     Yes   INFO: task hung in nsim_destroy (4)
                   https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
<5>  126     No    INFO: task hung in rxrpc_destroy_all_calls (4)
                   https://syzkaller.appspot.com/bug?extid=1c21ab751f6531a595d6
<6>  43      Yes   UBSAN: array-index-out-of-bounds in llc_conn_state_process (2)
                   https://syzkaller.appspot.com/bug?extid=628f93722c08dc5aabe0
<7>  2574    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<8>  1209    Yes   INFO: task hung in switchdev_deferred_process_work (3)
                   https://syzkaller.appspot.com/bug?extid=d6bbe0f5705cb8a5aa2b
<9>  676     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<10> 252     Yes   INFO: rcu detected stall in rtnl_newlink (5)
                   https://syzkaller.appspot.com/bug?extid=2e90866706ad999df132

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
