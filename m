Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B435FF58
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786946524; cv=none; b=buA6ZYLeas96v4rCJEXDf8dcpfmu+h+0nmJ+BW6VSG2MzomCFWzR3Iv89OVPW/nEQlqDU9JsNjato914badzSnX8A0d/zKCrR9QqaJFl/uD5hxUT4zZ5Ytr66mXvQqcmCJcA1+Ux0lbUB8hzkQMMKrYjuATPW8Hggh6pvy2VH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786946524; c=relaxed/simple;
	bh=qXmJafGkcN6mwo71Q4S+fqyqawYMUw1tEIBKeZhrCEQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eiIV0RfB7Sr/fi/EjJ+zsU671R2MkDe/i9iAgDU2I4Wo2e1gF9C97fCu0yMf1g+bBMG7yk6fz5Q3Oz29g+xkbHao1VquhTw1nvPYK00dox9grV4C4wHvhF09AezZSZSsM5Kx9/OWnC+c+OOrTYrY90woXFNUKOYF8dgOjsKAqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a17dafd042so252755eaf.2
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 23:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786946521; x=1787551321;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NvBAJ1wc5C6xZlpPmDjItq5dHkzr0Wm85xmMFTDijQI=;
        b=V1TKWgWm/VRiGttBEEof/Gb0fpgH0nRmOcjS5m2Ll4claZuq++Ikt3440oYPnYBKOX
         is6lzRUX+5gXVSe6l+YozcT+bmNnSsa4N293qOVImKxOex/vBfXui4QRDoNRV+mRrOuw
         zbhH/UMfTf6gmLrOGJCX846JAAgGRF4UlvOwQLsnyx1WEIFym6lRlVF3pRQBubtpudHp
         8RA6KF5JyeSBzcy9Of215U9DSAvjyhl289InWqKDjeavVF0Cc0/2fGIMVfvFy+Qemw9x
         yUhv0qTKvKQ6pWcpPEepQzxZyPYxd1FpDYn+nT07ocmN2QvfP9E6HUPBU5KhlT9vMF9l
         w93w==
X-Forwarded-Encrypted: i=1; AHgh+RqJywizygA5GRWWwBIAGO0HFA/vrvrEOumNUcpE5LzqpzsKhGNwvVaSTaJ/QrGbLLUSSnavYmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRI8VVC6coB8sVAcD7tbJvlKIbLrZEEwHgDA7v+mYY0sofIau4
	2bt5ohRYL7RANIFwFjaG43GEaHT8RRHt3RHF66e5sjlpal5rnCuiCAt5QRseZzJ15sdd8sAGt7b
	G37Q0jnfwGGjJFxlNYVWzf0yzy/AH8ZO04aVObYA4iRWo9D/FONmLxfBrnQk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c98:b0:6b1:30e:75ea with SMTP id
 006d021491bc7-6b1030e8361mr8279011eaf.16.1786946521575; Sun, 16 Aug 2026
 23:02:01 -0700 (PDT)
Date: Sun, 16 Aug 2026 23:02:01 -0700
In-Reply-To: <20260817072146.313493-1-junjie.cao@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a82a3d9.f7a79266.2f965f.001f.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
From: syzbot <syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com>
To: hdanton@sina.com, junjie.cao@linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com
Tested-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com

Tested on:

commit:         24ef02f9 net: page_pool: fix UAF in __page_pool_releas..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15742679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d07fbc6821d72a61
dashboard link: https://syzkaller.appspot.com/bug?extid=2642f347f7309b4880dc
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b1ea25580000

Note: testing is done by a robot and is best-effort only.
