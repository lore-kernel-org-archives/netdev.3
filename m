Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B350456DF6
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281538; cv=none; b=TNqm1dzJwxUxx6OLpYSjAFn708otlLVPp8q5nG8s4ij4G8yx4Y8fYDfXfNF8zX1gmRr6sa34CuHkxFCI1DJImAVZN1O79kv8UOGTuUPO52/rWy+ylbQuPD/tweKn3wjnm+8waybCOLnxrGqlgD2UhcsRBsTvKg5nSdUkTA7k1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281538; c=relaxed/simple;
	bh=rOpiqxy5Hwt3SE0e9vZaPQFw0gt21K2h6bHhN6d7H3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kn0sxgAEeoMfS3AXL6ymvPaN+dRquWCrrwpsyqhPfTdX1CXoP8ZKszRBEgrRoiATc8pqs1aI75s9/6NLjlCeVvF0+glfzcU5UkEcEN6zztmco2BBr9G3hLhxr4VlavUXDQCi2qkOV6Yfxo6AoJfKEpMV66QEcSF/rHBWLyZsLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=EFvkYHq3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="EFvkYHq3"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c263415982eso114165666b.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792281535; x=1792886335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Sz/9HECOnKqBct7vdatnd4ZGB8n4Dp//SRsM9tOgzQ=;
        b=EFvkYHq3KIXit4kQprAlvWxY9IQLgoJVuanjwtL6wliPZxPuhhgrWFmzf3fdd7mEpc
         GBn3qL5TYJtmVKOZoXYPG5CMKvVlLTuaEmmeRH+2XTUaG+bznxfAAYVQRi49oTfNShyK
         NUCYIIuhYgYPXQxJRgeSMFMZC3mmXd75U8SRm3+2fttad7F68zDFuNdin91L8YqMGBhX
         IgFxPs+HYnP26OCWhrknXIWhsFb4wC5pzfBJyPrzeQAWTKbecGFw9cEPRsGc/MiUhMbL
         Uw4Pckq/DZ6hsMnkyX0EeyZEmBUnJJ7X9tr2En5VoFdRCHJSWnR3Y/KDk798Rdi4+7L5
         qEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792281535; x=1792886335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Sz/9HECOnKqBct7vdatnd4ZGB8n4Dp//SRsM9tOgzQ=;
        b=tw4nCkm8F2IW3xbPKmESs+rviFsOzQMdzCz2P7uqCbZIoYPT9z5GQ663awdEDXie+b
         F5agaXa1Pto5VdMLN9AIT6vRVyuVfXoaLhUWI4yNwCJWeMAs0bOyDpI1I3/IKzl317SV
         rI7oUnBoJIm6nQBbAwwoeppBJ3IryM5wGlhDZ1dus+UFr3xBS7FADHWXZjhDUOcucxl0
         0l3aGMa6DhTzmxG2r1TjF+yHEJn77pYoWoDPaviEMa5cxLw9XmVUtoye8R2tkWAvcFKP
         j/Wrl+JicLV96Lc9XlZ/BHLWS6217i+6Oo8SkBr4a6YEOg5L6H7XXSrlTuMNAEi/El6t
         KhMA==
X-Forwarded-Encrypted: i=1; AKwUvBx/0jVf6bU0vUdrugNF/hwy6nr34zQyUjMEmO/PhhD4Y/Xu1LJ8MK77H+XgXNJ71qDlWDtYFnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIq56MOyj+PK9PJPGTmS3FsIaVycATk/eZRUTVAvjCd6/F5wC9
	sb9n4/lcI3PLKTqdANm1Y4Zou7g6OIDjT4xgHrHwcmQlexHfHqnH7P7YcJmoO0MVxg==
X-Gm-Gg: AYBFou3TWzBHnnDGbqsj3d3GGDNhQZkyGyUuXHv+wMwJq0zlIh4dkuCTwpkF1ac6fj/
	VyX6uTyrQSWMi2Gx32gVceFtQaePpM8sKTvVl/3S/r31LQQbJYUVZsIvQl0/ZxhYQoQTTUINnqg
	Cr9kaTKz+zmWdNsLe27qCrY7k+OGMoiJ+nYaiez7U59wFshF5LQ1NonV9SgwmiJV8N9cf5+7Lqz
	HlgjvDXedZgNYl7RTPxyK+xzM1EOl2QNm7IIv+XNsXsNk2yoE9c6sW3ttYP9pq8ON58AYy4os6k
	GTWsreRnAQS7vSCLVvu967UH3Gy0DorthVhPurwIr71TqeQqK/ZSMCMhuFFsjj4t3ZRAAHJfWhe
	yrPlTpC1JsmlkqYKq+HErlVLNsXWpvTCqU/MUG1jV2LvCSCzkR6CneZVKgFDugab8/gZ57/47sr
	cXadj+uhIhviiycaacZfvMM7b+XgO4z1+t0Jzt3iiDnqAkSe83dvY89nHYcj5gsdtYrMkIZLma5
	DrsMKKs07eg2il+pS8Fubz23LliLnfiBimTw/8dJUYGhVeeYLvdYsewNexvWuE9Sz0jns4zpa7G
	WJCtIGHKUSOcg3oWQeuXHnIig+4lHaCrcETGsb1u4XphyLJMx8tHgdE/uOezGCvVXCxA2dEO5lE
	JTsnQg0jdwouSJHg+zAiBZQzsFDR9hpXNdAsV8rz8QHYeYmZaj7yrT5kI/qNCZruhnCapw0zlmj
	vHynbr2+618LCcFsn1s6BsaeF5MvZqzzBHwJEWLKsQwkVKEhb+zkaqAp3MxxSR7M/FA7c=
X-Received: by 2002:a17:907:944a:b0:c2a:ef15:2be0 with SMTP id a640c23a62f3a-c419e73e10emr273217766b.24.1792281534993;
        Sat, 17 Oct 2026 16:58:54 -0700 (PDT)
Received: from Desktop.fritz.box (p200300f24741261000ca3161c2b9b67f.dip0.t-ipconnect.de. [2003:f2:4741:2610:ca:3161:c2b9:b67f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e328780sm216534166b.6.2026.10.17.16.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:58:53 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v8 0/2] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Sun, 18 Oct 2026 01:58:46 +0200
Message-ID: <20261017235849.1066624-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flowtable flow that transmits straight to a bridge port keeps sending
to the old port when the host moves to another port, for example a
Wi-Fi station roaming between access points.

Patch 1 makes the gc tear such a flow down, using the bridge fdb lookup
from Pablo's patch. Patch 2 adds selftest cases.

Tested on nf-next a5e7d8e446af in an x86 guest with PROVE_LOCKING:
nft_flowtable.sh passes, including all eleven roaming cases, with no
lockdep splat. A kprobe on flow_offload_teardown sees no teardown of
the test flow during 10 s of steady traffic in any case. struct
flow_offload stays at 296 bytes on x86_64.

Changes in v8:
- drop bridge_ifidx and bridge_vid (Pablo): the bridge port is found
  from out.ifidx through the vlan devices the forward path has below
  the port (new port_vlans field), the vid comes from the encap stack
  (new bridge_vlan bit) or is the pvid of the port for an untagged port
  of a vlan_filtering bridge
- move the fdb check into nf_flow_dst_valid() next to
  nf_flow_dst_check(), and name the hook fdb_valid_dst() again (Pablo);
  it now takes the bridge port device instead of net and ifindex
- drop the comments Pablo pointed out
- selftest: vlan_filtering with tagged plain and vlan ports, the router
  address on a vlan device on the bridge, and vlan ports whose real
  devices are ports of another bridge; no forward chain packet is
  allowed once the flow is offloaded again

v7: https://lore.kernel.org/netfilter-devel/20261014235628.197976-1-julius@bairaktaris.de/
v6: https://lore.kernel.org/netfilter-devel/20261004171605.3544792-1-julius@bairaktaris.de/
Pablo's patch: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/

Julius Bairaktaris (2):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

 include/linux/netfilter.h                     |   7 +
 include/net/netfilter/nf_flow_table.h         |   8 +-
 net/bridge/Makefile                           |   2 +
 net/bridge/br.c                               |   2 +
 net/bridge/br_nf_utils.c                      |  38 +++
 net/bridge/br_private.h                       |  13 +
 net/netfilter/core.c                          |   3 +
 net/netfilter/nf_flow_table_core.c            |  45 +++-
 net/netfilter/nf_flow_table_path.c            |  19 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 239 ++++++++++++++++++
 10 files changed, 371 insertions(+), 5 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
-- 
2.53.0

