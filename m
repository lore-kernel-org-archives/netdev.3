Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74C537BE6F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771120; cv=none; b=OgWWFjqQ2pZ08fNPtAs4E5dAaZKZzFydaUPrPBVyHdS2rOaMkAVysOfB1jhi2MaCTNCPqaAHWkJVf8RMjYcadZZ1gBSTw/8/cgy9HKdI+20ovy/kcoBecUAjS9NZzx3HaZAhHf3vxam44dB9DgR4fmeYvuCDDQHg5v291H9YukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771120; c=relaxed/simple;
	bh=X+nPGg4WzuMTgqQVoSQy+Z7cH43dSDxPwSFrGFdfNAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VoVLSTIgwQsJ+LJuxyt0hw17ZG8nDSpWHGRdLzB6aiOBEIRCwxwRP53vh4IeZ7YtxAMtC+QKPPI65iFtohpE8QyyiDitt7XNLGDoQdkgcVRJap0JJoe5y5e1Ll0CHShe107fCPs8sCvdREe+/tjgudKgH4USZge3XIs2QiyCxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ecppsQ7A; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ecppsQ7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9g
	7RJTA1WWN395zTrCYTTEsBF3mUTfm7Ewrm8cQuOvY=; b=ecppsQ7AhG7JX955Au
	qP4z5gWfh6DRDq/WqrDmCws/s8gjw++7UigQWseH5DPGqTCqLL7D0Fg3sHQIkTkC
	wEUzD3gxUwvGISmEwgycwCc39UeP5K4EohCMO5HfuTdDtR3J/5HY2Y1y0sG2DL30
	FGRXgrnJSaxm3P71ltu+SaPMg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBHksPDQcxq9pjpDw--.11839S2;
	Mon, 12 Oct 2026 10:11:16 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [RESEND PATCH net v5 0/2] tun: fix re-attaching the socket filter
Date: Mon, 12 Oct 2026 10:11:11 +0800
Message-Id: <20261012021113.45939-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHksPDQcxq9pjpDw--.11839S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF43Xr1kuw1rCry7Aw1fZwb_yoW5WrW5pF
	WYg345tw4kWryxZ3Z3ZayxZ34Yyws7GFW3Zwn7Ga4rZws8Wryjv3yaga45ZasFyrZ7uw12
	yF1YvwnIg3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4QZPumrMQcadSQAA3n

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v5 of the series that fixes attaching a queue to a TAP device which
re-installs the socket filter of a persistent device.

Patch 1 keeps a copy of the program in the kernel when it is configured,
instead of reading tun->fprog from user space again on every later attach,
and fixes the inverted error check in tun_attach(). The two changes are
one patch on purpose: with only the kernel copy every re-attach returns 0
without publishing the queue, and with only the check fixed a re-attach
that used to succeed without a filter starts to fail. IFF_NOFILTER keeps
working and is no longer needed as a workaround.

Patch 2 adds selftests: it re-attaches a queue after the buffer the program
was copied from was made unreadable, attaches a second queue from a fresh
socket to check that the filter is rebuilt from the kernel copy, and checks
that a rejected TUNATTACHFILTER keeps the saved program, plus the ways to
attach a queue without a filter.

Thanks to Willem de Bruijn for the reviews, and to the CI reviews for
the comments they raised.

Rongguang Wei (2):
  tun: keep a kernel copy of the socket filter program
  selftests: net: add TAP socket filter attach tests

---
v5:
  - add kernel-doc for sk_attach_filter_kern() describing what the missing
    original program means for SO_GET_FILTER and sock_diag
  - mention in the message that a rejected header now leaves the installed
    filter alone
  - fix the wording of the mprotect() comment and note what the IFF_NOFILTER
    and TUNGETFILTER checks in the re-attach test
v4:
  - merge the kernel copy and the error check into one patch, so that no
    step of the series turns a re-attach into a silent no-op or into a new
    failure
  - charge the kernel copy to the caller's memory cgroup
  - selftests: check that the queue is attached again, and attach a new
    queue to see that the filter was installed from the kernel copy
v3:
  - reorder: the kernel copy of the program comes before the corrected
    error check
  - add sk_attach_filter_kern() in the patch that first uses it
  - address the review of the selftests
v2:
  - roll back the filter attach when a later step of tun_attach() fails
  - keep a copy of the program in the kernel, so that a later attach does
    not depend on the address space of the process that set the filter
  - add selftests for the re-attach and for a rejected TUNATTACHFILTER
v1:
  - https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/
---
 drivers/net/tun.c                 |  56 ++++++++-
 include/linux/filter.h            |   1 +
 net/core/filter.c                 |  37 ++++++
 tools/testing/selftests/net/tun.c | 197 ++++++++++++++++++++++++++++++
 4 files changed, 286 insertions(+), 5 deletions(-)

base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

