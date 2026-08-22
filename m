Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C911C5F13
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787375472; cv=none; b=XrOp7LEXlbwL/Cu0TrO2oZyfLVA8SsPjp5FllDKdAsedMwZKaI6T/geXWjxjm77Drzx504u9M0hPpuWHzHWZJBK8H2SLBiXz53mQ1SCNrL665YpPN/JaEcx008kQ8KTdVL5m+7QVDm7FviDtlJqJlg+9e4gddtxogJg20UP6WCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787375472; c=relaxed/simple;
	bh=3Ntuzbn/y1ccb86Z4zXNH1tckVTp4+rI3/AMLFyr1zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ey7gluEmnUc+hfH2H5Kb5PoiBUXLzBvLvAK1zfwUI9HHjWpVicXs3Sa7b55pLK9//4HIGWMZwRHLH54Ky8SzPJM7+3WXzxp+Wbb/u+/sLvvMQmmMorWD8Ah0k2JlkaSLxLQkJj+1W3JVbp+bBE/MH+46A99wvlt9++ikuLpsNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4b2d1eb484aso2960347b6e.2
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 22:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787375470; x=1787980270;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cQUzZAXwNpPzaN2MjCWlzFEowQ2KNsU0O2e+ffdjdy8=;
        b=nK3IGOHyCYRy4jBgzpaKBBwsOusOYFoQzDQE9PtxZEi9ZMh3mR7A6VTJVcolm3yATs
         D2Z5pJWCokNBgO/3lXnYodnoeu7+8oykEkx6ryZG530TD79SeUbY28//lUEsXbnkh7EH
         2X0LMW9cNVPOsZvcShLRPBYkx5yfE1qfkG1fPb07WlguhW7LQXP27QFqF0PJR59gzqTk
         L5M2QIKfbMVaDsssCajZbPl9EvF/vlhbo5IXonshmlQDfGip5zvsLn/w9PVPuz+Cqqy7
         WqPO/+zUAotqPJ1cwOV76OISbENAO4p71V+g3wm7LTVR53dJH+HwCNqYKjtGrPaFHvjd
         cw3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoGqBuBV7WZFX6cICIYp6zDelPt8OtdB/dIUFkFNCFX8W3XWpb5SXdQpChUJDWdAcYvu6snOVY=@vger.kernel.org
X-Gm-Message-State: AFuF++kp9X9oScHx+lp9EGUeTr8go/69eAqN01KPvgve2bfFTl7v3CSp
	3RjXgkr7hyWZuebEHluf3bY9XBMky8s+/VtncGk6F94qtjfinGjkmp2bzF289nNCYi9bwgpX+me
	Fw3owRc6PmvZIe4upQS6tZSOkT5ptQvXLyi1V2iHW/MddHCl+6U3DXRd0TMg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2f07:b0:4a4:c623:4c0b with SMTP id
 5614622812f47-4b2ef1753c6mr14026654b6e.4.1787375470318; Fri, 21 Aug 2026
 22:11:10 -0700 (PDT)
Date: Fri, 21 Aug 2026 22:11:10 -0700
In-Reply-To: <6a75d605.01d0871a.3a0d52.0047.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a892f6e.ae6ddae5.3da009.0050.GAE@google.com>
Subject: Re: [syzbot] BUG: Address fc00:: on device lo is missing its host route.
From: syzbot <syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	pimyn@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    21d6ac051080 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11bd5e79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=ded267b328e950a7c0c4
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d52179580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c94415580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88380e2ddcb9/disk-21d6ac05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dba5c2896b7/vmlinux-21d6ac05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52ac739e37e0/Image-21d6ac05.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com

wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
IPv6: BUG: Address fc00:: on device lo is missing its host route.


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
