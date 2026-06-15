Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758634216C
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520585; cv=none; b=D+aUDQqE5SWEEpqgPAcBvVS/n4wTa7E1JWzEsaHLkZenU8JJnqomqbkJLvnWOkW49ObuIXe9neZ++VcE13wPsoMujW2YmcBwoMxjnYNzx7GTszcRWj0I5naK6q6KMLdr+gaRVsp8fCZyA4cYmZrYB1ud8/ih9YZ9tNnivPXtiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520585; c=relaxed/simple;
	bh=xxEr1M+MbPn727hYmofElG9s4cK91diKEcUKZP5wQa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G/vrOPqQk2WQVhHUMCJkEbZxEB6K0icuMIOYd9reh2CFoTOgxq1d1htgxWJ/QF7uS+x2IuGeNO3NMIS+IbLQr1svqXByCo7MBNi7YWj8r4WES8lHuDDKVyEyD68q3FPEO/E7O1fdodCHnMsSEpzQBw6hAVTtvQKV8hQLE78ZU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz19t1781520532tc60b38e4
X-QQ-Originating-IP: JG1aL85oLVtuCvSBM6Zbu2Y40Zp3dT/rXRmMrxF2r5c=
Received: from localhost.localdomain ( [183.157.22.210])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 18:48:51 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15955490062102303072
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 0/3] net: libwx: improve VF ethtool support
Date: Mon, 15 Jun 2026 18:48:46 +0800
Message-Id: <20260615104849.60444-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MIqIAkDP7HbSCN1qUzQP9Hti7etOXPIFlux4nzVIhJFit2nkXbec200u
	aP7VHVRhHbyxPrHy/tgLwO6gfhHbbW4deOHbLmF+pCgUPRJxvX8kyP3EBppIrPDifuahTIn
	vsAmwI0PxgQsA9Z66i7xZ//MxUgU0fd+9+uvaF15Gbiwc7xPG1XsQwpESltzlctVNt+l9/e
	GeIPnqs3hUh+enqm+YkXQx2k28NQ60ovIYllAfm8rZ1HbsRfX3RxZQedKJLvm48xGCa5eJJ
	EJi4IQ3WdT1cRYOZscX7BmYR/QDhOs71HWdj8is2W8YMpFP/sojIic7CytnDuHfZzqHHxYF
	Rk42iiJvLrP52/cp2A4LO4f6Ok9SfNeYCgXD60tU8FdVvuIeqN3/oH4dE818cgfo4z4bNKx
	oY4PjZxYvu56BY0ufWVXaYEraGyGZlJg2QFXT/RmyA2LsBsYXJXUJkU3TjlNzRWCysG2nXa
	vXWO9TgYjOIwxcASfTU3KrFlYylz1YSKD8wVMv3P5WnWz7nLuQgPLf4hL2CESn1R8BXS+Zl
	Cg7q3YESg6k/MjIoCsRxZqkCVWq1qD4w24RoAuQDrmzSFjSwNY/35sZ8H7ouD8BsWwHVeUF
	TxacrJxddwjzmZUQUWcmtxRW7y9Y1KCCQOxFWOx5oSCDLXtxzybLJ6HhuIV3j7aOjFyz5qb
	/dh22KOZFqTXJN4rj4zKLyYy74NpqpzFhcoaAdN7DqoucZES32jF6j4/iaia37mPtEiYAAM
	6QWzObsp/8N97TqMNrrMyHMeCyjxE+p6Fr4oAo8eqMEiEk8/JGqagiVOXxmQXgIDaTSHKzT
	xk06FH1xDnEIRB+/lvoXm1lkzTwhU1A5CKWvQqmA+3Qe2AXlHUmxZ9pEkHzLNsoWIrjOyTV
	JogZaKtINdCTJ3aqXJz7+CcurPHPxYc9JdWR+q1W0X13mfwa1u1ypNcfa8XahEh3ToIe9nT
	wgj0iWb2Bd+p95QfMbO8UoA9HEnsvz3ZbegGEnffE4T62Qxpjxk0xV8kKOU9UktlOozA4ds
	Xv6jG0dYG3rIB3zymG+9t6e082RZZs9g1HQTGXtmXGPUyV8hHc9nLDn/EnuZh89MldDxBR3
	hT5+EZMyLnRdgyLlMnYDKWgDywCETym/UustrNY4wKjd7PaQLP+NLxu1UPBNUslKEk5GKtI
	T8aG87PRV3rS66xkt6Sb4HWYUH4uB7zaE9teYCz+4WhxnDo=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

This series improves ethtool support for Wangxun VF drivers
(ngbevf and txgbevf) in libwx.

This series extends VF support by enabling:
ring parameter configuration via ethtool -G
interrupt coalescing configuration via ethtool -C
per-queue statistics reporting via ethtool -S

Patch 1 adds support for set_ringparam in wx_ethtool_ops_vf,
allowing VF users to adjust TX/RX descriptor ring sizes.
Patch 2 enables set_coalesce support for VF devices and updates
EITR programming to use the VF-specific register access helper.
Patch 3 adds VF statistics support so ethtool -S can
report useful runtime counters for VF interfaces.

Changelog:
v5:
- patch 3:
  Convert WX_NUM_{RX,TX}_QUEUES macros to take explicit netdev parameter
  as suggested by Simon Horman.
v4: https://lore.kernel.org/all/20260608103946.25786-1-mengyuanlou@net-swift.com
  sashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260529075147.88398-1-mengyuanlou%40net-swift.com
- Patch 2:
  PF and VF share the same ITR value range. Update wx_write_eitr_vf() to apply
  identical range clamping as the PF path, ensuring consistent coalesce behavior
  across both device types.
- Patch 3:
  Remove wx_update_stats in wxvf_down.
  Replace both WX_GLOBAL_STATS_LEN and WX_STATS_LEN macros with type-safe
  static helpers wx_global_stats_len() and wx_stats_len().
v3: https://lore.kernel.org/all/20260529075147.88398-1-mengyuanlou@net-swift.com
- Patch 3:
  Drop netdev_stat_ops support from this patch.
v2: https://lore.kernel.org/all/20260525101115.13151-1-mengyuanlou@net-swift.com
- Patch 3:
  Remove some stats which can be replaced by standard stats defined in
  include/net/netdev_queues.h.
- Patch 1:
  Adding a return value to wx_set_ring to make wx_set_ringparam_vf can
  be passed back to userspace.
  Remove freeing and requesting of IRQs. Ring resize only updates descriptor
  resources and does not change MSI-X vector or interrupt configuration,
  so IRQs do not need to be reallocated.
v1: https://lore.kernel.org/all/20260514103405.42175-1-mengyuanlou@net-swift.com

Mengyuan Lou (3):
  net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
  net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
  net: libwx: support vf per-queue statistics via ethtool -S

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 138 +++++++++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   9 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   6 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  13 +-
 7 files changed, 145 insertions(+), 31 deletions(-)

-- 
2.30.1

