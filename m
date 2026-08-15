Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CD37F737
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775528; cv=pass; b=ueygqnA+Qs9K8+8ZRCEEGP+74epcyJ1ZNhqpK/cmBmmL0BqCzQcsHd7C8jxPl1b8QmPS3sGwdox61z7tu0jQpo/VFtISg+GJ6A7d/OLmlFaQY2gwPdqEpn4mAN0sw9f3ctWL14oJD5lDsKormWZDom2ZsdjLu78ANV9OOvoHhkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775528; c=relaxed/simple;
	bh=TE/N6rHSkxPNEhcY19wCoeaqnSNiDhbj0nTVCqykoWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlxzJ0BwviyjZHQ4wC68RTJVDiThY/F8DrBsmnBNnhGaZvXJpUe0FJQMpUY5psZCKujzn/Bted6r2ruSHeDQtrO/AkBF18JlLhzmRxM0AAv6MnKtyJqlKgJXsigwYZR7DfAEPVXmOEmSo+p4I/WGjC4/Gww2k1/y0uiZfXcrYPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=PuuPasgZ; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="PuuPasgZ"
ARC-Seal: i=1; a=rsa-sha256; t=1786775514; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TCQCnaM477ANyRGaP9RMsZdi5spikUB61CSaQ4MTAcXlBJHozKOc9+Iczl4q2wuuMIkgCzdQrTThxpiFpN6Ud/+ayxYSxKvAyJWOzc7lKP6PhQ1prHqh8rQgfQTPk52L1yQ2ZO/qoYifff9Edmg18KY3+SIoRCWiRB2tXKM7l+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786775514; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OMSROwWdNvjpLayLYD5dyAlB5wZ0AnTBTj8Uagsr+QU=; 
	b=Sj1aXmwXjpECySl5Rv8gVPs+ImPi0afeYp3f0b7f2jRVYMwO5hyI0ZEtwIq2Jyb+Z+Lv7RWG/W8GGpKyh1f+N+IvXVyvkcAFwr0JXghzUnPwiSaWEjO+ONYiIuL3vx+KjFsPNrI910ue1f99R093QR95SKAdhA6uyJEjObgxgrA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786775514;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OMSROwWdNvjpLayLYD5dyAlB5wZ0AnTBTj8Uagsr+QU=;
	b=PuuPasgZZqTFqu3uwhQgRvuEbACFD/TnwTPVyXGSkLZ7OXfZr4E1M+tJv07DmfQ/
	XekCv19G2AxeV5sXna8HEsggkfPvfq8MZmUNMQEzYyLLql/nxkpOo5zmG6dK6CZNGEm
	sth5Bzj5xqMy3DtOfSzR3HkLbdFMbg5vDm4MVMl8mAU2ROHyqnXHN+5IudxJar6JUnl
	7uIBe5oWopX67yfS5AIitUelG/aaSBT7MCryB/2sIioyd7JXkztkuQWdzdSkRNXndLd
	lJg5a/2DAbrJYoegM/9z6+jc/uh88FOT66bnRLnu7UTNmWxm9GVKsytFH3lx4boyDPf
	2RlVOAmQug==
Received: by mx.zohomail.com with SMTPS id 1786775512356944.5447179774208;
	Fri, 14 Aug 2026 23:31:52 -0700 (PDT)
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
Subject: [PATCH v10 net-next 0/3] Implement PTP support in netdevsim
Date: Sat, 15 Aug 2026 08:31:45 +0200
Message-ID: <20260815063148.2952-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.

It also adds the selftest to verify the hw timestamping functionality
running over netdevsim.

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
- Modified ptp_mock to use spin_lock_irqsave

v2:
- Added selftest/net/ptp.sh
- Modified ptp_mock to use spin_lock_bh
- Populate ethtool defaults using ethtool_op_get_ts_info

Maciek Machnikowski (3):
  ptp_mock: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support
  selftests: drivers/net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c              |  15 +++
 drivers/net/netdevsim/netdev.c               | 104 +++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h            |   1 +
 drivers/ptp/ptp_mock.c                       |  26 +++--
 include/linux/ptp_mock.h                     |   5 +
 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/config   |   1 +
 tools/testing/selftests/drivers/net/ptp.py   |  84 +++++++++++++++
 8 files changed, 229 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

--
2.55.0

