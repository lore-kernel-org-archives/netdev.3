Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618908;
	b=D7KWTnuEifi2nefK1TLk/IkMXZIVAIkzB7AdF6k9L1SIewb0B9/wd9cGN+nUrmHrB0Ni
	 XmBoxiYyXTsVoDiX9HSXsTRHG+UEXXMtleq1txvIOii1I0nuvZFYqH6zb6cmhzdaowSrL
	 iShZaDGBfXwCsOPT/j9QcVPiUhckEtJkNcKfXOpkx5XUmssp4jl3Xn9QHF3gexE9fMKT3
	 Ix+B9q78M4O0P0ICQmj8WXeCy6z+yiNqDwj6CUnIZGiXsiXO14F/QU4xbwP4jU0VA7+DW
	 qrRjLQpF2avUsVW79nGRyozVYAGQm1ojV1vGFPiKOSbE92BbGvx9V9hhV3x+fb5RJFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618908;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wq2DK5eAxiEl1BnVO/YgIjQxwj/Tl3RqelEhCpvP3Xw=;
	b=LXW54kCwSkBDokHSEDOq7iMwNUp1TU94AO8mUHXAB1EEK/awlOHPjSZh5WZvikamLbQg
	 /ooMgs4aGOtjXFRoUz6JQgcAJMbTmQxjzGppe4pWxXsTBs/uYnXMLuqJhcgAEX8Z03OX9
	 1tmc67Ay18fkc0KTkxYLPbHlBVpbzY2If/HcCSF+oiNzq3r1Ml3J1oSoPRP5o7/i116LM
	 OfK35yi4U9NHp2UDayii+its7c9n/8jLOb7SsreRSVf/uaQAQGeCgnMM3UBSQUYQRadLs
	 18f8IPPGTgGtjSETjl86+/Ut48tQVfj0wreBgtoTVcWI6wm/iw3K3TDsdMvOkmCf87Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="X/g9/kcB";
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40628606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40628606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=X/g9/kcB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793618896; bh=wq2DK5eAxiEl1BnVO/YgIjQxwj/Tl3RqelEhCpvP3Xw=;
	h=From:To:Cc:Subject:Date;
	b=X/g9/kcBoT5Hlc0TJ9K5a7ozUq4KAIuHn9uTosi8LdO0sSfv9MhX6DO+UDe9ALcP6
	 E3bE7arbumvmgxdii2FXLBZZRyGjLFnwA7pLDQ/sBkKDClTCobYRFLtruK1sCqIHpe
	 q0WcC6i9Q+/CkVJ4FxRk8QDCbMu5AXae0j1RD+p4=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 70D9DAA4; Mon, 02 Nov 2026 19:28:13 +0800
X-QQ-mid: xmsmtpt1793618893tmfbg333h
Message-ID: <tencent_BA6DA4F17D2035F5DEEEA21B9578E2234307@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JugXe+UnQHAJdIr2kOu3iQLK2pGmAj/Rt5eZQkpLvUJ+L6cy2vnW
	 C7Tyf6t+IF3SBhNIHENki8ChVORd0mL/4X/mfRNSC2/qbzz11X64H6PFpgn4nAsTSf6adhM2KqrO
	 UyiW9bKLWaRWeB0hsnMQeQhWt5X8aRDjva50Yxc+Fd02p+R/s99SI9G0s8cpSUPkJxWraKxIx5t6
	 z7kYYk2I1oSwJJeBMPDVpzRiuPOpRZz1/p6QjzUNkF3QcyFSPVbaYpe+VwFBn8UQVNSAlrGRisW6
	 c5QRFuY1K5JzlT21SaaUfjZf8ZNnILG1jkV7cWSUrkVY/7zHCEVNYq41htXM+rSksvmajju5UEdm
	 vgd5rFHOW0/F45aONcrtzfqpJJt3hwvV+FgeiFEg63pL1jqnB+9SrF6IpSTicNqZJkX6Dcy8FAam
	 Jw8F7OjakRShfqX1Vw6BBC3UcRjmzYe+i2GMaTdT5UFBGKXU94fErGV5eemf+VwjcHBzJ5pDBuXl
	 37oS2GYZ1Di0nRsErAy18ydLw9NYxzm/ICg55ifFF5CKMJ7jOyyQXvAYF8FyOlCbN1J92C551et7
	 jYPMshWXLthHjZWkmhRQAPsboeG7KcG78gX7Bvi7IXMF/lgCkfVopZZpF8AabGVYlG2g9VToNYKp
	 cjTBobYdy/sUo3EEKfrhEDdrh32XzeEE+EMtJjrvOUOIJPhMMHrrpOgnxl/6iRCxZIEslxH4ZUgv
	 mtXZLWieAbA/tzETZ+Hm9Pu8JER+RA2/ksoHn80AXTeDdPgxbpveQFK5U37orqap+dwQik+LA+dQ
	 hatngCz5HzXWwGyxpcw3v1+Ph14p7Klo/1TaLaSuk3iSqBhSmU2ipUL/EpbqAR+Ow5tQL7+M/g11
	 inN+wAkPjk3tdU7J7IvhoGAE47WPrVgViW0Ag5JtnhvvtJPqjW5VD1umMcDeQEhaJC+xcLNBu7Wn
	 2HLuZdobhZ9nVSnEXniczJTHrN81j2NYjsN/e7V/XvVVHrlVhYLkfG7BDIFqhqG86AnN5r3EmhKW
	 LXPe4TxAXU2SnFYdbwjYql2TG6rExb/+osXYFehw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Chengyu Liu <19290937@qq.com>
To: netdev@vger.kernel.org
Cc: khc@pm.waw.pl,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	Chengyu Liu <19290937@qq.com>
Subject: [PATCH net-next v2 0/2] hdlc_cisco/hdlc_fr: shut down protocol timers on ->detach
Date: Mon,  2 Nov 2026 19:28:05 +0800
X-OQ-MSGID: <20261102112807.1395951-1-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
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

Both cisco and fr arm a self-re-arming timer in ->start() but never shut
it down on the protocol-detach path: detach_hdlc_protocol() calls only
->detach() (never ->stop()) and then kfree()s hdlc->state, so
unregistering an up device leaves the timer armed on freed memory.  This
is the same defect class as CVE-2026-63803 ("hdlc_ppp: sync per-proto
timers before freeing hdlc state").

Each patch shuts the respective timer down with timer_shutdown_sync() and
moves timer_setup() to the attach ioctl (attach_hdlc_protocol() uses
kmalloc(), so the timer must be initialized exactly once at attach time).
Both bugs were found by static analysis and confirmed with a KASAN
reproducer (slab-use-after-free in the timer softirq after rmmod of an up
device).

---
v2: retarget to net-next and drop Cc: stable per maintainer guidance;
    carry Simon's Reviewed-by; no code change.
    v1: 2026-10-28 netdev thread "hdlc_cisco/hdlc_fr: shut down protocol
        timers on ->detach"

Chengyu Liu (2):
  hdlc_cisco: shut down the keepalive timer on ->detach
  hdlc_fr: shut down the LMI timer in fr_destroy()

 drivers/net/wan/hdlc_cisco.c | 10 +++++++++-
 drivers/net/wan/hdlc_fr.c    |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1

