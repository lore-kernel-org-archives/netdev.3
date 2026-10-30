Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350144;
	b=5gYM1v/tVePFjRKhi/KnyNeJNNjt9urMmA1KZLEi7OSNS93EneQQ4es7gvi7w0cd2YCL
	 rP5BY1FBEoOINBW6y6qK/Gmbs2PiQgirbLmoc5E3JAaIEPDE3gtJo63xNrPy/Cmq8YPdI
	 zhxDKFNENbZFNPA/pKsy3dUmIiMjSIeyMtOn+trjd1vqNgVH+5frzNAeEZHxSVnqhvHRF
	 PabUK/QQJee/6lNSUD3r2873qZOQxIt0Q1pVhoEqLYmzLa9klXIyI23uzPhPl5hh2BuZL
	 m2EsGwtCh7grIiOBwaX7WxtY2KZefgMIOQSLIAWBlO3VRR89vlSGPGWUt7+dhIUWPIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350144;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=uFqBBEwOWl98ug1TqMQYwIz6t+F2tyQFk0IyQsWt9qA=;
	b=2FwvvOpuVd7tzDV5AOsc4Xmof2ObttRRFXtACztf+F9/wlPt6Hs57cx6x15INOOn0NFA
	 obDncf7pk05e5fJDzLVLayyJrxo9pDdWSP5913leRa102McClDDS+OSGzhIp4zfRbP6Um
	 lID6TzmHRm5v+QBQudSAQG7eLpbC6XIVWVpw7q4EHWc268eWPFgeDOZ4PERIG1pFF2lpX
	 gi1wJL3x3yb+CSBXoLQHs28GIxcV8G82gn9iGs35gi+C1l39Jvfwve41+7jAYRaHbwfFq
	 KQpxcWA+w7/7KJ/SlHImoNTq5baQRL0YSkXhBSmEj3kVOp8DA1G119xBMqLDfNVsZFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A291606A325
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A291606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4d2f0f77124so505699b6e.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350143; x=1793954943;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uFqBBEwOWl98ug1TqMQYwIz6t+F2tyQFk0IyQsWt9qA=;
        b=jLOG3IXqPy/7c1MAQF5tgVcGqL6ucfyfdgm8vjawPaKAxQceJZcrWrVmbowuk3Dp77
         hi6HYn5pJpYy7c8qqc/sNqMvXs+IjfGD2iSVwjmhmCVZtyS7vedTUGfjxl/9mjQl6grg
         UF91DvEzOHq11Bzr5vCvgK4HCXhmQ+p+vtrGUZsSSpp6e1YQhyM+8eEx6JR4VAA82fr/
         hUKQkOdIVBFb5YvZYutRsgAKIQiEozg40pGG9DrxbjSuTTfojcT1KVysl77E1tI3oUPk
         SK4xBEy6+uLGPRs8/NR1YfyMkj15fa0nCnPjN11k95DPyOVjYlvlqU+rWmZf59uNGo7U
         Wilg==
X-Forwarded-Encrypted: i=1; AKwUvBxJyCvIDQ3b0E2lv9hihWQCZKTA87J/YqcRQtXKL3uDy++zXPfu+1MXZ1URDeV4RbumUfK6elQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLa7tzu9ot2iteodPmF2lRhDhcUwo5QdvC097OXtvGYVU0/Xl2Q
	7UJxB9SOBrhhNxaANn7l06NOhsX8KOE8JPq8wzA8pjFFws7wV//8VuhUGxdiZInpgN5Mrv7hcmT
	1bISjBeG7ONmrw2CoYXNSaFBaLlDWdFqI3vctdbsAFK4hayoT7PSBz7oyexU=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4487:b0:490:315d:e0d5 with SMTP id
 5614622812f47-5640dcb6f71mr1007391b6e.16.1793350143466; Fri, 30 Oct 2026
 01:49:03 -0700 (PDT)
Date: Fri, 30 Oct 2026 01:49:03 -0700
In-Reply-To: <CAL4WiipBVMi_fiSQVUAFxqcPVc5jR2BswOwA2iNmGFYE_sbyRg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae459ff.f57e0135.1770dd.0078.GAE@google.com>
Subject: Re: [syzbot] [net?] memory leak in build_skb
From: syzbot <syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	jasowangio@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 6



Tested on:

commit:         d89e1d18 Merge tag 'fscrypt-for-linus' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbf447a1375a1948
dashboard link: https://syzkaller.appspot.com/bug?extid=a3f21220cbbb6e14ee2e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124fcef1580000

