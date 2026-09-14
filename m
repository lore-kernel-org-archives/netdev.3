Received: from mail-ed2-f9.google.com (mail-ed2-f9.google.com [74.125.228.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB93B38AA
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370747; cv=none; b=YaRU/w6sK0GtJ2YPEplam1RZYIRB6qYWZBZbs2zaxyq+4C0d0l14JoSsbfwnUXiCAepnpTEz+oxnPb0lRzxgmoQz7p8exfv2He5KDTtP7m5Jr5imw10hFF3tpRFXjeuk/AuVGx1fKp+gdON1AZtxeTJcdnz3KxY9lLS4cwExpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370747; c=relaxed/simple;
	bh=PbFleIiEMM4EcOk80K3i/aLj+DU6YW6VYPFpTkRWFdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kcss2T1mtJboS0QUWx8vF28pOD7S2vu8suFQaePaeueHlwMbX0hF4kTsQ0KQ+MZEYqO73YjfzHnUjs+VAta75wB2z7UaWanW6E4gfY8IqxTgaS7JHBFc7A7WrSxSdj9DsWLGLCWQQtHP5apZW4V++Mb9BMG2Ma4QJZTXgL9/f/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=HrlhERzv; arc=none smtp.client-ip=74.125.228.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="HrlhERzv"
Received: by mail-ed2-f9.google.com with SMTP id 4fb4d7f45d1cf-6a99cd510ecso1549121a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789370744; x=1789975544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJ86Zw0v4ma0tFKlF0YzcCNn6ZjfpJhPEM6cbbu9cJI=;
        b=HrlhERzv16GJowlpSwSwRzhGC4CyVKDxIMOr2L4ClQFpqohN1SIx6aU15FdTk2OUSM
         qTz03o+CtiNcmGRxpRMhnAP3AKJkFsnfBV8hGW2GOYJoJWKb0ffy0Vojq8fvuRvHCZJf
         VLJG4oy5gx6QQ+btAbIUouO7D1KdDipmaEsWoqPRz54U9g0n4a/zab87zK3a6SClar4p
         NWnKyF7g3Eab1tgpbburmMCq2/D3vun8WziluNIJ5rTZ0uOsAgWVLpN1QJc1ke2hcKZp
         3Y5KNam31omL9YHakilPEOwug7ys1+Ro7velGPt4SdQZnWrY2T75ERqyRqJ5Uh5Ot5aF
         69dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370744; x=1789975544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJ86Zw0v4ma0tFKlF0YzcCNn6ZjfpJhPEM6cbbu9cJI=;
        b=ZXIV5wG5FJm0N0ctpkfw83f/ZC0o+KRtLc6G9yS1ZQNselV+h2wOOsSISFFraYNLTR
         A4HZ298NzFN8/u5BUkKas0rC2kzz22/7MpJA/dehNSLUEdNdePBsls4mDaA4Q3ee7EVI
         n8WQKrlHXNFuKubjP5El5Pbn1aVuegglKIWYWW3Y+8p2ZZ1DAUILHX9E9lSbo9lIqrWZ
         E5gF2xH7+fNsf+2o5OasxjvR1K1joNanFN65NCiY0w1LaJPq1C9P0ExgBELJO1q+CPxN
         dc2nk2SDGoJi6ZNG0iZ8cB8Vx/Nz8bNGm0k7gYdHulGQpUlSRNrjTEjpvMTUoizqvnxi
         tPew==
X-Forwarded-Encrypted: i=1; AKwUvBx6yKJi2cS3YN4Fj3OcgvyL6uV2cTmyGBn8xUuDgKiwQggyz5aM2CaJFFRiD+t7vkG65ToFi10=@vger.kernel.org
X-Gm-Message-State: AFuF++lieo8QWlRsn+5QCaBjewBdgFNABgpTE2TT7g07klCpBFwmnaOv
	n2z684ofpgVKAFjudqYauRVdNJSlXcmQzj8pCggrjWTmUvkINZFWMMxBmdcQ7sT85g==
X-Gm-Gg: AYBFou25RO703lwjkb1PQyxt+IJuasPq6NQwWHnGr7awDYgN6+yMDHCNyi2rzFafv6K
	WRbqFdUvxft4rxGget/w7dClIzhVKqljb4XiK7Y1Bw8j0EQytpOrr/sP+U6mc+McCYR3yS9EEUh
	EmMje9rQncFd/YimXcR7di3phpu8jbulDRHNEGTIyqXfv5TXqHAEvk1OjpbKk5KRggn9lEvqLoj
	MCJK84x2wztgrDRVLzmtzBZJS0Hts8FDupLVuaC4gYLa7DYC7ORI181k4A/bos5uSdVK3BWZrfz
	9Bt81os5MTk/zujfeTRyDgeJeJ9CBulLYq5uxVCpyLOzf2YacLav3sY+7au9eZYaQLFsmeMO44q
	6vruL2XlXVRb2vH5JOImPbwvzivtYe9tkTc4jrOmo2Zi7Axf7pgTK5DhcBVjXhbQ/POvcYgjhD0
	M9KwRt5bBFchN5aiDwKbmwP2OJcOfv2e3e64n+YuW2CP/M/vlhMyCHBQAj4BEUlv9XBESVVgykA
	Oz3yRbT9bOObwMrvYXo9fd5y9ejG49Mxq4uEereA37wFUOGg9dEmb5AloxGyXa+NwknE9csjoVk
	W9PCuqOO41JHNIDZg4bFEQlFjJG0DjIo7vqpYg84irQUjlht+ynCL+2xcFdyiTQDnGlMyqkTqL1
	l5CRowtpNkbygFbFEqpigN6rkATaiMyK+XbEG7WOQWJfYsAIeduHz2cy+JlzSxFAdF3dctSf2An
	onbxusGJjV
X-Received: by 2002:a05:6402:4149:b0:6a5:d8eb:da01 with SMTP id 4fb4d7f45d1cf-6a9f61583a0mr1933700a12.0.1789370744430;
        Mon, 14 Sep 2026 00:25:44 -0700 (PDT)
Received: from Desktop.fritz.box ([185.152.145.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e8a1sm382835666b.6.2026.09.14.00.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:25:43 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v5 0/3] flow offload teardown when layer 2 roaming
Date: Mon, 14 Sep 2026 09:25:38 +0200
Message-ID: <20260914072541.897040-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A direct xmit flow keeps the bridge port and destination address that the
fdb resolved when the flow was created. When the host moves to another
port of the bridge, for example a station roaming to another access
point, the bridge moves the fdb entry and the flow keeps forwarding to the
old port. Every packet the sender keeps transmitting refreshes the flow,
so it does not age out, and a hardware offloaded flow never sees a packet
on the software path where the stale port could be corrected.

The bridge notifies SWITCHDEV_FDB_DEL_TO_DEVICE for the old port before it
moves the entry. Patch 2 tears down the matching direct xmit flows on that
notification. Patch 1 stores the bridge vid in the tuple so the vid of the
deleted entry can be compared. Patch 3 adds a selftest.

Tested on an ipq807x router (OpenWrt, fw4 flowtable with the offload flag)
with a station roaming between the two radios of one bridge during a
download: without the patches the download stalls for as long as the
station stays on the other radio and resumes only after it roams back,
with them it continues through the roam, three runs each. A host moving
from a switch port with a hardware offloaded flow to a radio gets the flow
torn down and re-offloaded towards the radio.

Changes in v5:
- Rebase onto nf-next; the forward path resolution now lives in
  nf_flow_table_path.c and the tuple has no hw_ifidx.
- Store the bridge port in the tuple and match on it: the out interface
  is the lowest device of the path and differs from the port when the
  port is a vlan device.
- Add a helper for the per-tuple match.
- Drop the WARN_ON on allocation failure; the flow then ages out as
  before, the same way dsa_user_fdb_event() drops the hardware fdb
  update when its work item cannot be allocated.
- Skip local fdb entries, kick the gc once per flowtable.
- Hold the device with netdev_hold()/netdev_put() and a tracker.
- Add a selftest that roams a host between two bridge ports, plain and
  vlan, mid-transfer.

Changes in v4:
- Removed patch "don't follow fastpath when marked teardown".
- Use a work queue to process the event.

Changes in v3:
- static nf_flow_table_switchdev_nb.

Changes in v2:
- Unchanged, only tags RFC net-next to PATCH nf-next.

v4: https://lore.kernel.org/netfilter-devel/20250925182623.114045-1-ericwouds@gmail.com/

Eric Woudstra (2):
  netfilter: flow: Add bridge_vid member
  netfilter: flowtable: teardown direct xmit flows when the fdb entry
    moves

Julius Bairaktaris (1):
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

 include/net/netfilter/nf_flow_table.h         |   4 +
 net/netfilter/nf_flow_table_core.c            | 109 ++++++++++++++
 net/netfilter/nf_flow_table_path.c            |   9 ++
 tools/testing/selftests/net/netfilter/config  |   1 +
 .../selftests/net/netfilter/nft_flowtable.sh  | 140 ++++++++++++++++++
 5 files changed, 263 insertions(+)

-- 
2.53.0

