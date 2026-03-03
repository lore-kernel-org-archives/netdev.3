Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255C375AD6
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507079; cv=none; b=lUiRFvpV8Pj+Kn0WEAMj40a3DG/yaP/XbbDg+ZUVn65OJ1wEtEvk6C9w8cCzSR4w+lX9aGzMNqdL0O6sn4Ci2zVH3+0YNM9WMqycMwHe6bK4n0qVlLSeskXZI6soo1b8SPahVL1BY87bs9cdW7scSgpil6m6NZkY1rgSN7TS6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507079; c=relaxed/simple;
	bh=1UdOc+nJmmg2v4vSLKsWkrDI6jYvY0YCokDOsPB6KNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MX1tSIrnHWawwr3ESXDIS5TRM7uyjmR4olgvp2CDsN6B+MLsHAiEK3TQ06a8qyVtLnLQsvgMN8D9o8Iihy106DeFc3NMaNYxvPKhUqzPaeDYECxCovB2EPm0RSUU51vWguOKBwh/K1joTedf0hA2PcN8pTaqO0XVufl/CP3KZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507021t1e794326
X-QQ-Originating-IP: y4/z318aLm1zMmk+9esilNd9FVzU3iwtPsTfQxwezLI=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:03:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11278934198843258186
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
Subject: [PATCH net-next v3 0/9] Wangxun improvement and new support
Date: Tue,  3 Mar 2026 11:03:22 +0800
Message-Id: <20260303030331.24076-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MGvbISg46CTeBFkOFt5i2Ry+JbvCp4IMrFMpicXkJYQTlJ2elGy0Hx9d
	R6sKfcEUP1HkhcbOD2RzDULYllTgvDfMVEl2b7dsr9L3odqRdTxZLCSf2zUAKAtHtG0iOpk
	EteMTOzcTZTLvUGZYRvrZgwLHf7y1v0y5VRjOho4TSehHSMn2VBLxZedGmr/gVbqNiyHqDC
	A7vJOmsmqiJXZOxmcfoD+Y7LuIbV3OyHHiLrY8MhVKggT5nYKmPg0ymlovo3EIN1WybvQc7
	ZMj4p6bbLhUMIURcJFomVoMI+pO3g9K5Bzc7K+ZZDIWqFd1eLnOQJOqlA/b+gU6oP2LSfJk
	huveWw4ofIUR4Y63ozh7N/vLXuaSDRnlD7Om8DRgTfCnVDcdCQE3QK91keTKxLYjSmrKFWF
	oHmbfhMxbl9zQqJe6u/2Z6eIGujYtxzOWU8DGgdJjG0mADjIuoTUmyx90q8FueijaBUlYzC
	gZquTYAuOGiqZII4dBkcY2xozdyqkJjwxeYbmmvD/A8xgBki5b26qror9H3epEUhyAPL8ac
	D7vGySzrXvynzHEmf8sDzXEwT750numdAsPQDmbx5kRXY0PbbRwt8OCe0QXUOG2UbRApZaW
	6dG4FK3urp6qzaCxbIlVhPhQDgQTesgeQNqdxeDV4i72elJDgZe+TprrlD3DOCORBidRRfp
	NezVeAJCwmrJxNt3KdoM0Mqldz6nuH+PqGHusCNxWgT74IwOEKlGsTth9nqAZfRkkcAOQVS
	N5kcqp1GxkJ1ZjkLvZtSFR7b/GYtFvIhnDaUL6iT+3Hz4X+piLzaYzNJV9+o4wBkNUE09Xe
	BYcAlUggSUQDPpNVpNwVLyYroE3V0Sd3aqU28Cd/GtxLElTX3UERs8PpMnhLEAlx1Ew4t+D
	yRp3WtkIj6Kw/hWhln2rRI0Xbm0LLFAqPzMMIygpdivJaUF8c5hnE0MX8ZKjBodLm40X6vt
	RikMry+Z2hH6IyLEN3VtPl+spazUf3Y6ub1pv/HfaRf5ZaRydC6gViCSJ7JP/hYnURjs4af
	kK2V5pikbv1tE12GWY2E2Eq7IMY5R141Dc7GRskCeEsnfpgdi1Gpu+DUJrIsYKjQLwI8lf/
	bhb/TDgb6HE
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Implement power management function for txgbe. Clean up the same code in
the two drivers, to make more use of lib functions.

Add Tx timeout process and pci_error_handlers ops, to recover the devices.

v3:
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

Jiawen Wu (9):
  net: ngbe: move the WOL functions to libwx
  net: ngbe: remove redundant macros
  net: ngbe: improve the reset flow
  net: wangxun: move reusable PCI driver ops functions into libwx
  net: txgbe: add power management support
  net: wangxun: move ethtool_ops.set_channels into libwx
  net: wangxun: delete service_timer before cancel service_work
  net: wangxun: add Tx timeout process
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 228 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  38 ++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   4 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 139 ++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  16 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  52 +---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 199 +++++++--------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  17 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  75 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 16 files changed, 590 insertions(+), 227 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.48.1

