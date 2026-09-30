Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D845D93A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755695; cv=none; b=JfrUtQzjOtL93ync6jeK5GQ3FwNqH5y7Z39HGQrwP9ui9K5mESsKZBUm4ZyrlxTvI1fBmWaC3myT5u8m1nRPGIeD05KTCfVgtO51hWHfWcub94mOeMNh0zbSl1UvIr0NROjs9AHOvqpTIlGUyGeHT6DGtPPK1432vcgqe2iut5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755695; c=relaxed/simple;
	bh=YFu53QhNgkZphCt1KePl3grBMTvq4bCdX2dLnxCniIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VRfZGpoRd3As8Tdpv4COWZh2liKaChkIbrGdjn0lus0F23MCdrTHpZJ3b3ohh9pQQhWYzDyH1N9/wdZqOaAWSNJLE9fIOWdT/gtMia7s0g4qDKqgksp1A/b5aEjhY0ySTDJyQ3gF2W3hGrhdQmQqm03yZMqVUfrHOqPGkztvink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pn6fMEMY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pn6fMEMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nw
	+tFWCjnD4RYviZ4Ysc+DKhAau/lasEFsDjcU2Df90=; b=Pn6fMEMYIFAHXb44I7
	PouB9E+CanoGCxKYgv5YBNY7X6I4zVberSiRwlcNU4pbhpIMMmlzYa/oyS492nbm
	djknmOSj0gFxUvnZaHAe+CxmgB4piWF1HNrv84THDlavfXfFE+Lr6YuNIuupBGXe
	wPQbB1Dhn+tZxIfB47z607uTA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnNiBTw7xqRdh1Bw--.20247S2;
	Wed, 30 Sep 2026 16:07:48 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v3 0/3] tun: fix re-attaching the socket filter
Date: Wed, 30 Sep 2026 16:07:43 +0800
Message-Id: <20260930080746.135017-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnNiBTw7xqRdh1Bw--.20247S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF43Xr4xZrWDuFyDZr13urg_yoW5GFy3pF
	W5uwnxtr1kW343Xan3Z3y8X34Yyws7GFW3urn7G3s8Za15WryUA3yag34Y93ZrAF92kw1j
	yFyj9ryYgw1DJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jopBfUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hXPO2q8w1UecAAA3t

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v3 of the series that fixes attaching a queue to a TAP device which
re-installs the socket filter of a persistent device.

Patch 1 keeps a copy of the program in the kernel when it is configured,
instead of reading tun->fprog from user space again on every later attach.
It also adds sk_attach_filter_kern(), the kernel memory counterpart of
sk_attach_filter(), which the patch uses. That is the second issue reported
in the review of v1; IFF_NOFILTER keeps working and is no longer needed as
a workaround.

Patch 2 fixes the inverted error check after the filter attach in
tun_attach(): a successful re-attach returned early, so the queue was never
published in tun->tfiles[] while TUNSETIFF still reported success. A failed
re-attach now aborts the attach, and the filter is detached again if a
later step of the attach fails.

It has to follow patch 1: with the check fixed but the program still read
from the caller's address space, an attach that used to succeed without a
filter would fail with -EFAULT or -EINVAL.

Patch 3 adds selftests for the re-attach path and for attaching a queue
without a filter. The two tests that cover the kernel copy fail without
patch 1; the rollback in patch 2 needs a failure inside tun_attach() after
the filter attach, which userspace cannot trigger reliably, so it has no
test.

Thanks to Willem de Bruijn for the review.

Rongguang Wei (3):
  tun: keep a kernel copy of the socket filter program
  tun: fix inverted error check when re-attaching the filter
  selftests: net: add TAP socket filter attach tests

---
v3:
  - reorder: the kernel copy of the program comes before the corrected
    error check, so that no step of the series turns an attach that
    succeeded without a filter into a failure
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
 drivers/net/tun.c                 |  50 +++++++++-
 include/linux/filter.h            |   1 +
 net/core/filter.c                 |  22 +++++
 tools/testing/selftests/net/tun.c | 155 ++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+), 5 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0

No virus found
		Checked by Hillstone Network AntiVirus

