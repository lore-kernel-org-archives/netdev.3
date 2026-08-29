Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FF374A14
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787994940; cv=none; b=AHnF96OC7Rg9NmowGAztBqp2WjV1ueHHI732Qc3Rr5yV8vzbzE7pNk6J3sijDrRzAqJwunnu45KYvmSdQQt8+oXsUuP1ZHgub2zUXhY+Q9RxRJ6QdeGrwTz3x8IUjbWm7Yxyd8Bv+/vNT4oi5SPGOVzW5aRr7p7W2adS/IZYfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787994940; c=relaxed/simple;
	bh=XzpoOSZbty0jRrVJafLMy92kRi93giPYXUUgkIbm5Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Hs3ClSUdkFcvtEgHMbBHmO3GSaWfNVcwi9oJSh6LbU3uZWFXZ4vw/M4Mj7Una48gnDWUd0bLWf9hsnTPk3BJEXmXv5+tWXs2j3x7TayjD7wwGSZ/qZD2Gq7PtitsxuIRBzDfMdyFdEY9Y18XHDpM2zzyTitL7JbeTCksLrTSDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz4t1787994870t4b1936f4
X-QQ-Originating-IP: KFH0PE+GyrNE6n36WnMfVsC3SZb1PNxOuKeUU/8hA0g=
Received: from localhost.localdomain ( [36.24.99.71])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 29 Aug 2026 17:14:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5247917018781375560
EX-QQ-RecipientCnt: 11
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net v2] net: libwx: fix PM suspend/resume flow for VF drivers
Date: Sat, 29 Aug 2026 17:14:23 +0800
Message-Id: <20260829091423.83097-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: M4KtbCSV5heiO2OEPLZo+ce0W2kpgWzOOnpX6hZRA4TzVgAPTjUoXAJq
	+cc6/twVwCWk97rCWym/QBti79j8aae4Pw1jvz5/L7MbZKTwMWiphnsBXZQmZ4zxS7vHMbo
	PA9ny+VPDdqucKxswb01mj6WjE/oHKKKsoyAVvxMLGZMkamp3E+MorIkH+A/TKC8y+ElRJe
	cah9uQ4UWqQDJgDBe3mfYaK4y1JqFqHT8KpwQIkE5PrR7jKssRw9JkPYw+GnZ7dLG5Rr4JD
	D1wiLRtlfTNYj7Po1JW+Z4nwEyBWEb+1Pk4YfNMlWpNuxCiAMxzv1CgVAdJQxbMwPGjngTH
	In8JZ1vMrak3e8mK+BLLgo7xC/Meq8Wo+gaG8Dk//n/YCI1E+s13+0tvDRgL0CbX425870f
	SaQw6Oou+GITaR2RC003Eb2/YkpMsx1uV2mhb6pMCbGq9lydWP2wxr+39SSursPHm1kaEks
	c3cJmbrgoK16TPnxJeQwTPh1CcA4cB/hmufpY9p7VkpWkBacJeMlcXKkQP+ebnsr0uZD7zM
	KOTtkSX+34rl2G7fKRx5SbLzFPD9mmr5xbQ17ZE333pjx95JTmyMw4Gn6cWIDNdRysHo4BW
	lehEx7ZjCVZ5Gorv5fQjpGCxGUlgi7qgjcYWa8vlsRtiX8dRuomU2NXtVWcUR9lIzA5JEJv
	tx80YrXu+eSlfKBYEIGu3FM4TKNxILYxMptXOGtoM+2SswnZogc8GC/FrPblSFPwbWYrqu1
	izs2fmwscuMJOwJEULiCUT8vADBIn/DbjX66p1xTr+4SVDPGSis1q1h22Neu4dJ/sB5qkL6
	pOeJjZMAdNNQauHW5+fXpRQ0UhLXu7eYmmHzYaUkh1jYv905u4QQtlUwJszot+eIDo5Unnl
	1Xiqh/iG37DiWZpwJIbel7KXcm8DBPcc3ql8m77qp1BNuRJT6fIamsXcHZS85jAMI6U5/WT
	LAYstwn4tuYUy+cCMuB5A+e6Azhad6aRioezRamj0GJWu3rsIGXl4yaNOPwl+oF2LKVfWdp
	5szlmcAbN0kSq5HsXBArIPfWKiSg41ptbhmfH1eCg+9Cp41ZgZNLYltUDVpRvlMnOyKSFUz
	3zr2PYdQUeB
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

In the current wxvf_suspend() and wxvf_resume() implementations, power
management operations lack synchronization with network device
configuration, and proper hardware cleanup/restoration lifecycle
handling is missing.
Specifically:

1. Operations are not guarded by rtnl_lock(), leading to potential race
   conditions with concurrent netdevice callbacks.
2. The suspend path leaves background work and timers running, omits
   disabling TX queues/NAPI instances, and fails to release IRQ and ring
   resources when the interface is up.
3. The resume path does not re-enable the PCI device with MEM access, lacks
   re-allocation and request of MSI-X IRQs/resources, and missing proper
   unroll error handling upon failures.

Fix these issues with the following changes:

- Synchronize both suspend and resume handlers under rtnl_lock().
- In wxvf_suspend(), synchronously cancel background timers/service tasks,
  clear state flags, bring down queues and NAPI, free IRQ/resources if
  running, and clear PCI bus master flag before disabling the device.
- In wxvf_resume(), re-enable the PCI device via pci_enable_device_mem(),
  re-initialize the interrupt scheme, and for running interfaces,
  re-allocate resources, re-request MSI-X IRQs, triggering
  WX_FLAG_NEED_DO_RESET for subsequent HW reset handling, and attach the
  device. Complete error handling paths are added to rollback safely on
  failures.

Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v2:
- Refactored the suspend and resume logic to eliminate full netdevice close/open
  cycles in favor of lightweight interrupt and queue manipulation:
  * In wxvf_suspend(), replaced wxvf_close() with explicit queue stopping
    (netif_tx_disable), carrier drop, NAPI disabling (wx_napi_disable_all), IRQ
    releasing (wx_free_irq), and resource freeing (wx_free_resources).
  * In wxvf_resume(), replaced wxvf_open() with granular resource allocation
    (wx_setup_resources), MSI-X IRQ requesting (wx_request_msix_irqs_vf), and deferred
    hardware reconfiguration via WX_FLAG_NEED_DO_RESET flag.
- Dropped the addition of device_link_add() to parent PF in ngbevf and txgbevf probe()
  paths to keep the patch focused strictly on libwx PM suspend/resume flow.
v1: https://lore.kernel.org/netdev/20260826095243.16939-1-mengyuanlou@net-swift.com/
---
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 62 ++++++++++++++++++-
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..8a212e36c3d8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -15,10 +15,26 @@ int wxvf_suspend(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
 
-	netif_device_detach(wx->netdev);
+	netdev = wx->netdev;
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+	if (netif_running(netdev)) {
+		netif_tx_disable(netdev);
+		netif_carrier_off(netdev);
+		wx_napi_disable_all(wx);
+		wx_free_irq(wx);
+		wx_free_resources(wx);
+	}
 	wx_clear_interrupt_scheme(wx);
+	pci_clear_master(pdev);
 	pci_disable_device(pdev);
+	rtnl_unlock();
 
 	return 0;
 }
@@ -34,12 +50,52 @@ int wxvf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	int err;
+
+	netdev = wx->netdev;
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
 
 	pci_set_master(pdev);
-	wx_init_interrupt_scheme(wx);
-	netif_device_attach(wx->netdev);
+	rtnl_lock();
+
+	err = wx_init_interrupt_scheme(wx);
+	if (err)
+		goto err_pci;
+
+	/* Since vf resume before than pf, only the vf interrupt and software
+	 * resources need to be initialized. The hardware configuration will be
+	 * reconfigured in reset subtask.
+	 */
+	if (netif_running(netdev)) {
+		err = wx_setup_resources(wx);
+		if (err)
+			goto err_clear_int;
+
+		err = wx_request_msix_irqs_vf(wx);
+		if (err)
+			goto err_free_resources;
+
+		wxvf_up_complete(wx);
+		set_bit(WX_FLAG_NEED_DO_RESET, wx->flags);
+	}
+
+	netif_device_attach(netdev);
+	rtnl_unlock();
 
 	return 0;
+err_free_resources:
+	wx_free_resources(wx);
+err_clear_int:
+	wx_clear_interrupt_scheme(wx);
+err_pci:
+	rtnl_unlock();
+	pci_disable_device(pdev);
+	return err;
 }
 EXPORT_SYMBOL(wxvf_resume);
 
-- 
2.30.1

