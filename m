Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044A2D592D
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809464; cv=none; b=QbHrABnTmsfCmooKTQYMPlA/bEp6jzlfUIC3vCZa7I01tQSBzkivmSm25kNcnrC+RYCfbShIZzG4r31D0mjP/oCpd2MbwzO/RVCCVdb5DIgu75GdMDyS9FO9g6qO7jYQ1boEnEr8/g6aqBp/ekwJLfL0gDWgb86jcTOfRMrsNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809464; c=relaxed/simple;
	bh=Y/f7gKfTtD3caAROXXmlez0v7+lxdkmJJ2ksmNTB8Bs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KCrknc3geOlTuMBbZ93HXm0n05ytq0MzQ5oxAD4M3QLE95Xy2moONZhLZC56bjDiGEfmYGUXUkcf3bl6wzjMbllQ+6L7J7np9IHyPoAQS1B9Z4F14OoSXbFgsl2ieTXD5CMx+sDbjIzrOvl/O+IRy8ZDRhNKF0pUwzXvLReJjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7f653940ba4so4880898a34.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809461; x=1789414261;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7xhFNaP6KQHnAXOKkPy8YZJSop4UrDgQg8b1cvrfSdQ=;
        b=mvaYYF9qThRpMCzkE6LEHYqGv3/K6xM8j6u5Wmqnu+9t8uMh2QmSb7sIhX0rMNMa3a
         9ypyXSp6ze9WMI+LwPzSNJUEpPg9LdrYPfTp9Xsp8LzFCzP1/FqEpXz+tNpRCVHRIldl
         +9Id2C/c/RFx8iJPHsUQJELuPogTjCG/tSN8zOX/scUo5PIbMdon27snIZ8dPa0oof7O
         ROIW8MKqzNUG9nPatp7F0NQyZjOvqan7+z+oewYGFwyAGgiXVuZ6m422sF6xmNZgK5i+
         p/GWolKlrNq8h2oZCNLvwzfg6AluH+2kK6s3niLWG/9ybsBgGZLoCEeRmeRnX+6uQvU8
         js0Q==
X-Forwarded-Encrypted: i=1; AKwUvByXF4aBSVOO0VbHV1gswSHcJymemavlkCya4Ts59czhrdkitc0WjWoGqle+sylK0yaXERmgmbo=@vger.kernel.org
X-Gm-Message-State: AFuF++kkQMxMv9vqVd2jcUQ2HNZ/mmugHg/TnZ4ZgpI0hXZ4yU8Ekocc
	NIguNulyEx61npjddha/ihNakb0RrapOCJTLozODBgACSv7aYt/pz5n4++XcupObdTBFMXHM9Bj
	3ExW8QY+lWIfGBB90yZA1OOweUgtBC79JZSmDUT6QMETDeN1/eSjN/VsMHx4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c3d6:b0:6ba:3635:800b with SMTP id
 006d021491bc7-6ba36359f2amr3741068eaf.68.1788809461737; Mon, 07 Sep 2026
 12:31:01 -0700 (PDT)
Date: Mon, 07 Sep 2026 12:31:01 -0700
In-Reply-To: <4c018446-e4c0-457a-b2d1-a5bf856d0e2e@slotpi15m67>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9f10f5.2bb5a69c.24b23c.000a.GAE@google.com>
Subject: Re: [syzbot] [nfs?] [net?] KASAN: vmalloc-out-of-bounds Read in rpc_queue_upcall
From: syzbot <syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com>
To: cel@kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com
Tested-by: syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com

Tested on:

commit:         5965280c SUNRPC: fix netns use-after-free in write_gss..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git nfsd-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1374eaf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=d5c77cabf7a3492aa650
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
