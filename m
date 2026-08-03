Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1123BD1B
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739476; cv=none; b=j4zBS7NEnvn2AmlpGuRKkAAoBbr8mXNJi/lhHPLmNN/vHS+7SZ1P66WifIPreEnGDioD0qrHlIzhZiwVLIox6JXg5AW1h6Wve2ZWt+P3p02Q8Y3N/6cICyTtpiIPNWku05dXcK6vuCuZ+1CNB2ceUTpJJ1Ip9sfjS/nm6mZrXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739476; c=relaxed/simple;
	bh=jbkllnn9yRzQcGeWQzUE8S0N33L8sMiHise/wXQjXJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uVzDeH+VDHeV2AMB0TnSJX4XsE/VTcJn2L/xPz1FNPMiFjDCyNzl/4C3/HnR4SkjVuZvWjmI3lzawAXgKwArraATOdaZ526eezEMP82MUzu8BtJsVutpBY4syK5y5h+gZL9iPHZCN6tcF6UIrAKPvTshKUM0GA93fD2TXeSJArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz10t1785739420t255e00ce
X-QQ-Originating-IP: K4OZG8TPTvNG/nx5jsWGnK+8psf2wEGV0ZapM0F4zTI=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 14:43:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14223874660558241921
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
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Joe Damato <joe@dama.to>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v14 0/5] net: wangxun: timeout and error
Date: Mon,  3 Aug 2026 14:43:29 +0800
Message-Id: <20260803064334.21876-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OWISOlifo4HyoZVsC9NqkMBqxaUgS9alAfF4pB/YJMUJom+STyqf+MME
	+eqGq2baJZGBKsDGVGzW1NGieu1Oqgn66PiVy6XqKpyZXUOYfLP9OcC3HSk0xg4RucJiJs4
	sQf5lraWrU9Z3LsydH/b7CGYWeGpxJ2L6+MVpkTLkIe9CfSAbaLvsnSCOhGGYDVdS9FzdgE
	IlIdpnp9DxrVosAkFP+7yiIWIImg27Roz5XLECdaXkeAwI/U2nnl9/Razxq5izzXvF0qgPs
	6u+WuQO5VSdbpkMMq9CjqdAEaky2s/n/d4CZXahO6hvEfoey+7izXlUvMDg5+2FXhASX96X
	5qBph4q4WtJ6CMRtccwCfCSHbpVoS5yLEsZAcG+La7QTyumI8AbmdaNw0m7iPPZBanIop0i
	lJCGzr7eKaey7HddK0s4H2qeRomB1l+0WPC7FlPZF5JfX8FC4SC9xhkCjW9PJLn3ilIV24O
	kz5rB8GaHQLrznS2V/dIBewmw+80Punu9rouLePApV76iH86wXhtjeeImhmwYxdQv0c5XqG
	cMrsKxVsKFkxAmVJhL/W6rFMzP5Oqtd7YMOpuIaH9nmeDKn3raXPYhunrU13ZYtObt8QpC/
	xk8myWZurq1hwjcvx/gvmn2WavdAdOy16ku2q4wqCYQmLpxO4Du/mtU0Cem4TKIz4rV2Z26
	YRwjPa0YMWPbnUTSVVDFcQWOgn6XM4BYHEE8vtnTdi1ax3DP2xM93ms5k4w84K3/T3J1G7k
	VTjIEq3fyfj4dzWvez9Amr4iLys1Y711EF9lprFaMw5fSSrZFXJs3iatsdhM/v2GCm9m463
	h4kPwga/A1Yq2thgZ4WD3KLFUHPMKLqJ3nngSQ1mx1+MKH57qPHgC3exIq8uMqZzn98JxHW
	eqbFaP+l75fuIPxXj9xm8Ata/sRtfPBNGk866jeE9re14BUFoum/JC9mJ9R8Z6RDMkzHfz5
	Qr/5kRpnNz55AEwhe5cou2tJ7V3aoG/5ZcxzQbhV98V/w/fSoix8sfWBXagCRfDUU3YPd/w
	y5rt0QVxpnTAlQpVggORJzwUCxRvPMIC0LFob5x8pGL+iRS2qy0crYDRIYlR0QL8pksvOV2
	v03bZ8ltRZSsitaxMDyJZWlGmVNzyMZg78xr/0SRekq
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
v14:
- Remove flag WX_FLAG_NEED_PF_RESET and reuse WX_FLAG_NEED_DO_RESET for it.
- Remove redundant 'watchdog_timeo = 5 * HZ'.
- Not clear flags when device has been detached in wx_reset_task().

v13: https://lore.kernel.org/all/20260731061837.12672-1-jiawenwu@trustnetic.com
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 332 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  59 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  27 ++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  24 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  82 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  64 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 614 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


