Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362369;
	b=rOY3NFq9Ce/l0B2Onln825bQZGIbKAsxnA74l2JuIq2WJyl9G9duhoZzmAy86/bWCz1H
	 Oi6PeFyBxf2hqRfUYzSdjDk0/jm+Wn/nRaF3JbB4i+hgbx7D2gooDhFy4zt0vrSNHIpPx
	 boDRzhu68bdkuf8/mPqDqxC8WkQ7PPHyhdBektI7k96WhqelmsYLIPTFQjFOyKeWvpNF2
	 nt2KPbm1qhcFzHYziGDbu+zKUdO2zYw+aHAhJ5AmOBBguf6fX+indtFOFW5E1HiRRmht2
	 494p6eU+KSkT+xG6kft9K/bahEsll0cRbbiIOLNG/Fdvn/swWiCOxjanASiLzDIdU+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2ke5kyJBmq0AFCcx3Fu7oLeZm6H/B0W+HhAkyx1DQsI=;
	b=yWQbRjhg2TLI9d5lyXJSiXb+VRZaXf3Kmf6X6iiO+0DRcYcZYPCG21CMFuxgEUWNpnz0
	 d/3SaROo1Dg591RBp6NPD/YM81AVIQajjuOyte3Jx9bkxPh/ohpHkbqTiPdC7RQH4Giuv
	 sE7YvmHk6uK1Uiod1CnpDmM6WH0BZDsXh7ImG5v2ucJlsOfq4NBxffC6hjE2j9cP5eyNB
	 NXGma+PeQV+KAJR4taa3y6/H/Wb4tPOaSad2+4RcSl0500i1TR1t79m93TaqJ/dBWxVoP
	 p/Ci+aL8n/p5VxRzg43vfbx39e+ga/jL83k42L6mGNdg/kr5rdgR4WUQiCTojebQ6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=S5gUk4di;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD2606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8FD2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=S5gUk4di
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso3619994a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794362367; x=1794967167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ke5kyJBmq0AFCcx3Fu7oLeZm6H/B0W+HhAkyx1DQsI=;
        b=S5gUk4dimJhKaLynL3tjG1twjvBv2NBjeIh62CUJ0NqRTEyi+tsShsPrvV1cWhQd4y
         wgEM5GdyDHpe4DQ3ei6bfZRquKgULlS5MrKWXxNBbD1rPYLIz3DgkDg7hhNwHU0MIs1F
         MWcaD4YdkKLNipDvkPqD9ebyZOWngy1bQTZlttfDsjCB/3oz2bOMvGHrP73S+G9gfCsr
         SJhFCiLdBmgu1RoSbdao+CzdhvrIjIGIb6BMbKTxS7LCFFycAvFSLqTx2rmFSVSlHtU+
         +Pe6DcEHmClnNzPZWVFWkKTjs2PGPK9CGc7loRSucdDS//goGzoobiL5ipSYmBT2MEA8
         CsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362367; x=1794967167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ke5kyJBmq0AFCcx3Fu7oLeZm6H/B0W+HhAkyx1DQsI=;
        b=G2ObvnkpLxPj4FBlJ//wZ5vk+eJAI0WVuzENKYLgbIrD+rJ7Mm1fnGA/I9ZFr/uUAo
         hQGyyo6hIC9U/xz9GLFeinrLnXL1XAqBdFMYN4H5m2y1cehSaNIuyTs29hcYtO6uC4aB
         zh/zLSAFRFVgv2/g5d5Vlr4oj9Uq58KmgZeAmFUQ4sTGcO1PEWymzmcRDjuA514lFThr
         HbxkOcbY+SZaksOFgzh1D/SmZ/+Rt2PUMdYp1zV9xLkKnoIN1iyQ97ezMz2NAt3gVYqf
         O0oYlrz9XEYXpZ5KvpaiJVlkOjSD3VEb61V4lIeRg2uJrXyzq1fOUzYq2eYHupTaSiZS
         ByUA==
X-Gm-Message-State: APuU4Z/ZpvwYFCN5qd1p4wJbn8nJuv1R/ep36kNDD6vbMR4maOEvVIT2
	koew0cvOruDNuZNOcTCrgfFFh+PgCa7PhOv42TiOMM+ElwA+C3K74hxodjov/EyM3M3raMl6u+h
	rKJ60Gw0=
X-Gm-Gg: AYBFou24jkAbvEDPTouee/IrwepsEULje5QVw0rbPEF3aSJLRSUoouzLH6JPobJKbZ2
	2aR3QVllEskA8AXdjZfMgPyuSxh4gzJgiSUuBIJye9bop9KylouNFd19nKwIL5pxMm8XjHZge8I
	83wOz4mDhbuD4hzeyWEEHn21ougwwqwOK7GNFo70NnF2g98svn/1SiDa6vIMl3ObN6KRFwvqV+K
	4n/hA/vwBpvdKoVHnkZc595HYAej4W7y4g0VvZo01ygvUUIOngceup966QguYGLIndCIqPAxDfB
	7tXK+tEmQaNiAmAyCtFjUmajpXqE4vw0ZOcpz4Xwd1XQywWmhpygzMgg/9pwYczGOuHl5ksIplw
	VeLDbq01NGML4+0XTbtM8sd+M3yPYRR+mlfWUeo/YZamAG8udpyuXBhpwOdNa9uh1aKoDOw1LHR
	/iCbFA1TMMuMfmKWRzE23nFQ/iNh6GpWfhYE1Pl5hMPK3h8AwCZt0J0TkpCQzmUc1B009hrlFWx
	wjaZEpam0Kh6GdEO8DdrVRAbMK8RSA+hwkDya51I6RABYIjO2aGzqxr/1oDOspHrLYZ3Ob6oyWu
	l5a7hkiOiV0c4JvtX6h1jCUZ/omYNhZQO54WrAc/ai3O6h681nTVmE2NkQ==
X-Received: by 2002:a05:6402:4005:b0:6b7:8444:a456 with SMTP id 4fb4d7f45d1cf-6b78444a614mr130398a12.0.1794362367268;
        Tue, 10 Nov 2026 17:59:27 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm147498a12.12.2026.11.10.17.59.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:59:25 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 0/3] veth: link RX queues to their NAPI instances
Date: Wed, 11 Nov 2026 01:59:19 +0000
Message-ID: <20261111015922.67745-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
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

veth does not link its RX queues to their NAPI instances. queue-get
therefore reports no napi-id for them. napi-get lists the NAPI instances
of a veth, and their thread PIDs when NAPI is threaded. It does not show
which RX queue each instance polls. Userspace cannot tell which NAPI
thread to pin for a given queue, or which NAPI to change with napi-set.

There is also no way to busy poll an AF_XDP socket bound to a veth
queue. xsk_bind() takes the socket's NAPI ID from the RX queue, and a
veth RX queue has none.

Patch 1 is a cleanup to ease review of patch 2. veth_enable_xdp_range()
adds the NAPI instances only to pass their napi_id to
xdp_rxq_info_reg(), which no longer uses it. Patch 1 moves
netif_napi_add() into the loop that enables the NAPI instances. It also
removes the arguments and wrappers that came with adding the NAPI
instances in two places.

Patch 2 calls netif_queue_set_napi() in veth_napi_enable_range(), after
napi_enable(). In veth_napi_del_range(), it clears the link with NULL
before napi_disable().

Patch 3 adds RX queue NAPI link checks to veth.sh. The napi-id of every
RX queue must match a NAPI instance of the device. The queues must be
linked only while NAPI is enabled. The checks run with GRO on and with
XDP attached, and across RX channel changes and link down/up.

---
Changes in v2:
- Rebase on net-next. Patch 3 no longer applied after commit
  c1f04ea0aa0f ("selftests: net: check veth carrier after changing
  channel counts"). The conflict is in context only. No code change.
- v1: https://lore.kernel.org/all/20261105143356.17062-1-tianyi@cloudflare.com/

Tianyi Gao (3):
  veth: refactor NAPI enable paths
  veth: link RX queues to their NAPI instances
  selftests: net: veth: test RX queue NAPI links

 drivers/net/veth.c                  | 83 ++++++++---------------------
 tools/testing/selftests/net/veth.sh | 79 ++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 63 deletions(-)


base-commit: 79ee9e6768721f337952e9b3edd14cedbbc03030
-- 
2.56.0

