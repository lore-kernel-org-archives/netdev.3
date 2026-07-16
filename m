Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107243BC696
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187576; cv=none; b=lUaEK8GW2wlsGvKGtQp8P/1X00SwOIKkkqfGMHQhGLULy7VyA3AK+RPcKRsb2ujNkMYfkx4Ek6E59eKUeqtltrW8ngauBjSTA6332GKh8FjlW13ORHdwwZyE/XWhFsIornF8ttaBxOLODGoYNj3j3r9nFhxFmHteS6DqJYDCEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187576; c=relaxed/simple;
	bh=8aVy81ALtv/YlqO6zl4luGwQvt2xVpc+MA4+oXwyju8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eH0DC5ifTuG+/rQDjBWhg+X2g/MTBHFBFgBpVu2q8xCv2MhV9IbjtxQks/K06jBngEMDgFOZr7Gk1wZOGlIvcjBedxe/c7rqAolHPIVOFMUbL6i9kVvMYHB562Pa/CyIOsG18hzpQ5nFCAHz5UyzOPWZVzx5m6yr8daXzq/vxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1784187511t3610c38b
X-QQ-Originating-IP: DyQf1zyS+eZtY16omGUwp1ShfE+MyS8Yj3PVTH0q1vY=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 15:38:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12526176476337550231
EX-QQ-RecipientCnt: 20
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v11 0/5] net: wangxun: timeout and error
Date: Thu, 16 Jul 2026 15:38:17 +0800
Message-Id: <20260716073822.24356-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OO2wLqYBHUeBMGb3jS5TSIxmHWqEV69PxBkMOiBjXJFfsDQp82ORMu3k
	U1+89423v7MptbntegWH2+LA4a+v9mYxjeDFVk3MfolrNk8lWw1lx979bVe4MqCgrlhcshK
	je9sFtRF9Dspt77NIBBgDhjTSJsEVbssThIuXtouCJJcGkoMxC7v42sZrGbU7AZZF42I8Tf
	lXNVJfthL6YFP6Yzx6bMcCJ7xzqV+1fs6EmnpNDWdXLQtLAfhLZJsWxK2l74TRVkY8TIz9v
	fs+7i/a3qbsJVEjUVztyEaZ4V++73f1UMV4ReR8AJx929YlBnoMpEU1N7N73AgpoZ1peaKX
	VpG8HmExvIOvz7iOCGU3P3Dx9EF5IboBQ5SaQ/9GginSBRPAuddUp5v8kFWhsrKs2eAKboE
	+dRD5tYm4M5MfYr8SmkZ+77sReJBPWEnRpVXAwJdwfY42QnqkavokMUrOOmaPn8uSyCU0PF
	FWZo7dBqizCaVlx3sQWANmYN+pFEMkmxJyiCzopul/2cRFN283XuhDdvUzYpaFs2/Iqedny
	rNzNZlDnl4oE79I/yggSCZaocgwEPcUz8S6GYLYF0Lu/a+41WJVYwKjc0Y1+O5dg5Izs51U
	zGEaVQcQZVj2bfDAxopZWEYdnchH/xvXOHyIr7wXCDo2/SQUyGWY70GDrE/HtJ6om4NkzFE
	OwTbSndDwDWQqQLNGqOtfRZ46ZGcnDHOuKx9kLfLgE92XU7olsabi6pcm5QBuBX2Wp1KPca
	xokFipt2hwYHprjYTW/Nwn7QR8RpXs6aKAwHbE/lYwnRj/ZLgx0evOHYqxXm+wqtXKG2Po5
	6acBe+7usw0hBOPus09o6gdxjYvnWymU97fAsq9MiGyrJ8NO/oX40tkwZdngtbzrx8dXVHX
	Fmm7YEWOz2F4tO7Xs47zBuzRoit4ZYXx+tG/7+ZtVlZ5PVmrbBK21fIPCcJC5eOPEv7Wn0c
	Blc9Y0z3zBYW8ThxrHRvREVaagx7cxlZ2PyP8qYKsdOHFPpvTDFGuihd9wMKktIaPMWTnpR
	kaKg1wSDeYg0oj4WdoVumC4XoAE8ny5OU4TepA8Zj6ZaBJ2JB58bAotrXk2hRWBBhjcx9T9
	ekGyzjCCDkRAa6aIVZLWh3DTxxuzje3IA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

It is about adding the Tx timeout process and pci_error_handlers.
When a PCIe error occurs, the txgbe device is able to recover on platform
that support AER interrupt. And for Tx timeout, the txgbe driver can
recover the device by reset process.

For ngbe devices, due to the absence of the current function, it cannot
br fully recovered once there is a PCIe error or Tx timeout. Its
function will be completed in the future.

---
Changes log:
v11:
- Destroy ptp_clock in wx_ptp_quiesce().
- Re-check down/resetting state flag after time sleep in module
  detection subtask.

v10: https://lore.kernel.org/all/20260707061455.39564-1-jiawenwu@trustnetic.com
- Remove pci_aer_clear_nonfatal_status().

v9: https://lore.kernel.org/all/20260701072357.33984-1-jiawenwu@trustnetic.com
- Add calling ptp_cancel_worker_sync() in wx_ptp_quiesce().
- Fix the typo of 'out' for wx_control_hw().

v8: https://lore.kernel.org/all/20260630031016.19820-1-jiawenwu@trustnetic.com
- Not destroying PTP clock in wx_soft_quiesce(), and keeping the PTP worker
  alive but idle during PCIe recovery.
- Move wx_soft_quiesce() after wx_napi_disable_all().
- Use PCI_COMMAND_MEMORY and U16_MAX instead of magic number.
- Fix the leak of wx_control_hw() when WX_STATE_RES_FREED is set.

v7: https://lore.kernel.org/all/20260615065016.21672-1-jiawenwu@trustnetic.com
- Move ptp_clock_unregister() to be executed before free wx->ptp_tx_skb.

v6: https://lore.kernel.org/all/20260610060917.23980-1-jiawenwu@trustnetic.com
- Move the check of device status inside wx_soft_quiesce().
- Reverse the error return of txgbe_disable_device().
- Add PCIe error check in tx_timeout.
- Add WX_STATE_RES_FREED flag to avoid double-free of resources.

v5: https://lore.kernel.org/all/20260604085631.12720-1-jiawenwu@trustnetic.com
- Avoid the same name on two functions.
- Encode the device identity into the name of reset work queue.
- Change pr_err() to wx_err().
- Check WX_STATE_DOWN and WX_STATE_RESETTING at the entry of every work item.
- Implement wx_ptp_quiesce().
- Add netif_carrier_off() and netif_tx_disable() in soft_quiesce.
- Move resource free operations after PCIe recovery.
- Return error code in down path.

v4: https://lore.kernel.org/all/20260601072221.2952-1-jiawenwu@trustnetic.com
- Create a separate work queue for the reset task.
- Gate wx_watchdog_flush_tx() on netif_running().
- Add rtnl_lock() around wx->do_reset() in wx_io_slot_reset().
- Change .close_suspend() to .soft_quiesce() to avoid MMIO when PCI
  channel is frozen.

v3: https://lore.kernel.org/all/20260509100540.32612-1-jiawenwu@trustnetic.com
- Merge the multiple string line into one in wx_handle_tx_hang().
- Remove the redundant warn messages.
- Use test_and_clear_bit() instead of checking the flag bit then clear it.
- Drop the Tx hang check in tx_timeout.
- Call wx_update_stats() before wx_check_tx_hang().
- Add Tx flush when link lost.
- Move wx_ptp_stop() into wx->close_suspend().
- Drop V2 patch 5/6 because WOL packets are handled before DMA ring.
- Check wx NULL pointer in wx_io_error_detected().
- Check perm failure before hardware teardown.

v2: https://lore.kernel.org/all/20260430082517.19612-1-jiawenwu@trustnetic.com
- Add the missing rtnl_unlock() at early return in wx_reset_subtask().
- Replace ngbe_close() with ngbe_close_suspend() in ngbe_dev_shutdown().
- Add a patch to clear stored DMA addresses.
 
v1: https://lore.kernel.org/r/20260428021156.13564-1-jiawenwu@trustnetic.com
---

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: implement soft quiesce for PCIe error recovery
  net: wangxun: add pcie error handler

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 317 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  59 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  27 ++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  25 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  83 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  65 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 602 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0

