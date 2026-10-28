Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180001;
	b=HdvpoW/p28oYSQwy5NDuo0ufC+3D3Oa+lFWzGOdlifd7wHtYYt7Jh94qS6FQ7DuoF4VI
	 KzjH9JhA48RSGmb0TSZPCTQOklYwKcqVy2edhJYNGU5JMH5zzNoA4oyYJhl+b9vy5KZPO
	 4V+gI31AoBrXZkkYNjrPNtD4xo9Ulw7tTEY1rX24ZQ2Hd1CaxKOi6JCmgWmDxe8VSpkeY
	 sV49sZNCN/4NdqN7J16E0FM33ewlRQR6X7RP84Bc9OdQNlaGnkZutEdymLH+WSpy1fQGL
	 lU5b4djw2Zmd97Ls0pqcJk3tkdtuma19KQ6G6ibedaLeZVhlWHYePygOBuScS884VOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180001;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=nHfpGoFG0udpPhlsVXKGG8PWoGWMQ/g/z19+wRsejxM=;
	b=SDfk9tzPTYF1e30q9ubXZSeHitdvCHlEDhSg4KXYbGGQXs1kqozYMISb1rmAT3ks+EjF
	 GAQEcbsNreZiR1K/4qaEgWAi/jRddgNH2dd3BrLIe8AvJCM3bNRdfSfl2eE+Qdjjiinvx
	 C2tY92MBw5aN7qWa14+A480yjtVgTycz0GSzGDrwWWijSBq2pIF0czGoZMUqpn2YiIon/
	 ZoHskvcgsmKLQQKXj/qPF/W95Xqh0E4Zw9T+UDqb5+UgLzLRms4G810AL/Q26PfLkjVIa
	 DDLa8ifOypOBUv4Fcp/eE2iwTkfKGrCYfOUvBkYdSmgTLZkDVK7LVm7fnCWVfdp6Q9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CVT3SR2F;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B4606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D1B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CVT3SR2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nH
	fpGoFG0udpPhlsVXKGG8PWoGWMQ/g/z19+wRsejxM=; b=CVT3SR2FwJnjliGfuD
	MAkzwMsViwSMqYs3q+iNI1HpG0nK9fPlcI1qR3fL7GhXEVIWsfk053ejE/EoHvp+
	u8paxXIRnxODS1v5cTwUvwK/JzEuFMmMyAIzK5fST43ZiAEuh8oP5H2hutDJISV4
	Q7bdNI50Cv7vDh0JuGx+s7Aag=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBn5es1weFqGkWrCQ--.12186S2;
	Wed, 28 Oct 2026 17:32:37 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v8 0/2] tun: fix re-attaching the socket filter
Date: Wed, 28 Oct 2026 17:32:33 +0800
Message-Id: <20261028093235.148649-1-clementwei90@163.com>
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
X-CM-TRANSID:PSgvCgBn5es1weFqGkWrCQ--.12186S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1Dtw1DWF4DuF1xWr4rXwb_yoWrtr1kpF
	WrW345Gw4kW3yxuwn3Z3yxZ34Yyws7GF45ZwnrG34rZan8Wry093ySg34Yv3ZrArZ7Ww1j
	yF1jv3ZFg3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrrcfUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-RaQ+2rhwTb9bgAA3v

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v8 of the series that fixes attaching a queue to a TAP device which
re-installs the socket filter of a persistent device.

Patch 1 keeps a copy of the program in the kernel when it is configured,
instead of reading tun->fprog from user space again on every later attach,
and fixes the inverted error check in tun_attach(). The two changes are
one patch on purpose: with only the kernel copy every re-attach returns 0
without publishing the queue, and with only the check fixed a re-attach
that used to succeed without a filter starts to fail. IFF_NOFILTER keeps
working and is no longer needed to work around the re-attach bug. The
program is verified with bpf_prog_validate_classic() when it is copied in,
and the copy is committed only after every queue accepted it, so a program
that is refused later, when it is built, does not replace the saved one.

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
v8:
  - narrow the bpf_prog_validate_classic() contract to the classic
    verifier and note that it can also return -ENOMEM; a program can still
    be refused when it is built, and the commit message now says so
  - commit the new program only after every queue took it, so a late
    failure does not replace the saved one, and filter_attached is left
    alone
  - selftests: check the filter state and a newly attached queue in
    attach_filter_bad_prog_keeps_program() too
v7:
  - verify the instructions in tun_copy_filter() before anything is
    replaced, so an invalid program is rejected even when no queue is
    attached
  - fix the kernel-doc of sk_attach_filter_kern(): drop a reference to a
    function that does not exist and complete the Return section
  - reject a program whose length is out of range before allocating
    memory for it
  - document why the filter is dropped when a later step of tun_attach()
    fails, and why filter_accept[] has three instructions
  - selftests: add a case for a rejected program with valid length and
    bad instructions
v6:
  - add description for return value of sk_attach_filter_kern(); no code
    change is involved
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
 drivers/net/tun.c                 | 125 ++++++++++++++--
 include/linux/filter.h            |   2 +
 net/core/filter.c                 |  67 +++++++++
 tools/testing/selftests/net/tun.c | 249 ++++++++++++++++++++++++++++++
 4 files changed, 431 insertions(+), 12 deletions(-)


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

