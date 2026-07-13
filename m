Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7613DBA0;
	Mon, 13 Jul 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952490; cv=none; b=JW73NkWVklGIivVCzl2r68IKR3MnNBogjuoZWBxz3+PPuAJoVgejKb6uA66azgptBORR53zjvCV31agPf5McFk/EEhaqLQzQqr0jGsGoTHNqkXcfEcUn/dHLXE+k4WrTny1BoftSrdZFVxJzge5HjiYwOOmI/GSKfi7mlxaReNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952490; c=relaxed/simple;
	bh=oM5IM+8fk/6vWugC4QHBgIzsTq6MoclQtVAXmKy9Jqs=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=WPdSkBiZUfB3ZwxmYiE9vDyBYJE5io6sN92utiC8A6c6XS6RhJq4FStZ7JnmuWIUk7/XA+hm9d+huf/JzKMHbNbbUW4PF84EKS2Ruz4e4c6vS7VIcMYULwfIw3NKOt+FvHvjlDq369fkVmxxnttjLaFP5Z4/sugdEg75kGxlReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gzPkM6KC6z5B13W;
	Mon, 13 Jul 2026 22:21:15 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl1.zte.com.cn with SMTP id 66DEL6UW074772;
	Mon, 13 Jul 2026 22:21:07 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app08[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 13 Jul 2026 22:21:10 +0800 (CST)
X-Zmail-TransId: 2b006a54f456cca-cd261
X-Mailer: Zmail v1.0
Message-ID: <202607132221104795CMBHxJGy8iTj3qc36Qw6@zte.com.cn>
Date: Mon, 13 Jul 2026 22:21:10 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY4IDAvMl0gQWRkIFpURSBEaW5nSGFpIEV0aGVybmV0IFBGIGRyaXZlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66DEL6UW074772
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 13 Jul 2026 22:21:15 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A54F45B.001/4gzPkM6KC6z5B13W

From: Junyang Han <han.junyang@zte.com.cn>

This series adds initial support for the ZTE DingHai Ethernet controller,
a high-performance PCIe Ethernet device supporting SR-IOV, hardware
offloading, and advanced virtualization features.

Changes from v7:
- Remove the redundant depends on NET_VENDOR_ZTE
  since it's already implied by the enclosing if NET_VENDOR_ZTE 
  block in the parent Kconfig.
- Check BAR 0 is an IORESOURCE_MEM resource before ioremap().
- Rework .shutdown to quiesce hardware only. 
- Add NULL guards in zxdh_set_mac() and zxdh_get_mac().
- Zero the output buffer in zxdh_pf_get_vf_mac() up front.

- Two further AI-review points were investigated and require no
  code change:

  (1) *len is written before the bounds check inside
      zxdh_pf_map_capability. The two fields written through
      *len and *bar_off are pf_dev->notify_len and
      pf_dev->dev_cfg_bar_off, both populated from this
      function. pf_dev->notify_len is only consulted when
      pf_dev->notify_base != NULL, which only happens when
      the corresponding map_capability() call returned a
      non-NULL pointer; pf_dev->dev_cfg_bar_off is only
      consumed by zxdh_pf_get_vf_mac and
      zxdh_pf_set_vf_mac_reg, both of which gate their
      access on pf_dev->pf_sriov_cap_base. So the early
      *len / *bar_off writes cannot produce values that
      end up consumed.

  (2) The expression off * notify_offset_multiplier is
      u16 * u32; the overflow only triggers when
      notify_offset_multiplier exceeds UINT_MAX / 65535
      (≈ 65537), which is well beyond any value a PCI
      config register would carry for this field. A
      malformed multiplier of that magnitude would also
      fail sane probing of the rest of the cap layout, so
      it cannot reach this arithmetic. The boundaries in
      practice are enforced by the 64-bit comparison at
      the top of zxdh_pf_map_vq_notify's notify_base
      branch, where off is promoted to u64 before the
      multiply. The three subsequent 32-bit multiplies in
      that function only feed pointer arithmetic against
      pf_dev->notify_base; a wrong offset would resolve
      to an address outside the mapped region and fail on
      access rather than corrupt kernel state.


Changes from v6:
- Clean up PCI device ID table (drop `, 0`, use `{ }` sentinel)
- Move dh_core_alloc_priv/dh_core_free_priv from header to .c,
  they don't need to be `static inline`
- Use `if (!x)` and drop the "%i, x" dev_err() messages in
  common/notify cfg init.

Changes from v5:
- Drop dev_info() log spam.
- Propagate the real error code from dh_pf_pci_init() in
  dh_pf_probe() instead of hard-coding -ENOMEM.
- Register devlink only after dh_pf_pci_init() succeeds, and
  in dh_pf_remove()/dh_pf_shutdown() unregister devlink
  before tearing down PCI/mutex/priv.
- Drop the "dh_dev->priv = NULL" assignment from
  dh_core_free_priv().

Changes from v4:
- Fix sparse warning: add __iomem annotation to priv pointer
- Fix Clang format warning
- Use "dinghai:" as patch subject prefix
- Ensure proper patch threading

Note: Sent manually due to temporary git send-email unavailability
in our environment. Will use git send-email or b4 for future
submissions. Apologies for any inconvenience.

Changes from v3:
- Merged patches 1 and 2: 
  Combined initial framework with logging infrastructure
  for better code organization and reduced patch count. This was done because
  the logging infrastructure now uses Linux's built-in dev_err(), dev_info(),
  dev_warn(), etc. macros instead of a custom logging system.
- Removed unnecessary variable initialization: 
  Fixed "don't initialise variables".
- Fixed variable declaration order: 
  Applied "Reverse Christmas tree" ordering with variables
  declared from longest to shortest line length.
- Code quality improvements:
  Fixed all checkpatch.pl issues (alignment, formatting, etc.).

Changes from v2:
- Address maintainer feedback from v2 review:
  * Remove meaningless initialization
  * Change dh_pf_pci_table to static const for better encapsulation
  * Simplify MODULE_DESCRIPTION for brevity
- Coding style improvements:
  * Ensure all lines are within 80-column limit
  * Use kernel types (u32/u8) consistently throughout
  * Improve code readability with better formatting


Changes from v1 (addressing feedback from AndrewLunn):
- Update copyright years to 2022-2026
- Remove DRV_VERSION, MODULE_VERSION and related boilerplate
- Fix MODULE_AUTHOR to use person with email address
- Use module_pci_driver() instead of manual init/exit
- Remove empty suspend/resume callbacks
- Replace char priv[] flexible array with void *priv + kzalloc
- Switch logging from printk wrappers to dev_*() based macros
- Remove dh_helper.h and dh_log.c, simplify to dh_log.h only
- Fix variable declaration ordering (reverse Christmas tree)
- Remove unnecessary NULL check in remove and pf_dev=NULL in probe
- Fix indentation and remove unnecessary type casts
- Use kernel idiomatic "if (ret)" style

This is the initial submission and only includes the PF (Physical Function)
driver. The VF (Virtual Function) driver will be submitted separately.

Junyang Han (2):
  dinghai: add ZTE network driver support
  dinghai: add hardware register access and PCI capability scanning

 MAINTAINERS                                 |   6 +
 drivers/net/ethernet/Kconfig                |   1 +
 drivers/net/ethernet/Makefile               |   1 +
 drivers/net/ethernet/zte/Kconfig            |  20 +
 drivers/net/ethernet/zte/Makefile           |   6 +
 drivers/net/ethernet/zte/dinghai/Kconfig    |  34 ++
 drivers/net/ethernet/zte/dinghai/Makefile   |  10 +
 drivers/net/ethernet/zte/dinghai/dh_queue.h |  71 +++
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 642 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    | 118 ++++
 10 files changed, 909 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/Kconfig
 create mode 100644 drivers/net/ethernet/zte/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
 create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/dh_queue.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h

-- 
2.27.0
