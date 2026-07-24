Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C0418A5D
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888048; cv=none; b=dZZKV0mDSA649cTpEsxr1NxGaNAnXgcZqhCdFLCMdy//yLqm4zsiTEs/j53gCFVBhJ1zHVqwz+E7dj2KfYELW2yM7a7zYfkEJptLxt7wVgwOLrRlTEgwn/AVJvHtGCY8f/3OLXWOCYOUdbg5M8n6/VY86ehlwmxq9EW2TgoJP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888048; c=relaxed/simple;
	bh=l2tl3SLBMuO3cpvZOiQ9hfMJTkze7OB07L/ToNN8Q3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y8qUBWCEPr73hKM8WdTHsJhfAIbhezt9B0DXkd3kU5GEOEseJVp7/h3+RIT5kOHnk4gBLCXP2ajkv0U4WSf4qtJeckbr9S0hjNmO5vc7nFPfVM+xX/ft4aoBKAnw7bf9AYE9sbloowqeTsEMp6XrXD+oH23YTzk1RxVGzBKwKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1784887999t299d97e4
X-QQ-Originating-IP: eXcg/R0a+WKtAZPVlQq3f52rSKUWkALF47TagJ72vrg=
Received: from lap-jiawenwu.trustnetic.com ( [115.227.112.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 18:13:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15313744218564480928
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v12 0/5] net: wangxun: timeout and error
Date: Fri, 24 Jul 2026 18:13:04 +0800
Message-Id: <20260724101309.23472-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NImvdRhE6fHp7rtBLLeWI04EX9IDsBd5zl/aLPGQE33kKbiwE4G7S1+c
	GAauMvDpuCXDGlnF9E7/n3tT9iMC+Zwn7Ts4XUSslOnOTv+dQvQJF7VIOnUzjQE2Nsm9NbB
	U6QT/f8YMBNDLxKz3yQRrv71SxnJVwKv2A8EssQuN90qVUal/twK5FZ7+djgfQdSRqvBqKl
	XskFduMhxhnJauk7C+tfMWeaZmu2obChen4VrNbbT+xDSZTGNhkYaf9z1FttLetEGNlhB04
	8/jTS1ayPgAoM552531NNaUCk19qKINu+6sL+H9dgo2/xiYNZbGOY3ypQh9sFvWQGM2b5DE
	RyhGA7QT4cTPyJAK42HQgWdz9P2yyNyp93YIzmcUkqs3flPN6I2FHcrHqMfgbLZmjPsXTIE
	e5wYSPZQb6zA/OIWTbYoNQEz+nPzuiX0uEHCJN6yNqVwzbFqYorMFvX3o2TYTAxaM8dzceH
	X8iyCMNirCww5/SkolqKNG9b8f/JMOdTcEhnDNWiigjs+8JcfaEp728UHObH38ceYHKPIG+
	JminzH4Mwji+sqFDR5vAZLc24hGQBi44q5txHZVTSFTenedMJE44jZPTwXHY1S7zW4HX5dR
	ZhV97HZag/wxGZL4IWymVnnkvyeZsE36yPAkPGeyaIUr33j07acE8CIz5KNXV0Trolu8jgl
	VTez55+XnWrrEiS5w0a58v54hsfS5e4KfdkGrQgyuVQluTNQV6R9wMsxGlW3LDVyJa42qSb
	YneYjxP7zFe1DQStFY0WIvz82Uy8vMQI5CI11LBsugEPyrSxqllWTOeQyz9QiBUu1+8Zmcz
	T1EoqTT+gM/d8j3AAvfSg0ToLHht17I5C3C7PFQ8vumRYrdjg4shzVaPieZj/8bX4M5n97B
	4nTSvx8UxlEdaJbOEsVznZ4b7t56qTm1JWWtQl55TMtWrNtt5BfMxzX9c74xDf+4c2MrLTZ
	EZP33gcquHgTpA8s1BxRMY5UR4f51AS00Doyi+FweZTjoALepMlYtdFH1oE3KpTLoWuF+1I
	t6dN8jIX69rc+CMQUtVVuCOhLcgQBHTSfvGqG4rEBKr/DyzvehDLRvpDi+4VQcWcf+em00t
	ZerOMOpG2tyyQvTsfVtOGHDAhVUCjlLpw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
v12:
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 319 ++++++++++++++++++
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
 15 files changed, 604 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0

