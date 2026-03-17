Received: from smtp-usa1.onexmail.com (smtp-usa1.onexmail.com [52.205.10.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA153491C2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.205.10.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733241; cv=none; b=X3xZ1XDK0JzaUHrzrjehZcKKKcCSXPRFKlw7khej9YMPNEwQE1HODQCLp0+akRM2FjwZ+7PxOUnqmtySCzv4HF5ZWuPw64NT6lhQZSuMuHogpd8iHYsFSuBgtPkqVYlz12uKHK5g6DUBRPOLfQCfYASwWlmHQNLbaGO8N9FuNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733241; c=relaxed/simple;
	bh=3nfEkE9GQ6BITi05kTT/bquEgIbBdjP2FhL/8plCF2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mw07IhjJDZBw4DHBM1wqY3SNVmvR5nrYXx0tcxMgS7IpUcIgp6CcaelvFHEhWDzR3Qmuzpy8w+woMnqrhrp9lxE3cSFzNuN/yHVZc8u7GczbiWbxfqkZnU5aD0UM0rsac/xYqkOuPHs6fnaQ1Zn4jpC8IJkWVwk53tj51LOqkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.205.10.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733118t3b005b97
X-QQ-Originating-IP: a8DROfs7UPfM8tBb/q9mTIkBEuO5eR1ShK+Aucg5cSk=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:38:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15952872955884314217
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 00/11] Wangxun improvement and new support
Date: Tue, 17 Mar 2026 15:38:16 +0800
Message-Id: <20260317073827.4300-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OLEpjvZK0eXkwnTri2ybTgZjf27OdPoVAaSn4Ep5VciyTewIquS1JfVg
	OzZ1xTyxHRzNxQ1xznWzIF6nEQCBmW7J3WWLMKNNla5mx4w7ZKW7sKLgD9Oy0fLDZ8MlTnJ
	kDsYiahDuW2RLWU/3f+B1n08fUqtzBA/1fiyBhEbTdq6g4X0xrb9ZTSe9rB0aKcG/XIMiPh
	4ZN5QCv1FPNq6wJPnRe5gDoGXDyeJhEFSJEHduV9tgiYWhe4wNZx8t4nHWA7wEos8Zrg4VD
	NLM5LDYyXGZrkpkHN1iEQK3LXAykyftkblhk5GmeohOv9fgtxXow5Be427P3zv2TgiEwxYH
	12x8W1Ju5EIk24PtNf45iFKgl1uGgEN11YHOXfpAtqPlDADFWcUM7mwou7BeaVkqsL45Pj7
	bMC8SxJbZoMjsj9O2HpFKfboEhRqNmZiVzFsozC/M84Odnc+ABuACtD3lTW0iw4kQ8N7U7k
	xjCW3CUnP3sc3Rdqr2jrzLqE1Uv3jvSXRZCU9AtO+Z+2UhAA3sWnAW9o5ZLulb+yooP31Bb
	bVjXmjHOHp08l7q0t2fjbf44+gY/GlhbVr074fYI5ukogr47blHOjbPJmwgd/67ziZKYKO/
	Wu1ZEySS61OMeVXc359qbmVHVKKraYC8Nutv7CVo7+JWbf/2e6L/DVGz/l3E1jeZuPmIv8m
	Mv01UkkVjEsyM6PGCzVxliASyfVIcJzVwW+nFtTJdVXojMCJZCF/utKQtKxsYSI+UZBZnrM
	C33dA/wtLDgOFuGgN0N1H0L5Resg6/FoJUIxEnz7p+dmkShbziSpm59054ecMG2TKkI8aZ+
	r1i+cCrq+Wirt1hcbjvyw4+henWEvR4Hj0wqtddRxoYDg/0BiFS7jxiHe1ZyYed1+s0Drpj
	znOT9X8Ykc4Ozq/JjSmdM1BTtXJx8bTeSK+c8jJohGYrdTnwnpSi46bsn4dc6kJnc0cL4dj
	0urFVhL/Pn8Bezdxbry9ygVN4Tl8/1sJqlGF+bqoQdS5Bhwx0uXtMQcVSddvC7tBEgFe1Ys
	hOr6ffHii+yIqOGSbjkucx4oPVT8p7UlwBH3C1IMkee7NMc9HwYIgPCN9OSg0UmcxBMuzSZ
	+aob0dg++70
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Implement power management function for txgbe. Clean up the same code in
the two drivers, to make more use of lib functions.

Add Tx timeout process and pci_error_handlers ops, to recover the devices.

v5:
- Add patch 10/11 to handle Tx hang check with pause frame.
- Clear WX_STATE_DISABLED bit in wx_resume().

v4: https://lore.kernel.org/all/20260306063211.20536-1-jiawenwu@trustnetic.com
- Add an initial patch to remove netdev->ethtool->wol_enabled setting.

v3: https://lore.kernel.org/all/20260303030331.24076-1-jiawenwu@trustnetic.com
- Detail the commit log for improving ngbe reset flow.
- Correct the process of stopping the work queue.

v2: https://lore.kernel.org/all/20260227073450.23680-1-jiawenwu@trustnetic.com
- Split NCSI changes from the WOL patch.
- Properly return and handle error codes.
- Fix the typos.
- Remove the check for PCIe errors and subsequent error handling, because
  aer_recover_queue() does not want to be called by the ethernet driver.
  The discussion link:
  https://lore.kernel.org/linux-acpi/001c01dc9740$c7722540$56566fc0$@trustnetic.com/T/

v1: https://lore.kernel.org/all/20260203075759.5852-1-jiawenwu@trustnetic.com

Jiawen Wu (11):
  net: ngbe: remove netdev->ethtool->wol_enabled setting
  net: ngbe: move the WOL functions to libwx
  net: ngbe: remove redundant macros
  net: ngbe: improve the reset flow
  net: wangxun: move reusable PCI driver ops functions into libwx
  net: txgbe: add power management support
  net: wangxun: move ethtool_ops.set_channels into libwx
  net: wangxun: delete service_timer before cancel service_work
  net: wangxun: add Tx timeout process
  net: wangxun: improve flow control setting
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 228 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  39 ++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  56 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 141 ++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  32 ++-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  52 +---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 202 ++++++++--------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  17 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  78 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 16 files changed, 657 insertions(+), 237 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.48.1

