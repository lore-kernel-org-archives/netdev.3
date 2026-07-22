Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CC35837C
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740722; cv=none; b=BElx3YAjdi4aMbfFhMU3KHSUwr9++7GxW/ZPHXwck4gB1HrUCuHOEqocdUH0GYlTYCQMBmOkPBBmPSeg+C/GHfF+naG3a3PneepbP4kHogOz4aYkOrrYpvndERV1v8jSTIrAiIdxakt8m03FzObwTV7SfL8hBSFYDLGv0a9pTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740722; c=relaxed/simple;
	bh=b8CCsYCtDOYU26UmOXYfPWeXYM9IX3RZvDTKFaNCI8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIA5u67h2d+DvnFmC2O/JBS6AfDBUPUCwoTgs1IprgYwGIU/8jLmRMr+ZXG5NqWi2tYv8q6jvHabOE5COAR7lW4Wj5Xcl4Y7R1/OZtEI4MiDmHPg+QBfvp3CU8Lb9nvGQbvl03HVLnhPePSSZmcJAdM+OeeZj2ZyXaF/IPi1uJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es0PRDyO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es0PRDyO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f611b3af9so484936f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740719; x=1785345519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJUeIBpQyzF7bWbhXrSbCIm7FpIohhGg0Yle0Q6BI7w=;
        b=Es0PRDyO7GLZWHWORq/wlAleeCjJe9zr1XXbLS8RaTGLN+V0V2Mq2hoiQp09red61z
         +TJQyrNm2Ec0uecOJtBvaYcgk1Z9ECk4YH41IV6lrSChLrlbusMV0wol/9hId0w+6H88
         NQomZ+iQEsKqG0H4qKdn0SaL8fkddaa2Q3Zek7D8kXOD/PQI6Lh4OA879ew80UwZ2jAK
         kFu0YRbPc4+YZ2Q+Py2ecjsknF8My6egovQrObHGHnUj7kh9DTGF9v7YGHfmodjw0sJJ
         oM7hCtuJGBCqnIpQF5NZqChiYroBrPKdOcvSwazm42O1ZpN3zq//P3BweC+6CFee2kMl
         VyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740719; x=1785345519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJUeIBpQyzF7bWbhXrSbCIm7FpIohhGg0Yle0Q6BI7w=;
        b=j3UbmgqlphHkwlWRIhuD8w1P4pV/TL02m2GwU8P46CBVrLzHB5usgmzvvTQDhguzkZ
         dZnxfdrDmsCs7A+1ch2rCFr372RHDGHPqHPNPMQYr0ibYcAvn/KICp1TxmRIyrVgdNy5
         69UYTCKI5mHBOFMbOZzmoP7PxfPfYfhjZv3SeeUhR075FrTwhoB0R4JrQyVs4WpyhjbY
         SmFpEOQiXiSgrFYCwUiCI4vFwJ+X7VzAl58QPfHxy+NuH5mzo0a73o5K24kFdxqk7rhG
         XJMk/NOQmlyg1jFfhQjYN7s/IJJjzSEKEwMiclGgOn1mhomYBskMkYE/smTdMZPHFGAK
         71iw==
X-Gm-Message-State: AOJu0YzI+UX48wBz6oS1/TFLJ5J24UazSc5Xzr/KIjLJC3ViKCbxIVG7
	/cWhKVyCHtBPadfvB/YslwbOkRlQZLo/48W/GKzPk+Okh1cNt6TcaOHYMb2aHXH8QwY=
X-Gm-Gg: AR+sD10XzxNeqSVxVQhzqtIKSXQ/US/RcRbtn9r2BZK3Ya2nyHKwF1DO9z8z/bEfMCa
	/AONLe3uSGoShH9M/TPuRUs6lue3/DC69wd4vUlGxO0Mumhx9oBFli1paZynzHxyQxV4zfRTC/y
	WnQ/h1HuE4UaVw+15ytcCIRr3qubZX4TG9M/MUz2ajmw5+neutXHgz9nUCiN5RdWURpHoINRLnn
	jdVly7XnalmT5O7QdAGA2sVr+uQ2vtKy61Pe1VL74hv4edv8L96CI45x6pYL+pTu2Pbg8kpTiCy
	q1Cuf3MG5X3jYLOw1NZN0QY3XLYp0OC6lfYgekbB6fjtpT9UBFMWBA1ySYOZfhX/l6RfhUDuXWl
	ACflRA3LwHwvXKAw9tOSQnoy5JappI/sGARAYyd5uC8VwlCYZ52e09Y9QakhWpDZYDhjZ3ZXEqg
	wACb8e73wr8BJpsC1XureVLvficvsrzwfR+xGK/vEl/Z07F/RGrY+yzh4daN43M6Bf+iuRemTZk
	WUZmyzNtg/+bKfPeMU6B4IErXdPhWtXGCx/0g==
X-Received: by 2002:a05:600c:46ce:b0:492:4a7a:e415 with SMTP id 5b1f17b1804b1-4956afc80f8mr29986135e9.2.1784740718717;
        Wed, 22 Jul 2026 10:18:38 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-078-051-150-230.78.51.pool.telefonica.de. [78.51.150.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a634cf9sm92427615e9.9.2026.07.22.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:18:38 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	qingfang.deng@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [RESEND PATCH net 0/4] net: hsr: fix GRO/GSO super-packet handling
Date: Wed, 22 Jul 2026 19:18:32 +0200
Message-ID: <20260722171836.196-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[resend: the previous cover letter was silently dropped by the
sender's mail provider after SMTP acceptance; the four patches
themselves are byte-identical.]

HSR/PRP forward frames one by one: each wire frame gets its own tag
or RCT and sequence number, and duplicate discard is per frame. Two
aggregation mechanisms break that per-frame assumption:

* On RX, a lower device that aggregates frames into a GRO
  super-packet feeds the HSR receive and forward paths something
  they cannot handle: frames are dropped, and on memory-constrained
  devices processing super-skbs in softirq context also pressures
  atomic allocation.

* At the forward entry, a GSO super-packet (locally generated on
  the master, or delivered intact by software NICs such as veth)
  would be tagged and forwarded as a single frame, violating
  per-frame wire semantics.

Patch 1 adds netif_disable_gro() and dev_disable_gro() alongside
the existing LRO helpers.  HSR calls the public wrapper at
enslavement time, while the networking core handles the generic
feature update and recursive lower-device traversal. Enslavement to
an HSR/PRP master therefore strips NETIF_F_GRO and NETIF_F_GRO_HW
on the lower device.

Patch 2 is a preparatory locking change with forwarding semantics
unchanged: it shrinks hsr->seqnr_lock from whole hsr_forward_skb()
calls to the individual sequence counter updates, so that the
segmentation work of patch 3 (per-segment allocation, checksums and
forwarding) never runs with BH disabled under the global sequence
lock. Patch 3 depends on patch 2; please keep them together for
stable.

Patch 3 unfolds the remaining GSO super-packets at the forward
entry with the top-level GSO dispatch (__skb_gso_segment()), so
each wire frame still gets its own tag and sequence number.
Segmentation is offered only for ingress roles whose frames are
known to be plain Ethernet: the master (locally generated) and the
interlink (SAN side, untagged). A super-packet from a LAN slave may
carry per-frame HSR tags or PRP RCT trailers that software
segmentation cannot recover, and an already-tagged HSR/PRP
super-packet violates per-frame wire semantics; both are rejected
by ingress-port policy. The HSR master also stops advertising
NETIF_F_GSO_MASK so locally generated traffic is segmented as
early as possible.

Patch 4 adds a kselftest covering the above: GRO disabled on
enslaved devices, no GSO/TSO advertised by the HSR master, and a
TCP stream from a TSO-enabled SAN through an HSR DUT completing
with zero retransmits.

Validation:
* build: W=1 allmodconfig and allyesconfig, base vs patched - no
  new warnings.
* selftests: hsr_gro_superpacket (new), hsr_ping, prp_ping and
  hsr_redbox pass on QEMU x86_64 and on physical igb lower devices.
* functional: SAN TSO streams unfold per-frame with zero
  retransmits (IPv4, IPv6, VLAN); LAN-slave and GRO-merged
  super-packets are dropped by policy; master/interlink concurrency
  under PROVE_LOCKING is clean.
* physical igb lower devices: GRO stripped at enslavement;
  force-enabled generic GRO super-packets unfold at line rate with
  a clean dmesg.

Xin Xie (4):
  net: hsr: fix packet drops caused by GRO superpackets
  net: hsr: shrink seqnr_lock to sequence counter updates
  net: hsr: unfold GSO super-packets at the forward entry
  selftests: net: hsr: add GRO super-packet forwarding test

 include/linux/netdevice.h                     |   2 +
 net/core/dev.c                                |  18 ++
 net/core/dev_api.c                            |  16 ++
 net/hsr/hsr_device.c                          |  17 +-
 net/hsr/hsr_forward.c                         |  53 +++-
 net/hsr/hsr_slave.c                           |  12 +-
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 249 ++++++++++++++++++
 8 files changed, 344 insertions(+), 24 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh


base-commit: ba712ecfd942b68b21a4b0a5daaf72f6616cc66d
-- 
2.43.0

