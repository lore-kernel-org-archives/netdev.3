Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826482;
	b=hHilkvlDWPqvdbh5qcOLF46fGfj0V3UpWb/qpOFRueUdr6F6QGEj8bIBmjeI0uK1Pzpn
	 w6IpKFbRaum6yZZJ8MIgpevTLADILWOlO4RCXRhKa1rCvQ485Uom4LYV1EKrmcItEOGu9
	 ahGux+ggp1NnCoaLshU989SP681fGlPTcMMqavbfGVK6aDsEXfQSWJ6FSg84fHrzegPT3
	 SbuH/WLKGdy2J70NzyiI8GoaVGdC4fX4JvdHouR5XwcMB5DP2FJSaHhB0+OzO7bNLLr0N
	 e5PDZNbWVipDZ9ysD5wYKgdG498JvfkrXj2lofMmXU52tAlaCabjCplV1wl+GXD0YGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SCN4KcOv3LJOrCzNOiWE7iHLX1O3uEjOLXKB9dTpo6Y=;
	b=sF+1HissoZhBGcuJ08DJ0EHh3P/kzkIWNyA9qV/ZsPKuKFH8gUezjQPy8aSAaPUsMk0m
	 43sDZN8xb/WmuwfbWsFSzfC23clEALcRTGErfCLYDCQq1QzGNyNHsTnk1oGFBGiMyk6YQ
	 IONp4BLUtV9fK4DswiA11TTWA2cAfqtv0NO04yzxr4HVpLCWIbkxTUN4FkItEJ3/yRWIA
	 FkZtydiGbDdJwlD0bCzdAMD7FvAWDilRTDhGb/xlxakLm/4k5+g88/PjTZHZ0v1YIQH61
	 4QF6aexHtPYZ7e0DkYwREEr7P9RHteq47OCBRn5vS7nhPmqcF2RssIiSGCh80EGYSWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WrRds21/";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843DB606EEAA
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 843DB606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WrRds21/
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso5652555e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826481; x=1794431281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SCN4KcOv3LJOrCzNOiWE7iHLX1O3uEjOLXKB9dTpo6Y=;
        b=WrRds21/yz8NH5dHrtg6Ye6/A417PYPG/rLpSM8Liz1xbnChmsfQC/eoZV3M6itHj5
         Ffi9Xz9vjkdDWEarTdEDlJ2zqHWd2BSFwklGj40ikOegG5xHY1mbQ8RymU5ffq5+6RTy
         Xn/l7FHqjcs+khhLcurJYwaVCPBRTF2l2o/Csn6D4eeI3ihfJRl+tL64yoLaz3dAHTpo
         g2JG97J6vACO56MEW9sb+YqijfZ5pzo4s0xzncYB+Lf22mwbPzaaRdMTaIPT/MPSWwyH
         pe8FrpUBwX9C0bQqiTFgptQxsDC4mer7dTvv9yWrp5NEj+ocfpQA1934qCZt4baSi6ZS
         h+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826481; x=1794431281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SCN4KcOv3LJOrCzNOiWE7iHLX1O3uEjOLXKB9dTpo6Y=;
        b=iRJj7yg56wD83vMlNVnG9UmG0Ah4Qy80rN+LtF1HTrSHObTA0ImQtJxDbRwZtfWNPk
         QWqzKkmnHCVfgCEfh3XQldZPHbm1rvYbOVLWAcRUC2HHP2hK6cVQIDF9I0u5dOurFdyy
         oEan1sQfuFx90rYJkko8KOpKQi74WATsD13sWMzprFWHp9QSeNp+pFi+mTwVua/rRqV1
         NNi2irS5BBT9K3zmd4POnLtnRIhnCVjh8WcUNZSVMMgn6FzXtuOk//v8bz1sW+R6WHhj
         B+H492eMtqljH8TKM7ZBu6H1LWoM31wLZrlL7iORYNIbXPINSYGfIxOtttJLmqbILQc0
         r+JA==
X-Forwarded-Encrypted: i=1; AKwUvBxJ7B3a6WknLSrrbO4VsmR+N1IzeKdvgxPWBnxVvQrO2L36BEbbsHK2HT0G3B7Rtkrs+bihoiI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OL3+vLM4fKaMpOh4UOjBBQTqhUr/bgYf/iXCkK2rxR+7/VUyC
	SgatSz0fuedkA0QTHwzgLZiqXaVCwcHyt9Kn0ld9ZIoJgf2K7TyEIUNm
X-Gm-Gg: AYBFou3q9L1kcoEnUNL5cb8YJpVPwGvyVJXLzomAwFAOph9vWnNSY7jPSbzqwSeBrUd
	OiiJ0Jw3YgS60C3FtgcWCJNXPxO7N8GBXjXhy29r9LXUHPmc50edbk/UFDVw3vrrJpzfGb8RIPM
	gIAhYV2rpWle0KBqVTuNrx6vUnAn/AhhKC7hodSLsu+odeZQzlIbpgDefxzY5ZgTp7NpWqK47If
	peThFQZo7fyPD6lZk3sR7LHJ6nsMbmXN2i2xqWb2puivmjGcf7IJhZibvUQSaJnsZg2Rqp020ZN
	U1qRAK7MULhppwKbjPIIY+jNIhZVLBv8E+6gSzMfIpnf4xmxIN0HzkasNNSvON9Wii9kQ0/1UAU
	QWS0cUFzhCqIDoln95Ob9Dfkv0Qeg3tLnZvOiAGXGT5sO00i1eIakJsIU1pJTxiCRgikjiqc6Kz
	B4lYWxaDLVH1i9TpgZxbmoVG9SzAWc937GiJFNxLyv317DbEM52pgjW3MxMjNLP0/UJpYEmEMzV
	0yOXgs9wO/a8p/I3KRjxbFgnq8HgmK0ZgzwPhSyxWyscVavYX597I4PdPj1j1U711LD5Kc2GY7B
	TURXuEcU/FM9tlVRMXWgGcp3trOzzZmuhsM63tkTaoqdpXj8dPU=
X-Received: by 2002:a05:600c:470a:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4ac16acfe61mr379603885e9.5.1793826480789;
        Wed, 04 Nov 2026 13:08:00 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c23:788d:6769:d03c:c916:2aca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm11998855e9.1.2026.11.04.13.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:00 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yongzhao Chen <yongzhao.derek@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: dsa: qca8k: fix the MIB autocast and management frame handlers
Date: Wed,  4 Nov 2026 22:07:53 +0100
Message-ID: <20261104210757.467964-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The netdev AI review of the MIB statistics series [1] found bugs in
the qca8k handlers of the Ethernet management and MIB autocast frames,
and its review of v1 of this series [2] found two more. None of them
has been seen in production, so as Andrew asked for the related MTU
series [3], this goes to net-next rather than net. All four keep their
Fixes tags.

1. qca8k_bulk_read() falls back to MDIO when the management path is
   not available, but stores register i at val_buf + i with val_buf a
   void pointer, so every multi-register read is garbage: the FDB dump
   and the MDB add/del write the wrong port mask back into the ATU.

2. An ethtool MIB request over Ethernet (autocast) that times out
   leaves the caller's buffer published; late frames write into it
   after ethtool has freed it, and extra frames underflow the frame
   counter. v2 also handles the frames of an earlier autocast arriving
   during the next request.

3. The autocast handler reads up to 164 bytes of counters without
   checking the frame length.

4. The management ack handler trusts the frame for both the length and
   the layout: up to 32 bytes into a 16-byte buffer, read from
   skb->data without checking that the frame has them.

Changes in v2:
- Drop "let regmap serialize register access" (v1 1/3): Yongzhao Chen
  carries it, unchanged, as 1/2 of his net-next v8 "preserve port state
  across MTU changes" [4]; this series does not depend on it.
- New 1/4: the MDIO fallback of qca8k_bulk_read() (review of v1 1/3).
- 2/4: poll MIB_BUSY before the next autocast, as qca8k_mib_init()
  does after a flush, and track the ports seen as a bitmap instead of
  a countdown (review of v1 2/3). The description now says that a
  frame of the previous autocast still queued on the host can serve the
  next request, with counters one autocast old, instead of claiming
  that every late frame is dropped.
- 3/4 unchanged (v1 3/3).
- New 4/4: bound the data of a management ack frame (review of v1
  3/3).
- Target net-next; describe the LLM assistance here and in the commit
  messages instead of an Assisted-by tag.

Testing: the affected objects build with W=1 on arm64. On a QCA8337
behind an IPQ5018 (GL.iNet GL-B3000), kernel 6.18.60 with these four
patches, under tag_qca with the management conduit on port 0, counted
on the conduit: one ethtool -S costs 3 management frames up and 10
down (the MIB_BUSY poll, the cast, the 7 autocast frames and acks);
with the request timeout forced to 0 by a test-only module parameter
it costs 50 up and 57 down, i.e. the register fallback over management
frames plus the 7 late autocast frames, which the handler drops. The
counters stayed monotonic over 2000 such reads and over 5x200 reads
under iperf3 in both directions while toggling the timeout, with no
memory growth and no splat. Under a tagger without management frames
(qca-8021q, OpenWrt) the MDIO fallback of 1/4 was checked by the FDB
dump.

LLM assistance: Claude Code (Claude Opus 5.5 for v1, Claude Fable 5.1
for v2) drafted the code and the descriptions from my analysis and the
review findings, and helped work out the race in 2/4. I reviewed every
line, built the series and ran the tests above. The review findings
themselves came from Sashiko, the netdev AI review bot.

[1] https://lore.kernel.org/netdev/20261019191137.307514-1-kuncy7@gmail.com/
[2] https://lore.kernel.org/netdev/179304303832.3134.328719975361344250@kernel.org/
[3] https://lore.kernel.org/netdev/47e9713f-815e-4caf-8928-a7ec12d0087b@lunn.ch/
[4] https://lore.kernel.org/netdev/20261104120130.48455-1-yongzhao.derek@gmail.com/

v1: https://lore.kernel.org/netdev/20261022192933.384898-1-kuncy7@gmail.com/

Stanislaw Pal (4):
  net: dsa: qca8k: read each register into its own word over MDIO
  net: dsa: qca8k: drop MIB autocast frames once the request is over
  net: dsa: qca8k: check the length of MIB autocast frames
  net: dsa: qca8k: bound the data of a management ack frame

 drivers/net/dsa/qca/qca8k-8xxx.c   | 81 ++++++++++++++++++++++++++----
 drivers/net/dsa/qca/qca8k-common.c |  2 +-
 drivers/net/dsa/qca/qca8k.h        |  9 ++--
 3 files changed, 77 insertions(+), 15 deletions(-)

-- 
2.43.0

