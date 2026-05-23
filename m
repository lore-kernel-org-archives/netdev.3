Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0627281E;
	Sat, 23 May 2026 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528593; cv=none; b=fWQzRlaor8ybhBgqnmNxqrGpnDxXxq5fLX0gdSk4dRXQzvSnOqEhFQr29Yf4WB8n7odGDSYryp3JBsRmr2/3FYPa68o1nYMeWHq8tWa6HHsOiiNn84Zp++fAAs7jMF22kgb2gZ/NwuqYT+Nezdwcij9q0hhOiTXM7/eNjOJFrps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528593; c=relaxed/simple;
	bh=IW6R/yqro8ElmofiJfeasd++lmBqdR2DmjN23iqlWy0=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=EVWwRKayz+TRF3WQqVpaTxL0nGDGe7IU28owK8pEKSsXaeS3qkAJUSMVZZxCHtUDhNuFyOWOKjgNaEhUYiwStwnByArRvSV/OERaG6n27k3gJ1KZFeiy23UKeTff1IRFZrz9EIN07qq99vhKUjA9Mn/smNZB2GqNjcStTTvyFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gMxgV2j2Rz8XrrJ;
	Sat, 23 May 2026 17:29:42 +0800 (CST)
Received: from njy2app08.zte.com.cn ([10.40.13.206])
	by mse-fl2.zte.com.cn with SMTP id 64N9TVtP099191;
	Sat, 23 May 2026 17:29:31 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Sat, 23 May 2026 17:29:34 +0800 (CST)
X-Zmail-TransId: 2afb6a11737edc2-d6e81
X-Mailer: Zmail v1.0
Message-ID: <20260523172934240Y6DiW-tAAQJHNvbVct4-M@zte.com.cn>
Date: Sat, 23 May 2026 17:29:34 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY0IDAvMl0gQWRkIFpURSBEaW5nSGFpIEV0aGVybmV0IFBGIGRyaXZlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64N9TVtP099191
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 23 May 2026 17:29:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A117386.000/4gMxgV2j2Rz8XrrJ

From: Junyang Han <han.junyang@zte.com.cn>

This series adds initial support for the ZTE DingHai Ethernet controller,
a high-performance PCIe Ethernet device supporting SR-IOV, hardware
offloading, and advanced virtualization features.

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
  net/ethernet: add ZTE network driver support
  net/ethernet/zte/dinghai: add hardware register access and PCI
    capability scanning

 MAINTAINERS                                 |   6 +
 drivers/net/ethernet/Kconfig                |   1 +
 drivers/net/ethernet/Makefile               |   1 +
 drivers/net/ethernet/zte/Kconfig            |  20 +
 drivers/net/ethernet/zte/Makefile           |   6 +
 drivers/net/ethernet/zte/dinghai/Kconfig    |  34 ++
 drivers/net/ethernet/zte/dinghai/Makefile   |  10 +
 drivers/net/ethernet/zte/dinghai/dh_queue.h |  71 +++
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 631 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    | 132 ++++
 10 files changed, 912 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/Kconfig
 create mode 100644 drivers/net/ethernet/zte/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
 create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/dh_queue.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h

---
A quick note: I've refined my email sending approach after the previous
series encountered some formatting issues. I've now tested the transmission
method and confirmed that the patches maintain proper formatting.
Thanks for your understanding!

-- 
2.27.0
