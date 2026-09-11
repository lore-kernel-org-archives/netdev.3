Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319083E7621;
	Fri, 11 Sep 2026 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099005; cv=none; b=IB/l9bHtibKmpv5wZaUbuh8a+ys7VNfYam4aQYFtbTFki0O6aPuTOdGIMSg+XcvsMHsTTYUfD+WvvH2FiRJZpHF9cSI4j/SwiryN0ISRY27IXPiEiKYJZWOBwLhDJRDO+tKwkiUtvyGzL9Nf5ao94bu3yLN1v+eevewGprFb2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099005; c=relaxed/simple;
	bh=UJcQGWQ/1A84xZkHLlREoTGPzt57JFMM8lYZ3rvp6eA=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=B4Zmkd6KwIi0e0QiA0J2N4LTiB82YmeS+fMg4dGTF8c/vXONwxJJHR6zl2/huOIV6D89p/hOVQcepumSl/ahQkDfjpVPWj4D/+5NujdacbLeZfl/wm8i2g+SJHJ11huYXUx8U3OyyWu8WFLocoO5wgMpnrUSz9vwVP4BrS2rV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hh11z5Gtmz5B12l;
	Fri, 11 Sep 2026 11:56:39 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl1.zte.com.cn with SMTP id 68B3uUl8097774;
	Fri, 11 Sep 2026 11:56:31 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app02[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 11 Sep 2026 11:56:32 +0800 (CST)
X-Zmail-TransId: 2afa6aa37bf0fbf-69704
X-Mailer: Zmail v1.0
Message-ID: <20260911115632342CS2YMSVejTTmnYEU3XbRs@zte.com.cn>
Date: Fri, 11 Sep 2026 11:56:32 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYyIDAvM10gZGluZ2hhaTogZmlybXdhcmUgaGFuZHNoYWtlLCBNU0ktWCBwb29scyBhbmQgYXN5bmMgZXZlbnQgcXVldWVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 68B3uUl8097774
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 11 Sep 2026 11:56:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AA37BF7.002/4hh11z5Gtmz5B12l

From: Junyang Han <han.junyang@zte.com.cn>

This series continues the DingHai (ZXDH) PF driver bring-up: after PCI
probing, it verifies the firmware version contract, waits for the
RISC-V management core to become ready, sets up the MSI-X interrupt
pools, and creates the async event queues through which the firmware
will report events.

Some notes on the IRQ design:

The vector space is partitioned into per-purpose pools (async, RDMA,
vq). Event queues share a vector through an atomic notifier chain
attached to the IRQ, and the sharing degree is governed by pool
thresholds. The IRQ table hangs off a void *priv in the shared core
device: the PF, MPF and SF core devices each carry a different pool
layout behind that pointer, so a type-specific struct in en_pf.c keeps
the shared header free of PF-only details.

Changes in v2:
- Convert both firmware readiness polls to readx_poll_timeout()
  (Andrew Lunn).
- Read the fw compat block field by field through ioread*() accessors
  instead of an ioread32_rep() bulk copy, which misplaces the u8/u16
  fields on big-endian; no __le annotations are needed since each
  accessor converts from little-endian (Andrew Lunn).
- Use kref for the IRQ reference count (Andrew Lunn).

Junyang Han (3):
  dinghai: add firmware version check and RISC-V readiness polling
  dinghai: add MSI-X interrupt pools
  dinghai: add async event queue for firmware notifications

 drivers/net/ethernet/zte/dinghai/Makefile   |   2 +-
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 225 +++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    |  57 +++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.c  | 145 +++++++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.h  |  61 +++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.c | 412 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.h |  72 ++++
 7 files changed, 973 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.h

-- 
2.27.0
