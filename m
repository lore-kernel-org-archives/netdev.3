Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72953C3C7
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169912; cv=none; b=fZpRCv6KxLOLegSV0+QfALZkn1Bt5GQaq26KlPJJqzxxVfR0bQstWEwAZHelyqcY3uIcIiT12pEx8GmYeuctcEnmiBdRK1kzmKtnjqd5qjAzNnFLKw7fs2zc5wIuMD/sW28PKD8n9EQyev6bgo2JzpdPYGaZouHU++5YFE1lsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169912; c=relaxed/simple;
	bh=NhsK+OMWxhknfQI/SOqq/bfASSChnEp0hXGZO90rIro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PeHvI/DScxHqierhAfDs9ExD/udS8yrvmuiuApQ92QOqhzSpWNdpLds2XK6IJu6hmxT0nFbz84ZrkcqYH981zah2srNMYmngA5JcIOQU+DMUYLTGv3BahQm/XsE8/BP/Jy7BzX6MziJSUzSs83tTTGJNxM0yImgr7v5pKLEehao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yeAogyHr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yeAogyHr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5EC134E41267;
	Fri, 16 Oct 2026 16:58:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3260A6075D;
	Fri, 16 Oct 2026 16:58:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB32D103281F4;
	Fri, 16 Oct 2026 18:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792169902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=720P721GeSUPkTd93AuKx+z+0KnUKiUTcYviHaZmV/I=;
	b=yeAogyHrfG07MTdfXdgcy+98eZsJgdxpFM/whpl2J+H6snHGEbwvGTmdWdjNDq7yXAxbgq
	Z+bFTDugij6aBssZF1l6BD28K5skVr5eIoPH0kInXWs2qit9K1Igkp/ofeoijhpC5zS169
	ZQ4BPiMDJy+2Jekmagkr44xSMDsyiQdhIC8qVgs9zjFmjVp86mRW10QFVxmwpMSyDoshw+
	gsO8aqBsLETxRVwbrpxg1MGudltz/kQ8Uq/vBRq0JCCpZzlHviTkmDPsN/LhhqRpVfvWJf
	6JelkMvLttAC/1hcyVlaGsNzJUMDaf5QJV7v8f3ijiZxrd1txEfOisbXRO7W2g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v5 0/3] net: macb: implement ethtool set channels
 count operation
Date: Fri, 16 Oct 2026 18:58:14 +0200
Message-Id: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKZX0moC/33NTWrDMBAF4KsYrasiaWzJ7qr3CFnoZ6YRJFKwj
 EkIvntUr1xsuny8ed+8WMExYmFfzYuNOMcSc6qh+2iYv9j0gzyGmpkSSgsQHb9Z73jBif/WCa+
 Fd440CkOgjGB1dx+R4mM1TyzVy4SPiZ1rc4llyuNzfTbLtf/HnSUXXPUIdtAWgodvl/N0jenT5
 9vqzWpjSHlkqGoMvdIDWEkd+b0BWwOODKiG19oZ08sQXL832q1hjoy2GtKFlloiT97+NZZleQN
 17AksigEAAA==
X-Change-ID: 20260305-macb-set-channels-5bf6e07f3270
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev
X-Last-TLS-Session-Version: TLSv1.3

Add support for changing the active number of queues. Tested on Mobileye
EyeQ5. I had stalled this series, focusing on other topics. It is time
to bring it up to date and gather reviews.

I am posting this while the context-swapping series is in the mailing
lists as well; context-swapping should land first then we'll care about
set_channels. Why we want set_channels:
 - To reduce the memory usage of too many queues.
 - It makes sense to have before XDP, which is per-queue. In particular
   testing is simpler.

Have a nice day,
Thanks,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v5:
- New patch: add missing MACB_CAPS_QUEUE_DISABLE to 3 compatibles based
  on publicly available datasheets. That means they can benefit from
  the set_channels implementation.
- set_channels patch:
  - Refuse set_channels if it disables a queue with active TAPRIO.
  - Use TBQP.QUEUE_DISABLE bit to also disable transmit; previously we
    only disabled the receive engine.
  - Migrate code to newly introduced macb_queue_isr_clear() helper.
  - Adapt to newly introduced macb_quiesce_start(), where we want to
    synchronize_irq() on all queues, even the disabled ones.
  - IRQ handler now self-disarms on disabled queues.
  - Drop `old_count` unused stack variable.
  - Only allow TAPRIO rules on active queues.
  - Fix comments style and text in macb_set_channels(); in particular
    mention we'll use context-swapping once it is available.
- Distribute SRAM segments patch:
  - Introduce GEM_TXQSEGALLOC_MASK(q) and use field_prep|get() macros.
  - Introduce capability for this feature, as many publicly available
    GEM datasheets don't document the registers.
  - Remove upper register support. Lower register is enough to handle 8
    queues, which is the max we support.
  - Add edge case kunit for num_segments=128.
  - Introduce static_assert(MACB_MAX_QUEUES == 8) in
    gem_sram_distribute_segments() to signal that code will need
    updating if/when the constant changes.
- Update To/Cc list: drop Nicolas and Claudiu, add Conor and Nicolai.
- Rebase onto latest net-next/main (6b3e73774815).
- Link to v4: https://patch.msgid.link/20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com

Changes in v4:
- macb_set_channels(): drop `count == old_count` check, it is redundant
  with both netlink and ioctl codepaths. See early returns in
  ethnl_set_channels() and ethtool_set_channels(). Discussion @ V2.
- Rebase to latest net-next (8737d7194d6d); nothing to report.
- Link to v3: https://patch.msgid.link/20260313-macb-set-channels-v3-0-c66b7781ddb8@bootlin.com

Changes in v3:
- Makefile: fix compilation of kunit tests. This bug was hidden before
  because everything was builtin so it ended up linked together anyway.
  Now macb.o is the amalgation of macb_{main,ptp,utils}.o and
  macb_test.o is the amalgation of macb_{kunit,utils}.o.
- Kconfig CONFIG_MACB_KUNIT_TEST entry:
  - Turn into tristate; no good reason to restrict to bool.
  - Drop "depends on MACB". We do not need to compile the full MACB
    driver to test gem_sram_distribute_segments().
- Add usual MODULE_*() macros to macb_kunit.c.
- Drop unused init value of `ret` in macb_set_channels().
- Rebase to latest net-next; nothing to report.
- Link to v2: https://patch.msgid.link/20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com

Changes in v2:
- Move gem_sram_distribute_segments() from macb_main.c to macb_utils.c
  and kunit tests from macb_main.c to macb_kunit.c.
- macb_set_channels():
  - Add comment about MACB_CAPS_QUEUE_DISABLE.
  - Refuse operation if netif_running(), with code comment.
  - Drop useless sanity checks on ch->{combined,rx,tx}_count.
- Add help text to CONFIG_MACB_KUNIT_TEST.
- Fix `checkpatch --max-line-length=80` warnings.
- Rebase onto latest net-next; nothing to report.
- Link to v1: https://lore.kernel.org/r/20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com

---
Théo Lebrun (3):
      net: macb: add QUEUE_DISABLE capability to 3 compatibles
      net: macb: implement ethtool_ops.get|set_channels()
      net: macb: distribute evenly Tx SRAM segments

 drivers/net/ethernet/cadence/Kconfig      |  12 +++
 drivers/net/ethernet/cadence/Makefile     |   5 +-
 drivers/net/ethernet/cadence/macb.h       |  20 +++++
 drivers/net/ethernet/cadence/macb_kunit.c |  78 +++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c  | 135 +++++++++++++++++++++++++-----
 drivers/net/ethernet/cadence/macb_utils.c |  60 +++++++++++++
 6 files changed, 287 insertions(+), 23 deletions(-)
---
base-commit: 6b3e73774815910a39d8ca75b9ad7df963f61d50
change-id: 20260305-macb-set-channels-5bf6e07f3270

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

