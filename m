Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BE34CFA7
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795737; cv=none; b=iIgR2dJ++aCoOShuDqLuvzI0eBU1IVNZGQgshvdtqRe2278kzhabhXL3+LbZ32oWq+ipC+x3inY2vHmKUgLlJQAX7JCRnxN6IjEPMwBHrUqBf3vW8UXtnjnHFB5TCzZ2tWu6oeVvA+ZMbc4bYvkp8K0+9kEzdqefmhs8rCF/R5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795737; c=relaxed/simple;
	bh=L32eEk+AigImqaI9Q3Qd9blnSll3e0y4JFG4WoijinY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ixJhrwZPefRZIAt7YkC86MSIW7aywUhhEGeNZXkEpf5EqvfrDqfJMWFFZ9IUUsclOZSilySW2r/HkgPt8cbuhtITjlqKv+MNmMIy48XbIzTJgObOpB2hmS0DgRoe/9W8yNggHKA678l4QyL9E60jlaUIq2YMkPehbxi3djv1Wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9MODDh6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9MODDh6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-473987fc217so243830f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785795734; x=1786400534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xu1jtT5ad/3aIuWjkcapvBTalwstqcPff6mpQ3x0HLc=;
        b=Y9MODDh6X48DN5xFSDMSUVd/F6I/08NuXsCwGkC9gWgAA9guylYvTMtLP2FnAs1aIa
         Jbpvb1NPpW2Q6idwzXewdrJJKi1stDPiI6KqNd+J10+6elT3uL2CpX+h/LWNOy8B0FoM
         PIMG1Y8vD/vi51bC4fqbGsEUAqng4lxKulPLCFcZjAFQj08us7m8Zka/LgQnFjbaX13R
         eOE2rNy41dhjGgYBuWY38P45de6kORc3npQpbJyyHTj5Y0grzs5/ALLjDLa1JjSgpw6N
         GqfwZ8rofcWxvDNBIk/ZwXHrdsq0e7jSKLwCvsCUIiiLC8R8+mgSxrpJNDbH58BzPkK8
         KaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785795734; x=1786400534;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xu1jtT5ad/3aIuWjkcapvBTalwstqcPff6mpQ3x0HLc=;
        b=HLrsIpVuaoLKZKTQQM3x98D/my88bI1UMFP5plyW4lj8s4TbqqhpMTJnTq3WYo9em/
         g9fESPj33G4XM479dpOiDJCIpFsVLraBNWD2a1QCY4B28eigN9adC5wBvn0fIaovz85v
         yCwhWWOjWhmTmPrxOZ4Q2zWb/SDQkVNAj/yNEU8avGEoNQ8bli4f5o1S4HQRhHtf+tP1
         /9G+it3irzEJz2INEvcB9yfjKP/IC0MLCLeRjvdcGVrmlSLkM6BPCZ+diN6ORT9lNkf9
         xs702S46F3+STqD66BMBuDyNoD3/dP+CqjowZZnEnQG6lhZrs60Vt8Uj9MKkPvbJu5gF
         ShCw==
X-Gm-Message-State: AOJu0YxkgXQdz2sdxu3Tk1QYB/5W+0ni3NCnlp7ivzv54krq6tlbdXyJ
	4JiGgR8T/MW1TJbYqNcgx0f1qtzECmVBlSwzh+UfQy+zLBihGuxt6s4BG64RHzwFSmk=
X-Gm-Gg: AR+sD12tkCXEbUwusYK1bbb+SGVURuZzXW0A73jbpGhrh5fCk2TKH29+NyA3eOW+1c8
	t7+Uu+rFuH1wwZiYGNznGC1iVRhE5ocuky/T88Ay+qdUatSjZdG7TjjagKIKKn8p+4XX4k9hbmZ
	JnZ6Wa3dtUcgDyXrRZcV17VqpSQI4GB8gL/sYSDDgahbQ7Tme6eS8t5LVHcIzcY78mVALkY3CJj
	e7+kDDtj0RhyQz8hIZ7B30nTW6aAlpF2J+UAdMl6PBoxAkLkM3KZoWtNJDbSdaGRC1X5I7JwFkS
	krtZc6PW+xtK9DVcA9B9paVFzTjhAP6k/anaTa5o1EMGl3i4SL/R/3AZOYBBZyXpbsQrQtq3EGP
	ZpnWU0jtcfeRrrw/Dc6SnwCH36RJGhK/BtGkfoh3Yte/FPq4XUQum2XgDBuhIQ4M7ETW5pzFbAJ
	EwqgZMYIvV6zr0+h9+hXkRospFiKVFbc+m4G7f4MjmXHLKAZNmbpU3O2lOZVNafXUgcKvnq5cSM
	wcQQPRsUZXwkSFx44VBrbGS3woRPpZ4CBxgAAu0iXjAsolU4/O+MKeV7auV1AuNbxioXF7dRpGU
	sGpwvp1lOq5ydLbUrAQ=
X-Received: by 2002:a05:600c:35d0:b0:496:bbce:ef with SMTP id 5b1f17b1804b1-4980c694208mr146408445e9.3.1785795734106;
        Mon, 03 Aug 2026 15:22:14 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-012-149-099.77.12.pool.telefonica.de. [77.12.149.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2da2sm31668145e9.3.2026.08.03.15.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:22:12 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v4 0/4] net: hsr: fix GRO/GSO super-packet handling
Date: Tue,  4 Aug 2026 00:22:07 +0200
Message-ID: <20260803222211.877-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HSR/PRP requires per-wire-frame tags/RCTs and sequence numbers, and
duplicate discard is per frame. RX GRO and TX GSO can present
multiple frames as one skb and violate that assumption: a super-skb
is either rejected by a constrained lower device, or forwarded
without valid per-frame trailers and sequence numbers.

Patch 1 adds netif_disable_gro()/dev_disable_gro() and disables
GRO and GRO_HW on lower devices at HSR/PRP enslavement time,
mirroring the existing LRO treatment.

Patch 2 shrinks hsr->seqnr_lock from whole hsr_forward_skb() calls
to the sequence counter updates, so the segmentation work of
patch 3 never runs under the global sequence lock. The outer lock
also incidentally serialized the tx statistics updates in
hsr_forward_skb(); those now use the atomic DEV_STATS_* helpers.

Patch 3 unfolds the remaining GSO super-packets at the forward
entry with the top-level GSO dispatch (__skb_gso_segment()), so
each wire frame gets its own tag and sequence number. The HSR
master also drops NETIF_F_GSO_MASK from its advertised features so
locally generated traffic is segmented as early as possible.

Patch 1 provides the normal setup-time default. Patch 3 is the
fail-safe when a privileged override or another source still
presents a GSO/GRO super-packet: plain-Ethernet super-packets from
the master or the untagged SAN side are segmented, while
super-packets from tagged LAN ingress are rejected by ingress-port
policy.

Patch 4 adds a kselftest covering the series.

Patch 1 is independent. Patch 3 depends on patch 2, and patches 2
and 3 are selected for stable only on 7.0 and newer, where
sparse-bitmap duplicate discard accepts out-of-order arrival.
Older branches need adapted backports.

Validation:
* the v4 kernel builds cleanly, and W=1 allmodconfig/allyesconfig
  base-vs-patched shows no new warnings;
* hsr_gro_superpacket passes on the v4 kernel and fails on the
  base kernel with the expected mechanism;
* hsr_ping, hsr_redbox, link_faults and prp_ping all pass;
* no kernel WARN/BUG/Oops, no leftover namespaces.

Note on the contest report: the contest conflict is with the
already merged PRP RedBox work.

- In send_prp_supervision_frame(), preserve the Type-30 RedBox-MAC
  TLV and EOT construction, release seqnr_lock immediately after
  the sequence-number update, and remove the later stale unlocks.
- Insert hsr_gro_superpacket.sh at the sorted Makefile position.

This composition builds and both the GRO/GSO and PRP RedBox
selftests pass on the tested net-next tree (69963a0678a3).

---

Changes in v4:
- Patches 2/3: the four tx statistics updates affected by the
  seqnr_lock shrink now use DEV_STATS_*, so they cannot lose
  increments on the concurrently callable forwarding paths.
- Patch 4: three namespace variables are explicitly initialized
  (empty), clearing the ShellCheck SC2154 findings.
- Patch 1 is payload-identical to v3 and carries Ali Ahmet
  Memis's Reviewed-by and Tested-by from the v3 thread; his
  Reviewed-by is not carried on the modified patches 2-4.

Previous postings (newest first):
v3: https://lore.kernel.org/netdev/20260731090224.18-1-xiexinet@gmail.com/
v2: https://lore.kernel.org/netdev/20260724161253.79-1-xiexinet@gmail.com/
v1: https://lore.kernel.org/netdev/20260722171836.196-1-xiexinet@gmail.com/

Xin Xie (4):
  net: hsr: fix packet drops caused by GRO superpackets
  net: hsr: shrink seqnr_lock to sequence counter updates
  net: hsr: unfold GSO super-packets at the forward entry
  selftests: net: hsr: add GRO super-packet forwarding test

 include/linux/netdevice.h                     |   2 +
 net/core/dev.c                                |  18 +
 net/core/dev_api.c                            |  16 +
 net/hsr/hsr_device.c                          |  17 +-
 net/hsr/hsr_forward.c                         |  59 ++-
 net/hsr/hsr_slave.c                           |  12 +-
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 465 ++++++++++++++++++
 8 files changed, 563 insertions(+), 27 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh

-- 
2.43.0

