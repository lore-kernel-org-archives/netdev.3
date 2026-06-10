Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B12C0296
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071960; cv=none; b=jn1bXOgDpmjd5wOHpzGzta1OkueiRzDHR/OD8bulFtojKjNe309LxFqSydpZ9y6N2yUNBf7MhGuZ5BP95DoIpSPbgSIHXzJ/FFifVjI5O1llEztUvc+78SKZ9JKHkuRTiuQT96YS4ZIcBJhgrcg5Ggj5fxT9Q4OGV8WetcLtIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071960; c=relaxed/simple;
	bh=t41QsdGiylMsunZD9ScaHRKPeLfM4sCDMMXG9CVIobI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jNhOMxNrpZcskLLB86fSovEHik/GSdCwkWbqRMTB1oNXNBKBk19/fAadYBIBEvoop6wJhSKiwUher6Pw8yMRi/fjgmn2WesfU/DIZiXdN+fnUq6oTJt45CPjTUHo26sLe7MAjKKlczJ1exHylPA+K0Sbs53Samp9zAumh5oLoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1781071899ted1d8356
X-QQ-Originating-IP: bdbl7D6dbbC8CZth+ol5xKw2Bk1gcU4uk7zlFYcGNEE=
Received: from lap-jiawenwu.trustnetic.com ( [125.118.31.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 14:11:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16884222364843898554
EX-QQ-RecipientCnt: 22
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 0/5] net: wangxun: timeout and error
Date: Wed, 10 Jun 2026 14:09:12 +0800
Message-Id: <20260610060917.23980-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OKhYnE1LzMsBpM0YhE8PYjF5yxtvwhMrwZqldVk5mpeLyoAZ0ZKS851w
	2vSfSPnkph2XHSnLrseDr3zANqs2yRpDQGcu65wsbB5VehAYeYjOqW1V2+gcYmRZtTho8rY
	NFRdNAntBKviiNGRB/T7Zp7DfOjYiHmfa4FKdI73EJHp5FgWeYPEAl7rMpcDVeyWgwmk1ZC
	bAwrtjBsgSxN+NEb3uoBkhD2GG80yzFQXl9UicgmO0Dk/iEyx3gslUpD/v0RrZfm38FnKJw
	B/rS3G2ymo2107w3zRYXCLOc0KJIH9tsMI5Nm9KzukdR86mRGu8pYVzTmbckVBrre8hVgKR
	G0/jX9ImKq/jmJZ0Wr0xT0V9C6ymGwLT7ODKyFYUXNsEIzk/W4ESnIOSTWp2m8q7kWW451K
	7oazN3cvcJyXVOkRT5SUGnTtSvJEoOURASz9xjKkZSEuiNy/ajpzS4EF+p7N2BcUgiGALva
	tkOiQxVPdOhoaiat2uEekUJnVVYvHAtpjmZ+eAEpEKuiTdu9esFTuXJ7g7C4IRRJZM5iFeB
	gKDwqp0Ot/A4zyNU3j/ARCR8Czu5NgCDKDPBf9ZWOnTDlNIm41fMZn4LS7MCoxdAUzMd1SE
	enStcQ3FHdKkwtAZrf0CLrvPd/AIUskNxdzw3lNRRHCQvB2svixaDLtDBt+byToY93s3V3T
	d1XJqEBLeBuWXnX1JLM14gtRijLkyRS3Pm+F7NZpVEjwpSiRimwQ19a4xbiaKOZO6xQEpsf
	TCmMWhMAv/3HXxG81JiYcie2rxnqw7MFORCgtzWUSZTBbV+PevbI5g05YFJFB+P1SsBwPWG
	eytwmU5UJLCBWjiM7NJzJw9Sa18Qkq6L1RFFtV7XXguBwjXyKrXWAumA9pHSsx7VCqWlJck
	bRUsj302cYQkuYE95e7JtobdPpcmjXdgjL+IaE5dGP4Cfa6Ef6nz/B4emmq14/gBXMuoD89
	wi9I4hO/wUMDysKspMhFNzdWdjoHyYAGhsZ7nPILFfTOXdAeuj9LIX2Wxa3lz3TUgGLk9ah
	iO2+KdqJFm/5DAEfys4MdQ1h7Nu6x/DX0BSWXMwAZZ6Uqt1imkkQEl/7lbPnifX65OIsr6s
	6LB3fLtWIH4ZeAh8y5foR4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

It is about adding the Tx timeout process and pci_error_handlers.
When a PCIe error occurs, the txgbe device is able to recover on platform
that support AER interrupt. And for Tx timeout, the txgbe driver can
recover the device by reset process.

For ngbe devices, due to the absence of the current function, it cannot
br fully recovered once there is a PCIe error or Tx timeout. Its
function will be completed in the future.

Changes log:
v6:
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

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: implement soft quiesce for PCIe error recovery
  net: wangxun: add pcie error handler

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 321 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  59 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  21 ++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  25 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  84 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  56 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 592 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0

