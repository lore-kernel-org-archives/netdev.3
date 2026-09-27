Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940F3B9927
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494930; cv=none; b=mMcGpJdK5mMze2w4RHnwJ9Q7rWaIsOC/FeQCvKS2i6hyqqOuqxKBa7O7jyA3zgfB57JkVsbuEgzLBuoCaP9hVAL9GZ9ATkRtAarYm32KY+LUkxQ/y9ZyRp0QkcGlvYlYVQ0fAlv3oNiM284haPf+43ZFfUVB6oT5+bq1vCxbV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494930; c=relaxed/simple;
	bh=75A9M5TgIoM2gIrevlAnIGQ7eccqokJJNc5o6u/pqks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=efhiQSf9Gn9Kp+HdmOfPa6WQ3quIAEp4rLkJ4fzvJpGpyEj7iOnLAscN2LaS9+POwHGeXIPKkVrc0UkvI0yHx/zW7MN+OjFYo4LrW6oOcsCFlu0rbK0/BfMl61sFZg38ZXLVytxicMEuXqE475H5mih6NgEIpPipXLdf9q+dkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ab4f652f9bso2528789b6e.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790494924; x=1791099724;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+dLWqk9Lfa1A8/fcjUQdJzQN+AEtevT8Cachr1mDVq0=;
        b=Ck+AbUbWBGdUaNDy+gfwA0hgHe150KbgeqrK4AZpSMoAxNWNyIOfTEhdWrIBJyBiXr
         gDzs0iwN0dlRt0ZqNq/4OjxniSc2jTA9jpM3gTUhqMcNPZ7sC7ECsu5kqSOCK7ixsdkb
         LMr5QBneSOTVpAAONyjMUijkuG6ubI8uS3kgLtyPZMjiQrsM3Ashjva7xm3u+zAGCnjv
         +JD22Gwl6seiNloJ1pOlznjxnKaa1g+dfxWd1L/x+cuQiWSepj5Hyuslw0/ih6MeVntc
         RgIQzF1RZEGxxibS5LPt8q2q+LGxVIC4oYIEDBgiUjlZHu1Nyx0CCFZSwh0rN0nQLsiC
         Y8yA==
X-Forwarded-Encrypted: i=1; AKwUvBwoRm9k+ogOSc7GWBOiJjiCtpU5ywrlfDUc+ycMlOse2biy9WuDOxR/COWjxvwqi9hp4siggM4=@vger.kernel.org
X-Gm-Message-State: AFuF++l68zlOtqe2kM2VSSR0sMaU9JBwywa4FkmdJi1VDY4wbaVAG1d8
	+zGocytL4f0SxsMIHZdBoAE7Men+LrgfkKcucaRgTXt/v9xjs1tyPCDwHGPOffsTCV1rnYnSE9x
	tDcTEOnDfNBGhl5e2j3Uq24VwCHRtm7gLZBZQhDo7oLERn0K10DgzTUvmyLM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:308e:b0:4d6:9232:b3bc with SMTP id
 5614622812f47-4d72cd363ffmr13140368b6e.51.1790494923975; Sun, 27 Sep 2026
 00:42:03 -0700 (PDT)
Date: Sun, 27 Sep 2026 00:42:03 -0700
In-Reply-To: <arjFl-vgg5vz1WWN@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8c8cb.e548f532.1ca396.0037.GAE@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134df2c9580000

