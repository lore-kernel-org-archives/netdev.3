Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434F377A89
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009577; cv=none; b=ki2XW7ya9rQJN7m13MpA570Ub21nHVveHRvkbtbQWKgYd+DCo77sY3Hpq1CYWwBQgM9MYpHxxAdkfqSAY7QZh8M86kGGuy2kHrROp5VwwvsItGf7FSYdEgCAnIvW17BbrIEhQnKEX3bRjC1I4l0dXxwNxiAaXjy/fOnvZHdiAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009577; c=relaxed/simple;
	bh=I8T8XTYxcCgX2Ir1lfsA7jF+T8sRSV36CDj+wxJeNbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XVwgUVc4oW2zED9UtqvSpxuEMZU6rKKxuEfYJNSePRkA+yFpzwu8W/DefKyCxlcjRrB1d0H1Er0rlRA+kov+i2w7EDx2DHr85GORTb82Jw3f3l3NfHDnNYhixheEIq+Kh+QDGAlxJ2SzUkGzHnuyK5kLHbJUJ/CvxDq86t+yfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ARlsNXAh; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ARlsNXAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3D
	/7y/WW4sPagmyMrlAm8civXyyfDUyE5UyNP3pHT6Q=; b=ARlsNXAhXAjFTMbY/Z
	dco2CfHZf5NiOeeTayUYtqgB8m7A/rV/SRjSFCzjAstaVaqh9YUSSFxTuedTzd7G
	nfjc5OSDCWurV1vpBZrzuvCsGRYlaZJEcvuZPjkzLJ+vChqE35xVyEsNgi48IW8c
	N5AoqdNL8Xa7EiPiCf7uKqQXU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXD0AEo8BqidfxCA--.46014S2;
	Sat, 03 Oct 2026 14:39:02 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v4 0/2] tun: fix re-attaching the socket filter
Date: Sat,  3 Oct 2026 14:38:57 +0800
Message-Id: <20261003063859.136895-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXD0AEo8BqidfxCA--.46014S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1kCw17uFyfuF1ftrW5Wrg_yoW5JF17pF
	WYg345Kw4kW34fZ3Z3ZayxZ34Yyws7JFy5Awn7Ga4rZw45Wryjv3yaga45Z3W7AFZ7Gw12
	yF1Y9r9Ig3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4Qe0IGrAowcCxgAA34

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v4 of the series that fixes attaching a queue to a TAP device which
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
 net/core/filter.c                 |  22 +++++
 tools/testing/selftests/net/tun.c | 193 ++++++++++++++++++++++++++++++
 4 files changed, 267 insertions(+), 5 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

