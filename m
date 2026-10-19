Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443056;
	b=P8HVbV+ickCFAUPpLG5xUmfR8OQViAOM/K2cNFRU6sPVIA4oxNoMIT1ne30wRs5mvQfl
	 Z+MJxihqYwxby2gZKQtehvGuAmT9M71aF90THSHq2Y2yW7VpFS9OxEJ59tutX1oq1U+AT
	 pEmSYqQQdero1JSAqht6n6kQB8zGvgdBTPV+qzAXoe4urlbav86pPlOuvv+xEwJ5zynij
	 9nbWB4aKs/FbwIIxQZCU4OUobm4jrNML5RHVkhl8thtn0fDh/aa1MUPLaYlTktVAkW8/n
	 o0wCUY8q3oUBMSkwFqAsyBCk8+zfG+kuQSi7cwsysmWA4ra9kv+t7Zk7TgSFZURMXZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443056;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AGvBQBicbIv2jeda8cVh1Ap+IgzyI6DV6T4+iQwGOpU=;
	b=s9sUKwrmcmlDOy79gSs6S6ZqQnOymmpNBXTCaJueSNgkU6tfXiY3hYRVObydvVYaNIA/
	 tSlxK1/UUoLPoQ4uCnBnElZcFV2IFpL8QW1y2pnDHt/5LsU4zZ6tIPnURi6aQr1YG6aor
	 sGKvhbpr9EtgZYs5gqpfbbvRs/JvwjjmM7WVYSmEkC0CxzmDK0/7mEOGSOM2lHfW5TrRy
	 VsLK3H8vwJfNBQhdzk/n6/79Br3AADneHjHPC+fmhowuJwOI3x0/spfy6EJ8rCKWLgSHL
	 ouumpL1XJUyKi7gsHOiPgYUMr+3vUsPlttkPkoX2sSbGHczuFt9E6ganT4j3P41V9CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lbrg.dk;
	spf=pass smtp.mailfrom=lbrg.dk;
	dkim=pass header.d=lbrg.dk header.i=@lbrg.dk header.a=rsa-sha256 header.s=protonmail header.b="RsO/W9o/";
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92276606A31F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92276606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lbrg.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lbrg.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lbrg.dk header.i=@lbrg.dk header.a=rsa-sha256 header.s=protonmail header.b=RsO/W9o/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lbrg.dk;
	s=protonmail; t=1792443052; x=1792702252;
	bh=AGvBQBicbIv2jeda8cVh1Ap+IgzyI6DV6T4+iQwGOpU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RsO/W9o/d2JX+bNACg8+2YE1S2IcUV7MhW2C1hdeJr1upTq6Tixmuit3/b2c0Kbxn
	 TPErDn+LuBylacIKa2W6CHIIgkTdApWskC+xY+gsMf1aDPv1MknQGQ7QwrN5We5VD7
	 a7q7JVzjW6X23vSLxDFBf9fl8jpDByqlRlDx77W0DuE/3z30+wKMpu3K9RWDXFosFS
	 K27HnecJW7cAKxOXvP1nZxgjaYlDiI/156Xwkg70MX3JD41vSBEopSfcmaKpbkqL+S
	 pprA4jkh3VsxZvtP4LwE1f2pYm7lGidkrwjSrmaAwXGojDrdsOmoMF9A9SGWosboTx
	 cv84eAM7UQ/jA==
Date: Mon, 19 Oct 2026 20:50:47 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: =?utf-8?Q?Jonas_L=C3=A6borg?= <hi@lbrg.dk>
Cc: "sukhdeeps@marvell.com" <sukhdeeps@marvell.com>
Subject: [BUG] atlantic: AQC113 napi_disable() hangs in aq_nic_stop() after resume from S3, wedging rtnl
Message-ID: <7h2n69cgEFundmU0BuCCIu20vBfYmFWUvB65gq-YqePn0ZSAY8vfoRF7ec5l8fu6yUr4l7x8BKaKmwURUsIfZMdMs3apMF7oKVuUCRXWiw8=@lbrg.dk>
Feedback-ID: 76324849:user:proton
X-Pm-Message-ID: 18e504eeffde65a914a9ba53dd9c9362e4bab07d
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On an AQC113 (Antigua) card the atlantic driver intermittently fails to
bring the link back after resume from S3. The next time the interface is
closed, aq_nic_stop() blocks forever in napi_disable() while holding rtnl.
Every following netlink user then blocks too, suspend fails ("Freezing user
space processes failed", 6-23 tasks in D state), and the machine eventually
becomes unusable and needs a hard reset.

Hardware / software
  NIC:      Aquantia AQC113 [1d6a:04c0] rev 03, subsystem ASUS [1043:889a]
            (ASUS XG-C100C V2 add-in card), firmware 1.3.31 (ATL2FW 103001f=
)
  Link:     5000 Mb/s full duplex
  Board:    ASUS TUF GAMING B650-PLUS WIFI, BIOS 3222 (2025-03-05), AMD
  Kernel:   7.2.9-300.fc45.x86_64 (Fedora 45), also seen on 7.2.8-300.fc45
  Setup:    enp7s0 is the primary slave of an active-backup bond0 managed b=
y
            NetworkManager; backup slave is the onboard RTL8125 (r8169)

Sequence (boot of 2026-10-19)
  18:38  resume from S3: enp7s0 comes back fine ("link change old 0 new 500=
0")
  19:16  suspend (deep) succeeds; NM releases eno1 only
  19:45  resume: bond0 reports enp7s0 "link status definitely down,
         disabling slave"; eno1 takes over. Unlike every good resume, there
         is no "atlantic: link change old 0 new 5000" afterwards, the link
         never comes back
  21:54  idle suspend: NM releases eno1, then enp7s0 from the bond
         (__bond_release_one -> dev_close). aq_ndev_close() never returns
  21:55  suspend: freezing fails, NetworkManager stuck in D state
         (trace below), PM falls back to s2idle, which fails the same way
  22:12, 22:29  same again; network unusable (DNS timeouts), hard reset at =
22:30

The same pattern occurred on 2026-10-08, 2026-10-10 and 2026-10-15 (6-52
failed-suspend traces per boot once it starts). Most suspend/resume cycles
are fine; I have no deterministic reproducer yet.

Hung task (first failed freeze, identical on every retry):

task:NetworkManager  state:D stack:0     pid:1239  tgid:1239  ppid:1      t=
ask_flags:0x400100 flags:0x00080803
Call Trace:
 <TASK>
 __schedule+0x2c0/0x6e0
 schedule+0x27/0xa0
 schedule_hrtimeout_range_clock+0x10a/0x160
 usleep_range_state+0x6c/0xa0
 napi_disable_locked+0xdd/0xf0
 napi_disable+0x25/0x40
 aq_nic_stop+0x15c/0x1c0 [atlantic]
 aq_ndev_close+0x1d/0x40 [atlantic]
 __dev_close_many+0xbc/0x210
 netif_close_many+0xb5/0x190
 netif_close+0xa5/0xe0
 dev_close+0x2a/0x80
 __bond_release_one.cold+0x26a/0x3d8 [bonding]
 do_set_master+0x79/0x1d0
 do_setlink.isra.0+0x37d/0xea0
 rtnl_newlink+0x446/0x940
 rtnetlink_rcv_msg+0x3d5/0x4d0
 netlink_rcv_skb+0xcd/0x150
 netlink_unicast+0x29e/0x3d0
 netlink_sendmsg+0x21f/0x470
 ____sys_sendmsg+0x39c/0x3d0
 ___sys_sendmsg+0xe1/0x130
 __sys_sendmsg+0xa4/0x100
 do_syscall_64+0xe2/0x570
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Other tasks stuck at the same time are blocked on rtnl (DNS resolver
threads, Chromium/Electron network threads, rtnl_getlink callers).

Other kernel messages around resume:
  ptp ptp0: PM: parent enp7s0 should not be sleeping

It looks as if a NAPI instance is left scheduled (or never re-armed) when
the resume path fails to restore the link, so napi_disable() in
aq_nic_stop() waits for a poll that never completes.

Happy to test patches or collect more data (full dmesg, ethtool -d /
register dumps, or a dynamic-debug run) on the next occurrence.


Thanks,
Jonas
