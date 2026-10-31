Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793465786;
	b=ybhcGRz4Vl9ENwOEWrtaKC1MHBXwC+QsW/WjOf2y9/BDm4Tg6kwz9UptUcGDvRsFqpc8
	 C4r+DOERwSaSzqGwlCrv1AM9FcQ4E1FHtjdpa0w04wbiF5u9XMxXQUUPpoLfDnUtu5O8L
	 CC909pzVXnG3qobn+1xlCi9wAfeyklMgZ6uGE0LI9l4r9ri/dEI/e5qRXC2EcOa1FiaSP
	 zAMvGNFyngd43Tnk29HZjs9oB2rvRtOzZEHzwvDeVo/e+C6QtuLQtyLcXoem921S9qM9g
	 jM7L5a3MtAOMDntn4MiYMrbvkpQsXXrAYFMZJtTgQpV9obhWq2Rpwr+QCGvY0L+nsqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465786;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=EVF6RdiwtK7ySXrGg/OxVDQSdtfvubc6HIQITiK9qCk=;
	b=WVJfNgaBoukNq9J8RKATQWVd1+7uZ45Y5dnsWdNx3Ej2MvtOky+roFb4k1/P9jqnRk3V
	 gbg8iZlOW/MoPvvpwHv+Z1JorREMdSaMd9VtI0oMsXXu8Ebg1iJ7ZT+/+4xEN7trQx1LJ
	 hUqm/CW/PQE8Gaq4grMV3T/wLZlLRdhVOhFsq7MqCtDSprcceed3N7W4rB8VdAkHELeuu
	 ACCcalceL/0vhq2IkF1Ky0H7eToYq/V0+YYwMrOtJbrW3eQefJzirNybSnNem21VH7obt
	 NCw0EyJYAcl+ZtziCuW7gDsLtmQwDY+7vX3asaSPYdLlzI/hgmjIxaeuqozqJsZ+6Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=UsNzB9rJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6991606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 16:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6991606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=UsNzB9rJ
ARC-Seal: i=1; a=rsa-sha256; t=1793465773; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GWasxcZ5q+0Yn27H1s9/VAQ7kUv6Ih9RliFKyioJDoOC5oZEzlYTRbQkswFpuhh8kUUgAetu+bnaEIGnzHWS3q7kZyuMiIgowEHqvzPXlzK6uct5seVVLGUv6VmVRvAloCLB+Z9HzbsHJsXMhUZjSLjWYYOUsD9kUD6QwHXAJy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793465773; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EVF6RdiwtK7ySXrGg/OxVDQSdtfvubc6HIQITiK9qCk=; 
	b=A+FBqbME6SW4MJ3eIGQ/YdhpjFcH/h9zhqUne9vd0WNyk3oKHJaX/mN+5ZVrOosJMps9cyjF9tUZEQtDvenU6yKe4JOE6XXJU+rkLTBvy+57JznCsYARrJj24Wc8gfzSnHZ7ZHqIF7ri2Haizx38C0BunU4+V7uiCUWXXLHpLF4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=UsNzB9rJM94LmFH39b9CYRK7OM12vN8FvYNbDCsbA4ZWoTYyfCKhzFGhTBo3Tqm7pgEdSuIlSYcsLuFQaX1KsqHwczgnF3SNEVHIOKPfglkWY9iDTD9Uf+lrNU764RiLBWT6te9pX1VMSxX1fkz2/lP4HQyAL4Y6pMYV6aZY/5uV5WmrailSvx4132kjb8nRxTOqJOdtdB4RFAuSx18n6N1rJVEXW4LqyxFjZOocmk10bP6Lv8HOt6R8YfbvLIhvQE/ABHv8U53Xmz+BHtQuQjqEifazB/czxE3lttsAm8x+rrmC997SoRin6o2Hgbre+V8wjwHAeF4jjjOcyAJs+w==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=EVF6RdiwtK7ySXrGg/OxVDQSdtfvubc6HIQITiK9qCk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179346577103667.93424516622622;
	Sat, 31 Oct 2026 09:56:11 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v11 net-next 0/3] Implement PTP support in netdevsim
Date: Sat, 31 Oct 2026 17:28:01 +0100
Message-ID: <20261031162804.1893-1-maciek@machnikowski.net>
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
X-ZohoMailClient: External

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.

It also adds the selftest to verify the hw timestamping functionality
running over netdevsim.

v11:
- Avoid aliasing the RX hwtstamp write with AF_XDP completion metadata
  (skb_shared_info's hwtstamps/xsk_meta union) by orphaning the skb
  first, addressing the Critical finding from Simon Horman's review.
  Link: https://lore.kernel.org/netdev/20260819101706.GP265046@horms.kernel.org/
- Only unshare the skb when an RX timestamp is written into it
- Reject non-zero hwtstamp flags and accept the PTP V2 L2 RX filters
- Use READ_ONCE() in ndo_hwtstamp_get and stop overwriting the whole
  config struct
- Skip the selftest if either the local or the remote device lacks
  hardware timestamping support
- Forward declare struct ptp_clock_info in ptp_mock.h
- Fix the ptp_mock commit message wording

v10:
- Drop the local_irq_save()/local_irq_restore() around the PHC reads.

v9:
- Unshare the skb instead of copying it
- Move the PTP timestamping off the xmit fast path
- Sample the TX and RX PHCs with IRQs disabled to keep the reads adjacent
- Validate the hwtstamp config before touching device state
- Report a -1 PHC index from ethtool for ports without a PHC (VFs)
- Clamp the ptp4l poll timeout in the selftest to a non-negative value

v8:
- Fix the lockless tstamp_config access in netdevsim with
  READ_ONCE()/WRITE_ONCE()
- Clarify the TX/RX timestamp handling in netdevsim comments

v7:
- Moved the test script to tools/testing/selftest/drivers/net
- Optimized implementation to avoid potential edge cases reported

v6:
- Enable PTP Mock in the tools/testing/selftests/net/config

v5:
- Rebase

v4:
- Check if Rx timestamps are enabled before generating a timestamp
- Replace bash selftest script with a python one
- Optimized Tx timestamp generation

v3:
- Fixed shellcheck issues in the selftest/net/ptp.sh
- Added selftest/net/ptp.sh to the selftest/net/Makefile
- Modified ptp_mock to use spin_lock_bh

v2:
- Added selftest/net/ptp.sh
- Modified ptp_mock to use spin_lock_bh
- Populate ethtool defaults using ethtool_op_get_ts_info

Maciek Machnikowski (3):
  ptp_mock: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support
  selftests: drivers/net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c              |  15 +++
 drivers/net/netdevsim/netdev.c               | 118 +++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h            |   1 +
 drivers/ptp/ptp_mock.c                       |  26 ++--
 include/linux/ptp_mock.h                     |   7 ++
 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/config   |   1 +
 tools/testing/selftests/drivers/net/ptp.py   |  97 +++++++++++++++
 8 files changed, 258 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

-- 
2.56.0

