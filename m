Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4837F8DD
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134447; cv=none; b=qJjOUEtNXUCkJMvFb4IhXCdAPs+0B6G3LrC3uMA3uI5AsTYzxM2D9lGGP+L1ohVUOJmPWmmkQKWiToouu9aQfoa9oeaEo5RbnLeR1zGzClAP8WZJkIaxs7lU8n7QJKTH6YK2NplXwGvPtCXtcoDIFPEKYU9k+n1lejHYKPLflWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134447; c=relaxed/simple;
	bh=K39YGSxjfWyyl+7+GdlZVK8ivofGvEAdf1YPQNm6KVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/n0xHxsu1PD1IMF0qmR3wKVvdpRbFu9hFs7A0u7yJeF4hMDLTaVlnBUnBHRLvWjgP0a4GKWdZDzi1+OQzXkzSkV+gGNh9xBlnINttS52VA9dPG+tv9ZjLxrjS9K3/3UF0VvWyy25ZgLnJmC4DN9NIR8/ksKHub2+x3QIwBOHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IvwJRR4A; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IvwJRR4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=v9
	3WurFOh37Cc6a05HYADFjHfrVWwrve8/drkZSTFDI=; b=IvwJRR4AXjWj7jMonj
	aMiYIrfezCbDwtiOCYJBbHnLS5ZMVwzzZ6g2oru1B9HiPRaXExcfpNcw/56b5MST
	9XoprVdm0opyLW6w3Ujm3vssutp5AEeqpjxqxA7HqV5Ua+kOMGXqduNsWFH88hGh
	62+E/MnLyRSJCf1pmQCJzYHm0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnr7wPzdFqoTHrAQ--.20287S2;
	Fri, 16 Oct 2026 15:06:57 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v6 0/2] tun: fix re-attaching the socket filter
Date: Fri, 16 Oct 2026 15:06:52 +0800
Message-Id: <20261016070654.170932-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr7wPzdFqoTHrAQ--.20287S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF43Xr1kuw1rCF15ur1fXrb_yoW5ury8pa
	y5W345Gw4kW347u3Za9ayxZ34Yyws7GFW3Zwn7G34rZa15Wryjv3ySg34YvF1qyrZ2gw1j
	yFn0vwnIg3WDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-RGG8WrRzRFioQAA3-

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v6 of the series that fixes attaching a queue to a TAP device which
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
v6:
  - add description for return value of sk_attach_filter_kern and No code
    change is involved.
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
 drivers/net/tun.c                 |  56 ++++++++-
 include/linux/filter.h            |   1 +
 net/core/filter.c                 |  41 +++++++
 tools/testing/selftests/net/tun.c | 197 ++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 5 deletions(-)

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

