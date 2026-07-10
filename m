Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A134CDD
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648836; cv=none; b=r2noHCK5QbiBJqBN+JtFaabC7XF+3tc77tpUw0wzEF0drYFGrFYbJ9uYkadFx7gGeK9I6pzgN30FJiKOnhvrLzKHKt742jRQVlVhV5ptcF/OT6Kgy/tHke9HqOcj+F+Aji/qDA+DptP3i3l71KprmOAjcFyYjZTw/UP1B8hjdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648836; c=relaxed/simple;
	bh=UZa86QtGUFcj32KOciQANkPv4buxwTnOVELBM0Mfgyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkzTXplLh5AbtWvDofFlsjgCNdgEJoIaMAB05EC7wAFTGEOUo54TD8eImKK8kSonj/CM8/aasY/Vjgwagp1bFepdexO1nQverF0kVH646ZX4En4LMfFcYEN4cE2nLUPLv5dCpX2Q0XbUkXcmR813V10FCGSKCpvzCPjjvI+KKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz14t1783648773t105e8cb5
X-QQ-Originating-IP: dXceXjmy0NGzGUFHs4i33qOsLtnvOIBAi+i8VF6DiM0=
Received: from localhost.localdomain ( [60.188.196.189])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jul 2026 09:59:30 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3318885291999861221
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v7 0/2] net: libwx: improve VF ethtool support
Date: Fri, 10 Jul 2026 09:59:23 +0800
Message-Id: <20260710015925.34769-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: M10PHUHiBhPoPSNuQ0ExhDOCwIiq4srW3tqp8T2b+JdfM3iYv4/rNvKf
	R3I591AJ0nzeqoLdgToyxrH03gTwHvXSLwBcaF1Z5cLV4+D/iPz3gisPt+4+5Bey/x/iatL
	ZcpfzZXMeDplEIs/8Vpc9pgY9jBQ1fa+M9QduK878G2pBB7CEVYUB0hse1BXxzNn3/Rc/WU
	Vi2n/dwMrJDGbxX282k31Pk9WZ3agktc0WJvi56hkQZMg3ACHIrVm6p2L+PglVOZEfzK1FT
	v0xMQZAhuhjAcJcIzEY8kzYfcKAhp3xSa9Mu5zAb22xrXUsHfX3Kgd4S6DdMjog0OEPTIQt
	bB+UTbEZ9mduKNKTykrKHJ5mlhrscHKlQ7/qcwO0Fi4Qw2kUoO81AwlF4j1JWU2o7E1eEaU
	ry4wGoTPJj3kITKDd5W782M7Ik5t34oXWf2ianE7ak5m/m4y3iXjaH/q1tnqdR7ORQCEA2h
	5HS9NmOfOVpvFoXALV/c6jR2sEBU1q+EUAgXfPycgxwD1paXDn2kUYNAnYTklQhsF5/ZCEL
	hqsjldP3owTMfwMKIH3os8qoD/d4SRelV5TVnw30op8NLz7RceFfV4yUK4NpneS1IR+cMwY
	BNdhF+8U220YyA2ML+G613NlZcyvpXpDzVMv9wBQCLApqKOzMUB0U6f11MfFzaTAdqynKUq
	X6CXTTja5x/RHF4vang5CY681e4sDqC64JDCmyUgvU8pJj21OoskRf0OSRVjMuNa0Wk6e5H
	vRQnVC5VSXJfHB0FhyVBEg9+EVbQ5Hcx3y6CP7mAtxLrynn1Rc9MMD7gHUhtFBRdTkBh5Hs
	SsOHHCxVZ9+puRfGdajB+P7Rc6Zho7NCFU9/qLeVlYNt5mKfwCHVQ8Vk/Y8nxz2eKm9Xb6m
	Bu0GLfnnJ6v5kSJZbeArMcKdzQg4s97JxolY5vYk5WXT2/2tTsMcyK4lNmw8miRUQ1h1zkc
	p8xU0SrVpr3KTYn/aMrYEiYXXzFyChIu8XNyYyplcv5xCUBaKiQAz6QdGNHEPcB8/oCGUJ4
	0i+Y4xahp3cHZBHal/sT41QxC88/HTcsKOpFkpNF0EmWdJQHmnl435sVJOMFoYswk2yjyJ7
	M+HvL/w+plwcTCGIGjg79mLXjV3CSlXjBHViZByZSXT
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

This series improves ethtool support for Wangxun VF drivers
(ngbevf and txgbevf) in libwx.

This series extends VF support by enabling:
ring parameter configuration via ethtool -G
interrupt coalescing configuration via ethtool -C

Patch 1 adds support for set_ringparam in wx_ethtool_ops_vf,
allowing VF users to adjust TX/RX descriptor ring sizes.
Patch 2 enables set_coalesce support for VF devices and updates
EITR programming to use the VF-specific register access helper.

Changelog:
v7:
- Remove patch3 and netdev_stat_ops support is deferred to a follow-up patch.
v6: https://lore.kernel.org/all/20260701100145.23738-1-mengyuanlou@net-swift.com/
- Patch 1:
  Clarify comments describing wx_set_ring() failure semantics.
- Patch 2:
  Expand commit message to explain VF ITR encoding changes.
- Patch 3:
  Protect ring accesses in wx_update_stats().
v5: https://lore.kernel.org/all/20260615104849.60444-1-mengyuanlou@net-swift.com
- Patch 3:
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

Mengyuan Lou (2):
  net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
  net: libwx: add support for set_coalesce in wx_ethtool_ops_vf

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 68 ++++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |  1 -
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    | 13 +++-
 7 files changed, 90 insertions(+), 11 deletions(-)

-- 
2.30.1

