Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6733938C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176586; cv=none; b=giZb87kR8h6mukMjZJqBa+mNeGnmRzrUNEUuuHTpOuJp1V8k7oTxQuqO5wckwPxP1RlKyBB4eeJ3YnPNZvrB+vwr1XtcUYfT3KUpqr+E9OXjEO4Ejr2rc3t6OmcFN3NAXzTCkx2yvlTyYs9M26W9GDRo7DUj4sasJNwm5zy6BKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176586; c=relaxed/simple;
	bh=+WX7mQP25t2lxqDFB4cSfx5m9/A1ooQM8MrwPHsLMqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YiFEfvHl7EeWHZ2N+sgyHd8ARnYmSYisBN+AjKiq4Ax8rmRSpx+Pi341f5X7FGrViARuGe/pJpBvwoVJc+3g8G4FbmWIGomhzstmmON5DEstfAAMCFNt3OYEkuiX5D8l4nz7bqTVv7KTHcxQ1oPm78OgZpli+ZN4aVwUEBW96g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6b59d85dcso6400693a34.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176583; x=1788781383;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I5LM+0Pjsyiw43Y9OPRtVO7+pR519d5y9NI1syLmG3Y=;
        b=WcwKvnCyWhaAdI4bvmKoPMBvstcQPmWSEgzXNMg0oyNYIefnXQis6UVVb76JeOuvhO
         KxoW0zunGmshJV8/2cW0NL3iQBhgKRC2QtVruHIRo7kz1vIApo7f09HoU/xEhER16VaG
         BomkxxyfNk07TFYmm+WoW3125FB9N/TPYaUaOtdaW7SJ7uWKQ6HfdVfgUv1HyfNxphnT
         ObaDMcQRSu1SDjW1L5vdb2tyo7sJ0XGH6qTEz5sggYLGXPGsupdCS9MrJL3Bpn1eD4bw
         Z0Ek/dksGDgB+PBXjFeHXpsiQIdzDGbnLtTln7lRATvaOTTDKiUE4RvfFsCmm9h2q2Up
         2ItQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfBAbT3QT5tcauXYNUdplsgsQ/s9YUWvSDIq7OSVatbFzx45zZPDIBJ59gYncHLoIgynvvA4g=@vger.kernel.org
X-Gm-Message-State: AFuF++lHVw2Yu5hv66PPXUNLdJAjGtKgoAJtG0nu/atIQlEdiQvUJT4d
	jAIGfb6y5xH+T0y2bHLgBZYP5mdIZxOVDkcy3jXaGDBzzzIuw3cf2n0ATgqEzN8FA8BHRmLyKrR
	xhoeWVbUU9O6O05wSuaP4pdaHYKD2/UtFumuEj/yhE2yyJmG19O4VSoi4VkY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:251a:b0:4b3:7c33:456 with SMTP id
 5614622812f47-4b5b81720ddmr416388b6e.11.1788176583352; Mon, 31 Aug 2026
 04:43:03 -0700 (PDT)
Date: Mon, 31 Aug 2026 04:43:03 -0700
In-Reply-To: <20260831084159.410474-1-junjie.cao@intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9568c7.a8e469d2.cbf3.5619.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in __mmap_complete
From: syzbot <syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, elver@google.com, glider@google.com, horms@kernel.org, 
	jannh@google.com, jhs@mojatatu.com, jiri@resnulli.us, junjie.cao@intel.com, 
	kasan-dev@googlegroups.com, kuba@kernel.org, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, pfalcato@suse.de, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com
Tested-by: syzbot+e4aa91d7f20c34417d4e@syzkaller.appspotmail.com

Tested on:

commit:         1bb784eb Merge branch 'net-phy-fix-cleanup-after-probe..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17e3be25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=e4aa91d7f20c34417d4e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171ebe25580000

Note: testing is done by a robot and is best-effort only.
