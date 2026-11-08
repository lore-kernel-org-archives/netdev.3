Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794169566;
	b=cxEwuP0VYAAHRFItYZaKc/CP4EgOqXWw969VnsyQkESZGZQ8PCqYt4KlyjZenKhX3XVc
	 kmHrNckX2y8kKtwAOgsyX1LPhCw1TYf4ldv0DLzxuyiSRzVo126EIsSPBa8qiTBQMEnxt
	 P/PKk/eoepClyDYN5H6E83NH+/fbFICuPYZgHSpXdVeViM6fVDy/NAOqVXgNDURQigx8z
	 8W+h/81jXLHF1b9hj7wu8R556dPS0UqWgyl5F/lHTq09kWldbC0knewnyLtjggpDL6IDE
	 KORRRQi99pSjin8tw4jRgmrm8D9ROzghZq7qh8CT6o6IEIiFV2ygV4AlEoZ1rXud84w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169566;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=PbvsLTUx5RTKZcO2SfSuvDv0Qx70PnJIRKcLI1CRGa0=;
	b=2iY3JUfjsjYuXs2XuPu9SW3wzfaMsphSiF8rQg0RwPLSl7iwHwALDxrIyfVI/xswb3/1
	 wNxvnSrGdBN0ArA8Gvd2MLqqVY/RvZtBUQG7H5DGmIaXRing5+5rv8FYuVxZEoaoE/z/4
	 rNqbk+LfKkCYXq6vQnT62bJP+rAMsreoVpDz5irHj8YHtNaW9RZq+mmdZv6AJOUxnlSed
	 6bkB9UoBR0pOkpWD94CWUtNom7x/tHiovg2B6tmDYCf8eKESulyHQS5EbjQIxB3utd7fY
	 g8Uu0vpYqwobNyEcY66lZJmYiLGW+/S4sawLhZ6ASyFBlMOZ1yXrnPcJlYyD/Lqp7WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=FCfFgVaG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BF606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 173BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=FCfFgVaG
ARC-Seal: i=1; a=rsa-sha256; t=1794169548; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A1p003UzVbtvT7FN+mHc3KPzZWyUJp54nQB8ei8a/LFwWGp9iUijp+q+BCvl0i+g6HzV3oYlziH7ykXeLMDieHLUm171Fs9tcQ+TUh4QlTFu0StzikSnlDDzyjFq17b6mYBoQC52+6O56TpQ9K36Zr0b+3vmqMadlJ5InncKz6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794169548; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PbvsLTUx5RTKZcO2SfSuvDv0Qx70PnJIRKcLI1CRGa0=; 
	b=VcOqKvQC5C5ITZXaeqgravMFLcZTwonZQcVc2cWoc4wuo7vi8FJwiDYmKhWuLA328GLPH7RXy2yM2b6Br0aX4h2UcZfX49iAbCZ27UWjpUMaxPAXRhfNKs0u/begO4cU6hH+uJOzYyIlQBZfm3BSc1onKOG0oGyujcTXDymhd0Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=FCfFgVaGXLLOCRMnCjuQsfvN9hcdSUlRNwJueIV30cu45n4TBxPsJ/+q8XDBn7Fa9wK5+ckp/9n3RTge8QN7RXt0ZS5kpx0mhfzxj5tBvnrmGxEWxcEIp7pcgVdEkol/S6KFGuc2FnDAut+dWfDKp2HAGoFXtVG1DpNdORtG/W4IlKQ3qBAJ3wfkYAnZLLdM0WfW/AgRPqzBYe6n4/GIkrLdHJL5uRENKHrvtrPQbRyBH9VT24eijPe/XpGqbYa7OxRyc/a9NfrJnzUpoQCUzTKrqPtT3C9tUhDz7l7ssWA1uWKmxGMtmK2yz3RTIRdcuMCq7nuov9b1nhlMtOz5tA==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=PbvsLTUx5RTKZcO2SfSuvDv0Qx70PnJIRKcLI1CRGa0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794169547263692.6246799169581;
	Sun, 8 Nov 2026 12:25:47 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	almasrymina@google.com
Subject: [PATCH v12 net-next 0/3] Implement PTP support in netdevsim
Date: Sun,  8 Nov 2026 21:15:00 +0100
Message-ID: <20261108201503.85000-1-maciek@machnikowski.net>
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

v12:
- Unclone the skb before writing hwtstamp to not corrupt the TX errqueue clone
- Clear the TX hwtstamp when peer RX timestamping is off
- Set SKBTX_IN_PROGRESS before skb_tx_timestamp() to avoid SW+HW duplicates
- Use skb_unclone() instead of skb_unclone_full()
- Return -EOPNOTSUPP from nsim_get_ts_config() when there is no PHC
- Use isolated ptp4l UDS paths in the selftest
- Explicitly kill the remote ptp4l leader in the selftest
- Tolerate the deferred pkill finding no ptp4l process in the selftest

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
 drivers/net/netdevsim/netdev.c               | 124 +++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h            |   1 +
 drivers/ptp/ptp_mock.c                       |  26 ++--
 include/linux/ptp_mock.h                     |   7 ++
 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/config   |   1 +
 tools/testing/selftests/drivers/net/ptp.py   | 112 +++++++++++++++++
 8 files changed, 279 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

-- 
2.56.0

