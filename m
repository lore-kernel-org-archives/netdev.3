Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61739E18F;
	Sun, 23 Aug 2026 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513590; cv=none; b=KwgvVs8Z+EDFwZ9woujibvfqyZyMivpVJBhyW8BJIikdM1EcxDCivR4IPl/y8a4VwomhlEdTQMIGX52XFDYEh7tGOCQA9SkUxy8X4m3LwB73Ck1422F8aL34zKHpIORIt3CVcLpbS3z/mng6VZlAREo8q0U38QFAJvAqRaQSU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513590; c=relaxed/simple;
	bh=Wn07tO4tEQJGFN8jhs7v95AZI924gQZoyCqH1pLCdoc=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=WpfKTuxoKAGjC/+GHHHokKQjiA7DkcKinaZ+ZIb535Yj239ZJqfIoxRwIrA42E1OtWn1zHL/jmzFsCsj3uuExbFsfloEUnTAcLHw3VDyP5KrTcoaf8mbcRHv8Q+UJARFSkUgl88SHHixt2fAqaOx7Jx2ASYn0P6budSBZbaeHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hSkj65XrSz8R03f;
	Mon, 24 Aug 2026 03:32:58 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl2.zte.com.cn with SMTP id 67NJWjGF020919;
	Mon, 24 Aug 2026 03:32:45 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app02[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 24 Aug 2026 03:32:49 +0800 (CST)
X-Zmail-TransId: 2afa6a8b4ae1b5f-29569
X-Mailer: Zmail v1.0
Message-ID: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
Date: Mon, 24 Aug 2026 03:32:49 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYxIDAvM10gZGluZ2hhaTogZmlybXdhcmUgaGFuZHNoYWtlLCBNU0ktWCBpbnRlcnJ1cHRzIGFuZCBhc3luYyBldmVudCBxdWV1ZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 67NJWjGF020919
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 24 Aug 2026 03:32:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A8B4AEA.000/4hSkj65XrSz8R03f

From: Junyang Han <han.junyang@zte.com.cn>

This series continues the DingHai PF driver bring-up on top of the
probe skeleton and the BAR/PCI capability access already merged in
net-next ("dinghai: add ZTE network driver support" and "dinghai:
add hardware register access and PCI capability scanning").

Patch 1 makes the probe talk to the firmware for the first time: it
waits for the version compatibility block to appear in BAR 0, checks
the driver/firmware version contract and then waits for the RISC-V
management core to finish booting, so later steps can talk to it.
Firmware images predating the protocol are detected and skipped.

Patch 2 allocates the fixed MSI-X vector layout of the device and
manages the vectors in per-purpose pools. IRQs are reference counted
so that several event queues can share one vector; delivery fans out
through an atomic notifier chain attached to each IRQ.

Patch 3 adds the event queue table and the first async event queue:
it takes one vector from the async pool, reads the event id from the
PF receive sub-channel of the BAR message area on interrupt and
dispatches it to the per-event-type notifier chains of the table.

Design note: struct zxdh_core_dev is shared by several core device
types (PF, VF, SF, MPF) whose IRQ pool and event queue layouts
differ, so the generic tables in the core only carry a private
pointer, and each device type keeps its concrete layout local to its
own source file. This series wires up the PF async part only; the
remaining pools and queues grow with the series that use them.

The BAR message channel handshake that tells the firmware which
vectors to signal, the vq queue pairs and the remaining event queues
follow in later series.

Junyang Han (3):
  dinghai: add firmware version check and RISC-V readiness polling
  dinghai: add MSI-X interrupt pools
  dinghai: add async event queue for firmware notifications

 drivers/net/ethernet/zte/dinghai/Makefile   |   2 +-
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 221 ++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    |  57 +++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.c  | 145 +++++++
 drivers/net/ethernet/zte/dinghai/zxdh_eq.h  |  61 +++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.c | 424 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/zxdh_irq.h |  71 ++++
 7 files changed, 980 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_eq.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/zxdh_irq.h

-- 
2.27.0
