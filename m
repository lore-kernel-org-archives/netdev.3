Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747390;
	b=SMGiKxxJ+1HjI59AOBbTD5d0+qgIycfOmCeyiNHr4BvIAeccjXaDqSLskiSPl2VWNJjq
	 57UgyQfhNLmY4L8R+8fjR6adK41GCQ9cPdCxt1ExjbBLdHSzfl+ntkM8j1tzoBeDbAT68
	 e9uxVEX6qyf3SjKZGYgvbW89OkZzM+plNwjAe91G7Mvwwk6f3EtSfouTXypi1t0YsFoB6
	 W2KP4TmRWzyA94NuKXcgjw7Y/EILotT9+9ijaalQ84t+lwqBL5foWL1Mza/ZW2H4uQaxh
	 /w75UdMTB1qmskCWnbHpNEhoR+8PYI5LyR+ceMIY/0pC8KOErnWEWHX1WzVJDYW2czQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747390;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Gt+qDUVF+X+thPBdjlM/bI5nSYkOxZFq1oh4C1QxK18=;
	b=iUcokFVur1TAnB7UIg0Q0lcGPZWBWEZ3b9D3oNA+AXTCG3PNHTHIXIcbYO3j6YW2abD2
	 uIAwclBmEpjs3kft8/7o5zi+rZzD7kaVvCliEPO+VI55xbX5zXDHUc4rJq8vo4UFJW0u0
	 +BeOomSaJ3dRnxjK8OpL4C3fXZRNoMN1ziP6vgJdHxawyspfbDs9ym9Nr1WUDNJh2TPDN
	 etrARjuZbvvNdCmaSnAYkBeg81gD4iMNffbRWmP67rLyEttHAXauByDb6H+QQio8O9KKE
	 hFNsJE67Oqh0xMN+jroEYp2v094Vmg7jVr4tfmX/vbfXf95wuJlUG2Wb+d7CAzfjpcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bUrp6bYw;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F0606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99F0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bUrp6bYw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gt
	+qDUVF+X+thPBdjlM/bI5nSYkOxZFq1oh4C1QxK18=; b=bUrp6bYw5oM/SHDLd3
	/g64S/BvT0gQogsPuix7S1fHOjSs1uke2ILsKwPDOIQskVhCWay4Y7MWpXFqJjx6
	O+Q4BF6yXdYiGvX6aRwKYzqTB+pR0iCbHYxMF9dDdNvsux/9rWp2tvAGImI4SNwS
	e8AZwZP6UhVg7EpkEXxrcBQJk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHL7xgJ9tqkyFtCQ--.53366S2;
	Fri, 23 Oct 2026 17:22:42 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v7 0/2] tun: fix re-attaching the socket filter
Date: Fri, 23 Oct 2026 17:22:37 +0800
Message-Id: <20261023092239.186665-1-clementwei90@163.com>
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
X-CM-TRANSID:_____wDHL7xgJ9tqkyFtCQ--.53366S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF43Xr1kuFyDCr17AF4DXFb_yoWrCr17pF
	WrW345Kw4kW347uana93yxA34Yyws7GF45uwnrG34rZan8Wry093yS9a4Yv3ZrArZ7Ww1j
	yF1YvFnFg3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-gNz3mrbJ2OODAAA3n

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v7 of the series that fixes attaching a queue to a TAP device which
re-installs the socket filter of a persistent device.

Patch 1 keeps a copy of the program in the kernel when it is configured,
instead of reading tun->fprog from user space again on every later attach,
and fixes the inverted error check in tun_attach(). The two changes are
one patch on purpose: with only the kernel copy every re-attach returns 0
without publishing the queue, and with only the check fixed a re-attach
that used to succeed without a filter starts to fail. IFF_NOFILTER keeps
working and is no longer needed to work around the re-attach bug. The
program is verified with bpf_prog_validate_classic() when it is copied in,
so a program that no verifier accepts is rejected even when no queue is
attached.

Patch 2 adds selftests: it re-attaches a queue after the buffer the program
was copied from was made unreadable, attaches a second queue from a fresh
socket to check that the filter is rebuilt from the kernel copy, and checks
that a TUNATTACHFILTER with a bad length or bad instructions keeps the
saved program, plus the ways to attach a queue without a filter.

Thanks to Willem de Bruijn for the reviews, and to the CI reviews for
the comments they raised.

Rongguang Wei (2):
  tun: keep a kernel copy of the socket filter program
  selftests: net: add TAP socket filter attach tests

---
v7:
  - validate the program with bpf_prog_validate_classic() in
    tun_copy_filter(), so an invalid program is rejected even when no
    queue is attached
  - fix the kernel-doc of sk_attach_filter_kern(): drop a reference to a
    function that does not exist and complete the Return section
  - make bpf_prog_validate_classic() reject a program whose length is out
    of range, like bpf_prog_create() does, and say so in its kernel-doc
  - document why the filter is dropped when a later step of tun_attach()
    fails, and why filter_accept[] has three instructions
  - selftests: add a case for a rejected program with valid length and
    bad instructions
v6:
  - add description for return value of sk_attach_filter_kern(); no code
    change is involved
  - https://lore.kernel.org/netdev/aa6f8ef9-56d8-4edb-9ae2-d3f3b7dc1721@163.com/
v5:
  - add kernel-doc for sk_attach_filter_kern() describing what the missing
    original program means for SO_GET_FILTER and sock_diag
  - mention in the message that a rejected header now leaves the installed
    filter alone
  - fix the wording of the mprotect() comment and note what the IFF_NOFILTER
    and TUNGETFILTER checks in the re-attach test
  - https://lore.kernel.org/netdev/20261012021113.45939-1-clementwei90@163.com/
v4:
  - merge the kernel copy and the error check into one patch, so that no
    step of the series turns a re-attach into a silent no-op or into a new
    failure
  - charge the kernel copy to the caller's memory cgroup
  - selftests: check that the queue is attached again, and attach a new
    queue to see that the filter was installed from the kernel copy
  - https://lore.kernel.org/netdev/20261003063859.136895-1-clementwei90@163.com/
v3:
  - reorder: the kernel copy of the program comes before the corrected
    error check
  - add sk_attach_filter_kern() in the patch that first uses it
  - address the review of the selftests
  - https://lore.kernel.org/netdev/20260930080746.135017-1-clementwei90@163.com/
v2:
  - roll back the filter attach when a later step of tun_attach() fails
  - keep a copy of the program in the kernel, so that a later attach does
    not depend on the address space of the process that set the filter
  - add selftests for the re-attach and for a rejected TUNATTACHFILTER
  - https://lore.kernel.org/netdev/20260929093712.131096-1-clementwei90@163.com/
v1:
  - https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/
---
 drivers/net/tun.c                 |  76 +++++++++-
 include/linux/filter.h            |   2 +
 net/core/filter.c                 |  62 +++++++++
 tools/testing/selftests/net/tun.c | 223 ++++++++++++++++++++++++++++++
 4 files changed, 358 insertions(+), 5 deletions(-)


base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

