Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222F322C88
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959232; cv=none; b=aAl4BHaqf0SiJA4y7RuBYKof+PzuMOCZVim4WwnAD6zhPyDjWrkO7TCUcKQB4zt3aKwVWUOH1uoeI8gdXlQytpSfHDGRnwk63qDKDfvRQHEiCW7pe/JLG9tPY3cV7bq6wK5W6XwZF1fGy6v4SOoXGADn1cx6KPCVWq7B3vli+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959232; c=relaxed/simple;
	bh=1z8hxM5s9yvUWFN2dVotJ68WWyLuICEJqjli3GIQhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7hwGI3jYSkSLp2j0qWskyRcRnzvWLkhqk/sTGW/UUBUQbQtJQjASfQIGMnL/72t4hOmcStABqgNNqKmZ/bZNv5krD3Q+FINnP8fSw2vjVMKcU/EtgjyuzG1vOsMTYLxvtncljAUVvraYyYNl10UIHqEWjg6lBqWkYMJ4F9+17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rU/v4GBi; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU/v4GBi"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76bcb1fso28473621cf.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959229; x=1790564029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=rU/v4GBi+Uf82FgKKMkVvIar/ScJzSORjOU7TXZqVWZvxI419H01gqtLz4hRGyep/J
         LXVFIdIhI0L501PYQVRWEarOo5MUDsPNQ8nSq+kuvM7zLmfdVEK41MMq8qdU05VSc7mK
         7l6r9QD5iu+Z+XziNx2D7QCm+jwXWFH2daKp4fSKK0Rhq9unMbpKlfzCAfOYNLzo4WPV
         y0AOcmI1NKDJAMvsKxHciD2Tw2GkCaX5vEyaDRKhmP7xxyvrdKHSJpoCulpnS+ReqhnC
         xcnJjrvoaVS3M8T0EmL2sJejJC8XzCgckFtdXV7jXwLdYeYCGitsf/eRNnkLKy63KUuO
         O1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959229; x=1790564029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/1dyv75kvDtXna7My+DxwKsoa7QIaIFxsslk0GYF3w=;
        b=PjoPTq8HA2ES3h1UXELvVOlj1AOKbvFmrYKIOZpEMW/ZDDxo92tn4HMX+oIAJB6ZG2
         7nK7Qfw8we8RW9KqvIp2qrKnWwHaIcrAWLJLXNxfV+uvFxgU+jo2YTiLka+gVrfgkpcY
         eSby+4hOSJjgW3Whk4DOiHyL6C8q4q9OD4kA0EBp2whLOVOEkROdxNG8vx1SZfxO33c1
         7F7gTJgyQcvMo5Nkwc7w6zRklCn0J1DZ7Ct24zSMwIh3UCQsCFl5pE22rUqVS2XTXVpI
         OBNP+fhNqqFUsOXtGV82J9v93fa2RNjcMtR/RZRtlMRtj7BQneh7XfntWZ41Y2nQLUIJ
         zcGQ==
X-Gm-Message-State: AFuF++mArbYRL7mC9rQ8tUcPjwev4D28W0P0q37qZyjeTG2aAF0zWM2w
	mbRhCAyRz3WY0AKahwBK+EMQboGnZIgdr6yGwCwmMBIU5oWmGeL9xF6Fo+mPeL58rJI=
X-Gm-Gg: AYBFou1/0wuvWTlZBFxDoqMQtKOnMusH8AgUDsW1bTrujRx9gwo3oYwreBHRme/iDcJ
	tPZO1MP95i+V1zBcStjQFVJJdvgxo2ECqWSsGOhTL+eJPGFHgHSR5ysZSBLiuFD0uXoSA8n+rYa
	H9WHaic6x5pz1o6PxDc2XG2SXFljj4B7Sq04nDwmPQGAxRhZf9IxsAQWc8Ajsz7Z+Oi6Lo2lf5Q
	AGQ0pHFmt0F57zSkW8HI6KjqohFVPuHB2zz/2o84hVMlORA1IHhmZqtbnJT3QNNu0JmizAG6F7R
	H5VY7IAR1KvJ1kTf+r3YiKyuTnascTUCscfV91DQz2GNEgyWosGISRyuoOHLpOWvXHesoeCjkuF
	/LdFoGhZQ3U7G7LW7oAxspe8zoWZ9rTUZzD649RIYV2ADDKX5HW5Lhh0Sq/4WiYlMZfJFKLgEh9
	ThhGUDCfskFOa49x+IfoeoZu4SEGNKnNHzlH6UWY4IRryPmBgg1+ipSzNezOXMow9nIdIJOlyku
	kXhPi3IrxfXxd8D66IbwHbSCimQKVLwFS6df5Bn5ierzkbnuNZrdJDy6s4qemkCNfhxOXaI
X-Received: by 2002:a05:620a:3187:b0:939:d913:9a74 with SMTP id af79cd13be357-93bf56ef696mr809392485a.46.1789959228703;
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:64b9:5e22:f77c:324e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb3de58sm528732785a.37.2026.09.20.19.53.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:53:48 -0700 (PDT)
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
Subject: [PATCH net v5 0/2] net: prevent partial checksums from modifying network headers
Date: Sun, 20 Sep 2026 22:53:39 -0400
Message-ID: <20260921025341.44846-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside the network header after link-layer removal.
Software checksum completion can then modify header bytes which the stack
has already parsed.

Patch 1 validates the checksum start against an explicit data-relative L3
origin. It covers TUN/TAP, virtio-net, AF_PACKET, UML, nested VLAN
headers, and tunnel metadata. It does not rely on skb header state which
may not yet be established.

Patch 2 independently validates the checksum start against the parsed
IPv4 or IPv6 header length in all four IP fragmentation implementations
which complete partial checksums.

The v4 Sashiko findings were correct. Patch 1 used
skb_network_offset() before all receive callers had established it.
Patch 2 compared a signed checksum offset with an unsigned IPv4 header
length. This revision fixes both findings and covers the corresponding
bridge and IPv6 fragmentation paths.

Validation included strict checkpatch, focused x86 and UML W=1 builds,
an offset-boundary model, and application of the exact mail series to the
stated base.

Changes in v5:
- Pass an explicit data-relative L3 origin through the virtio-net
  converter and audit every in-tree caller.
- Parse Ethernet and nested VLAN headers without mutating skb header
  state.
- Propagate virtio-header conversion failures in UML.
- Keep the IPv4 comparison signed and add matching parsed-header checks
  to the IPv4/IPv6 output and bridge-netfilter fragmentation paths.
- Drop Michael S. Tsirkin's Acked-by and David Ahern's Reviewed-by tags
  because both patches changed materially.

Link: https://lore.kernel.org/netdev/20260920004733.6473-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 10 ++-
 drivers/net/tun_vnet.h                     | 28 +++++++-
 drivers/net/virtio_net.c                   |  8 ++-
 include/linux/virtio_net.h                 | 76 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 +++++--
 net/ipv6/ip6_output.c                      | 12 +++-
 net/ipv6/netfilter.c                       | 12 +++-
 net/packet/af_packet.c                     |  6 +-
 9 files changed, 157 insertions(+), 39 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0
