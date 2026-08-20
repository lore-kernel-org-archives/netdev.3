Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB9313546
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263781; cv=none; b=O9AkLEGTysnsU45BB2tTRi94H2T2Q+ZgRWQfIfj0g8UX3jl9y0eHLjuv6VikNqslRzg5I4kA1plIz0xxw8AY3U2GiumJxN9oL+qe3Ce6CsMk4xz2aa5HqT1HwmZzRnqtUXs44Y4sWxN6jveU8le9CuUCP/7wDZL7MKxhyR02NJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263781; c=relaxed/simple;
	bh=gKEl5BDKm7NPtHmYouZILv51lFhr9lX8HXHWK89Ha1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uEkqUAkthWxjgxpOgmROTlVCprtn9g3p/dBh1k/nOImTBcJQKuSx/TWXJ0oh+fJgdGGOG4FpEm4pVQcyqAHH1lkL22kF4yXlNGYhwjFAvkZ9ZFiVd7dyoYtbLZFJm5mMFy8PfQ+Y8G4jzqhq0NnSBE5JFMge4ojJGScwdLscPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so139640b6e.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 15:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787263779; x=1787868579;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aXWG3iaT3vGs1SrxMuVGI6eYYcjA+z2LE04ReofBQBI=;
        b=crcCyTiz6hf+MJwrnKEcTJQ/DAZcez+BACjjSosPxYBsdbl8Ngg9MMlzIhNzO2y+6i
         TsqkyTeOfYHreKc8TFK1pu/othQQYawHnOav2ytTcnUd/ihPC9L+kbwN5f204fmphosA
         MlWnlWDGicVBz1nYH7RMivxdeH7NJnso7WyDucp/ikWFE3fangPSCvWBCN6fdizIsdYS
         +shaPdJIJqLz3Ve/uI2Hor7+jVXLxEx1Pd3GNKvVqVwQsei9X+2eikSd6G4p9lY/AomK
         u8tVqP7jZq0T2/SfFw3R5ZV3e0Hdu2bUBOjLlp+NJtU54CbkN+Cbh6xieYI6FAs6EBPl
         20bg==
X-Forwarded-Encrypted: i=1; AHgh+RoN9XFUwg1l6C1+/6TzZ1JPM/4KFlWRDbqX2fxhxk9pNRMNVY8xVrUcixvp5DUJn6Mb7RVIZ0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkKzoyC4MsFUeb45wYaZqeI/FZ63oxjB/gyySDUSx6DM5C471
	EQ+4ONEbMFBuDNnaEHpU27lSTSTscmj3hdoVX/ha+RnpK/6AM5DiydOxo0YcgP3uPqQSqavqxGy
	dt7/pgCatY/BiwFolwzKwU7EpyK24/90X6iNXpR45xHy9We+17cFODnW+wSA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:514c:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4b2ef42cc98mr1376891b6e.16.1787263778649; Thu, 20 Aug 2026
 15:09:38 -0700 (PDT)
Date: Thu, 20 Aug 2026 15:09:38 -0700
In-Reply-To: <6a75d605.01d0871a.3a0d52.0047.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a877b22.f7a79266.2f965f.004d.GAE@google.com>
Subject: Re: [syzbot] BUG: Address fc00:: on device lo is missing its host route.
From: syzbot <syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	pimyn@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9d2ed026f031 Merge tag 'sysctl-7.03-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10661e79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996f19b48f3c7123
dashboard link: https://syzkaller.appspot.com/bug?extid=ded267b328e950a7c0c4
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d20415580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9d2ed026.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbab070bbde5/vmlinux-9d2ed026.xz
kernel image: https://storage.googleapis.com/syzbot-assets/857014a70033/bzImage-9d2ed026.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
IPv6: BUG: Address fc00:: on device lo is missing its host route.
netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
