Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591145;
	b=MRxT5ZgK/S6cY2MqbtYxIx/fiJuvOA+1dQdHxK/teo2iRYLH2QRuQ8qGcclv2UxyQaSh
	 gRqDsZD8VrRlUBc3S7Dq7zbNW/7g6f+rueX7+AgxGUkqM6tNtAmtpVF6G0LEIagDHNbid
	 KvdTUqEgp+Xh7nvPdxiPPa3HA7IFIbYdUrw5dCO1v9NQnfHypJ1i1WszR/seVjF9f6eQf
	 IVmiihhk8jX7+vE3oJ3r9DRP9O1fTKIgEtjE/v/4RLrZL37eYV/KRl5VUEiQz/knZ5r69
	 EyHTrqNP9BLhabD0RQXFP22hO/HMneAT76HrotUKI1+aAukDH4eOjTD1mYwwmmWT+xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591145;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=aZajIEoZXqWFJXvTqWoCp65x1Q98la7ofaqE3h8juPA=;
	b=ytRtyhmWXJxQ0W+Ze1Ofh0LR9KXFjHxXo2JvP7l3FqMrpg6F5XO8KRO+ZftrRPTSKjzm
	 K5Tv47SrN/Vm2gtrC0Xfc2wnn8ACx26AzePAWSsI6LciOxOHzDO9GFmwhxrfzF+Q4Zpey
	 1OKiTMljnE+wa3R5I5qgiNQ4nqPM5NV20vpLkdHKGyiQCCwFwRgudQD3x6Lc3MotSFf5f
	 ILRmFso2xbjO9sAeAj5mV5rVc+ABFNe1UXAwfCTSg+LhzU07CTEbPYCAcqE5iRRIAbifi
	 BvuggD/DntrRTUFBcCvhivR08LzOuObXXhgfv6EneJUEsQ3GIOkQiO+jIqoXSWuOaUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="JGW/Mp/b";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC90606BD3D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC90606BD3D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JGW/Mp/b
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CCA681A1647;
	Fri, 13 Nov 2026 17:32:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96EED60015;
	Fri, 13 Nov 2026 17:32:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FE9C11BC1273;
	Fri, 13 Nov 2026 18:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794591141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aZajIEoZXqWFJXvTqWoCp65x1Q98la7ofaqE3h8juPA=;
	b=JGW/Mp/bizxmIsFsoB+s3nsCg4AyaJOXdqaGLnpUfGTZ4duybZm6fs9n2YoWOs5jFgEr1a
	PZ3o3EE9zX37zPRrdUtWmS5FFhBlkjFGVyeA8F+AKIe+yQrQqF9Vorsfr4je2mNDqzpGrD
	8TQ/gov7V4mOJ9bUdD3Yo4hthyY43OraqBdCVQvMcsejPtui7sq/TLemQRIYXOG+WuI10C
	dah9KNU4oRYQgqwfG87gtMr1omkxI9pyz64pPROcTddV28RvxLD/mFsewik23kPyNZtOZU
	LAZR8CGBVr5wGTCTii3lkaPQN+G1qLNpq1bfiPuFad6t44hopSU2Kkdql8HE4g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v6 0/2] net: macb: implement ethtool set channels
 count operation
Date: Fri, 13 Nov 2026 18:32:01 +0100
Message-Id: <20261113-macb-set-channels-v6-0-5de59d9e7f02@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJJJ92oC/33PwW7DIAwG4FepOI/JQIBkp73HtAMYsyK1UIUo6
 lTl3UdzmDIl2vHXb3+WH6zSmKiyt9ODjTSnmkpuwbycGJ5d/iKeQstMgjSgQPOrQ88rTfxZZ7p
 Urn00BDYqaYG1vdtIMd1X84PlNpnpPrHP1pxTncr4vR6bxdr/486CA5c9KTcYpwKqd1/KdEn5F
 ct19Wa5MYQ4MmQzhl6aQTkRdcS9obaGOjJUM9AYb20vQvD93ui2hj0yumYIH7rYxYgR3d7Qv4Y
 AYY4M/fwFkADB92T1X2NZlh/AGcC1zgEAAA==
X-Change-ID: 20260305-macb-set-channels-5bf6e07f3270
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Add support for changing the active number of queues.
Tested on Mobileye EyeQ5.

Now that context swapping landed, update this series and use the feature
on ethtool_ops.set_channels() requests.

 - We move num_queues from bp to ctx.

 - All readers of the bp->num_queues value now need to pick between:
   bp->max_num_queues / bp->configured_num_queues / bp->ctx->num_queues.

 - The context swapping in set_channels can fail because
   netif_set_real_num_queues can fail. Update macb_context_swap_end()
   to allow taking NULL as new context argument. If that is received,
   it restarts the interface with the same context as before.

This highlights a few callbacks that are pretty broken if accessed while
interface is down, because they access hardware registers while runtime
suspended. Most importantly stats and taprio. We don't attempt to fix
them in this series! I am mentioning this here to prompt Sashiko. :)

Have a nice day,
Thanks,
Théo

[0]: https://lore.kernel.org/netdev/20261113-macb-caps-v1-0-42e0984b2f09@bootlin.com/

---
Changes in v6:
- Rebase onto latest net-next/main (573af8015529). This means rebasing
  onto context swapping, which is now used on set_channels requests.
- Move the QUEUE_DISABLE caps patch out into a separate series [0].
- Drop kunit tests. Thanks Jakub.
- Fix the TAPRIO gate test if qdisc is destroyed while the interface is
  down (because bp->taprio_gated_queues was stall in that case).
  Thanks Nicolai.
- Link to v5: https://patch.msgid.link/20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com

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

To: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Paolo Valerio <pvalerio@redhat.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Benoît Monin <benoit.monin@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

---
Théo Lebrun (2):
      net: macb: implement ethtool_ops.get|set_channels()
      net: macb: distribute evenly Tx SRAM segments

 drivers/net/ethernet/cadence/macb.h      |  21 +-
 drivers/net/ethernet/cadence/macb_main.c | 355 ++++++++++++++++++++++++-------
 2 files changed, 294 insertions(+), 82 deletions(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
change-id: 20260305-macb-set-channels-5bf6e07f3270

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

