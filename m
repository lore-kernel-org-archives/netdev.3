Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680543;
	b=vcwQf2w+ceTLQOZJAbK5cWFZq4xvNBq8zuN5GOCqHnm1aAZKtpjFmDfD1m9N3pm5Dbke
	 cwsRe9CEDYdCR/s2bk1MVMbnxTMKEVizMuTowSjrr2pYXSrR+YCjeOpidWflkUAIMV0XM
	 tEGWngTtMmt36BubXKZNet9ewTfucfWvD6fFOUAIi2mbymmG7ovSz7EpTNn9ZxpiNE8Ht
	 Dyl8wlpLZovVR8r3Ld7mSlEUQfc5BTMDmHQPrCfyLHnYJYdA5/41zD7+y+Cp6Mdrq+zCo
	 NStB0spir8OzPpxX+TYY9QcvYpQDcHb8fHz6I1/JmEQea0uHi90i2tKANsDuFxi+Ang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680543;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=9Wte7AuBKj8qxpdrZA51TPo5RLedIlHp8+b5fQoKhzE=;
	b=ib0NDo2jd0+6gbq1+TBt/P65McP1Ug4h6l/O4moGEw3e0ckHy6G4xrZX7/U1ZM5qAURR
	 sg/IStivoHr4kDFmLhUAiKsFyYzBkfRHrjYDbVKarWVcxVzOYxSZWFtM9q+rF+GRyCiwa
	 C1viqVanEv0rMU+uoFdt5J/74hS0lpIZKkh+BphWWphwJOxCvHM74ifqTtSrvPq+6ilGr
	 wTXDOerOvq4244oALR5WSyq2NzUeXwqkdAk6+H55irCXYBdwtutBrSIlbHThnDaqhFEjz
	 HiOxMGP4yXK9sXSaMymENbBcU6IVwFDLkXtzIAJinH1yz4i8EzZXvK2fOw3W/xp21nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UPpSFo2d;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FD60A3816;
	Thu, 22 Oct 2026 14:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7FD60A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UPpSFo2d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9W
	te7AuBKj8qxpdrZA51TPo5RLedIlHp8+b5fQoKhzE=; b=UPpSFo2dvtVFK16JkF
	uKHaf0pjsFAPCjwRoqBvGEUy3fqCxW/DNeTrCKKOkfH0LoHcOy3cROzvY6aNmOw4
	u6EAA0n4Lyczlfno5n7zoE9Sr0zzuE0OgMrUU7X30poBU/cd4QRWf2AgA83zNYfY
	Y/sxxJke+Wc4UrLkI/8ehoJjc=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3h2E+Itpq_8PKBg--.60768S2;
	Thu, 22 Oct 2026 22:48:31 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [BUG] net/sched: TEQL qdisc can modify init-net teql0 from another netns
Date: Thu, 22 Oct 2026 14:48:30 +0000
Message-Id: <20261022144830.67948-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3h2E+Itpq_8PKBg--.60768S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1rCrWxGw43WFyDWw1kGrg_yoW8Ar48pF
	Zaya13AayUK3Z8WFnFgay8Xw1Igwn7Jr45G3Z0yw4j939rGw1DArW2y34a9F97CrZ3Wa4F
	vayYg3WxXr4DWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo7KsUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzx-o9mraIj-NagAA3E

Hello,

A process running as UID/GID 65534 creates a user and network namespace, sets a namespace-local dummy device to MTU 60000, and installs a root qdisc of kind teql0. TEQL reuses its global master and changes the init network namespace teql0 device from MTU 1500 to 60000.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/5a9460785f381e5feb8decc5dead00b8/raw/a87637a25fcc759de83709b4fb0fe8f7cb03d089/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/5a9460785f381e5feb8decc5dead00b8/raw/8039a72c1de72497f040f40b7507fd8d2103425d/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/c800422c572d258de956971217d3b6dc/raw/53eca8ea2f399fd3de75aa2b38423c3928c9825a/poc.c

Build the tested kernel with the attached configuration, compile the reproducer, and boot it in a disposable QEMU VM with TEQL enabled. The reproducer creates user and network namespaces as an unprivileged UID, then sends the netlink requests.

Impact and prerequisites:
This crosses a network-namespace boundary: an unprivileged user-namespace process changes a globally visible network device. The reproducer also shows that a direct unprivileged MTU change in the initial namespace is denied and a pfifo control does not change teql0.

Validation: Two fresh QEMU boots at the exact v7.3 revision reproduced the change. The pfifo and direct-EPERM controls passed.

Thanks,

shaos

