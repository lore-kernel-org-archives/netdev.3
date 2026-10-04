Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC50470136
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134195; cv=none; b=UqIpFnPF/dZYuH+4nYhQ88qirEeWV7MAwzvDqJy7qoazWhhdTdzOTyNPM8eoEbmm+rHAz4atanP62WadD0Riu3ThIBC65iknWuFl0hCDGYBfBUDWuCG2eTpe+hD9M/wlA0VpqeECAdpz/ZhLrLjEokESnCaizNFPOCvcNIlWCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134195; c=relaxed/simple;
	bh=XNKPCkkjrU+/+BYOooemdbVwzf8j/SyM1aIVVoHZeHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVMCBuSyOmLJ0GsJCt7b/ycFCojgKWIYHR/MLkr0w0IBjahy3fmjQo3F/XaIfCJ8Ivnkouki3NP4TQBg1BNzFoFo0tfGBBhfsZWXkmGzxd+dTYx5jK0q4kSoZH6sPz4DhTnndOIik4DfXTyTjckzCc8OOa7TBhDqYZ9a/SzZ6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=vR/skz6V; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="vR/skz6V"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2e7daa815aso68604666b.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134190; x=1791738990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJENsM5l+I7saOqNZzmQBdbyBOSHIfwstpe+vUaV7wA=;
        b=vR/skz6Viza0lpJS8v/Xu4JeO814BU5D7aUlMwvPGfCOSVZTuwmklRV8arFAkjlh/3
         mCv/r4y15Ig9+wPkBCc0X37g/F812X+IRMNiNuZapPlkHT9D6pcrM6UQU4pk5yEwnEWf
         7POTHVTkNQk3s6RViCnvHjscjOcCcg0hyfD7mts3/kKI/Vq9HuPR1nu3SVcSBphgFVoj
         z2kCNbT2I8pQtJAwKBMQQIRpUGo4tJZeEoXjcocYgOoeVD+G1qkADMOZeNY5Q731SPfK
         pUbAb6mNlxLH2KS5GXjmR8QKPkjRCMZQc9/7HoEjow2ZIP+eDDfyfsD9Q4IMoPS67wAT
         WqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134190; x=1791738990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJENsM5l+I7saOqNZzmQBdbyBOSHIfwstpe+vUaV7wA=;
        b=0Vrmbr2SL+69PR+HsPw1xF/KvHWBQYsRBy0p2y5nIv9PE2KUU+P09/fHUkg1Xwa/4Z
         4Z0eTeKEDtLiHHQemewY3DlezJRqINicPO+p/xCKkAwlf6D/vU0p5PjpMbdqR2mEVTLK
         tDySgQDdB9mHlie7vo3rdVZy9BU6BB8GmGc2pg6189ykHdOrLPtPG0JP36ybasSteaTq
         ZWbekbrLSek9VJRoNbrUw1318kYtI5kLdBPh5Cp9VmVxi4ugeLPvK466V72sY7DDu5HT
         IIbDDQa0kqttqimt5uhy+FTHs1mDq0YbdAt766ll1LCRQLdlw8l/W0zXftv32fkgVnsB
         KfFA==
X-Forwarded-Encrypted: i=1; AKwUvBwP5oV8/nFmla90bWHKA3B/s1eC/PRjzs+pxsaBFMKvSo7yGsQU3BG5a+m56zj31dJSEkqmyhA=@vger.kernel.org
X-Gm-Message-State: AFuF++mHglBALfUSwgWMYK150lPM99X7VBshtyn7VJirnc3kRPalCHZk
	APG4NPB0PZcyGJHtmg7c/gBwQMjDdPJm2bjsb6ENHfEaV4qU1DNSw3ULnYKQoSnL0A==
X-Gm-Gg: AYBFou1XrttNd2JXbM1FzV6Mv8G3DjQJUsGdfqITFq8A4jYxJ0qLJ5Y853MHuFDpL9L
	9R9vQ7dmBAjMescdnsSf5nZ0iqRZS91c0ldh3jx/L0ANaD4tG7xMGyeqV6uAXxaS7RCDDvBpVAg
	qkp7ugh/IqSrm25oGhbU0y/yxlIy1MtTXlILSc1lzTX05D3W09wwEBHgT85I7eFMRpkXlJmRJu5
	DO5bJML8dSEhOlexNNftd6+eSMzgNxYvSjtAHFTq9En4221qvQdXEVR3NZk3xKXIrd2iNghKSoJ
	/Zbw/UYIOmSm5SPyi1qPpFI4UajvkuD3KWG2XKVcdICrHSRL4pCiqZZu5X84b9oyw7lZ2TM9Fz6
	JVr8HzHJLS5Dd8lh+L0APi9GdW83lL48FCXGE1qv2Djqj3WXxI2ZMzQlvdJ1Ow+wlzj8WngS7dF
	GU6Js65Wq1279U9/q/a1SAY4rfrQ8Klw/NxGcTaaznHkUKOxODrrF880HzWVlBc71M9FkDyai1s
	KP+grVEzYkRzOUaseF9Mu/MnlwkYDlWfxttSohjVaLrqz2iYIvtZJbj0cZ+qDECrlG3by9NCrUP
	1SOoE9BgIdN0YJoBlt5ks1lBX4/6hdmLcch7SKm7h1fWcM8qvfFfwJVa5rpHo3DFUwtw/mA2h3A
	ZRqmQtpXMNWclh8rwJYeDndwZH9lx/43QNrriksDIamMbp/EE7p1SKgsvGUi2/n1lxyhOFaiFSH
	GoDOKvCX9gq0GKFb3K3bink4o=
X-Received: by 2002:a17:906:ee8d:b0:c29:f5d5:5a9b with SMTP id a640c23a62f3a-c2e4b241d8amr667125966b.37.1791134189545;
        Sun, 04 Oct 2026 10:16:29 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf9ddbesm317345166b.69.2026.10.04.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:29 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v2 0/4] netfilter: offload a TCP flow whose reply is never seen
Date: Sun,  4 Oct 2026 19:16:24 +0200
Message-ID: <20261004171628.3544978-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A router that sees only one direction of a TCP connection, because the
reply takes another path, cannot offload it: conntrack marks the
client's ACK after the SYN invalid, and the flowtable only takes assured
TCP connections. The setup this comes from is two subnets on one L2
segment, with the server answering over the shared segment.

The series adds no TCP state:
- patch 1 hands that ACK to the existing loose pickup in tcp_new(),
  gated by nf_conntrack_tcp_loose, as if the SYN had not been seen
- patch 2 keeps the reply direction of such a flow on the classic path
  until the connection is assured, as act_ct does for UDP
- patch 3 offloads the connection in the original direction and caps
  the timeout handed back to conntrack at UNACK, as
  nf_conntrack_tcp_packet() does
- patch 4 adds a selftest, which fails without patches 1 to 3

Pablo, on v1 you asked how TCP tracking copes without the reply
direction, and guessed right that the goal is flowtable offload. The
connection is tracked like a loose mid-stream pickup today: window
checks are off in both directions, and a FIN or RST still takes the
flow off the flowtable.

This series was written with the help of an AI coding assistant. I have
reviewed and tested it.

Changes in v2:
- patch 2: the XDP flowtable lookup does not return the held reply tuple
- patch 3: cap the conntrack timeout at UNACK while no reply was seen
- rebased onto nf-next

v1: https://lore.kernel.org/netfilter-devel/20260910090052.2034970-1-julius@bairaktaris.de/

Gary Dotzler (2):
  netfilter: conntrack: pick up a TCP flow whose SYN was never answered
  netfilter: nft_flow_offload: offload a TCP flow that has no reply

Julius Bairaktaris (2):
  netfilter: flowtable: promote a flow offloaded in one direction only
  selftests: netfilter: cover a TCP flow whose reply is never seen

 include/net/netfilter/nf_conntrack_l4proto.h  |  9 +++
 net/netfilter/nf_conntrack_proto_tcp.c        | 16 ++++
 net/netfilter/nf_flow_table_bpf.c             |  4 +
 net/netfilter/nf_flow_table_core.c            |  5 ++
 net/netfilter/nf_flow_table_ip.c              | 26 +++++++
 net/netfilter/nft_flow_offload.c              |  6 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 75 +++++++++++++++++++
 7 files changed, 139 insertions(+), 2 deletions(-)


base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.53.0

