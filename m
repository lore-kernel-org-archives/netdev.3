Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716A25B082
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478794; cv=none; b=TeMweWGA1nlvfXCM/ycITWU30pta7P+gjf/Av4gWNYfW0HGR5VUy+BKK+zRkKc+RC/+MwTvTWLUs7MgLLRzPcQTmXnYEYXwSwBjJpI6heeY+9FpoI2EJmgebAC1PeQAmv5Dc5Zo9Bu1xVz/ede6fHpVPvihrdfQrzKqqayAK8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478794; c=relaxed/simple;
	bh=eQvEJXmxyidqkUrorefZmQU2Mx7cga5tpYkW0XRphsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5nVD0ZXCOsTISgRH9q2IoN+kxzodrvC7OzGKbz3DzjbFVwPGu9lpN8m8hNmvr5dL4ABsAzdmsz1vyAMkWNlt2ZAsm2XAIIlie4nf61sEgD4Ac7b3OzppLAIkvViL30abCmIK3vdgQ/qUTts/bvbyn6XCMQ/2zHEjpjtroUO4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1785478726t3cfcacd9
X-QQ-Originating-IP: MA8tQLvAwp+qkKDMaHdbhIgxHH2YsWVl/ovWb074Dhw=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 14:18:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11634096242998166507
EX-QQ-RecipientCnt: 21
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
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v13 0/5] net: wangxun: timeout and error
Date: Fri, 31 Jul 2026 14:18:32 +0800
Message-Id: <20260731061837.12672-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: Oc8VQYySA48s0xIWMisJBQ606FSPhtWJSifqs4/+bvBjpfQV3JERgPra
	9nZj577G8MRM+JoTwp+lJj9ZdjAlSdbofD7vZcEVzY1IBirMUQHfmSLYMrz/6HW71EaiwHY
	qkiw7m6vU+Ck3zfgHzJdiAubYsYLsl8XJA7uOvy6luEoRYHWTk+gRghndYLMWd9C5xhmDvx
	tfuvw6k9IhAgnAYDPY6J7fanymXS9WHnOyE6925iSCZrhZBsS/0ycFEVwn0pdQXfsjN/nXZ
	lj+7jadB+tzEii9NiByBj38HnFq32zX3uli/Ifgc8f7Wx608xng/4U1Ws/2i5UAAViYdG+l
	yyizzDEmMGbsloN/daUXDrxE8DNdsJ3r/eTc6nGU0OMqDLHWv5hfq49l9Zh0t1RHjlkoSxX
	5nlsp9VplLCw0KIXjMJrTPIXiJY59U+XOz3REvx9Co1PMikFGWipCXsiaqal+M+IRP0SiPT
	QTWekAGFK8HvrHglq4ZP4uMfgOYS06ApMXTvl8H7qETzfxptUPbLUiNy3VcPX4GGhHzhyPB
	xXnPN/0WXQT7qkik7xSrZuCobE2iPqu5xciYmdLut923l0iyBA0EC4DoSj3G6oT2IyspTt1
	qDthffiLMPaRV7QbW/6IvkYUzNoRDoj9qlhVVAJx7WhsEy4ZjGCRZURiElkmSe3JBgi1aoW
	EKuBHNSnCYQ7bGl7hM4nbuU1jM2Bth7t7SvqMQQX6Tnz14k5tC8wCWJ98S9HcAKsDSifqGW
	7EqunIAADiLmObH4SCJ6UM13WhYtVaA4WGLSYryjfISKPT3w8HzvOf6BYxL1Sw/+APGLL1x
	eimAmFrzAKxJwwOKLu2XZzc8X9pvvW8NoibY8quflfbItf8lYp++nGdX5DW1asiV+761HwG
	AoBlYlUNpRIha0wTX2eZQNODHPFmQsmKK7kwQjZMWmETMFivJiO1+PO1OPzrkjLWiZcyTQG
	k3rRWP8l70ppc9+uq94ne3qkReYT5jDq1SioMBmUZ6wI6ZsQX7iHHaDS5tWoWGQ1jCvD2Dv
	UxNFCfqi7DRrPFPFFEwNpMiqlHP9Gq4I2XWAzhP5J+cuY9l2DA59Q5mJHXrkC3w4mDxRHys
	f2BQvw0WduslkBPyJPDf32F2aRmOkHxog==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
v13:
- Double check PCIe error in wx_reset_task().

v12: https://lore.kernel.org/all/20260724101309.23472-1-jiawenwu@trustnetic.com
- Perform device teardown before pci_channel_io_perm_failure return.

v11: https://lore.kernel.org/all/20260716073822.24356-1-jiawenwu@trustnetic.com
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 335 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  59 ++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  27 ++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  25 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  83 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  65 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 620 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0

