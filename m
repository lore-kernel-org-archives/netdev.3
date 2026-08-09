Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7018FC97
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786251785; cv=none; b=TiHPfJScjhpKligHMjlYPxuDL3JeZVa7CgmcKdZg4DlNUZn9hOV2EyVqSEbYxlDZieZ9KESLdDcA44Lec089epmk+q11Faa6hlXHHWkkF+C7/XjroZWRdldG7f5LfJEj3wLJE4ye56OfurYN5e9aQ7uUW9dnA/xdHUnOOUzVIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786251785; c=relaxed/simple;
	bh=TSyg59M+TO4YGE6AZbqHcac3nJAmna5Km/zaqZQswvs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WCaRKlfbL6r5J2sWSALlXmd2LxuH1BN3FJSNcdFUcvlyKJtlmyRimycdHy7/LMVrcEs6+lbQViikuIjM+oLRqRY70yV5FmSm9IpzM7ORqgyrEcj9eyDqR5fisL0ZKPYxD8FvoSHazYFzH30xlMZc2hOIchPnY8dg055/Q6PkfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a7c64fbbc6so982695b6e.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 22:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786251783; x=1786856583;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YcVzw1r34xk0LSgoQ+OK9e6rD1CVWCEsDqK39U+7VHY=;
        b=MZBtBuPsDhpS5GYg6Ug2HImti4ZLPJi5e5bQ53xjvfQyam6rnk5HQ4f6CacagKbDUL
         aqId+T/toUM92+qt4uZiBERdTKwD8yysW/hIuInMgkyrTI/Vyq0V4eHo26jZq1KjRiY1
         uLxEvFf7G32g7cdfPgPg/ELCEyMigvnTMg3F0vCAIPslWk75a4WXWzPmr05AF/F97MbC
         qgNE0qAaRjamfeRJ0MLUpom1EaSXMwBUrjRTI0/X1Dnb8Du8sE/O8IPTgO/o7QJ5uc10
         6OG3J8eXNX0WScTftbZzXz+VwLQ6EVVV/l4VWL0qC4plXN9sr48NMqG6G1j3nCUceLnM
         SfPg==
X-Forwarded-Encrypted: i=1; AHgh+RqTJ3zwNIDACRxGOs8Gfao59h+2Y9VEh1bNAZGlcl/xNzw+2OjSbabTq06Pxow5pOEnAl8H1S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguE3DvQvRjwVrZ5+mKbdIBjF+qg3CMWj9B7GxaxaBsf7WFgCw
	HdOSvJ59K5/8ngQfu6z2Y7KBIO3McNOz/iNLwSYHR25prFZ4ZWVZ/0Ts2+3++isdzJoyVyAv0mP
	nzuZflcvQx9mecit+LCXy/Jnov9YyAZVEk7v0qmE/ANM2FOA5EZ6OpO6Xlfw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b86:b0:496:daf:8709 with SMTP id
 5614622812f47-4afae1515c7mr18665986b6e.17.1786251783127; Sat, 08 Aug 2026
 22:03:03 -0700 (PDT)
Date: Sat, 08 Aug 2026 22:03:03 -0700
In-Reply-To: <CAL+tcoByBOaeZMyMGr_=9sPZtfNHVVZA4iVzG6ioP-_QHneWOQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a780a07.9c11d2ce.289b96.00c3.GAE@google.com>
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
error: corrupt patch at line 5



Tested on:

commit:         06cf6189 Merge tag 'x86-urgent-2026-08-08' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a29fb9580000

