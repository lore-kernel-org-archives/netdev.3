Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9803CCFB8
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512027; cv=none; b=AHVXrIlyC6weoJJpgJpnQ3GGwAqAIe3gJuFx0tXIF+n+h1SlXWSnAgKgdh+6EABF1mKj48L0Jm++sCAWZoriBv5h5dlrwW459ZYK0+m+cHRWlkXmUVWCHXMFS5b+gEJz32egnH+FBY0CahV3Dom47u299sBi21Lf1n4alJQmK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512027; c=relaxed/simple;
	bh=q6gs+4p5OOEL1aHTcmS1UAG2nLh2IuldBSGfVk8HslY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D+eIPdDIsUbXl9V3xaqnkN9pP2HJk+Uvs9LxmaYmJPdRrI2bYHptfnx2U3CJMadVdONq6vK9ioiGb1xNe0/SfeWFgr1UQBXeFq8JqM4mCALEFIGLGbpYiT49LnC6tNdOUn++B9n99nxfKjWdAXRwn7FqGJ2+uZ45mjtQfcvAj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz10t1788511941tfddf8cff
X-QQ-Originating-IP: PXztDdzEbgeJGKRuQUveenhDIQ0lpJvYHDAkLD1dHZE=
Received: from localhost.localdomain ( [36.24.189.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Sep 2026 16:52:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4855568335180887314
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
Subject: [PATCH net v3] net: libwx: fix PM suspend/resume flow for VF drivers
Date: Fri,  4 Sep 2026 16:52:16 +0800
Message-Id: <20260904085216.43469-1-mengyuanlou@net-swift.com>
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
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NbvVYYrLqtwLcnJUd3u0Vepff1JhOT/hAjeQHGmfb8eZlAZsDew/oOeR
	79m8em+vcDsHUQRpe6Goq60JaJuW9jWL9/phRG4kfK3iw1qoB9s5y7reRK6ktOxk4Zmv5Hl
	QOGuhCdVDmPPENbkY4sgmEr6/3tmiDZq5aFlRI+y+0LGWCZosXo2a98ulsJFjZ8+ezZIVrO
	c2qFq2abmwfuEv9vj5u5Y7oTTBKZyJ1zGfyNIFi7RdwNiXN4t4E79Bu0guXTBWWO28WQmUO
	oaMiFGfAEf33XqUnbL0ywRG+Q/YMpWAuGHVMT0pbk3WUuHP+rP8RSuj8XyjGWj86qAo3Nr/
	YAypV4fIifqnsu5aBVeWNZFDZdvt8oHajo/4geBqJSoFPM85dOfKqNGPuwF0Czeeh/1UUOd
	AV2LFM8O1w4YBk7TgKz2zqVYJw26sB4lkzLZFzWy/gllG8EIQrf+E1vGEP+30ims8/yJ0m7
	Ki5u0+Jo0mGhZhhhJT9XHybtVRIIZRMgyVVzKBNfUwbWCiEwHFyU70G6ZQ2vuc0Es0qvKHg
	jlCESiQPkqJlr1LSp/ViFzgP5Q4sDl68P6C06AR5kRt4+J8x6NHfkpSnp5jX7OvJbtG6Jmu
	svbO1b/Is44LD36ZR6aDqK71oNtUX1UaYqD89Z4TF4Os3uysY+gadmzUNQUzflSngiZBj8U
	GmvUU0IMQc8nkaytLdc+vqhmxmT+3njYXBMfoNVX/xC8ZdFNwzstUoGNJ3Lkk0b8oBqse2R
	QiMNy66X6FlrJygTSZOSRTKMFOJ8ji5FZggAGJ0pEDhTkqbuWZE8+yJzqR4RJbrzU+ecJYJ
	Kkb7JMfMa9AS5Xoadc4phiuBbOrCjJH1IYQJOEiP2rHsCh26MHwkfqUiTkVIx0VTyJsKfbL
	+xs6X1gV21gjdL3XyrOcHhbjFqEQGHoWiZv6b3VzZnCTARRco0t8ML6BK+G5bgzLfGlv9q1
	Pew/Y9Mt8TuFIiGtypZrWDtm2DFMhm1GdxhNvXCVLLTT++jQKK3l9SLqHRQcXw71DxD2izx
	tWitZkllLyEmjOWtljVSJTVXqyrP3EuwEfw9GVlVcv6dD5tlMgKuY36UiQCU1Uw0ZdKaQoE
	5sGpHEjcyGkhgu/e4cyNtVgK4DKEOZ8hCuE2eMhvD0h
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Rework wxvf_suspend() and wxvf_resume() to handle interface lifecycle
transitions safely under rtnl_lock() and eliminate resource races.

In wxvf_suspend(), if the netdevice is running, invoke wxvf_close() to
quiesce DMA engines, disable NAPI, and release IRQs/rings cleanly prior
to clearing PCI bus mastering and disabling the device.

In wxvf_resume(), avoid partial hardware re-initialization on active
queues. If the device was running before suspend, defer complete queue
and interrupt setup to a new reset subtask flag WX_FLAG_NEED_REOPEN,
which safely invokes wxvf_open() under rtnl_lock(). Provide error
unwinding inside wxvf_reopen_subtask() if re-opening fails.

Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v3:
- Fix DMA-after-free and UAF races in wxvf_suspend() by invoking
  wxvf_close() when running, ensuring DMA engines are stopped and
  NAPI/IRQs/rings are cleanly freed before clearing PCI state.
- Replace manual resource allocation in wxvf_resume() with deferred
  reopening via WX_FLAG_NEED_REOPEN, scheduling wxvf_reopen_subtask() to
  run full wxvf_open() sequence under rtnl_lock().
- Move timer/work synchronization after rtnl_lock() release in
  wxvf_suspend() to prevent service tasks from re-arming the timer.
- Add error unwinding in wxvf_reopen_subtask() to set WX_STATE_DOWN,
  clear bus mastering, and log errors if reopen fails.
- Skip wxvf_link_config_subtask() when WX_STATE_DOWN is set to prevent
  link updates on downed interfaces.
v2: https://lore.kernel.org/netdev/20260829091423.83097-1-mengyuanlou@net-swift.com/
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
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 57 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 2eba5ab59925..1b18b069decc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1288,6 +1288,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_MODULE_RESET,
 	WX_FLAG_NEED_UPDATE_LINK,
 	WX_FLAG_NEED_DO_RESET,
+	WX_FLAG_NEED_REOPEN,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PCIE_RECOVERY,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..3e55738e2096 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -16,9 +16,16 @@ int wxvf_suspend(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
 
+	rtnl_lock();
 	netif_device_detach(wx->netdev);
+	if (netif_running(wx->netdev))
+		wxvf_close(wx->netdev);
 	wx_clear_interrupt_scheme(wx);
+	pci_clear_master(pdev);
 	pci_disable_device(pdev);
+	rtnl_unlock();
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 
 	return 0;
 }
@@ -34,11 +41,25 @@ int wxvf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
 
-	pci_set_master(pdev);
-	wx_init_interrupt_scheme(wx);
-	netif_device_attach(wx->netdev);
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
 
+	rtnl_lock();
+	if (netif_running(wx->netdev)) {
+		clear_bit(WX_STATE_DOWN, wx->state);
+		clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+		mod_timer(&wx->service_timer, jiffies + HZ);
+		set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	} else {
+		pci_set_master(pdev);
+		netif_device_attach(wx->netdev);
+	}
+	rtnl_unlock();
 	return 0;
 }
 EXPORT_SYMBOL(wxvf_resume);
@@ -388,6 +409,9 @@ static void wxvf_link_config_subtask(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	if (test_bit(WX_STATE_DOWN, wx->state))
+		return;
+
 	wxvf_watchdog_update_link(wx);
 	if (wx->link) {
 		if (netif_carrier_ok(netdev))
@@ -403,10 +427,37 @@ static void wxvf_link_config_subtask(struct wx *wx)
 	}
 }
 
+static void wxvf_reopen_subtask(struct wx *wx)
+{
+	if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
+		return;
+
+	rtnl_lock();
+	pci_set_master(wx->pdev);
+	if (wx_init_interrupt_scheme(wx))
+		goto out;
+	if (wxvf_open(wx->netdev))
+		goto out_clear_scheme;
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	netif_device_attach(wx->netdev);
+	rtnl_unlock();
+	return;
+
+out_clear_scheme:
+	wx_clear_interrupt_scheme(wx);
+out:
+	pci_clear_master(wx->pdev);
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	set_bit(WX_STATE_DOWN, wx->state);
+	rtnl_unlock();
+	dev_err(&wx->pdev->dev, "Failed to reopen device\n");
+}
+
 static void wxvf_service_task(struct work_struct *work)
 {
 	struct wx *wx = container_of(work, struct wx, service_task);
 
+	wxvf_reopen_subtask(wx);
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
 	wx_service_event_complete(wx);
-- 
2.30.1

