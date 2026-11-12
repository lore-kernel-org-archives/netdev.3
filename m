Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513063;
	b=iZHOwe83vNFwEMqtvTlUgLpyFBeU2i7/5JRWee+AwFIoNO7MLafUTDI/ZAs9ROwCKXVE
	 QdbMme2DzuYPHvXrJqPO6UICnU/wnobR5MHPKoXtl/r91Ix7oolyOCxhtjoklLWMlO7r1
	 +nAwz61QmhOxp9wo/qIRiO3a0gjVkf79YKOrerI7lbgf0zdbMAYsrJEu4T6qkx3t/9H8i
	 IhDLPHbqttbgNZmoRYGzMniIhv6suJxouo8mj4wMGfBcIMpe/IzB13goS+Q/mXex4+mVY
	 pVWG8kwrflvIJ2d5SirAFXqB/6wtNJaaiQcNF/t9ouisYYT5ydDGvYwT5rBqsmLDLJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Iy1PGAVVFI8dPYiM+gpo0fvo32WV7ANCCu1Cx/iZJPM=;
	b=yHV+oVHR1nS0/ETzRhFp0b75uhY1OaYYpOXo649KlB1IqMOYgvZZf2AGLjx/TI6yW4+o
	 jCalMViAiULLJIe/MH2KFBhYTI32yQDUzqjI+FrUencvB8xAP8mBQYquRjkBWj5b2/UiD
	 lr5eEBZK1CPbdU50npdJq9pjiXGv2sUNWEbTyjRAHYcOcSD4P/H1tMEb+IINYodkjAXSx
	 wU1l0LhUAPrJmy12N6qVNx5l3zRJbOJyDBTn38pW69AXvDNtmWBxoworT3QMcT8qT+PXs
	 zKsaeAFsyxsv+oFVqMaBbe8M2SMW+sVF11sfu2B11EUiR17grX6HnZFp081I/gkJy1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IQvutxD7;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A1606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7A1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IQvutxD7
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b704171bc9so276907a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513061; x=1795117861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iy1PGAVVFI8dPYiM+gpo0fvo32WV7ANCCu1Cx/iZJPM=;
        b=IQvutxD7F9WZ/sQGFXApOc2N+biixFiqUql7tu7RejqBuBTFnqSLJv7DSjQqMyImKH
         JF1tw4JNvYvq8lDeF/CCVrSnEgxcKxJl0EG8s7P09Yijhqg8G+J7TtUfrCewkEmbc+JV
         wiJT2GK8TVFaJHkSBNYVTHnzVraeLHMwFMZXipJzmc415lwzcfH7htdJHcAN6BQhkys+
         zG3NFwq0IXr/9iTeRDc6EdYqv8h5g/KGV7OW8z9UISipm4b4pKoQglcAMY2al/Zr9MCK
         7Gew7s277Qm3m1e+8Qh6hTt34Fy4Y/AAI8m+epsvg6NpuWvU50dHtUsG/VxvFjO85pSU
         Df0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513061; x=1795117861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iy1PGAVVFI8dPYiM+gpo0fvo32WV7ANCCu1Cx/iZJPM=;
        b=bosrIWzmBTsKtnSf5uUwZj9HygWy3sA5h0GlBRJ5yQCadvm3bSJW/dvPkEagrT5uGZ
         mtQOlaDbYTwDYHp/k8zCP90OGj/igBhpFXkjfyfB9uAkHL/7L7ITV5SHE3otKGKMgqGO
         qldTXNgjsVrvMCRlvtXvh8XjZ0VavN/lCllNkPkxzx94AQXe9nsQEB/L8jPxwy93bqQn
         5jm4Q3npHup0WDNbyV2wwk07UGHCudOP5yecpL9WM7lMYadhUyRMk98EDdIYhXqhJOWW
         covOH38/UGVDoalPB9+GR1oO0uHrD2oDSfNrdfH+SgBs4sNvLWN5z9kbYkQoKleZgxfV
         NLdA==
X-Gm-Message-State: APuU4Z/GVuy6hHWDapKV8zGX23GLHe6vZW3E26YrA/toFICMaBZc2CsT
	6+HuifkttWTiVl6qGzWwVBqXLj0UPNOicchDqUgHfatNagbnZpxBmbXVQlQDxF9q
X-Gm-Gg: AYBFou1kW6FCs1L+FlMWKkeIHczfCVUIiS+4bMvx042Qc05G5eub2RLIH1udLIvPR8F
	OTN4VdXUlrI0A2ACYUQvdRSut3brQXZLBMj7lvbJOnaER8ivDFv+LiV2ULQC1n0Wqp66FE+ioLU
	9qUuGc1oJtng1ni2KRFURtxCfKBiRwQpVcKrPm2Y0Op+Uc9BoBbsLkgz6qWaEsAIL009RnyUozm
	KWqXkfX2FZJMqEkCu+fhyHoLqKq1Rlekfpolzmkm2Nw0Skghq5k+D4NygnvqGwdUuVvS68MAEb/
	QBtQtnzEYlrgv3ROkm+35UYyjIblhK2lekj3g4WKFxPPry9NwN9G+Ibp0st5NZx4sQsM/DwOL8x
	MbPK2hpgaKkV/zyOjwO2uGArLwuBU68FW9xhBhPpAifKnpC3Ra2NPwuG5lhymRhvxGa+6Cv6oE0
	ONVpn3cdM0U/sWIgy/KDETcoghUrbfJwVj/PxmMCGuShf64Du8jZsFigfE9KJnGJ1jSYUnq0sbg
	NijZF9kB7J8j1aB8SM0P9xgCzvmmInQVGV6o+ltbf/vzFvP2VursBsjzij8FC9vb8WrtoiBevmH
	5VvZPs1tZ63IN1y8+95ZvbeVwEwLtR2JDWX8/75r
X-Received: by 2002:a17:907:6e87:b0:c49:cf3a:a324 with SMTP id a640c23a62f3a-c5096409dbcmr25078366b.22.1794513060809;
        Thu, 12 Nov 2026 11:51:00 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm11727766b.38.2026.11.12.11.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:51:00 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/6] net: bcm4908_enet: TX ring and DMA fixes
Date: Thu, 12 Nov 2026 20:50:45 +0100
Message-ID: <20261112195051.597102-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
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

These fix the BCM4908 Ethernet driver. Patch 1 fixes a TX stall seen
on a TP-Link Archer AX6000 under sustained load. Patches 2 to 6 come
from reading the code and have no reproducer.

Tested on an Archer AX6000 with OpenWrt and Linux 6.18.55, whose driver
differs from net only in one tree-wide change, with the LAN going
through this driver: TX and RX at line rate (941 Mbit/s TCP), and
ifdown/ifup of the conduit while it was sending. I ran the same again,
plus UDP at 1 Gbit/s, with the TX ring shrunk to 16 descriptors for the
test, so that the ring was full much of the time and the queue was
stopped and woken over and over (about a million qdisc requeues in a
minute). No stall, no errors in the counters, no DMA timeout warnings.

The AI review of v1 also found two older problems, with a missing TX
interrupt and with a failed RX refill. I'll send fixes for them
separately, after this series.

Changes in v2:
- patch 1: stop and wake the queue with the netdev_queues.h helpers,
  also when start_xmit() finds the ring full on entry; the changelog
  also names the slot that poll_tx() completed without a frame
- patch 3: wait for the TX DMA channel to stop before freeing its
  buffers; free only between read_idx and write_idx instead of
  clearing slot->skb in poll_tx(); drop the OWN check that could stop
  the queue for good; fix the RX timeout warning; the changelog
  describes leaks and stale frames, not a use-after-free
- patch 6: the comment and changelog no longer say where the DMA waits
- patches 1 and 2: more exact changelogs (the measured rate and what
  stopped; what driver.rst says about NETDEV_TX_BUSY)
- drop patch 7: its trigger is not reachable with the driver's own
  settings
- wrap lines over 80 columns; author name without the nickname

v1: https://lore.kernel.org/netdev/20261109235700.2586821-1-kudzo51@gmail.com/

Kordian Chmielewski (6):
  net: bcm4908_enet: fix the TX ring wrap
  net: bcm4908_enet: drop a TX frame whose DMA mapping failed
  net: bcm4908_enet: release the TX ring on stop
  net: bcm4908_enet: unmap the buffer of a dropped RX frame
  net: bcm4908_enet: unmap RX buffers on stop with their mapped size
  net: bcm4908_enet: publish the buffer address before OWN

 drivers/net/ethernet/broadcom/bcm4908_enet.c | 124 ++++++++++++++-----
 1 file changed, 91 insertions(+), 33 deletions(-)


base-commit: 86706ffa990ecd46a4326f8eecbccbbd60a6cb8d
-- 
2.56.0

