Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5E381EB9
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788047046; cv=none; b=Z2dBSgguy/5Biqk8bjxaudtoX1JiAp0m1EBncPA+PENFRbK/pv855NGnNJMMZteygwD5ajTPTYQQaH8VrV5vp61XVSkpRqigqkOhBIeTJrDnkO4JkhKIBP6BeQek2I5k35Qo5W3OLaJ6LBmGltGX8TLf0ClPfCZ2TGgzK6UWV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788047046; c=relaxed/simple;
	bh=XyRzoIt9BKjeu+ZuM6OpvFtJ9CrPATeITWgkirouklA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TPYHujGrgGfmtDouQ8SLppqZoi1PGdIs+dWPGNi4M2ZH9od+yO5bRwAk0sJi7c400q4I0A7mkidM2VUUQft6opOxPartAppO8MG1/tsl6jiP/HlNIA+cTdzsdngJNrDEv+o5JNScxKp0KUYQM/nbfQwoOwTOguYzaeKv6MbSnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b28d9952a5so3652465b6e.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 16:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788047042; x=1788651842;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DQBWUg9lR1vGNw3aL5E0KsvI5tTpdhTutZWPXYdUw1M=;
        b=RY50BiZHonim9HDdNuI5eGq59md5S32Ft0RL2T6joQhqMz5mlMemq11KoftG5x0V8N
         jphsND0ECoPZ7qst/BQ1aHogNvfO0gQ3mJq3cMXbsdM61JD0JO7R79aPt9nzXSOw3jQ+
         /3NDubxbTVQzo8zCNuuVN+n5Ve0khYN/ToK+TV5qE32cAFYGHVl+4AYsjlRkXlGRmrXK
         UTnycUXkojldHfOcZMoHm5prwj/O8BCw88e6GZrBLOfF/HKPQdoZ/LGgR+VnbBU+MQCa
         VEqYF0R0ypRMLLq+OfuuybkaMJkIJGRttmXmf8WWwBd/HzGFvqjAFXUSjlrBfjkJFOZn
         +I7A==
X-Forwarded-Encrypted: i=1; AHgh+RoVLuCGUWqv01xUngZ7nBf8pijD73qgl/cacWp/jtzQGIfA0aYr9hJ7XBT6ey69UPBdMVbANOI=@vger.kernel.org
X-Gm-Message-State: AFuF++kgo96ekQcG+8hb8OM7HM+9Zkv9lTQ8DJrBvwkbQ7180N4i+c/5
	cfGYYK4UqS8Vo8eVNKUsDZ2xHMWtj4TUSXqPlPlQJ1BARriVmhvVKylZsQ+DS5tWEY8v8cM0py7
	mO50IN6+XAJ2IxmdgFlEX1rUMbU9LLmxfKecpU8U5fyRzQyh6iaMwdDqb0Hk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:538e:b0:4b2:e9d9:f13f with SMTP id
 5614622812f47-4b3982ee646mr20396784b6e.17.1788047042590; Sat, 29 Aug 2026
 16:44:02 -0700 (PDT)
Date: Sat, 29 Aug 2026 16:44:02 -0700
In-Reply-To: <20260829145838.19351db0a28b30b7ccc1b295@linux-foundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a936ec2.4d659fcc.734b4.0032.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in __mmap_complete
From: syzbot <syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dvyukov@google.com, elver@google.com, 
	glider@google.com, jannh@google.com, junjie.cao@intel.com, 
	kasan-dev@googlegroups.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	netdev@vger.kernel.org, pfalcato@suse.de, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com
Tested-by: syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com

Tested on:

commit:         1b78070a Merge tag 'net-7.3-rc1' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=14e12c15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=e4aa91d7f20c34417d4e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f37d49580000

Note: testing is done by a robot and is best-effort only.
