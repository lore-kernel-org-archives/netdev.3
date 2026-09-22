Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62027388391
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046199; cv=none; b=pGTuCNiVE20vlS7hrpLQ+R9e7ftbJObf5ic2sgnN1BYvK8dz1M2D490XU+ljmezpZjB3mecukw7wSm7GbEt8l6RH5aWtVuCUMWfzC9K+xFujb6+vNfoTjGnZsfxu290j31qiXKKGKQ1bcQTRt+lOn/8J9RLuCjH/ICxA+PFqzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046199; c=relaxed/simple;
	bh=7SODR36kHYK1IakVc5HOz6krTaW3m9saxbK5Vnu7M34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GY8z2zcrlwQo6YnnBivD8x8tNwlZ7AkzZD/MgXEuOPLq2OXfW8esbD5h3Iro3kgYh9rdh5O1edHCjCXuFFHxMOjCzP2TmKxcqOL6U/6P6s1egleqUAYYpqL8kCe1FQBjeJPhIzEzxWhN0BnRAqPy4buhfkJIXepyAjBhU3W5ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3UMiuor; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3UMiuor"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab19125so3688866d50.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046196; x=1790650996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=o3UMiuoreVz0HPKZg4/bawB60EG/WkxdFE2ye4gHBRClkGZh58SFrsVGfW5HQVXsft
         X0ETTi0mHf5ZmSTPYvYGlbVu/oXoT77Y4GWgGTStHw5ngc7UmD2AR17Lq4VwoIbV1KaI
         RC1J5ncG+4AILuXqVpQi1Uvmp7Ha2a0Ch/s3yQZEcvx0RO8+FC0BWsY0gtkwpcbwDAYL
         3WktoJIZYqPGLzv+54mfQ3/PW1ydgygzyyOYVmoI+omDbgdBs/QtSkI61Q45xLNFqzQV
         iCccG3YjyKGmmG+NNIn/bq/1N4d8yWGC+xEuXAVZEvopcsBsy11wt/KyJcxRLsWw9BGI
         DvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046196; x=1790650996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=YtKgw+/KcHQJl1qLpKL9zLRf6udwO1KbGyXDZcQKOrKYGXQMaPObvultR9BWq6fdPC
         Oa50qG8thhUrj+FSfcaO6RRy6uaApNhmCeH2UJo0jjGwhZwjztOh2acSiCXzVFsJ75bj
         BhQvbSAoYG5ZX+OR4GsoYQTrgCPP3YZsoXWZMxEaURQB+CoYnYgdv0ylRn7SU+4Mdwqn
         VddpT34n97smGQlV9bSA+6vK7K8zKNkOde4WiHs+1IsIKQ1dnlzG2nqXKPlrN0pObY0z
         MSOxy9oe6Zzodi2CGjGBLDFOWc1iXs2FEB1Oraupe2jL9niMhjuZGDOYHxhTi+mgW2gm
         MOaQ==
X-Gm-Message-State: AFuF++ndU5pLztHlTQT5JKjmEHnWQXRoAM9nLWsIXIW/QLVFQoyE57j0
	0K5b7ogBfEBzFwv1bP3h8Yl/yMpbS0WqxHT1+ch7CcerobEzzvQxUWRIsIfMlPl0eV7s6A==
X-Gm-Gg: AYBFou28vGYu1mv51l/dJTAs5Jzb3STjeNOHvyG3m3XDHvDR4vQAZgBeSEsHiscCWq9
	bQTThKYDIfR8o0+NdE1T2vmYPjQdI0dbNOxgQSPgB7MU0ah30uWOpYMGT6SgGPOmANhO1i+a1XS
	p/LJrI/aMQ/ggXS9tdDpOWcptk0MHTJByMIKhjvhjEXYKaTTbv+xA6bELILfruhm2S6gSSLEJY1
	Bgiv1mtNc+9gUVJlviCoyZzoXDH7EUgA23auSQgqg0mZG1WXFwShyZToTPJrBVucl46VzCUIgHJ
	TjiKbpHcOJRTWRaKhvD9yecKbFvrcYsO7TqxobJgTMM01/MVrhMU5XgIK4hb7WX8biVIIBA2KIV
	qH5q21xk40CUNs2dGtFKwEIUz4VkmegOWnKYkaMc6BypFeTB6ZgJhXijR9dEDhU7bM9Glqxtg8m
	Qdx8RnoKfM31jLgUSRwEe/DlQPY4MsBM9ikkW0CbZEuh9CgtrplcV13M051qgIPkzIRHsVC9LkF
	LGRyR99n2H8DfQdsDzdnUujyFPG4pfPX7jk5k7Xanyou3Hf2z5dO5SPY0IkwGvegQxHA2x6
X-Received: by 2002:a05:690e:1181:b0:671:70d2:527b with SMTP id 956f58d0204a3-6717fd6a661mr4352075d50.62.1790046196312;
        Mon, 21 Sep 2026 20:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:2875:43a3:e345:710c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c1b02abdsm1471447b3.17.2026.09.21.20.03.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 20:03:15 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 0/2] net: prevent partial checksums from modifying network headers
Date: Mon, 21 Sep 2026 23:03:08 -0400
Message-ID: <20260922030310.8684-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside a network header. Software checksum completion can
then modify bytes the stack has already parsed.

Patch 1 checks the data-relative L3 origin in the virtio-net conversion
paths. Patch 2 checks the parsed header length before checksum completion
in IPv4 and IPv6 fragmentation paths.

Changes in v6 address Michael S. Tsirkin's review of v5:
- Name the Ethernet-only L3 parser accordingly.
- Derive the AF_PACKET L3 offset and protocol from the actual Ethernet
  frame, including inline VLAN tags on an ETH_P_IP raw socket.
- Use the IPv6 base-header minimum for IPv6 checksum-only packets,
  including IFF_TUN before skb->protocol is set.
- Restore Assisted-by: LLM on both patches. Patch 2's code is unchanged.

Validation: focused x86 allmodconfig and UML defconfig W=1 object builds,
strict checkpatch, and application of the exact mail series to the stated
base. No runtime regression reproducer was run.

Link: https://lore.kernel.org/netdev/20260921025341.44846-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 13 +++-
 drivers/net/tun_vnet.h                     | 52 ++++++++++++-
 drivers/net/virtio_net.c                   | 10 ++-
 include/linux/virtio_net.h                 | 87 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 ++++--
 net/ipv6/ip6_output.c                      | 12 ++-
 net/ipv6/netfilter.c                       | 12 ++-
 net/packet/af_packet.c                     | 24 +++++-
 9 files changed, 214 insertions(+), 40 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0

