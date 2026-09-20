Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DA37F01D
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921566; cv=none; b=NTOe9shyzwkQRT/4M4zOUeuKfcEACJNd1aFQRmVgbVpvexeaOiJk1mHs8FuvkhZvKVI+5fI2JpS+IqwOUPrLq8IhLM6kTE7EMaiR1yDq2kT22I+02J1Qxp9WlDqNkl2nXQ0X/VRO4409VkaSOklZ7PDgLKP9J8LtLHf4U4AeeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921566; c=relaxed/simple;
	bh=Fjjho6VJw91VrAcRXjopNv8ysWLIDFycL7IuPex8zgg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VbQ8JdPiH7duLl0OfoL89ZIwXDqHJmtEgH2XaSepj8WX4wCbEB2Xi2PDXvDnpdGuAorbiLPn/WzFyNdVQwywTmkET6Mr5GX1Hg6fybd3g0ctnZP7zCe6GtFnLzTdmCd8IpS1a0Z+tfZf3AkL0B9/fjqb76c67Vh+D8RYaEhcpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-44899f99756so4340329fac.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 09:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921564; x=1790526364;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y09R4TyzDXz+1BvIReR3qakaXcoJY6bs098u2lGzhBk=;
        b=cZ+kzj9OgLOkc4dAsgfT9nAYnka7j7awJaXeTunCCiLJOM6IusU6cvMS7JZOfvQwCU
         UgCL/jNrOqkbqvaM+9Lzwbzys5T0zwvKVNxdAxmviYptK6fIALPTTwXW7E36q/Wuz+AE
         WOnjysY+/rjjo43/+GiLdvPjH9PP4MWI4ehrmNB3klEp90MGoZXw4jeK/3lgEo2UpmeB
         aJon2dVlo4DT+aPGuOYfsQ+k24puSusDclJhnm8eLDJGwzd47WdizkkfO7fV6N/54nG0
         gWKWiS/NrtuWZieyxV93hX8BZMi22rW13Y4kj/RTB6uKU2+ghyCz2n0TY1J3qDxK5C1a
         bjeA==
X-Forwarded-Encrypted: i=1; AKwUvBx4gUrItUzW0JqQpkvjoa83rA7s85oj4UFkuL31bQT1b5yq/PlI64gJrfaV6WLJa2L1aZ/C95I=@vger.kernel.org
X-Gm-Message-State: AFuF++m/gJn/2IT0MozTzHsq0PuUJBfhjU+uqz++E19R17vu5AYT65lm
	ZuoscGGUEiSY6VDNSyDv4cyKEazHM2bd0DcckOl+7EiewkYDzHNtX71TEmZDeHFYxV1vV3+rZXz
	STu8y/fUXHS6wnv3fwWT/wmH3y5VH278vGtTNDUF7a/7zjtLEe5g1J30WXlM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c0c5:10b0:6cd:3fec:de7e with SMTP id
 006d021491bc7-6cd3fecf3dcmr3186064eaf.84.1789921564416; Sun, 20 Sep 2026
 09:26:04 -0700 (PDT)
Date: Sun, 20 Sep 2026 09:26:04 -0700
In-Reply-To: <6aa3307a.6e6c5f9e.28f11f.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab0091c.3179f8cd.1e36b2.0016.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in finish_task_switch (3)
From: syzbot <syzbot+b5ddc2aecb8d1b29c871@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, leitao@debian.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mikhail.v.gavrilov@gmail.com, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8fa30821180a9a19e78e9f4df1c0ba710252801e
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue Jun 16 07:09:14 2026 +0000

    timekeeping: Register default clocksource before taking tk_core.lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d09525580000
start commit:   50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d09525580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d09525580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ddc2aecb8d1b29c871
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ab4525580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d4e915580000

Reported-by: syzbot+b5ddc2aecb8d1b29c871@syzkaller.appspotmail.com
Fixes: 8fa30821180a ("timekeeping: Register default clocksource before taking tk_core.lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
