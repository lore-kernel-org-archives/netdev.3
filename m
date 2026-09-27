Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82F3C09FB
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495405; cv=none; b=Iig+Hh3Oj9L+QHyqZphP6QYQvunmqz51O83TItOaRAOBXjIPYhhH0E/IJIVJOV8aaoRmZfEk5dr8oX8EDk4lcKQOWdq5Ep3cRwBMEpjZXJ4iTCM130yIz3riszNAJMwPorGJ7nfnY6Bjxr0I72/X3i4TNhkejs4G+jU0PacWBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495405; c=relaxed/simple;
	bh=MjheHG2ZPVtU7pbRctnGkpXFX0Twh1nIRjTFrpGW26c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JVki6JmWVmv0UaUbt+sds+FmAqN/FIjz03YrosJEbvDnMKHkZFShLokXyCk1nWoezHW9SY7QPSc6QS5zy3qQUA2h6vkiNVt9z0iMpEHZQgsfbrG09V6UClvr7q9Onc+Wrovjf6LHii1fsg0HJYq+smQCgZSNJlUhgSJKONJRQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e778acdbc6so1139426b6e.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495403; x=1791100203;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=707h2dOKet9Xzu5ZNoTuhg7nlxwDzTukl3D9vbYvzfc=;
        b=hRuL9rVqldo6vUPBYfIlMHwHFiVL+scbofSmvdWFO74SY4iTrW/TRIN+GkeVtUbyoy
         CyfEvSD9W0dEE4/2Rw0oU2ULQXVp460xDdwLBUizyOmYruc+bYs0b8HPDeRUGtS865vz
         Jnw88xI8w8R0bJlyE3DglnHoWMn8gpABVjveoz2XSeuy36eu3YBTnrJwojiVvz2kgjNd
         yd3mhqsZSlIWR5oKpFuTia2oh493r07ggW+z4kLtgUPmLdaM2tg4izCuttnTWjwuZgeX
         UgJw/3sIeuglO8FpEk78HnocqPSz867V0pBMVsN4dfhl8tdsZMYaGlClHeT4q0+utjuO
         foiQ==
X-Forwarded-Encrypted: i=1; AKwUvBz60q+0X4UEwHm0ZLFbpUCGyVCCRVQd4ZoP8ATYWcSPUZSPINNRQGI8PIZcB1UUC47ScQ0AZDI=@vger.kernel.org
X-Gm-Message-State: AFuF++n06163eC+ykBih0VXq7Su9AYb0G7uJJtFrU6wTH2W/HspJ+SIa
	YLLU3SDGBinKca0+Y+7TrN6+Bm8EEpyIyoC6OTQEzR9se2TGDdh2pdla7ktvJ0ts1JWptCVSomZ
	ZpRDLBDL0kc2H4MaCTOWa7GloYo/I2oVAaufXY5tgPAcwlwzTQNHur95dsW4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1706:b0:4d6:93c3:1af0 with SMTP id
 5614622812f47-4d72b845689mr11247450b6e.59.1790495403073; Sun, 27 Sep 2026
 00:50:03 -0700 (PDT)
Date: Sun, 27 Sep 2026 00:50:03 -0700
In-Reply-To: <arjJwc6yl3RkOTRK@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8caab.e548f532.1ca396.0038.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in rxrpc_destroy_all_connections
 (2)
From: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
To: azpijr@gmail.com, davem@davemloft.net, dhowells@redhat.com, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 25



Tested on:

commit:         a7bfaba4 ipv6: fix prefix route expiry in modify_prefi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=89001660f14fb7684c83
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17705315580000

