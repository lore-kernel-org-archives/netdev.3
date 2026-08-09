Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08E1474CC
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786257484; cv=none; b=Fy9zqLI/6m9AdSl8Hjh0tKe/OHHW9o2l9AIbTFMpayQegimp3lf9rXIHeRTjpd7LKw39tik5+tCNLF7DeWswhJSz1bCeBxbbJDKzkiEIQxkK+TwGZsGYmlbslKCOf9716RGvD4FPLCq6SEo5hNsmm21Xquz1airdG81+5+H0eSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786257484; c=relaxed/simple;
	bh=SY4DL4uLHqobukZmLqNiH8TmJ30ZuFc4y8pwa61yOEs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RNPHeUDt8SUvvc+rZlrL3pEcr1aAWbzU3P5ORERa1z9WSPNkCHXy5B31FTQ/r0EuHoT9DYeqM5cjSqdWtC3DStbYBap4gnVE7inyEA9yFnzymEzNEfSxpr2Yz1VKq0/ZeqdkedFYu2WKISD3yEKKvFrLXjjr1Sh0yy9+crcJCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a41f46d629so1378865b6e.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 23:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786257482; x=1786862282;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=viNDMipSqjRd9R+0lF4zimk5nSHhhcfEVlL1GEV2GRQ=;
        b=Bgy9wGLunhubEWVLaqX62hMRezfkXLwGVbl8zoyVHnUlefcbhXG9zfKmmo8fQIHcT+
         TbbaB9NlUmRRWHccVD0K+QTApc+irB0+XTC+LCqXTy4qQEd40BF33DJdXauZkM57VG6e
         dG4wPRCImfGeXVO9qE9vatud3lCxZEnpaFrExBN5kYbmqw/Wz6s6eRKC5V2DQBMEyd5c
         7twzl9W7TOB8lR3PXjUNPdF8UgtNT765gbgsF++4hktTCIE4xxyc/JzwsDXugZpyDgpK
         beXNFuDvnYyb2UT1ooNTogWGiSx6yDi3YOlMv2KZYTwjtL7Xc6u5OKxVk7Z8ehcSMRhu
         WX/A==
X-Forwarded-Encrypted: i=1; AHgh+RoatOpTcEkGHg7zhC9y4o1hThA5SnJHIF/EyUhvbWI/Pww06JMhM9cINd73QXD7lYRnNCkTiPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28YL60zmZfpmTrqPnkQvn4ci1IvfPEK4Dszq2/I/cjDGGRmAq
	RvJyTFFSGR4hzNfXljXrsYE7hRG0vORRqvnyXIC+CqNT4PXUT4sPP+wSPY5eXeZKxBiyE+aSOBU
	Fe5QqXL6CNXlj3e3dU3eGqareqnbZbzsqwo9Hc4fb0UO83UhSMw8FtPTZo9M=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2512:b0:4ab:230c:5faa with SMTP id
 5614622812f47-4b1a101502fmr9190710b6e.18.1786257481845; Sat, 08 Aug 2026
 23:38:01 -0700 (PDT)
Date: Sat, 08 Aug 2026 23:38:01 -0700
In-Reply-To: <CAL+tcoAR9WTmrFiM0GtWhtvgWX467vAD9fRRJ-Hds9Q346EB=w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a782049.9c11d2ce.289b96.00ca.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in ipgre_xmit (2)
From: syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kerneljasonxing@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 6



Tested on:

commit:         06cf6189 Merge tag 'x86-urgent-2026-08-08' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e27fb9580000

