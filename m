Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9CA3D16FC
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674683; cv=none; b=h3HCve1vXIkcs1LU2/TTFgEcmtpaM4nA+FAyIwZhYb6g9MbPSdRdgfkBADB+ixAGjNK/VpCl0TWtLijsJnBPg63RhGj9T9xnwUjlLwl5BsATtZL+6Uau4VR+rVtqNVSIzOK33wbS4UDPzCcHsbkDxjolFDbT3lt4Y+Cg3s13Sh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674683; c=relaxed/simple;
	bh=MG+22SKh8EPhZ5SsIXYjApjAv4C9Zd/7gi5/wQnIlLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UcBdpVdhQENR9UID/8WIO+Rqm/KdxFc4AXbCaIK+khZEUM5oZwF9DduVPNxvyQPa+8gzrBjQoLzOCy6Co6kq1bPXJMrsvbCgUyzpt+Ghd1v30BaVtGTlr/hm8d8OIb98GqS9H7SKf+a6NCw2/ptIOgHXqdJ1jBAiimspP1F7s8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GbahoLY0; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GbahoLY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Os
	ks0kQJ79jJz4sApqQDkUFTGIcgd6bhLKJGIiOlrc4=; b=GbahoLY0BDhNMSsb2g
	G37Wo304he/qNDpWSDVPLHbp4nQ2XqKFxKt8V6pwThT8R2+esLqZfCVyLZ6dET/h
	pjwfAq8hTKlAIR4el0JATwm6k2nGWCgY2Xnlgno20gmGPQ6lnN18beQFDJWhzWVJ
	n6qeGODCc/rsiRwkaO2VwOFRM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCnt5nKhrtqVp7nBQ--.16613S2;
	Tue, 29 Sep 2026 17:37:14 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v2 0/4] tun: fix re-attaching the socket filter
Date: Tue, 29 Sep 2026 17:37:08 +0800
Message-Id: <20260929093712.131096-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnt5nKhrtqVp7nBQ--.16613S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4UGw48Kr13tF18JF4ktFb_yoW8ur45pa
	98Ww13tr1kW34fZ3WfZ3yxA345Aws7GFyYgwn7G345Za15WryUC3yagryY93ZrArZ7Cw1j
	y3Wjg34q9w1DJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jov38UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-gtdyGq7hsvULwAA3H

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v2 of the series that fixes attaching a queue to a TAP device which
re-installs the socket filter of a persistent device.

Patch 1 fixes an inverted error check in tun_attach(): a successful
re-attach returned early, so the queue was never published in
tun->tfiles[] while TUNSETIFF still reported success.  A failed re-attach
now aborts the attach, and the filter is detached again if a later step of
the attach fails.

Patch 2 adds sk_attach_filter_kern(), the kernel memory counterpart of
sk_attach_filter().

Patch 3 uses it to install a copy of the program that the kernel holds,
instead of reading tun->fprog from user space again on every later attach.
That is the second issue reported in the review of v1, fixed here together
with patch 1 as the review asked; IFF_NOFILTER keeps working and is no
longer needed as a workaround.

Patch 4 adds the selftest that a queue re-attached after the buffer the
program was copied from was made unreadable, a rejected TUNATTACHFILTER
that has to keep the saved descriptor, and attaching a queue without a
filter.

Rongguang Wei (4):
  tun: fix inverted error check when re-attaching the filter
  net: filter: add sk_attach_filter_kern() function
  tun: keep a kernel copy of the socket filter program
  selftests: net: add TAP socket filter attach tests

---
v2:
  - roll back the filter attach when a later step of tun_attach() fails
  - keep a copy of the program in the kernel, so that a later attach does
    not depend on the address space of the process that set the filter
  - add selftests for the re-attach and for a rejected TUNATTACHFILTER,
    without patch 3, two of them fail.
v1:
  - https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/
---
 drivers/net/tun.c                 |  50 +++++++++-
 include/linux/filter.h            |   1 +
 net/core/filter.c                 |  22 +++++
 tools/testing/selftests/net/tun.c | 159 ++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 5 deletions(-)

-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

